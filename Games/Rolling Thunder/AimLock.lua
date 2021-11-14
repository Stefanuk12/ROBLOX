-- // Dependencies
local AimingNPC = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Aiming/NPC.lua"))()

-- // Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- // Vars
local LocalPlayer = Players.LocalPlayer
local Network = debug.getupvalue(require(ReplicatedStorage.Network), 2)

AimingNPC.RaycastIgnore = {LocalPlayer.Character, CurrentCamera}
AimingNPC.FOV = 150

local ThunderSettings = {
    AimLock = true,
    AimLockKeybind = Enum.KeyCode.W
}
getgenv().ThunderSettings = ThunderSettings

-- // Parse ignored stuff
for _, child in ipairs(Workspace.Walls:GetChildren()) do
    -- // Make sure can't collide
    if (child:IsA("BasePart") and not child.CanCollide) then
        -- // Add to ignored
        table.insert(AimingNPC.RaycastIgnore, child)
    end
end

-- // Check if an object is an NPC
function AimingNPC.IsNPC(Object)
    return Object:FindFirstChild("Humanoid") and not Players:FindFirstChild(Object.Name)
end

-- // Override
function AimingNPC.GetNPCs()
    -- // Vars
    local NPCs = {}

    -- // Loop through Workspace children
    for _, child in ipairs(Workspace:GetChildren()) do
        -- // Make sure is an NPC
        if (AimingNPC.IsNPC(child)) then
            -- // Add it
            local NPC = child
            table.insert(NPCs, NPC)
        end
    end

    -- // Return
    return NPCs
end

-- // Constant Loop
RunService:BindToRenderStep("AimLock", 0, function()
    -- // Make sure aimlock is enabled and we have a target
    if (ThunderSettings.AimLock and AimingNPC.Check() and UserInputService:IsKeyDown(ThunderSettings.AimLockKeybind)) then
        -- // Vars
        local CurrentCamera = Workspace.CurrentCamera
        local SelectedPart = AimingNPC.SelectedPart

        -- // Set the camera to face towards the Hit
        CurrentCamera.CFrame = CFrame.lookAt(CurrentCamera.CFrame.Position, SelectedPart.Position)
    end
end)