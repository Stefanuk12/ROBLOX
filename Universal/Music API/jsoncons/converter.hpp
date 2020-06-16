// Copyright 2020 Daniel Parker
// Distributed under the Boost license, Version 1.0.
// (See accompanying file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

// See https://github.com/danielaparker/jsoncons for latest version

#ifndef JSONCONS_CONVERTER_HPP
#define JSONCONS_CONVERTER_HPP

#include <system_error> // std::error_code
#include <jsoncons/detail/more_type_traits.hpp>
#include <jsoncons/byte_string.hpp>
#include <jsoncons/json_type.hpp>
#include <jsoncons/convert_error.hpp>
#include <jsoncons/detail/write_number.hpp> // write_integer

namespace jsoncons {

    template <class Into, class Enable=void>
    class converter
    {
    };

    // Into list like of bytes
    template <class Into>
    class converter<Into,typename std::enable_if<(!jsoncons::detail::is_basic_string<Into>::value && 
                                                   jsoncons::detail::is_back_insertable_byte_container<Into>::value) ||
                                                 jsoncons::detail::is_basic_byte_string<Into>::value>::type>
    {
        using value_type = typename Into::value_type;
        using allocator_type = typename Into::allocator_type;
        allocator_type alloc_;

    public:

        explicit converter(const allocator_type& alloc = allocator_type())
            : alloc_(alloc)
        {
        }

        JSONCONS_CPP14_CONSTEXPR 
        Into from(const byte_string_view& bstr, semantic_tag, std::error_code&) const
        {
            Into bytes(alloc_);
            for (auto ch : bstr)
            {
                bytes.push_back(static_cast<value_type>(ch));
            }

            return bytes;
        }

        template <class CharT>
        JSONCONS_CPP14_CONSTEXPR 
        typename std::enable_if<detail::is_narrow_character<CharT>::value,Into>::type
        from(const jsoncons::basic_string_view<CharT>& s, semantic_tag tag, std::error_code& ec) const
        {
            switch (tag)
            {
                case semantic_tag::base16:
                {
                    Into bytes(alloc_);
                    decode_base16(s.begin(), s.end(), bytes);
                    return bytes;
                }
                case semantic_tag::base64:
                {
                    Into bytes(alloc_);
                    decode_base64(s.begin(), s.end(), bytes);
                    return bytes;
                }
                case semantic_tag::base64url:
                {
                    Into bytes(alloc_);
                    decode_base64url(s.begin(), s.end(), bytes);
                    return bytes;
                }
                default:
                {
                    ec = convert_errc::not_byte_string;
                    return Into(alloc_);
                }
            }
        }

        template <class CharT>
        JSONCONS_CPP14_CONSTEXPR 
        typename std::enable_if<detail::is_wide_character<CharT>::value, Into>::type
        from(const jsoncons::basic_string_view<CharT>& s, semantic_tag tag, std::error_code& ec) const
        {
            std::string u;
            auto retval = unicons::convert(s.begin(), s.end(), std::back_inserter(u));
            if (retval.ec != unicons::conv_errc())
            {
                ec = convert_errc::not_utf8;
                return Into(alloc_);
            }
            return from(jsoncons::string_view(u), tag, ec);
        }
    };

    // Into string
    template <class Into>
    class converter<Into,typename std::enable_if<detail::is_basic_string<Into>::value>::type>
    {
        using char_type = typename Into::value_type;
        using allocator_type = typename Into::allocator_type;

        allocator_type alloc_;
    public:

        explicit converter(const allocator_type& alloc = allocator_type())
            : alloc_(alloc)
        {
        }

        template<class Integer>
        JSONCONS_CPP14_CONSTEXPR 
        typename std::enable_if<detail::is_integer<Integer>::value,Into>::type
        from(Integer val, semantic_tag, std::error_code&) const
        {
            Into s(alloc_);
            jsoncons::detail::write_integer(val, s);
            return s;
        }

        JSONCONS_CPP14_CONSTEXPR 
        Into from(double val, semantic_tag, std::error_code&) const
        {
            Into s(alloc_);
            jsoncons::detail::write_double f{float_chars_format::general,0};
            f(val, s);
            return s;
        }

        JSONCONS_CPP14_CONSTEXPR 
        Into from(half_arg_t, uint16_t val, semantic_tag, std::error_code&) const
        {
            Into s(alloc_);
            jsoncons::detail::write_double f{float_chars_format::general,0};
            double x = jsoncons::detail::decode_half(val);
            f(x, s);
            return s;
        }

        template <class ChT = char_type>
        JSONCONS_CPP14_CONSTEXPR
        typename std::enable_if<sizeof(ChT) == sizeof(uint8_t),Into>::type
        from(const byte_string_view& bytes, 
                  semantic_tag tag,
                  std::error_code&) const
        {
            Into s(alloc_);
            switch (tag)
            {
                case semantic_tag::base64:
                    encode_base64(bytes.begin(), bytes.end(), s);
                    break;
                case semantic_tag::base16:
                    encode_base16(bytes.begin(), bytes.end(), s);
                    break;
                default:
                    encode_base64url(bytes.begin(), bytes.end(), s);
                    break;
            }
            return s;
        }

        template <class ChT = char_type>
        JSONCONS_CPP14_CONSTEXPR
        typename std::enable_if<sizeof(ChT) != sizeof(uint8_t),Into>::type
        from(const byte_string_view& bytes, semantic_tag tag, std::error_code& ec) const
        {
            converter<std::string> convert(alloc_);
            std::string u = convert.from(bytes, tag, ec);

            Into s(alloc_);
            auto retval = unicons::convert(u.begin(), u.end(), std::back_inserter(s));
            if (retval.ec != unicons::conv_errc())
            {
                ec = convert_errc::not_wide_char;
                return s;
            }

            return s;
        }

        constexpr 
        Into from(const jsoncons::basic_string_view<char_type>& s, 
                  semantic_tag,
                  std::error_code&) const
        {
            return Into(s.data(), s.size(), alloc_);
        }

        JSONCONS_CPP14_CONSTEXPR 
        Into from(bool val, semantic_tag, std::error_code&) const
        {
            constexpr char_type true_literal[] = {'t','r','u','e'}; 
            constexpr char_type false_literal[] = {'f','a','l','s','e'}; 

            return val ? Into(true_literal,4,alloc_) : Into(false_literal,5,alloc_);
        }

        JSONCONS_CPP14_CONSTEXPR 
        Into from(null_type, semantic_tag, std::error_code&) const
        {
            constexpr char_type null_literal[] = {'n','u','l','l'}; 

            return Into(null_literal,4,alloc_);
        }
    };

} // namespace jsoncons

#endif

