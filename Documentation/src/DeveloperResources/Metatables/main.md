# Metatables

Here, I will try to explain how to use metatables, and how to make them, as well as their uses.

**NOTE:**
The Synapse X Team have made a better version of this, please check it out at these links:

[Objects and Metatables](https://x.synapse.to/docs/development/objects_mts.html)

[Importance of Newcclosure](https://x.synapse.to/docs/development/newcclosure.html)

[Metamethod Hook Examples](https://x.synapse.to/docs/development/metamethod_hook_examples.html)


**Please check those out before reading this!**

#### General Info
Metatables are a special type of tables where they contain certain metamethods. These metamethods can change how the table handles certain operations. Each metamethod has their own unique set amount of arguments that you can learn. 

#### Why would we use them?

Metatables are used more often in OOP (Object Oriented Programming) where for example, if you want to add two tables, you cannot simply do that. You will need to make it into a metatable and change how the __add metamethod works. You may use metatables to create a shape like a square. You could allow the ability to add two squares by their areas, for example. 

#### What are metamethods?

Metamethods are 'special keys' that perform 'special' actions when they are called. For example, lets say we have a table:
```lua
local exampleTable = {
    specialNumber = 1,
}
```
and we get the `specialNumber` from the table and assign it to a variable by doing:
```lua
local exampleTable = {
    specialNumber = 1,
}

local specialNumber = exampleTable["specialNumber"]
```
Believe it or not, we have used two metamethod here.

Firtly, we have used __index. __index is called/fired when you access a key in a table. In this example, the key was `specialNumber`. 

Secondly, we have also used __newindex. __newindex is fired when a new index is added to a table or when an index is changed in a table. For example, the new index was `specialNumber` and the new value is `1`. Within ___newindex, controls how this value is set. 

However, we can edit these metamethods.

#### Editing metamethod/making metatables

We can easily make metatables by using the `setmetatable` function. It accepts two arguments, both being a table. The first argument is the table you want to convert into a metatable and the second argument is a table including the metamethods you want to modify.

Lets make a simple metatable that returns "Hi" when it gets tostringed.

Firstly, make our table.
```lua
local tbl = {}
``` 
Now convert it into a metatable.
```lua
local tbl = {}
tbl = setmetatable(tbl, {

})
```
As of right now, this does nothing. We need to specify what metamethods we want to modify within the second table. 
```lua
local tbl = {}
tbl = setmetatable(tbl, {
    __tostring = function()
        return "Hi"
    end
})
```
We've created our first metatable. When we tostring the table, it will return "Hi". For tostring, the return value must be a string. So, lets test it out!
```lua
local tbl = {}
tbl = setmetatable(tbl, {
    __tostring = function()
        return "Hi"
    end
})
tostring(tbl) --> Hi
```
It works! 

It's really not that hard!

#### Identifying errors

Now that was simple but when you try to do more things, you may run into some certain errors, most notiably, "C Stack Overflow". This error is returned when the metamethod is in a constant loop of being called. Try executing this code:
```lua
local tbl = {Test = "hello"}
setmetatable(tbl, {
    __index = function(t, k)
        return t[k]
    end
})
print(tbl[1])
```
You will get a C Stack Overflow error. This is because __index is fired when you try to get the value of a key from a table and it's using __index to return the correct value but then it needs to use __index again to get the correct value for when __index is called, etc etc. This is very confusing isn't it? Well, it's in a constant loop and it'll this breaks your code. So you usually do not want to use the same metamethod within the same metamethod. In this example, **do not use __index in __index**.

#### Ending

If you wish to check out all of the possible metamethods you can use then you can go to the [lua wiki](http://lua-users.org/wiki/MetatableEvents). Hopefully this introduced you into what metatables and metamethods are. If you have any questions then please ask me on Discord @ Stefanuk12#5820. 

Note: ROBLOX does have extra metamethods, for example, __namecall. 
