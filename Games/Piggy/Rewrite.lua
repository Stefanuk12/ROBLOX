-- Game: https://roblox.com/games/4623386862
--[[
    Bugs:
        1. Spam Escape does not work.
    
    Note: 
        1. Not finished yet!
        2. Some maps need special handling that I have not added yet, due to them requiring to do certain things before you can get the item, auto farm, etc.
        3. Kill All Hazards may not have all of the hazards indexed!
        4. I may or may not add Auto Farm, probably not.

    Things to add:

    Feature List:
        (Things listed with * are not working or not implemented yet fully)

        1. Avoid the Item Obfuscation
        2. Get a certain item
        3. Auto Use Item - For example, uses the hammer on the main door automatically*
        4. Remove All Hazards*
        5. Kill Enemy Bots*
        6. Spam Escape*
        8. Noclip
        9. Infinite Jump
        10. Player ESP
        11. WalkSpeed + JumpPower
        12. Kill All Players (As Piggy or Traitor)
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
local NotificationHandler = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Notifications/Script.lua"))()

getgenv().PiggyHax = {
    Notifications = true,
    AntiTrap = true,
    SpammingEscape = false,
    InfiniteJump = false,
    Noclip = false,
    KillAllInProgress = false,
    WalkSpeed = 50,
    JumpPower = 50,
    PlayerESP = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/ESP/Player%20ESP.lua"))(),
    autoDoItemMapsOrder = {
        Forest = {"Wrench"}
    },
    Binds = {toggleNoclip = Enum.KeyCode.F4}
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
noRagFall()

function PiggyHax.teleport(targetCFrame)
    if targetCFrame and typeof(targetCFrame) == 'CFrame' and Character and Character:FindFirstChild("HumanoidRootPart") then
        Character.HumanoidRootPart.CFrame = targetCFrame
        print('Teleported!')
    end
end

function PiggyHax.inGame()
    return GameFolder.Phase == "GameInProgress"
end

function PiggyHax.returnMap()
    for _,v in pairs(Workspace:GetChildren()) do
        if v:IsA("Model") and v:FindFirstChild("Events") then
            return v 
        end
    end
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

function PiggyHax.autoDoItem(ItemName) -- // Basically goes to where the item belongs so the White Key goes to the Main Door and the Key Code goes to the Key Pad, etc.
    if ItemName and typeof(ItemName) == 'string' and PiggyHax.inGame() and PiggyHax.returnMap() and Character:FindFirstChild(ItemName) then
        local Map = PiggyHax.returnMap()
        for _,v in pairs(Map.Events:GetDescendants()) do
            local SpecialHandlingDone = false
            for a,x in pairs(PiggyHax.autoDoItemMaps) do
                if tostring(Map) == a and ItemName == x then
                    -- Special Handling Here
                    SpecialHandlingDone = true
                    break
                end
            end
            if SpecialHandlingDone then break end
            if v.Name == "ToolRequired" and v.Value == ItemName then
                PiggyHax.teleport(v.Parent.CFrame)
                local Handle = Character:FindFirstChild(ItemName).Handle
                for i = 1, 10 do
                    Humanoid.Jump = true
                    firetouchinterest(Handle, v.Parent, 0)
                    wait(0.1)
                    firetouchinterest(Handle, v.Parent, 1)
                    Humanoid.Jump = false
                end
                break
            end
        end
    end
end

function PiggyHax.retriveItem(ItemName, GoTo)
    if PiggyHax.returnItem(ItemName) then
        local Item = PiggyHax.returnItem(ItemName)
        local SavedPos = Character.PrimaryPart.CFrame
        function getItem()
            PiggyHax.teleport(Item.CFrame); wait(0.25)
            Item:FindFirstChildWhichIsA("ClickDetector").MaxActivationDistance = 15; wait(0.25)
            Item.Transparency = 0; wait(0.25)
            fireclickdetector(Item:FindFirstChildWhichIsA("ClickDetector"), 0); wait(0.5)
            if not GoTo then PiggyHax.teleport(SavedPos); wait(0.25) else PiggyHax.autoDoItem(ItemName) end
        end
        getItem()
        Humanoid:EquipTool(LocalPlayer.Backpack:FindFirstChild(ItemName))
        wait(0.1)
        if Character:FindFirstChild(ItemName) then
            NotificationHandler.newNotification('SUCCESS', 'Got '..ItemName.."!", 'Success')
        else
            NotificationHandler.newNotification('ERROR', 'Unable to get '..ItemName.."!", 'Error')
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
        NotificationHandler.newNotification('SUCCESS', 'Killed All!', 'Success')
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
            if (v.Name == "LaserGate" and v:FindFirstChild("LaserTrigger")) or (v.Name == "SecuritySystem" and v:FindFirstChild("AlarmScanner")) or (v.Name == "FallTrigger") then
                v.LaserTrigger:Destroy()
            end
        end
        NotificationHandler.newNotification('SUCCESS', 'Removed all possible hazards!', 'Success')
    end
end

function PiggyHax.RemoveBots()
    if inGame() then
        for _,v in pairs(Workspace.PeppaNPC:GetDescendants()) do
            if v:IsA("TouchTransmitter") then
                v:Destroy()
            end
        end
        NotificationHandler.newNotification('SUCCESS', 'Removed Bots.', 'Success')
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
        if PiggyHax.SpammingEscape and PiggyHax.inGame() then
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

function PiggyHax.toggleNoclip()
    PiggyHax.Noclip = not PiggyHax.Noclip
    NotificationHandler.newNotification('SUCCESS', 'Toggle - Noclip: '..(PiggyHax.Noclip and "Enabled!" or "Disabled!"), 'Success')
    return PiggyHax.Noclip
end

-- // Bind Handling
UserInputService.InputBegan:Connect(function(Key, GPE)
    for cmd, bind in pairs(PiggyHax.Binds) do
        if not GPE and Key == bind then
            PiggyHax[cmd]()
        end
    end
end)
NotificationHandler.newNotification('SUCCESS', 'PiggyHax Module Loaded!', 'Success')
warn("PiggyHax Module Loaded!")