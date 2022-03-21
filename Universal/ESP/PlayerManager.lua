-- // Dependencies
local Manager, Base = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/ESP/Manager.lua"))()

-- // Services
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

-- // Vars
local CurrentCamera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local Managers = {}

-- // Create a manager
local PlayerManager = Manager:Clone()
do
    -- // Override
    function PlayerManager.__init__(self, Data)
        -- // Default
        Data = Data or {}

        -- // Set Vars
        self.Filter = Data.Filter or function() return true end
        self.UpdateObjectManage = Data.UpdateObjectManage or function(self, ESPObject)
            -- // Data
            local _Data = {}
            local DrawingData = {}

            -- // Vars
            local Character = self:GetCharacter(ESPObject.Player)
            if (not Character) then
                return ESPObject:Update(_Data, DrawingData)
            end
            local Part = Character.PrimaryPart or Character:FindFirstChild("HumanoidRootPart")
            local IsVisible = self:IsVisible(Part, Character)

            -- // Data
            _Data.Object = Character

            -- // Visible Check
            local Settings = self.Settings
            local VisibleCheck = Settings.VisibleCheck
            if (VisibleCheck.Enabled) then
                -- // Vars
                local Distance = (CurrentCamera.CFrame.Position - Part.Position).Magnitude

                -- // All
                DrawingData.Color = IsVisible and VisibleCheck.VisibleColour or VisibleCheck.NotVisibleColour          

                -- // Tracer only
                if (ESPObject.__type == "Tracer") then
                    DrawingData.Transparency = math.clamp(Distance / 200, 0.45, 0.8)
                end
            end

            -- // Update
            ESPObject:Update(_Data, DrawingData)
        end
        self.Descendants = Data.Descendants or false

        self.ESPObjects = {}
        self.ConnectionAdded = nil
        self.ConnectionRemoved = nil

        self.Settings = {
            VisibleCheck = {
                Enabled = true,
                VisibleColour = Color3.fromRGB(152, 251, 152),
                NotVisibleColour = Color3.fromRGB(255, 127, 127)
            }
        }
    end

    -- // Check if a part is visible
    function PlayerManager.IsVisible(self, Part, Descendant)
        -- // Vars
        local Origin = CurrentCamera.CFrame.Position
        local Destination = Part.Position
        local Direction = (Destination - Origin)

        -- // Raycast
        local RaycastParameters = RaycastParams.new()
        RaycastParameters.FilterDescendantsInstances = {CurrentCamera}
        local RaycastResult = Workspace:Raycast(Origin, Direction, RaycastParameters)

        -- // Make sure we got a result
        if (RaycastResult) then
            return Descendant and RaycastResult.Instance:IsDescendantOf(Descendant) or RaycastResult.Instance == Part
        end

        -- //
        return false
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
        local ESPObject = self:AddObject(Character, nil, function(ESPObject)
            -- // Add Player
            ESPObject.Player = Player

            -- // Return
            return ESPObject
        end)

        -- // Return
        return ESPObject
    end

    -- // Stop a specific player's ESP
    function PlayerManager.StopPlayer(self, Player)
        -- // Loop through each Object
        for i = #self.ESPObjects, 1, -1 do
            local ESPObject = self.ESPObjects[i]

            -- // Make sure player matches
            if (Player ~= ESPObject.Player) then
                continue
            end

            -- // Loop through each Drawing
            for _, Drawing in ipairs(ESPObject.Drawings) do
                -- // Remove the drawing
                Drawing:Remove()
            end

            -- // Remove object from table
            table.remove(self.ESPObjects, i)
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
    function PlayerManager.UpdateObject(self, Object)
        self:UpdateObjectManage(Object)
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
-- getgenv().PlayerManager = PlayerManager
return PlayerManager, Base