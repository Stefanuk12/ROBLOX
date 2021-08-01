-- // Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- // Vars
local LocalPlayer = Players.LocalPlayer
local CharStats = ReplicatedStorage.CharStats

-- // the main thing
local function initialiseInfiniteStamina()
    -- // Get the stamina/walkspeed table
    local u110 = getrenv()._G.S_Get
    local u24 = debug.getupvalue(u110, 2)

    -- //
    local set = setmetatable({WS = 16}, {
        -- // Spoofing value
        __index = function(t, k)
            -- // See when it tries to index S - Stamina
            if (k == "S") then
                -- // Return our spoofed value
                return 100
            end

            -- // Return
            return rawget(t, k)
        end,

        -- // So it cannot set the S attribute
        __newindex = function(t, k, v)
            return
        end
    })

    -- // Set the new table
    debug.setupvalue(u24, 1, set)
    debug.setupvalue(u24, 2, set)
end
initialiseInfiniteStamina()

-- // So it works when you die
LocalPlayer.CharacterAdded:Connect(function(Character)
    -- // Wait until we have fully spawned in
    Character:WaitForChild("Humanoid")

    -- // Initialise
    initialiseInfiniteStamina()
end)