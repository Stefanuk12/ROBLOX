-- // Dependencies
local Manager, Base, Signals = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/ESP/Manager.lua"))()

-- // Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- // Vars
local LocalPlayer = Players.LocalPlayer
local Managers = {}

-- // Create a manager
local PlayerManager = Manager.new()
PlayerManager.__index = PlayerManager

-- // Override
function PlayerManager.new(Data)
    -- // Default
    Data = Data or {}

    -- // Initialise
    local self = setmetatable({}, PlayerManager)

    -- // Set Vars
    self.Filter = Data.Filter or function() return true end
    self.Descendants = Data.Descendants or false

    self.ESPObjects = {}
    self.ConnectionAdded = nil
    self.ConnectionRemoved = nil

    -- // Return
    return self
end

-- // Get character
function PlayerManager.GetCharacter(self, Player)
    return Player.Character
end

-- // Start for a specific player
function PlayerManager.StartPlayer(self, Player)
    -- // Vars
    local Character = self:GetCharacter(Player)

    -- // Create ESP
    local ESPObjects = self:AddObject(Character)
    ESPObjects.Player = Player

    -- // Return
    return ESPObjects
end

-- // Stop a specific player's ESP
function PlayerManager.StopPlayer(self, Player)
    -- // Loop through each Object
    for i, ESPObject in ipairs(self.ESPObjects) do
        -- // Make sure player matches
        if not (Player == ESPObject.Player) then
            continue
        end

        -- // Loop through each Drawing
        for _, DrawingObject in pairs(ESPObject.Drawings) do
            -- // Remove it
            DrawingObject:Remove()
        end

        -- // Remove object from table
        table.remove(self.ESPObjects, i)

        -- // Fire signal
        Signals.ObjectRemoved:Fire(ESPObject, Manager)

        -- // Break
        break
    end
end

-- // Override
function PlayerManager.Start(self, Data)
    Data = Data or {}

    -- // Vars
    local AlreadyStarted = table.find(Managers, self)

    -- // Make sure hasn't already started
    if (AlreadyStarted) then
        return false
    end

    -- // Initialise all current players
    for _, Player in ipairs(Players:GetPlayers()) do
        -- // Make sure isn't Local Player
        if (Player == LocalPlayer) then
            continue
        end

        -- // Initialise
        self:StartPlayer(Player)
    end

    -- // Initialise all new players
    self.PlayerAdded = Players.PlayerAdded:Connect(function(Player)
        self:StartPlayer(Player)
    end)

    -- // Deinitialise old players
    self.PlayerRemoving = Players.PlayerRemoving:Connect(function(Player)
        self:StopPlayer(Player)
    end)

    -- // Add to Managers
    table.insert(Managers, self)

    -- // Return
    return true
end

-- // Override
function PlayerManager.Stop(self)
    -- // Vars
    local AlreadyStarted = table.find(Managers, self)

    -- // Make sure hasn't already started
    if (not AlreadyStarted) then
        return false
    end

    -- // Disable Connections
    self.PlayerAdded:Disconnect()
    self.PlayerRemoving:Disconnect()

    -- // Remove from Managers
    table.remove(Managers, AlreadyStarted)

    -- // Return
    return true
end

-- // Override
function PlayerManager.UpdateAllObjects(self)
    -- // Loop through each Object
    for _, Object in ipairs(self.ESPObjects) do
        -- // Loop through Object Drawings
        for _, DrawingObject in pairs(Object.Drawings) do
            -- // Vars
            local Character = self:GetCharacter(Object.Player)

            -- // Update
            self:UpdateObject(DrawingObject, Character)
        end
    end
end

-- // Constantly update
RunService:BindToRenderStep("PlayerManagerUpdate", 0, function()
    -- // Loop through Managers
    for _, ESPManager in ipairs(Managers) do
        ESPManager:UpdateAllObjects()
    end
end)

-- // Return
return PlayerManager, Base, Signals