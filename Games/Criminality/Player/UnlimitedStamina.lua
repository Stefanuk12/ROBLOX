-- // Services
local Players = game:GetService("Players")

-- // Vars
local LocalPlayer = Players.LocalPlayer

-- // the main thing
local function initialiseInfiniteStamina()
    -- // Get the stamina/walkspeed table
    local u110 = getrenv()._G.S_Get
    local u24 = debug.getupvalue(u110, 2)

    -- // Spoofing
    local set = setmetatable({}, {
        -- // Spoofing value
        __index = function(t, k)
            -- // See when it tries to index S - Stamina
            if (k == "S") then
                -- // Return our spoofed value
                return 100
            elseif (k == "WS") then -- // See when it tries to index WS - WalkSpeed, disabled atm
                -- // Return our spoofed value
                return 25
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