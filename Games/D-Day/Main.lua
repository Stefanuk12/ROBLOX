-- // Game: https://www.roblox.com/games/901793731

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
local Weapons = ReplicatedStorage.Weapons
local ClientBullet = ReplicatedStorage.Modules.Client["Client_Bullet"]

-- // Base MT Vars + Funs
local mt = getrawmetatable(game)
local backupnamecall = mt.__namecall
local backupnewindex = mt.__newindex
local backupindex = mt.__index 
setreadonly(mt, false)

getgenv().DDayHax = {}
DDayHax.SpoofedValues = {
    Walkspeed = {
        Spoof = 30,
        Default = 16,
    },
    JumpPower = {
        Spoof = 50,
        Default = 50,
    },
}

-- // Bypassing the Anti Cheat

local function bypassACPart1()
    for i,v in pairs(Weapons:GetChildren()) do
        for _,connection in pairs(getconnections(v.ChildAdded)) do 
            connection:Disable()
        end

        for _,x in pairs(v:GetChildren()) do 
            if x:IsA("ModuleScript") then 
                for _,connection in pairs(getconnections(v.AncestryChanged)) do 
                    connection:Disable()
                end
            end
        end
    end

    for i,v in pairs(getgc()) do 
        if debug.getinfo(v).name == "DetectBodyStuff" then 
            hookfunction(v, function() return end)
        end
        if debug.getfenv(v).script ~= nil and debug.getfenv(v).script.Name == "_Client_Main_" then 
            for _,connection in pairs(getconnections(getfenv(v).script.AncestryChanged)) do 
                connection:Disable()
            end
        end
    end

    for _, connection in pairs(getconnections(game.GetService(game, "Players").LocalPlayer.PlayerScripts.Client_Second.AncestryChanged)) do
        connection:Disable()
    end

    for _, connection in pairs(getconnections(game.GetService(game, "Players").LocalPlayer.PlayerScripts.Client_Second.Changed)) do
        connection:Disable()
    end

    for _, connection in pairs(getconnections(game.GetService(game, "Players").LocalPlayer.PlayerGui.ChildAdded)) do
        for i,v in pairs(debug.getconstants(connection.Function)) do
            if tostring(v) == 'DDAY' then
                connection:Disable()
            end
        end
    end

    local map = Workspace.Map
    local veggie = Workspace.Vegetation
    for _, connection in pairs(getconnections(map.AncestryChanged)) do
        connection:Disable()
    end
    for _, connection in pairs(getconnections(veggie.AncestryChanged)) do
        connection:Disable()
    end
    for i,v in pairs(map:GetChildren()) do
        if v.Name == "Sandbags" then
            for _, connection in pairs(getconnections(v.AncestryChanged)) do
                connection:Disable()
            end
        end
        for a,x in pairs(v:GetChildren()) do
            if x:IsA("BasePart") then
                for _, connection in pairs(getconnections(x.AncestryChanged)) do
                    connection:Disable()
                end
                for _, connection in pairs(getconnections(x.Changed)) do
                    connection:Disable()
                end
            end
        end
    end
    for i,v in pairs(veggie:GetChildren()) do
        for _, connection in pairs(getconnections(v.AncestryChanged)) do
            connection:Disable()
        end
    end
    print('AC Part 1: Done!')
    return true
end
bypassACPart1()

if not getgenv().bypassAC2 then
    mt.__newindex = newcclosure(function(t, i, v)
        if humspoof[i] then
            return backupnewindex(t, i, getgenv().DDayHax.SpoofedValues[tostring(i)]["Spoof"])
        end
        return backupnewindex(t, i, v)
    end)

    mt.__index = newcclosure(function(t, k)
        if t == hrp and tostring(k) == "Anchored" then
            return false
        elseif t == humanoid and tostring(k) == 'PlatformStand' then
            return false
        end
        if getgenv().DDayHax.SpoofedValues[tostring(k)] then
            return getgenv().DDayHax.SpoofedValues[k]["Def"]
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
    print('AC Part 2 done!')
    getgenv().bypassAC2 = true
end

function TeleportDDay(cfr)
    local hrp = Character.WaitForChild(Character, "HumanoidRootPart")
    for i = 0, 1, 0.1 do
        hrp.CFrame = hrp.CFrame:lerp(cfr, i)
        wait()
    end
end
