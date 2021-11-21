-- // Services
local Workspace = game:GetService("Workspace")

-- // Vars
local CurrentCamera = Workspace.CurrentCamera

-- // Utilities
local Utilities = {}
do
    -- // Combine two tables
    function Utilities.CombineTables(Data, ToAdd)
        -- // Check to add exists
        if not (ToAdd) then
            return Data
        end

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
            print(i)
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
            table.insert(ConvertedPoints, Point2D)
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
    function Utilities.CalculateCornersBox(Object, Get2D, OnScreenCheck, CornerHandler)
        -- // Getting CF and Size
        local CF, Size = Utilities.GetCFrameAndSize(Object)

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
        Visible = false,
        ZIndex = 0,
        Transparency = 1,
        Color = Color3.fromRGB(255, 150, 150),

        Thickness = 3,
        Filled = false
    }
    Box.IdealData = {
        Enabled = true,
        Object = nil
    }

    -- // Constructor
    function Box.new(Data, DrawingData)
        -- // Initialise class
        local self = setmetatable({}, Box)

        -- // Data
        self.Data = Utilities.CombineTables(self.IdealData, Data)
        self.DrawingData = Utilities.CombineTables(self.DrawingDefault, DrawingData)

        -- //
        self.Drawing = Utilities.CreateDrawing(self.DrawingType, self.DrawingData)

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
            self.Drawing[i] = v
        end

        -- // Vars
        Data = self.Data
        local Object = Data.Object
        local DrawingObject = self.Drawing

        -- // Skip if disabled or invisible or transparency is 0
        if (not (Data.Enabled or DrawingObject.Visible) or DrawingObject.Transparency == 0) then
            return
        end

        -- // Get the points
        local Points = Utilities.CalculateCornersBox(Object, true, true)

        -- // Make sure we have them
        if (not Points) then
            return
        end

        -- // Set the points
        DrawingObject.PointA = Points[2]
        DrawingObject.PointB = Points[1]
        DrawingObject.PointC = Points[3]
        DrawingObject.PointD = Points[4]
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
        Visible = false,
        ZIndex = 0,
        Transparency = 1,
        Color = Color3.fromRGB(255, 150, 150),

        Text = nil,
        Size = 14,
        Center = true,
        Outline = true,
        OutlineColor = Color3.fromRGB(255, 255, 255),
        Font = Drawing.Fonts.UI
    }
    Header.IdealData = {
        Enabled = true,
        Object = nil,
        Offset = nil
    }

    -- // Constructor
    function Header.new(Data, DrawingData)
        -- // Initialise class
        local self = setmetatable({}, Header)

        -- // Data
        self.Data = Utilities.CombineTables(self.IdealData, Data)
        self.DrawingData = Utilities.CombineTables(self.DrawingDefault, DrawingData)

        -- //
        self.Drawing = Utilities.CreateDrawing(self.DrawingType, self.DrawingData)

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
            self.Drawing[i] = v
        end

        -- // Vars
        Data = self.Data
        local Object = Data.Object
        local DrawingObject = self.Drawing

        -- // Skip if disabled or invisible or transparency is 0
        if (not (Data.Enabled or DrawingObject.Visible) or DrawingObject.Transparency == 0) then
            return
        end

        -- // Get the points
        local Points = Utilities.CalculateCornersBox(Object, true, true)

        -- // Make sure we have them
        if (not Points) then
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
            Position = Offset(Position, Points)
        -- // Static Offset
        elseif (OffsetType == "number") then
            Position = Position * Offset
        end

        -- // Convert Position
        Position = CurrentCamera:WorldToViewportPoint(Position)
        Position = Vector2.new(Position.X, Position.Y)

        -- // Configuring the drawing
        DrawingObject.Text = Data.Text or Object.Name or "nil"
        DrawingObject.Position = Position
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
        Visible = false,
        ZIndex = 0,
        Transparency = 1,
        Color = Color3.fromRGB(255, 150, 150),

        Thickness = 3
    }
    Tracer.IdealData = {
        Enabled = true,
        Object = nil,
        Offset = nil
    }

    -- // Constructor
    function Tracer.new(Data, DrawingData)
        -- // Initialise class
        local self = setmetatable({}, Tracer)

        -- // Data
        self.Data = Utilities.CombineTables(self.IdealData, Data)
        self.DrawingData = Utilities.CombineTables(self.DrawingDefault, DrawingData)

        -- //
        self.Drawing = Utilities.CreateDrawing(self.DrawingType, self.DrawingData)

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
            self.Drawing[i] = v
        end

        -- // Vars
        Data = self.Data
        local Object = Data.Object
        local DrawingObject = self.Drawing

        -- // Skip if disabled or invisible or transparency is 0
        if (not (Data.Enabled or DrawingObject.Visible) or DrawingObject.Transparency == 0) then
            return
        end

        -- // Get the points
        local Points = Utilities.CalculateCornersBox(Object, true, true)

        -- // Make sure we have them
        if (not Points) then
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
end

-- // Return
return {
    Box = Box,
    Header = Header,
    Tracer = Tracer,
    Utilities = Utilities
}