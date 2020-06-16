// Copyright 2017 Daniel Parker
// Distributed under the Boost license, Version 1.0.
// (See accompanying file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

// See https://github.com/danielaparker/jsoncons for latest version

#ifndef JSONCONS_SER_TRAITS_HPP
#define JSONCONS_SER_TRAITS_HPP

#include <string>
#include <tuple>
#include <array>
#include <memory>
#include <type_traits> // std::enable_if, std::true_type, std::false_type
#include <jsoncons/json_visitor.hpp>
#include <jsoncons/json_decoder.hpp>
#include <jsoncons/json_options.hpp>
#include <jsoncons/json_encoder.hpp>
#include <jsoncons/json_type_traits.hpp>
#include <jsoncons/convert_error.hpp>

namespace jsoncons {

    // ser_traits

    template <class T, class CharT, class Enable = void>
    struct ser_traits
    {
        template <class Json>
        static void serialize(const T& val, 
                              basic_json_visitor<CharT>& encoder,
                              const Json& context_j, 
                              std::error_code& ec)
        {
            serialize(std::integral_constant<bool, jsoncons::detail::is_stateless<typename Json::allocator_type>::value>(),
                      val, encoder, context_j, ec);
        }
    private:
        template <class Json>
        static void serialize(std::true_type,
                              const T& val, 
                              basic_json_visitor<CharT>& encoder,
                              const Json& /*context_j*/, 
                              std::error_code& ec)
        {
            auto j = json_type_traits<Json,T>::to_json(val);
            j.dump(encoder, ec);
        }
        template <class Json>
        static void serialize(std::false_type, 
                              const T& val, 
                              basic_json_visitor<CharT>& encoder,
                              const Json& context_j, 
                              std::error_code& ec)
        {
            auto j = json_type_traits<Json,T>::to_json(val, context_j.get_allocator());
            j.dump(encoder, ec);
        }
    };

    // specializations

    // bool
    template <class T, class CharT>
    struct ser_traits<T,CharT,
        typename std::enable_if<detail::is_bool<T>::value 
    >::type>
    {
        template <class Json>
        static void serialize(const T& val, 
                              basic_json_visitor<CharT>& encoder, 
                              const Json&, 
                              std::error_code& ec)
        {
            encoder.bool_value(val,semantic_tag::none,ser_context(),ec);
        }
    };

    // uint
    template <class T, class CharT>
    struct ser_traits<T,CharT,
        typename std::enable_if<detail::is_u8_u16_u32_or_u64<T>::value 
    >::type>
    {
        template <class Json>
        static void serialize(const T& val, 
                              basic_json_visitor<CharT>& encoder, 
                              const Json&, 
                              std::error_code& ec)
        {
            encoder.uint64_value(val,semantic_tag::none,ser_context(),ec);
        }
    };

    // int
    template <class T, class CharT>
    struct ser_traits<T,CharT,
        typename std::enable_if<detail::is_i8_i16_i32_or_i64<T>::value 
    >::type>
    {
        template <class Json>
        static void serialize(const T& val, 
                              basic_json_visitor<CharT>& encoder, 
                              const Json&, 
                              std::error_code& ec)
        {
            encoder.int64_value(val,semantic_tag::none,ser_context(),ec);
        }
    };

    // float or double
    template <class T, class CharT>
    struct ser_traits<T,CharT,
        typename std::enable_if<detail::is_float_or_double<T>::value 
    >::type>
    {
        template <class Json>
        static void serialize(const T& val, 
                              basic_json_visitor<CharT>& encoder, 
                              const Json&, 
                              std::error_code& ec)
        {
            encoder.double_value(val,semantic_tag::none,ser_context(),ec);
        }
    };

    // string
    template <class T, class CharT>
    struct ser_traits<T,CharT,
        typename std::enable_if<detail::is_basic_string<T>::value &&
                                std::is_same<typename T::value_type,CharT>::value 
    >::type>
    {
        template <class Json>
        static void serialize(const T& val, 
                              basic_json_visitor<CharT>& encoder, 
                              const Json&, 
                              std::error_code& ec)
        {
            encoder.string_value(val,semantic_tag::none,ser_context(),ec);
        }
    };
    template <class T, class CharT>
    struct ser_traits<T,CharT,
        typename std::enable_if<detail::is_basic_string<T>::value &&
                                !std::is_same<typename T::value_type,CharT>::value 
    >::type>
    {
        template <class Json>
        static void serialize(const T& val, 
                              basic_json_visitor<CharT>& encoder, 
                              const Json&, 
                              std::error_code& ec)
        {
            std::basic_string<CharT> s;
            unicons::convert(val.begin(), val.end(), std::back_inserter(s));
            encoder.string_value(s,semantic_tag::none,ser_context(),ec);
        }
    };

    // std::pair

    template <class T1, class T2, class CharT>
    struct ser_traits<std::pair<T1, T2>, CharT>
    {
        using value_type = std::pair<T1, T2>;

        template <class Json>
        static void serialize(const value_type& val, 
                              basic_json_visitor<CharT>& encoder, 
                              const Json& context_j, 
                              std::error_code& ec)
        {
            encoder.begin_array(2,semantic_tag::none,ser_context(),ec);
            if (ec) return;
            ser_traits<T1,CharT>::serialize(val.first, encoder, context_j, ec);
            if (ec) return;
            ser_traits<T2,CharT>::serialize(val.second, encoder, context_j, ec);
            if (ec) return;
            encoder.end_array(ser_context(),ec);
        }
    };

    // std::tuple

    namespace detail
    {
        template<size_t Pos, std::size_t Size, class Json, class Tuple>
        struct json_serialize_tuple_helper
        {
            using char_type = typename Json::char_type;
            using element_type = typename std::tuple_element<Size-Pos, Tuple>::type;
            using next = json_serialize_tuple_helper<Pos-1, Size, Json, Tuple>;

            static void serialize(const Tuple& tuple,
                                  basic_json_visitor<char_type>& encoder, 
                                  const Json& context_j, 
                                  std::error_code& ec)
            {
                ser_traits<element_type,char_type>::serialize(std::get<Size-Pos>(tuple), encoder, context_j, ec);
                if (ec) return;
                next::serialize(tuple, encoder, context_j, ec);
            }
        };

        template<size_t Size, class Json, class Tuple>
        struct json_serialize_tuple_helper<0, Size, Json, Tuple>
        {
            using char_type = typename Json::char_type;
            static void serialize(const Tuple&,
                                  basic_json_visitor<char_type>&, 
                                  const Json&, 
                                  std::error_code&)
            {
            }
        };
    } // namespace detail


    template <class CharT, typename... E>
    struct ser_traits<std::tuple<E...>, CharT>
    {
        using value_type = std::tuple<E...>;
        static constexpr std::size_t size = sizeof...(E);

        template <class Json>
        static void serialize(const value_type& val, 
                              basic_json_visitor<CharT>& encoder, 
                              const Json& context_j, 
                              std::error_code& ec)
        {
            using helper = jsoncons::detail::json_serialize_tuple_helper<size, size, Json, std::tuple<E...>>;
            encoder.begin_array(semantic_tag::none,ser_context(),ec);
            if (ec) return;
            helper::serialize(val, encoder, context_j, ec);
            if (ec) return;
            encoder.end_array(ser_context(),ec);
        }
    };

    // vector like
    template <class T, class CharT>
    struct ser_traits<T,CharT,
        typename std::enable_if<!is_json_type_traits_declared<T>::value && 
                 jsoncons::detail::is_list_like<T>::value &&
                 !detail::is_typed_array<T>::value 
    >::type>
    {
        using value_type = typename T::value_type;

        template <class Json>
        static void serialize(const T& val, 
                              basic_json_visitor<CharT>& encoder, 
                              const Json& context_j, 
                              std::error_code& ec)
        {
            encoder.begin_array(val.size(),semantic_tag::none,ser_context(),ec);
            if (ec) return;
            for (auto it = std::begin(val); it != std::end(val); ++it)
            {
                ser_traits<value_type,CharT>::serialize(*it, encoder, context_j, ec);
                if (ec) return;
            }
            encoder.end_array(ser_context(), ec);
        }
    };

    template <class T, class CharT>
    struct ser_traits<T,CharT,
        typename std::enable_if<!is_json_type_traits_declared<T>::value && 
                 jsoncons::detail::is_list_like<T>::value &&
                 jsoncons::detail::is_typed_array<T>::value 
    >::type>
    {
        using value_type = typename T::value_type;

        template <class Json>
        static void serialize(const T& val, 
                              basic_json_visitor<CharT>& encoder, 
                              const Json&,
                              std::error_code& ec)
        {
            encoder.typed_array(span<const value_type>(val), semantic_tag::none, ser_context(), ec);
        }
    };

    // std::array

    template <class T, class CharT, std::size_t N>
    struct ser_traits<std::array<T,N>,CharT>
    {
        using value_type = typename std::array<T,N>::value_type;

        template <class Json>
        static void serialize(const std::array<T, N>& val, 
                           basic_json_visitor<CharT>& encoder, 
                           const Json& context_j, 
                           std::error_code& ec)
        {
            encoder.begin_array(val.size(),semantic_tag::none,ser_context(),ec);
            if (ec) return;
            for (auto it = std::begin(val); it != std::end(val); ++it)
            {
                ser_traits<value_type,CharT>::serialize(*it, encoder, context_j, ec);
                if (ec) return;
            }
            encoder.end_array(ser_context(),ec);
        }
    };

    // map like

    template <class T, class CharT>
    struct ser_traits<T,CharT,
        typename std::enable_if<!is_json_type_traits_declared<T>::value && 
                                jsoncons::detail::is_map_like<T>::value &&
                                jsoncons::detail::is_constructible_from_const_pointer_and_size<typename T::key_type>::value
    >::type>
    {
        using mapped_type = typename T::mapped_type;
        using value_type = typename T::value_type;
        using key_type = typename T::key_type;

        template <class Json>
        static void serialize(const T& val, 
                              basic_json_visitor<CharT>& encoder, 
                              const Json& context_j, 
                              std::error_code& ec)
        {
            encoder.begin_object(val.size(), semantic_tag::none, ser_context(), ec);
            if (ec) return;
            for (auto it = std::begin(val); it != std::end(val); ++it)
            {
                encoder.key(it->first);
                ser_traits<mapped_type,CharT>::serialize(it->second, encoder, context_j, ec);
                if (ec) return;
            }
            encoder.end_object(ser_context(), ec);
            if (ec) return;
        }
    };

    template <class T, class CharT>
    struct ser_traits<T,CharT,
        typename std::enable_if<!is_json_type_traits_declared<T>::value && 
                                jsoncons::detail::is_map_like<T>::value &&
                                std::is_integral<typename T::key_type>::value
    >::type>
    {
        using mapped_type = typename T::mapped_type;
        using value_type = typename T::value_type;
        using key_type = typename T::key_type;

        template <class Json>
        static void serialize(const T& val, 
                              basic_json_visitor<CharT>& encoder, 
                              const Json& context_j, 
                              std::error_code& ec)
        {
            encoder.begin_object(val.size(), semantic_tag::none, ser_context(), ec);
            if (ec) return;
            for (auto it = std::begin(val); it != std::end(val); ++it)
            {
                std::basic_string<typename Json::char_type> s;
                jsoncons::detail::write_integer(it->first,s);
                encoder.key(s);
                ser_traits<mapped_type,CharT>::serialize(it->second, encoder, context_j, ec);
                if (ec) return;
            }
            encoder.end_object(ser_context(), ec);
            if (ec) return;
        }
    };

} // jsoncons

#endif

