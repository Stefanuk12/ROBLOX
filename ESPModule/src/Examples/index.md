# Index Example
Here is an example silent aim, it will work on some games that purely use the Mouse's `Hit` and `Target` properties.

```lua
-- // Metatable Variables
local mt = getrawmetatable(game)
local __index = mt.__index
setreadonly(mt, false)

-- // Load Silent Aim
local Aiming = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Aiming/Module.lua"))()

-- // Hook
mt.__index = newcclosure(function(t, k)
    -- // Check if it trying to get our mouse's hit or target
    if (t:IsA("Mouse") and (k == "Hit" or k == "Target")) then
        -- // If we have a target and if it is enabled
        if (Aiming.Check()) then
            -- // Vars
            local TargetPart = Aiming.SelectedPart

            -- // Return modded val
            return (k == "Hit" and TargetPart.CFrame or TargetPart)
        end
    end

    -- // Return
    return __index(t, k)
end)
```