-- Game: https://www.roblox.com/games/5179736523

-- // Valiant ENV
loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/ValiantENV.lua"))()

-- // Vars
local UIS = game:GetService("UserInputService")
local RenderStepped = RunService.RenderStepped
local Heartbeat = RunService.Heartbeat
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded.Wait(LocalPlayer.CharacterAdded)
local Backpack = LocalPlayer.Backpack
local Humanoid = Character.WaitForChild(Character, "Humanoid")
local CurrentCamera = Workspace.CurrentCamera
local Mouse = LocalPlayer.GetMouse(LocalPlayer)
local FurryFolder
for i,v in pairs(Workspace:GetChildren()) do if v:IsA("Folder") and string.match(v.Name, "-") then FurryFolder = v end end
local modValues = {
    Auto = true, 
	BaseDamage = 100, 
	FireRate = 0.01, 
	ReloadTime = 0.1, 
	AmmoPerClip = math.huge, 
	Spread = 0.01, 
	HeadshotEnabled = true,
	BulletPerShot = 50, 
	ShellClipinSpeed = 1, 
	BulletPerBurst = 10, 
	BurstRate = 0.001,
	SpreadRedution = 1, 
	ExplosiveEnabled = true, 
	Radius = 20, 
	BulletSpeed = 2500, 
	FadeTime = 0.01, 
	ChargingTime = 1, 
	DelayBeforeFiring = 0.01, 
	DelayAfterFiring = 0.01, 
	Knockback = 0, 
	Lifesteal = 0, 
	FlamingBullet = true, 
	DualEnabled = false, 
    Piercing = 10,
    CameraShakingEnabled = false, 
}

-- // Base MT Vars + Funs
local mt = getrawmetatable(game)
local backupnamecall = mt.__namecall
local backupnewindex = mt.__newindex
local backupindex = mt.__index 
setreadonly(mt, false)

-- // Anti Camera Shake
for i,v in pairs(getgc()) do
    if debug.getinfo(v).name == "ShakeCamera" then
        hookfunction(v, function() end)
    end
end

-- // Silent Aim Vars
getgenv().ValiantAimHacks = {
    SilentAimEnabled = true,
    AimbotEnabled = false,
    ShowFOV = true,
    VisibleCheck = true,
    TeamCheck = true,
    FOV = 60,
    HitChance = 100,
    Selected = LocalPlayer,
    BlacklistedTeams = {
        {
            Team = LocalPlayer.Team,
            TeamColor = LocalPlayer.TeamColor,
        },
    },
    BlacklistedPlayers = {game:GetService("Players").LocalPlayer},
    WhitelistedPUIDs = {91318356},
}

-- // Show FOV
local circle = Drawing.new("Circle")
function ValiantAimHacks.updateCircle()
    if circle then
        circle.Transparency = 1
        circle.Visible = ValiantAimHacks["ShowFOV"]
        circle.Thickness = 2
        circle.Color = Color3.fromRGB(231, 84, 128)
        circle.NumSides = 12
        circle.Radius = (ValiantAimHacks["FOV"] * 6) / 2
        circle.Filled = false
        circle.Position = Vector2.new(Mouse.X, Mouse.Y + (GuiService.GetGuiInset(GuiService).Y))
        return circle
    end
end

-- // Custom Functions
setreadonly(math, false); math.chance = function(percentage) local percentage = math.floor(percentage); local chance = math.floor(Random.new().NextNumber(Random.new(), 0, 1) * 100)/100; return chance <= percentage/100 end; setreadonly(math, true);
setreadonly(table, false); table.loopforeach = function(tbl, func) for index, value in pairs(tbl) do if type(value) == 'table' then table.loopforeach(value, func); elseif type(value) == 'function' then table.loopforeach(debug.getupvalues(value)); else func(index, value); end; end; end; setreadonly(table, true);

-- // Silent Aim Function
function ValiantAimHacks.getClosestFurryToCursor()
    local ClosestFurry = nil
    local Chance = math.chance(ValiantAimHacks["HitChance"])
    local ShortestDistance = math.huge
    if not Chance then ValiantAimHacks["Selected"] = (Chance and LocalPlayer or LocalPlayer) return (Chance and LocalPlayer or LocalPlayer) end
    function isPartVisible(Part, PartDescendant)
        local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded.Wait(LocalPlayer.CharacterAdded)
        local Origin = CurrentCamera.CFrame.p
        local _, OnScreen = CurrentCamera.WorldToViewportPoint(CurrentCamera, Part.Position)
        if OnScreen then
            local newRay = Ray.new(Origin, Part.Position - Origin)
            local PartHit, _ = Workspace.FindPartOnRayWithIgnoreList(Workspace, newRay, {Character, CurrentCamera})
            local Visible = (not PartHit or PartHit.IsDescendantOf(PartHit, PartDescendant))
            return Visible
        end
        return false
    end
    for _,furry in pairs(FurryFolder:GetChildren()) do
        if furry.FindFirstChild(furry, "Head") and furry.FindFirstChildWhichIsA(furry, "Humanoid") and furry.FindFirstChildWhichIsA(furry, "Humanoid").Health > 0 then
            local PartPos, OnScreen = CurrentCamera.WorldToViewportPoint(CurrentCamera, furry.Head.Position)
            local Magnitude = (Vector2.new(PartPos.X, PartPos.Y) - Vector2.new(Mouse.X, Mouse.Y)).magnitude  
            if (Magnitude < (ValiantAimHacks["FOV"] * 6 - 8)) and (Magnitude < ShortestDistance) then
                if ValiantAimHacks["VisibleCheck"] and isPartVisible(furry.Head, furry) then
                    ClosestFurry = furry
                    ShortestDistance = Magnitude
                elseif not ValiantAimHacks["VisibleCheck"] then
                    ClosestFurry = furry
                    ShortestDistance = Magnitude
                end
            end
        end
    end
    ValiantAimHacks["Selected"] = (Chance and ClosestFurry or LocalPlayer)
    return (Chance and ClosestFurry or LocalPlayer)
end

function ValiantAimHacks.findDirectionNormalMaterial(Origin, Destination, UnitMultiplier)
    if typeof(Origin) == "Vector3" and typeof(Destination) == "Vector3" then
        if not UnitMultiplier then UnitMultiplier = 1 end
        local Direction = (Destination - Origin).Unit * UnitMultiplier
        local RaycastResult = Workspace.Raycast(Workspace, Origin, Direction)
        if RaycastResult ~= nil then
            local Normal = RaycastResult.Normal
            local Material = RaycastResult.Material
            return Direction, Normal, Material
        end
    end
    return nil
end

function ValiantAimHacks.checkSilentAim()
    if ValiantAimHacks.SilentAimEnabled and ValiantAimHacks["Selected"] ~= LocalPlayer then
        return true
    end
    return false
end

-- // Heartbeat Function
local HBFuncs = function()
    ValiantAimHacks.updateCircle()
    ValiantAimHacks.getClosestFurryToCursor()
end
Heartbeat.Connect(Heartbeat, HBFuncs)

-- // Silent Aim MT
mt.__index = newcclosure(function(t, k)
    if t == Mouse and (k == "Target" or k == "Hit") and ValiantAimHacks.checkSilentAim() then
        local CPlayer = ValiantAimHacks["Selected"].Head
        return (k == "Target" and CPlayer or CPlayer.CFrame)
    end
    return backupindex(t, k)
end)

-- // Insta Kill
mt.__namecall = newcclosure(function(...)
    local method = getnamecallmethod()
    local args = {...}
    if method == "FireServer" then
        if tostring(args[1]) == "InflictTarget" then
            args[4] = 100
            return backupnamecall(unpack(args))
        end
    end
    return backupnamecall(...)
end)

-- // AC Bypass
for _, connection in pairs(getconnections(game:GetService("ScriptContext").Error)) do
    connection:Disable()
end

function getWeapon()
    for i,v in pairs(Character:GetChildren()) do
        if v:IsA("Tool") and v:FindFirstChild("GunScript_Local") then
            return v
        end
    end
end

-- // Gun Mods
function doGunMods()
    wait(0.5)
    if getWeapon() then
        local Gun = getWeapon()
        local GunModule = require(Gun.Setting)
        for modName, modValue in pairs(modValues) do
            -- // Manage Gun.Settings
            if rawget(GunModule, modName) then
                rawset(GunModule, modName, modValue)
            end

            -- // Manage GunScript_Local
            for _, gc in pairs(getgc()) do
                if getfenv(gc).script and getfenv(gc).script.Name == "GunScript_Local" then
                    for _, uv in pairs(debug.getupvalues(gc)) do
                        if type(uv) == 'table' and rawget(uv, modName) then
                            rawset(uv, modName, modValue)
                        end
                    end
                end
            end
        end
        print('Done Gun Mods')
    end
end
doGunMods()
Character.ChildAdded:Connect(doGunMods)

function killAllFurries()
    if getWeapon() then
        local Gun = getWeapon()
        local Remote = Gun["GunScript_Server"].InflictTarget
        local GunSettings = require(Gun.Setting)
        for i,v in pairs(FurryFolder:GetChildren()) do
            if v:FindFirstChildWhichIsA("Humanoid") and v:FindFirstChild("Torso") then
                Remote:FireServer(
                    v:FindFirstChildWhichIsA("Humanoid"),
                    v:FindFirstChild("Torso"),
                    100,
                    Vector3.new(),
                    GunSettings.Knockback,
                    GunSettings.Lifesteal,
                    GunSettings.FlamingBullet
                )
                print('Killed a furry!')
            end
        end
    end
end

UIS.InputBegan:Connect(function(Key, GPE)
    if not GPE then
        if Key.KeyCode == Enum.KeyCode.F6 then
            killAllFurries()
        end
    end
end)