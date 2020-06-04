-- Game: https://roblox.com/games/5061412825

-- // Valiant ENV
loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/ValiantENV.lua"))()

-- // Vars
local RenderStepped = RunService.RenderStepped
local Heartbeat = RunService.Heartbeat
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded.Wait(LocalPlayer.CharacterAdded)
local Humanoid = Character.WaitForChild(Character, "Humanoid")
local HumanoidRootPart = Character.WaitForChild(Character, "HumanoidRootPart")
local CurrentCamera = Workspace.CurrentCamera
local Mouse = LocalPlayer.GetMouse(LocalPlayer)
local Weapons = ReplicatedStorage.Weapons
local ClientBullet = ReplicatedStorage.Modules.Client["Client_Bullet"]
local Map = Workspace.Map
local Vegetation = Workspace.Vegetation

getgenv().DDayHax = {}
if not DDayHax.WeaponSpoof then 
    DDayHax.BackupWeapons = ReplicatedStorage.Weapons.Clone(ReplicatedStorage.Weapons)
    print('Made Weapon Spoof.')
end
DDayHax.SpoofedValues = {
    ["WalkSpeed"] = {
		["Default"] = 16
	},
    ["JumpPower"] = {
		["Default"] = 50
	},
}

DDayHax.SpoofValuesForWeapon = {
    FireRate = 0.07,
    ReloadTime = 0,
    Spread = 0,
    ReloadTime = 0,
    AmmoPerClip = 250,
    RecoilOuter = -0.4,
    RecoilInner = 0.2,
    RecoilSprint = -1.6,
}

DDayHax.Connections = {
    LocalPlayer.PlayerScripts["Client_Second"].AncestryChanged,
    LocalPlayer.PlayerScripts["Client_Second"].Changed,
    Map.AncestryChanged,
    Vegetation.AncestryChanged,
}

-- // Base MT Vars + Funs
local mt = getrawmetatable(game)
local backupnamecall = mt.__namecall
local backupnewindex = mt.__newindex
local backupindex = mt.__index 
setreadonly(mt, false)


function disableACPart1()
    function disableConnections(connection)
        for _,v in pairs(getconnections(connection)) do
            v:Disable()
        end
    end

    -- // Disable AC Connections
    for i,v in pairs(Weapons:GetChildren()) do
        disableConnections(v.ChildAdded)

        for _,x in pairs(v:GetChildren()) do
            if x:IsA("ModuleScript") then
                disableConnections(v.AncestryChanged)
            end
        end
    end

    for i,v in pairs(DDayHax.Connections) do
        disableConnections(v)
    end

    for _,connection in pairs(getconnections(LocalPlayer.PlayerGui.ChildAdded)) do
        for i,v in pairs(debug.getconstants(connection.Function)) do
            if tostring(v) == 'DDAY' then
                connection:Disable()
            end
        end
    end

    for i,v in pairs(Map:GetChildren()) do
        if v.Name == "Sandbags" then
            disableConnections(v.AncestryChanged)
        end
        for a,x in pairs(v:GetChildren()) do
            if x:IsA("BasePart") then
                disableConnections(x.AncestryChanged)
                disableConnections(x.Changed)
            end
        end
    end

    for i,v in pairs(Vegetation:GetChildren()) do
        disableConnections(v.AncestryChanged)
    end

    -- // Disable Functions
    for i,v in ipairs(getgc()) do
        if debug.getinfo(v).name == "DetectBodyStuff" or debug.getinfo(v).name == "AnotherLayer" then
            hookfunction(v, function() return end)
        end

        if debug.getfenv(v).script ~= nil and debug.getfenv(v).script.Name == "_Client_Main_" then 
            disableConnections(getfenv(v).script.AncestryChanged)
        end
    end
end
disableACPart1()
Character.CharacterAdded:Connect(disableACPart1)

-- // Gun Mods
for i,v in pairs(ReplicatedStorage.Weapons:GetDescendants()) do
    if v:IsA("ModuleScript") then
        local req = require(v)
        for a,x in pairs(DDayHax.SpoofValuesForWeapon) do
            if req[a] then
                req[a] = x
            end
        end
    end
end

-- // Anti Mine
for i,v in pairs(Map:GetChildren()) do
    if (v.Name == "Static_Landmine" or v.Name == "Land Mine") then
        v:Destroy()
    end
end
Map.DescendantAdded:Connect(function(Descendant)
    if (Descendant.Name == "Static_Landmine" or Descendant.Name == "Land Mine") then
        print(Descendant, "destroyed")
        v:Destroy()
    end
end)

-- // MT Stuff
if not DDayHax.Part2 then
    mt.__index = newcclosure(function(t, k)
        if t == HumanoidRootPart and k == "Anchored" then
            return false
        elseif t == Humanoid and k == "PlatformStand" then
            return false
        end
        if DDayHax.SpoofedValues[k] then
            return DDayHax.SpoofedValues[k]["Default"]
        end
        return backupindex(t, k)
    end)
    DDayHax.Part2 = true
    print("DDayHax: AC Bypass Part2 - Bypassed:", DDayHax.Part2)
end

mt.__namecall = newcclosure(function(...)
    local method = getnamecallmethod()
    local args = {...}
    if method == 'GetRealPhysicsFPS' then
        return 71
    end
    if method == "FireServer" then
        if tostring(args[1]) == "Attempt_Fire" and not DDayHax["WeaponSpoof"] then
            local req = require(DDayHax.BackupWeapons[args[2].Name]["Setting"])
            args[9] = req["AmmoPerClip"] 
            args[10] = req["AmmoPerClip"] 
            args[11] = req["FireRate"] 
            return backupnamecall(unpack(args))
        end
    end
    return backupnamecall(...)
end)

DDayHax.WeaponSpoof = true