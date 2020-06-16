// Copyright 2013 Daniel Parker
// Distributed under the Boost license, Version 1.0.
// (See accompanying file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

// See https://github.com/danielaparker/jsoncons for latest version

#ifndef JSONCONS_DETAIL_STRING_WRAPPER_HPP
#define JSONCONS_DETAIL_STRING_WRAPPER_HPP

#include <stdexcept>
#include <string>
#include <exception>
#include <ostream>
#include <cstring> // std::memcpy
#include <memory> // std::allocator
#include <jsoncons/config/compiler_support.hpp>

namespace jsoncons { 
namespace detail {

    // From boost 1_71
    template <class T, class U>
    T launder_cast(U* u)
    {
    #if defined(__cpp_lib_launder) && __cpp_lib_launder >= 201606
        return std::launder(reinterpret_cast<T>(u));
    #elif defined(__GNUC__) &&  (__GNUC__ * 100 + __GNUC_MINOR__) > 800
        return __builtin_launder(reinterpret_cast<T>(u));
    #else
        return reinterpret_cast<T>(u);
    #endif
    }

    // string_wrapper

    template <class CharT,class Allocator>
    class string_wrapper
    {
    public:
        using char_type = CharT;
    private:
        struct str_base_t
        {
            Allocator alloc_;
        
            Allocator& get_allocator() 
            {
                return alloc_;
            }

            const Allocator& get_allocator() const
            {
                return alloc_;
            }

            str_base_t(const Allocator& alloc)
                : alloc_(alloc)
            {
            }

            ~str_base_t() noexcept = default;
        };

        struct str_t : public str_base_t
        {
            typedef typename std::allocator_traits<Allocator>::template rebind_alloc<CharT> allocator_type;  
            using allocator_traits_type = std::allocator_traits<allocator_type>;
            using pointer = typename allocator_traits_type::pointer;

            pointer p_;
            std::size_t length_;

            ~str_t() noexcept = default; 

            const char_type* c_str() const { return to_plain_pointer(p_); }
            const char_type* data() const { return to_plain_pointer(p_); }
            std::size_t length() const { return length_; }
        
            str_t(const Allocator& alloc)
                : str_base_t(alloc), p_(nullptr), length_(0)
            {

            }

            str_t(const str_t&) = delete;
            str_t& operator=(const str_t&) = delete;

        };

        typedef typename std::allocator_traits<Allocator>::template rebind_alloc<char> byte_allocator_type;  
        using byte_pointer = typename std::allocator_traits<byte_allocator_type>::pointer;

        typedef typename std::allocator_traits<Allocator>::template rebind_alloc<str_t> string_allocator_type;  
        using string_pointer = typename std::allocator_traits<string_allocator_type>::pointer;

        struct storage_t
        {
            str_t data;
            char_type c[1];
        };
        typedef typename std::aligned_storage<sizeof(storage_t), alignof(storage_t)>::type storage_kind;

        string_pointer ptr_;
    public:
        string_wrapper() = default;

        string_wrapper(string_pointer ptr)
            : ptr_(ptr)
        {
        }

        string_wrapper(const char_type* data, std::size_t length, const Allocator& a) 
        {
            ptr_ = create(data,length,a);
        }

        string_wrapper(const string_wrapper& val) 
        {
            ptr_ = create(val.data(),val.length(),val.get_allocator());
        }

        string_wrapper(const string_wrapper& val, const Allocator& a) 
        {
            ptr_ = create(val.data(),val.length(),a);
        }

        ~string_wrapper() noexcept
        {
            if (ptr_ != nullptr)
            {
                destroy(ptr_);
            }
        }

        void swap(string_wrapper& other) noexcept
        {
            std::swap(ptr_,other.ptr_);
        }

        const char_type* data() const
        {
            return ptr_->data();
        }

        const char_type* c_str() const
        {
            return ptr_->c_str();
        }

        std::size_t length() const
        {
            return ptr_->length();
        }

        Allocator get_allocator() const
        {
            return ptr_->get_allocator();
        }
    private:
        static size_t aligned_size(std::size_t n)
        {
            return sizeof(storage_kind) + n;
        }

        static string_pointer create(const char_type* s, std::size_t length, const Allocator& alloc)
        {
            std::size_t mem_size = aligned_size(length*sizeof(char_type));

            byte_allocator_type byte_alloc(alloc);
            byte_pointer ptr = byte_alloc.allocate(mem_size);

            char* storage = to_plain_pointer(ptr);
            str_t* ps = new(storage)str_t(byte_alloc);

            auto psa = launder_cast<storage_t*>(storage); 

            CharT* p = new(&psa->c)char_type[length + 1];
            std::memcpy(p, s, length*sizeof(char_type));
            p[length] = 0;
            ps->p_ = std::pointer_traits<typename str_t::pointer>::pointer_to(*p);
            ps->length_ = length;
            return std::pointer_traits<string_pointer>::pointer_to(*ps);
        }

        static void destroy(string_pointer ptr)
        {
            str_t* rawp = to_plain_pointer(ptr);

            char* p = launder_cast<char*>(rawp);

            std::size_t mem_size = aligned_size(ptr->length_*sizeof(char_type));
            byte_allocator_type byte_alloc(ptr->get_allocator());
            byte_alloc.deallocate(p,mem_size);
        }
    };

    // tagged_string_wrapper

    template <class CharT,class Allocator>
    class tagged_string_wrapper
    {
    public:
        using char_type = CharT;
    private:
        struct str_base_t
        {
            Allocator alloc_;

            Allocator& get_allocator() 
            {
                return alloc_;
            }

            const Allocator& get_allocator() const
            {
                return alloc_;
            }

            str_base_t(const Allocator& alloc)
                : alloc_(alloc)
            {
            }

            ~str_base_t() noexcept = default;
        };

        struct str_t : public str_base_t
        {
            typedef typename std::allocator_traits<Allocator>::template rebind_alloc<CharT> allocator_type;  
            using allocator_traits_type = std::allocator_traits<allocator_type>;
            using pointer = typename allocator_traits_type::pointer;

            pointer p_;
            std::size_t length_;
            uint64_t tag_;

            ~str_t() noexcept = default; 

            const char_type* c_str() const { return to_plain_pointer(p_); }
            const char_type* data() const { return to_plain_pointer(p_); }
            std::size_t length() const { return length_; }
            uint64_t tag() const { return tag_; }

            str_t(uint64_t tag, const Allocator& alloc)
                : str_base_t(alloc), p_(nullptr), length_(0), tag_(tag)
            {

            }

            str_t(const str_t&) = delete;
            str_t& operator=(const str_t&) = delete;

        };

        typedef typename std::allocator_traits<Allocator>::template rebind_alloc<char> byte_allocator_type;  
        using byte_pointer = typename std::allocator_traits<byte_allocator_type>::pointer;

        typedef typename std::allocator_traits<Allocator>::template rebind_alloc<str_t> string_allocator_type;  
        using string_pointer = typename std::allocator_traits<string_allocator_type>::pointer;

        struct storage_t
        {
            str_t data;
            char_type c[1];
        };
        typedef typename std::aligned_storage<sizeof(storage_t), alignof(storage_t)>::type storage_kind;

        string_pointer ptr_;
    public:
        tagged_string_wrapper() = default;

        tagged_string_wrapper(string_pointer ptr)
            : ptr_(ptr)
        {
        }

        tagged_string_wrapper(const char_type* data, std::size_t length, uint64_t tag, const Allocator& alloc) 
        {
            ptr_ = create(data, length, tag, alloc);
        }

        tagged_string_wrapper(const tagged_string_wrapper& val) 
        {
            ptr_ = create(val.data(), val.length(), val.tag(), val.get_allocator());
        }

        tagged_string_wrapper(const tagged_string_wrapper& val, const Allocator& alloc) 
        {
            ptr_ = create(val.data(), val.length(), val.tag(), alloc);
        }

        ~tagged_string_wrapper() noexcept
        {
            if (ptr_ != nullptr)
            {
                destroy(ptr_);
            }
        }

        void swap(tagged_string_wrapper& other) noexcept
        {
            std::swap(ptr_,other.ptr_);
        }

        const char_type* data() const
        {
            return ptr_->data();
        }

        const char_type* c_str() const
        {
            return ptr_->c_str();
        }

        std::size_t length() const
        {
            return ptr_->length();
        }

        uint64_t tag() const
        {
            return ptr_->tag();
        }

        Allocator get_allocator() const
        {
            return ptr_->get_allocator();
        }
    private:
        static size_t aligned_size(std::size_t n)
        {
            return sizeof(storage_kind) + n;
        }

        static string_pointer create(const char_type* s, std::size_t length, uint64_t tag, const Allocator& alloc)
        {
            std::size_t mem_size = aligned_size(length*sizeof(char_type));

            byte_allocator_type byte_alloc(alloc);
            byte_pointer ptr = byte_alloc.allocate(mem_size);

            char* storage = to_plain_pointer(ptr);
            str_t* ps = new(storage)str_t(tag, byte_alloc);

            auto psa = launder_cast<storage_t*>(storage); 

            CharT* p = new(&psa->c)char_type[length + 1];
            std::memcpy(p, s, length*sizeof(char_type));
            p[length] = 0;
            ps->p_ = std::pointer_traits<typename str_t::pointer>::pointer_to(*p);
            ps->length_ = length;
            return std::pointer_traits<string_pointer>::pointer_to(*ps);
        }

        static void destroy(string_pointer ptr)
        {
            str_t* rawp = to_plain_pointer(ptr);

            char* p = launder_cast<char*>(rawp);

            std::size_t mem_size = aligned_size(ptr->length_*sizeof(char_type));
            byte_allocator_type byte_alloc(ptr->get_allocator());
            byte_alloc.deallocate(p,mem_size);
        }
    };

} // namespace detail
} // namespace jsoncons

#endif
