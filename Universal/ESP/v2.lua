-- // Services
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

-- // Vars
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- // Module
local ESP = {}
getgenv().ESP = ESP

-- // Utilites
ESP.Utilites = {}

-- // Get the corners for the box
function ESP.Utilites:getBoxCorners(Character, returnType)
    local function GetPartCorners(CF, Size)
        local function getMidpoint(a, b)
            local modifiedPosition = Vector3.new((a.X + b.X) / 2, a.Y, (a.Z + b.Z) / 2)
            return (a - a.Position) + modifiedPosition
        end

        local front = {
            CF * CFrame.new(-Size.X / 2, Size.Y / 2, -Size.Z / 2),
            CF * CFrame.new(Size.X / 2, Size.Y / 2, -Size.Z / 2),
            CF * CFrame.new(-Size / 2),
            CF * CFrame.new(Size.X / 2, -Size.Y / 2, -Size.Z / 2)
        }
        local back = {
            CF * CFrame.new(-Size.X / 2, Size.Y / 2, Size.Z / 2),
            CF * CFrame.new(Size / 2),
            CF * CFrame.new(-Size.X / 2, -Size.Y / 2, Size.Z / 2),
            CF * CFrame.new(Size.X / 2, -Size.Y / 2, Size.Z / 2)
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
            local tPoint, _ = Camera:WorldToViewportPoint(point.Position)

            newPoints[i] = Vector2.new(tPoint.X, tPoint.Y)
        end

        return newPoints
    end

    local CharacterBoxC, CharacterBoxS = Character:GetBoundingBox()
    if (returnType) then
        return GetPartCorners(CharacterBoxC, CharacterBoxS)
    else
        local Corners3D = GetPartCorners(CharacterBoxC, CharacterBoxS)
        local Corners2D = convertTo2D(Corners3D)

        return Corners2D, Corners3D
    end
end

-- // Create Drawing Objects with Data
function ESP.Utilites:Drawing(Type, data)
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
-- // Create the elements
ESP.Creation = {}

-- // Create Box
function ESP.Creation:Box(data)
    -- // Management
    if (not data) then data = {} end
    local idealData = {
        Player = LocalPlayer,
        Character = LocalPlayer.Character,
        PrimaryPart = LocalPlayer.Character.PrimaryPart,
        Thickness = 3,
        Color = Color3.fromRGB(255, 150, 150),
        Visible = true,
        Filled = false,
    }
    for i,v in pairs(idealData) do
        if (not data[i]) then
            data[i] = v
        end
    end

    -- // Vars
    local BoxCorners = ESP.Utilites:getBoxCorners(data.Character)

    -- // Object
    local Object = ESP.Utilites:Drawing("Quad", data)

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
function ESP.Creation:Header(data)
    -- // Management
    if (not data) then data = {} end
    local idealData = {
        Player = LocalPlayer,
        Character = LocalPlayer.Character,
        PrimaryPart = LocalPlayer.Character.PrimaryPart,
        Thickness = 3,
        Color = Color3.fromRGB(255, 150, 150),
        Visible = true,
        Text = "Sex",
        Size = 14,
        Center = true,
        Outline = false,
        OutlineColor = Color3.fromRGB(255, 150, 150),
        Font = Drawing.Fonts.UI,
        Offset = CFrame.new(0, 2, 0)
    }
    for i,v in pairs(idealData) do
        if (not data[i]) then
            data[i] = v
        end
    end

    -- // Vars
    local BoxCFrame = ESP.Utilites:getBoxCorners(data.Character, true)

    -- // Object
    local Object = ESP.Utilites:Drawing("Text", data)

    -- // Midpoint
    local Blank = BoxCFrame[1] - BoxCFrame[1].Position
    local Midpoint = Blank + (BoxCFrame[1].Position + BoxCFrame[2].Position) / 2

    -- // Position
    local Position = Midpoint * data.Offset
    Position = Camera:WorldToViewportPoint(Position.Position)
    Position = Vector2.new(Position.X, Position.Y)

    -- // Setting stuff
    Object.Text = data.Player.Name
    Object.Position = Position

    -- // Returning the object
    data.Object = Object
    return data
end

-- // Create Tracer
local TracerStart = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
function ESP.Creation:Tracer(data)
    -- // Management
    if (not data) then data = {} end
    local idealData = {
        Player = LocalPlayer,
        Character = LocalPlayer.Character,
        PrimaryPart = LocalPlayer.Character.PrimaryPart,
        Thickness = 3,
        Color = Color3.fromRGB(255, 150, 150),
        Visible = true,
        From = TracerStart,
    }
    for i,v in pairs(idealData) do
        if (not data[i]) then
            data[i] = v
        end
    end

    -- // Vars
    local BoxCFrame = ESP.Utilites:getBoxCorners(data.Character, true)

    -- // Object
    local Object = ESP.Utilites:Drawing("Line", data)

    -- // Midpoint
    local Blank = BoxCFrame[3] - BoxCFrame[3].Position
    local Midpoint = Blank + (BoxCFrame[4].Position + BoxCFrame[3].Position) / 2

    -- // Position
    local Position = Midpoint
    Position = Camera:WorldToViewportPoint(Position.Position)
    Position = Vector2.new(Position.X, Position.Y)

    -- // Setting To position
    Object.To = Position

    -- // Returning the object
    data.Object = Object
    return data
end

-- // Update the elements
ESP.Update = {}
local Update = ESP.Update

-- // Update Box
function ESP.Update:Box(data)
    -- // Vars
    local BoxCorners = ESP.Utilites:getBoxCorners(data.Character)

    -- // Object
    local Object = data.Object
    Object.Filled = data.Filled
    Object.Thickness = data.Thickness
    Object.Color = data.Color
    Object.Visible = data.Visible

    -- // Setting Points
    Object.PointA = BoxCorners[2]
    Object.PointB = BoxCorners[1]
    Object.PointC = BoxCorners[3]
    Object.PointD = BoxCorners[4]

    -- // Returning the box
    data.Object = Object
    return data
end

-- // Update Text
function ESP.Update:Header(data)
    -- // Vars
    local BoxCFrame = ESP.Utilites:getBoxCorners(data.Character, true)

    -- // Object
    local Object = data.Object

    -- // Midpoint
    local Blank = BoxCFrame[1] - BoxCFrame[1].Position
    local Midpoint = Blank + ((BoxCFrame[1].Position + BoxCFrame[2].Position) / 2)

    -- // Position
    local Position = Midpoint * data.Offset
    Position = Camera:WorldToViewportPoint(Position.Position)
    Position = Vector2.new(Position.X, Position.Y)

    -- // Setting stuff
    Object.Text = data.Player.Name
    Object.Position = Position

    -- // Returning the object
    data.Object = Object
    return data
end

-- // Update Tracer
function ESP.Update:Tracer(data)
    -- // Vars
    local BoxCFrame = ESP.Utilites:getBoxCorners(data.Character, true)

    -- // Midpoint
    local Blank = BoxCFrame[3] - BoxCFrame[3].Position
    local Midpoint = Blank + (BoxCFrame[4].Position + BoxCFrame[3].Position) / 2

    -- // Position
    local Position = Midpoint
    Position = Camera:WorldToViewportPoint(Position.Position)
    Position = Vector2.new(Position.X, Position.Y)

    -- // Object
    local Object = data.Object
    Object.From = data.From
    Object.To = Position
    Object.Thickness = data.Thickness
    Object.Color = data.Color

    -- // Returning the box
    data.Object = Object
    return data
end

-- // Player Manager
local ESPManager = {}

local function manageNewPlayer(Player)
    if (not ESPManager[Player.Name]) then
        local Box = ESP.Creation:Box()
        local Tracer = ESP.Creation:Tracer()
        local Header = ESP.Creation:Header()

        ESPManager[Player.Name] = {
            Box = Box,
            Tracer = Tracer,
            Header = Header
        }
    end
end

local TypeToUpdate = {
    Box = ESP.Update.Box,
    Tracer = ESP.Update.Tracer,
    Header = ESP.Update.Header
}


local function manageOldPlayer(Player)
    for _,v in pairs(ESPManager) do
        for a,x in pairs(v) do
            local TypeUpdate = TypeToUpdate[a]

            if (TypeUpdate) then
                x.Object:Remove()
            end
        end
    end

    if (ESPManager[Player.Name]) then
        ESPManager[Player.Name] = nil
    end
end

local function manageUpdate()
    for i,v in pairs(ESPManager) do
        for a,x in pairs(v) do
            local TypeUpdate = TypeToUpdate[a]

            if (TypeUpdate) then
                TypeUpdate(Update, x)
            end
        end
    end
end

-- // Add Existing Players
do
    local AllPlayers = Players:GetPlayers()
    for i = 1, #AllPlayers do
        manageNewPlayer(AllPlayers[i])
    end
end

-- // Add New Players
Players.PlayerAdded:Connect(manageNewPlayer)

-- // Remove Old Players
Players.PlayerRemoving:Connect(manageOldPlayer)

-- // Constantly updating the ESP
RunService:BindToRenderStep("ESP", 0, manageUpdate)