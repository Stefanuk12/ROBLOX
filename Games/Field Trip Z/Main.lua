-- Game: https://roblox.com/games/4954096313/#

-- // Vars
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RE = ReplicatedStorage:WaitForChild("NetworkEvents"):WaitForChild("RemoteEvent")
local RF = ReplicatedStorage:WaitForChild("NetworkEvents"):WaitForChild("RemoteFunction")
local Interactions = Workspace:WaitForChild("Interactions")
local Weapons = Interactions:WaitForChild("Weapons")
local BloodSamples = Interactions:WaitForChild("BloodSamples")
local KillParts = Interactions:WaitForChild("KillParts")
local Items = Interactions:WaitForChild("Items")
local Glass = Interactions:WaitForChild("Glass")

-- // Base MT Vars + Funs
local mt = getrawmetatable(game)
local backupnamecall = mt.__namecall
getnamecallmethod = getnamecallmethod or get_namecall_method
setreadonly(mt, false)

-- // Inf DMG + Godmode
mt.__namecall = newcclosure(function(...)
    local method = getnamecallmethod()
    local args = {...}
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
for i,v in pairs(Players:GetPlayers()) do
    local Humanoid = v.Character:FindFirstChildWhichIsA("Humanoid")
    RF:InvokeServer("HEAL_PLAYER", v, 100)
    Humanoid:GetPropertyChangedSignal("Health"):Connect(function()
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

function getAllItems()
    for i,v in pairs(Items:GetDescendants()) do
        if v:IsA("ClickDetector") then
            fireclickdetector(v, 0)
        end
    end
end

function getAllWeapons()
    for i,v in pairs(Weapons:GetDescendants()) do
        if v:IsA("ClickDetector") then
            fireclickdetector(v, 0)
        end
    end
end