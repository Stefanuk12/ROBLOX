-- Game: https://www.roblox.com/games/5111155861

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
local changeVals = {
    BulletSpread = 0,
    MaxSpread = 0,
    ChargeRate = math.huge,
    MaxDistance = math.huge,
    RecoilMin = 0,
    RecoilMax = 0,
    AmmoCapacity = 100,
    CurrentAmmo = 100,
    TotalRecoilMax = 0,
    GravityFactor = 0.01,
    ShotCooldown = 0,
    FireMode = "Automatic"
}
local GunModTable = {}
local WeaponsSystem = ReplicatedStorage.WeaponsSystem
local Libraries = WeaponsSystem.Libraries
local WeaponTypes = WeaponsSystem.WeaponTypes
local BulletWeapon = WeaponTypes.BulletWeapon
local BaseWeapon = Libraries.BaseWeapon

-- // Base MT Vars + Funs
local mt = getrawmetatable(game)
local backupnamecall = mt.__namecall
local backupnewindex = mt.__newindex
local backupindex = mt.__index 
setreadonly(mt, false)

function doGunMods()
    for _, Obj in pairs(getgc(true)) do
        if type(Obj) == "table" then
            for i,v in pairs(changeVals) do
                if rawget(Obj, i) then
                    rawset(Obj, i, v)
                end
            end
        end
    end
end

doGunMods()
LocalPlayer.CharacterAdded:Connect(function()
    wait(1)
    doGunMods()
end)
