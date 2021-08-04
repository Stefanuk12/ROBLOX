# Namecall Example
This is a framework to build your own silent aim.

```lua
-- // Load Silent Aim
local Aiming = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Aiming/Module.lua"))()

-- // Hook
local __namecall
__namecall = hookmetamethod(game, "__namecall", function(...)
    -- // Vars
    local args = {...}
    local self = args[1]
    local method = getnamecallmethod()

    -- // Checks
    if (method == "FireServer") then
        if (self.Name == "RemoteNameHere") then
            -- change args

            -- // Return changed arguments
            return __namecall(unpack(args))
        end
    end

    -- // Return
    return __namecall(...)
end)
```