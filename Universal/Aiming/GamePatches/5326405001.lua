--[[
    Information:

    - Base Battles! (https://www.roblox.com/games/5326405001/)
]]

-- // Dependencies
local Aiming = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Aiming/Module.lua"))()

-- // Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- // Vars
local LocalPlayer = Players.LocalPlayer
local Libraries = ReplicatedStorage.Libraries
local Global = require(Libraries.Global)
local Teams = Global.Teams

-- // Team Check
function Aiming.IsIgnoredTeam(Player)
    -- //
    return (Teams[LocalPlayer] == Teams[Player])
end

-- //
return Aiming