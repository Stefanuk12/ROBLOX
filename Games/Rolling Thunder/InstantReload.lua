-- // Services
local Players = game:GetService("Players")

-- // Vars
local LocalPlayer = Players.LocalPlayer
local Vortex = LocalPlayer.PlayerScripts.Vortex
local sVortex = getsenv(Vortex)

-- // Hook the reload and replace it with restock
hookfunction(sVortex.Reload, sVortex.Restock)