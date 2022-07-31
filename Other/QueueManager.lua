-- // Dependencies
local SignalManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/Signal/main/Manager.lua"))()

-- // Services
local HttpService = game:GetService("HttpService")

-- //
local QueueManager = {}
QueueManager.__index = QueueManager
do
    -- // Constructor
    function QueueManager.new(Data)
        -- // Default
        Data = Data or {}

        -- // Create object
        local self = setmetatable({}, QueueManager)
        self.Queue = Data.Queue or {}
        self.ProcessFunction = Data.ProcessFunction or function(Item) end

        -- // Setting up signals
        self.Signals = SignalManager.new()
        self.Signals:Add("ItemProcessing")
        self.Signals:Add("ItemProcessed")
        self.Signals:Add("ItemRemoved")
        self.Signals:Add("ItemAdded")
        self.Signals:Add("StepCompleted")
        self.Signals:Add("QueueCleared")

        -- // Return object
        return self
    end

    -- // Adds an item to the queue
    function QueueManager.Add(self, Item)
        -- // Create the object
        local Id = HttpService:GenerateGUID(false)
        local Object = {
            Id = Id,
            Item = Item
        }

        -- // Add it to the queue
        table.insert(self.Queue, Object)

        -- // Fire signal
        self.Signals:Fire("ItemAdded", Object)

        -- // Return Id
        return Id
    end

    -- // Gets an item from the queue
    function QueueManager.Get(self, Id)
        -- // Loop through the queue
        for i, v in ipairs(self.Queue) do
            -- // Make sure the id matches
            if (v.Id == Id) then
                return v, i
            end
        end
    end

    -- // Removes an item from the queue
    function QueueManager.Remove(self, Id)
        -- // Get the item
        local Item, Index = self:Get(Id)

        -- // Make sure we got it
        if (not Index) then
            return
        end

        -- // Remove it
        table.remove(self.Queue, Id)

        -- // Fire signal
        self.Signals:Fire("ItemRemoved", Item, Index)
    end

    -- // Steps one item forward within the queue
    function QueueManager.Step(self)
        -- // Vars
        local Item = self.Queue[1]

        -- // Make sure we have an item (queue is not empty)
        if (not Item) then
            return
        end

        -- // Process it
        self.Signals:Fire("ItemProcessing", Item)
        self.ProcessFunction(Item.Item)
        self.Signals:Fire("ItemProcessed", Item)

        -- // Remove it
        table.remove(self.Queue, 1)
        self.Signals:Fire("ItemRemoved", Item, 1)
        self.Signals:Fire("StepCompleted", Item)

        -- // Check if queue is empty
        if (#self.Queue == 0) then
            self.Signals:Fire("QueueCleared")
        end
    end

    -- // Automatically runs the queue
    function QueueManager.Run(self)
        return task.spawn(function()
            while (true) do wait()
                self:Step()
            end
        end)
    end
end

-- // Return
return QueueManager