-- // Information
--[[
    This allows you to create a simple "listener" for the ESP
]]

-- // Dependencies
local Signal = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/Signal/main/Module.lua"))()
local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/ESP/Rewrite2.lua"))()

-- // Services
local RunService = game:GetService("RunService")

-- // Vars
local Signals = {
    ObjectAdded = Signal.new("ObjectAdded"),
    ObjectRemoved = Signal.new("ObjectRemoved"),
    ObjectUpdated = Signal.new("ObjectUpdated")
}
local Managers = {}

-- // Manager Class
local Manager = {}
Manager.__index = Manager
do
    -- // Constructor
    function Manager.new(Parent, Data)
        -- // Initialise
        local self = setmetatable({}, Manager)

        -- // Set Vars
        self.Parent = Parent
        self.Filter = Data.Filter or function() return true end
        self.Descendants = Data.Descendants or false

        self.ESPObjects = {}
        self.ConnectionAdded = nil
        self.ConnectionRemoved = nil

        -- // Return
        return self
    end

    -- // Add Object
    function Manager.AddObject(self, child)
        -- // Create the ESP Objects
        local ESPObjects = {
            Object = child,
            Drawings = {
                Box = ESP.Box.new({Object = child}),
                Header = ESP.Header.new({Object = child}),
                Tracer = ESP.Tracer.new({Object = child})
            }
        }

        -- // Add to the Manager's Objects
        table.insert(self.ESPObjects, ESPObjects)

        -- // Fire signal
        Signals.ObjectAdded:Fire(ESPObjects, Manager)
    end

    -- // Remove Object
    function Manager.RemoveObject(self, child)
        -- // Loop through each Object
        for i, ESPObject in ipairs(self.ESPObjects) do
            -- // Make sure object matches
            if not (child == ESPObject.Object) then
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

    -- // Start
    function Manager.Start(self)
        -- // Vars
        local AlreadyStarted = table.find(Managers, self)

        -- // Make sure hasn't already started
        if (AlreadyStarted) then
            return false
        end

        -- // Initialise current objects
        local GetType = self.Descendants and "GetDescendants" or "GetChildren"
        for _, child in ipairs(self.Parent[GetType](self.Parent)) do
            -- // Make sure filter is good
            if not (self.Filter(Manager, child)) then
                continue
            end

            -- // Add
            self:AddObject(child)
        end

        -- // See whenever there is a new descendant/child
        local AddedType = self.Descendants and "DescendantAdded" or "ChildAdded"
        self.ConnectionAdded = self.Parent[AddedType]:Connect(function(child)
            -- // Make sure filter is good
            if not (self.Filter(Manager, child)) then
                return
            end

            -- // Add
            self:AddObject(child)
        end)

        -- // See when a descendant/child has been removed
        local RemovedType = self.Descendants and "DescendantRemoved" or "ChildRemoved"
        self.ConnectionRemoved = self.Parent[RemovedType]:Connect(function(child)
            -- // Make sure filter is good
            if not (self.Filter(Manager, child)) then
                return
            end

            -- // Remove
            self:RemoveObject(child)
        end)

        -- // Add to Managers
        table.insert(Managers, self)

        -- // Return
        return true
    end

    -- // Stop
    function Manager.Stop(self)
        -- // Vars
        local AlreadyStarted = table.find(Managers, self)

        -- // Make sure hasn't already started
        if (not AlreadyStarted) then
            return false
        end

        -- // Disable Connections
        self.ConnectionAdded:Disconnect()
        self.ConnectionRemoved:Disconnect()

        -- // Remove from Managers
        table.remove(Managers, AlreadyStarted)

        -- // Return
        return true
    end

    -- // Change the parent
    function Manager.ChangeParent(self, Parent)
        -- // Vars
        local AlreadyStarted = table.find(Managers, self)

        -- // Stop
        if (AlreadyStarted) then
            self:Stop()
        end

        -- // Set
        self.Parent = Parent

        -- // Start
        if (AlreadyStarted) then
            self:Start()
        end
    end

    -- // Update
    function Manager.UpdateObject(self, ESPObject, Object)
        -- // Update
        ESPObject:Update({Object = Object})

        -- // Fire Signal
        Signals.ObjectUpdated:Fire(self, ESPObject, Object)
    end

    -- // Set
    function Manager.SetEnabled(self, Enabled, Filter)
        -- // Default value
        Filter = Filter or function(ESPObject, Type) return true end

        -- // Loop through each object
        for _, ESPObject in ipairs(self.ESPObjects) do
            -- // Make sure abides by filter
            if (not Filter(ESPObject, "ESPObject")) then
                continue
            end

            -- // Loop through each drawing
            for Type, Drawing in pairs(ESPObject.Drawings) do
                -- // Make sure abides by filter
                if (not Filter(ESPObject, Type)) then
                    continue
                end

                -- // Set
                Drawing.Enabled = Enabled
            end
        end
    end
end

-- // Constantly update
RunService:BindToRenderStep("ManagerUpdate", 0, function()
    -- // Loop through Managers
    for _, Manager in ipairs(Managers) do
        -- // Vars
        local ESPObjects = Manager.ESPObjects

        -- // Loop through each Object
        for _, Object in ipairs(ESPObjects) do
            -- // Loop through Object Drawings
            for _, DrawingObject in pairs(Object.Drawings) do
                -- // Update
                Manager:UpdateObject(DrawingObject, Object.Object)
            end
        end
    end
end)

-- // Return
return Manager