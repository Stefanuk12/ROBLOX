-- Game: https://roblox.com/games/4623386862
--[[
    Bugs:
        1. Teleport don't actually teleport you
    
    Note: 
        1. Not finished yet!

    Things to add:
        1. Autofarm!
    
]]

if getgenv().PiggyHax then return getgenv().PiggyHax end
warn("PiggyHax Module Loading...")

-- // Valiant ENV
loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/ValiantENV.lua"))()

-- // Vars
local UserInputService = game.GetService(game, "UserInputService")
local RenderStepped = RunService.RenderStepped
local Stepped = RunService.Stepped
local Heartbeat = RunService.Heartbeat
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded.Wait(LocalPlayer.CharacterAdded)
local Humanoid = Character.WaitForChild(Character, "Humanoid")
local CurrentCamera = Workspace.CurrentCamera
local Mouse = LocalPlayer.GetMouse(LocalPlayer)
local ItemFolder = Workspace:FindFirstChild("ItemFolder")
local GameFolder = Workspace:FindFirstChild("GameFolder")

getgenv().PiggyHax = {
    AntiTrap = true,
    AutoFarm = false,
    SpammingEscape = false,
    InfiniteJump = false,
    Noclip = false,
    KillAllInProgress = false,
    WalkSpeed = 50,
    JumpPower = 50,
    PlayerESP = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Player%20ESP.lua"))()
}

-- // Base MT Vars + Funs
local mt = getrawmetatable(game)
local backupnamecall = mt.__namecall
local backupnewindex = mt.__newindex
local backupindex = mt.__index 
setreadonly(mt, false)

-- // Anti Obfuscation
LocalPlayer.PlayerGui.GameGUI.ChildAdded:Connect(function(child)
    wait()
    if child.Name == "Crouch" and child:FindFirstChild("DoorScript") then
        child.DoorScript:Destroy()
        print('Avoided Obfuscation!')
    end
end)
print('Initialised Anti Item Obfuscation')

-- // Functions
function noRagFall()
    Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
    Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
end

function PiggyHax.teleport(targetCFrame)
    Character.PrimaryPart.CFrame = targetCFrame
    print('Teleported!')
end

function PiggyHax.inGame()
    return GameFolder.Phase == "GameInProgress"
end

function PiggyHax.returnItem(ItemName)
    for _,v in pairs(ItemFolder:GetChildren()) do
        if string.lower(v.Name) == string.lower(ItemName) then
            return v
        end
    end
end

function PiggyHax.returnAllItems()
    return ItemFolder:GetChildren()
end

function PiggyHax.retriveItem(ItemName)
    if PiggyHax.returnItem(ItemName) then
        local Item = PiggyHax.returnItem(ItemName)
        local SavedPos = Character.PrimaryPart.CFrame
        function getItem()
            PiggyHax.teleport(Item.CFrame)
            wait(0.25)
            fireclickdetector(Item:FindFirstChildWhichIsA("ClickDetector"), 0)
            wait(0.25)
            PiggyHax.teleport(SavedPos)
            wait(0.25)
        end
        getItem()
        print('Got Item!')
    end
end

function PiggyHax.returnMap()
    for _,v in pairs(Workspace:GetChildren()) do
        if v:IsA("Model") and v:FindFirstChild("Events") then
            return v 
        end
    end
end

function PiggyHax.returnEnemies()
    local Enemies = {}
    for _,plr in pairs(Players:GetPlayers()) do
        if plr.Character and (plr.Character:FindFirstChild("Enemy") and plr.Character.Enemy.Value) or (plr.Character:FindFirstChild("Traitor") and plr.Character.Traitor.Value) then
            table.insert(Enemies, plr)
        end
    end
    return Enemies
end

function PiggyHax.localPlayerPiggy()
    for _,plr in pairs(PiggyHax.returnEnemies()) do
        if plr == LocalPlayer then
            return true
        end
    end
    return false
end

function PiggyHax.killAll()
    if not PiggyHax.KillAllInProgress and PiggyHax.inGame() and PiggyHax.localPlayerPiggy() then
        PiggyHax.KillAllInProgress = true
        local nonKilled = Players:GetPlayers()
        local Connection = Players.PlayerAdded:Connect(function(player)
            if PiggyHax.KillAllInProgress then
                table.insert(nonKilled, player)
            end
        end)
        for i,plr in pairs(nonKilled) do
            repeat
                if plr and plr.Character and plr.Character.Humanoid.Health < 1 then
                    if not firetouchinterest then PiggyHax.teleport(plr.Character.PrimaryPart.CFrame) end
                    if firetouchinterest then firetouchinterest(Character.PrimaryPart, plr.Character.PrimaryPart, 0) firetouchinterest(Character.PrimaryPart, plr.Character.PrimaryPart, 1) end
                end
            until not plr or plr.Character or plr.Character.Humanoid.Health < 1
            table.remove(nonKilled, i)
        end
        PiggyHax.KillAllInProgress = false
        Connection:Disconnect()
    end
end


function PiggyHax.destroyAllHazards()
    if PiggyHax.inGame() then
        for _,v in pairs(ItemFolder:GetDescendants()) do
            if v:IsA("TouchTransmitter") then
                v:Destroy()
            end
        end
        for _,v in pairs(PiggyHax.returnMap().Events:GetChildren()) do
            if (v.Name == "LaserGate" and v:FindFirstChild("LaserTrigger")) or (v.Name == "SecuritySystem" and v:FindFirstChild("AlarmScanner")) then
                v.LaserTrigger:Destroy()
            end
        end
    end
end

function PiggyHax.RemoveBots()
    if inGame() then
        for _,v in pairs(Workspace.PeppaNPC:GetDescendants()) do
            if v:IsA("TouchTransmitter") then
                v:Destroy()
            end
        end
    end
end

-- // Anti Trap
ItemFolder.ChildAdded:Connect(function(child)
    wait()
    if string.match(child.Name, "Trap") and PiggyHax.AntiTrap and not PiggyHax.localPlayerPiggy() then
        child:Destroy()
    end
end)

-- // Coroutines
coroutine.wrap(function()
    while wait() do
        if PiggyHax.SpammingEscape and PiggyHax.inGame() and not PiggyHax.localPlayerPiggy() then
            PiggyHax.teleport(PiggyHax.returnMap().Events.EscapeTrigger.CFrame)
        end
    end
end)()

-- // WalkSpeed + JumpPower
Humanoid.WalkSpeed = PiggyHax["WalkSpeed"]
Humanoid.JumpPower = PiggyHax["JumpPower"]
mt.__newindex = newcclosure(function(t, k, v)
    if not checkcaller() and i == "WalkSpeed" or i == "JumpPower" then
        return backupnewindex(t, i, PiggyHax[i])
    end
    return backupnewindex(t, k, v)
end)

-- // Anti Fall + Ragdoll
LocalPlayer.CharacterAdded:Connect(noRagFall)

-- // Infinite Jump
UserInputService.JumpRequest:Connect(function()
    if PiggyHax.InfiniteJump then Character:ChangeState("Jumping") end
end)

-- // Noclip
Stepped:Connect(function()
    if PiggyHax.Noclip then 
        for _,v in pairs(Character:GetDescendants()) do
            if v:IsA("BasePart") and v.CanCollide then
                v.CanCollide = false
            end
        end
    end
end)

warn("PiggyHax Module Loaded!")