if getgenv().Aiming then return getgenv().Aiming end

-- // Dependencies
local SignalManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/Signal/main/Manager.lua"))()
local BeizerManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Aiming/BeizerManager.lua"))()

-- // Services
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- // Vars
local Heartbeat = RunService.Heartbeat
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = Workspace.CurrentCamera

-- // Optimisation Vars (ugly)
local Drawingnew = Drawing.new
local Color3fromRGB = Color3.fromRGB
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
local RenderStepped = RunService.RenderStepped
local GetMouseLocation = UserInputService.GetMouseLocation

-- // Silent Aim Vars
local Aiming = {
    Enabled = true,

    ShowFOV = true,
    FOV = 60,
    FOVSides = 12,
    FOVColour = Color3fromRGB(231, 84, 128),

    VisibleCheck = true,
    ShowCredits = true,

    HitChance = 100,

    Selected = nil,
    SelectedPart = nil,
    SelectedPosition = nil,
    SelectedPositionOnScreen = nil,

    TargetPart = {"Head", "HumanoidRootPart"},

    Ignored = {
        Teams = {
            {
                Team = LocalPlayer.Team,
                TeamColor = LocalPlayer.TeamColor,
            },
        },
        IgnoreOtherTeams = true,
        Players = {
            LocalPlayer,
            91318356
        }
    },

    RaycastIgnore = nil,
    Signals = SignalManager.new()
}
getgenv().Aiming = Aiming

-- // Create signals
do
    local SignalNames = {"TargetPlayerChanged", "TargetPartChanged", "TargetPartPositionChanged", "TargetPartPositionOnScreenChanged"}

    for _, SignalName in ipairs(SignalNames) do
        Aiming.Signals:Create(SignalName)
    end
end

-- // Create circle
local circle = Drawingnew("Circle")
circle.Transparency = 1
circle.Thickness = 2
circle.Color = Aiming.FOVColour
circle.Filled = false
Aiming.FOVCircle = circle

-- // Update
function Aiming.UpdateFOV()
    -- // Make sure the circle exists
    if not (circle) then
        return
    end

    -- // Vars
    local MousePosition = GetMouseLocation(UserInputService)

    -- // Set Circle Properties
    circle.Visible = Aiming.ShowFOV
    circle.Radius = (Aiming.FOV * 3)
    circle.Position = MousePosition
    circle.NumSides = Aiming.FOVSides
    circle.Color = Aiming.FOVColour

    -- // Return circle
    return circle
end

-- // Custom Functions
local CalcChance = function(percentage)
    -- // Floor the percentage
    percentage = mathfloor(percentage)

    -- // Get the chance
    local chance = mathfloor(Randomnew().NextNumber(Randomnew(), 0, 1) * 100) / 100

    -- // Return
    return chance <= percentage / 100
end

-- // Customisable Checking Functions: Is a part visible
function Aiming.IsPartVisible(Part, PartDescendant)
    -- // Vars
    local Character = LocalPlayer.Character or CharacterAddedWait(CharacterAdded)
    local Origin = CurrentCamera.CFrame.Position
    local _, OnScreen = WorldToViewportPoint(CurrentCamera, Part.Position)

    -- //
    if (OnScreen) then
        -- // Vars
        local raycastParams = RaycastParamsnew()
        raycastParams.FilterType = EnumRaycastFilterTypeBlacklist
        raycastParams.FilterDescendantsInstances = (typeof(Aiming.RaycastIgnore) == "function" and Aiming.RaycastIgnore() or Aiming.RaycastIgnore) or {Character, CurrentCamera}

        -- // Cast ray
        local Result = Raycast(Workspace, Origin, Part.Position - Origin, raycastParams)

        -- // Make sure we get a result
        if (Result) then
            -- // Vars
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
    for _, IgnoredPlayer in ipairs(IgnoredPlayers) do
        -- // Make sure player matches
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
    for i, IgnoredPlayer in ipairs(IgnoredPlayers) do
        -- // Make sure player matches
        if (IgnoredPlayer == Player) then
            -- // Remove from ignored
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
    for _, IgnoredTeam in ipairs(IgnoredTeams) do
        -- // Make sure team matches
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
    for i, IgnoredTeam in ipairs(IgnoredTeams) do
        -- // Make sure team matches
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

    -- // Check for others
    if (Ignored.IgnoreOtherTeams) then
        return (LocalPlayer.Team == Player.Team and LocalPlayer.TeamColor == Player.TeamColor)
    end

    -- // Check if team is ignored
    for _, IgnoredTeam in ipairs(IgnoredTeams) do
        -- // Make sure team matches
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
    for _, IgnoredPlayer in ipairs(IgnoredPlayers) do
        -- // Check if Player Id
        if (typeof(IgnoredPlayer) == "number" and Player.UserId == IgnoredPlayer) then
            return true
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
        local Result = Raycast(Workspace, Origin, Direction)

        -- // Make sure we have a result
        if (Result) then
            local Normal = Result.Normal
            local Material = Result.Material

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
    -- // Get Humanoid
    local Character = Aiming.Character(Player)
    local Humanoid = FindFirstChildWhichIsA(Character, "Humanoid")

    -- // Get Health
    local Health = (Humanoid and Humanoid.Health or 0)

    -- //
    return Health > 0
end

-- // Custom Check Function
function Aiming.CheckCustom(Player)
    return true
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
        -- // Convert string -> Instance
        if (typeof(TargetPart) == "string") then
            TargetPart = FindFirstChild(Character, TargetPart)
        end

        -- // Make sure we have a target
        if not (TargetPart) then
            return
        end

        -- // Get the length between Mouse and Target Part (on screen)
        local PartPos, onScreen = WorldToViewportPoint(CurrentCamera, TargetPart.Position)
        PartPos = Vector2.new(PartPos.X, PartPos.Y)

        local MousePosition = GetMouseLocation(UserInputService)
        local GuiInset = GetGuiInset(GuiService)
        local AccountedPos = PartPos - GuiInset

        local Magnitude = (AccountedPos - MousePosition).Magnitude

        -- //
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

    -- //
    if (typeof(TargetParts) == "table") then
        -- // Loop through all target parts and check them
        for _, TargetPartName in ipairs(TargetParts) do
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
    local PartPosition = nil
    local PartPositionOnScreen = nil
    local Chance = CalcChance(Aiming.HitChance)
    local ShortestDistance = 1/0

    -- // Chance
    if (not Chance) then
        Aiming.Selected = LocalPlayer
        Aiming.SelectedPart = nil
        Aiming.SelectedPosition = nil
        Aiming.SelectedPositionOnScreen = nil

        return LocalPlayer
    end

    -- // Loop through all players
    for _, Player in ipairs(GetPlayers(Players)) do
        -- // Get Character
        local Character = Aiming.Character(Player)

        -- // Make sure isn't ignored and Character exists
        if (Aiming.IsIgnored(Player) == false and Character) then
            -- // Vars
            local TargetPartTemp, PartPositionTemp, PartPositionOnScreenTemp, Magnitude = Aiming.GetClosestTargetPartToCursor(Character)

            -- // Check if part exists, health and custom
            if (TargetPartTemp and Aiming.CheckHealth(Player) and Aiming.CheckCustom(Player)) then
                -- // Check if is in FOV
                if (circle.Radius > Magnitude and Magnitude < ShortestDistance) then
                    -- // Check if Visible
                    if (Aiming.VisibleCheck and not Aiming.IsPartVisible(TargetPartTemp, Character)) then continue end

                    -- // Set vars
                    ClosestPlayer = Player
                    ShortestDistance = Magnitude
                    TargetPart = TargetPartTemp
                    PartPosition = PartPositionTemp
                    PartPositionOnScreen = PartPositionOnScreenTemp
                end
            end
        end
    end

    -- // Firing changed signals
    if (Aiming.Selected ~= ClosestPlayer) then
        Aiming.Signals:Fire("TargetPlayerChanged", ClosestPlayer)
    end
    if (Aiming.SelectedPart ~= TargetPart) then
        Aiming.Signals:Fire("TargetPartChanged", TargetPart)
    end
    if (Aiming.SelectedPosition ~= PartPosition) then
        Aiming.Signals:Fire("TargetPartPositionChanged", PartPosition)
    end
    if (Aiming.SelectedPositionOnScreen ~= PartPositionOnScreen) then
        Aiming.Signals:Fire("TargetPartPositionOnScreenChanged", PartPositionOnScreen)
    end

    -- // End
    Aiming.Selected = ClosestPlayer
    Aiming.SelectedPart = TargetPart
    Aiming.SelectedPosition = PartPosition
    Aiming.SelectedPositionOnScreen = PartPositionOnScreen
end

-- //
function Aiming.SetCameraCFrame(CFr)
    CurrentCamera.CFrame = CFr
end

-- //
function Aiming.CameraLookAt(Position)
    local LookAt = CFrame.lookAt(CurrentCamera.CFrame.Position, Position)
    Aiming.SetCameraCFrame(LookAt)
end

-- // Beizer Aim Curves
Aiming.BeizerCurve = {}
do
    -- // Information
    --[[
        A deals with mouse movements
        B deals with custom movements, e.g. camera
    ]]

    -- // Vars
    local ManagerA = BeizerManager.new()
    local ManagerB = BeizerManager.new()

    -- // Functions
    Aiming.BeizerCurve.ManagerA = ManagerA
    Aiming.BeizerCurve.ManagerB = ManagerB

    Aiming.BeizerCurve.AimTo = function(...)
        ManagerA:ChangeData(...)
    end
    Aiming.BeizerCurve.AimToB = function(...)
        ManagerB:ChangeData(...)
    end

    -- // Convert B to Camera Mode
    ManagerB:CameraMode()

    -- // Convert function to use Aiming
    ManagerB.Function = function(Pitch, Yaw)
        local RotationMatrix = CFrame.fromEulerAnglesYXZ(Pitch, Yaw, 0)
        Aiming.SetCameraCFrame(CFrame.new(CurrentCamera.CFrame.Position) * RotationMatrix)
    end

    -- // Start
    ManagerA:Start()
    ManagerB:Start()
end

-- // Heartbeat Function
Heartbeat:Connect(function()
    Aiming.UpdateFOV()
    Aiming.GetClosestPlayerToCursor()
end)

-- // Credits (by disabling this and not including your own way of crediting within the script, e.g. credits tab, is violating the license agreement. Beware!)
task.delay(1, function()
    if (Aiming.ShowCredits) then
        messagebox("Thanks to Stefanuk12 for their Aiming Module (v1).\n\nNote: This module is outdated, please see github.com/Stefanuk12/Aiming for the updated version!", "Credits", 0)
    end
end)

-- //
return Aiming

-- // If you want the examples, look at the docs.