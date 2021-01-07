# Hooking metamethods

Previously, we discussed metatables and metamethods in normal vanilla lua but how about ROBLOX lua? Well in ROBLOX Lua there's a very interesting metamethod called __namecall. __namecall is fired when you use "*:*" on something. For example:
```lua
RemoteEvent:FireServer() -- Example 1
workspace:GetChildren() -- Example 2
```
Uniquely, there's no "set" amount of arguments but there are two main ones. Within a namecall hook, you can get the first argument which is the thing __namecall is being called on. In our example, that would be `RemoteEvent` and `workspace` and then a 'hidden' one called the method. In our example, that would be `FireServer` and `GetChildren`. In normal roblox lua, you cannot simply just get it like that but you need to use a custom function like `getnamecallmethod()`. 

#### What can we do with this?

Anything that uses remotes or namecall on the client can be easily exploited, if a game uses a Kick remote, you can simply block the remote and you will not get kicked or if you want to edit certain arguments like the damage amount you do, you can do that with __namecall. You can also use it to make remote spies and edit the return value of `InvokeServer`. It's amazing what you can do with it.

#### How to hook metamethods
Firstly, we want to get the main game metatable. So we can do it by doing:
```lua
local mt = getmetatable(game)
```
While that may work, that is not how it should be done! The main game metatable has a metamethod that locks it called `__metatable`. This means we can't do anything with it and it "hides" the metatable. Instead we need to use `getrawmetatable`
```lua
local mt = getrawmetatable(game)
```
Now we need to backup the metamethod we are changing to return it in the end or else anything that uses that metamethod, will break:
```lua
local mt = getrawmetatable(game)
local backupnamecall = mt.__namecall
```
Now lets change it! No, we cannot do that! The metatable is also locked, we need to unlock it. We can do this by using the function `setreadonly`.
```lua
local mt = getrawmetatable(game)
local backupnamecall = mt.__namecall
setreadonly(mt, false)
```
Now we can change it, firstly, lets set some base variables inside the hook and return the backup.
```lua
local mt = getrawmetatable(game)
local backupnamecall = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(...)
    local args = {...}
    local method = getnamecallmethod()

    return backupnamecall(...)
end)
```
I've done a lot of things that you may not recognise. Firstly, I've used the function `newcclosure`. This function makes the command inside a C Function, no need to worry about what that exactly means but it means we can avoid detection levels of the hook being applied. Usually that could be detected by doing this:
```lua
local Env = getfenv()

xpcall(function()
    return game:_____()
end, function()
    for i = 0, 10 do
        if getfenv(i) ~= Env then
            warn("Detected metamethod tampering!")
        end
    end
end)
``` 
or
```lua
local OldErr, OldMsg = pcall(function() return game:____() end)

while wait(1) do
    local Err, Msg = pcall(function() return game:____() end)

    if OldErr ~= Err or OldMsg ~= Msg then
        warn("Detected metamethod tampering!")
    end
end
```
Back to our code, now lets make it print all of the things that use __namecall. Note: `checkcaller` checks if the script was executed by the executor or not.
```lua
local mt = getrawmetatable(game)
local backupnamecall = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(...)
    local args = {...}
    local method = getnamecallmethod()
    print('__namecall fired! Self - '..args[1]:GetFullName()..' Checkcaller - '..checkcaller()..' Args:')
    table.foreach(args, print)
    return backupnamecall(...)
end)
```

Now I will show you an anti-kick I made using `hookfunction` and mainly, `__namecall hooking`:
```lua
-- // Vars
local LocalPlayer = game:GetService("Players").LocalPlayer

-- // Base MT Vars + Funs
local mt = getrawmetatable(game)
local backupnamecall = mt.__namecall
setreadonly(mt, false)

-- // Anti kick
hookfunction(LocalPlayer.Kick, warn)
hookfunction(LocalPlayer.kick, warn)

mt.__namecall = newcclosure(function(...)
    if string.lower(getnamecallmethod()) == "kick" then return end
    return backupnamecall(...)
end)
```

That's the end of what I have to explain, for more examples, please visit the Synapse X Guide listed at the top!