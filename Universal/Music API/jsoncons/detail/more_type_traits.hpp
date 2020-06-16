// Copyright 2013 Daniel Parker
// Distributed under the Boost license, Version 1.0.
// (See accompanying file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

// See https://github.com/danielaparker/jsoncons for latest version

#ifndef JSONCONS_DETAIL_MORE_TYPE_TRAITS_HPP
#define JSONCONS_DETAIL_MORE_TYPE_TRAITS_HPP

#include <stdexcept>
#include <string>
#include <cmath>
#include <type_traits> // std::enable_if, std::true_type
#include <memory>
#include <iterator> // std::iterator_traits
#include <exception>
#include <array>
#include <utility> // std::declval
#include <jsoncons/config/compiler_support.hpp>

namespace jsoncons {
namespace detail {

    #ifndef JSONCONS_HAS_VOID_T
    // follows https://en.cppreference.com/w/cpp/types/void_t
    template<typename... Ts> struct make_void { typedef void type;};
    template<typename... Ts> using void_t = typename make_void<Ts...>::type;
    #else
    using void_t = std::void_t; 
    #endif

    // follows http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2015/n4436.pdf

    // detector

    // primary template handles all types not supporting the archetypal Op
    template< 
        class Default, 
        class, // always void; supplied externally
        template<class...> class Op, 
        class... Args
    >
    struct detector
    {
        constexpr static auto value = false;
        using type = Default;
    };

    // specialization recognizes and handles only types supporting Op
    template< 
        class Default, 
        template<class...> class Op, 
        class... Args
    >
    struct detector<Default, void_t<Op<Args...>>, Op, Args...>
    {
        constexpr static auto value = true;
        using type = Op<Args...>;
    };

    // is_detected, is_detected_t

    template< template<class...> class Op, class... Args >
    using
    is_detected = detector<void, void, Op, Args...>;

    template< template<class...> class Op, class... Args >
    using
    is_detected_t = typename is_detected<Op, Args...>::type;

    // detected_or, detected_or_t

    template< class Default, template<class...> class Op, class... Args >
    using
    detected_or = detector<Default, void, Op, Args...>;

    template< class Default, template<class...> class Op, class... Args >
    using
    detected_or_t = typename detected_or<Default, Op, Args...>::type;

    // is_detected_exact

   template< class Expected, template<class...> class Op, class... Args >
   using
   is_detected_exact = std::is_same< Expected, is_detected_t<Op, Args...> >;

    // is_detected_convertible

    template< class To, template<class...> class Op, class... Args >
    using
    is_detected_convertible = std::is_convertible< is_detected_t<Op, Args...>, To >;

    template <typename T>
    struct is_stateless
     : public std::integral_constant<bool,  
          (std::is_default_constructible<T>::value &&
          std::is_empty<T>::value)>
    {};

    // to_plain_pointer

    template<class Pointer> inline
    typename std::pointer_traits<Pointer>::element_type* to_plain_pointer(Pointer ptr)
    {       
        return (std::addressof(*ptr));
    }

    template<class T> inline
    T * to_plain_pointer(T * ptr)
    {       
        return (ptr);
    }  

    // is_primitive

    template <class T, class Enable=void>
    struct is_primitive : std::false_type {};

    template <class T>
    struct is_primitive<T, 
           typename std::enable_if<std::is_integral<T>::value ||
                                   std::is_floating_point<T>::value
    >::type> : std::true_type {};

    // is_character

    template <class T, class Enable=void>
    struct is_character : std::false_type {};

    template <class T>
    struct is_character<T, 
           typename std::enable_if<std::is_same<T,char>::value ||
                                   std::is_same<T,wchar_t>::value
    >::type> : std::true_type {};

    // is_narrow_character

    template <class T, class Enable=void>
    struct is_narrow_character : std::false_type {};

    template <class T>
    struct is_narrow_character<T, 
           typename std::enable_if<is_character<T>::value && (sizeof(T) == sizeof(char))
    >::type> : std::true_type {};

    // is_wide_character

    template <class T, class Enable=void>
    struct is_wide_character : std::false_type {};

    template <class T>
    struct is_wide_character<T, 
           typename std::enable_if<is_character<T>::value && (sizeof(T) != sizeof(char))
    >::type> : std::true_type {};

    // is_int

    template <class T, class Enable=void>
    struct is_bool : std::false_type {};

    template <class T>
    struct is_bool<T, 
                   typename std::enable_if<std::is_same<T,bool>::value
    >::type> : std::true_type {};

    // is_uint

    template <class T, class Enable=void>
    struct is_u8_u16_u32_or_u64 : std::false_type {};

    template <class T>
    struct is_u8_u16_u32_or_u64<T, 
                                typename std::enable_if<std::is_same<T,uint8_t>::value ||
                                                        std::is_same<T,uint16_t>::value ||
                                                        std::is_same<T,uint32_t>::value ||
                                                        std::is_same<T,uint64_t>::value
    >::type> : std::true_type {};

    // is_int

    template <class T, class Enable=void>
    struct is_i8_i16_i32_or_i64 : std::false_type {};

    template <class T>
    struct is_i8_i16_i32_or_i64<T, 
                                typename std::enable_if<std::is_same<T,int8_t>::value ||
                                                        std::is_same<T,int16_t>::value ||
                                                        std::is_same<T,int32_t>::value ||
                                                        std::is_same<T,int64_t>::value
    >::type> : std::true_type {};

    // is_float_or_double

    template <class T, class Enable=void>
    struct is_float_or_double : std::false_type {};

    template <class T>
    struct is_float_or_double<T, 
                              typename std::enable_if<std::is_same<T,float>::value ||
                                                      std::is_same<T,double>::value
    >::type> : std::true_type {};

    // is_integer

    template <class T, class Enable=void>
    struct is_integer : std::false_type {};

    template <class T>
    struct is_integer<T, 
                      typename std::enable_if<std::is_integral<T>::value && 
                      !std::is_same<T,bool>::value>::type> : std::true_type {};

    // is_signed_integer

    template <class T, class Enable=void>
    struct is_signed_integer : std::false_type {};

    template <class T>
    struct is_signed_integer<T, 
                           typename std::enable_if<is_integer<T>::value && 
                           std::is_signed<T>::value>::type> : std::true_type {};

    // is_unsigned_integer

    template <class T, class Enable=void>
    struct is_unsigned_integer : std::false_type {};

    template <class T>
    struct is_unsigned_integer<T, 
                            typename std::enable_if<is_integer<T>::value && 
                            !std::is_signed<T>::value>::type> : std::true_type {};

    // Containers

    template <class Container>
    using 
    container_npos_t = decltype(Container::npos);

    template <class Container>
    using 
    container_allocator_type_t = typename Container::allocator_type;

    template <class Container>
    using 
    container_mapped_type_t = typename Container::mapped_type;

    template <class Container>
    using 
    container_key_type_t = typename Container::key_type;

    template <class Container>
    using 
    container_value_type_t = typename std::iterator_traits<typename Container::iterator>::value_type;

    template <class Container>
    using 
    container_char_traits_t = typename Container::traits_type::char_type;

    template<class Container>
    using
    container_push_back_t = decltype(std::declval<Container>().push_back(std::declval<typename Container::value_type>()));

    template<class Container>
    using
    container_push_front_t = decltype(std::declval<Container>().push_front(std::declval<typename Container::value_type>()));

    template<class Container>
    using
    container_insert_t = decltype(std::declval<Container>().insert(std::declval<typename Container::value_type>()));

    template<class Container>
    using
    container_reserve_t = decltype(std::declval<Container>().reserve(typename Container::size_type()));

    template<class Container>
    using
    container_data_t = decltype(std::declval<Container>().data());

    template<class Container>
    using
    container_size_t = decltype(std::declval<Container>().size());

    // is_string_or_string_view

    template <class T, class Enable=void>
    struct is_string_or_string_view : std::false_type {};

    template <class T>
    struct is_string_or_string_view<T, 
                     typename std::enable_if<is_character<typename T::value_type>::value &&
                                             is_detected_exact<typename T::value_type,container_char_traits_t,T>::value &&
                                             is_detected<container_npos_t,T>::value
    >::type> : std::true_type {};

    // is_basic_string

    template <class T, class Enable=void>
    struct is_basic_string : std::false_type {};

    template <class T>
    struct is_basic_string<T, 
                     typename std::enable_if<is_string_or_string_view<T>::value &&
                                             is_detected<container_allocator_type_t,T>::value
    >::type> : std::true_type {};

    // is_basic_string_view

    template <class T, class Enable=void>
    struct is_basic_string_view : std::false_type {};

    template <class T>
    struct is_basic_string_view<T, 
                          typename std::enable_if<is_string_or_string_view<T>::value &&
                                                  !is_detected<container_allocator_type_t,T>::value
    >::type> : std::true_type {};

    // is_map_like

    template <class T, class Enable=void>
    struct is_map_like : std::false_type {};

    template <class T>
    struct is_map_like<T, 
                       typename std::enable_if<is_detected<container_mapped_type_t,T>::value &&
                                               is_detected<container_allocator_type_t,T>::value &&
                                               is_detected<container_key_type_t,T>::value &&
                                               is_detected<container_value_type_t,T>::value 
        >::type> 
        : std::true_type {};

    // is_std_array
    template<class T>
    struct is_std_array : std::false_type {};

    template<class E, std::size_t N>
    struct is_std_array<std::array<E, N>> : std::true_type {};

    // is_list_like

    template <class T, class Enable=void>
    struct is_list_like : std::false_type {};

    template <class T>
    struct is_list_like<T, 
                          typename std::enable_if<is_detected<container_value_type_t,T>::value &&
                                                  is_detected<container_allocator_type_t,T>::value &&
                                                  !is_std_array<T>::value && 
                                                  !is_detected_exact<typename T::value_type,container_char_traits_t,T>::value &&
                                                  !is_map_like<T>::value 
    >::type> 
        : std::true_type {};

    // is_constructible_from_const_pointer_and_size

    template <class T, class Enable=void>
    struct is_constructible_from_const_pointer_and_size : std::false_type {};

    template <class T>
    struct is_constructible_from_const_pointer_and_size<T, 
        typename std::enable_if<std::is_constructible<T,typename T::const_pointer,typename T::size_type>::value
    >::type> 
        : std::true_type {};

    // has_reserve

    template<class Container>
    using
    has_reserve = is_detected<container_reserve_t, Container>;

    // is_back_insertable

    template<class Container>
    using
    is_back_insertable = is_detected<container_push_back_t, Container>;

    // is_front_insertable

    template<class Container>
    using
    is_front_insertable = is_detected<container_push_front_t, Container>;

    // is_insertable

    template<class Container>
    using
    is_insertable = is_detected<container_insert_t, Container>;

    // has_data, has_data_exact

    template<class Container>
    using
    has_data = is_detected<container_data_t, Container>;

    template<class Ret, class Container>
    using
    has_data_exact = is_detected_exact<Ret, container_data_t, Container>;

    // has_size

    template<class Container>
    using
    has_size = is_detected<container_size_t, Container>;

    // has_data_and_size

    template<class Container>
    struct has_data_and_size
    {
        static constexpr bool value = has_data<Container>::value && has_size<Container>::value;
    };

    // is_byte_sequence

    template <class Container, class Enable=void>
    struct is_byte_sequence : std::false_type {};

    template <class Container>
    struct is_byte_sequence<Container, 
           typename std::enable_if<has_data_exact<const typename Container::value_type*,const Container>::value &&
                                   has_size<Container>::value &&
                                   sizeof(typename Container::value_type) == sizeof(uint8_t)
    >::type> : std::true_type {};

    // is_back_insertable_byte_container

    template <class Container, class Enable=void>
    struct is_back_insertable_byte_container : std::false_type {};

    template <class Container>
    struct is_back_insertable_byte_container<Container, 
           typename std::enable_if<is_back_insertable<Container>::value &&
                                   sizeof(typename Container::value_type) == sizeof(uint8_t)
    >::type> : std::true_type {};

    // is_c_array

    template<class T>
    struct is_c_array : std::false_type {};

    template<class T>
    struct is_c_array<T[]> : std::true_type {};

    template<class T, std::size_t N>
    struct is_c_array<T[N]> : std::true_type {};

namespace impl {

    template<class C, class Enable=void>
    struct is_typed_array : std::false_type {};

    template<class T>
    struct is_typed_array
    <
        T, 
        typename std::enable_if<jsoncons::detail::is_list_like<T>::value && 
                                (std::is_same<typename std::decay<typename T::value_type>::type,uint8_t>::value ||  
                                 std::is_same<typename std::decay<typename T::value_type>::type,uint16_t>::value ||
                                 std::is_same<typename std::decay<typename T::value_type>::type,uint32_t>::value ||
                                 std::is_same<typename std::decay<typename T::value_type>::type,uint64_t>::value ||
                                 std::is_same<typename std::decay<typename T::value_type>::type,int8_t>::value ||  
                                 std::is_same<typename std::decay<typename T::value_type>::type,int16_t>::value ||
                                 std::is_same<typename std::decay<typename T::value_type>::type,int32_t>::value ||
                                 std::is_same<typename std::decay<typename T::value_type>::type,int64_t>::value ||
                                 std::is_same<typename std::decay<typename T::value_type>::type,float_t>::value ||
                                 std::is_same<typename std::decay<typename T::value_type>::type,double_t>::value)>::type
    > : std::true_type{};

} // namespace impl
    
    template <typename T>
    using is_typed_array = impl::is_typed_array<typename std::decay<T>::type>;

    // is_compatible_element

    template<class Container, class Element, class Enable=void>
    struct is_compatible_element : std::false_type {};

    template<class Container, class Element>
    struct is_compatible_element
    <
        Container, Element, 
        typename std::enable_if<has_data<Container>::value>::type>
            : std::is_convertible< typename std::remove_pointer<decltype(std::declval<Container>().data() )>::type(*)[], Element(*)[]>
    {};

    template<typename T>
    using
    construct_from_string_t = decltype(T(std::string{}));


    template<class T>
    using
    is_constructible_from_string = is_detected<construct_from_string_t,T>;
} // detail
} // jsoncons

#endif
