-- // Information
--[[
    This may get you banned on later rounds as the game checks if you spam remotes. BEWARE

    THIS MAY GET YOU ALSO BANNED IF YOU DIE AND IT IS STILL ACTIVE
]]

-- // Dependencies
local DecayHax = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Decaying%20Winter/GetRemoteKey.lua"))()

-- // Services
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

-- // Vars
local ServerStuff = Workspace.ServerStuff
local dealDamage = ServerStuff.dealDamage

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
        dealDamage:FireServer(Data, nil, DecayHax.RemoteKey, DecayHax.RemoteKey2)
    end
end

local function Kill(Target)
    -- // Make sure is a target
    if (Target.Name:find("AI")) then
        Target = Target:WaitForChild("npc").Value
        KillTarget(Target, Target:WaitForChild("Torso"))
        print("Killed: " .. Target.Name)
    end
end

-- // Kills every target
local function KillTargets()
    for _, Player in ipairs(Players:GetChildren()) do
        Kill(Player)
    end
end

-- // Kill all current hostiles
KillTargets()

-- // Kill all fugure hostiles
Players.ChildAdded:Connect(Kill)