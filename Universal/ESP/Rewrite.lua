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

local TracerStart = Vector2new(CurrentCamera.ViewportSize.X / 2, CurrentCamera.ViewportSize.Y - 34)
local mathatan2 = math.atan2
local mathrad = math.rad
local CFrameAngles = CFrame.Angles
local mathpi = math.pi

-- // Module
local ESP = {}
getgenv().ESP = ESP
ESP.__index = ESP

-- // Utilites
ESP.Utilites = {}

-- // ty ic3 - failsafe if behind
ESP.Utilites.BehindPosition = function(TargetPosition)
    -- // Vars
    local ScreenPosition, _ = WorldToViewportPoint(CurrentCamera, TargetPosition)
    local OPosition = CurrentCamera.CFrame:PointToObjectSpace(TargetPosition)

    -- // Check if behind
    if (ScreenPosition.Z < 0) then
        local AT = mathatan2(OPosition.Y, OPosition.X) + mathpi
        OPosition = CFrameAngles(0, 0, AT):VectorToWorldSpace((CFrameAngles(0, mathrad(89.9), 0):VectorToWorldSpace(Vector3new(0, 0, -1))))
    end

    -- // Convert to 2D
    local Position, _ = WorldToViewportPoint(CurrentCamera, CurrentCamera.CFrame:PointToWorldSpace(OPosition))

    -- //
    return Position
end

-- // Get the corners for the box
ESP.Utilites.getBoxCorners = function(Target, return3D, convertBehind)
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

            if not (convertBehind) then
                local tPoint, _ = WorldToViewportPoint(CurrentCamera, point.Position)
                newPoints[i] = Vector2new(tPoint.X, tPoint.Y)
            else
                local Position = ESP.Utilites.BehindPosition(point.Position)
                newPoints[i] = Vector2new(Position.X, Position.Y)
            end
        end

        return newPoints
    end

    -- // Failsafe
    local ModelBoxC, ModelBoxS = BlankCFrame, BlankVector3
    local Failsafed = false
    if (Target) then
        if (Target:IsA("Model")) then
            ModelBoxC, ModelBoxS = Target:GetBoundingBox()
        elseif (Target:IsA("BasePart")) then
            ModelBoxC = Target.CFrame
            ModelBoxS = Target.Size
        else
            local tempModel = Instance.new("Model", workspace)
            local savedParent = Target.Parent
            Target.Parent = tempModel
            ModelBoxC, ModelBoxS = tempModel:GetBoundingBox()
            Target.Parent = savedParent
            Target:Destroy()
        end
    else
        Failsafed = true
    end

    -- //
    local Corners3D = GetPartCorners(ModelBoxC, ModelBoxS)

    -- //
    if (return3D) then
        return Corners3D, Failsafed
    else
        local Corners2D = convertTo2D(Corners3D)
        return Corners2D, Failsafed
    end
end

-- // Create Drawing Objects with Data
ESP.Utilites.Drawing = function(Type, Data)
    local Object = Drawing.new(Type)

    for i,v in pairs(Data) do
        Object[i] = v
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

-- // Add data (recursive tables)
local function addTableData(Data, ToAdd)
    -- // Check to add exists
    if not (ToAdd) then
        return Data
    end

    -- // Loop through data we want to add
    for i,v in pairs(ToAdd) do
        -- // If data does not exist
        if not (Data[i]) then
            Data[i] = v
            continue
        end

        -- // Check if table
        if (typeof(v) == "table") then
            Data[i] = addTableData(Data, v)
            continue
        end

        -- // Just add
        Data[i] = v
    end

    return Data
end

-- // Update an element's data
function ESP:UpdateData(Data)
    -- // Return if no data
    if not (Data) then
        return self.Data
    end

    -- // Add the data
    self.Data = addTableData(self.Data, Data)

    -- // See if any object data was given to update
    local ObjectData = Data.ObjectData
    if (ObjectData) then
        for i,v in pairs(ObjectData) do
            self.Object[i] = v
        end
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
            ObjectData = {
                Thickness = 3,
                Color = Color3fromRGB(255, 150, 150),
                Visible = true,
                Filled = false
            }
        }
        Data = addTableData(idealData, Data)
        self.Data = Data
    end

    -- // Object
    self.Object = ESP.Utilites.Drawing("Quad", Data.ObjectData)

    -- // Update function
    function self:Update(_Data)
        -- // Update data, if sent
        Data = self:UpdateData(_Data)

        -- // Vars
        local Object = self.Object
        local BoxCorners, Failsafed = ESP.Utilites.getBoxCorners(Data.Model, false, true)

        -- // Setting Points
        Object.PointA = BoxCorners[2]
        Object.PointB = BoxCorners[1]
        Object.PointC = BoxCorners[3]
        Object.PointD = BoxCorners[4]

        Data.ObjectData.PointA = Object.PointA
        Data.ObjectData.PointB = Object.PointB
        Data.ObjectData.PointC = Object.PointC
        Data.ObjectData.PointD = Object.PointD
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
            ObjectData = {
                Color = Color3fromRGB(255, 255, 255),
                Visible = true,
                Size = 12,
                Center = true,
                Outline = true,
                OutlineColor = Color3fromRGB(255, 150, 150),
                Font = Drawing.Fonts.Plex
            },
            Offset = CFramenew(0, 2, 0)
        }
        Data = addTableData(idealData, Data)
        self.Data = Data
    end

    -- // Object
    self.Object = ESP.Utilites.Drawing("Text", Data.ObjectData)

    -- // Update function
    function self:Update(_Data)
        -- // Update data, if sent
        Data = self:UpdateData(_Data)

        -- // Vars
        local Object = self.Object
        local BoxCFrame, Failsafed = ESP.Utilites.getBoxCorners(Data.Model, true)

        -- // Midpoint
        local Blank = BoxCFrame[1] - BoxCFrame[1].Position
        local Midpoint = Blank + (BoxCFrame[1].Position + BoxCFrame[2].Position) / 2

        -- // Position
        local Position
        if (typeof(Data.Offset) == "function") then -- // Allow dynamic offset
            Position = Data.Offset(Midpoint, BoxCFrame)
        else
            Position = Midpoint * Data.Offset
        end
        Position = ESP.Utilites.BehindPosition(Position.Position)
        Position = Vector2new(Position.X, Position.Y)

        -- // Setting stuff
        local ModelName = Data.Model and Data.Model.Name or Data.ObjectData.Text
        Object.Text = Data.Text or ModelName or "[sex]"
        Object.Position = Position

        Data.ObjectData.Text = Object.Text
        Data.ObjectData.Position = Object.Position
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
            ObjectData = {
                Thickness = 3,
                Color = Color3fromRGB(255, 150, 150),
                Visible = true,
                From = TracerStart
            }
        }
        Data = addTableData(idealData, Data)
        self.Data = Data
    end

    -- // Object
    self.Object = ESP.Utilites.Drawing("Line", Data.ObjectData)

    -- // Update function
    function self:Update(_Data)
        -- // Update data, if sent
        Data = self:UpdateData(_Data)

        -- // Vars
        local Object = self.Object
        local BoxCFrame, Failsafed = ESP.Utilites.getBoxCorners(Data.Model, true)

        -- // Midpoint
        local Blank = BoxCFrame[3] - BoxCFrame[3].Position
        local Midpoint = Blank + (BoxCFrame[4].Position + BoxCFrame[3].Position) / 2

        -- // Position - ty ic3
        local Position = ESP.Utilites.BehindPosition(Midpoint.Position)

        -- // Setting To position
        local To = Vector2new(Position.X, Position.Y)
        Object.To = To
        Data.ObjectData = Object.To
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