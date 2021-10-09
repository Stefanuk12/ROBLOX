-- // Information
--[[
    UNTESTED
]]

-- // Dependencies
local AimingNPC = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Aiming/NPC.lua"))()

-- // Services
local Players = game:GetService("Players")

-- //
AimingNPC.GetNPCs = function()
    -- // Vars
    local NPCs = {}

    -- //
    for _, NPC in ipairs(Players:GetChildren()) do
        -- // Make sure is AI
        if (NPC.Name:find("AI")) then
            NPC = NPC:WaitForChild("npc").Value
            table.insert(NPCs, NPC)
        end
    end

    -- //
    return NPCs
end

-- // Hook
local __index
__index = hookmetamethod(game, "__index", function(t, k)
    -- // Check if it trying to get our mouse's hit or target
    if (t:IsA("Mouse") and (k == "Hit" or k == "Target")) then
        -- // If we can use the silent aim
        if (AimingNPC.Check()) then
            -- // Vars
            local TargetPart = AimingNPC.SelectedPart

            -- // Return modded val
            return (k == "Hit" and TargetPart.CFrame or TargetPart)
        end
    end

    -- // Return
    return __index(t, k)
end)