-- // Rewrite of: https://raw.githubusercontent.com/wally-rblx/funky-friday-autoplay/main/main.lua

-- // Configuration
local FunkySettings = {
    Distance = 95, -- // How close the note has to be until we hit it
    HitChance = 99 -- // Hit 99% of shots
}

-- // Services
local RunService = game:GetService("RunService")

-- // Optimisations
local RenderStepped = RunService.RenderStepped
local RenderSteppedWait = RenderStepped.Wait
local islclosure = islclosure or is_l_closure
local getinfo = getinfo or debug.getinfo
local getconstants = getconstants or debug.getconstants
local mathfloor = math.floor
local Randomnew = Random.new
local mathabs = math.abs

-- // Vars
local Framework

-- // Special Functions
local KeyUp
local KeyDown

-- // Key Mapping
local Map = {[0] = "Left", [1] = "Down", [2] = "Up", [3] = "Right"}

-- // Find Constant
local function findConstant(constants, search)
    -- // Loop through all constants
    for i = 1, #constants do
        -- // Vars
        local constant = constants[i]

        -- // Check if we have found it and return
        if (constant == search) then
            return true
        end
    end

    -- // If not found
    return false
end

-- // Find all the data we need
do
    local gGC = getgc(true)
    for i = 1, #gGC do
        local v = gGC[i]

        -- // Get the Framework
        if (typeof(v) == "table" and rawget(v, "GameUI")) then
            Framework = v
        end

        -- // Get Special Functions
        if (typeof(v) == "function" and islclosure(v)) then
            local functionData = getinfo(v)

            -- // Remove local functions
            if (functionData.name == "") then continue end

            -- // Match for arrow
            if (functionData.source:match("%.Arrows$")) then
                local constants = getconstants(v)

                -- // Find KeyDown
                if (findConstant(constants, "Right") and findConstant(constants, "NewThread")) then
                    KeyDown = v
                end

                -- // Find KeyUp
                if (findConstant(constants, "Multiplier") and findConstant(constants, "MuteVoices")) then
                    KeyUp = v
                end
            end
        end

        -- // Break if found
        if (Framework and KeyUp and KeyDown) then
            break
        end
    end
end

-- // Vars
local UI = Framework.UI

-- // Hit Chance
local calcChance = function(percentage)
    percentage = mathfloor(percentage)
    local chance = mathfloor(Randomnew().NextNumber(Randomnew(), 0, 1) * 100) / 100
    return chance <= percentage / 100
end

-- // Handle new arrow
local function newArrow(Arrow, i)
    -- // Make sure the arrow exists :rolling_eyes:
    if (not Arrow) then return end

    -- // Ignore opponent's arrows
    if (Arrow.Side ~= UI.CurrentSide) then return end

    -- // Hit Chance
    local Chance = calcChance(FunkySettings.HitChance)
    if (not Chance) then return end

    -- // Vars
    local ArrowData = Arrow.Data
    local Position = Map[ArrowData.Position % 4]

    -- // Guard
    if (not Position) then return end

    -- // Get Distance
    local Distance = (1 - mathabs(ArrowData.Time - Framework.SongPlayer.CurrentlyPlaying.TimePosition)) * 100

    -- //
    coroutine.wrap(function()
        -- // Wait for arrow
        repeat RenderSteppedWait(RenderStepped)
            Distance = (1 - mathabs(ArrowData.Time - Framework.SongPlayer.CurrentlyPlaying.TimePosition)) * 100
        until Distance >= FunkySettings.Distance

        -- // Vars
        local waitTime = 0.1

        -- // Key Down
        KeyDown(Position)

        -- // For notes that need to be held down
        if (ArrowData.Length > 0) then
            waitTime = ArrowData.Length
        end

        -- // Wait
        wait(waitTime)

        -- // Key Up
        KeyUp(Position)
    end)()
end

-- // New Arrow
debug.setmetatable(UI.ActiveSections, {
    __newindex = function(t, k, v)
        -- // Set the value
        rawset(t, k, v)

        -- // Handle the arrow hit
        newArrow(v, k)
    end
})

--[[
-- // Constant Loop - you can use this version or you can use the one above
local MarkedArrows = {}
while true do RenderSteppedWait(RenderStepped)
    -- // Var
    local ActiveSections = UI.ActiveSections

    -- // Loop through active sessions
    for _, Arrow in pairs(Framework.UI.ActiveSections) do
        -- // Check if not nil
        if (not Arrow) then continue end

        -- // Ignore opponent's arrows
        if (Arrow.Side ~= UI.CurrentSide) then continue end

        -- // Ignore marked arrows
        if (MarkedArrows[Arrow]) then continue end

        -- // Hit Chance
        local Chance = calcChance(FunkySettings.HitChance)
        if (not Chance) then continue end

        -- // Vars
        local ArrowData = Arrow.Data
        local Position = Map[ArrowData.Position % 4]

        -- // Guard
        if (not Position) then continue end

        -- // Get Distance
        local Distance = (1 - mathabs(ArrowData.Time - Framework.SongPlayer.CurrentlyPlaying.TimePosition)) * 100

        -- // Distance Check
        if (Distance >= FunkySettings.Distance) then
            MarkedArrows[Arrow] = true

            coroutine.wrap(function()
                -- // Vars
                local waitTime = 0.1

                -- // Key Down
                KeyDown(Position)

                -- // For notes that need to be held down
                if (ArrowData.Length > 0) then
                    waitTime = ArrowData.Length
                end

                -- // Wait
                wait(waitTime)

                -- // Key Up
                KeyUp(Position)

                -- // Unmark
                MarkedArrows[Arrow] = nil
            end)()
        end
    end
end
]]

-- //
print("Loaded!")