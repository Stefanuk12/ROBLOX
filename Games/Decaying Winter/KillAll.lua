-- // Services
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

-- // Vars
local LocalPlayer = Players.LocalPlayer
local Backpack = LocalPlayer.Backpack
local mainHandler = Backpack:WaitForChild("mainHandler")

local ServerStuff = Workspace.ServerStuff
local dealDamage = ServerStuff.dealDamage

local NoTarget = Workspace.NoTarget
local activeHostiles = Workspace.activeHostiles

-- // Get the remote key
local RemoteKey = ""
do
    -- // Vars
    local stagger = getsenv(mainHandler).stagger

    -- //
    RemoteKey = debug.getupvalue(stagger, 6)
end

-- // Make sure got remote key
if (not RemoteKey or RemoteKey == "") then
    print("Could not get remote key")
end

-- // Kills a target
local function KillTarget(Target, Part)
    -- // Vars
    local Humanoid = Target:WaitForChild("Humanoid")
    local Data = {
        "meleedamage",
        Target,
        12,
        false,
        "Fist",
        false,
        false,
        {},
        Part
    }

    -- //
    while (Humanoid.Health > 1) do wait()
        dealDamage:FireServer(Data, nil, RemoteKey)
    end
end

local function Kill(Target)
    -- // Make sure is a target
    if (Target.Name:find("AI")) then
        KillTarget(Target, Target:WaitForChild("Torso"))
        print("Killed: " .. Target.Name)
    end
end

-- // Kills every target
local function KillTargets()
    -- // table.foreachi doesn't want to work for some reason - thread issues, cannot yield.

    -- // Kill all targets in NoTarget folder
    for _, Target in ipairs(NoTarget:GetChildren()) do
        Kill(Target)
    end

    -- // Kill all targets in activeHostiles folder
    for _, Target in ipairs(activeHostiles:GetChildren()) do
        Kill(Target)
    end
end

-- // Kill all current hostiles
KillTargets()

-- // Kill all fugure hostiles
NoTarget.ChildAdded:Connect(Kill)
activeHostiles.ChildAdded:Connect(Kill)