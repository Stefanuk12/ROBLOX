// Copyright 2013-2016 Daniel Parker
// Distributed under the Boost license, Version 1.0.
// (See accompanying file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

// See https://github.com/danielaparker/jsoncons for latest version

#ifndef JSONCONS_JSON_DECODER_HPP
#define JSONCONS_JSON_DECODER_HPP

#include <string>
#include <vector>
#include <type_traits> // std::true_type
#include <memory> // std::allocator
#include <iterator> // std::make_move_iterator
#include <utility> // std::move
#include <jsoncons/json_exception.hpp>
#include <jsoncons/json_visitor.hpp>

namespace jsoncons {

template <class Json,class TempAllocator=std::allocator<char>>
class json_decoder final : public basic_json_visitor<typename Json::char_type>
{
public:
    using char_type = typename Json::char_type;
    using typename basic_json_visitor<char_type>::string_view_type;

    using key_value_type = typename Json::key_value_type;
    using key_type = typename Json::key_type;
    using array = typename Json::array;
    using object = typename Json::object;
    using result_allocator_type = typename Json::allocator_type;
    using json_string_allocator = typename key_type::allocator_type;
    using json_array_allocator = typename array::allocator_type;
    using json_object_allocator = typename object::allocator_type;
    typedef typename std::allocator_traits<result_allocator_type>:: template rebind_alloc<uint8_t> json_byte_allocator_type;
private:
    struct stack_item
    {
        key_type name_;
        Json value_;

        template <class... Args>
        stack_item(key_type&& name, Args&& ... args)
            : name_(std::move(name)), value_(std::forward<Args>(args)...)
        {
        }

        stack_item() = default;
        stack_item(const stack_item&) = default;
        stack_item(stack_item&&) = default;
        stack_item& operator=(const stack_item&) = default;
        stack_item& operator=(stack_item&&) = default;
    };

    enum class structure_type {root_t, array_t, object_t};

    struct structure_info
    {
        structure_type type_;
        std::size_t container_index_;

        structure_info(structure_type type, std::size_t offset)
            : type_(type), container_index_(offset)
        {
        }

    };

    using temp_allocator_type = TempAllocator;
    typedef typename std::allocator_traits<temp_allocator_type>:: template rebind_alloc<stack_item> stack_item_allocator_type;
    typedef typename std::allocator_traits<temp_allocator_type>:: template rebind_alloc<structure_info> structure_info_allocator_type;
 
    json_string_allocator string_allocator_;
    json_byte_allocator_type byte_allocator_;
    json_object_allocator object_allocator_;
    json_array_allocator array_allocator_;
    stack_item_allocator_type stack_item_allocator_;
    structure_info_allocator_type size_t_allocator_;

    Json result_;

    key_type name_;
    std::vector<stack_item,stack_item_allocator_type> item_stack_;
    std::vector<structure_info,structure_info_allocator_type> structure_stack_;
    bool is_valid_;

public:
    json_decoder(const temp_allocator_type& temp_alloc = temp_allocator_type())
        : string_allocator_(result_allocator_type()),
          byte_allocator_(result_allocator_type()),
          object_allocator_(result_allocator_type()),
          array_allocator_(result_allocator_type()),
          stack_item_allocator_(temp_alloc),
          size_t_allocator_(temp_alloc),
          result_(),
          name_(string_allocator_),
          item_stack_(stack_item_allocator_),
          structure_stack_(size_t_allocator_),
          is_valid_(false) 

    {
        item_stack_.reserve(1000);
        structure_stack_.reserve(100);
        structure_stack_.emplace_back(structure_type::root_t, 0);
    }

    json_decoder(result_allocator_arg_t,
                 const result_allocator_type& result_alloc)
        : string_allocator_(result_alloc),
          byte_allocator_(result_alloc),
          object_allocator_(result_alloc),
          array_allocator_(result_alloc),
          stack_item_allocator_(),
          size_t_allocator_(),
          result_(),
          name_(string_allocator_),
          item_stack_(),
          structure_stack_(),
          is_valid_(false) 

    {
        item_stack_.reserve(1000);
        structure_stack_.reserve(100);
        structure_stack_.emplace_back(structure_type::root_t, 0);
    }

    json_decoder(result_allocator_arg_t,
                 const result_allocator_type& result_alloc, 
                 const temp_allocator_type& temp_alloc)
        : string_allocator_(result_alloc),
          byte_allocator_(result_alloc),
          object_allocator_(result_alloc),
          array_allocator_(result_alloc),
          stack_item_allocator_(temp_alloc),
          size_t_allocator_(temp_alloc),
          result_(),
          name_(string_allocator_),
          item_stack_(stack_item_allocator_),
          structure_stack_(size_t_allocator_),
          is_valid_(false) 

    {
        item_stack_.reserve(1000);
        structure_stack_.reserve(100);
        structure_stack_.emplace_back(structure_type::root_t, 0);
    }

    void reset()
    {
        is_valid_ = false;
        item_stack_.clear();
        structure_stack_.clear();
        structure_stack_.emplace_back(structure_type::root_t, 0);
    }

    bool is_valid() const
    {
        return is_valid_;
    }

    Json get_result()
    {
        is_valid_ = false;
        return std::move(result_);
    }

#if !defined(JSONCONS_NO_DEPRECATED)
    JSONCONS_DEPRECATED_MSG("Instead, use get_result()")
    Json& root()
    {
        return result_;
    }
#endif

private:

    void visit_flush() override
    {
    }

    bool visit_begin_object(semantic_tag tag, const ser_context&, std::error_code&) override
    {
        if (structure_stack_.back().type_ == structure_type::root_t)
        {
            item_stack_.clear();
            is_valid_ = false;
        }
        item_stack_.emplace_back(std::forward<key_type>(name_), json_object_arg, tag, object_allocator_);
        structure_stack_.emplace_back(structure_type::object_t, item_stack_.size()-1);
        return true;
    }

    bool visit_end_object(const ser_context&, std::error_code&) override
    {
        JSONCONS_ASSERT(structure_stack_.size() > 0);
        JSONCONS_ASSERT(structure_stack_.back().type_ == structure_type::object_t);
        const size_t structure_index = structure_stack_.back().container_index_;
        JSONCONS_ASSERT(item_stack_.size() > structure_index);
        const size_t count = item_stack_.size() - (structure_index + 1);
        auto first = item_stack_.begin() + (structure_index+1);
        auto last = first + count;
        item_stack_[structure_index].value_.object_value().insert(
            std::make_move_iterator(first),
            std::make_move_iterator(last),
            [](stack_item&& val){return key_value_type(std::move(val.name_), std::move(val.value_));}
        );
        item_stack_.erase(item_stack_.begin()+structure_index+1, item_stack_.end());
        structure_stack_.pop_back();
        if (structure_stack_.back().type_ == structure_type::root_t)
        {
            result_.swap(item_stack_.front().value_);
            item_stack_.pop_back();
            is_valid_ = true;
            return false;
        }
        return true;
    }

    bool visit_begin_array(semantic_tag tag, const ser_context&, std::error_code&) override
    {
        if (structure_stack_.back().type_ == structure_type::root_t)
        {
            item_stack_.clear();
            is_valid_ = false;
        }
        item_stack_.emplace_back(std::forward<key_type>(name_), json_array_arg, tag, array_allocator_);
        structure_stack_.emplace_back(structure_type::array_t, item_stack_.size()-1);
        return true;
    }

    bool visit_end_array(const ser_context&, std::error_code&) override
    {
        JSONCONS_ASSERT(structure_stack_.size() > 1);
        JSONCONS_ASSERT(structure_stack_.back().type_ == structure_type::array_t);
        const size_t container_index = structure_stack_.back().container_index_;
        JSONCONS_ASSERT(item_stack_.size() > container_index);

        auto& container = item_stack_[container_index].value_;

        const size_t size = item_stack_.size() - (container_index + 1);
        //std::cout << "size on item stack: " << size << "\n";

        if (size > 0)
        {
            container.reserve(size);
            auto first = item_stack_.begin() + (container_index+1);
            auto last = first + size;
            for (auto it = first; it != last; ++it)
            {
                container.push_back(std::move(it->value_));
            }
            item_stack_.erase(first, item_stack_.end());
        }

        structure_stack_.pop_back();
        if (structure_stack_.back().type_ == structure_type::root_t)
        {
            result_.swap(item_stack_.front().value_);
            item_stack_.pop_back();
            is_valid_ = true;
            return false;
        }
        return true;
    }

    bool visit_key(const string_view_type& name, const ser_context&, std::error_code&) override
    {
        name_ = key_type(name.data(),name.length(),string_allocator_);
        return true;
    }

    bool visit_string(const string_view_type& sv, semantic_tag tag, const ser_context&, std::error_code&) override
    {
        switch (structure_stack_.back().type_)
        {
            case structure_type::object_t:
            case structure_type::array_t:
                item_stack_.emplace_back(std::forward<key_type>(name_), sv, tag, string_allocator_);
                break;
            case structure_type::root_t:
                result_ = Json(sv, tag, string_allocator_);
                is_valid_ = true;
                return false;
        }
        return true;
    }

    bool visit_byte_string(const byte_string_view& b, 
                           semantic_tag tag, 
                           const ser_context&,
                           std::error_code&) override
    {
        switch (structure_stack_.back().type_)
        {
            case structure_type::object_t:
            case structure_type::array_t:
                item_stack_.emplace_back(std::forward<key_type>(name_), byte_string_arg, b, tag, byte_allocator_);
                break;
            case structure_type::root_t:
                result_ = Json(byte_string_arg, b, tag, byte_allocator_);
                is_valid_ = true;
                return false;
        }
        return true;
    }

    bool visit_byte_string(const byte_string_view& b, 
                           uint64_t ext_tag, 
                           const ser_context&,
                           std::error_code&) override
    {
        switch (structure_stack_.back().type_)
        {
            case structure_type::object_t:
            case structure_type::array_t:
                item_stack_.emplace_back(std::forward<key_type>(name_), byte_string_arg, b, ext_tag, byte_allocator_);
                break;
            case structure_type::root_t:
                result_ = Json(byte_string_arg, b, ext_tag, byte_allocator_);
                is_valid_ = true;
                return false;
        }
        return true;
    }

    bool visit_int64(int64_t value, 
                        semantic_tag tag, 
                        const ser_context&,
                        std::error_code&) override
    {
        switch (structure_stack_.back().type_)
        {
            case structure_type::object_t:
            case structure_type::array_t:
                item_stack_.emplace_back(std::forward<key_type>(name_), value, tag);
                break;
            case structure_type::root_t:
                result_ = Json(value,tag);
                is_valid_ = true;
                return false;
        }
        return true;
    }

    bool visit_uint64(uint64_t value, 
                         semantic_tag tag, 
                         const ser_context&,
                         std::error_code&) override
    {
        switch (structure_stack_.back().type_)
        {
            case structure_type::object_t:
            case structure_type::array_t:
                item_stack_.emplace_back(std::forward<key_type>(name_), value, tag);
                break;
            case structure_type::root_t:
                result_ = Json(value,tag);
                is_valid_ = true;
                return false;
        }
        return true;
    }

    bool visit_half(uint16_t value, 
                       semantic_tag tag,   
                       const ser_context&,
                       std::error_code&) override
    {
        switch (structure_stack_.back().type_)
        {
            case structure_type::object_t:
            case structure_type::array_t:
                item_stack_.emplace_back(std::forward<key_type>(name_), half_arg, value, tag);
                break;
            case structure_type::root_t:
                result_ = Json(half_arg, value, tag);
                is_valid_ = true;
                return false;
        }
        return true;
    }

    bool visit_double(double value, 
                         semantic_tag tag,   
                         const ser_context&,
                         std::error_code&) override
    {
        switch (structure_stack_.back().type_)
        {
            case structure_type::object_t:
            case structure_type::array_t:
                item_stack_.emplace_back(std::forward<key_type>(name_), value, tag);
                break;
            case structure_type::root_t:
                result_ = Json(value, tag);
                is_valid_ = true;
                return false;
        }
        return true;
    }

    bool visit_bool(bool value, semantic_tag tag, const ser_context&, std::error_code&) override
    {
        switch (structure_stack_.back().type_)
        {
            case structure_type::object_t:
            case structure_type::array_t:
                item_stack_.emplace_back(std::forward<key_type>(name_), value, tag);
                break;
            case structure_type::root_t:
                result_ = Json(value, tag);
                is_valid_ = true;
                return false;
        }
        return true;
    }

    bool visit_null(semantic_tag tag, const ser_context&, std::error_code&) override
    {
        switch (structure_stack_.back().type_)
        {
            case structure_type::object_t:
            case structure_type::array_t:
                item_stack_.emplace_back(std::forward<key_type>(name_), null_type(), tag);
                break;
            case structure_type::root_t:
                result_ = Json(null_type(), tag);
                is_valid_ = true;
                return false;
        }
        return true;
    }
};

}

#endif
