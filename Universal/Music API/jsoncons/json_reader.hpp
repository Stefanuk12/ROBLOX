// Copyright 2015 Daniel Parker
// Distributed under the Boost license, Version 1.0.
// (See accompanying file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

// See https://github.com/danielaparker/jsoncons for latest version

#ifndef JSONCONS_JSON_READER_HPP
#define JSONCONS_JSON_READER_HPP

#include <memory> // std::allocator
#include <string>
#include <vector>
#include <stdexcept>
#include <system_error>
#include <ios>
#include <utility> // std::move
#include <jsoncons/source.hpp>
#include <jsoncons/json_exception.hpp>
#include <jsoncons/json_visitor.hpp>
#include <jsoncons/json_parser.hpp>

namespace jsoncons {

// utf8_other_json_input_adapter

template <class CharT>
class json_utf8_to_other_visitor_adaptor : public json_visitor
{
public:
    using json_visitor::string_view_type;
private:
    basic_default_json_visitor<CharT> default_visitor_;
    basic_json_visitor<CharT>& other_visitor_;
    //std::function<bool(json_errc,const ser_context&)> err_handler_;

    // noncopyable and nonmoveable
    json_utf8_to_other_visitor_adaptor<CharT>(const json_utf8_to_other_visitor_adaptor<CharT>&) = delete;
    json_utf8_to_other_visitor_adaptor<CharT>& operator=(const json_utf8_to_other_visitor_adaptor<CharT>&) = delete;

public:
    json_utf8_to_other_visitor_adaptor()
        : other_visitor_(default_visitor_)
    {
    }

    json_utf8_to_other_visitor_adaptor(basic_json_visitor<CharT>& other_visitor/*,
                                          std::function<bool(json_errc,const ser_context&)> err_handler*/)
        : other_visitor_(other_visitor)/*,
          err_handler_(err_handler)*/
    {
    }

private:

    void visit_flush() override
    {
        other_visitor_.flush();
    }

    bool visit_begin_object(semantic_tag tag, const ser_context& context, std::error_code& ec) override
    {
        return other_visitor_.begin_object(tag, context, ec);
    }

    bool visit_end_object(const ser_context& context, std::error_code& ec) override
    {
        return other_visitor_.end_object(context, ec);
    }

    bool visit_begin_array(semantic_tag tag, const ser_context& context, std::error_code& ec) override
    {
        return other_visitor_.begin_array(tag, context, ec);
    }

    bool visit_end_array(const ser_context& context, std::error_code& ec) override
    {
        return other_visitor_.end_array(context, ec);
    }

    bool visit_key(const string_view_type& name, const ser_context& context, std::error_code& ec) override
    {
        std::basic_string<CharT> target;
        auto result = unicons::convert(
            name.begin(), name.end(), std::back_inserter(target), 
            unicons::conv_flags::strict);
        if (result.ec != unicons::conv_errc())
        {
            JSONCONS_THROW(ser_error(result.ec,context.line(),context.column()));
        }
        return other_visitor_.key(target, context, ec);
    }

    bool visit_string(const string_view_type& value, semantic_tag tag, const ser_context& context, std::error_code& ec) override
    {
        std::basic_string<CharT> target;
        auto result = unicons::convert(
            value.begin(), value.end(), std::back_inserter(target), 
            unicons::conv_flags::strict);
        if (result.ec != unicons::conv_errc())
        {
            ec = result.ec;
            return false;
        }
        return other_visitor_.string_value(target, tag, context, ec);
    }

    bool visit_int64(int64_t value, 
                        semantic_tag tag, 
                        const ser_context& context,
                        std::error_code& ec) override
    {
        return other_visitor_.int64_value(value, tag, context, ec);
    }

    bool visit_uint64(uint64_t value, 
                         semantic_tag tag, 
                         const ser_context& context,
                         std::error_code& ec) override
    {
        return other_visitor_.uint64_value(value, tag, context, ec);
    }

    bool visit_half(uint16_t value, 
                       semantic_tag tag,
                       const ser_context& context,
                       std::error_code& ec) override
    {
        return other_visitor_.half_value(value, tag, context, ec);
    }

    bool visit_double(double value, 
                         semantic_tag tag,
                         const ser_context& context,
                         std::error_code& ec) override
    {
        return other_visitor_.double_value(value, tag, context, ec);
    }

    bool visit_bool(bool value, semantic_tag tag, const ser_context& context, std::error_code& ec) override
    {
        return other_visitor_.bool_value(value, tag, context, ec);
    }

    bool visit_null(semantic_tag tag, const ser_context& context, std::error_code& ec) override
    {
        return other_visitor_.null_value(tag, context, ec);
    }
};

template<class CharT,class Src=jsoncons::stream_source<CharT>,class Allocator=std::allocator<char>>
class basic_json_reader 
{
public:
    using char_type = CharT;
    using source_type = Src;
    using string_view_type = basic_string_view<CharT>;
    using temp_allocator_type = Allocator;
private:
    typedef typename std::allocator_traits<temp_allocator_type>:: template rebind_alloc<CharT> char_allocator_type;

    static constexpr size_t default_max_buffer_length = 16384;

    basic_default_json_visitor<CharT> default_visitor_;

    basic_json_visitor<CharT>& visitor_;

    basic_json_parser<CharT,Allocator> parser_;

    source_type source_;
    bool eof_;
    bool begin_;
    std::size_t buffer_length_;
    std::vector<CharT,char_allocator_type> buffer_;

    // Noncopyable and nonmoveable
    basic_json_reader(const basic_json_reader&) = delete;
    basic_json_reader& operator=(const basic_json_reader&) = delete;

public:
    template <class Source>
    explicit basic_json_reader(Source&& source, const Allocator& alloc = Allocator())
        : basic_json_reader(std::forward<Source>(source),
                            default_visitor_,
                            basic_json_decode_options<CharT>(),
                            default_json_parsing(),
                            alloc)
    {
    }

    template <class Source>
    basic_json_reader(Source&& source, 
                      const basic_json_decode_options<CharT>& options, 
                      const Allocator& alloc = Allocator())
        : basic_json_reader(std::forward<Source>(source),
                            default_visitor_,
                            options,
                            default_json_parsing(),
                            alloc)
    {
    }

    template <class Source>
    basic_json_reader(Source&& source,
                      std::function<bool(json_errc,const ser_context&)> err_handler, 
                      const Allocator& alloc = Allocator())
        : basic_json_reader(std::forward<Source>(source),
                            default_visitor_,
                            basic_json_decode_options<CharT>(),
                            err_handler,
                            alloc)
    {
    }

    template <class Source>
    basic_json_reader(Source&& source, 
                      const basic_json_decode_options<CharT>& options,
                      std::function<bool(json_errc,const ser_context&)> err_handler, 
                      const Allocator& alloc = Allocator())
        : basic_json_reader(std::forward<Source>(source),
                            default_visitor_,
                            options,
                            err_handler,
                            alloc)
    {
    }

    template <class Source>
    basic_json_reader(Source&& source, 
                      basic_json_visitor<CharT>& visitor, 
                      const Allocator& alloc = Allocator())
        : basic_json_reader(std::forward<Source>(source),
                            visitor,
                            basic_json_decode_options<CharT>(),
                            default_json_parsing(),
                            alloc)
    {
    }

    template <class Source>
    basic_json_reader(Source&& source, 
                      basic_json_visitor<CharT>& visitor,
                      const basic_json_decode_options<CharT>& options, 
                      const Allocator& alloc = Allocator())
        : basic_json_reader(std::forward<Source>(source),
                            visitor,
                            options,
                            default_json_parsing(),
                            alloc)
    {
    }

    template <class Source>
    basic_json_reader(Source&& source,
                      basic_json_visitor<CharT>& visitor,
                      std::function<bool(json_errc,const ser_context&)> err_handler, 
                      const Allocator& alloc = Allocator())
        : basic_json_reader(std::forward<Source>(source),
                            visitor,
                            basic_json_decode_options<CharT>(),
                            err_handler,
                            alloc)
    {
    }

    template <class Source>
    basic_json_reader(Source&& source,
                      basic_json_visitor<CharT>& visitor, 
                      const basic_json_decode_options<CharT>& options,
                      std::function<bool(json_errc,const ser_context&)> err_handler, 
                      const Allocator& alloc = Allocator(),
                      typename std::enable_if<!std::is_constructible<basic_string_view<CharT>,Source>::value>::type* = 0)
       : visitor_(visitor),
         parser_(options,err_handler,alloc),
         source_(std::forward<Source>(source)),
         eof_(false),
         begin_(true),
         buffer_length_(default_max_buffer_length),
         buffer_(alloc)
    {
        buffer_.reserve(buffer_length_);
    }

    template <class Source>
    basic_json_reader(Source&& source,
                      basic_json_visitor<CharT>& visitor, 
                      const basic_json_decode_options<CharT>& options,
                      std::function<bool(json_errc,const ser_context&)> err_handler, 
                      const Allocator& alloc = Allocator(),
                      typename std::enable_if<std::is_constructible<basic_string_view<CharT>,Source>::value>::type* = 0)
       : visitor_(visitor),
         parser_(options,err_handler,alloc),
         eof_(false),
         begin_(false),
         buffer_length_(0),
         buffer_(alloc)
    {
        basic_string_view<CharT> sv(std::forward<Source>(source));
        auto result = unicons::skip_bom(sv.begin(), sv.end());
        if (result.ec != unicons::encoding_errc())
        {
            JSONCONS_THROW(ser_error(result.ec,parser_.line(),parser_.column()));
        }
        std::size_t offset = result.it - sv.begin();
        parser_.update(sv.data()+offset,sv.size()-offset);
    }

    std::size_t buffer_length() const
    {
        return buffer_length_;
    }

    void buffer_length(std::size_t length)
    {
        buffer_length_ = length;
        buffer_.reserve(buffer_length_);
    }
#if !defined(JSONCONS_NO_DEPRECATED)
    JSONCONS_DEPRECATED_MSG("Instead, use max_nesting_depth() on options")
    int max_nesting_depth() const
    {
        return parser_.max_nesting_depth();
    }

    JSONCONS_DEPRECATED_MSG("Instead, use max_nesting_depth(int) on options")
    void max_nesting_depth(int depth)
    {
        parser_.max_nesting_depth(depth);
    }
#endif
    void read_next()
    {
        std::error_code ec;
        read_next(ec);
        if (ec)
        {
            JSONCONS_THROW(ser_error(ec,parser_.line(),parser_.column()));
        }
    }

    void read_next(std::error_code& ec)
    {
        if (source_.is_error())
        {
            ec = json_errc::source_error;
            return;
        }        
        parser_.reset();
        while (!parser_.finished())
        {
            if (parser_.source_exhausted())
            {
                if (!source_.eof())
                {
                    read_buffer(ec);
                    if (ec) return;
                }
                else
                {
                    eof_ = true;
                }
            }
            parser_.parse_some(visitor_, ec);
            if (ec) return;
        }
        
        while (!eof_)
        {
            parser_.skip_whitespace();
            if (parser_.source_exhausted())
            {
                if (!source_.eof())
                {
                    read_buffer(ec);
                    if (ec) return;
                }
                else
                {
                    eof_ = true;
                }
            }
            else
            {
                break;
            }
        }
    }

    void check_done()
    {
        std::error_code ec;
        check_done(ec);
        if (ec)
        {
            JSONCONS_THROW(ser_error(ec,parser_.line(),parser_.column()));
        }
    }

    std::size_t line() const
    {
        return parser_.line();
    }

    std::size_t column() const
    {
        return parser_.column();
    }

    void check_done(std::error_code& ec)
    {
        if (source_.is_error())
        {
            ec = json_errc::source_error;
            return;
        }   
        if (eof_)
        {
            parser_.check_done(ec);
            if (ec) return;
        }
        else
        {
            while (!eof_)
            {
                if (parser_.source_exhausted())
                {
                    if (!source_.eof())
                    {
                        read_buffer(ec);     
                        if (ec) return;
                    }
                    else
                    {
                        eof_ = true;
                    }
                }
                if (!eof_)
                {
                    parser_.check_done(ec);
                    if (ec) return;
                }
            }
        }
    }

    bool eof() const
    {
        return eof_;
    }

    void read()
    {
        read_next();
        check_done();
    }

    void read(std::error_code& ec)
    {
        read_next(ec);
        if (!ec)
        {
            check_done(ec);
        }
    }

#if !defined(JSONCONS_NO_DEPRECATED)

    JSONCONS_DEPRECATED_MSG("Instead, use buffer_length()")
    std::size_t buffer_capacity() const
    {
        return buffer_length_;
    }

    JSONCONS_DEPRECATED_MSG("Instead, use buffer_length(std::size_t)")
    void buffer_capacity(std::size_t length)
    {
        buffer_length_ = length;
        buffer_.reserve(buffer_length_);
    }
#endif

private:

    void read_buffer(std::error_code& ec)
    {
        buffer_.clear();
        buffer_.resize(buffer_length_);
        std::size_t count = source_.read(buffer_.data(), buffer_length_);
        buffer_.resize(static_cast<std::size_t>(count));
        if (buffer_.size() == 0)
        {
            eof_ = true;
        }
        else if (begin_)
        {
            auto result = unicons::skip_bom(buffer_.begin(), buffer_.end());
            if (result.ec != unicons::encoding_errc())
            {
                ec = result.ec;
                return;
            }
            std::size_t offset = result.it - buffer_.begin();
            parser_.update(buffer_.data()+offset,buffer_.size()-offset);
            begin_ = false;
        }
        else
        {
            parser_.update(buffer_.data(),buffer_.size());
        }
    }
};

using json_reader = basic_json_reader<char>;
using wjson_reader = basic_json_reader<wchar_t>;

#if !defined(JSONCONS_NO_DEPRECATED)
JSONCONS_DEPRECATED_MSG("Instead, use json_reader") typedef json_reader json_string_reader;
JSONCONS_DEPRECATED_MSG("Instead, use wjson_reader") typedef wjson_reader wjson_string_reader;
#endif

}

#endif

