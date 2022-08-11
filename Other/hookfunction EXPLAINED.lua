--[[
    Please make sure you know the basics before doing anything too complex.

    Basics:
    - Watch YT Videos
    - Learn through experience
        - Set a goal, a feature you want to make on an easy, simple game.
            The feature would make your life easier. For example, instead of walking to the sell area, teleport to it instead when you press a key.
                - Do not start on a game like Phantom Forces - it is simply too complex.
        - Keep on making it
        - You get more knowledgable with Lua through more experience
]]

--[[
    hookfunction.

    This function takes two arguments. What it does is call the second function when the first one is called.
    For example, when I call

    function a()
        print("Hello")
    end

    it would call

    function b()
        print("Goodbye")
    end

    instead. As a result, instead of printing Hello, it prints Goodbye. See the full example below
]]

local function Hello()
    print("Hello")
end

local function Goodbye()
    print("Goodbye")
end

hookfunction(Hello, Goodbye)
Hello() -- // Goodbye

--[[
    Whenever the game goes to call Hello, it calls Goodbye instead. Therefore, Goodbye is printed instead of Hello.
]]

--[[
    Observe the following function

    local function Magic(text)
        return text:reverse() 
    end

    How could we change text to be whatever we want, AND have the function carry its normal functionality? Essentially, always overwriting what text is.
    
    Firstly, hookfunction returns the "old" function. This is the first function BEFORE it has been hooked. We can use this to allow it to continue as normal.
    Look at the following hook
]]

local function Magic(text)
    return text:reverse() 
end

local old
old = hookfunction(Magic, function(text)
    text = "Hello"

    return old(text)
end)

print(Magic("Goodbye")) -- // olleH

--[[
    The function goes to call Magic, but it calls our own function instead. This function then overwrites the existing text and returns the result from the "old" function.
    The old function is Magic before it has been hooked.
]]

--[[
    Note: You want to make sure that the number of arguments possible in the original function, matches yours.
]]

--[[
    You may stumble into some errors along the way. Try to execute the following script
]]

local function NoUpvalues()
    return "Hello"
end

local old
old = hookfunction(NoUpvalues, function()
    return old()
end)

--[[
    This will error. Even though we did not modify the function in anyway, it errors. It errors with the error of "too many upvalues". What is an upvalue?

    An upvalue is a variable that has been referenced in a different scope. For example

    local upvalue = 3
    local function ChangeUpvalue(Value)
        upvalue = Value
    end

    upvalue becomes an upvalue since it was referenced in a different scope. There's the "main" scope, then the function "ChangeUpvalue" scope which are separete.
    Any variables inside the ChangeUpvalue scope cannot be accessed by the main scope. But any main variables can be accessed in ChangeUpvalue. This is because
    its scope is lower. Whenever we accessed a variable in a higher scope, we go up and therefore that variable becomes an UPvalue.

    It is important to note that "upvalue" is only an upvalue in the "ChangeUpvalue" function. It is not an upvalue in the context of the scope it was defined in.

    Generally, if a function has at least one upvalue, you can hook it and have as many upvalues as you want. However, if it has 0 then you cannot have any upvalues at all.

    Below is an example of using unlimited upvalues in a hookfunction that only has one.
]]

local uv1, uv2, uv3
local old
local function Hook()
    uv1, uv2, uv3 = 0, 0, 0

    return old()
end

local hookuv = "Hello"
local function ToHook()
    hookuv = "Goodbye"
end

old = hookfunction(ToHook, function()
    return Hook()
end)

--[[
    Note: uv = upvalue

    Now this code is obviously non-sensical. It has no purpose. However, it shows you something. When we hook the function, we technically only have one upvalue.
    That one upvalue is the "Hook" function. Therefore it works!
]]

--[[
    That is hookfunction explained. Any questions? Please let me know!
]]
