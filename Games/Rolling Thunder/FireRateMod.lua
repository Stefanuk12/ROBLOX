-- // Services
local Players = game:GetService("Players")

-- // Vars
local LocalPlayer = Players.LocalPlayer
local Vortex = LocalPlayer.PlayerScripts.Vortex
local sVortex = getsenv(Vortex)

-- // Set the fire rate to 1000
debug.setupvalue(sVortex.GatherWeaponData, 4, 1000)