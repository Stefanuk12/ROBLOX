-- // Load Silent Aim
local Aiming = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Aiming/Module.lua"))()
Aiming.TeamCheck(false)

-- // Services
local Workspace = game:GetService("Workspace")

-- // Vars
local CurrentCamera = Workspace.CurrentCamera

-- // Hook
local __index
__index = hookmetamethod(game, "__index", function(t, k)
    -- // Vars
    local callingscript = getcallingscript()

    -- // Check if it trying to get our mouse's hit or target
    if (t:IsA("Mouse") and (k == "X" or k == "Y") and tostring(callingscript) ~= "MouseScript") then
        -- // If we can use the silent aim
        if (Aiming.Check()) then
            -- // Vars
            local TargetPart = Aiming.SelectedPart
            local vector, _ = CurrentCamera:WorldToScreenPoint(TargetPart.Position)

            -- // Return modded val
            return (k == "X" and vector.X or vector.Y)
        end
    end

    -- // Return
    return __index(t, k)
end)