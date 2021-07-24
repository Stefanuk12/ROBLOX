-- // Services
local Workspace = game:GetService("Workspace")

-- // Vars
local CurrentCamera = Workspace.CurrentCamera

local WorldToViewportPoint = CurrentCamera.WorldToViewportPoint
local Vector2new = Vector2.new
local Vector3new = Vector3.new
local CFramenew = CFrame.new
local RaycastParamsnew = RaycastParams.new
local Raycast = Workspace.Raycast
local Color3fromRGB = Color3.fromRGB
local EnumRaycastFilterTypeBlacklist = Enum.RaycastFilterType.Blacklist
local ModelInstance = Instance.new("Model")
local GetBoundingBox = ModelInstance.GetBoundingBox

local BlankVector3 = Vector3.new(69, 69, 69)
local BlankCFrame = CFrame.new(BlankVector3, BlankVector3)

local TracerStart = Vector2new(CurrentCamera.ViewportSize.X / 2, CurrentCamera.ViewportSize.Y)

-- // Module
local ESP = {}
getgenv().ESP = ESP
ESP.__index = ESP

-- // Utilites
ESP.Utilites = {}

-- // Get the corners for the box
ESP.Utilites.getBoxCorners = function(Target, returnType)
    -- // Get Part Corners
    local function GetPartCorners(CF, Size)
        local function getMidpoint(a, b)
            local modifiedPosition = Vector3new((a.X + b.X) / 2, a.Y, (a.Z + b.Z) / 2)
            return (a - a.Position) + modifiedPosition
        end

        local front = {
            CF * CFramenew(-Size.X / 2, Size.Y / 2, -Size.Z / 2),
            CF * CFramenew(Size.X / 2, Size.Y / 2, -Size.Z / 2),
            CF * CFramenew(-Size / 2),
            CF * CFramenew(Size.X / 2, -Size.Y / 2, -Size.Z / 2)
        }
        local back = {
            CF * CFramenew(-Size.X / 2, Size.Y / 2, Size.Z / 2),
            CF * CFramenew(Size / 2),
            CF * CFramenew(-Size.X / 2, -Size.Y / 2, Size.Z / 2),
            CF * CFramenew(Size.X / 2, -Size.Y / 2, Size.Z / 2)
        }
        local centre = {}

        for i = 1, 4 do
            centre[i] = getMidpoint(front[i], back[i])
        end

        return centre
    end

    -- // Convert 3D to 2D
    local function convertTo2D(points)
        local newPoints = {}

        for i = 1, #points do
            local point = points[i]
            local tPoint, _ = CurrentCamera.WorldToViewportPoint(CurrentCamera, point.Position)

            newPoints[i] = Vector2new(tPoint.X, tPoint.Y)
        end

        return newPoints
    end

    -- // Failsafe
    local ModelBoxC, ModelBoxS = BlankCFrame, BlankVector3
    local Failsafed = false
    if (Target) then
        if (Target:IsA("Model")) then
            ModelBoxC, ModelBoxS = GetBoundingBox(ModelInstance, Target)
        elseif (Target:IsA("BasePart")) then
            ModelBoxC = Target.CFrame
            ModelBoxS = Target.Size
        else
            local tempModel = Instance.new("Model", workspace)
            local savedParent = Target.Parent
            Target.Parent = tempModel
            ModelBoxC, ModelBoxS = GetBoundingBox(ModelInstance, tempModel)
            Target.Parent = savedParent
            Target:Destroy()
        end
    else
        Failsafed = true
    end

    -- //
    if (returnType) then
        return GetPartCorners(ModelBoxC, ModelBoxS), Failsafed
    else
        local Corners3D = GetPartCorners(ModelBoxC, ModelBoxS)
        local Corners2D = convertTo2D(Corners3D)

        return Corners2D, Corners3D, Failsafed
    end
end

-- // Create Drawing Objects with Data
ESP.Utilites.Drawing = function(Type, Data)
    local Object = Drawing.new(Type)

    for i,v in pairs(Data) do
        local success, _ = pcall(function()
            local test = Object[i]
        end)

        if (success) then
            Object[i] = v
        end
    end

    return Object
end

-- // Check if part is visible
ESP.Utilites.IsVisible = function(TargetPosition)
    -- // Vars
    local Visible = false
    local PartHit

    -- // Setup the Raycast Parameters
    local raycastParams = RaycastParamsnew()
    raycastParams.FilterType = EnumRaycastFilterTypeBlacklist
    raycastParams.FilterDescendantsInstances = {CurrentCamera}

    -- // Cast the ray
    local Origin = CurrentCamera.CFrame.Position
    local Result = Raycast(Workspace, Origin, (TargetPosition - Origin), raycastParams)

    -- // See if it hit something
    if (Result) then
        PartHit = Result.Instance

        -- // See if it hit the target part
        Visible = (Result.Position == TargetPosition)
    end

    -- // Return
    return Visible, PartHit
end

-- // Get the center of a part/model
ESP.Utilites.GetCenter = function(Object)
    if (Object:IsA("Model")) then
        local Orientation, _ = Object:GetBoundingBox()
        return Orientation.Position
    else
        -- // Get middle of parts
        return Object.Position
    end
end

-- // Update an element's data
function ESP:UpdateData(Data)
    -- // Return if no data
    if not (Data) then
        return self.Data
    end

    -- // Loop through given data
    for i,v in pairs(Data) do
        -- // Set
        self.Data[i] = v

        -- // Make sure it is an object value
        local objectI = self.Object[i]
        if not (objectI) then
            continue
        end

        -- // Set data
        objectI = v
    end

    -- // Return
    return self.Data
end

-- // Create a box element
function ESP:Box(Data)
    self = setmetatable({}, ESP)
    self.ClassName = "Box"

    -- // Management
    do
        local idealData = {
            Thickness = 3,
            Color = Color3fromRGB(255, 150, 150),
            Visible = true,
            Filled = false,
        }
        for i,v in pairs(idealData) do
            if (not Data[i]) then
                Data[i] = v
            end
        end

        self.Data = Data
    end

    -- // Object
    self.Object = ESP.Utilites.Drawing("Quad", Data)

    -- // Update function
    function self:Update(_Data)
        -- // Update data, if sent
        Data = self:UpdateData(_Data)

        -- // Vars
        local Object = self.Object
        local BoxCorners, Failsafed = ESP.Utilites.getBoxCorners(Data.Model)

        -- // Setting Points
        Object.PointA = BoxCorners[2]
        Object.PointB = BoxCorners[1]
        Object.PointC = BoxCorners[3]
        Object.PointD = BoxCorners[4]
    end
    self:Update()

    -- // Return
    return self
end

-- // Create a header element
function ESP:Header(Data)
    self = setmetatable({}, ESP)
    self.ClassName = "Header"

    -- // Management
    do
        local idealData = {
            Thickness = 3,
            Color = Color3fromRGB(255, 150, 150),
            Visible = true,
            Size = 18,
            Center = true,
            Outline = false,
            OutlineColor = Color3fromRGB(255, 150, 150),
            Font = Drawing.Fonts.UI,
            Offset = CFramenew(0, 2, 0)
        }
        for i,v in pairs(idealData) do
            if (not Data[i]) then
                Data[i] = v
            end
        end

        self.Data = Data
    end

    -- // Object
    self.Object = ESP.Utilites.Drawing("Text", Data)

    -- // Update function
    function self:Update(_Data)
        -- // Update data, if sent
        Data = self:UpdateData(_Data)

        -- // Vars
        local Object = self.Object
        local BoxCFrame, _, Failsafed = ESP.Utilites.getBoxCorners(Data.Model, true)

        -- // Midpoint
        local Blank = BoxCFrame[1] - BoxCFrame[1].Position
        local Midpoint = Blank + (BoxCFrame[1].Position + BoxCFrame[2].Position) / 2

        -- // Position
        local Position = Midpoint * Data.Offset
        Position = WorldToViewportPoint(CurrentCamera, Position.Position)
        Position = Vector2new(Position.X, Position.Y)

        -- // Setting stuff
        Object.Text = Data.Text or Data.Model.Name
        Object.Position = Position
    end
    self:Update()

    -- // Return
    return self
end

-- // Create a tracer element
function ESP:Tracer(Data)
    self = setmetatable({}, ESP)
    self.ClassName = "Tracer"

    -- // Management
    do
        local idealData = {
            Thickness = 3,
            Color = Color3fromRGB(255, 150, 150),
            Visible = true,
            From = TracerStart,
        }
        for i,v in pairs(idealData) do
            if (not Data[i]) then
                Data[i] = v
            end
        end

        self.Data = Data
    end

    -- // Object
    self.Object = ESP.Utilites.Drawing("Line", Data)

    -- // Update function
    function self:Update(_Data)
        -- // Update data, if sent
        Data = self:UpdateData(_Data)

        -- // Vars
        local Object = self.Object
        local BoxCFrame, _, Failsafed = ESP.Utilites.getBoxCorners(Data.Model, true)

        -- // Midpoint
        local Blank = BoxCFrame[3] - BoxCFrame[3].Position
        local Midpoint = Blank + (BoxCFrame[4].Position + BoxCFrame[3].Position) / 2

        -- // Position
        local Position, _ = WorldToViewportPoint(CurrentCamera, Midpoint.Position)
        Position = Vector2new(Position.X, Position.Y)

        -- // Setting To position
        Object.To = Position
    end
    self:Update()

    -- // Return
    return self
end

-- // Sets the ESP Object's visiblity based upon whether you have a clear line of sight to its object middle
function ESP:IsVisible()
    -- // Vars
    local Middle = ESP.Utilites.GetCenter(self.Data.Model)
    local Visible, _ = ESP.Utilites.IsVisible(Middle)

    -- // Set the visibility
    return self:Update({
        Visible = Visible
    })
end

-- // Sets the ESP Object's visibility based upon whether the object is on the screen, disregardining line of sight
function ESP:IsOnScreen()
    -- // Vars
    local Middle = ESP.Utilites.GetCenter(self.Data.Model)
    local _, OnScreen = WorldToViewportPoint(CurrentCamera, Middle)

    -- // Set the visibility
    return self:Update({
        Visible = OnScreen
    })
end

-- // Return module
return ESP