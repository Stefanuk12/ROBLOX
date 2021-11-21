-- // Information
--[[
    This allows you to create a simple "listener" for the ESP
]]

-- // Dependencies
local Signal = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/Signal/main/Module.lua"))()
local Base = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/ESP/Base.lua"))()

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
                Box = Base.Box.new({Object = child}),
                Header = Base.Header.new({Object = child}),
                Tracer = Base.Tracer.new({Object = child})
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
    function Manager.Start(self, Data)
        Data = Data or {}

        -- // Vars
        local AlreadyStarted = table.find(Managers, self)
        local Descendants = Data.Descendants or self.Descendants

        -- // Make sure hasn't already started
        if (AlreadyStarted) then
            return false
        end

        self.Descendants = Descendants

        -- // Initialise current objects
        local GetType = Descendants and "GetDescendants" or "GetChildren"
        for _, child in ipairs(self.Parent[GetType](self.Parent)) do
            -- // Make sure filter is good
            if not (self.Filter(Manager, child)) then
                continue
            end

            -- // Add
            self:AddObject(child)
        end

        -- // See whenever there is a new descendant/child
        local AddedType = Descendants and "DescendantAdded" or "ChildAdded"
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

    -- // Update all object
    function Manager.UpdateAllObjects(self)
        -- // Loop through each Object
        for _, Object in ipairs(self.ESPObjects) do
            -- // Loop through Object Drawings
            for _, DrawingObject in pairs(Object.Drawings) do
                -- // Update
                self:UpdateObject(DrawingObject, Object.Object)
            end
        end
    end

    -- // Set
    function Manager.ModifyDataProperty(self, Name, Value, Filter)
        -- // Default
        Filter = Filter or function(Manager, DrawingObject) return true end

        -- // Loop through each object
        for _, Object in ipairs(self.ESPObjects) do
            -- // Loop through Object Drawings
            for _, DrawingObject in pairs(Object.Drawings) do
                -- // Make sure passes
                if (not Filter(self, DrawingObject)) then
                    return
                end

                -- // Set
                DrawingObject.Data[Name] = Value
            end
        end
    end
end

-- // Constantly update
RunService:BindToRenderStep("ManagerUpdate", 0, function()
    -- // Loop through Managers
    for _, ESPManager in ipairs(Managers) do
        ESPManager:UpdateAllObjects()
    end
end)

-- // Return
return Manager, Base