-- // Information
--[[
    You need a bandage out in your hand
]]

-- // Services
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

-- // Vars
local LocalPlayer = Players.LocalPlayer
local Backpack = LocalPlayer.Backpack
local mainHandler = Backpack:WaitForChild("mainHandler")

local ServerStuff = Workspace.ServerStuff
local dealDamage = ServerStuff.dealDamage

-- // Get the remote key
local RemoteKey = ""
do
    -- // Vars
    local stagger = getsenv(mainHandler).stagger

    -- //
    RemoteKey = debug.getupvalue(stagger, 6)
end

-- // Heal enough health to get back to 100
local function HealthFull(Health)
    -- // Workout how many times to fire remote
    local FireAmount = math.ceil((100 - Health) / 5)

    -- // Fire remote
    for i = 1, FireAmount do wait()
        dealDamage:FireServer("regenheal", nil, RemoteKey)
    end
end

-- //
local function onCharacter(Character)
    -- // Vars
    local Humanoid = Character:WaitForChild("Humanoid")

    -- // Heal to full
    HealthFull(Humanoid.Health)

    -- // See whenever lose health, heal back up
    Humanoid.HealthChanged:Connect(function(Health)
        HealthFull(Health)
    end)
end
onCharacter(LocalPlayer.Character)

-- // Work after death
LocalPlayer.CharacterAdded:Connect(onCharacter)