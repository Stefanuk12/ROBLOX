-- // Load Aiming Module
local Aiming = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Aiming/Module.lua"))()

-- // Services
local Workspace = game:GetService("Workspace")

-- // Vars
local CurrentCamera = Workspace.CurrentCamera

-- // Hook
local __index
__index = hookmetamethod(game, "__index", function(t, k)
    -- // Check if it trying to get our mouse's unitray and see if we can use the aiming
    if (not checkcaller() and t:IsA("Mouse") and k == "UnitRay" and Aiming.Check()) then
        -- // Vars
        local TargetPart = Aiming.SelectedPart

        -- // Ray Vars
        local Origin = CurrentCamera.CFrame.Position
        local Destination = TargetPart.Position
        local Direction = (Destination - Origin).Unit

        -- // Create fake ray
        local FakeRay = Ray.new(Origin, Direction)

        -- // Return it
        return FakeRay
    end

    -- // Return
    return __index(t, k)
end)