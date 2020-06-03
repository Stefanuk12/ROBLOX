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
DDayHax.SpoofedValues = {
    ["WalkSpeed"] = {
		["Spoof"] = 30,
		["Def"] = 16
	},
    ["JumpPower"] = {
		["Spoof"] = 50,
		["Def"] = 50
	},
}

DDayHax.Connections = {
    LocalPlayer.PlayerScripts["Client_Second"].AncestryChanged = true,
    LocalPlayer.PlayerScripts["Client_Second"].Changed = true,
    Map.AncestryChanged = true,
    Vegetation.AncestryChanged = true,
}


-- // Base MT Vars + Funs
local mt = getrawmetatable(game)
local backupnamecall = mt.__namecall
local backupnewindex = mt.__newindex
local backupindex = mt.__index 
setreadonly(mt, false)


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
    disableConnections(i)
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
    if debug.getinfo(v).name == "DetectBodyStuff" then
        hookfunction(v, function() return end)
    end

    if debug.getfenv(v).script ~= nil and debug.getfenv(v).script.Name == "_Client_Main_" then 
        disableConnections(getfenv(v).script.AncestryChanged)
    end
end

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

    mt.__namecall = newcclosure(function(...)
        local method = getnamecallmethod()
        if method == 'GetRealPhysicsFPS' then
            return 71
        end
        if method == "Destroy" and args[1] == Character.Head then
            return nil
        end

        return backupnamecall(...)
    end)
    DDayHax.Part2 = true
end


