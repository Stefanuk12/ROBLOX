-- // Dependencies
local Signals = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/PLS%20DONATE/Signals.lua"))()

-- // Services
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")

-- // Vars
local LocalPlayer = Players.LocalPlayer
local Events = ReplicatedStorage.Events
local BoothModels = Workspace.BoothModels
local SayMessageRequest = ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest

-- // Class stuff
local function InheritClass(Base)
    -- //
    local Class = {}
    local Class_MT = {
        __index = Class
    }

    -- // Constructor
    function Class.new(...)
        -- // Create object
        local self = setmetatable({}, Class_MT)

        -- // Initialise
        if (Class.__init__) then
            Class.__init__(self, ...)
        end

        -- // Return object
        return self
    end

    -- //
    if (Base ~= nil) then
        setmetatable(Class, {
            __index = Base
        })
    end

    -- //
    return Class
end
local function InheritClassClone(Base, Clone)
    -- //
    if (typeof(Base) ~= "table") then
        return Clone or Base
    end

    -- //
    Clone = Clone or {}
    Clone.__index = Base

    -- //
    return setmetatable(Clone, Clone)
end

-- // Message Manager
local MessageManager = {}
MessageManager.__index = MessageManager
do
    -- // Vars
    MessageManager.DefaultData = {
        Enabled = true,
        KillSwitch = false,
        Messages = "na",
        Random = false,
        Delay = 10, -- // seconds
        RefreshDelay = 1, -- // seconds
    }

    -- // Constructor
    function MessageManager.new(Data)
        -- // Create object
        local self = setmetatable({}, MessageManager)

        -- // Vars
        self:LoadDefaults(Data)

        -- // Return object
        return self
    end

    -- // Clone
    function MessageManager.Clone(self)
        return InheritClass(self)
    end

    -- // Add a message
    function MessageManager.AddMessage(self, Message, IgnoreExistCheck)
        -- // Make sure does not exist
        assert(IgnoreExistCheck or not table.find(self.Messages, Message), "message already exists")

        -- // Add message
        table.insert(self.Messages, Message)
    end

    -- // Remove a message
    function MessageManager.RemoveMessage(self, Message)
        -- // Make sure it exists
        local MessageI = table.find(self.Messages, Message)
        assert(MessageI, "message does not exist")

        -- // Remove
        table.remove(self.Messages, MessageI)
    end

    -- // Load default
    function MessageManager.LoadDefaults(self, Data)
        -- // Default
        Data = Data or {}

        -- // Loop through default data
        for i, v in pairs(self.DefaultData) do
            -- // Vars
            local Value = v

            -- // Check if data has it
            if (Data[i] ~= nil) then
                Value = Data[i]
            end

            -- // Set
            self[i] = Value
        end
    end

    -- // Chat a message (static)
    function MessageManager.Chat(self, Message, Target)
        -- // Default
        Target = Target or "All"
        SayMessageRequest:FireServer(Message, Target)
    end

    -- // Whisper to a player (static)
    function MessageManager.ChatWhisper(self, Message, Player, Target)
        -- // Default
        Target = Target or "All"
        SayMessageRequest:FireServer("/w " .. Player.Name .. " " .. Message, Target)
    end

    -- // Perform the task
    function MessageManager.DoTask(self, Message)

    end

    -- // Starts the automated stuff
    function MessageManager.StartAutomated(self)
        -- // Create a thread
        local thread = coroutine.create(function()
            -- // Vars
            local TimeElapsed = 0
            local MessagePointer = 1

            -- // Loop
            while (true) do wait(self.RefreshDelay)
                -- // Make sure is enabled
                if (not self.Enabled) then
                    continue
                end

                -- // Add
                TimeElapsed = TimeElapsed + self.RefreshDelay

                -- // Check for kill switch
                if (self.KillSwitch) then
                    self.KillSwitch = false
                    break
                end

                -- // Check if delay has been reached
                if not (TimeElapsed >= self.Delay) then
                    continue
                end

                -- // Vars
                local Message = ""

                -- // Check whether message is a string or not
                if (typeof(self.Messages) == "string") then
                    Message = self.Messages
                end

                -- // Check if the message is a table (array)
                if (typeof(self.Messages) == "table") then
                    -- // See whether we want a random message
                    if (self.Random) then
                        -- // Set message
                        Message = self.Messages[math.random(1, #self.Messages)]
                    else
                        -- // Set message
                        Message = self.Messages[MessagePointer]

                        -- // Check if pointer has reached the end
                        if (MessagePointer == #self.Messages) then
                            -- // Reset
                            MessagePointer = 0
                        end

                        -- // Add to pointer
                        MessagePointer = MessagePointer + 1
                    end
                end

                -- // Say the message, if it is not empty and reset time
                if (Message ~= "") then
                    self:DoTask(Message)
                    TimeElapsed = 0
                end
            end
        end)
        coroutine.resume(thread)

        -- // Return the thread
        return thread
    end

    -- // Starts everyting
    function MessageManager.Start(self)
        self:StartAutomated()
    end
end

-- // Booth Manager
local BoothManager = {}
BoothManager.__index = BoothManager
do
    -- // Constructor
    function BoothManager.new(Data)
        -- // Default
        Data = Data or {}

        -- // Create object
        local self = setmetatable({}, BoothManager)

        -- // Vars
        local BoothInteraction, Booth = self:GetBooth(LocalPlayer.UserId)
        self.BoothInteraction = BoothInteraction
        self.Booth = Booth

        -- // Return object
        return self
    end

    -- // Check if we have a booth
    function BoothManager.HasBooth(self)
        -- //
        if (self.Booth) then
            return true
        end

        -- //
        return self:GetBooth(LocalPlayer.UserId, true) ~= nil
    end

    -- // Get a booth
    function BoothManager.GetBooth(self, Id, IgnoreBooth)
        -- // Vars
        local BoothInteraction
        local BoothInteractionPosition

        -- // Loop through all of the booth interactions
        for _, v in pairs(CollectionService:GetTagged("BoothInteraction")) do
            -- // Check if the owner matches
            if (v:GetAttribute("BoothOwner") == Id) then
                -- // Set
                BoothInteraction = v
                BoothInteractionPosition = v.Position
                break
            end
        end

        -- // Make sure we got it
        if (not BoothInteraction or IgnoreBooth) then
            return BoothInteraction
        end

        -- // Loop through all of the booths
        local Distance = 1/0
        local Closest = nil
        for _, Booth in ipairs(BoothModels:GetChildren()) do
            -- // Vars
            local Magnitude = (BoothInteractionPosition - Booth.Base.Position).Magnitude

            -- // Check if closer
            if (Distance > Magnitude) then
                -- // Set
                Distance = Magnitude
                Closest = Booth
            end
        end

        -- // Return
        return BoothInteraction, Closest
    end

    -- // Claim a booth
    function BoothManager.ClaimBooth(self, BoothInteraction)
        -- // Make sure we do not have a booth
        assert(self:HasBooth() == false, "already claimed a booth")

        -- // Get a booth
        local _BoothInteraction, Booth = self:GetBooth()
        BoothInteraction = BoothInteraction or _BoothInteraction

        -- // Make sure we have a booth
        assert(BoothInteraction, "unable to find a booth to claim")

        -- // Claim
        fireproximityprompt(BoothInteraction.Claim, 0)

        -- // Return the booth
        self.BoothInteraction = BoothInteraction
        self.Booth = Booth
        return BoothInteraction, Booth
    end

    -- // Teleport behind a booth
    function BoothManager.TeleportBehind(self, Booth)
        -- // Make sure we got a booth
        assert(Booth, "unable to get booth")

        -- // Workout where to teleport
        local BaseCFrame = Booth.Base.CFrame
        local LookAt = Booth["Meshes/AssetsPD_Cube.014"].Position

        local TeleportCFrame = BaseCFrame:ToWorldSpace(CFrame.new(5, 2, 0))
        TeleportCFrame = CFrame.lookAt(TeleportCFrame.Position, LookAt)

        -- // Teleport
        LocalPlayer.Character.HumanoidRootPart.CFrame = TeleportCFrame
    end

    -- // Edit the text (static)
    function BoothManager.EditText(self, Text)
        Events.EditBooth:FireServer(
            Text,
            "booth"
        )
    end
end

-- // Chat Message
local ChatMessageManager = MessageManager:Clone()
do
    -- // Constructor
    function ChatMessageManager.__init__(self, Data)
        -- // Set default
        self.DefaultData.Messages = {"Hello", "This is an automated message", "Donate for an automated response!", "How are you today?", "Created by Stefanuk12"}
        self:LoadDefaults(Data)
    end

    -- // Set task
    ChatMessageManager.DoTask = ChatMessageManager.Chat
end

-- // Booth "Message"
local BoothMessageManager = MessageManager:Clone()
do
    -- // Constructor
    function BoothMessageManager.__init__(self, Data)
        -- // Set default
        self.DefaultData.Messages = {"very cool", "pls donate", "ibeg", "automated booth"}
        self:LoadDefaults(Data)
    end

    -- // Set task
    BoothMessageManager.DoTask = BoothManager.EditText
end

-- // Donate Manager
local DonateManager = {}
DonateManager.__index = DonateManager
do
    -- // Vars
    DonateManager.DefaultData = {
        AutomatedTasks = {},
        DefaultMessage = "Thanks for your tip, unfortunately, I do not have anything special for you!"
    }

    -- // Constructor
    function DonateManager.new(Data)
        -- // Default
        Data = Data or {}

        -- // Create object
        local self = setmetatable({}, DonateManager)

        -- // Vars
        self:LoadDefaults(Data)
        self.AutomatedMessages = ChatMessageManager.new(Data.AutomatedMessages)
        self.AutomatedBooth = BoothMessageManager.new(Data.AutomatedBooth)
        self.BoothManager = BoothManager.new()

        -- // Start
        self:Start()

        -- // Return object
        return self
    end

    -- // Load default
    function DonateManager.LoadDefaults(self, Data)
        -- // Loop through default data
        for i, v in pairs(self.DefaultData) do
            -- // Vars
            local Value = v

            -- // Check if data has it
            if (Data[i] ~= nil) then
                Value = Data[i]
            end

            -- // Set
            self[i] = Value
        end
    end

    -- // Add an automated task
    function DonateManager.AddTask(self, Amount, TaskFunction)
        -- // Make sure the task does not exist already
        assert(not self.AutomatedTasks[Amount], "task already exists")

        -- // Add the task
        self.AutomatedTasks[Amount] = TaskFunction
    end

    -- // Remove an automated task
    function DonateManager.RemoveTask(self, Amount)
        -- // Make sure the task exists
        assert(self.AutomatedTasks[Amount], "task does not exist")

        -- // Remove task
        self.AutomatedTasks[Amount] = nil
    end

    -- // Default task - executed when we have no task
    function DonateManager.DefaultTask(self, Tipper, Amount)
        -- // Tell the tipper thanks
        self.AutomatedMessages:ChatWhisper(self.DefaultMessage, Tipper)
    end

    -- // Starts the connection
    function DonateManager.StartDonateListener(self)
        -- // See whenever we get a purchase
        self.DonateListener = Signals:Connect("Purchase", function(Tipper, Amount)
            -- // Check if we have a task
            local TaskFunction = self.AutomatedTasks[Amount]
            if (not TaskFunction) then
                -- // Do the default task
                return self:DefaultTask(Tipper, Amount)
            end

            -- // Perform the function
            TaskFunction(Tipper, Amount)
        end)
    end

    -- // Starts everything
    function DonateManager.Start(self)
        self:StartDonateListener()
        self.AutomatedMessages:Start()
        self.AutomatedBooth:Start()
    end
end

-- // Return
getgenv().DonateManager = DonateManager
return DonateManager, BoothManager, ChatMessageManager, BoothMessageManager, MessageManager