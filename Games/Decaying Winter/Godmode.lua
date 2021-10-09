-- // Information
--[[
    You need a bandage out in your hand

    YOU WILL GET BANNED AFTER SOME TIME
]]

-- // Dependencies
local DecayHax = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Decaying%20Winter/GetRemoteKey.lua"))()

-- // Services
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

-- // Vars
local LocalPlayer = Players.LocalPlayer

local ServerStuff = Workspace.ServerStuff
local dealDamage = ServerStuff.dealDamage

-- // Heal enough health to get back to 100
local function HealthFull(Health)
    -- // Workout how many times to fire remote
    local FireAmount = math.ceil((100 - Health) / 5)

    -- // Fire remote
    for i = 1, FireAmount do wait()
        dealDamage:FireServer("regenheal", nil, DecayHax.RemoteKey, DecayHax.RemoteKey2)
    end
end

-- //
local function onCharacter(Character)
    -- // Vars
    local Humanoid = Character:WaitForChild("Humanoid")

    -- // Heal to full
    HealthFull(Humanoid.Health)

    -- // See whenever lose health, heal back up
    Humanoid.HealthChanged:Connect(HealthFull)
end
onCharacter(LocalPlayer.Character)

-- // Work after death
LocalPlayer.CharacterAdded:Connect(onCharacter)