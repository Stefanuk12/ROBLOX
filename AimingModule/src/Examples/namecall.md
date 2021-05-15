# Namecall Example
This is a framework to build your own silent aim.

```lua
-- // Metatable Variables
local mt = getrawmetatable(game)
local __namecall = mt.__index
setreadonly(mt, false)

-- // Load Silent Aim
local Aiming = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Aiming/Module.lua"))()

-- // Hook
mt.__namecall = newcclosure(function(...)
    -- // Vars
    local args = {...}
    local method = getnamecallmethod()

    -- // Checks
    if (method == "FireServer") then
        if (args[1].Name == "RemoteNameHere" and Aiming.Check()) then
            -- // Vars
            local SelectedPart = Aiming.SelectedPart
    
            -- // Change the arguments here, for example:
            args[2].Target = SelectedPart

            -- // Return changed arguments
            return backupnamecall(unpack(args))
        end
    end

    -- // Return
    return __namecall(...)
end)
```