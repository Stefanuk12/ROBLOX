-- // Configuration
local Use = {
    Fireball = true,
    BlackHole = true,
    Meteor = true,
}

-- // Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- // Vars
local LocalPlayer = Players.LocalPlayer
local Points = LocalPlayer.leaderstats.Points

local Events = ReplicatedStorage.Events
local Convertion = {
    Fireball = 25,
    BlackHole = 50,
    Meteor = 100
}

-- // See when we get points
Points.Changed:Connect(function(value)
    -- // Vars
    local Needed = 0

    -- // Loop through the config
    for i, v in pairs(Use) do
        -- // See if enabled
        if (v) then
            -- // Add
            Needed = Needed + Convertion[i]
        end
    end

    -- // Make sure we have enough
    if not (value >= Needed) then
        return
    end

    -- // Loop through config
    for i, v in pairs(Use) do
        -- // See if enabled
        if (v) then
            -- // Fire
            Events["AttemptToSpawn" .. i .. "_Event"]:FireServer()
        end
    end
end)