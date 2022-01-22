-- // Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- // Vars
local LocalPlayer = Players.LocalPlayer

local KillsNeeded = LocalPlayer.PlayerGui["Kills Required GUI"].Frame.Kills
local Kills = LocalPlayer.leaderstats.Kills
local Events = ReplicatedStorage.Events

-- // See when we get a kill
Kills.Changed:Connect(function(value)
    -- // Vars
    local Needed = tonumber(KillsNeeded.Text)

    -- // Make sure we have enough
    if not (value >= Needed) then
        return
    end

    -- // Attempt rank up
    Events.AttemptToRankUp_Event:FireServer()
end)