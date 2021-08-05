# Index Example
Here is an example silent aim, it will work on some games that purely use the Mouse's `Hit` and `Target` properties.

```lua
-- // Load Aiming Module
local Aiming = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Aiming/Module.lua"))()

-- // Hook
local __index
__index = hookmetamethod(game, "__index", function(t, k)
    -- // Check if it trying to get our mouse's hit or target
    if (t:IsA("Mouse") and (k == "Hit" or k == "Target")) then
        -- // If we can use the silent aim
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