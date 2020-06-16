// Copyright 2015 Daniel Parker
// Distributed under the Boost license, Version 1.0.
// (See accompanying file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

// See https://github.com/danielaparker/jsoncons for latest version

#ifndef JSONCONS_JSON_PARSER_HPP
#define JSONCONS_JSON_PARSER_HPP

#include <memory> // std::allocator
#include <string>
#include <vector>
#include <stdexcept>
#include <system_error>
#include <unordered_map>
#include <limits> // std::numeric_limits
#include <functional> // std::function
#include <jsoncons/json_exception.hpp>
#include <jsoncons/json_filter.hpp>
#include <jsoncons/json_options.hpp>
#include <jsoncons/json_visitor.hpp>
#include <jsoncons/json_error.hpp>
#include <jsoncons/detail/parse_number.hpp>

#define JSONCONS_ILLEGAL_CONTROL_CHARACTER \
        case 0x00:case 0x01:case 0x02:case 0x03:case 0x04:case 0x05:case 0x06:case 0x07:case 0x08:case 0x0b: \
        case 0x0c:case 0x0e:case 0x0f:case 0x10:case 0x11:case 0x12:case 0x13:case 0x14:case 0x15:case 0x16: \
        case 0x17:case 0x18:case 0x19:case 0x1a:case 0x1b:case 0x1c:case 0x1d:case 0x1e:case 0x1f 

namespace jsoncons {

namespace detail {

}

enum class json_parse_state : uint8_t 
{
    root,
    start, 
    before_done, 
    slash,  
    slash_slash, 
    slash_star, 
    slash_star_star,
    expect_comma_or_end,  
    object,
    expect_member_name_or_end, 
    expect_member_name, 
    expect_colon,
    expect_value_or_end,
    expect_value,
    array, 
    string,
    member_name,
    escape, 
    escape_u1, 
    escape_u2, 
    escape_u3, 
    escape_u4, 
    escape_expect_surrogate_pair1, 
    escape_expect_surrogate_pair2, 
    escape_u6, 
    escape_u7, 
    escape_u8, 
    escape_u9, 
    minus, 
    zero,  
    integer,
    fraction1,
    fraction2,
    exp1,
    exp2,
    exp3,
    n,
    nu,
    nul,
    t,  
    tr,  
    tru,  
    f,  
    fa,  
    fal,  
    fals,  
    cr,
    done
};

struct default_json_parsing
{
    bool operator()(json_errc ec, const ser_context&) noexcept 
    {
        if (ec == json_errc::illegal_comment)
        {
            return true; // Recover, allow comments
        }
        else
        {
            return false;
        }
    }
};

struct strict_json_parsing
{
    bool operator()(json_errc, const ser_context&) noexcept
    {
        return false;
    }
};

#if !defined(JSONCONS_NO_DEPRECATED)
JSONCONS_DEPRECATED_MSG("Instead, use default_json_parsing") typedef default_json_parsing default_parse_error_handler;
JSONCONS_DEPRECATED_MSG("Instead, use strict_json_parsing") typedef strict_json_parsing strict_parse_error_handler;
#endif

template <class CharT, class TempAllocator = std::allocator<char>>
class basic_json_parser : public ser_context
{
public:
    using char_type = CharT;
    using string_view_type = typename basic_json_visitor<CharT>::string_view_type;
private:
    struct string_maps_to_double
    {
        string_view_type s;

        bool operator()(const std::pair<string_view_type,double>& val) const
        {
            return val.first == s;
        }
    };

    using temp_allocator_type = TempAllocator;
    using char_allocator_type = typename std::allocator_traits<temp_allocator_type>:: template rebind_alloc<CharT>;
    using parse_state_allocator_type = typename std::allocator_traits<temp_allocator_type>:: template rebind_alloc<json_parse_state>;

    static constexpr size_t initial_string_buffer_capacity_ = 1024;
    static constexpr int default_initial_stack_capacity_ = 100;

    basic_json_decode_options<CharT> options_;

    std::function<bool(json_errc,const ser_context&)> err_handler_;
    int initial_stack_capacity_;
    int nesting_depth_;
    uint32_t cp_;
    uint32_t cp2_;
    std::size_t line_;
    std::size_t column_;
    const CharT* begin_input_;
    const CharT* input_end_;
    const CharT* input_ptr_;
    json_parse_state state_;
    bool more_;
    bool done_;

    std::basic_string<CharT,std::char_traits<CharT>,char_allocator_type> string_buffer_;
    jsoncons::detail::to_double_t to_double_;

    std::vector<json_parse_state,parse_state_allocator_type> state_stack_;
    std::vector<std::pair<string_view_type,double>> string_double_map_;

    // Noncopyable and nonmoveable
    basic_json_parser(const basic_json_parser&) = delete;
    basic_json_parser& operator=(const basic_json_parser&) = delete;

public:
    basic_json_parser(const TempAllocator& alloc = TempAllocator())
        : basic_json_parser(basic_json_decode_options<CharT>(), default_json_parsing(), alloc)
    {
    }

    basic_json_parser(std::function<bool(json_errc,const ser_context&)> err_handler, 
                      const TempAllocator& alloc = TempAllocator())
        : basic_json_parser(basic_json_decode_options<CharT>(), err_handler, alloc)
    {
    }

    basic_json_parser(const basic_json_decode_options<CharT>& options, 
                      const TempAllocator& alloc = TempAllocator())
        : basic_json_parser(options, default_json_parsing(), alloc)
    {
    }

    basic_json_parser(const basic_json_decode_options<CharT>& options,
                      std::function<bool(json_errc,const ser_context&)> err_handler, 
                      const TempAllocator& alloc = TempAllocator())
       : options_(options),
         err_handler_(err_handler),
         initial_stack_capacity_(default_initial_stack_capacity_),
         nesting_depth_(0), 
         cp_(0),
         cp2_(0),
         line_(1),
         column_(1),
         begin_input_(nullptr),
         input_end_(nullptr),
         input_ptr_(nullptr),
         state_(json_parse_state::start),
         more_(true),
         done_(false),
         string_buffer_(alloc),
         state_stack_(alloc)
    {
        string_buffer_.reserve(initial_string_buffer_capacity_);

        state_stack_.reserve(initial_stack_capacity_);
        push_state(json_parse_state::root);

        if (options_.enable_str_to_nan())
        {
            string_double_map_.emplace_back(options_.nan_to_str(),std::nan(""));
        }
        if (options_.enable_str_to_inf())
        {
            string_double_map_.emplace_back(options_.inf_to_str(),std::numeric_limits<double>::infinity());
        }
        if (options_.enable_str_to_neginf())
        {
            string_double_map_.emplace_back(options_.neginf_to_str(),-std::numeric_limits<double>::infinity());
        }
    }

    bool source_exhausted() const
    {
        return input_ptr_ == input_end_;
    }

    ~basic_json_parser() noexcept
    {
    }

    json_parse_state parent() const
    {
        JSONCONS_ASSERT(state_stack_.size() >= 1);
        return state_stack_.back();
    }

    bool done() const
    {
        return done_;
    }

    bool stopped() const
    {
        return !more_;
    }

    bool finished() const
    {
        return !more_ && state_ != json_parse_state::before_done;
    }

    void skip_space()
    {
        const CharT* local_input_end = input_end_;
        while (input_ptr_ != local_input_end) 
        {
            switch (*input_ptr_)
            {
                case ' ':
                case '\t':
                    ++input_ptr_;
                    ++column_;                     
                    break;
                case '\r': 
                    push_state(state_);
                    ++input_ptr_;
                    ++column_;
                    state_ = json_parse_state::cr;
                    return; 
                case '\n': 
                    ++input_ptr_;
                    ++line_;
                    column_ = 1;
                    return;   
                default:
                    return;
            }
        }
    }

    void skip_whitespace()
    {
        const CharT* local_input_end = input_end_;

        while (input_ptr_ != local_input_end) 
        {
            switch (state_)
            {
                case json_parse_state::cr:
                    ++line_;
                    column_ = 1;
                    switch (*input_ptr_)
                    {
                        case '\n':
                            ++input_ptr_;
                            state_ = pop_state();
                            break;
                        default:
                            state_ = pop_state();
                            break;
                    }
                    break;

                default:
                    switch (*input_ptr_)
                    {
                        case ' ':
                        case '\t':
                        case '\n':
                        case '\r':
                            skip_space();
                            break;
                        default:
                            return;
                    }
                    break;
            }
        }
    }

    void begin_object(basic_json_visitor<CharT>& visitor, std::error_code& ec)
    {
        if (JSONCONS_UNLIKELY(++nesting_depth_ > options_.max_nesting_depth()))
        {
            more_ = err_handler_(json_errc::max_nesting_depth_exceeded, *this);
            if (!more_)
            {
                ec = json_errc::max_nesting_depth_exceeded;
                return;
            }
        } 
        push_state(json_parse_state::object);
        state_ = json_parse_state::expect_member_name_or_end;
        more_ = visitor.begin_object(semantic_tag::none, *this, ec);
    }

    void end_object(basic_json_visitor<CharT>& visitor, std::error_code& ec)
    {
        if (JSONCONS_UNLIKELY(nesting_depth_ < 1))
        {
            err_handler_(json_errc::unexpected_right_brace, *this);
            ec = json_errc::unexpected_right_brace;
            more_ = false;
            return;
        }
        --nesting_depth_;
        state_ = pop_state();
        if (state_ == json_parse_state::object)
        {
            more_ = visitor.end_object(*this, ec);
        }
        else if (state_ == json_parse_state::array)
        {
            err_handler_(json_errc::expected_comma_or_right_bracket, *this);
            ec = json_errc::expected_comma_or_right_bracket;
            more_ = false;
            return;
        }
        else
        {
            err_handler_(json_errc::unexpected_right_brace, *this);
            ec = json_errc::unexpected_right_brace;
            more_ = false;
            return;
        }

        if (parent() == json_parse_state::root)
        {
            state_ = json_parse_state::before_done;
        }
        else
        {
            state_ = json_parse_state::expect_comma_or_end;
        }
    }

    void begin_array(basic_json_visitor<CharT>& visitor, std::error_code& ec)
    {
        if (++nesting_depth_ > options_.max_nesting_depth())
        {
            more_ = err_handler_(json_errc::max_nesting_depth_exceeded, *this);
            if (!more_)
            {
                ec = json_errc::max_nesting_depth_exceeded;
                return;
            }
        }
        push_state(json_parse_state::array);
        state_ = json_parse_state::expect_value_or_end;
        more_ = visitor.begin_array(semantic_tag::none, *this, ec);
    }

    void end_array(basic_json_visitor<CharT>& visitor, std::error_code& ec)
    {
        if (nesting_depth_ < 1)
        {
            err_handler_(json_errc::unexpected_right_bracket, *this);
            ec = json_errc::unexpected_right_bracket;
            more_ = false;
            return;
        }
        --nesting_depth_;
        state_ = pop_state();
        if (state_ == json_parse_state::array)
        {
            more_ = visitor.end_array(*this, ec);
        }
        else if (state_ == json_parse_state::object)
        {
            err_handler_(json_errc::expected_comma_or_right_brace, *this);
            ec = json_errc::expected_comma_or_right_brace;
            more_ = false;
            return;
        }
        else
        {
            err_handler_(json_errc::unexpected_right_bracket, *this);
            ec = json_errc::unexpected_right_bracket;
            more_ = false;
            return;
        }
        if (parent() == json_parse_state::root)
        {
            state_ = json_parse_state::before_done;
        }
        else
        {
            state_ = json_parse_state::expect_comma_or_end;
        }
    }

    void reset()
    {
        state_stack_.clear();
        state_stack_.reserve(initial_stack_capacity_);
        push_state(json_parse_state::root);
        state_ = json_parse_state::start;
        more_ = true;
        done_ = false;
        line_ = 1;
        column_ = 1;
        nesting_depth_ = 0;
    }

    void restart()
    {
        more_ = true;
    }

    void check_done()
    {
        std::error_code ec;
        check_done(ec);
        if (ec)
        {
            JSONCONS_THROW(ser_error(ec,line_,column_));
        }
    }

    void check_done(std::error_code& ec)
    {
        for (; input_ptr_ != input_end_; ++input_ptr_)
        {
            CharT curr_char_ = *input_ptr_;
            switch (curr_char_)
            {
                case '\n':
                case '\r':
                case '\t':
                case ' ':
                    break;
                default:
                    more_ = err_handler_(json_errc::extra_character, *this);
                    if (!more_)
                    {
                        ec = json_errc::extra_character;
                        return;
                    }
                    break;
            }
        }
    }

    json_parse_state state() const
    {
        return state_;
    }

    void update(const string_view_type sv)
    {
        update(sv.data(),sv.length());
    }

    void update(const CharT* data, std::size_t length)
    {
        begin_input_ = data;
        input_end_ = data + length;
        input_ptr_ = begin_input_;
    }

    void parse_some(basic_json_visitor<CharT>& visitor)
    {
        std::error_code ec;
        parse_some(visitor, ec);
        if (ec)
        {
            JSONCONS_THROW(ser_error(ec,line_,column_));
        }
    }

    void parse_some(basic_json_visitor<CharT>& visitor, std::error_code& ec)
    {
        parse_some_(visitor, ec);
    }

    void finish_parse(basic_json_visitor<CharT>& visitor)
    {
        std::error_code ec;
        finish_parse(visitor, ec);
        if (ec)
        {
            JSONCONS_THROW(ser_error(ec,line_,column_));
        }
    }

    void finish_parse(basic_json_visitor<CharT>& visitor, std::error_code& ec)
    {
        while (!finished())
        {
            parse_some(visitor, ec);
        }
    }

    void parse_some_(basic_json_visitor<CharT>& visitor, std::error_code& ec)
    {
        if (state_ == json_parse_state::before_done)
        {
            visitor.flush();
            done_ = true;
            state_ = json_parse_state::done;
            more_ = false;
            return;
        }
        const CharT* local_input_end = input_end_;

        if (input_ptr_ == local_input_end && more_)
        {
            switch (state_)
            {
                case json_parse_state::zero:  
                case json_parse_state::integer:
                    end_integer_value(visitor, ec);
                    if (ec) return;
                    break;
                case json_parse_state::fraction2:
                    end_fraction_value(visitor, ec);
                    if (ec) return;
                    break;
                case json_parse_state::exp3:
                    end_fraction_value(visitor, ec);
                    if (ec) return;
                    break;
                case json_parse_state::before_done:
                    visitor.flush();
                    done_ = true;
                    state_ = json_parse_state::done;
                    more_ = false;
                    break;
                case json_parse_state::done:
                    more_ = false;
                    break;
                case json_parse_state::cr:
                    state_ = pop_state();
                    break;
                default:
                    err_handler_(json_errc::unexpected_eof, *this);
                    ec = json_errc::unexpected_eof;
                    more_ = false;
                    return;
            }
        }

        while ((input_ptr_ < local_input_end) && more_)
        {
            switch (state_)
            {
                case json_parse_state::before_done:
                    visitor.flush();
                    done_ = true;
                    state_ = json_parse_state::done;
                    more_ = false;
                    break;
                case json_parse_state::cr:
                    ++line_;
                    column_ = 1;
                    switch (*input_ptr_)
                    {
                        case '\n':
                            ++input_ptr_;
                            state_ = pop_state();
                            break;
                        default:
                            state_ = pop_state();
                            break;
                    }
                    break;
                case json_parse_state::start: 
                    {
                        switch (*input_ptr_)
                        {
                            JSONCONS_ILLEGAL_CONTROL_CHARACTER:
                                more_ = err_handler_(json_errc::illegal_control_character, *this);
                                if (!more_)
                                {
                                    ec = json_errc::illegal_control_character;
                                    return;
                                }
                                break;
                            case '\r': 
                                push_state(state_);
                                ++input_ptr_;
                                ++column_;
                                state_ = json_parse_state::cr;
                                break; 
                            case '\n': 
                                ++input_ptr_;
                                ++line_;
                                column_ = 1;
                                break;   
                            case ' ':case '\t':
                                skip_space();
                                break;
                            case '/': 
                                ++input_ptr_;
                                ++column_;
                                push_state(state_);
                                state_ = json_parse_state::slash;
                                break;
                            case '{':
                                begin_object(visitor, ec);
                                if (ec) return;
                                ++input_ptr_;
                                ++column_;
                                break;
                            case '[':
                                begin_array(visitor, ec);
                                if (ec) return;
                                ++input_ptr_;
                                ++column_;
                                break;
                            case '\"':
                                state_ = json_parse_state::string;
                                ++input_ptr_;
                                ++column_;
                                string_buffer_.clear();
                                parse_string(visitor, ec);
                                if (ec) return;
                                break;
                            case '-':
                                string_buffer_.clear();
                                string_buffer_.push_back('-');
                                ++input_ptr_;
                                ++column_;
                                state_ = json_parse_state::minus;
                                parse_number(visitor, ec);
                                if (ec) {return;}
                                break;
                            case '0': 
                                string_buffer_.clear();
                                string_buffer_.push_back(static_cast<char>(*input_ptr_));
                                state_ = json_parse_state::zero;
                                ++input_ptr_;
                                ++column_;
                                parse_number(visitor, ec);
                                if (ec) {return;}
                                break;
                            case '1':case '2':case '3':case '4':case '5':case '6':case '7':case '8': case '9':
                                string_buffer_.clear();
                                string_buffer_.push_back(static_cast<char>(*input_ptr_));
                                ++input_ptr_;
                                ++column_;
                                state_ = json_parse_state::integer;
                                parse_number(visitor, ec);
                                if (ec) {return;}
                                break;
                            case 'n':
                                parse_null(visitor, ec);
                                if (ec) {return;}
                                break;
                            case 't':
                                parse_true(visitor, ec);
                                if (ec) {return;}
                                break;
                            case 'f':
                                parse_false(visitor, ec);
                                if (ec) {return;}
                                break;
                            case '}':
                                err_handler_(json_errc::unexpected_right_brace, *this);
                                ec = json_errc::unexpected_right_brace;
                                more_ = false;
                                return;
                            case ']':
                                err_handler_(json_errc::unexpected_right_bracket, *this);
                                ec = json_errc::unexpected_right_bracket;
                                more_ = false;
                                return;
                            default:
                                err_handler_(json_errc::invalid_json_text, *this);
                                ec = json_errc::invalid_json_text;
                                more_ = false;
                                return;
                        }
                    }
                    break;

                case json_parse_state::expect_comma_or_end: 
                    {
                        switch (*input_ptr_)
                        {
                            JSONCONS_ILLEGAL_CONTROL_CHARACTER:
                                more_ = err_handler_(json_errc::illegal_control_character, *this);
                                if (!more_)
                                {
                                    ec = json_errc::illegal_control_character;
                                    return;
                                }
                                ++input_ptr_;
                                ++column_;
                                break;
                            case '\r': 
                                ++input_ptr_;
                                ++column_;
                                push_state(state_);
                                state_ = json_parse_state::cr;
                                break; 
                            case '\n': 
                                ++input_ptr_;
                                ++line_;
                                column_ = 1;
                                break;   
                            case ' ':case '\t':
                                skip_space();
                                break;
                            case '/':
                                ++input_ptr_;
                                ++column_;
                                push_state(state_); 
                                state_ = json_parse_state::slash;
                                break;
                            case '}':
                                end_object(visitor, ec);
                                if (ec) return;
                                ++input_ptr_;
                                ++column_;
                                break;
                            case ']':
                                end_array(visitor, ec);
                                if (ec) return;
                                ++input_ptr_;
                                ++column_;
                                break;
                            case ',':
                                begin_member_or_element(ec);
                                if (ec) return;
                                ++input_ptr_;
                                ++column_;
                                break;
                            default:
                                if (parent() == json_parse_state::array)
                                {
                                    more_ = err_handler_(json_errc::expected_comma_or_right_bracket, *this);
                                    if (!more_)
                                    {
                                        ec = json_errc::expected_comma_or_right_bracket;
                                        return;
                                    }
                                }
                                else if (parent() == json_parse_state::object)
                                {
                                    more_ = err_handler_(json_errc::expected_comma_or_right_brace, *this);
                                    if (!more_)
                                    {
                                        ec = json_errc::expected_comma_or_right_brace;
                                        return;
                                    }
                                }
                                ++input_ptr_;
                                ++column_;
                                break;
                        }
                    }
                    break;
                case json_parse_state::expect_member_name_or_end: 
                    {
                        switch (*input_ptr_)
                        {
                            JSONCONS_ILLEGAL_CONTROL_CHARACTER:
                                more_ = err_handler_(json_errc::illegal_control_character, *this);
                                if (!more_)
                                {
                                    ec = json_errc::illegal_control_character;
                                    return;
                                }
                                ++input_ptr_;
                                ++column_;
                                break;
                            case '\r': 
                                ++input_ptr_;
                                ++column_;
                                push_state(state_);
                                state_ = json_parse_state::cr;
                                break; 
                            case '\n': 
                                ++input_ptr_;
                                ++line_;
                                column_ = 1;
                                break;   
                            case ' ':case '\t':
                                skip_space();
                                break;
                            case '/':
                                ++input_ptr_;
                                ++column_;
                                push_state(state_); 
                                state_ = json_parse_state::slash;
                                break;
                            case '}':
                                end_object(visitor, ec);
                                if (ec) return;
                                ++input_ptr_;
                                ++column_;
                                break;
                            case '\"':
                                ++input_ptr_;
                                ++column_;
                                push_state(json_parse_state::member_name);
                                state_ = json_parse_state::string;
                                string_buffer_.clear();
                                parse_string(visitor, ec);
                                if (ec) return;
                                break;
                            case '\'':
                                more_ = err_handler_(json_errc::single_quote, *this);
                                if (!more_)
                                {
                                    ec = json_errc::single_quote;
                                    return;
                                }
                                ++input_ptr_;
                                ++column_;
                                break;
                            default:
                                more_ = err_handler_(json_errc::expected_key, *this);
                                if (!more_)
                                {
                                    ec = json_errc::expected_key;
                                    return;
                                }
                                ++input_ptr_;
                                ++column_;
                                break;
                        }
                    }
                    break;
                case json_parse_state::expect_member_name: 
                    {
                        switch (*input_ptr_)
                        {
                            JSONCONS_ILLEGAL_CONTROL_CHARACTER:
                                more_ = err_handler_(json_errc::illegal_control_character, *this);
                                if (!more_)
                                {
                                    ec = json_errc::illegal_control_character;
                                    return;
                                }
                                ++input_ptr_;
                                ++column_;
                                break;
                            case '\r': 
                                ++input_ptr_;
                                ++column_;
                                push_state(state_);
                                state_ = json_parse_state::cr;
                                break; 
                            case '\n': 
                                ++input_ptr_;
                                ++line_;
                                column_ = 1;
                                break;   
                            case ' ':case '\t':
                                skip_space();
                                break;
                            case '/': 
                                ++input_ptr_;
                                ++column_;
                                push_state(state_);
                                state_ = json_parse_state::slash;
                                break;
                            case '\"':
                                ++input_ptr_;
                                ++column_;
                                push_state(json_parse_state::member_name);
                                state_ = json_parse_state::string;
                                string_buffer_.clear();
                                parse_string(visitor, ec);
                                if (ec) return;
                                break;
                            case '}':
                                more_ = err_handler_(json_errc::extra_comma, *this);
                                if (!more_)
                                {
                                    ec = json_errc::extra_comma;
                                    return;
                                }
                                end_object(visitor, ec);  // Recover
                                if (ec) return;
                                ++input_ptr_;
                                ++column_;
                                break;
                            case '\'':
                                more_ = err_handler_(json_errc::single_quote, *this);
                                if (!more_)
                                {
                                    ec = json_errc::single_quote;
                                    return;
                                }
                                ++input_ptr_;
                                ++column_;
                                break;
                            default:
                                more_ = err_handler_(json_errc::expected_key, *this);
                                if (!more_)
                                {
                                    ec = json_errc::expected_key;
                                    return;
                                }
                                ++input_ptr_;
                                ++column_;
                                break;
                        }
                    }
                    break;
                case json_parse_state::expect_colon: 
                    {
                        switch (*input_ptr_)
                        {
                            JSONCONS_ILLEGAL_CONTROL_CHARACTER:
                                more_ = err_handler_(json_errc::illegal_control_character, *this);
                                if (!more_)
                                {
                                    ec = json_errc::illegal_control_character;
                                    return;
                                }
                                ++input_ptr_;
                                ++column_;
                                break;
                            case '\r': 
                                push_state(state_);
                                state_ = json_parse_state::cr;
                                ++input_ptr_;
                                ++column_;
                                break; 
                            case '\n': 
                                ++input_ptr_;
                                ++line_;
                                column_ = 1;
                                break;   
                            case ' ':case '\t':
                                skip_space();
                                break;
                            case '/': 
                                push_state(state_);
                                state_ = json_parse_state::slash;
                                ++input_ptr_;
                                ++column_;
                                break;
                            case ':':
                                state_ = json_parse_state::expect_value;
                                ++input_ptr_;
                                ++column_;
                                break;
                            default:
                                more_ = err_handler_(json_errc::expected_colon, *this);
                                if (!more_)
                                {
                                    ec = json_errc::expected_colon;
                                    return;
                                }
                                ++input_ptr_;
                                ++column_;
                                break;
                        }
                    }
                    break;

                    case json_parse_state::expect_value: 
                    {
                        switch (*input_ptr_)
                        {
                            JSONCONS_ILLEGAL_CONTROL_CHARACTER:
                                more_ = err_handler_(json_errc::illegal_control_character, *this);
                                if (!more_)
                                {
                                    ec = json_errc::illegal_control_character;
                                    return;
                                }
                                ++input_ptr_;
                                ++column_;
                                break;
                            case '\r': 
                                push_state(state_);
                                ++input_ptr_;
                                ++column_;
                                state_ = json_parse_state::cr;
                                break; 
                            case '\n': 
                                ++input_ptr_;
                                ++line_;
                                column_ = 1;
                                break;   
                            case ' ':case '\t':
                                skip_space();
                                break;
                            case '/': 
                                push_state(state_);
                                ++input_ptr_;
                                ++column_;
                                state_ = json_parse_state::slash;
                                break;
                            case '{':
                                begin_object(visitor, ec);
                                if (ec) return;
                                ++input_ptr_;
                                ++column_;
                                break;
                            case '[':
                                begin_array(visitor, ec);
                                if (ec) return;
                                ++input_ptr_;
                                ++column_;
                                break;
                            case '\"':
                                ++input_ptr_;
                                ++column_;
                                state_ = json_parse_state::string;
                                string_buffer_.clear();
                                parse_string(visitor, ec);
                                if (ec) return;
                                break;
                            case '-':
                                string_buffer_.clear();
                                string_buffer_.push_back('-');
                                ++input_ptr_;
                                ++column_;
                                state_ = json_parse_state::minus;
                                parse_number(visitor, ec);
                                if (ec) {return;}
                                break;
                            case '0': 
                                string_buffer_.clear();
                                string_buffer_.push_back(static_cast<char>(*input_ptr_));
                                ++input_ptr_;
                                ++column_;
                                state_ = json_parse_state::zero;
                                parse_number(visitor, ec);
                                if (ec) {return;}
                                break;
                            case '1':case '2':case '3':case '4':case '5':case '6':case '7':case '8': case '9':
                                string_buffer_.clear();
                                string_buffer_.push_back(static_cast<char>(*input_ptr_));
                                ++input_ptr_;
                                ++column_;
                                state_ = json_parse_state::integer;
                                parse_number(visitor, ec);
                                if (ec) {return;}
                                break;
                            case 'n':
                                parse_null(visitor, ec);
                                if (ec) {return;}
                                break;
                            case 't':
                                parse_true(visitor, ec);
                                if (ec) {return;}
                                break;
                            case 'f':
                                parse_false(visitor, ec);
                                if (ec) {return;}
                                break;
                            case ']':
                                if (parent() == json_parse_state::array)
                                {
                                    more_ = err_handler_(json_errc::extra_comma, *this);
                                    if (!more_)
                                    {
                                        ec = json_errc::extra_comma;
                                        return;
                                    }
                                    end_array(visitor, ec);  // Recover
                                    if (ec) return;
                                }
                                else
                                {
                                    more_ = err_handler_(json_errc::expected_value, *this);
                                    if (!more_)
                                    {
                                        ec = json_errc::expected_value;
                                        return;
                                    }
                                }
                                ++input_ptr_;
                                ++column_;
                                break;
                            case '\'':
                                more_ = err_handler_(json_errc::single_quote, *this);
                                if (!more_)
                                {
                                    ec = json_errc::single_quote;
                                    return;
                                }
                                ++input_ptr_;
                                ++column_;
                                break;
                            default:
                                more_ = err_handler_(json_errc::expected_value, *this);
                                if (!more_)
                                {
                                    ec = json_errc::expected_value;
                                    return;
                                }
                                ++input_ptr_;
                                ++column_;
                                break;
                        }
                    }
                    break;
                    case json_parse_state::expect_value_or_end: 
                    {
                        switch (*input_ptr_)
                        {
                            JSONCONS_ILLEGAL_CONTROL_CHARACTER:
                                more_ = err_handler_(json_errc::illegal_control_character, *this);
                                if (!more_)
                                {
                                    ec = json_errc::illegal_control_character;
                                    return;
                                }
                                ++input_ptr_;
                                ++column_;
                                break;
                            case '\r': 
                                ++input_ptr_;
                                ++column_;
                                push_state(state_);
                                state_ = json_parse_state::cr;
                                break; 
                            case '\n': 
                                ++input_ptr_;
                                ++line_;
                                column_ = 1;
                                break;   
                            case ' ':case '\t':
                                skip_space();
                                break;
                            case '/': 
                                ++input_ptr_;
                                ++column_;
                                push_state(state_);
                                state_ = json_parse_state::slash;
                                break;
                            case '{':
                                begin_object(visitor, ec);
                                if (ec) return;
                                ++input_ptr_;
                                ++column_;
                                break;
                            case '[':
                                begin_array(visitor, ec);
                                if (ec) return;
                                ++input_ptr_;
                                ++column_;
                                break;
                            case ']':
                                end_array(visitor, ec);
                                if (ec) return;
                                ++input_ptr_;
                                ++column_;
                                break;
                            case '\"':
                                ++input_ptr_;
                                ++column_;
                                state_ = json_parse_state::string;
                                string_buffer_.clear();
                                parse_string(visitor, ec);
                                if (ec) return;
                                break;
                            case '-':
                                string_buffer_.clear();
                                string_buffer_.push_back('-');
                                ++input_ptr_;
                                ++column_;
                                state_ = json_parse_state::minus;
                                parse_number(visitor, ec);
                                if (ec) {return;}
                                break;
                            case '0': 
                                string_buffer_.clear();
                                string_buffer_.push_back(static_cast<char>(*input_ptr_));
                                ++input_ptr_;
                                ++column_;
                                state_ = json_parse_state::zero;
                                parse_number(visitor, ec);
                                if (ec) {return;}
                                break;
                            case '1':case '2':case '3':case '4':case '5':case '6':case '7':case '8': case '9':
                                string_buffer_.clear();
                                string_buffer_.push_back(static_cast<char>(*input_ptr_));
                                ++input_ptr_;
                                ++column_;
                                state_ = json_parse_state::integer;
                                parse_number(visitor, ec);
                                if (ec) {return;}
                                break;
                            case 'n':
                                parse_null(visitor, ec);
                                if (ec) {return;}
                                break;
                            case 't':
                                parse_true(visitor, ec);
                                if (ec) {return;}
                                break;
                            case 'f':
                                parse_false(visitor, ec);
                                if (ec) {return;}
                                break;
                            case '\'':
                                more_ = err_handler_(json_errc::single_quote, *this);
                                if (!more_)
                                {
                                    ec = json_errc::single_quote;
                                    return;
                                }
                                ++input_ptr_;
                                ++column_;
                                break;
                            default:
                                more_ = err_handler_(json_errc::expected_value, *this);
                                if (!more_)
                                {
                                    ec = json_errc::expected_value;
                                    return;
                                }
                                ++input_ptr_;
                                ++column_;
                                break;
                            }
                        }
                    break;
                case json_parse_state::string: 
                case json_parse_state::escape: 
                case json_parse_state::escape_u1: 
                case json_parse_state::escape_u2: 
                case json_parse_state::escape_u3: 
                case json_parse_state::escape_u4: 
                case json_parse_state::escape_expect_surrogate_pair1: 
                case json_parse_state::escape_expect_surrogate_pair2: 
                case json_parse_state::escape_u6: 
                case json_parse_state::escape_u7: 
                case json_parse_state::escape_u8: 
                case json_parse_state::escape_u9: 
                    parse_string(visitor, ec);
                    if (ec) return;
                    break;
                case json_parse_state::minus:
                case json_parse_state::zero:  
                case json_parse_state::integer: 
                case json_parse_state::fraction1: 
                case json_parse_state::fraction2: 
                case json_parse_state::exp1: 
                case json_parse_state::exp2:  
                case json_parse_state::exp3: 
                    parse_number(visitor, ec);  
                    if (ec) return;
                    break;
                case json_parse_state::t: 
                    switch (*input_ptr_)
                    {
                        case 'r':
                            ++input_ptr_;
                            ++column_;
                            state_ = json_parse_state::tr;
                            break;
                        default:
                            err_handler_(json_errc::invalid_value, *this);
                            ec = json_errc::invalid_value;
                            more_ = false;
                            return;
                    }
                    break;
                case json_parse_state::tr: 
                    switch (*input_ptr_)
                    {
                        case 'u':
                            state_ = json_parse_state::tru;
                            break;
                        default:
                            err_handler_(json_errc::invalid_value, *this);
                            ec = json_errc::invalid_value;
                            more_ = false;
                            return;
                    }
                    ++input_ptr_;
                    ++column_;
                    break;
                case json_parse_state::tru: 
                    switch (*input_ptr_)
                    {
                        case 'e':
                            more_ = visitor.bool_value(true,  semantic_tag::none, *this, ec);
                            if (parent() == json_parse_state::root)
                            {
                                state_ = json_parse_state::before_done;
                            }
                            else
                            {
                                state_ = json_parse_state::expect_comma_or_end;
                            }
                            break;
                        default:
                            err_handler_(json_errc::invalid_value, *this);
                            ec = json_errc::invalid_value;
                            more_ = false;
                            return;
                    }
                    ++input_ptr_;
                    ++column_;
                    break;
                case json_parse_state::f: 
                    switch (*input_ptr_)
                    {
                        case 'a':
                            ++input_ptr_;
                            ++column_;
                            state_ = json_parse_state::fa;
                            break;
                        default:
                            err_handler_(json_errc::invalid_value, *this);
                            ec = json_errc::invalid_value;
                            more_ = false;
                            return;
                    }
                    break;
                case json_parse_state::fa: 
                    switch (*input_ptr_)
                    {
                        case 'l':
                            state_ = json_parse_state::fal;
                            break;
                        default:
                            err_handler_(json_errc::invalid_value, *this);
                            ec = json_errc::invalid_value;
                            more_ = false;
                            return;
                    }
                    ++input_ptr_;
                    ++column_;
                    break;
                case json_parse_state::fal: 
                    switch (*input_ptr_)
                    {
                        case 's':
                            state_ = json_parse_state::fals;
                            break;
                        default:
                            err_handler_(json_errc::invalid_value, *this);
                            ec = json_errc::invalid_value;
                            more_ = false;
                            return;
                    }
                    ++input_ptr_;
                    ++column_;
                    break;
                case json_parse_state::fals: 
                    switch (*input_ptr_)
                    {
                        case 'e':
                            more_ = visitor.bool_value(false, semantic_tag::none, *this, ec);
                            if (parent() == json_parse_state::root)
                            {
                                state_ = json_parse_state::before_done;
                            }
                            else
                            {
                                state_ = json_parse_state::expect_comma_or_end;
                            }
                            break;
                        default:
                            err_handler_(json_errc::invalid_value, *this);
                            ec = json_errc::invalid_value;
                            more_ = false;
                            return;
                    }
                    ++input_ptr_;
                    ++column_;
                    break;
                case json_parse_state::n: 
                    switch (*input_ptr_)
                    {
                        case 'u':
                            ++input_ptr_;
                            ++column_;
                            state_ = json_parse_state::nu;
                            break;
                        default:
                            err_handler_(json_errc::invalid_value, *this);
                            ec = json_errc::invalid_value;
                            more_ = false;
                            return;
                    }
                    break;
                case json_parse_state::nu: 
                    switch (*input_ptr_)
                    {
                        case 'l':
                            state_ = json_parse_state::nul;
                            break;
                        default:
                            err_handler_(json_errc::invalid_value, *this);
                            ec = json_errc::invalid_value;
                            more_ = false;
                            return;
                    }
                    ++input_ptr_;
                    ++column_;
                    break;
                case json_parse_state::nul: 
                    switch (*input_ptr_)
                    {
                    case 'l':
                        more_ = visitor.null_value(semantic_tag::none, *this, ec);
                        if (parent() == json_parse_state::root)
                        {
                            state_ = json_parse_state::before_done;
                        }
                        else
                        {
                            state_ = json_parse_state::expect_comma_or_end;
                        }
                        break;
                    default:
                        err_handler_(json_errc::invalid_value, *this);
                        ec = json_errc::invalid_value;
                        more_ = false;
                        return;
                    }
                    ++input_ptr_;
                    ++column_;
                    break;
                case json_parse_state::slash: 
                {
                    switch (*input_ptr_)
                    {
                    case '*':
                        state_ = json_parse_state::slash_star;
                        more_ = err_handler_(json_errc::illegal_comment, *this);
                        if (!more_)
                        {
                            ec = json_errc::illegal_comment;
                            return;
                        }
                        break;
                    case '/':
                        state_ = json_parse_state::slash_slash;
                        more_ = err_handler_(json_errc::illegal_comment, *this);
                        if (!more_)
                        {
                            ec = json_errc::illegal_comment;
                            return;
                        }
                        break;
                    default:    
                        more_ = err_handler_(json_errc::invalid_json_text, *this);
                        if (!more_)
                        {
                            ec = json_errc::invalid_json_text;
                            return;
                        }
                        break;
                    }
                    ++input_ptr_;
                    ++column_;
                    break;
                }
                case json_parse_state::slash_star:  
                {
                    switch (*input_ptr_)
                    {
                    case '\r':
                        push_state(state_);
                        state_ = json_parse_state::cr;
                        break;
                    case '\n':
                        ++line_;
                        column_ = 1;
                        break;
                    case '*':
                        state_ = json_parse_state::slash_star_star;
                        break;
                    }
                    ++input_ptr_;
                    ++column_;
                    break;
                }
                case json_parse_state::slash_slash: 
                {
                    switch (*input_ptr_)
                    {
                    case '\r':
                        state_ = pop_state();
                        break;
                    case '\n':
                        state_ = pop_state();
                        break;
                    default:
                        ++input_ptr_;
                        ++column_;
                    }
                    break;
                }
                case json_parse_state::slash_star_star: 
                {
                    switch (*input_ptr_)
                    {
                    case '/':
                        state_ = pop_state();
                        break;
                    default:    
                        state_ = json_parse_state::slash_star;
                        break;
                    }
                    ++input_ptr_;
                    ++column_;
                    break;
                }
                default:
                    JSONCONS_ASSERT(false);
                    break;
            }
        }
    }

    void parse_true(basic_json_visitor<CharT>& visitor, std::error_code& ec)
    {
        if (JSONCONS_LIKELY(input_end_ - input_ptr_ >= 4))
        {
            if (*(input_ptr_+1) == 'r' && *(input_ptr_+2) == 'u' && *(input_ptr_+3) == 'e')
            {
                more_ = visitor.bool_value(true, semantic_tag::none, *this, ec);
                input_ptr_ += 4;
                column_ += 4;
                if (parent() == json_parse_state::root)
                {
                    state_ = json_parse_state::before_done;
                }
                else
                {
                    state_ = json_parse_state::expect_comma_or_end;
                }
            }
            else
            {
                err_handler_(json_errc::invalid_value, *this);
                ec = json_errc::invalid_value;
                more_ = false;
                return;
            }
        }
        else
        {
            ++input_ptr_;
            ++column_;
            state_ = json_parse_state::t;
        }
    }

    void parse_null(basic_json_visitor<CharT>& visitor, std::error_code& ec)
    {
        if (JSONCONS_LIKELY(input_end_ - input_ptr_ >= 4))
        {
            if (*(input_ptr_+1) == 'u' && *(input_ptr_+2) == 'l' && *(input_ptr_+3) == 'l')
            {
                more_ = visitor.null_value(semantic_tag::none, *this, ec);
                input_ptr_ += 4;
                column_ += 4;
                if (parent() == json_parse_state::root)
                {
                    state_ = json_parse_state::before_done;
                }
                else
                {
                    state_ = json_parse_state::expect_comma_or_end;
                }
            }
            else
            {
                err_handler_(json_errc::invalid_value, *this);
                ec = json_errc::invalid_value;
                more_ = false;
                return;
            }
        }
        else
        {
            ++input_ptr_;
            ++column_;
            state_ = json_parse_state::n;
        }
    }

    void parse_false(basic_json_visitor<CharT>& visitor, std::error_code& ec)
    {
        if (JSONCONS_LIKELY(input_end_ - input_ptr_ >= 5))
        {
            if (*(input_ptr_+1) == 'a' && *(input_ptr_+2) == 'l' && *(input_ptr_+3) == 's' && *(input_ptr_+4) == 'e')
            {
                more_ = visitor.bool_value(false, semantic_tag::none, *this, ec);
                input_ptr_ += 5;
                column_ += 5;
                if (parent() == json_parse_state::root)
                {
                    state_ = json_parse_state::before_done;
                }
                else
                {
                    state_ = json_parse_state::expect_comma_or_end;
                }
            }
            else
            {
                err_handler_(json_errc::invalid_value, *this);
                ec = json_errc::invalid_value;
                more_ = false;
                return;
            }
        }
        else
        {
            ++input_ptr_;
            ++column_;
            state_ = json_parse_state::f;
        }
    }

    void parse_number(basic_json_visitor<CharT>& visitor, std::error_code& ec)
    {
        const CharT* local_input_end = input_end_;

        switch (state_)
        {
            case json_parse_state::minus:
                goto minus_sign;
            case json_parse_state::zero:
                goto zero;
            case json_parse_state::integer:
                goto integer;
            case json_parse_state::fraction1:
                goto fraction1;
            case json_parse_state::fraction2:
                goto fraction2;
            case json_parse_state::exp1:
                goto exp1;
            case json_parse_state::exp2:
                goto exp2;
            case json_parse_state::exp3:
                goto exp3;
            default:
                JSONCONS_UNREACHABLE();               
        }
minus_sign:
        if (JSONCONS_UNLIKELY(input_ptr_ >= local_input_end)) // Buffer exhausted               
        {
            state_ = json_parse_state::minus;
            return;
        }
        switch (*input_ptr_)
        {
            case '0': 
                string_buffer_.push_back(static_cast<char>(*input_ptr_));
                ++input_ptr_;
                ++column_;
                goto zero;
            case '1':case '2':case '3':case '4':case '5':case '6':case '7':case '8': case '9':
                string_buffer_.push_back(static_cast<char>(*input_ptr_));
                ++input_ptr_;
                ++column_;
                goto integer;
            default:
                err_handler_(json_errc::expected_value, *this);
                ec = json_errc::expected_value;
                more_ = false;
                return;
        }
zero:
        if (JSONCONS_UNLIKELY(input_ptr_ >= local_input_end)) // Buffer exhausted               
        {
            state_ = json_parse_state::zero;
            return;
        }
        switch (*input_ptr_)
        {
            case '\r': 
                end_integer_value(visitor, ec);
                if (ec) return;
                ++input_ptr_;
                ++column_;
                push_state(state_);
                state_ = json_parse_state::cr;
                return; 
            case '\n': 
                end_integer_value(visitor, ec);
                if (ec) return;
                ++input_ptr_;
                ++line_;
                column_ = 1;
                return;   
            case ' ':case '\t':
                end_integer_value(visitor, ec);
                if (ec) return;
                skip_space();
                return;
            case '/': 
                end_integer_value(visitor, ec);
                if (ec) return;
                ++input_ptr_;
                ++column_;
                push_state(state_);
                state_ = json_parse_state::slash;
                return;
            case '}':
                end_integer_value(visitor, ec);
                if (ec) return;
                state_ = json_parse_state::expect_comma_or_end;
                return;
            case ']':
                end_integer_value(visitor, ec);
                if (ec) return;
                state_ = json_parse_state::expect_comma_or_end;
                return;
            case '.':
                string_buffer_.push_back(to_double_.get_decimal_point());
                ++input_ptr_;
                ++column_;
                goto fraction1;
            case 'e':case 'E':
                string_buffer_.push_back(static_cast<char>(*input_ptr_));
                ++input_ptr_;
                ++column_;
                goto exp1;
            case ',':
                end_integer_value(visitor, ec);
                if (ec) return;
                begin_member_or_element(ec);
                if (ec) return;
                ++input_ptr_;
                ++column_;
                return;
            case '0': case '1':case '2':case '3':case '4':case '5':case '6':case '7':case '8': case '9':
                err_handler_(json_errc::leading_zero, *this);
                ec = json_errc::leading_zero;
                more_ = false;
                state_ = json_parse_state::zero;
                return;
            default:
                err_handler_(json_errc::invalid_number, *this);
                ec = json_errc::invalid_number;
                more_ = false;
                state_ = json_parse_state::zero;
                return;
        }
integer:
        if (JSONCONS_UNLIKELY(input_ptr_ >= local_input_end)) // Buffer exhausted               
        {
            state_ = json_parse_state::integer;
            return;
        }
        switch (*input_ptr_)
        {
            case '\r': 
                end_integer_value(visitor, ec);
                if (ec) return;
                push_state(state_);
                ++input_ptr_;
                ++column_;
                state_ = json_parse_state::cr;
                return; 
            case '\n': 
                end_integer_value(visitor, ec);
                if (ec) return;
                ++input_ptr_;
                ++line_;
                column_ = 1;
                return;   
            case ' ':case '\t':
                end_integer_value(visitor, ec);
                if (ec) return;
                skip_space();
                return;
            case '/': 
                end_integer_value(visitor, ec);
                if (ec) return;
                push_state(state_);
                ++input_ptr_;
                ++column_;
                state_ = json_parse_state::slash;
                return;
            case '}':
                end_integer_value(visitor, ec);
                if (ec) return;
                state_ = json_parse_state::expect_comma_or_end;
                return;
            case ']':
                end_integer_value(visitor, ec);
                if (ec) return;
                state_ = json_parse_state::expect_comma_or_end;
                return;
            case '0': case '1':case '2':case '3':case '4':case '5':case '6':case '7':case '8': case '9':
                string_buffer_.push_back(static_cast<char>(*input_ptr_));
                ++input_ptr_;
                ++column_;
                goto integer;
            case '.':
                string_buffer_.push_back(to_double_.get_decimal_point());
                ++input_ptr_;
                ++column_;
                goto fraction1;
            case 'e':case 'E':
                string_buffer_.push_back(static_cast<char>(*input_ptr_));
                ++input_ptr_;
                ++column_;
                goto exp1;
            case ',':
                end_integer_value(visitor, ec);
                if (ec) return;
                begin_member_or_element(ec);
                if (ec) return;
                ++input_ptr_;
                ++column_;
                return;
            default:
                err_handler_(json_errc::invalid_number, *this);
                ec = json_errc::invalid_number;
                more_ = false;
                state_ = json_parse_state::integer;
                return;
        }
fraction1:
        if (JSONCONS_UNLIKELY(input_ptr_ >= local_input_end)) // Buffer exhausted               
        {
            state_ = json_parse_state::fraction1;
            return;
        }
        switch (*input_ptr_)
        {
            case '0':case '1':case '2':case '3':case '4':case '5':case '6':case '7':case '8': case '9':
                string_buffer_.push_back(static_cast<char>(*input_ptr_));
                ++input_ptr_;
                ++column_;
                goto fraction2;
            default:
                err_handler_(json_errc::invalid_number, *this);
                ec = json_errc::invalid_number;
                more_ = false;
                state_ = json_parse_state::fraction1;
                return;
        }
fraction2:
        if (JSONCONS_UNLIKELY(input_ptr_ >= local_input_end)) // Buffer exhausted               
        {
            state_ = json_parse_state::fraction2;
            return;
        }
        switch (*input_ptr_)
        {
            case '\r': 
                end_fraction_value(visitor, ec);
                if (ec) return;
                push_state(state_);
                ++input_ptr_;
                ++column_;
                state_ = json_parse_state::cr;
                return; 
            case '\n': 
                end_fraction_value(visitor, ec);
                if (ec) return;
                ++input_ptr_;
                ++line_;
                column_ = 1;
                return;   
            case ' ':case '\t':
                end_fraction_value(visitor, ec);
                if (ec) return;
                skip_space();
                return;
            case '/': 
                end_fraction_value(visitor, ec);
                if (ec) return;
                push_state(state_);
                ++input_ptr_;
                ++column_;
                state_ = json_parse_state::slash;
                return;
            case '}':
                end_fraction_value(visitor, ec);
                if (ec) return;
                state_ = json_parse_state::expect_comma_or_end;
                return;
            case ']':
                end_fraction_value(visitor, ec);
                if (ec) return;
                state_ = json_parse_state::expect_comma_or_end;
                return;
            case ',':
                end_fraction_value(visitor, ec);
                if (ec) return;
                begin_member_or_element(ec);
                if (ec) return;
                ++input_ptr_;
                ++column_;
                return;
            case '0':case '1':case '2':case '3':case '4':case '5':case '6':case '7':case '8': case '9':
                string_buffer_.push_back(static_cast<char>(*input_ptr_));
                ++input_ptr_;
                ++column_;
                goto fraction2;
            case 'e':case 'E':
                string_buffer_.push_back(static_cast<char>(*input_ptr_));
                ++input_ptr_;
                ++column_;
                goto exp1;
            default:
                err_handler_(json_errc::invalid_number, *this);
                ec = json_errc::invalid_number;
                more_ = false;
                state_ = json_parse_state::fraction2;
                return;
        }
exp1:
        if (JSONCONS_UNLIKELY(input_ptr_ >= local_input_end)) // Buffer exhausted               
        {
            state_ = json_parse_state::exp1;
            return;
        }
        switch (*input_ptr_)
        {
            case '+':
                ++input_ptr_;
                ++column_;
                goto exp2;
            case '-':
                string_buffer_.push_back(static_cast<char>(*input_ptr_));
                ++input_ptr_;
                ++column_;
                goto exp2;
            case '0':case '1':case '2':case '3':case '4':case '5':case '6':case '7':case '8': case '9':
                string_buffer_.push_back(static_cast<char>(*input_ptr_));
                ++input_ptr_;
                ++column_;
                goto exp3;
            default:
                err_handler_(json_errc::expected_value, *this);
                ec = json_errc::expected_value;
                more_ = false;
                state_ = json_parse_state::exp1;
                return;
        }
exp2:
        if (JSONCONS_UNLIKELY(input_ptr_ >= local_input_end)) // Buffer exhausted               
        {
            state_ = json_parse_state::exp2;
            return;
        }
        switch (*input_ptr_)
        {
            case '0':case '1':case '2':case '3':case '4':case '5':case '6':case '7':case '8': case '9':
                string_buffer_.push_back(static_cast<char>(*input_ptr_));
                ++input_ptr_;
                ++column_;
                goto exp3;
            default:
                err_handler_(json_errc::expected_value, *this);
                ec = json_errc::expected_value;
                more_ = false;
                state_ = json_parse_state::exp2;
                return;
        }
        
exp3:
        if (JSONCONS_UNLIKELY(input_ptr_ >= local_input_end)) // Buffer exhausted               
        {
            state_ = json_parse_state::exp3;
            return;
        }
        switch (*input_ptr_)
        {
            case '\r': 
                end_fraction_value(visitor, ec);
                if (ec) return;
                ++input_ptr_;
                ++column_;
                push_state(state_);
                state_ = json_parse_state::cr;
                return; 
            case '\n': 
                end_fraction_value(visitor, ec);
                if (ec) return;
                ++input_ptr_;
                ++line_;
                column_ = 1;
                return;   
            case ' ':case '\t':
                end_fraction_value(visitor, ec);
                if (ec) return;
                skip_space();
                return;
            case '/': 
                end_fraction_value(visitor, ec);
                if (ec) return;
                push_state(state_);
                ++input_ptr_;
                ++column_;
                state_ = json_parse_state::slash;
                return;
            case '}':
                end_fraction_value(visitor, ec);
                if (ec) return;
                state_ = json_parse_state::expect_comma_or_end;
                return;
            case ']':
                end_fraction_value(visitor, ec);
                if (ec) return;
                state_ = json_parse_state::expect_comma_or_end;
                return;
            case ',':
                end_fraction_value(visitor, ec);
                if (ec) return;
                begin_member_or_element(ec);
                if (ec) return;
                ++input_ptr_;
                ++column_;
                return;
            case '0':case '1':case '2':case '3':case '4':case '5':case '6':case '7':case '8': case '9':
                string_buffer_.push_back(static_cast<char>(*input_ptr_));
                ++input_ptr_;
                ++column_;
                goto exp3;
            default:
                err_handler_(json_errc::invalid_number, *this);
                ec = json_errc::invalid_number;
                more_ = false;
                state_ = json_parse_state::exp3;
                return;
        }

        JSONCONS_UNREACHABLE();               
    }

    void parse_string(basic_json_visitor<CharT>& visitor, std::error_code& ec)
    {
        const CharT* local_input_end = input_end_;
        const CharT* sb = input_ptr_;

        switch (state_)
        {
            case json_parse_state::string:
                goto string_u1;
            case json_parse_state::escape:
                goto escape;
            case json_parse_state::escape_u1:
                goto escape_u1;
            case json_parse_state::escape_u2:
                goto escape_u2;
            case json_parse_state::escape_u3:
                goto escape_u3;
            case json_parse_state::escape_u4:
                goto escape_u4;
            case json_parse_state::escape_expect_surrogate_pair1:
                goto escape_expect_surrogate_pair1;
            case json_parse_state::escape_expect_surrogate_pair2:
                goto escape_expect_surrogate_pair2;
            case json_parse_state::escape_u6:
                goto escape_u6;
            case json_parse_state::escape_u7:
                goto escape_u7;
            case json_parse_state::escape_u8:
                goto escape_u8;
            case json_parse_state::escape_u9:
                goto escape_u9;
            default:
                JSONCONS_UNREACHABLE();               
        }

string_u1:
        while (input_ptr_ < local_input_end)
        {
            switch (*input_ptr_)
            {
                JSONCONS_ILLEGAL_CONTROL_CHARACTER:
                {
                    column_ += (input_ptr_ - sb + 1);
                    more_ = err_handler_(json_errc::illegal_control_character, *this);
                    if (!more_)
                    {
                        ec = json_errc::illegal_control_character;
                        state_ = json_parse_state::string;
                        return;
                    }
                    // recovery - skip
                    string_buffer_.append(sb,input_ptr_-sb);
                    ++input_ptr_;
                    state_ = json_parse_state::string;
                    return;
                }
                case '\r':
                {
                    column_ += (input_ptr_ - sb + 1);
                    more_ = err_handler_(json_errc::illegal_character_in_string, *this);
                    if (!more_)
                    {
                        ec = json_errc::illegal_character_in_string;
                        state_ = json_parse_state::string;
                        return;
                    }
                    // recovery - keep
                    string_buffer_.append(sb, input_ptr_ - sb + 1);
                    ++input_ptr_;
                    push_state(state_);
                    state_ = json_parse_state::cr;
                    return;
                }
                case '\n':
                {
                    ++line_;
                    column_ = 1;
                    more_ = err_handler_(json_errc::illegal_character_in_string, *this);
                    if (!more_)
                    {
                        ec = json_errc::illegal_character_in_string;
                        state_ = json_parse_state::string;
                        return;
                    }
                    // recovery - keep
                    string_buffer_.append(sb, input_ptr_ - sb + 1);
                    ++input_ptr_;
                    return;
                }
                case '\t':
                {
                    column_ += (input_ptr_ - sb + 1);
                    more_ = err_handler_(json_errc::illegal_character_in_string, *this);
                    if (!more_)
                    {
                        ec = json_errc::illegal_character_in_string;
                        state_ = json_parse_state::string;
                        return;
                    }
                    // recovery - keep
                    string_buffer_.append(sb, input_ptr_ - sb + 1);
                    ++input_ptr_;
                    state_ = json_parse_state::string;
                    return;
                }
                case '\\': 
                {
                    string_buffer_.append(sb,input_ptr_-sb);
                    column_ += (input_ptr_ - sb + 1);
                    ++input_ptr_;
                    goto escape;
                }
                case '\"':
                {
                    if (string_buffer_.length() == 0)
                    {
                        end_string_value(sb,input_ptr_-sb, visitor, ec);
                        if (ec) {return;}
                    }
                    else
                    {
                        string_buffer_.append(sb,input_ptr_-sb);
                        end_string_value(string_buffer_.data(),string_buffer_.length(), visitor, ec);
                        if (ec) {return;}
                    }
                    column_ += (input_ptr_ - sb + 1);
                    ++input_ptr_;
                    return;
                }
            default:
                break;
            }
            ++input_ptr_;
        }

        // Buffer exhausted               
        {
            string_buffer_.append(sb,input_ptr_-sb);
            column_ += (input_ptr_ - sb + 1);
            state_ = json_parse_state::string;
            return;
        }

escape:
        if (JSONCONS_UNLIKELY(input_ptr_ >= local_input_end)) // Buffer exhausted               
        {
            state_ = json_parse_state::escape;
            return;
        }
        switch (*input_ptr_)
        {
        case '\"':
            string_buffer_.push_back('\"');
            sb = ++input_ptr_;
            ++column_;
            goto string_u1;
        case '\\': 
            string_buffer_.push_back('\\');
            sb = ++input_ptr_;
            ++column_;
            goto string_u1;
        case '/':
            string_buffer_.push_back('/');
            sb = ++input_ptr_;
            ++column_;
            goto string_u1;
        case 'b':
            string_buffer_.push_back('\b');
            sb = ++input_ptr_;
            ++column_;
            goto string_u1;
        case 'f':
            string_buffer_.push_back('\f');
            sb = ++input_ptr_;
            ++column_;
            goto string_u1;
        case 'n':
            string_buffer_.push_back('\n');
            sb = ++input_ptr_;
            ++column_;
            goto string_u1;
        case 'r':
            string_buffer_.push_back('\r');
            sb = ++input_ptr_;
            ++column_;
            goto string_u1;
        case 't':
            string_buffer_.push_back('\t');
            sb = ++input_ptr_;
            ++column_;
            goto string_u1;
        case 'u':
            cp_ = 0;
            ++input_ptr_;
            ++column_;
            goto escape_u1;
        default:    
            err_handler_(json_errc::illegal_escaped_character, *this);
            ec = json_errc::illegal_escaped_character;
            more_ = false;
            state_ = json_parse_state::escape;
            return;
        }

escape_u1:
        if (JSONCONS_UNLIKELY(input_ptr_ >= local_input_end)) // Buffer exhausted               
        {
            state_ = json_parse_state::escape_u1;
            return;
        }
        {
            append_codepoint(*input_ptr_,ec);
            if (ec)
            {
                state_ = json_parse_state::escape_u1;
                return;
            }
            ++input_ptr_;
            ++column_;
            goto escape_u2;
        }

escape_u2:
        if (JSONCONS_UNLIKELY(input_ptr_ >= local_input_end)) // Buffer exhausted               
        {
            state_ = json_parse_state::escape_u2;
            return;
        }
        {
            append_codepoint(*input_ptr_, ec);
            if (ec)
            {
                state_ = json_parse_state::escape_u2;
                return;
            }
            ++input_ptr_;
            ++column_;
            goto escape_u3;
        }

escape_u3:
        if (JSONCONS_UNLIKELY(input_ptr_ >= local_input_end)) // Buffer exhausted               
        {
            state_ = json_parse_state::escape_u3;
            return;
        }
        {
            append_codepoint(*input_ptr_, ec);
            if (ec)
            {
                state_ = json_parse_state::escape_u3;
                return;
            }
            ++input_ptr_;
            ++column_;
            goto escape_u4;
        }

escape_u4:
        if (JSONCONS_UNLIKELY(input_ptr_ >= local_input_end)) // Buffer exhausted               
        {
            state_ = json_parse_state::escape_u4;
            return;
        }
        {
            append_codepoint(*input_ptr_, ec);
            if (ec)
            {
                state_ = json_parse_state::escape_u4;
                return;
            }
            if (unicons::is_high_surrogate(cp_))
            {
                ++input_ptr_;
                ++column_;
                goto escape_expect_surrogate_pair1;
            }
            else
            {
                unicons::convert(&cp_, &cp_ + 1, std::back_inserter(string_buffer_));
                sb = ++input_ptr_;
                ++column_;
                state_ = json_parse_state::string;
                return;
            }
        }

escape_expect_surrogate_pair1:
        if (JSONCONS_UNLIKELY(input_ptr_ >= local_input_end)) // Buffer exhausted               
        {
            state_ = json_parse_state::escape_expect_surrogate_pair1;
            return;
        }
        {
            switch (*input_ptr_)
            {
            case '\\': 
                cp2_ = 0;
                ++input_ptr_;
                ++column_;
                goto escape_expect_surrogate_pair2;
            default:
                err_handler_(json_errc::expected_codepoint_surrogate_pair, *this);
                ec = json_errc::expected_codepoint_surrogate_pair;
                more_ = false;
                state_ = json_parse_state::escape_expect_surrogate_pair1;
                return;
            }
        }

escape_expect_surrogate_pair2:
        if (JSONCONS_UNLIKELY(input_ptr_ >= local_input_end)) // Buffer exhausted               
        {
            state_ = json_parse_state::escape_expect_surrogate_pair2;
            return;
        }
        {
            switch (*input_ptr_)
            {
            case 'u':
                ++input_ptr_;
                ++column_;
                goto escape_u6;
            default:
                err_handler_(json_errc::expected_codepoint_surrogate_pair, *this);
                ec = json_errc::expected_codepoint_surrogate_pair;
                more_ = false;
                state_ = json_parse_state::escape_expect_surrogate_pair2;
                return;
            }
        }

escape_u6:
        if (JSONCONS_UNLIKELY(input_ptr_ >= local_input_end)) // Buffer exhausted               
        {
            state_ = json_parse_state::escape_u6;
            return;
        }
        {
            append_second_codepoint(*input_ptr_, ec);
            if (ec)
            {
                state_ = json_parse_state::escape_u6;
                return;
            }
        }
        ++input_ptr_;
        ++column_;
        goto escape_u7;

escape_u7:
        if (JSONCONS_UNLIKELY(input_ptr_ >= local_input_end)) // Buffer exhausted               
        {
            state_ = json_parse_state::escape_u7;
            return;
        }
        {
            append_second_codepoint(*input_ptr_, ec);
            if (ec)
            {
                state_ = json_parse_state::escape_u7;
                return;
            }
            ++input_ptr_;
            ++column_;
            goto escape_u8;
        }

escape_u8:
        if (JSONCONS_UNLIKELY(input_ptr_ >= local_input_end)) // Buffer exhausted               
        {
            state_ = json_parse_state::escape_u8;
            return;
        }
        {
            append_second_codepoint(*input_ptr_, ec);
            if (ec)
            {
                state_ = json_parse_state::escape_u8;
                return;
            }
            ++input_ptr_;
            ++column_;
            goto escape_u9;
        }

escape_u9:
        if (JSONCONS_UNLIKELY(input_ptr_ >= local_input_end)) // Buffer exhausted               
        {
            state_ = json_parse_state::escape_u9;
            return;
        }
        {
            append_second_codepoint(*input_ptr_, ec);
            if (ec)
            {
                state_ = json_parse_state::escape_u9;
                return;
            }
            uint32_t cp = 0x10000 + ((cp_ & 0x3FF) << 10) + (cp2_ & 0x3FF);
            unicons::convert(&cp, &cp + 1, std::back_inserter(string_buffer_));
            sb = ++input_ptr_;
            ++column_;
            goto string_u1;
        }

        JSONCONS_UNREACHABLE();               
    }

    void translate_conv_errc(unicons::conv_errc result, std::error_code& ec)
    {
        switch (result)
        {
        case unicons::conv_errc():
            break;
        case unicons::conv_errc::over_long_utf8_sequence:
            more_ = err_handler_(json_errc::over_long_utf8_sequence, *this);
            if (!more_)
            {
                ec = json_errc::over_long_utf8_sequence;
                return;
            }
            break;
        case unicons::conv_errc::unpaired_high_surrogate:
            more_ = err_handler_(json_errc::unpaired_high_surrogate, *this);
            if (!more_)
            {
                ec = json_errc::unpaired_high_surrogate;
                return;
            }
            break;
        case unicons::conv_errc::expected_continuation_byte:
            more_ = err_handler_(json_errc::expected_continuation_byte, *this);
            if (!more_)
            {
                ec = json_errc::expected_continuation_byte;
                return;
            }
            break;
        case unicons::conv_errc::illegal_surrogate_value:
            more_ = err_handler_(json_errc::illegal_surrogate_value, *this);
            if (!more_)
            {
                ec = json_errc::illegal_surrogate_value;
                return;
            }
            break;
        default:
            more_ = err_handler_(json_errc::illegal_codepoint, *this);
            if (!more_)
            {
                ec = json_errc::illegal_codepoint;
                return;
            }
            break;
        }
    }

#if !defined(JSONCONS_NO_DEPRECATED)

    JSONCONS_DEPRECATED_MSG("Instead, use finish_parse(basic_json_visitor<CharT>&)")
    void end_parse(basic_json_visitor<CharT>& visitor)
    {
        std::error_code ec;
        finish_parse(visitor, ec);
        if (ec)
        {
            JSONCONS_THROW(ser_error(ec,line_,column_));
        }
    }

    JSONCONS_DEPRECATED_MSG("Instead, use finish_parse(basic_json_visitor<CharT>&, std::error_code&)")
    void end_parse(basic_json_visitor<CharT>& visitor, std::error_code& ec)
    {
        while (!finished())
        {
            parse_some(visitor, ec);
        }
    }

    JSONCONS_DEPRECATED_MSG("Instead, use update(const CharT*, std::size_t)")
    void set_source(const CharT* data, std::size_t length)
    {
        begin_input_ = data;
        input_end_ = data + length;
        input_ptr_ = begin_input_;
    }
#endif

    std::size_t line() const override
    {
        return line_;
    }

    std::size_t column() const override
    {
        return column_;
    }
private:

    void end_integer_value(basic_json_visitor<CharT>& visitor, std::error_code& ec)
    {
        if (string_buffer_[0] == '-')
        {
            end_negative_value(visitor, ec);
        }
        else
        {
            end_positive_value(visitor, ec);
        }
    }

    void end_negative_value(basic_json_visitor<CharT>& visitor, std::error_code& ec)
    {
        auto result = jsoncons::detail::to_integer_unchecked<int64_t>(string_buffer_.data(), string_buffer_.length());
        if (result)
        {
            more_ = visitor.int64_value(result.value(), semantic_tag::none, *this, ec);
        }
        else // Must be overflow
        {
            more_ = visitor.string_value(string_buffer_, semantic_tag::bigint, *this, ec);
        }
        after_value(ec);
    }

    void end_positive_value(basic_json_visitor<CharT>& visitor, std::error_code& ec)
    {
        auto result = jsoncons::detail::to_integer_unchecked<uint64_t>(string_buffer_.data(), string_buffer_.length());
        if (result)
        {
            more_ = visitor.uint64_value(result.value(), semantic_tag::none, *this, ec);
        }
        else // Must be overflow
        {
            more_ = visitor.string_value(string_buffer_, semantic_tag::bigint, *this, ec);
        }
        after_value(ec);
    }

    void end_fraction_value(basic_json_visitor<CharT>& visitor, std::error_code& ec)
    {
        JSONCONS_TRY
        {
            if (options_.lossless_number())
            {
                more_ = visitor.string_value(string_buffer_, semantic_tag::bigdec, *this, ec);
            }
            else
            {
                double d = to_double_(string_buffer_.c_str(), string_buffer_.length());
                more_ = visitor.double_value(d, semantic_tag::none, *this, ec);
            }
        }
        JSONCONS_CATCH(...)
        {
            more_ = err_handler_(json_errc::invalid_number, *this);
            if (!more_)
            {
                ec = json_errc::invalid_number;
                return;
            }
            more_ = visitor.null_value(semantic_tag::none, *this, ec); // recovery
        }

        after_value(ec);
    }

    void append_codepoint(int c, std::error_code& ec)
    {
        switch (c)
        {
        case '0': case '1':case '2':case '3':case '4':case '5':case '6':case '7':case '8': case '9':
        case 'a':case 'b':case 'c':case 'd':case 'e':case 'f':
        case 'A':case 'B':case 'C':case 'D':case 'E':case 'F':
            cp_ = append_to_codepoint(cp_, c, ec);
            if (ec) return;
            break;
        default:
            more_ = err_handler_(json_errc::expected_value, *this);
            if (!more_)
            {
                ec = json_errc::expected_value;
                return;
            }
            break;
        }
    }

    void append_second_codepoint(int c, std::error_code& ec)
    {
        switch (c)
        {
        case '0': 
        case '1':case '2':case '3':case '4':case '5':case '6':case '7':case '8': case '9':
        case 'a':case 'b':case 'c':case 'd':case 'e':case 'f':
        case 'A':case 'B':case 'C':case 'D':case 'E':case 'F':
            cp2_ = append_to_codepoint(cp2_, c, ec);
            if (ec) return;
            break;
        default:
            more_ = err_handler_(json_errc::expected_value, *this);
            if (!more_)
            {
                ec = json_errc::expected_value;
                return;
            }
            break;
        }
    }

    void end_string_value(const CharT* s, std::size_t length, basic_json_visitor<CharT>& visitor, std::error_code& ec) 
    {
        string_view_type sv(s, length);
        auto result = unicons::validate(s,s+length);
        if (result.ec != unicons::conv_errc())
        {
            translate_conv_errc(result.ec,ec);
            column_ += (result.it - s);
            return;
        }
        switch (parent())
        {
        case json_parse_state::member_name:
            more_ = visitor.key(sv, *this, ec);
            state_ = pop_state();
            state_ = json_parse_state::expect_colon;
            break;
        case json_parse_state::object:
        case json_parse_state::array:
        {
            auto it = std::find_if(string_double_map_.begin(), string_double_map_.end(), string_maps_to_double{ sv });
            if (it != string_double_map_.end())
            {
                more_ = visitor.double_value(it->second, semantic_tag::none, *this, ec);
            }
            else
            {
                more_ = visitor.string_value(sv, semantic_tag::none, *this, ec);
            }
            state_ = json_parse_state::expect_comma_or_end;
            break;
        }
        case json_parse_state::root:
        {
            auto it = std::find_if(string_double_map_.begin(),string_double_map_.end(),string_maps_to_double{sv});
            if (it != string_double_map_.end())
            {
                more_ = visitor.double_value(it->second, semantic_tag::none, *this, ec);
            }
            else
            {
                more_ = visitor.string_value(sv, semantic_tag::none, *this, ec);
            }
            state_ = json_parse_state::before_done;
            break;
        }
        default:
            more_ = err_handler_(json_errc::invalid_json_text, *this);
            if (!more_)
            {
                ec = json_errc::invalid_json_text;
                return;
            }
            break;
        }
    }

    void begin_member_or_element(std::error_code& ec) 
    {
        switch (parent())
        {
        case json_parse_state::object:
            state_ = json_parse_state::expect_member_name;
            break;
        case json_parse_state::array:
            state_ = json_parse_state::expect_value;
            break;
        case json_parse_state::root:
            break;
        default:
            more_ = err_handler_(json_errc::invalid_json_text, *this);
            if (!more_)
            {
                ec = json_errc::invalid_json_text;
                return;
            }
            break;
        }
    }

    void after_value(std::error_code& ec) 
    {
        switch (parent())
        {
        case json_parse_state::array:
        case json_parse_state::object:
            state_ = json_parse_state::expect_comma_or_end;
            break;
        case json_parse_state::root:
            state_ = json_parse_state::before_done;
            break;
        default:
            more_ = err_handler_(json_errc::invalid_json_text, *this);
            if (!more_)
            {
                ec = json_errc::invalid_json_text;
                return;
            }
            break;
        }
    }

    void push_state(json_parse_state state)
    {
        state_stack_.push_back(state);
    }

    json_parse_state pop_state()
    {
        JSONCONS_ASSERT(!state_stack_.empty())
        json_parse_state state = state_stack_.back();
        state_stack_.pop_back();
        return state;
    }
 
    uint32_t append_to_codepoint(uint32_t cp, int c, std::error_code& ec)
    {
        cp *= 16;
        if (c >= '0'  &&  c <= '9')
        {
            cp += c - '0';
        }
        else if (c >= 'a'  &&  c <= 'f')
        {
            cp += c - 'a' + 10;
        }
        else if (c >= 'A'  &&  c <= 'F')
        {
            cp += c - 'A' + 10;
        }
        else
        {
            more_ = err_handler_(json_errc::invalid_hex_escape_sequence, *this);
            if (!more_)
            {
                ec = json_errc::invalid_hex_escape_sequence;
                return cp;
            }
        }
        return cp;
    }
};

using json_parser = basic_json_parser<char>;
using wjson_parser = basic_json_parser<wchar_t>;

}

#endif

