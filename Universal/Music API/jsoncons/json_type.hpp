// Copyright 2013 Daniel Parker
// Distributed under the Boost license, Version 1.0.
// (See accompanying file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

// See https://github.com/danielaparker/jsoncons for latest version

#ifndef JSONCONS_JSON_TYPE_HPP
#define JSONCONS_JSON_TYPE_HPP

namespace jsoncons {

    enum class json_type : uint8_t 
    {
        null_value,
        bool_value,
        int64_value,
        uint64_value,
        half_value,
        double_value,
        string_value,
        byte_string_value,
        array_value,
        object_value
    };

    enum class storage_kind : uint8_t 
    {
        null_value = 0x00,
        bool_value = 0x01,
        int64_value = 0x02,
        uint64_value = 0x03,
        half_value = 0x04,
        double_value = 0x05,
        short_string_value = 0x06,
        long_string_value = 0x07,
        byte_string_value = 0x08,
        array_value = 0x09,
        empty_object_value = 0x0a,
        object_value = 0x0b
    };

} // jsoncons

#endif
