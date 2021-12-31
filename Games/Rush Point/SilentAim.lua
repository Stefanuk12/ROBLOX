-- // Dependencies
local Aiming = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Aiming/Load.lua"))()

-- // Services
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- // Vars
local CurrentCamera = Workspace.CurrentCamera
local WeaponManagerClient = require(ReplicatedStorage.Modules.Client.Managers.WeaponManagerClient)

-- // Hook
local __index
__index = hookfunction(game, "__index", function(t, k)
    -- // Vars
    local callingscript = getcallingscript()

    -- // Check that the weapon manager's shoot function is trying to get the camera's cframe
    if (not checkcaller() and callingscript == WeaponManagerClient and t == CurrentCamera and k == "CFrame" and Aiming.Check() and #debug.getupvalues(2) == 1) then
        -- // Vars
        local Origin = CurrentCamera.CFrame.Position

        -- // Return modified ver
        return CFrame.lookAt(Origin, Aiming.SelectedPart.Position)
    end

    -- //
    return __index(t, k)
end)