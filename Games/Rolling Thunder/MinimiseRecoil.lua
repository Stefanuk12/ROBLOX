-- // Services
local Players = game:GetService("Players")

-- // Vars
local LocalPlayer = Players.LocalPlayer
local Vortex = LocalPlayer.PlayerScripts.Vortex
local sVortex = getsenv(Vortex)

-- // Loop through stuff idk what to call it
for i, v in pairs(debug.getupvalue(sVortex.GatherWeaponData, 10)) do
    -- // Just in case
    if (typeof(v) == "table") then
        -- // Set base velocity to -100
        v.BaseVelocity = -100
    end
end