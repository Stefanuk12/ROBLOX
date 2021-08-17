-- // Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- // Vars
local LocalPlayer = Players.LocalPlayer
local Manager = {} -- // Contains every player

-- // Get character
local getCharacter = function(Player)
    return Player.Character
end

-- // Dynamic Offset function
local function dynamicOffset(Midpoint, BoxCFrame)
    local BottomLeft = BoxCFrame[3] + Vector3.new(0, -0.5, 0)
    local MidpointPosition = Midpoint.Position

    local Position = Vector3.new(MidpointPosition.X, BottomLeft.Position.Y, MidpointPosition.Z)
    return CFrame.new(Position, BottomLeft.LookVector)
end

-- // Initialise ESP for that player
local initialisePlayer = function(Player)
    -- // Create the ESP Objects
    local Box = ESP:Box({Model = Player.Character})
    local HealthBar = ESP:HealthBar({Model = Player.Character})
    local Header = ESP:Header({Model = Player.Character, Offset = dynamicOffset})
    local Tracer = ESP:Tracer({Model = Player.Character})

    -- // Add to manager
    table.insert(Manager, {Player, {Box, HealthBar, Header, Tracer}})
end

-- // Deinitialise ESP for that player
local deinitialisePlayer = function(Player)
    for i, Object in ipairs(Manager) do
        -- // Check for player
        if not (Object[1] == Player) then
            continue
        end

        -- // Remove each object
        local ESPObjects = Object[2]
        for x = 1, #ESPObjects do
            local ESPObject = ESPObjects[x]
            ESPObject:Remove()
        end

        -- // Remove from table
        table.remove(Manager, i)

        -- // Break
        break
    end
end

-- // Initialise for existing players
do
    local AllPlayers = game:GetService("Players"):GetPlayers()
    for _, Player in ipairs(AllPlayers) do
        -- // Skip LocalPlayer
        if (Player == LocalPlayer) then
            continue
        end

        -- // Initialise the player
        initialisePlayer(Player)
    end
end

-- // Initialise for new players
Players.PlayerAdded:Connect(initialisePlayer)

-- // Deinitialise left players
Players.PlayerRemoving:Connect(deinitialisePlayer)

-- // Update loop
RunService:BindToRenderStep("ESPUpdate", 0, function()
    -- // Loop through manager
    for _, Object in ipairs(Manager) do
        -- // Vars
        local Character = getCharacter(Object[1])

        -- // Check character
        if not (Character) then
            continue
        end

        -- //
        local Humanoid = Character.Humanoid

        -- // Update every ESP Object
        local ESPObjects = Object[2]
        for _, ESPObject in ipairs(ESPObjects) do
            if (ESPObject.ClassName == "HealthBar" and Humanoid) then
                local HealthPercentage = Humanoid.Health / Humanoid.MaxHealth
                ESPObject:Update({Model = Character, HealthPercentage = HealthPercentage})
            else
                ESPObject:Update({Model = Character})
            end
        end
    end
end)