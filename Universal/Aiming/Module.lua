if getgenv().Aiming then return getgenv().Aiming end

-- // Services
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")

-- // Vars
local Heartbeat = RunService.Heartbeat
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = Workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

-- // Optimisation Vars (ugly)
local Drawingnew = Drawing.new
local Color3fromRGB = Color3.fromRGB
local Vector2new = Vector2.new
local GetGuiInset = GuiService.GetGuiInset
local Randomnew = Random.new
local mathfloor = math.floor
local CharacterAdded = LocalPlayer.CharacterAdded
local CharacterAddedWait = CharacterAdded.Wait
local WorldToViewportPoint = CurrentCamera.WorldToViewportPoint
local RaycastParamsnew = RaycastParams.new
local EnumRaycastFilterTypeBlacklist = Enum.RaycastFilterType.Blacklist
local Raycast = Workspace.Raycast
local GetPlayers = Players.GetPlayers
local Instancenew = Instance.new
local IsDescendantOf = Instancenew("Part").IsDescendantOf
local FindFirstChildWhichIsA = Instancenew("Part").FindFirstChildWhichIsA
local FindFirstChild = Instancenew("Part").FindFirstChild
local tableremove = table.remove
local tableinsert = table.insert

-- // Silent Aim Vars
getgenv().Aiming = {
    Enabled = true,
    ShowFOV = true,
    FOVSides = 12,
    FOVColour = Color3fromRGB(231, 84, 128),
    VisibleCheck = true,
    FOV = 60,
    HitChance = 100,
    Selected = LocalPlayer,
    SelectedPart = nil,
    TargetPart = {"Head", "HumanoidRootPart"},
    Ignored = {
        Teams = {
            {
                Team = LocalPlayer.Team,
                TeamColor = LocalPlayer.TeamColor,
            },
        },
        Players = {
            LocalPlayer,
            91318356
        }
    }
}
local Aiming = getgenv().Aiming

-- // Show FOV
local circle = Drawingnew("Circle")
circle.Transparency = 1
circle.Thickness = 2
circle.Color = Aiming.FOVColour
circle.Filled = false
function Aiming.UpdateFOV()
    if (circle) then
        -- // Set Circle Properties
        circle.Visible = Aiming.ShowFOV
        circle.Radius = (Aiming.FOV * 3)
        circle.Position = Vector2new(Mouse.X, Mouse.Y + GetGuiInset(GuiService).Y)
        circle.NumSides = Aiming.FOVSides
        circle.Color = Aiming.FOVColour

        -- // Return circle
        return circle
    end
end

-- // Custom Functions
local CalcChance = function(percentage)
    percentage = mathfloor(percentage)
    local chance = mathfloor(Randomnew().NextNumber(Randomnew(), 0, 1) * 100) / 100
    return chance <= percentage / 100
end

-- // Customisable Checking Functions: Is a part visible
function Aiming.IsPartVisible(Part, PartDescendant)
    -- // Vars
    local Character = LocalPlayer.Character or CharacterAddedWait(CharacterAdded)
    local Origin = CurrentCamera.CFrame.Position
    local _, OnScreen = WorldToViewportPoint(CurrentCamera, Part.Position)

    -- // If Part is on the screen
    if (OnScreen) then
        -- // Vars: Calculating if is visible
        local raycastParams = RaycastParamsnew()
        raycastParams.FilterType = EnumRaycastFilterTypeBlacklist
        raycastParams.FilterDescendantsInstances = {Character, CurrentCamera}

        local Result = Raycast(Workspace, Origin, Part.Position - Origin, raycastParams)
        if (Result) then
            local PartHit = Result.Instance
            local Visible = (not PartHit or IsDescendantOf(PartHit, PartDescendant))

            -- // Return
            return Visible
        end
    end

    -- // Return
    return false
end

-- // Ignore player
function Aiming.IgnorePlayer(Player)
    -- // Vars
    local Ignored = Aiming.Ignored
    local IgnoredPlayers = Ignored.Players

    -- // Find player in table
    for i = 1, #IgnoredPlayers do
        local IgnoredPlayer = IgnoredPlayers[i]

        if (IgnoredPlayer == Player) then
            return false
        end
    end

    -- // Blacklist player
    tableinsert(IgnoredPlayers, Player)
    return true
end

-- // Unignore Player
function Aiming.UnIgnorePlayer(Player)
    -- // Vars
    local Ignored = Aiming.Ignored
    local IgnoredPlayers = Ignored.Players

    -- // Find player in table
    for i = 1, #IgnoredPlayers do
        local IgnoredPlayer = IgnoredPlayers[i]

        if (IgnoredPlayer == Player) then
            tableremove(IgnoredPlayers, i)
            return true
        end
    end

    -- //
    return false
end

-- // Ignore team
function Aiming.IgnoreTeam(Team, TeamColor)
    -- // Vars
    local Ignored = Aiming.Ignored
    local IgnoredTeams = Ignored.Teams

    -- // Find team in table
    for i = 1, #IgnoredTeams do
        local IgnoredTeam = IgnoredTeams[i]

        if (IgnoredTeam.Team == Team and IgnoredTeam.TeamColor == TeamColor) then
            return false
        end
    end

    -- // Ignore team
    tableinsert(IgnoredTeams, {Team, TeamColor})
    return true
end

-- // Unignore team
function Aiming.UnIgnoreTeam(Team, TeamColor)
    -- // Vars
    local Ignored = Aiming.Ignored
    local IgnoredTeams = Ignored.Teams

    -- // Find team in table
    for i = 1, #IgnoredTeams do
        local IgnoredTeam = IgnoredTeams[i]

        if (IgnoredTeam.Team == Team and IgnoredTeam.TeamColor == TeamColor) then
            -- // Remove
            tableremove(IgnoredTeams, i)
            return true
        end
    end

    -- // Return
    return false
end

-- //  Toggle team check
function Aiming.TeamCheck(Toggle)
    if (Toggle) then
        return Aiming.IgnoreTeam(LocalPlayer.Team, LocalPlayer.TeamColor)
    end

    return Aiming.UnIgnoreTeam(LocalPlayer.Team, LocalPlayer.TeamColor)
end

-- // Check teams
function Aiming.IsIgnoredTeam(Player)
    -- // Vars
    local Ignored = Aiming.Ignored
    local IgnoredTeams = Ignored.Teams

    -- // Check if team is ignored
    for i = 1, #IgnoredTeams do
        local IgnoredTeam = IgnoredTeams[i]

        if (Player.Team == IgnoredTeam.Team and Player.TeamColor == IgnoredTeam.TeamColor) then
            return true
        end
    end

    -- // Return
    return false
end

-- // Check if player (and team) is ignored
function Aiming.IsIgnored(Player)
    -- // Vars
    local Ignored = Aiming.Ignored
    local IgnoredPlayers = Ignored.Players

    -- // Loop
    for i = 1, #IgnoredPlayers do
        local IgnoredPlayer = IgnoredPlayers[i]

        -- // Check if Player Id
        if (typeof(IgnoredPlayer) == "number") then
            if (Player.UserId == IgnoredPlayer) then
                return true
            end
        end

        -- // Normal Player Instance
        if (IgnoredPlayer == Player) then
            return true
        end
    end

    -- // Team check
    return Aiming.IsIgnoredTeam(Player)
end

-- // Get the Direction, Normal and Material
function Aiming.Raycast(Origin, Destination, UnitMultiplier)
    if (typeof(Origin) == "Vector3" and typeof(Destination) == "Vector3") then
        -- // Handling
        if (not UnitMultiplier) then UnitMultiplier = 1 end

        -- // Vars
        local Direction = (Destination - Origin).Unit * UnitMultiplier
        local RaycastResult = Raycast(Workspace, Origin, Direction)

        if (RaycastResult ~= nil) then
            local Normal = RaycastResult.Normal
            local Material = RaycastResult.Material

            return Direction, Normal, Material
        end
    end

    -- // Return
    return nil
end

-- // Get Character
function Aiming.Character(Player)
    return Player.Character
end

-- // Check Health
function Aiming.CheckHealth(Player)
    local Character = Aiming.Character(Player)
    local Humanoid = FindFirstChildWhichIsA(Character, "Humanoid")

    local Health = (Humanoid and Humanoid.Health or 0)
    return Health > 0
end

-- // Check if silent aim can used
function Aiming.Check()
    return (Aiming.Enabled == true and Aiming.Selected ~= LocalPlayer and Aiming.SelectedPart ~= nil)
end
Aiming.checkSilentAim = Aiming.Check

-- // Get Closest Target Part
function Aiming.GetClosestTargetPartToCursor(Character)
    local TargetParts = Aiming.TargetPart

    -- // Vars
    local ClosestPart = nil
    local ClosestPartPosition = nil
    local ClosestPartOnScreen = false
    local ClosestPartMagnitudeFromMouse = nil
    local ShortestDistance = 1/0

    -- //
    local function CheckTargetPart(TargetPart)
        TargetPart = TargetPart or FindFirstChild(Character, TargetPart)

        if (not TargetPart) then
            return
        end

        local PartPos, onScreen = WorldToViewportPoint(CurrentCamera, TargetPart.Position)
        local GuiInset = GetGuiInset(GuiService)
        local Magnitude = (Vector2new(PartPos.X, PartPos.Y) - Vector2new(Mouse.X, Mouse.Y - GuiInset.Y)).Magnitude

        if (Magnitude < ShortestDistance) then
            ClosestPart = TargetPart
            ClosestPartPosition = PartPos
            ClosestPartOnScreen = onScreen
            ClosestPartMagnitudeFromMouse = Magnitude
            ShortestDistance = Magnitude
        end
    end

    -- // String check
    if (typeof(TargetParts) == "string") then
        -- // Check if it all
        if (TargetParts == "All") then
            -- // Loop through character children
            for _, v in ipairs(Character:GetChildren()) do
                -- // See if it a part
                if not (v:IsA("BasePart")) then
                    continue
                end

                -- // Check it
                CheckTargetPart(v)
            end
        else
            -- // Individual
            CheckTargetPart(TargetParts)
        end
    end

    -- // Loop through all target parts
    if (typeof(TargetParts) == "table") then
        for i = 1, #TargetParts do
            local TargetPartName = TargetParts[i]
            CheckTargetPart(TargetPartName)
        end
    end

    -- //
    return ClosestPart, ClosestPartPosition, ClosestPartOnScreen, ClosestPartMagnitudeFromMouse
end

-- // Silent Aim Function
function Aiming.GetClosestPlayerToCursor()
    -- // Vars
    local TargetPart = nil
    local ClosestPlayer = nil
    local Chance = CalcChance(Aiming.HitChance)
    local ShortestDistance = 1/0

    -- // Chance
    if (not Chance) then
        Aiming.Selected = LocalPlayer
        Aiming.SelectedPart = nil

        return LocalPlayer
    end

    -- // Loop through all players
    local AllPlayers = GetPlayers(Players)
    for i = 1, #AllPlayers do
        local Player = AllPlayers[i]
        local Character = Aiming.Character(Player)

        if (Aiming.IsIgnored(Player) == false and Character) then
            local TargetPartTemp, _, _, Magnitude = Aiming.GetClosestTargetPartToCursor(Character)

            -- // Check if part exists and health
            if (TargetPartTemp and Aiming.CheckHealth(Player)) then
                -- // Check if is in FOV
                if (circle.Radius > Magnitude and Magnitude < ShortestDistance) then
                    -- // Check if Visible
                    if (Aiming.VisibleCheck and not Aiming.IsPartVisible(TargetPartTemp, Character)) then continue end

                    -- // Set vars
                    ClosestPlayer = Player
                    ShortestDistance = Magnitude
                    TargetPart = TargetPartTemp
                end
            end
        end
    end

    -- // End
    Aiming.Selected = ClosestPlayer
    Aiming.SelectedPart = TargetPart
end

-- // Heartbeat Function
Heartbeat:Connect(function()
    Aiming.UpdateFOV()
    Aiming.GetClosestPlayerToCursor()
end)

return Aiming

-- // Examples // --

--// Namecall Version // --

--[[
-- // Load Aiming Module
local Aiming = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Aiming/Module.lua"))()

-- // Hook
local __namecall
__namecall = hookmetamethod(game, "__namecall", function(...)
    -- // Vars
    local args = {...}
    local self = args[1]
    local method = getnamecallmethod()

    -- // Checks
    if (method == "FireServer") then
        if (self.Name == "RemoteNameHere") then
            -- change args

            -- // Return changed arguments
            return __namecall(unpack(args))
        end
    end

    -- // Return
    return __namecall(...)
end)
]]--

-- // Index Version // --

--[[
-- // Load Aiming Module
local Aiming = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Aiming/Module.lua"))()

-- // Hook
local __index
__index = hookmetamethod(game, "__index", function(t, k)
    -- // Check if it trying to get our mouse's hit or target
    if (t:IsA("Mouse") and (k == "Hit" or k == "Target")) then
        -- // If we can use the silent aim
        if (Aiming.Check()) then
            -- // Vars
            local TargetPart = Aiming.SelectedPart

            -- // Return modded val
            return (k == "Hit" and TargetPart.CFrame or TargetPart)
        end
    end

    -- // Return
    return __index(t, k)
end)
]]--