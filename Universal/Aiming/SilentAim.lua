if getgenv().ValiantAimHacks then return getgenv().ValiantAimHacks end

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

-- // Silent Aim Vars
getgenv().ValiantAimHacks = {
    SilentAimEnabled = true,
    ShowFOV = true,
    FOVSides = 12,
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
local ValiantAimHacks = getgenv().ValiantAimHacks

-- // Show FOV
local circle = Drawingnew("Circle")
circle.Transparency = 1
circle.Thickness = 2
circle.Color = Color3fromRGB(231, 84, 128)
circle.Filled = false
function ValiantAimHacks.updateCircle()
    if (circle) then
        -- // Set Circle Properties
        circle.Visible = ValiantAimHacks.ShowFOV
        circle.Radius = (ValiantAimHacks.FOV * 3)
        circle.Position = Vector2new(Mouse.X, Mouse.Y + GetGuiInset(GuiService).Y)
        circle.NumSides = ValiantAimHacks.FOVSides

        -- // Return circle
        return circle
    end
end

-- // Custom Functions
local calcChance = function(percentage)
    percentage = mathfloor(percentage)
    local chance = mathfloor(Randomnew().NextNumber(Randomnew(), 0, 1) * 100) / 100
    return chance <= percentage / 100
end

-- // Customisable Checking Functions: Is a part visible
function ValiantAimHacks.isPartVisible(Part, PartDescendant)
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

-- // Check teams
function ValiantAimHacks.isIgnoredTeam(targetPlayer)
    -- // Vars
    local Ignored = ValiantAimHacks.Ignored
    local IgnoredTeams = Ignored.Teams

    -- // Check if team is ignored
    for i = 1, #IgnoredTeams do
        local v = IgnoredTeams[i]

        if (targetPlayer.Team == v.Team and targetPlayer.TeamColor == v.TeamColor) then
            return true
        end
    end

    -- // Return
    return false
end

-- // Ignore player
function ValiantAimHacks.IgnorePlayer(Player)
    -- // Vars
    local Ignored = ValiantAimHacks.Ignored
    local IgnoredPlayers = Ignored.Players

    -- // Find player in table
    for i = 1, #IgnoredPlayers do
        local IgnoredPlayer = IgnoredPlayers[i]

        if (IgnoredPlayer == Player) then
            return false
        end
    end

    -- // Blacklist player
    IgnoredPlayers[#IgnoredPlayers + 1] = Player
    return true
end

-- // Unignore Player
function ValiantAimHacks.UnIgnorePlayer(Player)
    -- // Vars
    local Ignored = ValiantAimHacks.Ignored
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
function ValiantAimHacks.IgnoreTeam(Team, TeamColor)
    -- // Vars
    local Ignored = ValiantAimHacks.Ignored
    local IgnoredTeams = Ignored.Teams

    -- // Find team in table
    for i = 1, #IgnoredTeams do
        local IgnoredTeam = IgnoredTeams[i]

        if (IgnoredTeam.Team == Team and IgnoredTeam.TeamColor == TeamColor) then
            return false
        end
    end

    -- // Ignore team
    IgnoredTeams[#IgnoredTeams + 1] = {Team, TeamColor}
    return true
end

-- // Unignore team
function ValiantAimHacks.UnIgnoreTeam(Team, TeamColor)
    -- // Vars
    local Ignored = ValiantAimHacks.Ignored
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
function ValiantAimHacks.TeamCheck(Toggle)
    if (Toggle) then
        return ValiantAimHacks.IgnoreTeam(LocalPlayer.Team, LocalPlayer.TeamColor)
    end

    return ValiantAimHacks.UnIgnoreTeam(LocalPlayer.Team, LocalPlayer.TeamColor)
end

-- // Check if player (and team) is ignored
function ValiantAimHacks.isIgnored(Player)
    -- // Vars
    local Ignored = ValiantAimHacks.Ignored
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
    if (ValiantAimHacks.TeamCheck) then
        return not ValiantAimHacks.isIgnoredTeam(Player)
    end

    -- // Return
    return false
end

-- // Get the Direction, Normal and Material
function ValiantAimHacks.findDirectionNormalMaterial(Origin, Destination, UnitMultiplier)
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
function ValiantAimHacks.getCharacter(Player)
    return Player.Character
end

-- // Check Health
function ValiantAimHacks.checkHealth(Player)
    local Character = ValiantAimHacks.getCharacter(Player)
    local Humanoid = FindFirstChildWhichIsA(Character, "Humanoid")

    local Health = (Humanoid and Humanoid.Health or 0)
    return Health > 0
end

-- // Check if silent aim can used
function ValiantAimHacks.checkSilentAim()
    return (ValiantAimHacks.SilentAimEnabled == true and ValiantAimHacks.Selected ~= LocalPlayer and ValiantAimHacks.SelectedPart ~= nil)
end

-- // Get Closest Target Part
function ValiantAimHacks.getClosestTargetPartToCursor(Character)
    local TargetParts = ValiantAimHacks.TargetPart

    -- // Vars
    local ClosestPart = nil
    local ClosestPartPosition = nil
    local ClosestPartOnScreen = false
    local ClosestPartMagnitudeFromMouse = nil
    local ShortestDistance = 1/0

    -- //
    local function checkTargetPart(TargetPartName)
        local TargetPart = FindFirstChild(Character, TargetPartName)

        if (TargetPart) then
            local PartPos, onScreen = WorldToViewportPoint(CurrentCamera, TargetPart.Position)
            local Magnitude = (Vector2new(PartPos.X, PartPos.Y) - Vector2new(Mouse.X, Mouse.Y)).Magnitude

            if (Magnitude < ShortestDistance) then
                ClosestPart = TargetPart
                ClosestPartPosition = PartPos
                ClosestPartOnScreen = onScreen
                ClosestPartMagnitudeFromMouse = Magnitude
                ShortestDistance = Magnitude
            end
        end
    end

    -- // String check
    if (typeof(TargetParts) == "string") then
        checkTargetPart(TargetParts)
    end

    -- // Loop through all target parts
    if (typeof(TargetParts) == "table") then
        for i = 1, #TargetParts do
            local TargetPartName = TargetParts[i]
            checkTargetPart(TargetPartName)
        end
    end

    -- //
    return ClosestPart, ClosestPartPosition, ClosestPartOnScreen, ClosestPartMagnitudeFromMouse
end

-- // Silent Aim Function
function ValiantAimHacks.getClosestPlayerToCursor()
    -- // Vars
    local TargetPart = nil
    local ClosestPlayer = nil
    local Chance = calcChance(ValiantAimHacks.HitChance)
    local ShortestDistance = 1/0

    -- // Chance
    if (not Chance) then
        ValiantAimHacks.Selected = LocalPlayer
        ValiantAimHacks.SelectedPart = nil

        return LocalPlayer
    end

    -- // Loop through all players
    local AllPlayers = GetPlayers(Players)
    for i = 1, #AllPlayers do
        local Player = AllPlayers[i]
        local Character = ValiantAimHacks.getCharacter(Player)

        if (not ValiantAimHacks.isIgnored(Player) and Character) then
            local TargetPartTemp, PartPos, onScreen, Magnitude = ValiantAimHacks.getClosestTargetPartToCursor(Character)

            -- // Check if part exists and health
            if (TargetPartTemp and ValiantAimHacks.checkHealth(Player)) then
                -- // Check if is in FOV
                if (circle.Radius > Magnitude and Magnitude < ShortestDistance) then
                    -- // Check if Visible
                    if (ValiantAimHacks.VisibleCheck and not ValiantAimHacks.isPartVisible(TargetPartTemp, Character)) then continue end

                    -- // Set vars
                    ClosestPlayer = Player
                    ShortestDistance = Magnitude
                    TargetPart = TargetPartTemp
                end
            end
        end
    end

    -- // End
    ValiantAimHacks.Selected = ClosestPlayer
    ValiantAimHacks.SelectedPart = TargetPart
end

-- // Heartbeat Function
Heartbeat:Connect(function()
    ValiantAimHacks.updateCircle()
    ValiantAimHacks.getClosestPlayerToCursor()
end)

return ValiantAimHacks

--[[
Examples:

--// Namecall Version // --
-- // Metatable Variables
local mt = getrawmetatable(game)
local backupindex = mt.__index
setreadonly(mt, false)

-- // Load Silent Aim
local ValiantAimHacks = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Experimental%20Silent%20Aim%20Module.lua"))()

-- // Hook
mt.__namecall = newcclosure(function(...)
    -- // Vars
    local args = {...}
    local method = getnamecallmethod()

    -- // Checks
    if (method == "FireServer") then
        if (args[1].Name == "RemoteNameHere") then
            -- change args

            -- // Return changed arguments
            return backupnamecall(unpack(args))
        end
    end

    -- // Return
    return backupnamecall(...)
end)

-- // Revert Metatable readonly status
setreadonly(mt, true)

-- // Index Version // --
-- // Metatable Variables
local mt = getrawmetatable(game)
local backupindex = mt.__index
setreadonly(mt, false)

-- // Load Silent Aim
local ValiantAimHacks = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Experimental%20Silent%20Aim%20Module.lua"))()

-- // Hook
mt.__index = newcclosure(function(t, k)
    -- // Check if it trying to get our mouse's hit or target
    if (t:IsA("Mouse") and (k == "Hit" or k == "Target")) then
        -- // If we can use the silent aim
        if (ValiantAimHacks.checkSilentAim()) then
            -- // Vars
            local TargetPart = ValiantAimHacks.SelectedPart

            -- // Return modded val
            return (k == "Hit" and TargetPart.CFrame or TargetPart)
        end
    end

    -- // Return
    return backupindex(t, k)
end)

-- // Revert Metatable readonly status
setreadonly(mt, true)
]]
