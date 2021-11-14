if (getgenv().AimingNPC) then
    return getgenv().AimingNPC
end

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
local Instancenew = Instance.new
local IsDescendantOf = Instancenew("Part").IsDescendantOf
local FindFirstChildWhichIsA = Instancenew("Part").FindFirstChildWhichIsA
local FindFirstChild = Instancenew("Part").FindFirstChild

-- // Silent Aim Vars
local AimingNPC = {
    Enabled = true,

    ShowFOV = true,
    FOV = 60,
    FOVSides = 12,
    FOVColour = Color3fromRGB(231, 84, 128),

    VisibleCheck = true,

    HitChance = 100,

    Selected = nil,
    SelectedPart = nil,

    TargetPart = {"Head", "HumanoidRootPart"},

    RaycastIgnore = nil
}
getgenv().AimingNPC = AimingNPC

-- // Create circle
local circle = Drawingnew("Circle")
circle.Transparency = 1
circle.Thickness = 2
circle.Color = AimingNPC.FOVColour
circle.Filled = false
AimingNPC.FOVCircle = circle

-- // Update
function AimingNPC.UpdateFOV()
    -- // Make sure the circle exists
    if not (circle) then
        return
    end

    -- // Set Circle Properties
    circle.Visible = AimingNPC.ShowFOV
    circle.Radius = (AimingNPC.FOV * 3)
    circle.Position = Vector2new(Mouse.X, Mouse.Y + GetGuiInset(GuiService).Y)
    circle.NumSides = AimingNPC.FOVSides
    circle.Color = AimingNPC.FOVColour

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
function AimingNPC.IsPartVisible(Part, PartDescendant)
    -- // Vars
    local Character = LocalPlayer.Character or CharacterAddedWait(CharacterAdded)
    local Origin = CurrentCamera.CFrame.Position
    local _, OnScreen = WorldToViewportPoint(CurrentCamera, Part.Position)

    -- //
    if (OnScreen) then
        -- // Vars
        local raycastParams = RaycastParamsnew()
        raycastParams.FilterType = EnumRaycastFilterTypeBlacklist

        -- // Raycast Ignore
        raycastParams.FilterDescendantsInstances = AimingNPC.RaycastIgnore or {Character, CurrentCamera}

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

-- // Get the Direction, Normal and Material
function AimingNPC.Raycast(Origin, Destination, UnitMultiplier)
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

-- // Check Health
function AimingNPC.CheckHealth(NPC)
    -- // Get Humanoid
    local Humanoid = FindFirstChildWhichIsA(NPC, "Humanoid")

    -- // Get Health
    local Health = (Humanoid and Humanoid.Health or 0)

    -- //
    return Health > 0
end

-- // Check if has target and is enabled
function AimingNPC.Check()
    return (AimingNPC.Enabled == true and AimingNPC.Selected and AimingNPC.SelectedPart)
end

-- // Get Closest Target Part
function AimingNPC.GetClosestTargetPartToCursor(NPC)
    local TargetParts = AimingNPC.TargetPart

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
            TargetPart = FindFirstChild(NPC, TargetPart)
        end

        -- // Make sure we have a target
        if not (TargetPart) then
            return
        end

        -- // Get the length between Mouse and Target Part (on screen)
        local PartPos, onScreen = WorldToViewportPoint(CurrentCamera, TargetPart.Position)
        local GuiInset = GetGuiInset(GuiService)
        local Magnitude = (Vector2new(PartPos.X, PartPos.Y - GuiInset.Y) - Vector2new(Mouse.X, Mouse.Y)).Magnitude

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
            -- // Loop through NPC children
            for _, v in ipairs(NPC:GetChildren()) do
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

-- // Returns all of the NPCs to target
function AimingNPC.GetNPCs()
    return {} --Workspace.NPCs:GetChildren()
end

-- //
function AimingNPC.GetClosestNPCToCursor()
    -- // Vars
    local TargetPart = nil
    local ClosestNPC = nil
    local Chance = CalcChance(AimingNPC.HitChance)
    local ShortestDistance = 1/0

    -- // Chance
    if (not Chance) then
        AimingNPC.Selected = nil
        AimingNPC.SelectedPart = nil

        return nil
    end

    -- // Loop through all NPCs
    for _, NPC in ipairs(AimingNPC.GetNPCs()) do
        -- // Vars
        local TargetPartTemp, _, _, Magnitude = AimingNPC.GetClosestTargetPartToCursor(NPC)

        -- // Check if part exists and health
        if (TargetPartTemp and AimingNPC.CheckHealth(NPC)) then
            -- // Check if is in FOV
            if (circle.Radius > Magnitude and Magnitude < ShortestDistance) then
                -- // Check if Visible
                if (AimingNPC.VisibleCheck and not AimingNPC.IsPartVisible(TargetPartTemp, NPC)) then continue end

                -- // Set vars
                ClosestNPC = NPC
                ShortestDistance = Magnitude
                TargetPart = TargetPartTemp
            end
        end
    end

    -- // End
    AimingNPC.Selected = ClosestNPC
    AimingNPC.SelectedPart = TargetPart
end

-- // Heartbeat Function
Heartbeat:Connect(function()
    AimingNPC.UpdateFOV()
    AimingNPC.GetClosestNPCToCursor()
end)

-- //
return AimingNPC