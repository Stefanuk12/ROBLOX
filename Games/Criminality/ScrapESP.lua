-- // Load Module
local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/ESP/Rewrite.lua"))()

-- // Services
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

-- // Vars
local Scraps = Workspace.Filter.SpawnedPiles
local Manager = {} -- // Contains every scrap

-- // Dynamic Offset function
local function dynamicOffset(Midpoint, BoxCFrame)
    local BottomLeft = BoxCFrame[3] + Vector3.new(0, -0.5, 0)
    local MidpointPosition = Midpoint.Position

    local Position = Vector3.new(MidpointPosition.X, BottomLeft.Position.Y, MidpointPosition.Z)
    return CFrame.new(Position, BottomLeft.LookVector)
end

-- // Initialise ESP
local initialise = function(Model)
    -- // Create the ESP Objects
    local Box = ESP:Box({Model = Model})
    local Header = ESP:Header({Text = "Scrap", Model = Model, Offset = dynamicOffset})
    local Tracer = ESP:Tracer({Model = Model})

    -- // Add to manager
    table.insert(Manager, {Model, {Box, Header, Tracer}})
end

-- // Deinitialise ESP
local deinitialise = function(Model)
    -- // Loop through manager
    for i, Object in ipairs(Manager) do
        -- // Check for model
        if not (Object[1] == Model) then
            continue
        end

        -- // Update every ESP Object
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

-- // Initialise for existing scraps
do
    local AllScraps = Scraps:GetChildren()
    for _, v in ipairs(AllScraps) do
        initialise(v)
    end
end

-- // Initialise for new safes
Scraps.ChildAdded:Connect(function(child)
    initialise(child)
end)

-- // Deinitialise left players
Scraps.ChildRemoved:Connect(function(child)
    deinitialise(child)
end)

-- // Update loop
RunService:BindToRenderStep("ESPUpdate", 0, function()
    -- // Loop through manager
    for _, Object in ipairs(Manager) do
        -- // Update every ESP Object
        local ESPObjects = Object[2]
        for _, ESPObject in ipairs(ESPObjects) do
            ESPObject:Update()
        end
    end
end)