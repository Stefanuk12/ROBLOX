// Copyright 2017 Daniel Parker
// Distributed under the Boost license, Version 1.0.
// (See accompanying file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

// See https://github.com/danielaparker/jsoncons for latest version

#ifndef JSONCONS_ENCODE_JSON_HPP
#define JSONCONS_ENCODE_JSON_HPP

#include <iostream>
#include <string>
#include <tuple>
#include <memory>
#include <istream> // std::basic_istream
#include <jsoncons/ser_traits.hpp>
#include <jsoncons/json_cursor.hpp>

namespace jsoncons {

    // to string

    template <class T, class CharT>
    void encode_json(const T& val, 
                     std::basic_string<CharT>& s, 
                     indenting line_indent = indenting::no_indent)
    {
        encode_json(val, s, basic_json_encode_options<CharT>(), line_indent);
    }

    template <class T, class CharT>
    typename std::enable_if<is_basic_json<T>::value>::type
    encode_json(const T& val,
                std::basic_string<CharT>& s, 
                const basic_json_encode_options<CharT>& options, 
                indenting line_indent = indenting::no_indent)
    {
        if (line_indent == indenting::indent)
        {
            basic_json_encoder<CharT,jsoncons::string_sink<std::basic_string<CharT>>> encoder(s, options);
            val.dump(encoder);
        }
        else
        {
            basic_compact_json_encoder<CharT, jsoncons::string_sink<std::basic_string<CharT>>> encoder(s, options);
            val.dump(encoder);
        }
    }

    template <class T, class CharT>
    typename std::enable_if<!is_basic_json<T>::value>::type
    encode_json(const T& val,
                std::basic_string<CharT>& s, 
                const basic_json_encode_options<CharT>& options, 
                indenting line_indent = indenting::no_indent)
    {
        if (line_indent == indenting::indent)
        {
            basic_json_encoder<CharT,jsoncons::string_sink<std::basic_string<CharT>>> encoder(s, options);
            encode_json(val, encoder);
        }
        else
        {
            basic_compact_json_encoder<CharT, jsoncons::string_sink<std::basic_string<CharT>>> encoder(s, options);
            encode_json(val, encoder);
        }
    }

    // to stream

    template <class T, class CharT>
    void encode_json(const T& val, 
                     std::basic_ostream<CharT>& os, 
                     indenting line_indent = indenting::no_indent)
    {
        encode_json(val, os, basic_json_encode_options<CharT>(), line_indent);
    }

    template <class T, class CharT>
    typename std::enable_if<is_basic_json<T>::value>::type
    encode_json(const T& val,
                std::basic_ostream<CharT>& os, 
                const basic_json_encode_options<CharT>& options, 
                indenting line_indent = indenting::no_indent)
    {
        if (line_indent == indenting::indent)
        {
            basic_json_encoder<CharT> encoder(os, options);
            val.dump(encoder);
        }
        else
        {
            basic_compact_json_encoder<CharT> encoder(os, options);
            val.dump(encoder);
        }
    }

    template <class T, class CharT>
    typename std::enable_if<!is_basic_json<T>::value>::type
    encode_json(const T& val,
                std::basic_ostream<CharT>& os, 
                const basic_json_encode_options<CharT>& options, 
                indenting line_indent = indenting::no_indent)
    {
        if (line_indent == indenting::indent)
        {
            basic_json_encoder<CharT> encoder(os, options);
            encode_json(val, encoder);
        }
        else
        {
            basic_compact_json_encoder<CharT> encoder(os, options);
            encode_json(val, encoder);
        }
    }

    template <class T, class CharT>
    void encode_json(const T& val, 
                     basic_json_visitor<CharT>& encoder)
    {
        std::error_code ec;
        ser_traits<T,CharT>::serialize(val, encoder, basic_json<CharT>(), ec);
        if (ec)
        {
            JSONCONS_THROW(ser_error(ec));
        }
        encoder.flush();
    }

    template <class T, class CharT, class TempAllocator>
    void encode_json(temp_allocator_arg_t, const TempAllocator& temp_alloc,
                     const T& val, 
                     std::basic_string<CharT>& s, 
                     indenting line_indent = indenting::no_indent)
    {
        encode_json(temp_allocator_arg, temp_alloc, val, s, basic_json_encode_options<CharT>(), line_indent);
    }

    template <class T, class CharT, class TempAllocator>
    typename std::enable_if<is_basic_json<T>::value>::type
    encode_json(temp_allocator_arg_t, const TempAllocator& temp_alloc,
                const T& val,
                std::basic_string<CharT>& s, 
                const basic_json_encode_options<CharT>& options, 
                indenting line_indent = indenting::no_indent)
    {
        if (line_indent == indenting::indent)
        {
            basic_json_encoder<CharT,jsoncons::string_sink<std::basic_string<CharT>>,TempAllocator> encoder(s, options, temp_alloc);
            val.dump(encoder);
        }
        else
        {
            basic_compact_json_encoder<CharT, jsoncons::string_sink<std::basic_string<CharT>>,TempAllocator> encoder(s, options, temp_alloc);
            val.dump(encoder);
        }
    }

    template <class T, class CharT, class TempAllocator>
    typename std::enable_if<!is_basic_json<T>::value>::type
    encode_json(temp_allocator_arg_t, const TempAllocator& temp_alloc,
                const T& val,
                std::basic_string<CharT>& s,
                const basic_json_encode_options<CharT>& options, 
                indenting line_indent)
    { 
        if (line_indent == indenting::indent)
        {
            basic_json_encoder<CharT,jsoncons::string_sink<std::basic_string<CharT>>,TempAllocator> encoder(s, options, temp_alloc);
            encode_json(temp_allocator_arg, temp_alloc, val, encoder);
        }
        else
        {
            basic_compact_json_encoder<CharT,jsoncons::string_sink<std::basic_string<CharT>>,TempAllocator> encoder(s, options, temp_alloc);
            encode_json(temp_allocator_arg, temp_alloc, val, encoder);
        }
    }

    template <class T, class CharT, class TempAllocator>
    void encode_json(temp_allocator_arg_t, const TempAllocator& temp_alloc,
                     const T& val, 
                     std::basic_ostream<CharT>& os, 
                     indenting line_indent = indenting::no_indent)
    {
        encode_json(temp_allocator_arg, temp_alloc, val, os, basic_json_encode_options<CharT>(), line_indent);
    }

    template <class T, class CharT, class TempAllocator>
    typename std::enable_if<is_basic_json<T>::value>::type
    encode_json(temp_allocator_arg_t, const TempAllocator& temp_alloc,
                const T& val,
                std::basic_ostream<CharT>& os, 
                const basic_json_encode_options<CharT>& options, 
                indenting line_indent = indenting::no_indent)
    {
        if (line_indent == indenting::indent)
        {
            basic_json_encoder<CharT,jsoncons::stream_sink<CharT>,TempAllocator> encoder(os, options, temp_alloc);
            val.dump(encoder);
        }
        else
        {
            basic_compact_json_encoder<CharT,jsoncons::stream_sink<CharT>,TempAllocator> encoder(os, options, temp_alloc);
            val.dump(encoder);
        }
    }

    template <class T, class CharT, class TempAllocator>
    typename std::enable_if<!is_basic_json<T>::value>::type
    encode_json(temp_allocator_arg_t, const TempAllocator& temp_alloc,
                const T& val,
                std::basic_ostream<CharT>& os, 
                const basic_json_encode_options<CharT>& options, 
                indenting line_indent)
    {
        if (line_indent == indenting::indent)
        {
            basic_json_encoder<CharT> encoder(os, options);
            encode_json(temp_allocator_arg, temp_alloc, val, encoder);
        }
        else
        {
            basic_compact_json_encoder<CharT> encoder(os, options);
            encode_json(temp_allocator_arg, temp_alloc, val, encoder);
        }
    }

    template <class T, class CharT, class TempAllocator>
    typename std::enable_if<!is_basic_json<T>::value>::type
    encode_json(temp_allocator_arg_t, const TempAllocator& temp_alloc,
                const T& val,
                basic_json_visitor<CharT>& encoder)
    {
        std::error_code ec;
        basic_json<CharT,sorted_policy,TempAllocator> context_j(temp_alloc);
        ser_traits<T,CharT>::serialize(val, encoder, context_j, ec);
        if (ec)
        {
            JSONCONS_THROW(ser_error(ec));
        }
        encoder.flush();
    }

} // jsoncons

#endif

