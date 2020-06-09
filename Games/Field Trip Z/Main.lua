-- Game: https://roblox.com/games/4954096313

-- // Valiant ENV
loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/ValiantENV.lua"))()

-- // Vars
local RenderStepped = RunService.RenderStepped
local Heartbeat = RunService.Heartbeat
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded.Wait(LocalPlayer.CharacterAdded)
local Humanoid = Character.WaitForChild(Character, "Humanoid")
local CurrentCamera = Workspace.CurrentCamera
local Mouse = LocalPlayer.GetMouse(LocalPlayer)
local RF = ReplicatedStorage:WaitForChild("NetworkEvents"):WaitForChild("RemoteFunction")
local Interactions = Workspace.Interactions
local Weapons = Interactions:WaitForChild("Weapons")
local BloodSamples = Interactions.BloodSamples
local KillParts = Interactions.KillParts
local Items = Interactions.Items
local Glass = Interactions.Glass

-- // Base MT Vars + Funs
local mt = getrawmetatable(game)
local backupnamecall = mt.__namecall
local backupnewindex = mt.__newindex
local backupindex = mt.__index 
setreadonly(mt, false)

-- // Anti Kick + Inf DMG + Godmode
hookfunction(LocalPlayer.Kick, warn)
hookfunction(LocalPlayer.kick, warn)
mt.__namecall = newcclosure(function(...)
    local method = getnamecallmethod()
    local args = {...}
    if string.lower(method) == "kick" then
        return nil
    end
    if method == "InvokeServer" then
        if tostring(args[1]) == "RemoteFunction" then
            if tostring(args[2]) == "DO_DAMAGE" then
                args[4] = math.huge
            end
            if tostring(args[2]) == "TAKE_DAMAGE_PLAYER" then
                return nil
            end
        end
        return backupnamecall(unpack(args))
    end
    return backupnamecall(...)
end)

-- // Godmode
RF:InvokeServer("HEAL_PLAYER", LocalPlayer, 100)
for i,v in pairs(Players:GetPlayers()) do
    local Humanoid = v.Character:FindFirstChildWhichIsA("Humanoid")
    Humanoid.HealthChanged:Connect(function(health)
        RF:InvokeServer("HEAL_PLAYER", v, 100)
    end)
end

-- // Remove Damage Parts
for i,v in pairs(KillParts:GetChildren()) do
    v:Destroy()
end
KillParts.ChildAdded:Connect(function(child)
    child:Destroy()
end)