-- // Dependencies
local CIELUV = loadstring(game:HttpGet("https://raw.githubusercontent.com/coastss/releases/main/cieluv_color_lerp.lua"))()

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

-- // Convert 3D to 2D
ESP.Utilites.convertTo2D = function(points, convertBehind)
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

-- // Get Part Corners
ESP.Utilites.GetPartCorners = function(CF, Size, CornerFunc)
    -- // Set corner function
    CornerFunc = CornerFunc or function(Front, Back, Index)
        -- // Get the midpoint
        local Midpoint = Vector3new((Front.X + Back.X) / 2, Front.Y, (Front.Z + Back.Z) / 2)

        -- //
        local Blank = (Front - Front.Position)

        -- //
        return Blank + Midpoint
    end

    -- //
    local front = {
        CF * CFramenew(-Size.X / 2, Size.Y / 2, -Size.Z / 2), -- // Top Left (A)
        CF * CFramenew(Size.X / 2, Size.Y / 2, -Size.Z / 2), -- // Top Right (F)
        CF * CFramenew(-Size / 2), -- // Bottom Left (C)
        CF * CFramenew(Size.X / 2, -Size.Y / 2, -Size.Z / 2) -- // Bottom Right (E)
    }
    local back = {
        CF * CFramenew(-Size.X / 2, Size.Y / 2, Size.Z / 2), -- // Top Left (B)
        CF * CFramenew(Size / 2), -- // Top Right (G)
        CF * CFramenew(-Size.X / 2, -Size.Y / 2, Size.Z / 2), -- // Bottom Right (H)
        CF * CFramenew(Size.X / 2, -Size.Y / 2, Size.Z / 2) -- // Bottom Left (D)
    }
    local centre = {}

    for i = 1, 4 do
        -- // Vars
        local ToSet = CornerFunc(front[i], back[i], i)

        -- //
        centre[i] = ToSet
    end

    return centre
end

-- // Get the corners for the box
ESP.Utilites.getBoxCorners = function(Target, return3D, convertBehind, CornerFunc)
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
    local Corners3D = ESP.Utilites.GetPartCorners(ModelBoxC, ModelBoxS, CornerFunc)

    -- //
    if (return3D) then
        return Corners3D, Failsafed
    else
        local Corners2D = ESP.Utilites.convertTo2D(Corners3D, convertBehind)
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

-- // Create a healthbar element
local HealthBarLerp = CIELUV:Lerp(Color3fromRGB(255, 0, 0), Color3fromRGB(0, 255, 0))
function ESP:HealthBar(Data)
    self = setmetatable({}, ESP)
    self.ClassName = "HealthBar"

    -- // Management
    do
        local idealData = {
            HealthPercentage = 1,
            ObjectData = {
                Thickness = 3,
                Color = Color3fromRGB(0, 255, 0),
                Visible = true,
                Filled = true
            },
            OutlineDivisor = 100,
            Offset = CFrame.new(0.5, 0, 0), -- // Please do not mess the Y-axis
            OutlineData = {
                Thickness = 3,
                Color = Color3fromRGB(0, 0, 0),
                Visible = true,
                Filled = true
            },
            Enabled = false
        }

        Data = addTableData(idealData, Data)
        self.Data = Data
    end

    -- // Outline
    self.OutlineObject = ESP.Utilites.Drawing("Quad", Data.OutlineData)

    -- // Object
    self.Object = ESP.Utilites.Drawing("Quad", Data.ObjectData)

    -- // Update function
    function self:Update(_Data)
        -- // Update data, if sent
        Data = self:UpdateData(_Data)

        -- // Vars
        local ObjectOffset = Data.Offset
        local Object = self.Object
        local OutlineObject = self.OutlineObject

        -- // Use for top left and bottom right
        local function Convert(A, B, Offset)
            -- //
            local Divisor = Data.OutlineDivisor
            local LengthAB = B.Position - A.Position
            local BlankA = A - A.Position
            local ACFrame = BlankA + (A.Position - (LengthAB / Divisor))

            -- //
            return ACFrame:ToWorldSpace(Offset)
        end
        local function ConvertManyOutline(Corners3D)
            return {
                Convert(Corners3D[2], Corners3D[1], ObjectOffset),
                Corners3D[2]:ToWorldSpace(ObjectOffset),
                Convert(Corners3D[4], Corners3D[3], ObjectOffset),
                Corners3D[4]:ToWorldSpace(ObjectOffset)
            }
        end
        local function ConvertManyObject(Corners3D, HealthPercentage)
            -- // Vars
            local Height = Corners3D[3].Position.Y - Corners3D[1].Position.Y
            local Remove = Vector3new(0, HealthPercentage * Height, 0)

            Corners3D[2] = Corners3D[2] - Remove

            -- // Return
            return {
                Convert(Corners3D[2], Corners3D[1], ObjectOffset),
                Corners3D[2]:ToWorldSpace(ObjectOffset),
                Convert(Corners3D[4], Corners3D[3], ObjectOffset),
                Corners3D[4]:ToWorldSpace(ObjectOffset)
            }
        end

        -- //
        local BoxCorners3D, Failsafed = ESP.Utilites.getBoxCorners(Data.Model, true, true)

        -- // Setting Points
        local BoxCorners2D = ESP.Utilites.convertTo2D(ConvertManyOutline(BoxCorners3D), true)
        local A = BoxCorners2D[2]
        local B = BoxCorners2D[1]
        local C = BoxCorners2D[3]
        local D = BoxCorners2D[4]
        OutlineObject.PointA = A
        OutlineObject.PointB = B
        OutlineObject.PointC = C
        OutlineObject.PointD = D
        Data.OutlineData.PointA = A
        Data.OutlineData.PointB = B
        Data.OutlineData.PointC = C
        Data.OutlineData.PointD = D

        BoxCorners2D = ESP.Utilites.convertTo2D(ConvertManyObject(BoxCorners3D, Data.HealthPercentage), true)
        A = BoxCorners2D[2]
        B = BoxCorners2D[1]
        C = BoxCorners2D[3]
        D = BoxCorners2D[4]
        Object.PointA = A
        Object.PointB = B
        Object.PointC = C
        Object.PointD = D
        Data.ObjectData.PointA = A
        Data.ObjectData.PointB = B
        Data.ObjectData.PointC = C
        Data.ObjectData.PointD = D

        -- // Other properties
        Object.Color = HealthBarLerp(Data.HealthPercentage)
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
            Offset = CFramenew(0, 2, 0),
            Enabled = true
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
            },
            Enabled = true
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
        ObjectData = {
            Visible = Visible and self.Data.Enabled
        }
    })
end

-- // Sets the ESP Object's visibility based upon whether the object is on the screen, disregardining line of sight
function ESP:IsOnScreen()
    -- // Vars
    local Middle = ESP.Utilites.GetCenter(self.Data.Model)
    local _, OnScreen = WorldToViewportPoint(CurrentCamera, Middle)

    -- // Set the visibility
    return self:Update({
        ObjectData = {
            Visible = OnScreen and self.Data.Enabled
        }
    })
end

-- // Return module
return ESP