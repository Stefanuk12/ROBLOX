-- // Dependencies
local CIELUV = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/ESP/CIELUV.lua"))()

-- // Services
local Workspace = game:GetService("Workspace")

-- // Vars
local CurrentCamera = Workspace.CurrentCamera

-- // Utilities
local Utilities = {}
do
    -- // Combine two tables
    function Utilities.CombineTables(ToAdd, Data)
        -- // Default
        ToAdd = ToAdd or {}
        Data = Data or {}

        -- // Loop through data we want to add
        for i, v in pairs(ToAdd) do
            -- // If data does not exist
            if (not Data[i]) then
                Data[i] = v
                continue
            end

            -- // Check if table
            if (typeof(v) == "table") then
                Data[i] = Utilities.CombineTables(Data, v)
                continue
            end

            -- // Add
            Data[i] = v
        end

        -- // Return
        return Data
    end

    -- // Create a drawing based upon Data
    function Utilities.CreateDrawing(Type, Data)
        -- // Create drawing
        local Object = Drawing.new(Type)

        -- // Loop through the data
        for i, v in pairs(Data) do
            -- // Assign the properties
            Object[i] = v
        end

        -- // Return the drawing
        return Object
    end

    -- // Get corners
    function Utilities.CalculateCorners(CF, Size, Handler)
        -- // Default
        Handler = Handler or function(Front, Back)
            -- // Get the midpoint
            local Midpoint = Vector3.new((Front.X + Back.X) / 2, Front.Y, (Front.Z + Back.Z) / 2)

            -- //
            local Blank = (Front - Front.Position)

            -- //
            return Blank + Midpoint
        end

        -- // Calculate the positions of the front face corners
        local Front = {
            CF * CFrame.new(-Size.X / 2, Size.Y / 2, -Size.Z / 2), -- // Top Left (A)
            CF * CFrame.new(Size.X / 2, Size.Y / 2, -Size.Z / 2), -- // Top Right (F)
            CF * CFrame.new(-Size / 2), -- // Bottom Left (C)
            CF * CFrame.new(Size.X / 2, -Size.Y / 2, -Size.Z / 2) -- // Bottom Right (E)
        }

        -- // Calculate the positions of the back face corners
        local Back = {
            CF * CFrame.new(-Size.X / 2, Size.Y / 2, Size.Z / 2), -- // Top Left (B)
            CF * CFrame.new(Size / 2), -- // Top Right (G)
            CF * CFrame.new(-Size.X / 2, -Size.Y / 2, Size.Z / 2), -- // Bottom Right (H)
            CF * CFrame.new(Size.X / 2, -Size.Y / 2, Size.Z / 2) -- // Bottom Left (D)
        }

        -- //
        local Points = {}
        for i = 1, 4 do
            -- //
            Points[i] = Handler(Front[i], Back[i])
        end

        -- // Return processed points
        return Points
    end

    -- //
    function Utilities.CalculatePositionBehind(Point3D, Point2D)
        Point2D = Point2D or CurrentCamera:WorldToViewportPoint(Point3D)
        local ObjectSpace = CurrentCamera.CFrame:PointToObjectSpace(Point3D)

        -- // Check if behind
        if (Point2D.Z < 0) then
            local AT = math.atan2(ObjectSpace.Y, ObjectSpace.X) + math.pi
            ObjectSpace = CFrame.Angles(0, 0, AT):VectorToWorldSpace((CFrame.Angles(0, math.rad(89.9), 0):VectorToWorldSpace(Vector3.new(0, 0, -1))))
        end

        -- //
        return CurrentCamera:WorldToViewportPoint(CurrentCamera.CFrame:PointToWorldSpace(ObjectSpace))
    end

    -- // Convert 3D points to 2D points
    function Utilities.ConvertTo2D(Points, ReturnOffScreen)
        -- // Vars
        local ConvertedPoints = {}

        -- // Loop through points
        for _, Point in ipairs(Points) do
            -- // Vars
            local Point2D, OnScreen = CurrentCamera:WorldToViewportPoint(Point.Position)

            -- // On Screen Check
            if (ReturnOffScreen and not OnScreen) then
                return false
            end

            -- // Add it
            table.insert(ConvertedPoints, Vector2.new(Point2D.X, Point2D.Y))
        end

        -- // Retun
        return ConvertedPoints
    end

    -- //
    function Utilities.GetCFrameAndSize(Object)
        -- // Model
        if (Object:IsA("Model")) then
            return Object:GetBoundingBox()
        end

        -- // Base Part
        if (Object:IsA("BasePart")) then
            return Object.CFrame, Object.Size
        end

        -- // Other types
        local TargetClone = Object:Clone()

        -- // Create and configure a temp model
        local TempModel = Instance.new("Model")
        TargetClone.Parent = TempModel

        -- // Set
        return TempModel:GetBoundingBox()
    end

    -- //
    function Utilities.CalculateCornersBox(Object, Get2D, OnScreenCheck, RenderDistance, LookAtCamera, CornerHandler)
        -- // Vars
        local CameraPosition = CurrentCamera.CFrame.Position

        -- // Getting CF and Size
        local CF, Size = Utilities.GetCFrameAndSize(Object)

        -- // Check render distance
        local Magnitude = (CF.Position - CameraPosition).Magnitude
        if (Magnitude > RenderDistance) then
            return
        end

        -- //
        if (LookAtCamera) then
            CF = CFrame.lookAt(CF.Position, CameraPosition)
        end

        -- // Calculate where the corners are within 3D space
        local Corners3D = Utilities.CalculateCorners(CF, Size, CornerHandler)

        -- // Get 2D if specified
        local Corners2D
        if (Get2D) then
            Corners2D = Utilities.ConvertTo2D(Corners3D, OnScreenCheck)
        end

        -- // Return
        return Corners3D, Corners2D
    end
end

-- // Box Class
local Box = {}
Box.__index = Box
Box.__type = "Box"
do
    -- // Vars
    Box.DrawingType = "Quad"
    Box.DrawingDefault = {
        Visible = true,
        ZIndex = 0,
        Transparency = 1,
        Color = Color3.fromRGB(255, 150, 150),

        Thickness = 3,
        Filled = false
    }
    Box.IdealData = {
        Enabled = true,
        Object = nil,

        RenderDistance = 1/0
    }
    Box.GlobalEnabled = true
    Box.GlobalLookAtCamera = false

    -- // Constructor
    function Box.new(Data, DrawingData)
        -- // Initialise class
        local self = setmetatable({}, Box)

        -- // Data
        self.Data = Utilities.CombineTables(self.IdealData, Data)
        self.DrawingData = Utilities.CombineTables(self.DrawingDefault, DrawingData)

        -- //
        self.Drawings = {Utilities.CreateDrawing(self.DrawingType, self.DrawingData)}

        -- // Return
        return self
    end

    -- // Update
    function Box.Update(self, Data, DrawingData)
        -- // Loop through the data
        for i, v in pairs(Data or {}) do
            -- // Set
            self.Data[i] = v
        end
        for i, v in pairs(DrawingData or {}) do
            -- // Set
            self.Drawings[1][i] = v
        end

        -- // Vars
        Data = self.Data
        local Object = Data.Object
        local DrawingObject = self.Drawings[1]

        -- // Skip if disabled
        if (not Data.Enabled or not self.GlobalEnabled or not Object) then
            DrawingObject.Visible = false
            return
        end

        -- // Get the points
        local _, Points = Utilities.CalculateCornersBox(Object, true, true, Data.RenderDistance, self.GlobalLookAtCamera)
        DrawingObject.Visible = not not Points

        -- // Make sure we have them
        if (not DrawingObject.Visible) then
            return
        end

        -- // Set the points
        DrawingObject.PointA = Points[2]
        DrawingObject.PointB = Points[1]
        DrawingObject.PointC = Points[3]
        DrawingObject.PointD = Points[4]
    end

    -- // Remove
    function Box.Remove(self)
        self.Drawings[1]:Remove()
    end
end

-- // Header Class
local Header = {}
Header.__index = Header
Header.__type = "Header"
do
    -- // Vars
    Header.DrawingType = "Text"
    Header.DrawingDefault = {
        Visible = true,
        ZIndex = 0,
        Transparency = 1,
        Color = Color3.fromRGB(255, 150, 150),

        Text = nil,
        Size = 18,
        Center = true,
        Outline = true,
        OutlineColor = Color3.fromRGB(255, 255, 255),
        Font = Drawing.Fonts.UI
    }
    Header.IdealData = {
        Enabled = true,
        Object = nil,
        Offset = function(Position, Points, Points2D)
            -- // Return
            return Position * CFrame.new(0, -1.5, 0)
        end,

        RenderDistance = 1/0,

        ScaleWithDistance = true,
        _Size = 1/4,
        _SizeClamp = {1, 14}
    }
    Header.GlobalEnabled = true
    Header.GlobalLookAtCamera = false

    -- // Constructor
    function Header.new(Data, DrawingData)
        -- // Initialise class
        local self = setmetatable({}, Header)

        -- // Data
        self.Data = Utilities.CombineTables(self.IdealData, Data)
        self.DrawingData = Utilities.CombineTables(self.DrawingDefault, DrawingData)

        -- //
        self.Drawings = {Utilities.CreateDrawing(self.DrawingType, self.DrawingData)}

        -- // Return
        return self
    end

    -- // Update
    function Header.Update(self, Data, DrawingData)
        -- // Loop through the data
        for i, v in pairs(Data or {}) do
            -- // Set
            self.Data[i] = v
        end
        for i, v in pairs(DrawingData or {}) do
            -- // Set
            self.Drawings[1][i] = v
        end

        -- // Vars
        Data = self.Data
        local Object = Data.Object
        local DrawingObject = self.Drawings[1]

        -- // Skip if disabled
        if (not Data.Enabled or not self.GlobalEnabled or not Object) then
            DrawingObject.Visible = false
            return
        end

        -- // Get the points
        local Points, Points2D = Utilities.CalculateCornersBox(Object, true, true, Data.RenderDistance, self.GlobalLookAtCamera)
        DrawingObject.Visible = not not Points2D

        -- // Make sure we have them
        if (not DrawingObject.Visible or not Points2D) then
            return
        end

        -- // Get the midpoint
        local Blank = Points[1] - Points[1].Position
        local Midpoint = Blank + (Points[1].Position + Points[2].Position) / 2

        -- // Get the position
        local Position = Midpoint

        -- // Offset
        local Offset = Data.Offset
        local OffsetType = typeof(Offset)

        -- // Dynamic Offset
        if (OffsetType == "function") then
            Position = Offset(Position, Points, Points2D)
        -- // Static Offset
        elseif (OffsetType == "number") then
            Position = Position * Offset
        end

        -- // Figuring out the size (Disabled)
        if (Data.ScaleWithDistance and false) then
            -- // Vars
            local TopLeft, _ = CurrentCamera:WorldToViewportPoint(Points[1].Position)
            local BottomLeft, _ = CurrentCamera:WorldToViewportPoint(Points[3].Position)

            local Height = BottomLeft.Y - TopLeft.Y
            local Size = Height * Data._Size
            local SizeClamp = Data._SizeClamp

            -- //
            DrawingObject.Size = math.clamp(Size, unpack(SizeClamp))
        end

        -- // Convert Position
        local PositionType = typeof(Position)
        if (PositionType == "CFrame" or PositionType == "Vector3") then
            -- // Convert
            local _Position, OnScreen = CurrentCamera:WorldToViewportPoint(PositionType == "CFrame" and Position.Position or Position)

            -- // Onscreen check, just in case
            if (not OnScreen) then
                DrawingObject.Visible = false
                return
            end

            -- // Convert position
            _Position = Vector2.new(_Position.X, _Position.Y)
            Position = _Position
        end

        Position = Position - Vector2.new(0, DrawingObject.TextBounds.Y)

        -- // Configuring the drawing
        DrawingObject.Text = Data.Text or Object.Name or "nil"
        DrawingObject.Position = Position
    end

    -- // Remove
    function Header.Remove(self)
        self.Drawings[1]:Remove()
    end
end

-- // Tracer Class
local Tracer = {}
Tracer.__index = Tracer
Tracer.__type = "Tracer"
do
    -- // Vars
    Tracer.DrawingType = "Line"
    Tracer.DrawingDefault = {
        Visible = true,
        ZIndex = 0,
        Transparency = 1,
        Color = Color3.fromRGB(255, 150, 150),

        From = Vector2.new(CurrentCamera.ViewportSize.X / 2, CurrentCamera.ViewportSize.Y - 34),
        Thickness = 3
    }
    Tracer.IdealData = {
        Enabled = true,
        Object = nil,
        Offset = nil,

        RenderDistance = 1/0
    }
    Tracer.GlobalEnabled = true
    Tracer.GlobalLookAtCamera = false

    -- // Constructor
    function Tracer.new(Data, DrawingData)
        -- // Initialise class
        local self = setmetatable({}, Tracer)

        -- // Data
        self.Data = Utilities.CombineTables(self.IdealData, Data)
        self.DrawingData = Utilities.CombineTables(self.DrawingDefault, DrawingData)

        -- //
        self.Drawings = {Utilities.CreateDrawing(self.DrawingType, self.DrawingData)}

        -- // Return
        return self
    end

    -- // Update
    function Tracer.Update(self, Data, DrawingData)
        -- // Loop through the data
        for i, v in pairs(Data or {}) do
            -- // Set
            self.Data[i] = v
        end
        for i, v in pairs(DrawingData or {}) do
            -- // Set
            self.Drawings[1][i] = v
        end

        -- // Vars
        Data = self.Data
        local Object = Data.Object
        local DrawingObject = self.Drawings[1]

        -- // Skip if disabled
        if (not Data.Enabled or not self.GlobalEnabled or not Object) then
            DrawingObject.Visible = false
            return
        end

        -- // Get the points
        local Points = Utilities.CalculateCornersBox(Object, false, false, Data.RenderDistance, self.GlobalLookAtCamera)
        DrawingObject.Visible = not not Points

        -- // Make sure we have them
        if (not DrawingObject.Visible) then
            return
        end

        -- // Get the midpoint
        local Blank = Points[1] - Points[1].Position
        local Midpoint = Blank + (Points[4].Position + Points[3].Position) / 2

        -- // Getting the position
        local Position = Utilities.CalculatePositionBehind(Midpoint.Position)
        Position = Vector2.new(Position.X, Position.Y)

        -- // Set To
        DrawingObject.To = Position
    end

    -- // Remove
    function Tracer.Remove(self)
        self.Drawings[1]:Remove()
    end
end

-- // Healthbar Class
local Healthbar = {}
Healthbar.__index = Healthbar
Healthbar.__type = "Healthbar"
do
    -- // Vars
    Healthbar.DrawingType = "Quad"
    Healthbar.DrawingDefault = {
        Visible = true,
        ZIndex = 0,
        Transparency = 1,
        Color = Color3.fromRGB(30, 30, 30),

        Thickness = 3,
        Filled = true
    }
    Healthbar.DrawingType2 = "Quad"
    Healthbar.DrawingDefault2 = {
        Visible = true,
        ZIndex = 1,
        Transparency = 1,
        Color = Color3.fromRGB(169, 220, 118),

        Thickness = 3,
        Filled = true
    }
    Healthbar.IdealData = {
        Enabled = true,
        Object = nil,

        RenderDistance = 1/0,

        HealthPercentage = 1,
        Width = 1/3,
        Offset = 1/6
    }
    Healthbar.CIELUV = CIELUV(Color3.fromRGB(255, 97, 136), Color3.fromRGB(169, 220, 118))
    Healthbar.GlobalEnabled = true
    Healthbar.GlobalLookAtCamera = false

    -- // Constructor
    function Healthbar.new(Data, DrawingData, DrawingData2)
        -- // Initialise class
        local self = setmetatable({}, Healthbar)

        -- // Data
        self.Data = Utilities.CombineTables(self.IdealData, Data)
        self.DrawingData = Utilities.CombineTables(self.DrawingDefault, DrawingData)
        self.DrawingData2 = Utilities.CombineTables(self.DrawingDefault2, DrawingData2)

        -- //
        self.Drawings = {Utilities.CreateDrawing(self.DrawingType, self.DrawingData), Utilities.CreateDrawing(self.DrawingType2, self.DrawingData2)}

        -- // Return
        return self
    end

    -- // Update
    function Healthbar.Update(self, Data, DrawingData, DrawingData2)
        -- // Loop through the data
        for i, v in pairs(Data or {}) do
            -- // Set
            self.Data[i] = v
        end
        for i, v in pairs(DrawingData or {}) do
            -- // Set
            self.Drawings[1][i] = v
        end
        for i, v in pairs(DrawingData2 or {}) do
            -- // Set
            self.Drawings[2][i] = v
        end

        -- // Vars
        Data = self.Data
        local Object = Data.Object
        local Background = self.Drawings[1]
        local Main = self.Drawings[2]

        -- // Skip if disabled
        if (not Data.Enabled or not self.GlobalEnabled or not Object) or true then
            Background.Visible = false
            Main.Visible = false
            return
        end

        -- // Get the points
        local _, Points = Utilities.CalculateCornersBox(Object, true, true, Data.RenderDistance, self.GlobalLookAtCamera)
        local isVisible = not not Points
        Background.Visible = isVisible
        Main.Visible = isVisible

        -- // Make sure we have them
        if (not isVisible) then
            return
        end

        -- // Vars
        local TopRight = Points[2]
        local TopLeft = Points[1]
        local BottomLeft = Points[3]
        local BottomRight = Points[4]

        local LeftHeight = (TopLeft.Y - BottomLeft.Y)
        local RightHeight = (TopRight.Y - BottomRight.Y)
        local TopWidth = (TopRight.X - TopLeft.X)
        local BottomWidth = (BottomRight.X - BottomLeft.X)

        local TopRightOffset = TopLeft - Vector2.new(TopWidth * Data.Offset, 0)
        local BottomRightOffset = TopRight - Vector2.new(TopWidth * Data.Offset, 0)

        local TopLeftPoint = TopRightOffset - Vector2.new(TopWidth * Data.Width, 0)
        local BottomLeftPoint = BottomRightOffset - Vector2.new(BottomWidth * Data.Width, 0)

        -- // Set the points for the background
        Background.PointA = TopRightOffset
        Background.PointB = TopLeftPoint
        Background.PointC = BottomLeftPoint
        Background.PointD = BottomRightOffset

        -- // Set the points for the main
        Main.PointA = TopRightOffset - Vector2.new(0, RightHeight - (RightHeight * (1 - Data.HealthPercentage)))
        Main.PointB = TopLeftPoint - Vector2.new(0, LeftHeight - (LeftHeight * (1 - Data.HealthPercentage)))
        Main.PointC = BottomLeftPoint
        Main.PointD = BottomRightOffset

        -- // Work out the fill colour for the main
        Main.Color = Healthbar.CIELUV(Data.HealthPercentage)
    end
end

-- // Return
local Base = {
    Box = Box,
    Header = Header,
    Tracer = Tracer,
    Healthbar = Healthbar,
    Utilities = Utilities
}
-- getgenv().Base = Base
return Base