-- // Game: https://www.roblox.com/games/901793731

-- made a while ago and just bypasses the ac atm

local reps = game.GetService(game, "ReplicatedStorage")
local weapons = reps.Weapons  
local clientbullet = reps.Modules.Client["Client_Bullet"]

local mt = getrawmetatable(game)
local backupnamecall = mt.__namecall
local backupnewindex = mt.__newindex
local backupindex = mt .__index
local localplayer = game.GetService(game, "Players").LocalPlayer
local char = localplayer.Character or localplayer.CharacterAdded.wait(localplayer.CharacterAdded)
local humanoid = char.WaitForChild(char, "Humanoid")
local hrp = char.WaitForChild(char, "HumanoidRootPart")
setreadonly(mt, false)
getgenv().humspoof = {
    ["WalkSpeed"] = {
		["Spoof"] = 30,
		["Def"] = 16
	},
    ["JumpPower"] = {
		["Spoof"] = 50,
		["Def"] = 50
	},
}

-- // AC Bypass
local function bypassAC1()
    for i,v in pairs(weapons:GetChildren()) do
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

    local map = game.GetService(game, "Workspace").Map
    local veggie = game.GetService(game, "Workspace").Vegetation
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
bypassAC1()
if not getgenv().bypassAC2 then

    mt.__newindex = newcclosure(function(t, i, v)
        if humspoof[i] then
            return backupnewindex(t, i, getgenv().humspoof[tostring(i)]["Spoof"])
        end
        return backupnewindex(t, i, v)
    end)

    mt.__index = newcclosure(function(t, k)
        if t == hrp and tostring(k) == "Anchored" then
            return false
        elseif t == humanoid and tostring(k) == 'PlatformStand' then
            return false
        end
        if getgenv().humspoof[tostring(k)] then
            return getgenv().humspoof[k]["Def"]
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
getgenv().TeleportDDay = function(cfr)
    local localplayer = game.GetService(game, "Players").LocalPlayer
    local char = localplayer.Character or localplayer.CharacterAdded.wait(localplayer.CharacterAdded)
    local hrp = char.WaitForChild(char, "HumanoidRootPart")
    for i = 0, 1, 0.1 do
        hrp.CFrame = hrp.CFrame:lerp(cfr, i)
        wait()
    end
end
--[[ //

for i,v in pairs(getgc()) do 
    if getfenv(v).script == clientbullet then 
		for a,x in pairs(debug.getconstants(v)) do 
            print(a, x)
            
			if tostring(x) == "Actual_Helmet" then
				debug.setconstant(v, a, "no")
			end
		end
		for a,x in pairs(weapons:GetDescendants()) do 
			if x:IsA("ModuleScript") then 
                local req = require(x)
                req.ReloadTime = 0
				IdleAnimationSpeed = 100
				FireAnimationSpeed = 100
				BoltAnimationSpeed = 100
				ReloadAnimationSpeed = 100
			end
		end
	end
end
]]