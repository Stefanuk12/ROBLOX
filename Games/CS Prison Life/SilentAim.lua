-- // Dependencies
local Aiming = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/Aiming/main/Load.lua"))()("Module")
local AimingSelected = Aiming.Selected
local AimingChecks = Aiming.Checks

-- // Hook
local __index
__index = hookmetamethod(game, "__index", function(t, k)
    -- // Check it's trying to get CFrame of the Muzzle and is ready
    if (not checkcaller() and k == "WorldCFrame" and t.Name == "Muzzle" and AimingChecks.IsAvailable()) then
        -- // Return spoofed value
        return CFrame.lookAt(t.WorldPosition, AimingSelected.Part.Position)
    end

    -- // Return
    return __index(t, k)
end)