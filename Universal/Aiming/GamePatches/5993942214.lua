--[[
    Information:

    - Rush Point (https://www.roblox.com/games/5993942214/)
]]

-- // Dependencies
local Aiming = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Aiming/Module.lua"))()

-- // Services
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

-- // Vars
local LocalPlayer = Players.LocalPlayer
local GameStats = Workspace.MapFolder.GameStats

-- // Team Check
function Aiming.IsIgnoredTeam(Player)
    -- // Deathmatch check
    if (GameStats.GameMode.Value == "Deathmatch") then
        return false
    end

    -- //
    return (LocalPlayer.PermanentTeam.Value == Player.PermanentTeam.Value)
end

-- // Return
return Aiming