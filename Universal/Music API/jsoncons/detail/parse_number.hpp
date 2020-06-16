// Copyright 2013 Daniel Parker
// Distributed under the Boost license, Version 1.0.
// (See accompanying file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

// See https://github.com/danielaparker/jsoncons for latest version

#ifndef JSONCONS_DETAIL_PARSE_NUMBER_HPP
#define JSONCONS_DETAIL_PARSE_NUMBER_HPP

#include <system_error>
#include <stdexcept>
#include <string>
#include <vector>
#include <locale>
#include <limits> // std::numeric_limits
#include <type_traits> // std::enable_if
#include <exception>
#include <jsoncons/config/jsoncons_config.hpp>
#include <cctype>

namespace jsoncons { namespace detail {

    enum class to_integer_errc : uint8_t {success=0,overflow,invalid_digit,invalid_number};

    class to_integer_error_category_impl
       : public std::error_category
    {
    public:
        const char* name() const noexcept override
        {
            return "jsoncons/to_integer_unchecked";
        }
        std::string message(int ev) const override
        {
            switch (static_cast<to_integer_errc>(ev))
            {
                case to_integer_errc::overflow:
                    return "Integer overflow";
                case to_integer_errc::invalid_digit:
                    return "Invalid digit";
                default:
                    return "Unknown to_integer_unchecked error";
            }
        }
    };

    inline
    const std::error_category& to_integer_error_category()
    {
      static to_integer_error_category_impl instance;
      return instance;
    }

    inline 
    std::error_code make_error_code(to_integer_errc e)
    {
        return std::error_code(static_cast<int>(e),to_integer_error_category());
    }

} // namespace detail
} // namespace jsoncons

namespace std {
    template<>
    struct is_error_code_enum<jsoncons::detail::to_integer_errc> : public true_type
    {
    };
}

namespace jsoncons { namespace detail {

template <class T>
class to_integer_result
{
    T value_;
    to_integer_errc ec;
public:
    constexpr to_integer_result(T value_)
        : value_(value_), ec(to_integer_errc::success)
    {
    }
    constexpr to_integer_result(to_integer_errc ec)
        : value_(), ec(ec)
    {
    }

    to_integer_result(const to_integer_result&) = default;

    to_integer_result& operator=(const to_integer_result&) = default;

    constexpr explicit operator bool() const noexcept
    {
        return ec == to_integer_errc::success;
    }

    T value() const
    {
        return value_;
    }

    std::error_code error_code() const
    {
        return make_error_code(ec);
    }

    to_integer_errc errc() const
    {
        return ec;
    }
};

enum class integer_chars_format : uint8_t {decimal=1,hex};
enum class integer_chars_state {initial,minus,integer,binary,octal,decimal,hex};

template <class CharT>
bool is_base10(const CharT* s, std::size_t length)
{
    integer_chars_state state = integer_chars_state::initial;

    const CharT* end = s + length; 
    for (;s < end; ++s)
    {
        switch(state)
        {
            case integer_chars_state::initial:
            {
                switch(*s)
                {
                    case '0':case '1':case '2':case '3':case '4':case '5':case '6':case '7':case '8': case '9':
                        state = integer_chars_state::decimal;
                        break;
                    case '-':
                        state = integer_chars_state::minus;
                        break;
                    default:
                        return false;
                }
                break;
            }
            case integer_chars_state::minus:
            {
                switch(*s)
                {
                    case '0':case '1':case '2':case '3':case '4':case '5':case '6':case '7':case '8': case '9':
                        state = integer_chars_state::decimal;
                        break;
                    default:
                        return false;
                }
                break;
            }
            case integer_chars_state::decimal:
            {
                switch(*s)
                {
                    case '0':case '1':case '2':case '3':case '4':case '5':case '6':case '7':case '8': case '9':
                        break;
                    default:
                        return false;
                }
                break;
            }
            default:
                break;
        }
    }
    return state == integer_chars_state::decimal ? true : false;
}

template <class T, class CharT>
typename std::enable_if<std::is_integral<T>::value && !std::is_signed<T>::value,to_integer_result<T>>::type
to_integer_decimal(const CharT* s, std::size_t length)
{
    integer_chars_state state = integer_chars_state::initial;
    T n = 0;

    const CharT* end = s + length; 
    while (s < end)
    {
        switch(state)
        {
            case integer_chars_state::initial:
            {
                switch(*s)
                {
                    case '0':
                        return (++s == end) ? to_integer_result<T>(0) : to_integer_result<T>(to_integer_errc::invalid_digit);
                    case '1':case '2':case '3':case '4':case '5':case '6':case '7':case '8': case '9': // Must be decimal
                        state = integer_chars_state::decimal;
                        break;
                    default:
                        return to_integer_result<T>(to_integer_errc::invalid_digit);
                }
                break;
            }
            case integer_chars_state::decimal:
            {
                static constexpr T max_value = (std::numeric_limits<T>::max)();
                static constexpr T max_value_div_10 = max_value / 10;
                for (; s < end; ++s)
                {
                    T x = 0;
                    switch(*s)
                    {
                        case '0':case '1':case '2':case '3':case '4':case '5':case '6':case '7':case '8': case '9':
                            x = static_cast<T>(*s) - static_cast<T>('0');
                            break;
                        default:
                            return to_integer_result<T>(to_integer_errc::invalid_digit);
                    }
                    if (n > max_value_div_10)
                    {
                        return to_integer_result<T>(to_integer_errc::overflow);
                    }
                    n = n * 10;
                    if (n > max_value - x)
                    {
                        return to_integer_result<T>(to_integer_errc::overflow);
                    }
                    n += x;
                }
                break;
            }
            default:
                JSONCONS_UNREACHABLE();
                break;
        }
    }
    return (state == integer_chars_state::initial) ? to_integer_result<T>(to_integer_errc::invalid_number) : to_integer_result<T>(n);
}

template <class T, class CharT>
typename std::enable_if<std::is_integral<T>::value && std::is_signed<T>::value,to_integer_result<T>>::type
to_integer_decimal(const CharT* s, std::size_t length)
{
    if (length == 0)
    {
        return to_integer_result<T>(to_integer_errc::invalid_number);
    }

    bool is_negative = *s == '-' ? true : false;
    if (is_negative)
    {
        ++s;
        --length;
    }

    using U = typename std::make_unsigned<T>::type;

    auto u = to_integer_decimal<U>(s, length);
    if (!u)
    {
        return to_integer_result<T>(u.errc());
    }
    if (is_negative)
    {
        if (u.value() > static_cast<U>(-((std::numeric_limits<T>::min)()+T(1))) + U(1))
        {
            return to_integer_result<T>(to_integer_errc::overflow);
        }
        else
        {
            return to_integer_result<T>(static_cast<T>(U(0) - u.value()));
        }
    }
    else
    {
        if (u.value() > static_cast<U>((std::numeric_limits<T>::max)()))
        {
            return to_integer_result<T>(to_integer_errc::overflow);
        }
        else
        {
            return to_integer_result<T>(static_cast<T>(u.value()));
        }
    }
}

template <class T, class CharT>
typename std::enable_if<std::is_integral<T>::value && !std::is_signed<T>::value,to_integer_result<T>>::type
to_integer(const CharT* s, std::size_t length)
{
    integer_chars_state state = integer_chars_state::initial;
    T n = 0;

    const CharT* end = s + length; 
    while (s < end)
    {
        switch(state)
        {
            case integer_chars_state::initial:
            {
                switch(*s)
                {
                    case '0':
                        state = integer_chars_state::integer; // Could be binary, octal, hex 
                        ++s;
                        break;
                    case '1':case '2':case '3':case '4':case '5':case '6':case '7':case '8': case '9': // Must be decimal
                        state = integer_chars_state::decimal;
                        break;
                    default:
                        return to_integer_result<T>(to_integer_errc::invalid_digit);
                }
                break;
            }
            case integer_chars_state::integer:
            {
                switch(*s)
                {
                    case 'b':case 'B':
                    {
                        state = integer_chars_state::binary;
                        ++s;
                        break;
                    }
                    case 'x':case 'X':
                    {
                        state = integer_chars_state::hex;
                        ++s;
                        break;
                    }
                    case '0':case '1':case '2':case '3':case '4':case '5':case '6':case '7':case '8': case '9':
                    {
                        state = integer_chars_state::octal;
                        break;
                    }
                    default:
                        return to_integer_result<T>(to_integer_errc::invalid_digit);
                }
                break;
            }
            case integer_chars_state::binary:
            {
                static constexpr T max_value = (std::numeric_limits<T>::max)();
                static constexpr T max_value_div_2 = max_value / 2;
                for (; s < end; ++s)
                {
                    T x = 0;
                    switch(*s)
                    {
                        case '0':case '1':
                            x = static_cast<T>(*s) - static_cast<T>('0');
                            break;
                        default:
                            return to_integer_result<T>(to_integer_errc::invalid_digit);
                    }
                    if (n > max_value_div_2)
                    {
                        return to_integer_result<T>(to_integer_errc::overflow);
                    }
                    n = n * 2;
                    if (n > max_value - x)
                    {
                        return to_integer_result<T>(to_integer_errc::overflow);
                    }
                    n += x;
                }
                break;
            }
            case integer_chars_state::octal:
            {
                static constexpr T max_value = (std::numeric_limits<T>::max)();
                static constexpr T max_value_div_8 = max_value / 8;
                for (; s < end; ++s)
                {
                    T x = 0;
                    switch(*s)
                    {
                        case '0':case '1':case '2':case '3':case '4':case '5':case '6':case '7':
                            x = static_cast<T>(*s) - static_cast<T>('0');
                            break;
                        default:
                            return to_integer_result<T>(to_integer_errc::invalid_digit);
                    }
                    if (n > max_value_div_8)
                    {
                        return to_integer_result<T>(to_integer_errc::overflow);
                    }
                    n = n * 8;
                    if (n > max_value - x)
                    {
                        return to_integer_result<T>(to_integer_errc::overflow);
                    }
                    n += x;
                }
                break;
            }
            case integer_chars_state::decimal:
            {
                static constexpr T max_value = (std::numeric_limits<T>::max)();
                static constexpr T max_value_div_10 = max_value / 10;
                for (; s < end; ++s)
                {
                    T x = 0;
                    switch(*s)
                    {
                        case '0':case '1':case '2':case '3':case '4':case '5':case '6':case '7':case '8': case '9':
                            x = static_cast<T>(*s) - static_cast<T>('0');
                            break;
                        default:
                            return to_integer_result<T>(to_integer_errc::invalid_digit);
                    }
                    if (n > max_value_div_10)
                    {
                        return to_integer_result<T>(to_integer_errc::overflow);
                    }
                    n = n * 10;
                    if (n > max_value - x)
                    {
                        return to_integer_result<T>(to_integer_errc::overflow);
                    }
                    n += x;
                }
                break;
            }
            case integer_chars_state::hex:
            {
                static constexpr T max_value = (std::numeric_limits<T>::max)();
                static constexpr T max_value_div_16 = max_value / 16;
                for (; s < end; ++s)
                {
                    CharT c = *s;
                    T x = 0;
                    switch (c)
                    {
                        case '0':case '1':case '2':case '3':case '4':case '5':case '6':case '7':case '8': case '9':
                            x = c - '0';
                            break;
                        case 'a':case 'b':case 'c':case 'd':case 'e':case 'f':
                            x = c - ('a' - 10);
                            break;
                        case 'A':case 'B':case 'C':case 'D':case 'E':case 'F':
                            x = c - ('A' - 10);
                            break;
                        default:
                            return to_integer_result<T>(to_integer_errc::invalid_digit);
                    }
                    if (n > max_value_div_16)
                    {
                        return to_integer_result<T>(to_integer_errc::overflow);
                    }
                    n = n * 16;
                    if (n > max_value - x)
                    {
                        return to_integer_result<T>(to_integer_errc::overflow);
                    }

                    n += x;
                }
                break;
            }
            default:
                JSONCONS_UNREACHABLE();
                break;
        }
    }
    return (state == integer_chars_state::initial) ? to_integer_result<T>(to_integer_errc::invalid_number) : to_integer_result<T>(n);
}

template <class T, class CharT>
typename std::enable_if<std::is_integral<T>::value && std::is_signed<T>::value,to_integer_result<T>>::type
to_integer(const CharT* s, std::size_t length)
{
    if (length == 0)
    {
        return to_integer_result<T>(to_integer_errc::invalid_number);
    }

    bool is_negative = *s == '-' ? true : false;
    if (is_negative)
    {
        ++s;
        --length;
    }

    using U = typename std::make_unsigned<T>::type;

    auto u = to_integer<U>(s, length);
    if (!u)
    {
        return to_integer_result<T>(u.errc());
    }
    if (is_negative)
    {
        if (u.value() > static_cast<U>(-((std::numeric_limits<T>::min)()+T(1))) + U(1))
        {
            return to_integer_result<T>(to_integer_errc::overflow);
        }
        else
        {
            return to_integer_result<T>(static_cast<T>(U(0) - u.value()));
        }
    }
    else
    {
        if (u.value() > static_cast<U>((std::numeric_limits<T>::max)()))
        {
            return to_integer_result<T>(to_integer_errc::overflow);
        }
        else
        {
            return to_integer_result<T>(static_cast<T>(u.value()));
        }
    }
}

// Precondition: s satisfies

// digit
// digit1-digits 
// - digit
// - digit1-digits

template <class T, class CharT>
typename std::enable_if<std::is_integral<T>::value && !std::is_signed<T>::value,to_integer_result<T>>::type
to_integer_unchecked(const CharT* s, std::size_t length)
{
    static_assert(std::numeric_limits<T>::is_specialized, "Integer type not specialized");
    JSONCONS_ASSERT(length > 0);

    T n = 0;
    const CharT* end = s + length; 
    if (*s == '-')
    {
        static constexpr T min_value = (std::numeric_limits<T>::lowest)();
        static constexpr T min_value_div_10 = min_value / 10;
        ++s;
        for (; s < end; ++s)
        {
            T x = (T)*s - (T)('0');
            if (n < min_value_div_10)
            {
                return to_integer_result<T>(to_integer_errc::overflow);
            }
            n = n * 10;
            if (n < min_value + x)
            {
                return to_integer_result<T>(to_integer_errc::overflow);
            }

            n -= x;
        }
    }
    else
    {
        static constexpr T max_value = (std::numeric_limits<T>::max)();
        static constexpr T max_value_div_10 = max_value / 10;
        for (; s < end; ++s)
        {
            T x = static_cast<T>(*s) - static_cast<T>('0');
            if (n > max_value_div_10)
            {
                return to_integer_result<T>(to_integer_errc::overflow);
            }
            n = n * 10;
            if (n > max_value - x)
            {
                return to_integer_result<T>(to_integer_errc::overflow);
            }

            n += x;
        }
    }

    return to_integer_result<T>(n);
}

// Precondition: s satisfies

// digit
// digit1-digits 
// - digit
// - digit1-digits

template <class T, class CharT>
typename std::enable_if<std::is_integral<T>::value && std::is_signed<T>::value,to_integer_result<T>>::type
to_integer_unchecked(const CharT* s, std::size_t length)
{
    static_assert(std::numeric_limits<T>::is_specialized, "Integer type not specialized");
    JSONCONS_ASSERT(length > 0);

    T n = 0;
    const CharT* end = s + length; 
    if (*s == '-')
    {
        static constexpr T min_value = (std::numeric_limits<T>::lowest)();
        static constexpr T min_value_div_10 = min_value / 10;
        ++s;
        for (; s < end; ++s)
        {
            T x = (T)*s - (T)('0');
            if (n < min_value_div_10)
            {
                return to_integer_result<T>(to_integer_errc::overflow);
            }
            n = n * 10;
            if (n < min_value + x)
            {
                return to_integer_result<T>(to_integer_errc::overflow);
            }

            n -= x;
        }
    }
    else
    {
        static constexpr T max_value = (std::numeric_limits<T>::max)();
        static constexpr T max_value_div_10 = max_value / 10;
        for (; s < end; ++s)
        {
            T x = static_cast<T>(*s) - static_cast<T>('0');
            if (n > max_value_div_10)
            {
                return to_integer_result<T>(to_integer_errc::overflow);
            }
            n = n * 10;
            if (n > max_value - x)
            {
                return to_integer_result<T>(to_integer_errc::overflow);
            }

            n += x;
        }
    }

    return to_integer_result<T>(n);
}

// base16_to_integer

template <class T, class CharT>
typename std::enable_if<std::is_integral<T>::value && std::is_signed<T>::value,to_integer_result<T>>::type
base16_to_integer(const CharT* s, std::size_t length)
{
    static_assert(std::numeric_limits<T>::is_specialized, "Integer type not specialized");
    JSONCONS_ASSERT(length > 0);

    T n = 0;
    const CharT* end = s + length; 
    if (*s == '-')
    {
        static constexpr T min_value = (std::numeric_limits<T>::lowest)();
        static constexpr T min_value_div_16 = min_value / 16;
        ++s;
        for (; s < end; ++s)
        {
            CharT c = *s;
            T x = 0;
            switch (c)
            {
                case '0':case '1':case '2':case '3':case '4':case '5':case '6':case '7':case '8': case '9':
                    x = c - '0';
                    break;
                case 'a':case 'b':case 'c':case 'd':case 'e':case 'f':
                    x = c - ('a' - 10);
                    break;
                case 'A':case 'B':case 'C':case 'D':case 'E':case 'F':
                    x = c - ('A' - 10);
                    break;
                default:
                    return to_integer_result<T>(to_integer_errc::invalid_digit);
            }
            if (n < min_value_div_16)
            {
                return to_integer_result<T>(to_integer_errc::overflow);
            }
            n = n * 16;
            if (n < min_value + x)
            {
                return to_integer_result<T>(to_integer_errc::overflow);
            }
            n -= x;
        }
    }
    else
    {
        static constexpr T max_value = (std::numeric_limits<T>::max)();
        static constexpr T max_value_div_16 = max_value / 16;
        for (; s < end; ++s)
        {
            CharT c = *s;
            T x = 0;
            switch (c)
            {
                case '0':case '1':case '2':case '3':case '4':case '5':case '6':case '7':case '8': case '9':
                    x = c - '0';
                    break;
                case 'a':case 'b':case 'c':case 'd':case 'e':case 'f':
                    x = c - ('a' - 10);
                    break;
                case 'A':case 'B':case 'C':case 'D':case 'E':case 'F':
                    x = c - ('A' - 10);
                    break;
                default:
                    return to_integer_result<T>(to_integer_errc::invalid_digit);
            }
            if (n > max_value_div_16)
            {
                return to_integer_result<T>(to_integer_errc::overflow);
            }
            n = n * 16;
            if (n > max_value - x)
            {
                return to_integer_result<T>(to_integer_errc::overflow);
            }

            n += x;
        }
    }

    return to_integer_result<T>(n);
}

template <class T, class CharT>
typename std::enable_if<std::is_integral<T>::value && !std::is_signed<T>::value,to_integer_result<T>>::type
base16_to_integer(const CharT* s, std::size_t length)
{
    static_assert(std::numeric_limits<T>::is_specialized, "Integer type not specialized");
    JSONCONS_ASSERT(length > 0);

    T n = 0;
    const CharT* end = s + length; 

    static constexpr T max_value = (std::numeric_limits<T>::max)();
    static constexpr T max_value_div_16 = max_value / 16;
    for (; s < end; ++s)
    {
        CharT c = *s;
        T x = *s;
        switch (c)
        {
            case '0':case '1':case '2':case '3':case '4':case '5':case '6':case '7':case '8': case '9':
                x = c - '0';
                break;
            case 'a':case 'b':case 'c':case 'd':case 'e':case 'f':
                x = c - ('a' - 10);
                break;
            case 'A':case 'B':case 'C':case 'D':case 'E':case 'F':
                x = c - ('A' - 10);
                break;
            default:
                return to_integer_result<T>(to_integer_errc::invalid_digit);
        }
        if (n > max_value_div_16)
        {
            return to_integer_result<T>(to_integer_errc::overflow);
        }
        n = n * 16;
        if (n > max_value - x)
        {
            return to_integer_result<T>(to_integer_errc::overflow);
        }

        n += x;
    }

    return to_integer_result<T>(n);
}

#if defined(JSONCONS_HAS_MSC__STRTOD_L)

class to_double_t
{
private:
    _locale_t locale_;
public:
    to_double_t()
    {
        locale_ = _create_locale(LC_NUMERIC, "C");
    }
    ~to_double_t() noexcept
    {
        _free_locale(locale_);
    }

    to_double_t(const to_double_t&)
    {
        locale_ = _create_locale(LC_NUMERIC, "C");
    }

    to_double_t& operator=(const to_double_t&) 
    {
        // Don't assign locale
        return *this;
    }

    char get_decimal_point() const
    {
        return '.';
    }

    template <class CharT>
    typename std::enable_if<std::is_same<CharT,char>::value,double>::type
    operator()(const CharT* s, std::size_t) const
    {
        CharT *end = nullptr;
        double val = _strtod_l(s, &end, locale_);
        if (s == end)
        {
            JSONCONS_THROW(json_runtime_error<std::invalid_argument>("Convert string to double failed"));
        }
        return val;
    }

    template <class CharT>
    typename std::enable_if<std::is_same<CharT,wchar_t>::value,double>::type
    operator()(const CharT* s, std::size_t) const
    {
        CharT *end = nullptr;
        double val = _wcstod_l(s, &end, locale_);
        if (s == end)
        {
            JSONCONS_THROW(json_runtime_error<std::invalid_argument>("Convert string to double failed"));
        }
        return val;
    }
};

#elif defined(JSONCONS_HAS_STRTOLD_L)

class to_double_t
{
private:
    locale_t locale_;
public:
    to_double_t()
    {
        locale_ = newlocale(LC_ALL_MASK, "C", (locale_t) 0);
    }
    ~to_double_t() noexcept
    {
        freelocale(locale_);
    }

    to_double_t(const to_double_t&)
    {
        locale_ = newlocale(LC_ALL_MASK, "C", (locale_t) 0);
    }

    to_double_t& operator=(const to_double_t&) 
    {
        return *this;
    }

    char get_decimal_point() const
    {
        return '.';
    }

    template <class CharT>
    typename std::enable_if<std::is_same<CharT,char>::value,double>::type
    operator()(const CharT* s, std::size_t length) const
    {
        char *end = nullptr;
        double val = strtold_l(s, &end, locale_);
        if (s == end)
        {
            JSONCONS_THROW(json_runtime_error<std::invalid_argument>("Convert string to double failed"));
        }
        return val;
    }

    template <class CharT>
    typename std::enable_if<std::is_same<CharT,wchar_t>::value,double>::type
    operator()(const CharT* s, std::size_t length) const
    {
        CharT *end = nullptr;
        double val = wcstold_l(s, &end, locale_);
        if (s == end)
        {
            JSONCONS_THROW(json_runtime_error<std::invalid_argument>("Convert string to double failed"));
        }
        return val;
    }
};

#else
class to_double_t
{
private:
    std::vector<char> buffer_;
    char decimal_point_;
public:
    to_double_t()
        : buffer_()
    {
        struct lconv * lc = localeconv();
        if (lc != nullptr && lc->decimal_point[0] != 0)
        {
            decimal_point_ = lc->decimal_point[0];    
        }
        else
        {
            decimal_point_ = '.'; 
        }
        buffer_.reserve(100);
    }

    to_double_t(const to_double_t&) = default;
    to_double_t& operator=(const to_double_t&) = default;

    char get_decimal_point() const
    {
        return decimal_point_;
    }

    template <class CharT>
    typename std::enable_if<std::is_same<CharT,char>::value,double>::type
    operator()(const CharT* s, std::size_t /*length*/) const
    {
        CharT *end = nullptr;
        double val = strtod(s, &end);
        if (s == end)
        {
            JSONCONS_THROW(json_runtime_error<std::invalid_argument>("Convert string to double failed"));
        }
        return val;
    }

    template <class CharT>
    typename std::enable_if<std::is_same<CharT,wchar_t>::value,double>::type
    operator()(const CharT* s, std::size_t /*length*/) const
    {
        CharT *end = nullptr;
        double val = wcstod(s, &end);
        if (s == end)
        {
            JSONCONS_THROW(json_runtime_error<std::invalid_argument>("Convert string to double failed"));
        }
        return val;
    }
};
#endif

}}

#endif
