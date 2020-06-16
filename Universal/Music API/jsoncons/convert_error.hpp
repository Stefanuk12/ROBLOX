/// Copyright 2019 Daniel Parker
// Distributed under the Boost license, Version 1.0.
// (See accompanying file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

// See https://github.com/danielaparker/jsoncons for latest version

#ifndef JSONCONS_CONVERT_ERROR_HPP
#define JSONCONS_CONVERT_ERROR_HPP

#include <system_error>
#include <jsoncons/config/jsoncons_config.hpp>

namespace jsoncons {

    enum class convert_errc
    {
        success = 0,
        not_utf8,
        not_wide_char,
        not_vector,
        not_array,
        not_map,
        not_pair,
        not_string,
        not_string_view,
        not_byte_string,
        not_byte_string_view,
        not_signed_integer,
        not_unsigned_integer,
        not_double,
        not_bool
    };
}

namespace std {
    template<>
    struct is_error_code_enum<jsoncons::convert_errc> : public true_type
    {
    };
}

namespace jsoncons {

namespace detail {
    class convert_error_category_impl
       : public std::error_category
    {
    public:
        const char* name() const noexcept override
        {
            return "jsoncons/convert";
        }
        std::string message(int ev) const override
        {
            switch (static_cast<convert_errc>(ev))
            {
                case convert_errc::not_utf8:
                    return "Cannot convert string to UTF-8";
                case convert_errc::not_wide_char:
                    return "Cannot convert string to wide characters";
                case convert_errc::not_vector:
                    return "Cannot convert to vector";
                case convert_errc::not_array:
                    return "Cannot convert to std::array";
                case convert_errc::not_map:
                    return "Cannot convert to map";
                case convert_errc::not_pair:
                    return "Cannot convert to std::pair";
                case convert_errc::not_string:
                    return "Cannot convert to string";
                case convert_errc::not_string_view:
                    return "Cannot convert to string_view";
                case convert_errc::not_byte_string:
                    return "Cannot convert to byte_string";
                case convert_errc::not_byte_string_view:
                    return "Cannot convert to byte_string_view";
                case convert_errc::not_signed_integer:
                    return "Cannot convert to signed integer";
                case convert_errc::not_unsigned_integer:
                    return "Cannot convert to unsigned integer";
                case convert_errc::not_double:
                    return "Cannot convert to double";
                case convert_errc::not_bool:
                    return "Cannot convert to bool";
                default:
                    return "Unknown convert error";
            }
        }
    };
} // detail

extern inline
const std::error_category& convert_error_category()
{
  static detail::convert_error_category_impl instance;
  return instance;
}

inline 
std::error_code make_error_code(convert_errc result)
{
    return std::error_code(static_cast<int>(result),convert_error_category());
}

}

#endif
