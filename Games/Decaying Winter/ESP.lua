-- // Information
--[[
    UNTESTED
]]

-- // Dependencies
local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/ESP/Rewrite.lua"))()

-- // Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- // Vars
local Manager = {} -- // Contains every NPC

-- // Initialise ESP for that player
local initialiseNPC = function(NPC)
    -- // Make sure is NPC
    if not (NPC.Name:find("AI")) then
        return
    end

    -- // Convert
    NPC = NPC:WaitForChild("npc").Value

    -- // Create the ESP Objects
    local Box = ESP:Box({Model = NPC})
    local Header = ESP:Header({Model = NPC})
    local Tracer = ESP:Tracer({Model = NPC})

    -- // Add to manager
    table.insert(Manager, {NPC, {Box, Header, Tracer}})
end

-- // Deinitialise ESP for that NPC
local deinitialiseNPC = function(NPC)
    -- // Make sure is NPC
    if not (NPC.Name:find("AI")) then
        return
    end

    -- // Convert
    NPC = NPC:WaitForChild("npc").Value

    -- // Find NPC in manager
    for i, Object in ipairs(Manager) do
        -- // Check for NPC
        if not (Object[1] == NPC) then
            continue
        end

        -- // Remove each object
        local ESPObjects = Object[2]
        for _, ESPObject in ipairs(ESPObjects) do
            ESPObject:Remove()
        end

        -- // Remove from table
        table.remove(Manager, i)

        -- // Break
        break
    end
end

-- // Initialise for existing NPCs
do
    for _, NPC in ipairs(Players:GetChildren()) do
        -- // Skip non-NPCs
        if not (NPC.Name:find("AI")) then
            continue
        end

        -- // Initialise the NPC
        initialiseNPC(NPC)
    end
end

-- // Initialise for new NPC
Players.ChildAdded:Connect(initialiseNPC)

-- // Deinitialise old NPCs
Players.ChildRemoved:Connect(deinitialiseNPC)

-- // Update loop
RunService:BindToRenderStep("ESPUpdate", 0, function()
    -- // Loop through manager
    for _, Object in ipairs(Manager) do
        local NPC = Object[1]

        -- // Update every ESP Object
        local ESPObjects = Object[2]
        for _, ESPObject in ipairs(ESPObjects) do
            ESPObject:Update({Model = NPC})
        end
    end
end)