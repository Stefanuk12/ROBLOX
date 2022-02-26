-- // Dependencies
local Signals = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/PLS%20DONATE/Signals.lua"))()

-- // Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- // Vars
local SayMessageRequest = ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest

-- //
local DonateManager = {}
DonateManager.__index = DonateManager
do
    -- // Constructor
    function DonateManager.new(Data)
        -- // Default
        Data = Data or {}

        -- // Create object
        local self = setmetatable({}, DonateManager)

        -- // Vars
        self.AutomatedTasks = Data.AutomatedTasks or {}
        self.DefaultMessage = Data.DefaultMessage or "Thanks for your tip, unfortunately, I do not have anything special for you!"
        self.AutomatedMessages = Data.AutomatedMessages or {
            Enabled = false,
            KillSwitch = false,
            Messages = {"Hello", "This is an automated message", "How are you today?", "Created by Stefanuk12"},
            Random = false,
            Delay = 10, -- // seconds
            RefreshDelay = 1 -- // seconds
        }

        -- // Start
        self:Start()

        -- // Return object
        return self
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

    -- // Says a message (static)
    function DonateManager.SayMessage(Message, Target)
        -- // Default
        Target = Target or "All"
        SayMessageRequest:FireServer(Message, Target)
    end

    -- // Default task - executed when we have no task
    function DonateManager.DefaultTask(self, Tipper, Amount)
        -- // Tell the tipper thanks
        self.SayMessage("/w " .. Tipper.Name .. " " .. self.DefaultMessage)
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

    -- // Starts the automated messages
    function DonateManager.StartAutomatedMessages(self)
        -- // Create a thread
        local thread = coroutine.create(function()
            -- // Vars
            local TimeElapsed = 0
            local MessagePointer = 1
            local Data = self.AutomatedMessages

            -- // Loop
            while (true) do wait(Data.RefreshDelay)
                -- // Add
                TimeElapsed = TimeElapsed + Data.RefreshDelay

                -- // Check for kill switch
                if (Data.KillSwitch) then
                    Data.KillSwitch = false
                    break
                end

                -- // Check if delay has been reached
                if not (TimeElapsed >= Data.Delay) then
                    continue
                end

                -- // Vars
                local Message = ""

                -- // Check whether message is a string or not
                if (typeof(Data.Messages) == "string") then
                    Message = Data.Messages
                end

                -- // Check if the message is a table (array)
                if (typeof(Data.Messages) == "table") then
                    -- // See whether we want a random message
                    if (Data.Random) then
                        Message = Data.Messages[math.random(1, #Data.Messages)]
                    else
                        Message = Data.Messages[MessagePointer]
                        MessagePointer = MessagePointer + 1

                        -- // Check if pointer has reached the end
                        if (MessagePointer == #Data.Messages) then
                            -- // Reset
                            MessagePointer = 0
                        end
                    end
                end

                -- // Say the message, if it is not empty and reset time
                if (Message ~= "") then
                    self.SayMessage(Message)
                    TimeElapsed = 0
                end
            end
        end)
        coroutine.resume(thread)

        -- // Return the thread
        return thread
    end

    -- // Starts everything
    function DonateManager.Start(self)
        self:StartDonateListener()
        self:StartAutomatedMessages()
    end
end

-- // Return
return DonateManager