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
function ESP.Utilites:getBoxCorners(Character)
    local function GetPartCorners(CF, Size)
        local function getMidpoint(a, b)
            return CFrame.new((a.X + b.X) / 2, a.Y, (a.Z + b.Z) / 2)
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
        for i = 1, #points do
            local point = points[i]
            local tPoint, _ = Camera:WorldToViewportPoint(point.Position)

            points[i] = Vector2.new(tPoint.X, tPoint.Y)
        end

        return points
    end

    local CharacterBoxC, CharacterBoxS = Character:GetBoundingBox()
    local Corners3D = GetPartCorners(CharacterBoxC, CharacterBoxS)
    local Corners2D = convertTo2D(Corners3D)

    return Corners2D, Corners3D
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
        Offset = Vector2.new(10, 50)
    }
    for i,v in pairs(idealData) do
        if (not data[i]) then
            data[i] = v
        end
    end

    -- // Vars
    local BoxCorners = ESP.Utilites:getBoxCorners(data.Character)

    -- // Object
    local Object = ESP.Utilites:Drawing("Text", data)

    -- // Setting Position
    Object.Position = BoxCorners[1] + Vector2.new((BoxCorners[2].X - BoxCorners[1].X) / 2, data.VerticalOffset)

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
    local BoxCorners = ESP.Utilites:getBoxCorners(data.Character)

    -- // Object
    local Object = ESP.Utilites:Drawing("Line", data)

    -- // Setting To position
    Object.To = BoxCorners[3] + Vector2.new((BoxCorners[4].X - BoxCorners[3].X) / 2, 0)

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
    local BoxCorners, BoxCorners3D = ESP.Utilites:getBoxCorners(data.Character)

    -- // Object
    local Object = data.Object

    -- // Calculating vertical offset

    -- // Setting stuff
    Object.Text = data.Player.Name
    Object.Position = BoxCorners[1] + Vector2.new((BoxCorners[2].X - BoxCorners[1].X) / 2, data.Offset.Y)

    -- // Returning the object
    data.Object = Object
    return data
end

-- // Update Tracer
function ESP.Update:Tracer(data)
    -- // Vars
    local BoxCorners = ESP.Utilites:getBoxCorners(data.Character)

    local To = BoxCorners[3] + Vector2.new((BoxCorners[4].X - BoxCorners[3].X) / 2, 0)

    -- // Object
    local Object = data.Object
    Object.From = data.From
    Object.To = To
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
RunService.RenderStepped:Connect(manageUpdate)