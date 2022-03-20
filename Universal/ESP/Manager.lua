-- // Information
--[[
    This allows you to create a simple "listener" for the ESP
]]

-- // Dependencies
local Base = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/ESP/Base.lua"))()

-- // Services
local RunService = game:GetService("RunService")

-- // Vars
local Managers = {}

-- // Class stuff
local function InheritClass(_Base)
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
    if (_Base ~= nil) then
        setmetatable(Class, {
            __index = _Base
        })
    end

    -- //
    return Class
end

-- // Manager Class
local Manager = {}
Manager.__index = Manager
do
    -- // Constructor
    function Manager.new(Parent, Data)
        -- // Default
        Data = Data or {}

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

    -- // Clone
    function Manager.Clone(self)
        return InheritClass(self)
    end

    -- // Add Object
    function Manager.AddObject(self, child, Types, Modifier)
        -- // Default
        Types = Types or {"Box", "Tracer", "Header", "Healthbar"}
        Modifier = Modifier or function(ESPObject) return ESPObject end

        -- // Create the ESP Objects
        local Objects = {}
        for _, Type in ipairs(Types) do
            -- // Create the object
            local ESPObject = Base[Type].new({Object = child})
            ESPObject = Modifier(ESPObject)

            -- // Add to the Manager's Objects
            table.insert(self.ESPObjects, ESPObject)

            -- // Add to created objects
            table.insert(Objects, ESPObject)
        end

        -- // Return
        return Objects
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
            for _, Drawing in ipairs(ESPObject.Drawings) do
                -- // Remove the drawing
                Drawing:Remove()
            end

            -- // Remove object from table
            table.remove(self.ESPObjects, i)

            -- // Break
            break
        end
    end

    -- // Get Objects
    function Manager.GetObjectsOfType(self, Type)
        -- // Vars
        local Found = {}

        -- // Loop through Objects
        for _, ESPObject in ipairs(self.ESPObjects) do
            -- // Check that the type matches
            if (ESPObject.__type == Type) then
                -- // Add to found
                table.insert(Found, ESPObject)
            end
        end

        -- // Return found
        return Found
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

    -- // Update a object
    function Manager.UpdateObject(self, Object)
        Object:Update()
    end

    -- // Update all object
    function Manager.UpdateAllObjects(self)
        -- // Loop through each Object
        for _, ESPObject in ipairs(self.ESPObjects) do
            -- // Update
            self:UpdateObject(ESPObject)
        end
    end

    -- // Set
    function Manager.ModifyDataProperty(self, Name, Value, Filter)
        -- // Default
        Filter = Filter or function(Manager, ESPObject) return true end

        -- // Loop through each object
        for _, ESPObject in ipairs(self.ESPObjects) do
            -- // Make sure passes
            if (not Filter(self, ESPObject)) then
                return
            end

            -- // Set
            ESPObject.Data[Name] = Value
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
-- getgenv().Manager = Manager
return Manager, Base