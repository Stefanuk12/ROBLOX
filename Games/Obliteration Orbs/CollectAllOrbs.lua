-- // Information
--[[
    You can increase the speed, just head to line 137. The 100 is the speed (in studs/second)
]]

-- // Services
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")

-- // Vars
local OrbLocation = Workspace:WaitForChild("OrbFolder")
local Orbs = {}
local LocalPlayer = Players.LocalPlayer
local Team = LocalPlayer.Team.Name
local Wall

-- // Loop through workspace
for _, child in ipairs(Workspace:GetChildren()) do
    -- // Make sure it is the wall
    if (child:IsA("Part") and child.Name == "Grass3") then
        -- // Set and break
        Wall = child
        break
    end
end

-- //
local function IsValidOrb(Orb)
    -- // Make sure is a part
    if (not Orb:IsA("BasePart")) then
        return false
    end

    -- // Checks
    if (not Orb.Name:find("Orb")) then
        return false
    end

    -- // Team Check
    local OrbPosition = Orb.Position
    local WallPosition = Wall.Position
    if (Team == "TeamLeft" and OrbPosition.Z < WallPosition.Z) or (Team == "TeamRight" and OrbPosition.Z > WallPosition.Z) then
        return false
    end

    -- // Return
    return true
end

-- // Loop through workspace
for _, child in ipairs(OrbLocation:GetChildren()) do
    -- // Make sure is a valid orb
    if (IsValidOrb(child)) then
        -- // Add to orbs
        table.insert(Orbs, child)
    end
end

-- // See whenever there is a new orb
OrbLocation.ChildAdded:Connect(function(child)
    -- // Make sure it is valid
    if (IsValidOrb(child)) then
        -- // Add to orbs
        table.insert(Orbs, child)
    end
end)

-- // See whenever an orb is removed
OrbLocation.ChildRemoved:Connect(function(child)
    -- // Make sure is in table
    local i = table.find(Orbs, child)
    if (i) then
        -- // Remove
        table.remove(Orbs, i)
    end
end)

-- // Get Closest Orb
local function GetClosestOrb()
    -- // Vars
    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local HumanoidRootPart = Character.HumanoidRootPart
    local Position = HumanoidRootPart.Position

    -- //
    local ClosestOrb
    local ShortestDistance = 1/0

    -- // Loop through all of the orbs
    for _, Orb in ipairs(Orbs) do
        -- // Look at the distance between us and the orb
        local Magnitude = (Orb.Position - Position).Magnitude

        -- // See if it's shortest than the current record
        if (Magnitude < ShortestDistance) then
            -- // Set
            ClosestOrb = Orb
            ShortestDistance = Magnitude
        end
    end

    -- // Return the orb
    return ClosestOrb
end

-- // Teleport function
local function Teleport(Speed, Position)
    -- // Vars
    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local HumanoidRootPart = Character.HumanoidRootPart

    local Distance = (Position - HumanoidRootPart.Position).Magnitude
    local Time = Distance / Speed

    local tweenInfo = TweenInfo.new(Time, Enum.EasingStyle.Linear, Enum.EasingDirection.In)
    local Tween = TweenService:Create(HumanoidRootPart, tweenInfo, {
        CFrame = CFrame.new(Position)
    })

    -- // Play
    Tween:Play()
    return Tween.Completed:Wait()
end

-- // Teleport to an orb
local function CollectOrb()
    -- // Vars
    local Orb = GetClosestOrb()

    -- // Make sure we have an orb
    if (not Orb) then
        return false
    end

    -- // Teleport
    Teleport(16, Orb.Position)

    -- // Wait until orb is gone
    repeat
        task.wait()
    until Orb.Parent == nil

    -- // Return true
    return true
end

-- //
while true do wait(0.1)
    CollectOrb()
end