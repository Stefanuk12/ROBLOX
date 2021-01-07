-- // Game: https://roblox.com/games/2788229376/

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

-- // Silent Aim Vars
local AimHacks = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Experimental%20Silent%20Aim%20Module.lua"))()

-- // Da Hood Protections
local function removeRagdolls()
    for i,v in pairs(Character:WaitForChild("RagdollConstraints"):GetChildren()) do
        v.Enabled = false
    end
end

local function protections()
    -- // Anti Fall/Ragdoll
    Humanoid:SetStateEnabled(Enum.HumnaoidStateType.FallingDown, false)
    Humanoid:SetStateEnabled(Enum.HumnaoidStateType.Ragdoll, false)
    Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None -- Hide your name

    for i,v in pairs(Character:GetDescendants()) do
        if v:IsA("Accessory") or (v:IsA("Decal") and v.Name == 'face') then
            v:Destroy()
        elseif v:IsA("MeshPart") then
            v.Color = Color3.fromRGB(255, 255, 255)
        end
    end

    removeRagdolls()
    Character:WaitForChild("BodyEffects").Movement.DescendantAdded:Connect(function(descendant)
        wait()
        descendant:Destroy()
    end)
end

function toggleSeats(state)
    for i,v in pairs(Workspace:GetDescendants()) do
        if v:IsA("Seat") then
            v.Disabled = state
        end
    end
end

-- // Anti Fly Bypass
coroutine.wrap(function()
    while wait(0.1) do
        if getgenv().BypassFlyDaHood then
            for i,v in ipairs(getgc()) do 
                if (debug.getinfo(v).name == 'crash') then
                    getfenv(v).script:Destroy()
                end
            end
        end
	end
end)()

-- // Toggle Anti Fly Bypass
game:GetService("UserInputService").InputBegan:connect(function(inputObject, gameProcessedEvent)
    if inputObject.KeyCode == Enum.KeyCode.F7 then
        getgenv().BypassFlyDaHood = not getgenv().BypassFlyDaHood
        print("Bypass TP Status: "..(getgenv().BypassFlyDaHood and "Enabled" or "Disabled"))
    end 
end)

-- // Teleport
function Teleport(_CFrame, Status)
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
    if Status then
        for i = 0, 1, 0.1 do
            HumanoidRootPart.CFrame = HumanoidRootPart.CFrame:lerp(_CFrame, i)
            wait()
        end
    else
        HumanoidRootPart.CFrame = _CFrame
    end
end

-- // Metatable Stuff: Silent Aim + Bypass other protections
mt.__namecall = newcclosure(function(...)
    local method = getnamecallmethod()
    local args = {...}
    if method == "FireServer" then
        local remoteName = tostring(args[1])
        if remoteName == "MainEvent" then
            if args[2] == "TeleportDetect" or args[2] == 'TeleportDetect' or args[2] == 'CHECKER' or args[2] == 'OneMoreTime' then
                return nil
            end
            if args[2] == "MouseUpdatedPos" and typeof(args[3]) == "Vector3" and AimHacks.checkSilentAim() then
                return AimHacks["Selected"].Character.Head.Position
            end
        end
    end
    
    return backupnamecall(...)
end)

mt.__index = newcclosure(function(t, k)
    if t == Mouse and (k == "Target" or k == "Hit") and AimHacks.checkSilentAim() then
        local CPlayer = AimHacks["Selected"].Character.Head
        return (k == "Target" and CPlayer or CPlayer.Position)
    end
    return backupindex(t, k)
end)

-- // Script
local Cashiers = Workspace:WaitForChild("Cashiers")
local Drop = Workspace.Ignored:FindFirstChild("Drop")
local ItemDrops = Workspace.Ignored:FindFirstChild("ItemsDrop")

function collectMoney(Nearby, TPBack)
    local SavedCFrame = HumanoidRootPart.CFrame
    for i,v in pairs(Drop:GetDescendants()) do
        if v:IsA("ClickDetecter") and v.Parent.Name == "MoneyDrop" then
            if Nearby then
                if LocalPlayer:DistanceFromCharacter(v.Parent.Position) < 20 then
                    Teleport(v.Parent.CFrame, false)
                    wait(0.2)
                    fireclickdetector(v, 0)
                    wait(0.2)
                end
            else
                Teleport(v.Parent.CFrame, false)
                wait(1)
                fireclickdetector(v, 0)
                wait(2)
            end
        end
    end
    if TPBack then
        wait(1)
        Teleport(SavedCFrame, true)
    end
end

function collectShoes()
    local SavedCFrame = HumanoidRootPart.CFrame
    for i,v in pairs(Drop:GetDescendants()) do
        if v:IsA("ClickDetector") and v.Parent.Name == "MeshPart" then
            Teleport(v.Parent.CFrame, false)
            wait(1)
            fireclickdetector(v, 0)
            wait(2)
        end
    end
    wait(1)
    Teleport(SavedCFrame, true)
end

function collectTools()
    local SavedCFrame = HumanoidRootPart.CFrame
    for i,v in pairs(ItemDrops:GetDescendants()) do
        if v:IsA("Tool") then
            for a,x in pairs(v:GetDescendants()) do
                if x:IsA("TouchTransmitter") then
                    Teleport(v.Parent.CFrame, false)
                end
            end
        end
    end
    wait(1)
    Teleport(SavedCFrame, true)
end

function collectCashiers()
    removeRagdolls()
    local SavedCFrame = HumanoidRootPart.CFrame
    for i,v in next, Workspace:WaitForChild("Cashiers"):GetChildren() do
        if v:FindFirstChildWhichIsA("Humanoid").Health > 0 then
            local targetCFrame = lootPositions[tostring(i)]
            Teleport(targetCFrame, false)
            if Backpack:FindFirstChild("Combat") then Humanoid:EquipTool(Backpack.Combat) end
            repeat VirtualUser:ClickButton1(Vector2.new()) wait() until v.Humanoid.Health <= 0
            for i = 1, 3 do
                collectMoney(true)
                HumanoidRootPart.CFrame = targetCFrame
                wait(1)
            end
        end
    end
    wait(1)
    Teleport(SavedCFrame, true)
end

protections()
LocalPlayer.CharacterAdded:Connect(protections())