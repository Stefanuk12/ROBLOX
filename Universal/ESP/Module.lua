-- // Services
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

-- // Vars
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

local WorldToViewportPoint = Camera.WorldToViewportPoint
local newVector2 = Vector2.new
local newVector3 = Vector3.new
local newCFrame = CFrame.new
local newRaycastParams = RaycastParams.new
local Raycast = Workspace.Raycast
local Color3fromRGB = Color3.fromRGB
local IsDescendantOf = Instance.new("Part").IsDescendantOf
local EnumRaycastFilterTypeBlacklist = Enum.RaycastFilterType.Blacklist
local GetBoundingBox = Instance.new("Model").GetBoundingBox

-- // Module
local ESP = {}
getgenv().ESP = ESP

-- // Utilites
ESP.Utilites = {}

-- // Get the corners for the box
function ESP.Utilites.getBoxCorners(Character, returnType)
    local function GetPartCorners(CF, Size)
        local function getMidpoint(a, b)
            local modifiedPosition = newVector3((a.X + b.X) / 2, a.Y, (a.Z + b.Z) / 2)
            return (a - a.Position) + modifiedPosition
        end

        local front = {
            CF * newCFrame(-Size.X / 2, Size.Y / 2, -Size.Z / 2),
            CF * newCFrame(Size.X / 2, Size.Y / 2, -Size.Z / 2),
            CF * newCFrame(-Size / 2),
            CF * newCFrame(Size.X / 2, -Size.Y / 2, -Size.Z / 2)
        }
        local back = {
            CF * newCFrame(-Size.X / 2, Size.Y / 2, Size.Z / 2),
            CF * newCFrame(Size / 2),
            CF * newCFrame(-Size.X / 2, -Size.Y / 2, Size.Z / 2),
            CF * newCFrame(Size.X / 2, -Size.Y / 2, Size.Z / 2)
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
            local tPoint, _ = Camera.WorldToViewportPoint(Camera, point.Position)

            newPoints[i] = newVector2(tPoint.X, tPoint.Y)
        end

        return newPoints
    end

    local CharacterBoxC, CharacterBoxS = GetBoundingBox(Character)
    if (returnType) then
        return GetPartCorners(CharacterBoxC, CharacterBoxS)
    else
        local Corners3D = GetPartCorners(CharacterBoxC, CharacteCharacterBoxS)
        local Corners2D = convertTo2D(Corners3D)

        return Corners2D, Corners3D
    end
end

-- // Create Drawing Objects with Data
function ESP.Utilites.Drawing(Type, data)
    local Object = Drawing.new(Type)

    for i,v in pairs(data) do
        local success, _ = pcall(function()
            local test = Object[i]
        end)

        if (success) then
            Object[i] = v
        end
    end

    return Object
end

-- // Get Character
function ESP.Utilites.GetCharacter(Player)
    local Character = Player.Character or Player.CharacterAdded.Wait(Player)
    return Character, Character.PrimaryPart
end

-- // Check if part is visible
function ESP.Utilites.IsVisible(Part, PartDescendant)
    -- // Vars
    local Character = ESP.Utilites.GetCharacter(LocalPlayer)
    local Origin = Camera.CFrame.Position
    local _, OnScreen = WorldToViewportPoint(Camera, Part.Position)

    -- // If Part is on the screen
    if (OnScreen) then
        -- // Vars: Calculating if is visible
        local raycastParams = newRaycastParams()
        raycastParams.FilterType = EnumRaycastFilterTypeBlacklist
        raycastParams.FilterDescendantsInstances = {Character, Camera}

        local Result = Raycast(Workspace, Origin, Part.Position - Origin, raycastParams)
        local PartHit = Result.Instance
        local Visible = (not PartHit or IsDescendantOf(PartHit, PartDescendant))

        -- // Return
        return Visible
    end

    -- // Return
    return false
end

-- // Check if a part is on screen
function ESP.Utilites.IsOnScreen(Part)
    -- //
    if (not Part) then return false end

    -- // Vars
    local _, OnScreen = WorldToViewportPoint(Camera, Part.Position)

    return OnScreen
end

-- // Create the elements
ESP.Creation = {}

-- // Create Box
function ESP.Creation.Box(data)
    -- // Management
    do
        if (not data) then data = {} end
        if (not data.Player) then data.Player = LocalPlayer end

        local Player = data.Player
        local Character, PrimaryPart = ESP.Utilites.GetCharacter(Player)
        local idealData = {
            Character = Character,
            PrimaryPart = PrimaryPart,
            Thickness = 3,
            Color = Color3fromRGB(255, 150, 150),
            Visible = true,
            Filled = false,
        }
        for i,v in pairs(idealData) do
            if (not data[i]) then
                data[i] = v
            end
        end
    end

    -- // Vars
    local BoxCorners = ESP.Utilites.getBoxCorners(data.Character)

    -- // Object
    local Object = ESP.Utilites.Drawing("Quad", data)

    -- // Setting Points
    Object.PointA = BoxCorners[2]
    Object.PointB = BoxCorners[1]
    Object.PointC = BoxCorners[3]
    Object.PointD = BoxCorners[4]

    -- // Returning the object
    data.Object = Object
    return data
end

-- // Create Header (text)
function ESP.Creation.Header(data)
    -- // Management
    do
        if (not data) then data = {} end
        if (not data.Player) then data.Player = LocalPlayer end

        local Player = data.Player
        local Character, PrimaryPart = ESP.Utilites.GetCharacter(Player)
        local idealData = {
            Character = Character,
            PrimaryPart = PrimaryPart,
            Thickness = 3,
            Color = Color3fromRGB(255, 150, 150),
            Visible = true,
            Text = "Sex",
            Size = 14,
            Center = true,
            Outline = false,
            OutlineColor = Color3fromRGB(255, 150, 150),
            Font = Drawing.Fonts.UI,
            Offset = newCFrame(0, 2, 0)
        }
        for i,v in pairs(idealData) do
            if (not data[i]) then
                data[i] = v
            end
        end
    end

    -- // Vars
    local BoxCFrame = ESP.Utilites.getBoxCorners(data.Character, true)

    -- // Object
    local Object = ESP.Utilites.Drawing("Text", data)

    -- // Midpoint
    local Blank = BoxCFrame[1] - BoxCFrame[1].Position
    local Midpoint = Blank + (BoxCFrame[1].Position + BoxCFrame[2].Position) / 2

    -- // Position
    local Position = Midpoint * data.Offset
    Position = WorldToViewportPoint(Camera, Position.Position)
    Position = newVector2(Position.X, Position.Y)

    -- // Setting stuff
    Object.Text = data.Player.Name
    Object.Position = Position

    -- // Returning the object
    data.Object = Object
    return data
end

-- // Create Tracer
local TracerStart = newVector2(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
function ESP.Creation.Tracer(data)
    -- // Management
    do
        if (not data) then data = {} end
        if (not data.Player) then data.Player = LocalPlayer end

        local Player = data.Player
        local Character, PrimaryPart = ESP.Utilites.GetCharacter(Player)
        local idealData = {
            Character = Character,
            PrimaryPart = PrimaryPart,
            Thickness = 3,
            Color = Color3fromRGB(255, 150, 150),
            Visible = true,
            From = TracerStart,
        }
        for i,v in pairs(idealData) do
            if (not data[i]) then
                data[i] = v
            end
        end
    end

    -- // Vars
    local BoxCFrame = ESP.Utilites.getBoxCorners(data.Character, true)

    -- // Object
    local Object = ESP.Utilites.Drawing("Line", data)

    -- // Midpoint
    local Blank = BoxCFrame[3] - BoxCFrame[3].Position
    local Midpoint = Blank + (BoxCFrame[4].Position + BoxCFrame[3].Position) / 2

    -- // Position
    local Position = Midpoint
    Position = WorldToViewportPoint(Camera, Position.Position)
    Position = newVector2(Position.X, Position.Y)

    -- // Setting To position
    Object.To = Position

    -- // Returning the object
    data.Object = Object
    return data
end

-- // Update the elements
ESP.Update = {}

-- // Update Box
function ESP.Update.Box(data)
    -- // Management
    do
        local Character, PrimaryPart = ESP.Utilites.GetCharacter(data.Player)
        data.Character = Character
        data.PrimaryPart = PrimaryPart
    end

    -- // Object
    local Object = data.Object

    -- // On screen check
    if (not ESP.Utilites.IsOnScreen(data.PrimaryPart)) then
        Object.Visible = false
        data.Visible = false

        -- // Returning the object
        return data
    else
        Object.Visible = true
        data.Visible = true
    end

    -- // Vars
    local BoxCorners = ESP.Utilites.getBoxCorners(data.Character)

    -- // Object
    Object.Filled = data.Filled
    Object.Thickness = data.Thickness
    Object.Color = data.Color
    Object.Visible = data.Visible

    -- // Setting Points
    Object.PointA = BoxCorners[2]
    Object.PointB = BoxCorners[1]
    Object.PointC = BoxCorners[3]
    Object.PointD = BoxCorners[4]

    -- // Returning the data
    return data
end

-- // Update Text
function ESP.Update.Header(data)
    -- // Management
    do
        local Character, PrimaryPart = ESP.Utilites.GetCharacter(data.Player)
        data.Character = Character
        data.PrimaryPart = PrimaryPart
    end

    -- // Object
    local Object = data.Object

    -- // On screen check
    if (not ESP.Utilites.IsOnScreen(data.PrimaryPart)) then
        Object.Visible = false
        data.Visible = false

        -- // Returning the object
        return data
    else
        Object.Visible = true
        data.Visible = true
    end

    -- // Vars
    local BoxCFrame = ESP.Utilites.getBoxCorners(data.Character, true)

    -- // Midpoint
    local Blank = BoxCFrame[1] - BoxCFrame[1].Position
    local Midpoint = Blank + ((BoxCFrame[1].Position + BoxCFrame[2].Position) / 2)

    -- // Position
    local Position = Midpoint * data.Offset
    Position = WorldToViewportPoint(Camera, Position.Position)
    Position = newVector2(Position.X, Position.Y)

    -- // Setting stuff
    Object.Text = data.Player.Name
    Object.Position = Position

    -- // Returning the data
    return data
end

-- // Update Tracer
function ESP.Update.Tracer(data)
    -- // Management
    do
        local Character, PrimaryPart = ESP.Utilites.GetCharacter(data.Player)
        data.Character = Character
        data.PrimaryPart = PrimaryPart
    end

    -- // Object
    local Object = data.Object

    -- // On screen check
    if (not ESP.Utilites.IsOnScreen(data.PrimaryPart)) then
        Object.Visible = false
        data.Visible = false

        -- // Returning the object
        return data
    else
        Object.Visible = true
        data.Visible = true
    end

    -- // Vars
    local BoxCFrame = ESP.Utilites.getBoxCorners(data.Character, true)

    -- // Midpoint
    local Blank = BoxCFrame[3] - BoxCFrame[3].Position
    local Midpoint = Blank + (BoxCFrame[4].Position + BoxCFrame[3].Position) / 2

    -- // Position
    local Position = Midpoint
    Position = WorldToViewportPoint(Camera, Position.Position)
    Position = newVector2(Position.X, Position.Y)

    -- // Object
    Object.From = data.From
    Object.To = Position
    Object.Thickness = data.Thickness
    Object.Color = data.Color

    -- // Returning the data
    return data
end

return ESP