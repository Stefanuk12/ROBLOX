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
local autoReload = false
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
local ValiantAimHacks = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Experimental%20Silent%20Aim%20Module.lua"))()

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

doGunMods()
LocalPlayer.CharacterAdded:Connect(doGunMods)