-- Game: https://www.roblox.com/games/5111155861

-- // Valiant ENV
loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/ValiantENV.lua"))()

-- // Vars
local RenderStepped = RunService.RenderStepped
local Heartbeat = RunService.Heartbeat
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded.Wait(LocalPlayer.CharacterAdded)
local Backpack = LocalPlayer.Backpack
local Humanoid = Character.WaitForChild(Character, "Humanoid")
local CurrentCamera = Workspace.CurrentCamera
local Mouse = LocalPlayer.GetMouse(LocalPlayer)
local changeVals = {
    BulletSpread = 0,
    MaxSpread = 0,
    ChargeRate = math.huge,
    MaxDistance = math.huge,
    RecoilMin = 0,
    RecoilMax = 0,
    TotalRecoilMax = 0,
    GravityFactor = 0.01,
    ShotCooldown = 0,
    FireMode = "Automatic"
}
local autoReload = true
local GunModTable = {}
local WeaponsSystem = ReplicatedStorage.WeaponsSystem
local Libraries = WeaponsSystem.Libraries
local WeaponTypes = WeaponsSystem.WeaponTypes
local BulletWeapon = WeaponTypes.BulletWeapon
local BaseWeapon = Libraries.BaseWeapon
local Network = WeaponsSystem.Network
local WeaponReloadRequest = Network.WeaponReloadRequest
local WeaponHit = Network.WeaponHit

-- // Base MT Vars + Funs
local mt = getrawmetatable(game)
local backupnamecall = mt.__namecall
local backupnewindex = mt.__newindex
local backupindex = mt.__index 
setreadonly(mt, false)

-- // Functions
function equipTool(targetTool)
    if Backpack:FindFirstChild(targetTool) then
        print('Equipped -', targetTool)
        Humanoid:EquipTool(Backpack[targetTool])
        return true
    elseif Character:FindFirstChild(targetTool) then
        return true
    end
    return false
end

function getWeapon(Player, targetWeapon)
    if targetWeapon then
        repeat wait() until equipTool("AWM")
    end
    for i,v in pairs(Player.Character:GetChildren()) do
        if v:IsA("Tool") then
            if targetWeapon and v.Name == targetWeapon then
                return v
            elseif not targetWeapon then
                return v 
            end
        end
    end
end

function killAll()
    repeat wait() until getWeapon(LocalPlayer, "AWM")
    for i,v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer and not v.Character:FindFirstChild("ForceField") then
            local Arg1 = getWeapon(LocalPlayer, "AWM")
            local Arg2 = {
                ["p"] = v.Character.Head.Position,
                ["pid"] = 1,
                ["part"] = v.Character.HumanoidRootPart,
                ["d"] = 0.1,
                ["maxDist"] = 0.06,
                ["h"] = v.Character.Humanoid,
                ["m"] = Enum.Material.Plastic,
                ["sid"] = 1,
                ["t"] = 0.006,
                ["n"] = v.Character.Head.Position,
            }
            Network.WeaponHit:FireServer(Arg1, Arg2)
            print('Killed - ', v.Name)
        end
    end
end

function doGunMods()
    repeat wait() until getWeapon(LocalPlayer)
    for _, Obj in pairs(getgc(true)) do
        if type(Obj) == "table" then
            for i,v in pairs(changeVals) do
                if rawget(Obj, i) then
                    rawset(Obj, i, v)
                end
            end
        end
    end
    print('Successfully Modded Weapon!')
end

-- // Silent Aim 
setreadonly(mt, false)

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
function ValiantAimHacks.getClosestPlayerToCursor()
    local ClosestPlayer = nil
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
    function checkTeam(localPlayer, targetPlayer)
        if targetPlayer.Team ~= localPlayer.Team then
            for _,v in pairs(ValiantAimHacks.BlacklistedTeams) do
                if targetPlayer.Team ~= v.Team and targetPlayer.TeamColor ~= v.TeamColor then
                    return true
                end
            end
        end
        return false
    end
    function checkPlayer(targetPlayer)
        for i,v in pairs(ValiantAimHacks.BlacklistedPlayers) do
            if v ~= targetPlayer then
                return true
            end
        end
        return false
    end
    for _,plr in pairs(Players.GetPlayers(Players)) do
        if checkPlayer(plr) and plr.Character and plr.Character.FindFirstChildWhichIsA(plr.Character, "Humanoid") and plr.Character.FindFirstChildWhichIsA(plr.Character, "Humanoid").Health > 0 then
            if (ValiantAimHacks["TeamCheck"] and not checkTeam(LocalPlayer, plr)) then break end
            local PartPos, OnScreen = CurrentCamera.WorldToViewportPoint(CurrentCamera, plr.Character.PrimaryPart.Position)
            local Magnitude = (Vector2.new(PartPos.X, PartPos.Y) - Vector2.new(Mouse.X, Mouse.Y)).magnitude  
            if (Magnitude < (ValiantAimHacks["FOV"] * 6 - 8)) and (Magnitude < ShortestDistance) then
                if ValiantAimHacks["VisibleCheck"] and isPartVisible(plr.Character.PrimaryPart, plr.Character) then
                    ClosestPlayer = plr
                    ShortestDistance = Magnitude
                elseif not ValiantAimHacks["VisibleCheck"] then
                    ClosestPlayer = plr
                    ShortestDistance = Magnitude
                end
            end
        end
    end
    ValiantAimHacks["Selected"] = (Chance and ClosestPlayer or LocalPlayer)
    return (Chance and ClosestPlayer or LocalPlayer)
end

function ValiantAimHacks.findDirectionNormalMaterial(Origin, Destination)
    if typeof(Origin) == "Vector3" and typeof(Destination) == "Vector3" then
        local Direction = (Destination - Origin).Unit * 5000
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
    ValiantAimHacks.getClosestPlayerToCursor()
end
Heartbeat.Connect(Heartbeat, HBFuncs)
setreadonly(mt, true)

setreadonly(mt, false)
mt.__namecall = newcclosure(function(...)
    local args = {...}
    local method = getnamecallmethod()
    if tostring(args[1]) == "WeaponFired" and ValiantAimHacks.checkSilentAim() then
        local Origin = args[3]["origin"]
        local targetPlayer = ValiantAimHacks["Selected"].Character
        local Direction, Normal, Material = ValiantAimHacks.findDirectionNormalMaterial(Origin, targetPlayer.Head.Position)
        local weapon = args[2]
        local Id1 = args[3]["id"]
        local tableargs = {
            ["p"] = targetPlayer.Head.Position,
            ["pid"] = 1,
            ["part"] = targetPlayer.HumanoidRootPart,
            ["d"] = 0.1,
            ["maxDist"] = 0.06,
            ["h"] = targetPlayer.Humanoid,
            ["m"] = Enum.Material.Plastic,
            ["sid"] = Id1,
            ["t"] = 0.06,
            ["n"] = targetPlayer.Head.Position,
        }
        backupnamecall(WeaponHit, weapon, tableargs)
    end

    return backupnamecall(...)
end)
setreadonly(mt, true)

-- // Player ESP
local PlayerESP = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Player%20ESP.lua"))()

-- // Function Handler stuff
coroutine.wrap(function()
    while wait() do
        if autoReload and getWeapon(LocalPlayer) then
            local Weapon = getWeapon(LocalPlayer)
            WeaponReloadRequest:FireServer(Weapon)
        end
    end
end)()

game:GetService("UserInputService").InputBegan:Connect(function(Key, GPE)
    if not GPE then
        if Key.KeyCode == Enum.KeyCode.F1 then
            killAll()
            print("Killed All!")
        elseif Key.KeyCode == Enum.KeyCode.F2 then
            autoReload = not autoReload
            print('Toggle - Auto Reload -', autoReload)
        elseif Key.KeyCode == Enum.KeyCode.F3 then
            ValiantAimHacks["SilentAimEnabled"] = not ValiantAimHacks["SilentAimEnabled"]
            print('Toggle - Silent Aim -', ValiantAimHacks["SilentAimEnabled"])
        elseif Key.KeyCode == Enum.KeyCode.F4 then
            PlayerESP["Enabled"] = not PlayerESP["Enabled"]
            print('Toggle - Player ESP -', PlayerESP["Enabled"])
        end
    end
end)

-- // Gun Mods
doGunMods()
LocalPlayer.CharacterAdded:Connect(doGunMods)