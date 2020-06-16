// Copyright 2018 Daniel Parker
// Distributed under the Boost license, Version 1.0.
// (See accompanying file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

// See https://github.com/danielaparker/jsoncons for latest version

#ifndef JSONCONS_STAJ_READER_HPP
#define JSONCONS_STAJ_READER_HPP

#include <memory> // std::allocator
#include <string>
#include <stdexcept>
#include <system_error>
#include <ios>
#include <type_traits> // std::enable_if
#include <array> // std::array
#include <functional> // std::function
#include <jsoncons/json_exception.hpp>
#include <jsoncons/json_visitor.hpp>
#include <jsoncons/bigint.hpp>
#include <jsoncons/json_parser.hpp>
#include <jsoncons/ser_context.hpp>
#include <jsoncons/sink.hpp>
#include <jsoncons/detail/write_number.hpp>
#include <jsoncons/json_type_traits.hpp>
#include <jsoncons/converter.hpp>

namespace jsoncons {

enum class staj_event_type
{
    begin_array,
    end_array,
    begin_object,
    end_object,
    key,
    string_value,
    byte_string_value,
    null_value,
    bool_value,
    int64_value,
    uint64_value,
    half_value,
    double_value
#if !defined(JSONCONS_NO_DEPRECATED)
    ,name = key
#endif
};

template <class CharT>
std::basic_ostream<CharT>& operator<<(std::basic_ostream<CharT>& os, staj_event_type tag)
{
    JSONCONS_ARRAY_OF_CHAR(CharT,begin_array_name,'b','e','g','i','n','_','a','r','r','a','y')
    JSONCONS_ARRAY_OF_CHAR(CharT,end_array_name,'e','n','d','_','a','r','r','a','y')
    JSONCONS_ARRAY_OF_CHAR(CharT,begin_object_name,'b','e','g','i','n','_','o','b','j','e','c','t')
    JSONCONS_ARRAY_OF_CHAR(CharT,end_object_name,'e','n','d','_','o','b','j','e','c','t')
    JSONCONS_ARRAY_OF_CHAR(CharT,key_name,'k','e','y')
    JSONCONS_ARRAY_OF_CHAR(CharT,string_value_name,'s','t','r','i','n','g','_','v','a','l','u','e')
    JSONCONS_ARRAY_OF_CHAR(CharT,byte_string_value_name,'b','y','t','e','_','s','t','r','i','n','g','_','v','a','l','u','e')
    JSONCONS_ARRAY_OF_CHAR(CharT,null_value_name,'n','u','l','l','_','v','a','l','u','e')
    JSONCONS_ARRAY_OF_CHAR(CharT,bool_value_name,'b','o','o','l','_','v','a','l','u','e')
    JSONCONS_ARRAY_OF_CHAR(CharT,uint64_value_name,'u','i','n','t','6','4','_','v','a','l','u','e')
    JSONCONS_ARRAY_OF_CHAR(CharT,int64_value_name,'i','n','t','6','4','_','v','a','l','u','e')
    JSONCONS_ARRAY_OF_CHAR(CharT,half_value_name,'h','a','l','f','_','v','a','l','u','e')
    JSONCONS_ARRAY_OF_CHAR(CharT,double_value_name,'d','o','u','b','l','e','_','v','a','l','u','e')

    switch (tag)
    {
        case staj_event_type::begin_array:
        {
            os << begin_array_name;
            break;
        }
        case staj_event_type::end_array:
        {
            os << end_array_name;
            break;
        }
        case staj_event_type::begin_object:
        {
            os << begin_object_name;
            break;
        }
        case staj_event_type::end_object:
        {
            os << end_object_name;
            break;
        }
        case staj_event_type::key:
        {
            os << key_name;
            break;
        }
        case staj_event_type::string_value:
        {
            os << string_value_name;
            break;
        }
        case staj_event_type::byte_string_value:
        {
            os << byte_string_value_name;
            break;
        }
        case staj_event_type::null_value:
        {
            os << null_value_name;
            break;
        }
        case staj_event_type::bool_value:
        {
            os << bool_value_name;
            break;
        }
        case staj_event_type::int64_value:
        {
            os << int64_value_name;
            break;
        }
        case staj_event_type::uint64_value:
        {
            os << uint64_value_name;
            break;
        }
        case staj_event_type::half_value:
        {
            os << half_value_name;
            break;
        }
        case staj_event_type::double_value:
        {
            os << double_value_name;
            break;
        }
    }
    return os;
}

template<class CharT>
class basic_staj_event
{
    staj_event_type event_type_;
    semantic_tag tag_;
    uint64_t ext_tag_;
    union
    {
        bool bool_value_;
        int64_t int64_value_;
        uint64_t uint64_value_;
        uint16_t half_value_;
        double double_value_;
        const CharT* string_data_;
        const uint8_t* byte_string_data_;
    } value_;
    std::size_t length_;
public:
    using string_view_type = basic_string_view<CharT>;

    basic_staj_event(staj_event_type event_type, semantic_tag tag = semantic_tag::none)
        : event_type_(event_type), tag_(tag), ext_tag_(0), length_(0)
    {
    }

    basic_staj_event(null_type, semantic_tag tag)
        : event_type_(staj_event_type::null_value), tag_(tag), ext_tag_(0), length_(0)
    {
    }

    basic_staj_event(bool value, semantic_tag tag)
        : event_type_(staj_event_type::bool_value), tag_(tag), ext_tag_(0), length_(0)
    {
        value_.bool_value_ = value;
    }

    basic_staj_event(int64_t value, semantic_tag tag)
        : event_type_(staj_event_type::int64_value), tag_(tag), ext_tag_(0), length_(0)
    {
        value_.int64_value_ = value;
    }

    basic_staj_event(uint64_t value, semantic_tag tag)
        : event_type_(staj_event_type::uint64_value), tag_(tag), ext_tag_(0), length_(0)
    {
        value_.uint64_value_ = value;
    }

    basic_staj_event(half_arg_t, uint16_t value, semantic_tag tag)
        : event_type_(staj_event_type::half_value), tag_(tag), ext_tag_(0), length_(0)
    {
        value_.half_value_ = value;
    }

    basic_staj_event(double value, semantic_tag tag)
        : event_type_(staj_event_type::double_value), tag_(tag), ext_tag_(0), length_(0)
    {
        value_.double_value_ = value;
    }

    basic_staj_event(const string_view_type& s,
        staj_event_type event_type,
        semantic_tag tag = semantic_tag::none)
        : event_type_(event_type), tag_(tag), ext_tag_(0), length_(s.length())
    {
        value_.string_data_ = s.data();
    }

    basic_staj_event(const byte_string_view& s,
        staj_event_type event_type,
        semantic_tag tag = semantic_tag::none)
        : event_type_(event_type), tag_(tag), ext_tag_(0), length_(s.size())
    {
        value_.byte_string_data_ = s.data();
    }

    basic_staj_event(const byte_string_view& s,
        staj_event_type event_type,
        uint64_t ext_tag)
        : event_type_(event_type), tag_(semantic_tag::ext), ext_tag_(ext_tag), length_(s.size())
    {
        value_.byte_string_data_ = s.data();
    }

    template <class T>
    T get() const
    {
        std::error_code ec;
        T val = get<T>(ec);
        if (ec)
        {
            JSONCONS_THROW(ser_error(ec));
        }
        return val;
    }

    template<class T, class CharT_ = CharT>
    typename std::enable_if<detail::is_basic_string<T>::value && std::is_same<typename T::value_type, CharT_>::value, T>::type
    get(std::error_code& ec) const
    {
        converter<T> conv;
        switch (event_type_)
        {
            case staj_event_type::key:
            case staj_event_type::string_value:
                return conv.from(jsoncons::basic_string_view<CharT>(value_.string_data_, length_), tag(), ec);
            case staj_event_type::byte_string_value:
            {
                return conv.from(byte_string_view(value_.byte_string_data_,length_),
                                               tag(),
                                               ec);
            }
            case staj_event_type::uint64_value:
            {
                return conv.from(value_.uint64_value_, tag(), ec);
            }
            case staj_event_type::int64_value:
            {
                return conv.from(value_.int64_value_, tag(), ec);
            }
            case staj_event_type::half_value:
            {
                return conv.from(half_arg, value_.half_value_, tag(), ec);
            }
            case staj_event_type::double_value:
            {
                return conv.from(value_.double_value_, tag(), ec);
            }
            case staj_event_type::bool_value:
            {
                return conv.from(value_.bool_value_,tag(),ec);
            }
            case staj_event_type::null_value:
            {
                return conv.from(null_type(),tag(),ec);
            }
            default:
            {
                ec = convert_errc::not_string;
                return T{};
            }
        }
    }

    template<class T, class CharT_ = CharT>
    typename std::enable_if<detail::is_basic_string_view<T>::value && std::is_same<typename T::value_type, CharT_>::value, T>::type
        get(std::error_code& ec) const
    {
        T s;
        switch (event_type_)
        {
        case staj_event_type::key:
        case staj_event_type::string_value:
            s = T(value_.string_data_, length_);
            break;
        default:
            ec = convert_errc::not_string_view;
            break;        
        }
        return s;
    }

    template<class T>
    typename std::enable_if<std::is_same<T, byte_string_view>::value, T>::type
        get(std::error_code& ec) const
    {
        T s;
        switch (event_type_)
        {
            case staj_event_type::byte_string_value:
                s = T(value_.byte_string_data_, length_);
                break;
            default:
                ec = convert_errc::not_byte_string_view;
                break;
        }
        return s;
    }

    template<class T>
    typename std::enable_if<detail::is_list_like<T>::value &&
                            std::is_same<typename T::value_type,uint8_t>::value,T>::type
    get(std::error_code& ec) const
    {
        converter<T> conv;
        switch (event_type_)
        {
            case staj_event_type::byte_string_value:
                return conv.from(byte_string_view(value_.byte_string_data_, length_), tag(), ec);
            case staj_event_type::string_value:
                return conv.from(jsoncons::basic_string_view<CharT>(value_.string_data_, length_), tag(), ec);
            default:
                ec = convert_errc::not_byte_string;
                return T{};
        }
    }

    template<class T>
    typename std::enable_if<detail::is_signed_integer<T>::value, T>::type
        get(std::error_code& ec) const
    {
        return static_cast<T>(as_int64(ec));
    }

    template<class T>
    typename std::enable_if<detail::is_unsigned_integer<T>::value, T>::type
        get(std::error_code& ec) const
    {
        return static_cast<T>(as_uint64(ec));
    }

    template<class T>
    typename std::enable_if<std::is_floating_point<T>::value, T>::type
        get(std::error_code& ec) const
    {
        return static_cast<T>(as_double(ec));
    }

    template<class T>
    typename std::enable_if<detail::is_bool<T>::value, T>::type
        get(std::error_code& ec) const
    {
        return as_bool(ec);
    }

#if !defined(JSONCONS_NO_DEPRECATED)
    template<class T>
    JSONCONS_DEPRECATED_MSG("Instead, use get<T>()")
    T as() const
    {
        return get<T>();
    }
    semantic_tag get_semantic_tag() const noexcept { return tag_; }
#endif

    staj_event_type event_type() const noexcept { return event_type_; }

    semantic_tag tag() const noexcept { return tag_; }

    uint64_t ext_tag() const noexcept { return ext_tag_; }
private:

    int64_t as_int64(std::error_code& ec) const
    {
        int64_t value = 0;
        switch (event_type_)
        {
            case staj_event_type::key:
            case staj_event_type::string_value:
            {
                auto result = jsoncons::detail::to_integer<int64_t>(value_.string_data_, length_);
                if (!result)
                {
                    ec = convert_errc::not_signed_integer;
                }
                else
                {
                    value = result.value();
                }
                break;
            }
            case staj_event_type::double_value:
                value = static_cast<int64_t>(value_.double_value_);
                break;
            case staj_event_type::int64_value:
                value = value_.int64_value_;
                break;
            case staj_event_type::uint64_value:
                value = static_cast<int64_t>(value_.uint64_value_);
                break;
            case staj_event_type::bool_value:
                value = value_.bool_value_ ? 1 : 0;
                break;
            default:
                ec = convert_errc::not_signed_integer;
                break;
        }
        return value;
    }

    uint64_t as_uint64(std::error_code& ec) const
    {
        uint64_t value = 0;
        switch (event_type_)
        {
            case staj_event_type::key:
            case staj_event_type::string_value:
            {
                auto result = jsoncons::detail::to_integer<uint64_t>(value_.string_data_, length_);
                if (!result)
                {
                    ec = convert_errc::not_unsigned_integer;
                }
                else
                {
                    value = result.value();
                }
                break;
            }
            case staj_event_type::double_value:
                value = static_cast<uint64_t>(value_.double_value_);
                break;
            case staj_event_type::int64_value:
                value = static_cast<uint64_t>(value_.int64_value_);
                break;
            case staj_event_type::uint64_value:
                value = value_.uint64_value_;
                break;
            case staj_event_type::bool_value:
                value = value_.bool_value_ ? 1 : 0;
                break;
            default:
                ec = convert_errc::not_unsigned_integer;
                break;
        }
        return value;
    }

    double as_double(std::error_code& ec) const
    {
        switch (event_type_)
        {
            case staj_event_type::key:
            case staj_event_type::string_value:
            {
                jsoncons::detail::to_double_t f;
                return f(value_.string_data_, length_);
            }
            case staj_event_type::double_value:
                return value_.double_value_;
            case staj_event_type::int64_value:
                return static_cast<double>(value_.int64_value_);
            case staj_event_type::uint64_value:
                return static_cast<double>(value_.uint64_value_);
            case staj_event_type::half_value:
            {
                double x = jsoncons::detail::decode_half(value_.half_value_);
                return static_cast<double>(x);
            }
            default:
                ec = convert_errc::not_double;
                return double();
        }
    }

    bool as_bool(std::error_code& ec) const
    {
        switch (event_type_)
        {
            case staj_event_type::bool_value:
                return value_.bool_value_;
            case staj_event_type::double_value:
                return value_.double_value_ != 0.0;
            case staj_event_type::int64_value:
                return value_.int64_value_ != 0;
            case staj_event_type::uint64_value:
                return value_.uint64_value_ != 0;
            default:
                ec = convert_errc::not_bool;
                return bool();
        }
    }
};

// basic_staj_visitor

enum class staj_cursor_state
{
    typed_array = 1,
    multi_dim,
    shape
};

struct uint8_array_arg_t {explicit uint8_array_arg_t() = default; };
constexpr uint8_array_arg_t uint8_array_arg = uint8_array_arg_t();
struct uint16_array_arg_t {explicit uint16_array_arg_t() = default; };
struct uint32_array_arg_t {explicit uint32_array_arg_t() = default; };
constexpr uint32_array_arg_t uint32_array_arg = uint32_array_arg_t();
struct uint64_array_arg_t {explicit uint64_array_arg_t() = default; };
constexpr uint64_array_arg_t uint64_array_arg = uint64_array_arg_t();
struct int8_array_arg_t {explicit int8_array_arg_t() = default; };
constexpr int8_array_arg_t int8_array_arg = int8_array_arg_t();
struct int16_array_arg_t {explicit int16_array_arg_t() = default; };
constexpr int16_array_arg_t int16_array_arg = int16_array_arg_t();
struct int32_array_arg_t {explicit int32_array_arg_t() = default; };
constexpr int32_array_arg_t int32_array_arg = int32_array_arg_t();
struct int64_array_arg_t {explicit int64_array_arg_t() = default; };
constexpr int64_array_arg_t int64_array_arg = int64_array_arg_t();
constexpr uint16_array_arg_t uint16_array_arg = uint16_array_arg_t();
struct half_array_arg_t {explicit half_array_arg_t() = default; };
constexpr half_array_arg_t half_array_arg = half_array_arg_t();
struct float_array_arg_t {explicit float_array_arg_t() = default; };
constexpr float_array_arg_t float_array_arg = float_array_arg_t();
struct double_array_arg_t {explicit double_array_arg_t() = default; };
constexpr double_array_arg_t double_array_arg = double_array_arg_t();
struct float128_array_arg_t {explicit float128_array_arg_t() = default; };
constexpr float128_array_arg_t float128_array_arg = float128_array_arg_t();

enum typed_array_type {uint8_value=1,uint16_value,uint32_value,uint64_value,
                      int8_value,int16_value,int32_value,int64_value, 
                      half_value, float_value,double_value};

class typed_array_view
{
    typed_array_type type_;
    union 
    {
        const uint8_t* uint8_data_;
        const uint16_t* uint16_data_;
        const uint32_t* uint32_data_;
        const uint64_t* uint64_data_;
        const int8_t* int8_data_;
        const int16_t* int16_data_;
        const int32_t* int32_data_;
        const int64_t* int64_data_;
        const float* float_data_;
        const double* double_data_;
    } data_;
    std::size_t size_;
public:

    typed_array_view()
        : type_(), data_(), size_(0)
    {
    }

    typed_array_view(const typed_array_view& other)
        : type_(other.type_), data_(other.data_), size_(other.size())
    {
    }

    typed_array_view(typed_array_view&& other)
    {
        swap(*this,other);
    }

    typed_array_view(const uint8_t* data, std::size_t size)
        : type_(typed_array_type::uint8_value), size_(size)
    {
        data_.uint8_data_ = data;
    }

    typed_array_view(const uint16_t* data, std::size_t size)
        : type_(typed_array_type::uint16_value), size_(size)
    {
        data_.uint16_data_ = data;
    }

    typed_array_view(const uint32_t* data, std::size_t size)
        : type_(typed_array_type::uint32_value), size_(size)
    {
        data_.uint32_data_ = data;
    }

    typed_array_view(const uint64_t* data, std::size_t size)
        : type_(typed_array_type::uint64_value), size_(size)
    {
        data_.uint64_data_ = data;
    }

    typed_array_view(const int8_t* data, std::size_t size)
        : type_(typed_array_type::int8_value), size_(size)
    {
        data_.int8_data_ = data;
    }

    typed_array_view(const int16_t* data, std::size_t size)
        : type_(typed_array_type::int16_value), size_(size)
    {
        data_.int16_data_ = data;
    }

    typed_array_view(const int32_t* data, std::size_t size)
        : type_(typed_array_type::int32_value), size_(size)
    {
        data_.int32_data_ = data;
    }

    typed_array_view(const int64_t* data, std::size_t size)
        : type_(typed_array_type::int64_value), size_(size)
    {
        data_.int64_data_ = data;
    }

    typed_array_view(half_array_arg_t, const uint16_t* data, std::size_t size)
        : type_(typed_array_type::half_value), size_(size)
    {
        data_.uint16_data_ = data;
    }

    typed_array_view(const float* data, std::size_t size)
        : type_(typed_array_type::float_value), size_(size)
    {
        data_.float_data_ = data;
    }

    typed_array_view(const double* data, std::size_t size)
        : type_(typed_array_type::double_value), size_(size)
    {
        data_.double_data_ = data;
    }

    typed_array_view& operator=(const typed_array_view& other)
    {
        typed_array_view temp(other);
        swap(*this,temp);
        return *this;
    }

    typed_array_type type() const {return type_;}

    std::size_t size() const
    {
        return size_;
    }

    span<const uint8_t> data(uint8_array_arg_t) const
    {
        JSONCONS_ASSERT(type_ == typed_array_type::uint8_value);
        return span<const uint8_t>(data_.uint8_data_, size_);
    }

    span<const uint16_t> data(uint16_array_arg_t) const
    {
        JSONCONS_ASSERT(type_ == typed_array_type::uint16_value);
        return span<const uint16_t>(data_.uint16_data_, size_);
    }

    span<const uint32_t> data(uint32_array_arg_t) const
    {
        JSONCONS_ASSERT(type_ == typed_array_type::uint32_value);
        return span<const uint32_t>(data_.uint32_data_, size_);
    }

    span<const uint64_t> data(uint64_array_arg_t) const
    {
        JSONCONS_ASSERT(type_ == typed_array_type::uint64_value);
        return span<const uint64_t>(data_.uint64_data_, size_);
    }

    span<const int8_t> data(int8_array_arg_t) const
    {
        JSONCONS_ASSERT(type_ == typed_array_type::int8_value);
        return span<const int8_t>(data_.int8_data_, size_);
    }

    span<const int16_t> data(int16_array_arg_t) const
    {
        JSONCONS_ASSERT(type_ == typed_array_type::int16_value);
        return span<const int16_t>(data_.int16_data_, size_);
    }

    span<const int32_t> data(int32_array_arg_t) const
    {
        JSONCONS_ASSERT(type_ == typed_array_type::int32_value);
        return span<const int32_t>(data_.int32_data_, size_);
    }

    span<const int64_t> data(int64_array_arg_t) const
    {
        JSONCONS_ASSERT(type_ == typed_array_type::int64_value);
        return span<const int64_t>(data_.int64_data_, size_);
    }

    span<const uint16_t> data(half_array_arg_t) const
    {
        JSONCONS_ASSERT(type_ == typed_array_type::half_value);
        return span<const uint16_t>(data_.uint16_data_, size_);
    }

    span<const float> data(float_array_arg_t) const
    {
        JSONCONS_ASSERT(type_ == typed_array_type::float_value);
        return span<const float>(data_.float_data_, size_);
    }

    span<const double> data(double_array_arg_t) const
    {
        JSONCONS_ASSERT(type_ == typed_array_type::double_value);
        return span<const double>(data_.double_data_, size_);
    }

    friend void swap(typed_array_view& a, typed_array_view& b) noexcept
    {
        std::swap(a.data_,b.data_);
        std::swap(a.type_,b.type_);
        std::swap(a.size_,b.size_);
    }
};

template <class CharT>
class basic_staj_visitor : public basic_json_visitor<CharT>
{
    using super_type = basic_json_visitor<CharT>;
public:
    using char_type = CharT;
    using typename super_type::string_view_type;
private:
    std::function<bool(const basic_staj_event<CharT>&, const ser_context&)> pred_;
    basic_staj_event<CharT> event_;

    staj_cursor_state state_;
    typed_array_view data_;
    span<const size_t> shape_;
    std::size_t index_;
public:
    basic_staj_visitor()
        : pred_(accept), event_(staj_event_type::null_value),
          state_(), data_(), shape_(), index_(0)
    {
    }

    basic_staj_visitor(std::function<bool(const basic_staj_event<CharT>&, const ser_context&)> pred)
        : pred_(pred), event_(staj_event_type::null_value),
          state_(), data_(), shape_(), index_(0)
    {
    }

    const basic_staj_event<CharT>& event() const
    {
        return event_;
    }

    bool in_available() const
    {
        return state_ != staj_cursor_state();
    }

    void send_available(std::error_code& ec)
    {
        switch (state_)
        {
            case staj_cursor_state::typed_array:
                advance_typed_array(ec);
                break;
            case staj_cursor_state::multi_dim:
            case staj_cursor_state::shape:
                advance_multi_dim(ec);
                break;
            default:
                break;
        }
    }

    bool is_typed_array() const
    {
        return data_.type() != typed_array_type();
    }

    staj_cursor_state state() const
    {
        return state_;
    }

    void advance_typed_array(std::error_code& ec)
    {
        if (is_typed_array())
        {
            if (index_ < data_.size())
            {
                switch (data_.type())
                {
                    case typed_array_type::uint8_value:
                    {
                        this->uint64_value(data_.data(uint8_array_arg)[index_], semantic_tag::none, ser_context(), ec);
                        break;
                    }
                    case typed_array_type::uint16_value:
                    {
                        this->uint64_value(data_.data(uint16_array_arg)[index_], semantic_tag::none, ser_context(), ec);
                        break;
                    }
                    case typed_array_type::uint32_value:
                    {
                        this->uint64_value(data_.data(uint32_array_arg)[index_], semantic_tag::none, ser_context(), ec);
                        break;
                    }
                    case typed_array_type::uint64_value:
                    {
                        this->uint64_value(data_.data(uint64_array_arg)[index_], semantic_tag::none, ser_context(), ec);
                        break;
                    }
                    case typed_array_type::int8_value:
                    {
                        this->int64_value(data_.data(int8_array_arg)[index_], semantic_tag::none, ser_context(), ec);
                        break;
                    }
                    case typed_array_type::int16_value:
                    {
                        this->int64_value(data_.data(int16_array_arg)[index_], semantic_tag::none, ser_context(), ec);
                        break;
                    }
                    case typed_array_type::int32_value:
                    {
                        this->int64_value(data_.data(int32_array_arg)[index_], semantic_tag::none, ser_context(), ec);
                        break;
                    }
                    case typed_array_type::int64_value:
                    {
                        this->int64_value(data_.data(int64_array_arg)[index_], semantic_tag::none, ser_context(), ec);
                        break;
                    }
                    case typed_array_type::half_value:
                    {
                        this->half_value(data_.data(half_array_arg)[index_], semantic_tag::none, ser_context(), ec);
                        break;
                    }
                    case typed_array_type::float_value:
                    {
                        this->double_value(data_.data(float_array_arg)[index_], semantic_tag::none, ser_context(), ec);
                        break;
                    }
                    case typed_array_type::double_value:
                    {
                        this->double_value(data_.data(double_array_arg)[index_], semantic_tag::none, ser_context(), ec);
                        break;
                    }
                    default:
                        break;
                }
                ++index_;
            }
            else
            {
                this->end_array();
                state_ = staj_cursor_state();
                data_ = typed_array_view();
                index_ = 0;
            }
        }
    }

    void advance_multi_dim(std::error_code& ec)
    {
        if (shape_.size() != 0)
        {
            if (state_ == staj_cursor_state::multi_dim)
            {
                this->begin_array(shape_.size(), semantic_tag::none, ser_context(), ec);
                state_ = staj_cursor_state::shape;
            }
            else if (index_ < shape_.size())
            {
                this->uint64_value(shape_[index_], semantic_tag::none, ser_context(), ec);
                ++index_;
            }
            else
            {
                state_ = staj_cursor_state();
                this->end_array(ser_context(), ec);
                shape_ = span<const size_t>();
                index_ = 0;
            }
        }
    }

    bool dump(basic_json_visitor<CharT>& visitor, const ser_context& context, std::error_code& ec)
    {
        bool more = true;
        if (is_typed_array())
        {
            if (index_ != 0)
            {
                more = staj_to_saj_event(event(), visitor, context, ec);
                while (more && is_typed_array())
                {
                    if (index_ < data_.size())
                    {
                        switch (data_.type())
                        {
                            case typed_array_type::uint8_value:
                            {
                                more = visitor.uint64_value(data_.data(uint8_array_arg)[index_]);
                                break;
                            }
                            case typed_array_type::uint16_value:
                            {
                                more = visitor.uint64_value(data_.data(uint16_array_arg)[index_]);
                                break;
                            }
                            case typed_array_type::uint32_value:
                            {
                                more = visitor.uint64_value(data_.data(uint32_array_arg)[index_]);
                                break;
                            }
                            case typed_array_type::uint64_value:
                            {
                                more = visitor.uint64_value(data_.data(uint64_array_arg)[index_]);
                                break;
                            }
                            case typed_array_type::int8_value:
                            {
                                more = visitor.int64_value(data_.data(int8_array_arg)[index_]);
                                break;
                            }
                            case typed_array_type::int16_value:
                            {
                                more = visitor.int64_value(data_.data(int16_array_arg)[index_]);
                                break;
                            }
                            case typed_array_type::int32_value:
                            {
                                more = visitor.int64_value(data_.data(int32_array_arg)[index_]);
                                break;
                            }
                            case typed_array_type::int64_value:
                            {
                                more = visitor.int64_value(data_.data(int64_array_arg)[index_]);
                                break;
                            }
                            case typed_array_type::float_value:
                            {
                                more = visitor.double_value(data_.data(float_array_arg)[index_]);
                                break;
                            }
                            case typed_array_type::double_value:
                            {
                                more = visitor.double_value(data_.data(double_array_arg)[index_]);
                                break;
                            }
                            default:
                                break;
                        }
                        ++index_;
                    }
                    else
                    {
                        more = visitor.end_array();
                        state_ = staj_cursor_state();
                        data_ = typed_array_view();
                        index_ = 0;
                    }
                }
            }
            else
            {
                switch (data_.type())
                {
                    case typed_array_type::uint8_value:
                    {
                        more = visitor.typed_array(data_.data(uint8_array_arg));
                        break;
                    }
                    case typed_array_type::uint16_value:
                    {
                        more = visitor.typed_array(data_.data(uint16_array_arg));
                        break;
                    }
                    case typed_array_type::uint32_value:
                    {
                        more = visitor.typed_array(data_.data(uint32_array_arg));
                        break;
                    }
                    case typed_array_type::uint64_value:
                    {
                        more = visitor.typed_array(data_.data(uint64_array_arg));
                        break;
                    }
                    case typed_array_type::int8_value:
                    {
                        more = visitor.typed_array(data_.data(int8_array_arg));
                        break;
                    }
                    case typed_array_type::int16_value:
                    {
                        more = visitor.typed_array(data_.data(int16_array_arg));
                        break;
                    }
                    case typed_array_type::int32_value:
                    {
                        more = visitor.typed_array(data_.data(int32_array_arg));
                        break;
                    }
                    case typed_array_type::int64_value:
                    {
                        more = visitor.typed_array(data_.data(int64_array_arg));
                        break;
                    }
                    case typed_array_type::float_value:
                    {
                        more = visitor.typed_array(data_.data(float_array_arg));
                        break;
                    }
                    case typed_array_type::double_value:
                    {
                        more = visitor.typed_array(data_.data(double_array_arg));
                        break;
                    }
                    default:
                        break;
                }

                state_ = staj_cursor_state();
                data_ = typed_array_view();
            }
        }
        else
        {
            more = staj_to_saj_event(event(), visitor, context, ec);
        }
        return more;
    }

private:
    static constexpr bool accept(const basic_staj_event<CharT>&, const ser_context&) 
    {
        return true;
    }

    bool visit_begin_object(semantic_tag tag, const ser_context& context, std::error_code&) override
    {
        event_ = basic_staj_event<CharT>(staj_event_type::begin_object, tag);
        return !pred_(event_, context);
    }

    bool visit_end_object(const ser_context& context, std::error_code&) override
    {
        event_ = basic_staj_event<CharT>(staj_event_type::end_object);
        return !pred_(event_, context);
    }

    bool visit_begin_array(semantic_tag tag, const ser_context& context, std::error_code&) override
    {
        event_ = basic_staj_event<CharT>(staj_event_type::begin_array, tag);
        return !pred_(event_, context);
    }

    bool visit_end_array(const ser_context& context, std::error_code&) override
    {
        event_ = basic_staj_event<CharT>(staj_event_type::end_array);
        return !pred_(event_, context);
    }

    bool visit_key(const string_view_type& name, const ser_context& context, std::error_code&) override
    {
        event_ = basic_staj_event<CharT>(name, staj_event_type::key);
        return !pred_(event_, context);
    }

    bool visit_null(semantic_tag tag, const ser_context& context, std::error_code&) override
    {
        event_ = basic_staj_event<CharT>(staj_event_type::null_value, tag);
        return !pred_(event_, context);
    }

    bool visit_bool(bool value, semantic_tag tag, const ser_context& context, std::error_code&) override
    {
        event_ = basic_staj_event<CharT>(value, tag);
        return !pred_(event_, context);
    }

    bool visit_string(const string_view_type& s, semantic_tag tag, const ser_context& context, std::error_code&) override
    {
        event_ = basic_staj_event<CharT>(s, staj_event_type::string_value, tag);
        return !pred_(event_, context);
    }

    bool visit_byte_string(const byte_string_view& s, 
                           semantic_tag tag,
                           const ser_context& context,
                           std::error_code&) override
    {
        event_ = basic_staj_event<CharT>(s, staj_event_type::byte_string_value, tag);
        return !pred_(event_, context);
    }

    bool visit_byte_string(const byte_string_view& s, 
                           uint64_t ext_tag,
                           const ser_context& context,
                           std::error_code&) override
    {
        event_ = basic_staj_event<CharT>(s, staj_event_type::byte_string_value, ext_tag);
        return !pred_(event_, context);
    }

    bool visit_uint64(uint64_t value, 
                         semantic_tag tag, 
                         const ser_context& context,
                         std::error_code&) override
    {
        event_ = basic_staj_event<CharT>(value, tag);
        return !pred_(event_, context);
    }

    bool visit_int64(int64_t value, 
                  semantic_tag tag,
                  const ser_context& context,
                  std::error_code&) override
    {
        event_ = basic_staj_event<CharT>(value, tag);
        return !pred_(event_, context);
    }

    bool visit_half(uint16_t value, 
                 semantic_tag tag,
                 const ser_context& context,
                 std::error_code&) override
    {
        event_ = basic_staj_event<CharT>(half_arg, value, tag);
        return !pred_(event_, context);
    }

    bool visit_double(double value, 
                   semantic_tag tag, 
                   const ser_context& context,
                   std::error_code&) override
    {
        event_ = basic_staj_event<CharT>(value, tag);
        return !pred_(event_, context);
    }

    bool visit_typed_array(const span<const uint8_t>& v, 
                        semantic_tag tag,
                        const ser_context& context,
                        std::error_code& ec) override
    {
        state_ = staj_cursor_state::typed_array;
        data_ = typed_array_view(v.data(), v.size());
        index_ = 0;
        return this->begin_array(tag, context, ec);
    }

    bool visit_typed_array(const span<const uint16_t>& data, 
                        semantic_tag tag,
                        const ser_context& context,
                        std::error_code& ec) override
    {
        state_ = staj_cursor_state::typed_array;
        data_ = typed_array_view(data.data(), data.size());
        index_ = 0;
        return this->begin_array(tag, context, ec);
    }

    bool visit_typed_array(const span<const uint32_t>& data, 
                        semantic_tag tag,
                        const ser_context& context,
                        std::error_code& ec) override
    {
        state_ = staj_cursor_state::typed_array;
        data_ = typed_array_view(data.data(), data.size());
        index_ = 0;
        return this->begin_array(tag, context, ec);
    }

    bool visit_typed_array(const span<const uint64_t>& data, 
                        semantic_tag tag,
                        const ser_context& context,
                        std::error_code& ec) override
    {
        state_ = staj_cursor_state::typed_array;
        data_ = typed_array_view(data.data(), data.size());
        index_ = 0;
        return this->begin_array(tag, context, ec);
    }

    bool visit_typed_array(const span<const int8_t>& data, 
                        semantic_tag tag,
                        const ser_context& context,
                        std::error_code& ec) override
    {
        state_ = staj_cursor_state::typed_array;
        data_ = typed_array_view(data.data(), data.size());
        index_ = 0;
        return this->begin_array(tag, context, ec);
    }

    bool visit_typed_array(const span<const int16_t>& data, 
                        semantic_tag tag,
                        const ser_context& context,
                        std::error_code& ec) override
    {
        state_ = staj_cursor_state::typed_array;
        data_ = typed_array_view(data.data(), data.size());
        index_ = 0;
        return this->begin_array(tag, context, ec);
    }

    bool visit_typed_array(const span<const int32_t>& data, 
                        semantic_tag tag,
                        const ser_context& context,
                        std::error_code& ec) override
    {
        state_ = staj_cursor_state::typed_array;
        data_ = typed_array_view(data.data(), data.size());
        index_ = 0;
        return this->begin_array(tag, context, ec);
    }

    bool visit_typed_array(const span<const int64_t>& data, 
                        semantic_tag tag,
                        const ser_context& context,
                        std::error_code& ec) override
    {
        state_ = staj_cursor_state::typed_array;
        data_ = typed_array_view(data.data(), data.size());
        index_ = 0;
        return this->begin_array(tag, context, ec);
    }

    bool visit_typed_array(half_arg_t, const span<const uint16_t>& data, 
                        semantic_tag tag,
                        const ser_context& context,
                        std::error_code& ec) override
    {
        state_ = staj_cursor_state::typed_array;
        data_ = typed_array_view(data.data(), data.size());
        index_ = 0;
        return this->begin_array(tag, context, ec);
    }

    bool visit_typed_array(const span<const float>& data, 
                        semantic_tag tag,
                        const ser_context& context,
                        std::error_code& ec) override
    {
        state_ = staj_cursor_state::typed_array;
        data_ = typed_array_view(data.data(), data.size());
        index_ = 0;
        return this->begin_array(tag, context, ec);
    }

    bool visit_typed_array(const span<const double>& data, 
                        semantic_tag tag,
                        const ser_context& context,
                        std::error_code& ec) override
    {
        state_ = staj_cursor_state::typed_array;
        data_ = typed_array_view(data.data(), data.size());
        index_ = 0;
        return this->begin_array(tag, context, ec);
    }
/*
    bool visit_typed_array(const span<const float128_type>&, 
                        semantic_tag,
                        const ser_context&,
                        std::error_code&) override
    {
        return true;
    }
*/
    bool visit_begin_multi_dim(const span<const size_t>& shape,
                            semantic_tag tag,
                            const ser_context& context, 
                            std::error_code& ec) override
    {
        state_ = staj_cursor_state::multi_dim;
        shape_ = shape;
        return this->begin_array(2, tag, context, ec);
    }

    bool visit_end_multi_dim(const ser_context& context,
                          std::error_code& ec) override
    {
        return this->end_array(context, ec);
    }

    void visit_flush() override
    {
    }
};

template<class CharT>
bool staj_to_saj_event(const basic_staj_event<CharT>& ev,
                       basic_json_visitor<CharT>& visitor,
                       const ser_context& context,
                       std::error_code& ec)
{
    switch (ev.event_type())
    {
        case staj_event_type::begin_array:
            return visitor.begin_array(ev.tag(), context);
        case staj_event_type::end_array:
            return visitor.end_array(context);
        case staj_event_type::begin_object:
            return visitor.begin_object(ev.tag(), context, ec);
        case staj_event_type::end_object:
            return visitor.end_object(context, ec);
        case staj_event_type::key:
            return visitor.key(ev.template get<basic_string_view<CharT>>(), context);
        case staj_event_type::string_value:
            return visitor.string_value(ev.template get<basic_string_view<CharT>>(), ev.tag(), context);
        case staj_event_type::byte_string_value:
            return visitor.byte_string_value(ev.template get<byte_string_view>(), ev.tag(), context);
        case staj_event_type::null_value:
            return visitor.null_value(ev.tag(), context);
        case staj_event_type::bool_value:
            return visitor.bool_value(ev.template get<bool>(), ev.tag(), context);
        case staj_event_type::int64_value:
            return visitor.int64_value(ev.template get<int64_t>(), ev.tag(), context);
        case staj_event_type::uint64_value:
            return visitor.uint64_value(ev.template get<uint64_t>(), ev.tag(), context);
        case staj_event_type::half_value:
            return visitor.half_value(ev.template get<uint16_t>(), ev.tag(), context);
        case staj_event_type::double_value:
            return visitor.double_value(ev.template get<double>(), ev.tag(), context);
        default:
            return false;
    }
}

// basic_staj_cursor

template<class CharT>
class basic_staj_cursor
{
public:
    virtual ~basic_staj_cursor() noexcept = default;

    virtual bool done() const = 0;

    virtual const basic_staj_event<CharT>& current() const = 0;

    virtual void read_to(basic_json_visitor<CharT>& visitor) = 0;

    virtual void read_to(basic_json_visitor<CharT>& visitor,
                      std::error_code& ec) = 0;

    virtual void next() = 0;

    virtual void next(std::error_code& ec) = 0;

    virtual const ser_context& context() const = 0;
};

template<class CharT>
class basic_staj_filter_view : basic_staj_cursor<CharT>
{
    basic_staj_cursor<CharT>* cursor_;
    std::function<bool(const basic_staj_event<CharT>&, const ser_context&)> pred_;
public:
    basic_staj_filter_view(basic_staj_cursor<CharT>& cursor, 
                     std::function<bool(const basic_staj_event<CharT>&, const ser_context&)> pred)
        : cursor_(std::addressof(cursor)), pred_(pred)
    {
        while (!done() && !pred_(current(),context()))
        {
            cursor_->next();
        }
    }

    bool done() const override
    {
        return cursor_->done();
    }

    const basic_staj_event<CharT>& current() const override
    {
        return cursor_->current();
    }

    void read_to(basic_json_visitor<CharT>& visitor) override
    {
        cursor_->read_to(visitor);
    }

    void read_to(basic_json_visitor<CharT>& visitor,
                 std::error_code& ec) override
    {
        cursor_->read_to(visitor, ec);
    }

    void next() override
    {
        cursor_->next();
        while (!done() && !pred_(current(),context()))
        {
            cursor_->next();
        }
    }

    void next(std::error_code& ec) override
    {
        cursor_->next(ec);
        while (!done() && !pred_(current(),context()) && !ec)
        {
            cursor_->next(ec);
        }
    }

    const ser_context& context() const override
    {
        return cursor_->context();
    }

    friend
    basic_staj_filter_view<CharT> operator|(basic_staj_filter_view& cursor, 
                                      std::function<bool(const basic_staj_event<CharT>&, const ser_context&)> pred)
    {
        return basic_staj_filter_view<CharT>(cursor, pred);
    }
};

using staj_event = basic_staj_event<char>;
using wstaj_event = basic_staj_event<wchar_t>;

using staj_cursor = basic_staj_cursor<char>;
using wstaj_cursor = basic_staj_cursor<wchar_t>;

using staj_filter_view = basic_staj_filter_view<char>;
using wstaj_filter_view = basic_staj_filter_view<wchar_t>;

#if !defined(JSONCONS_NO_DEPRECATED)

JSONCONS_DEPRECATED_MSG("Instead, use staj_event_type") typedef staj_event_type stream_event_type;

template<class CharT>
using basic_stream_event = basic_staj_event<CharT>;

template<class CharT>
using basic_stream_reader = basic_staj_cursor<CharT>;

template<class CharT>
using basic_staj_reader = basic_staj_cursor<CharT>;

JSONCONS_DEPRECATED_MSG("Instead, use staj_event") typedef basic_staj_event<char> stream_event;
JSONCONS_DEPRECATED_MSG("Instead, use wstaj_event") typedef basic_staj_event<wchar_t> wstream_event;

JSONCONS_DEPRECATED_MSG("Instead, use staj_cursor") typedef basic_staj_cursor<char> stream_reader;
JSONCONS_DEPRECATED_MSG("Instead, use wstaj_cursor") typedef basic_staj_cursor<wchar_t> wstream_reader;

JSONCONS_DEPRECATED_MSG("Instead, use staj_cursor") typedef basic_staj_cursor<char> staj_reader;
JSONCONS_DEPRECATED_MSG("Instead, use wstaj_cursor") typedef basic_staj_cursor<wchar_t> wstaj_reader;

#endif

}

#endif

