-- // Valiant ENV
loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/ValiantENV.lua"))()

-- // Vars
local RenderStepped = RunService.RenderStepped
local Heartbeat = RunService.Heartbeat
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded.Wait(LocalPlayer.CharacterAdded)
local Humanoid = Character.WaitForChild(Character, "Humanoid")
local HumnaoidRootPart = Character.WaitForChild(Character, "HumanoidRootPart")
local Backpack = LocalPlayer.Backpack
local CurrentCamera = Workspace.CurrentCamera
local Mouse = LocalPlayer.GetMouse(LocalPlayer)
local GetCameraAim = ReplicatedStorage.Modules.Client["Get_Camera_Aim"]
local backupweapons = ReplicatedStorage.Weapons.Clone(ReplicatedStorage.Weapons)
getgenv().DDayHax = {}
if not DDayHax.WeaponSpoof then 
    DDayHax.BackupWeapons = ReplicatedStorage.Weapons.Clone(ReplicatedStorage.Weapons)
    if not DDayHax.WeaponSpoof then
        mt.__namecall = newcclosure(function(...)
            local method = getnamecallmethod()
            local args = {...}
            if method == "FireServer" and tostring(args[1]) == "Attempt_Fire" then
                local req = require(DDayHax.BackupWeapons[args[2].Name]["Setting"])
                args[9] = req["AmmoPerClip"] 
                args[10] = req["AmmoPerClip"] 
                args[11] = req["FireRate"] 
                return backupnamecall(unpack(args))
            end
            
            return backupnamecall(...)
        end)
        DDayHax.WeaponSpoof = true
    end
end
DDayHax.SpoofValuesForWeapon = {
    ReloadTime = 0,
    Spread = 0,
    ReloadTime = 0,
    AmmoPerClip = 250,
    RecoilOuter = -0.4,
    RecoilInner = 0.2,
    RecoilSprint = -1.6,
}


-- // Base MT Vars + Funs
local mt = getrawmetatable(game)
local backupnamecall = mt.__namecall
local backupnewindex = mt.__newindex
local backupindex = mt.__index 
setreadonly(mt, false)


for i,v in pairs(ReplicatedStorage.Weapons:GetDescendants()) do
    if v:IsA("ModuleScript") then
        local req = require(v)
        for a,x in pairs(DDayHax.SpoofValuesForWeapon) do
            if req[a] then
                req[a] = x
                print(req[a].." = "..x)
            end
        end
    end
end