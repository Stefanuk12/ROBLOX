-- // Dependencies
local AimingNPC = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Aiming/NPC.lua"))()

-- // Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

-- // Vars
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = Workspace.CurrentCamera
local Network = debug.getupvalue(require(ReplicatedStorage.Network), 2)

AimingNPC.RaycastIgnore = {LocalPlayer.Character, CurrentCamera}
AimingNPC.FOV = 150

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

-- // Hook
local __index
__index = hookmetamethod(game, "__index", function(t, k)
    -- // Vars
    local callingscript = getcallingscript()

    -- // Make sure it's the correct script trying to get Camera.CFrame and that silent aim is available
    if (t == CurrentCamera and k == "CFrame" and AimingNPC.Check()) then
        -- // Modify it so we are looking at target
        local Original = __index(t, k)
        local Modified = CFrame.lookAt(Original.Position, AimingNPC.SelectedPart.Position)

        -- // Return it
        return Modified
    end

    -- // Return
    return __index(t, k)
end)