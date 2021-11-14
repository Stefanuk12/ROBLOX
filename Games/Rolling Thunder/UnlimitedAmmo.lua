-- // Services
local Players = game:GetService("Players")

-- // Vars
local LocalPlayer = Players.LocalPlayer
local Vortex = LocalPlayer.PlayerScripts.Vortex
local sVortex = getsenv(Vortex)

-- // Set reserve ammo as infinite
debug.setupvalue(sVortex.GetAmmoData, 2, 1/0)