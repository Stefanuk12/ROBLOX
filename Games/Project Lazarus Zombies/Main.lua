-- Game: https://www.roblox.com/games/443406476
--[[
    Feature List:
        Gun Mods
        WalkSpeed 
        Always Headshot
        Get Remote Ley
        Auto Kill All Zombies
        Point Farm
        Anti Crash
        Teleport All Zombies to Cursor
]]

-- // Valiant ENV
loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/ValiantENV.lua"))()

-- // Vars
local UserInputService = game:GetService("UserInputService")
local RenderStepped = RunService.RenderStepped
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded.Wait(LocalPlayer.CharacterAdded)
local Backpack = LocalPlayer.Backpack
local Humanoid = Character.WaitForChild(Character, "Humanoid")
local Baddies = Workspace.Baddies
local Mouse = LocalPlayer:GetMouse()
local NotificationHandler = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Notifications/Script.lua"))()
NotificationHandler["StorageLocation"] = game:GetService("CoreGui")
getgenv().ZombieHax = {
    HumanoidSpoofVals = {
        WalkSpeed = 50,
    },
    AlwaysHeadshot = true,
    CapturedRemoteKey = nil,
    AutoKillAllZombies = false,
    PointFarm = false,
    NetworkOwnerEnabled = false
}
ZombieHax = getgenv().ZombieHax

-- // Base MT Vars + Funs
local mt = getrawmetatable(game)
local backupnamecall = mt.__namecall
local backupnewindex = mt.__newindex
local backupindex = mt.__index 
setreadonly(mt, false)

-- // Notification
Notify = function(...)
    local text = tostring(...)
    NotificationHandler.newNotification("SUCCESS", text, "Success")
end

-- // Auto does stuff when table indexes are updated
local function tableHandler(targetTable, onUA) -- UA Stands for Update/Add, CC Stands for CheckCaller
    local onUA = onUA or function() end
    local CC = CC or false
	return setmetatable({}, {
		__index = targetTable,
		__newindex = function(self, index, value)
		    local updateTable = {}
		    table.insert(updateTable, {index, value, targetTable[index]})
			targetTable[index] = value
			table.insert(updateTable, {index, value, targetTable[index]})
			onUA(updateTable)
		end
	})
end

-- // Gun Mods Section // --
function doGunMods(gunMods)
    for _,v in pairs(Backpack:GetChildren()) do -- // Getting the modules we need to change
        if string.match(v.Name, "Weapon") and v:IsA("ModuleScript") then
            -- // Doing the Gun Mods
            local req = require(v)  
            for a,x in pairs(gunMods) do
                if rawget(req, a) then
                    rawset(req, a, x)
                end
            end
        end
    end
end

ZombieHax.ModTable = { -- // Setting default values
    MagSize = 1/0,
    StoredAmmo = 1/0,
    MaxAmmo = 1/0,
    FireRate = 0.01,
    Semi = false,
    Damage = {Min = 1/0, Max = 1/0},
    Drop = {Start = 0, End = 0},
    BulletPenetration = 1000,
    GibPower = 1000,
    Spread = {Min = 0, Max = 0},
    GunKick = 0,
    ViewKick = {Pitch = {Min = 0, Max = 0}, Yaw = {Min = 0, Max = 0}},
    AimTime = 0,
    Splash = {Damage = {Min = 1/0, Max = 1/0}, Radius = 15},
    ProjectileSpeed = 100000000
}

ZombieHax.ModTable = tableHandler(ZombieHax.ModTable, function(givenTable) -- // Auto change values when the ModTable is changed/added to
    doGunMods(ZombieHax.ModTable)
end)
doGunMods(ZombieHax.ModTable)

Character.ChildAdded:Connect(function(child)
    wait(0.5)
    doGunMods(ZombieHax.ModTable)
end)

-- // Anti Crash Function // --
function ZombieHax.nonoOverload()
    for _,v in pairs(getgc()) do
        if debug.getinfo(v).name == "Overload" then
            hookfunction(v, function() end)
        end
    end
end
ZombieHax.nonoOverload()
LocalPlayer.CharacterAdded:Connect(ZombieHax.nonoOverload) -- // Just in case

-- // Kill All Zombies Section // --
function ZombieHax.killAllZombies()
    for _,v in pairs(Baddies:GetChildren()) do
        if ZombieHax.CapturedRemoteKey then
            v.Humanoid.Damage:FireServer({
                ["BodyPart"] = v.Head, 
                ["GibPower"] = 1/0, 
                ["Damage"] = 1/0,
            }, ZombieHax.CapturedRemoteKey)
        end
    end
end

Baddies.ChildAdded:Connect(function(child)
    if ZombieHax.AutoKillAllZombies and ZombieHax.CapturedRemoteKey and v:FindFirstChild("Humanoid") then 
        child.Humanoid.Damage:FireServer({
            ["BodyPart"] = v.Head, 
            ["GibPower"] = 1/0, 
            ["Damage"] = 1/0,
        }, ZombieHax.CapturedRemoteKey)
    end
end)

-- // Point Farm Section // --
RunService:BindToRenderStep("PointFarm", 0, function()
    if ZombieHax.CapturedRemoteKey and ZombieHax.PointFarm and not ZombieHax.AutoKillAllZombies then
        local targetZombie = Baddies:FindFirstChild("Zombie")
        if targetZombie and targetZombie:FindFirstChild("Humanoid") and targetZombie.Humanoid:FindFirstChild("Damage") and ZombieHax.CapturedRemoteKey and ZombieHax.PointFarm and not ZombieHax.AutoKillAllZombies then
            targetZombie.Humanoid.Damage:FireServer({
                ["BodyPart"] = targetZombie.Head, 
                ["GibPower"] = 0, 
                ["Damage"] = 0,
            }, ZombieHax.CapturedRemoteKey)
        end
    end
end)

-- // TP All Zombies // --
if sethiddenproperty then -- // Network Ownership
    game:GetService("RunService"):BindToRenderStep("NetworkRep", 0, function()
        if ZombieHax.NetworkOwnerEnabled and gethiddenproperty(LocalPlayer, "SimulationRadius") ~= 1/0 then
            sethiddenproperty(LocalPlayer, "SimulationRadius", 1/0)
            sethiddenproperty(LocalPlayer, "MaximumSimulationRadius", 1/0)
        end
    end)
end

function ZombieHax.TPAllZombies()
    ZombieHax.NetworkOwnerEnabled = true
    for _,v in pairs(Baddies:GetChildren()) do
        coroutine.wrap(function() -- // To make it faster
            if v and v.HumanoidRootPart then
                v.HumanoidRootPart.CFrame = Mouse.Hit
            end
        end)()
    end
    ZombieHax.NetworkOwnerEnabled = false -- // Cause less strain on client
end

-- // Keybinds // --
UserInputService.InputBegan:Connect(function(Key, GPE)
    if not GPE then
        local KeyCode = Key.KeyCode
        local EnumKeyCode = Enum.KeyCode

        if KeyCode == EnumKeyCode.F1 then
            ZombieHax.AutoKillAllZombies = not ZombieHax.AutoKillAllZombies
            ZombieHax.PointFarm = not ZombieHax.AutoKillAllZombies
            Notify("Auto Kill All Zombies: "..(ZombieHax.AutoKillAllZombies and "Enabled." or "Disabled."))
        elseif KeyCode == EnumKeyCode.F2 then
            ZombieHax.PointFarm = not ZombieHax.PointFarm
            Notify("Point Farm: "..(ZombieHax.PointFarm and "Enabled." or "Disabled."))
            ZombieHax.AutoKillAllZombies = not ZombieHax.PointFarm
        elseif KeyCode == EnumKeyCode.F3 then
            ZombieHax.AlwaysHeadshot = not ZombieHax.AlwaysHeadshot
            Notify("Always Headshot: "..(ZombieHax.AlwaysHeadshot and "Enabled." or "Disabled."))
        elseif KeyCode == EnumKeyCode.F4 then
            ZombieHax.killAllZombies()
            Notify("Killed all zombies!")
        elseif KeyCode == EnumKeyCode.F5 then
            ZombieHax.TPAllZombies()
            Notify("Teleported All Zombies To Cursor!")
        elseif KeyCode == EnumKeyCode.F6 then
            doGunMods(ZombieHax.ModTable)
        end
    end
end)

-- // Metatable Section // --
mt.__newindex = newcclosure(function(t, k, v) -- // Setting the WalkSpeed/Other
    if t == Humanoid and ZombieHax["HumanoidSpoofVals"][k] then
        return backupnewindex(t, k, ZombieHax["HumanoidSpoofVals"][k])
    end

    return backupnewindex(t, k, v)
end)

mt.__namecall = newcclosure(function(...)-- // Handling Remotes: Caputuring the remote key and always headshot
    local args = {...}
    local method = getnamecallmethod()
    if method == "FireServer" then
        if tostring(args[1]) == "UpdateDamageKey" then
            ZombieHax["CapturedRemoteKey"] = args[2] -- // Grab remote key
        end
        if tostring(args[1]) == 'Damage' then
            if AlwaysHeadshot then args[2].BodyPart = args[2].BodyPart.Parent.Head end -- // Always Headshot
            ZombieHax["CapturedRemoteKey"] = args[3] -- // Grab remote key

            return backupnamecall(unpack(args))
        end
    elseif method == "InvokeServer" then

    end
    return backupnamecall(...)
end)