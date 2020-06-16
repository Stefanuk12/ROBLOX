// Copyright 2018 Daniel Parker
// Distributed under the Boost license, Version 1.0.
// (See accompanying file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

// See https://github.com/danielaparker/jsoncons for latest version

#ifndef JSONCONS_SOURCE_HPP
#define JSONCONS_SOURCE_HPP

#include <stdexcept>
#include <string>
#include <vector>
#include <istream>
#include <memory> // std::addressof
#include <cstring> // std::memcpy
#include <exception>
#include <type_traits> // std::enable_if
#include <jsoncons/config/jsoncons_config.hpp>
#include <jsoncons/byte_string.hpp> // jsoncons::byte_traits
#include <jsoncons/detail/more_type_traits.hpp>

namespace jsoncons { 

    template <class CharT>
    class basic_null_istream : public std::basic_istream<CharT>
    {
        class null_buffer : public std::basic_streambuf<CharT>
        {
        public:
            using typename std::basic_streambuf<CharT>::int_type;
            using typename std::basic_streambuf<CharT>::traits_type;

            null_buffer() = default;
            null_buffer(const null_buffer&) = default;
            null_buffer& operator=(const null_buffer&) = default;

            int_type overflow( int_type ch = traits_type::eof() ) override
            {
                return ch;
            }
        } nb_;
    public:
        basic_null_istream()
          : std::basic_istream<CharT>(&nb_)
        {
        }
        basic_null_istream(basic_null_istream&&) = default;

        basic_null_istream& operator=(basic_null_istream&&) = default;
    };

    template <class CharT>
    class character_result
    {
        CharT value_;
        bool eof_;
    public:
        using value_type = CharT;

        constexpr character_result()
            : value_(0), eof_(true)
        {
        }

        constexpr character_result(CharT value)
            : value_(value), eof_(false)
        {
        }

        constexpr explicit operator bool() const noexcept
        {
            return !eof_;
        }

        constexpr value_type value() const
        {
            return value_;
        }

        constexpr bool eof() const
        {
            return eof_;
        }
    };

    // text sources

    template <class CharT>
    class stream_source 
    {
    public:
        using value_type = CharT;
    private:
        using traits_type = std::char_traits<CharT>;
        using int_type = typename traits_type::int_type;

        basic_null_istream<CharT> null_is_;
        std::basic_istream<CharT>* stream_ptr_;
        std::basic_streambuf<CharT>* sbuf_;
        std::size_t position_;

        // Noncopyable 
        stream_source(const stream_source&) = delete;
        stream_source& operator=(const stream_source&) = delete;
    public:
        stream_source()
            : stream_ptr_(&null_is_), sbuf_(null_is_.rdbuf()), position_(0)
        {
        }

        stream_source(std::basic_istream<CharT>& is)
            : stream_ptr_(std::addressof(is)), sbuf_(is.rdbuf()), position_(0)
        {
        }

        stream_source(stream_source&& other) noexcept
        {
            std::swap(stream_ptr_,other.stream_ptr_);
            std::swap(sbuf_,other.sbuf_);
            std::swap(position_,other.position_);
        }

        ~stream_source() noexcept = default;

        stream_source& operator=(stream_source&& other) noexcept
        {
            std::swap(stream_ptr_,other.stream_ptr_);
            std::swap(sbuf_,other.sbuf_);
            std::swap(position_,other.position_);
            return *this;
        }

        bool eof() const
        {
            return stream_ptr_->eof();  
        }

        bool is_error() const
        {
            return stream_ptr_->bad();  
        }

        std::size_t position() const
        {
            return position_;
        }

        character_result<value_type> get_character()
        {
            JSONCONS_TRY
            {
                int_type c = sbuf_->sbumpc();
                if (c == traits_type::eof())
                {
                    stream_ptr_->clear(stream_ptr_->rdstate() | std::ios::eofbit);
                    return character_result<value_type>();
                }
                ++position_;
                return character_result<value_type>(static_cast<value_type>(c));
            }
            JSONCONS_CATCH(const std::exception&)     
            {
                stream_ptr_->clear(stream_ptr_->rdstate() | std::ios::badbit | std::ios::eofbit);
                return character_result<value_type>();
            }
        }

        void ignore(std::size_t count)
        {
            JSONCONS_TRY
            {
                for (std::size_t i = 0; i < count; ++i)
                {
                    int_type c = sbuf_->sbumpc();
                    if (c == traits_type::eof())
                    {
                        stream_ptr_->clear(stream_ptr_->rdstate() | std::ios::eofbit);
                        return;
                    }
                    else
                    {
                        ++position_;
                    }
                }
            }
            JSONCONS_CATCH(const std::exception&)     
            {
                stream_ptr_->clear(stream_ptr_->rdstate() | std::ios::badbit | std::ios::eofbit);
            }
        }

        character_result<value_type> peek_character() 
        {
            JSONCONS_TRY
            {
                int_type c = sbuf_->sgetc();
                if (c == traits_type::eof())
                {
                    stream_ptr_->clear(stream_ptr_->rdstate() | std::ios::eofbit);
                    return character_result<value_type>();
                }
                return character_result<value_type>(static_cast<value_type>(c));
            }
            JSONCONS_CATCH(const std::exception&)     
            {
                stream_ptr_->clear(stream_ptr_->rdstate() | std::ios::badbit);
                return character_result<value_type>();
            }
        }

        std::size_t read(value_type* p, std::size_t length)
        {
            JSONCONS_TRY
            {
                std::streamsize count = sbuf_->sgetn(p, length); // never negative
                if (static_cast<std::size_t>(count) < length)
                {
                    stream_ptr_->clear(stream_ptr_->rdstate() | std::ios::eofbit);
                }
                position_ += length;
                return static_cast<std::size_t>(count);
            }
            JSONCONS_CATCH(const std::exception&)     
            {
                stream_ptr_->clear(stream_ptr_->rdstate() | std::ios::badbit | std::ios::eofbit);
                return 0;
            }
        }
    };

    // string_source

    template <class CharT, class T, class Enable=void>
    struct is_string_sourceable : std::false_type {};

    template <class CharT, class T>
    struct is_string_sourceable<CharT,T,typename std::enable_if<std::is_same<typename T::value_type, CharT>::value>::type> : std::true_type {};

    template <class CharT>
    class string_source 
    {
    public:
        using value_type = CharT;
        using string_view_type = basic_string_view<value_type>;
    private:
        const value_type* data_;
        const value_type* current_;
        const value_type* end_;

        // Noncopyable 
        string_source(const string_source&) = delete;
        string_source& operator=(const string_source&) = delete;
    public:
        string_source()
            : data_(nullptr), current_(nullptr), end_(nullptr)
        {
        }

        template <class Source>
        string_source(const Source& s,
                      typename std::enable_if<is_string_sourceable<value_type,typename std::decay<Source>::type>::value>::type* = 0)
            : data_(s.data()), current_(s.data()), end_(s.data()+s.size())
        {
        }

        string_source(const value_type* data, std::size_t size)
            : data_(data), current_(data), end_(data+size)
        {
        }

        string_source(string_source&& val) 
            : data_(nullptr), current_(nullptr), end_(nullptr)
        {
            std::swap(data_,val.data_);
            std::swap(current_,val.current_);
            std::swap(end_,val.end_);
        }

        string_source& operator=(string_source&& val)
        {
            std::swap(data_,val.data_);
            std::swap(current_,val.current_);
            std::swap(end_,val.end_);
            return *this;
        }

        bool eof() const
        {
            return current_ == end_;  
        }

        bool is_error() const
        {
            return false;  
        }

        std::size_t position() const
        {
            return (current_ - data_)/sizeof(value_type) + 1;
        }

        character_result<value_type> get_character()
        {
            if (current_ < end_)
            {
                return character_result<value_type>(*current_++);
            }
            else
           {
                return character_result<value_type>();
            }
        }

        void ignore(std::size_t count)
        {
            std::size_t len;
            if ((std::size_t)(end_ - current_) < count)
            {
                len = end_ - current_;
            }
            else
            {
                len = count;
            }
            current_ += len;
        }

        character_result<value_type> peek_character() 
        {
            return current_ < end_ ? character_result<value_type>(*current_) : character_result<value_type>();
        }

        std::size_t read(value_type* p, std::size_t length)
        {
            std::size_t len;
            if ((std::size_t)(end_ - current_) < length)
            {
                len = end_ - current_;
            }
            else
            {
                len = length;
            }
            std::memcpy(p, current_, len*sizeof(value_type));
            current_  += len;
            return len;
        }
    };

    // iterator source

    template <class IteratorT>
    class iterator_source
    {
        IteratorT current_;
        IteratorT end_;
        std::size_t position_;
    public:
        using value_type = typename std::iterator_traits<IteratorT>::value_type;

        iterator_source(const IteratorT& first, const IteratorT& last)
            : current_(first), end_(last), position_(0)
        {
        }

        bool eof() const
        {
            return !(current_ != end_);  
        }

        bool is_error() const
        {
            return false;  
        }

        std::size_t position() const
        {
            return position_;
        }

        character_result<value_type> get_character()
        {
            if (current_ != end_)
            {
                ++position_;
                return character_result<value_type>(*current_++);
            }
            else
           {
                return character_result<value_type>();
            }
        }

        void ignore(std::size_t count)
        {
            while (count-- > 0 && current_ != end_)
            {
                ++position_;
                ++current_;
            }
        }

        character_result<value_type> peek_character() 
        {
            return current_ != end_ ? character_result<value_type>(*current_) : character_result<value_type>();
        }

        std::size_t read(value_type* data, std::size_t length)
        {
            value_type* p = data;
            value_type* pend = data + length;

            while (p < pend && current_ != end_)
            {
                *p = *current_;
                ++p;
                ++current_;
            }

            position_ += (p - data);

            return p - data;
        }
    };

    // binary sources

    class binary_stream_source 
    {
    public:
        typedef uint8_t value_type;
    private:
        using traits_type = byte_traits;
        basic_null_istream<char> null_is_;
        std::istream* stream_ptr_;
        std::streambuf* sbuf_;
        std::size_t position_;

        // Noncopyable 
        binary_stream_source(const binary_stream_source&) = delete;
        binary_stream_source& operator=(const binary_stream_source&) = delete;
    public:
        binary_stream_source()
            : stream_ptr_(&null_is_), sbuf_(null_is_.rdbuf()), position_(0)
        {
        }

        binary_stream_source(std::istream& is)
            : stream_ptr_(std::addressof(is)), sbuf_(is.rdbuf()), position_(0)
        {
        }

        binary_stream_source(binary_stream_source&& other) noexcept
        {
            std::swap(stream_ptr_,other.stream_ptr_);
            std::swap(sbuf_,other.sbuf_);
            std::swap(position_,other.position_);
        }

        ~binary_stream_source()
        {
        }

        binary_stream_source& operator=(binary_stream_source&& other) noexcept
        {
            std::swap(stream_ptr_,other.stream_ptr_);
            std::swap(sbuf_,other.sbuf_);
            std::swap(position_,other.position_);
            return *this;
        }

        bool eof() const
        {
            return stream_ptr_->eof();  
        }

        bool is_error() const
        {
            return stream_ptr_->bad();  
        }

        std::size_t position() const
        {
            return position_;
        }

        character_result<value_type> get_character()
        {
            JSONCONS_TRY
            {
                int c = sbuf_->sbumpc();
                if (c == traits_type::eof())
                {
                    stream_ptr_->clear(stream_ptr_->rdstate() | std::ios::eofbit);
                    return character_result<value_type>();
                }
                ++position_;
                return character_result<value_type>(static_cast<value_type>(c));
            }
            JSONCONS_CATCH(const std::exception&)     
            {
                stream_ptr_->clear(stream_ptr_->rdstate() | std::ios::badbit | std::ios::eofbit);
                return character_result<value_type>();
            }
        }

        void ignore(std::size_t count)
        {
            JSONCONS_TRY
            {
                for (std::size_t i = 0; i < count; ++i)
                {
                    int c = sbuf_->sbumpc();
                    if (c == traits_type::eof())
                    {
                        stream_ptr_->clear(stream_ptr_->rdstate() | std::ios::eofbit);
                        return;
                    }
                    else
                    {
                        ++position_;
                    }
                }
            }
            JSONCONS_CATCH(const std::exception&)     
            {
                stream_ptr_->clear(stream_ptr_->rdstate() | std::ios::badbit | std::ios::eofbit);
            }
        }

        character_result<value_type> peek_character() 
        {
            JSONCONS_TRY
            {
                int c = sbuf_->sgetc();
                if (c == traits_type::eof())
                {
                    stream_ptr_->clear(stream_ptr_->rdstate() | std::ios::eofbit);
                    return character_result<value_type>();
                }
                return character_result<value_type>(static_cast<value_type>(c));
            }
            JSONCONS_CATCH(const std::exception&)     
            {
                stream_ptr_->clear(stream_ptr_->rdstate() | std::ios::badbit);
                return character_result<value_type>();
            }
        }

        std::size_t read(value_type* p, std::size_t length)
        {
            JSONCONS_TRY
            {
                std::streamsize count = sbuf_->sgetn(reinterpret_cast<char*>(p), length); // never negative
                if (static_cast<std::size_t>(count) < length)
                {
                    stream_ptr_->clear(stream_ptr_->rdstate() | std::ios::eofbit);
                }
                position_ += length;
                return static_cast<std::size_t>(count);
            }
            JSONCONS_CATCH(const std::exception&)     
            {
                stream_ptr_->clear(stream_ptr_->rdstate() | std::ios::badbit | std::ios::eofbit);
                return 0;
            }
        }
    };

    class bytes_source 
    {
    public:
        typedef uint8_t value_type;
    private:
        const value_type* data_;
        const value_type* current_;
        const value_type* end_;

        // Noncopyable 
        bytes_source(const bytes_source&) = delete;
        bytes_source& operator=(const bytes_source&) = delete;
    public:
        bytes_source()
            : data_(nullptr), current_(nullptr), end_(nullptr)
        {
        }

        template <class Source>
        bytes_source(const Source& source,
                     typename std::enable_if<jsoncons::detail::is_byte_sequence<Source>::value,int>::type = 0)
            : data_(reinterpret_cast<const uint8_t*>(source.data())), 
              current_(data_), 
              end_(data_+source.size())
        {
        }

        bytes_source(bytes_source&&) = default;

        bytes_source& operator=(bytes_source&&) = default;

        bool eof() const
        {
            return current_ == end_;  
        }

        bool is_error() const
        {
            return false;  
        }

        std::size_t position() const
        {
            return current_ - data_ + 1;
        }

        character_result<value_type> get_character()
        {
            if (current_ < end_)
            {
                return character_result<value_type>(*current_++);
            }
            else
            {
                return character_result<value_type>();
            }
        }

        void ignore(std::size_t count)
        {
            std::size_t len;
            if ((std::size_t)(end_ - current_) < count)
            {
                len = end_ - current_;
            }
            else
            {
                len = count;
            }
            current_ += len;
        }

        character_result<value_type> peek_character() 
        {
            return current_ < end_ ? character_result<value_type>(*current_) : character_result<value_type>();
        }

        std::size_t read(value_type* p, std::size_t length)
        {
            std::size_t len;
            if ((std::size_t)(end_ - current_) < length)
            {
                len = end_ - current_;
            }
            else
            {
                len = length;
            }
            std::memcpy(p, current_, len);
            current_  += len;
            return len;
        }
    };

    // binary_iterator source

    template <class IteratorT>
    class binary_iterator_source
    {
        IteratorT current_;
        IteratorT end_;
        std::size_t position_;
    public:
        using value_type = uint8_t;

        binary_iterator_source(const IteratorT& first, const IteratorT& last)
            : current_(first), end_(last), position_(0)
        {
        }

        bool eof() const
        {
            return !(current_ != end_);  
        }

        bool is_error() const
        {
            return false;  
        }

        std::size_t position() const
        {
            return position_;
        }

        character_result<value_type> get_character()
        {
            if (current_ != end_)
            {
                ++position_;
                return character_result<value_type>(*current_++);
            }
            else
            {
                return character_result<value_type>();
            }
        }

        void ignore(std::size_t count)
        {
            while (count-- > 0 && current_ != end_)
            {
                ++position_;
                ++current_;
            }
        }

        character_result<value_type> peek_character() 
        {
            return current_ != end_ ? character_result<value_type>(static_cast<value_type>(*current_)) : character_result<value_type>();
        }

        std::size_t read(value_type* data, std::size_t length)
        {
            value_type* p = data;
            value_type* pend = data + length;

            while (p < pend && current_ != end_)
            {
                *p = static_cast<value_type>(*current_);
                ++p;
                ++current_;
            }

            position_ += (p - data);

            return p - data;
        }
    };

    template <class Source>
    struct source_reader
    {
        using value_type = typename Source::value_type;
        static constexpr std::size_t max_buffer_length = 16384;

        template <class Container>
        static
        typename std::enable_if<std::is_convertible<value_type,typename Container::value_type>::value &&
                                jsoncons::detail::has_reserve<Container>::value &&
                                jsoncons::detail::has_data_exact<value_type*,Container>::value 
            , std::size_t>::type
        read(Source& source, Container& v, std::size_t length)
        {
            std::size_t unread = length;

            std::size_t n = (std::min)(max_buffer_length, unread);
            while (n > 0 && !source.eof())
            {
                std::size_t offset = v.size();
                v.resize(v.size()+n);
                std::size_t actual = source.read(v.data()+offset, n);
                unread -= actual;
                n = (std::min)(max_buffer_length, unread);
            }

            return length - unread;
        }

        template <class Container>
        static
        typename std::enable_if<std::is_convertible<value_type,typename Container::value_type>::value &&
                                jsoncons::detail::has_reserve<Container>::value &&
                                !detail::has_data_exact<value_type*, Container>::value 
            , std::size_t>::type
        read(Source& source, Container& v, std::size_t length)
        {
            std::size_t unread = length;

            std::size_t n = (std::min)(max_buffer_length, unread);
            while (n > 0 && !source.eof())
            {
                v.reserve(v.size()+n);
                std::size_t actual = 0;
                while (actual < n)
                {
                    auto c = source.get_character();
                    if (!c)
                    {
                        break;
                    }
                    v.push_back(c.value());
                    ++actual;
                }
                unread -= actual;
                n = (std::min)(max_buffer_length, unread);
            }

            return length - unread;
        }
    };
    template <class Source>
    constexpr std::size_t source_reader<Source>::max_buffer_length;

    #if !defined(JSONCONS_NO_DEPRECATED)
    using bin_stream_source = binary_stream_source;
    #endif

} // namespace jsoncons

#endif
