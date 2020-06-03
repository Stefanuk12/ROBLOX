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
local MainEvent = game:GetService("ReplicatedStorage"):WaitForChild("MainEvent")
getgenv().BypassFlyDaHood = false

-- // Base MT Vars + Funs
local mt = getrawmetatable(game)
local backupnamecall = mt.__namecall
local backupnewindex = mt.__newindex
local backupindex = mt.__index 
setreadonly(mt, false)

-- // Anti Mine
for i,v in pairs(Workspace:GetDescendants()) do
    if v:IsA("TouchTransmitter") and (v.Parent.Name == "Static_Landmine" or v.Parent.Name == "Land Mine") then
        v:Destroy()
    end
end