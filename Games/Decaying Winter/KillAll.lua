-- // Configuration


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

-- // Kills a target
local function KillTarget(Target, Part)
    -- // Vars
    local Data = {
        "meleedamage",
        Target,
        100,
        false,
        "Fist",
        false,
        false,
        {},
        Part
    }

    -- //
    dealDamage:FireServer(Data, nil, RemoteKey)
end

-- // Kills every target
local function KillTargets()
    -- // Loop through NoTarget
    for _, child in ipairs(NoTarget:GetChildren()) do
        -- // Make sure is a target
        if (child.Name:find("AI")) then
            KillTarget(child, child.Torso)
        end
    end

    -- // Loop through activeHostiles
    for _, child in ipairs(activeHostiles:GetChildren()) do
        -- // Make sure is a target
        if (child.Name:find("AI")) then
            KillTarget(child, child.Torso)
        end
    end
end

-- // Constantly kill all
while (true) do wait()
    KillTargets()
end