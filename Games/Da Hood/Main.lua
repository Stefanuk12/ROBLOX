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
getgenv().AimHacks = {
    SilentAimEnabled = true,
    AimbotEnabled = false,
    ShowFOV = true,
    VisibleCheck = true,
    TeamCheck = true,
    FOV = 60,
    HitChance = 100,
    Selected = LocalPlayer,
    BlacklistedPlayers = {game:GetService("Players").LocalPlayer.Name},
}

-- // Show FOV
local circle = Drawing.new("Circle")
function updateCircle()
    if circle then
        circle.Transparency = 1
        circle.Visible = AimHacks["ShowFOV"]
        circle.Thickness = 2
        circle.Color = Color3.fromRGB(231, 84, 128)
        circle.NumSides = 12
        circle.Radius = (AimHacks["FOV"] * 6) / 2
        circle.Filled = false
        circle.Position = Vector2.new(Mouse.X, Mouse.Y + (GuiService.GetGuiInset(GuiService).Y))
    end
end

-- // Custom Functions
setreadonly(math, false); math.chance = function(percentage) local percentage = math.floor(percentage); local chance = math.floor(Random.new().NextNumber(Random.new(), 0, 1) * 100)/100; return chance <= percentage/100 end; setreadonly(math, true);
setreadonly(table, false); table.loopforeach = function(tbl, func) for index, value in pairs(tbl) do if type(value) == 'table' then table.loopforeach(value, func); elseif type(value) == 'function' then table.loopforeach(debug.getupvalues(value)); else func(index, value); end; end; end; setreadonly(table, true);

-- // Silent Aim Functions
function checkTable(Item, Table)
    local Passed = false
    if type(Item) ~= "string" then Item = tostring(Item) end
	for i,v in pairs(Table) do 
		if Table[i] then 
			Passed = true
		end
	end
	return Passed
end

local function getClosestPlayerToCursor()
    local ClosestPlayer = nil
    local Chance = math.chance(AimHacks["HitChance"])
    local ShortestDistance = math.huge
    if not Chance then AimHacks["Selected"] = (Chance and LocalPlayer or LocalPlayer) return (Chance and LocalPlayer or LocalPlayer) end
    local isPartVisible = function(Part, PartDescendant)
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
    for _,plr in pairs(Players.GetPlayers(Players)) do
        if plr ~= LocalPlayer and plr.Character and plr.Character.FindFirstChild(plr.Character, "Humanoid") and plr.Character.Humanoid.Health > 0 and not checkTable(plr.Name, AimHacks["BlacklistedPlayers"]) then
            if (AimHacks["TeamCheck"] and plr.Team ~= LocalPlayer.Team and not checkTable(tostring(plr.Team), AimHacks["BlacklistedTeams"])) then
                local PartPos, OnScreen = CurrentCamera.WorldToViewportPoint(CurrentCamera, plr.Character.PrimaryPart.Position)
                local Magnitude = (Vector2.new(PartPos.X, PartPos.Y) - Vector2.new(Mouse.X, Mouse.Y)).magnitude  
                if (Magnitude < (AimHacks["FOV"] * 6 - 8)) and (Magnitude < ShortestDistance) then
                    if AimHacks["VisibleCheck"] and isPartVisible(plr.Character.PrimaryPart, plr.Character) then
                        ClosestPlayer = plr
                        ShortestDistance = Magnitude
                    elseif not AimHacks["VisibleCheck"] then
                        ClosestPlayer = plr
                        ShortestDistance = Magnitude
                    end
                end
            else
                local PartPos, OnScreen = CurrentCamera.WorldToViewportPoint(CurrentCamera, plr.Character.PrimaryPart.Position)
                local Magnitude = (Vector2.new(PartPos.X, PartPos.Y) - Vector2.new(Mouse.X, Mouse.Y)).magnitude  
                if (Magnitude < (AimHacks["FOV"] * 6 - 8)) and (Magnitude < ShortestDistance) then
                    if AimHacks["VisibleCheck"] and isPartVisible(plr.Character.PrimaryPart, plr.Character) then
                        ClosestPlayer = plr
                        ShortestDistance = Magnitude
                    elseif not AimHacks["VisibleCheck"] then
                        ClosestPlayer = plr
                        ShortestDistance = Magnitude
                    end
                end
            end
        end
    end
    AimHacks["Selected"] = (Chance and ClosestPlayer or LocalPlayer)
    return (Chance and ClosestPlayer or LocalPlayer)
end

-- // Heartbeat Function
local function HBFuncs()
    updateCircle()
    getClosestPlayerToCursor()
end
Heartbeat.Connect(Heartbeat, HBFuncs)

-- // Da Hood Protections
local function removeAvatarItems()
    for i,v in pairs(Character:GetDescendants()) do
        if v:IsA("Accessory") or (v:IsA("Decal") and v.Name == 'face') then
            v:Destroy()
        elseif v:IsA("MeshPart") then
            v.Color = Color3.fromRGB(255, 255, 255)
        end
    end
end
   
local function removeAnimationSlowdowns()
    Character:WaitForChild("BodyEffects").Movement.DescendantAdded:Connect(function(descendant)
        wait()
        descendant:Destroy()
    end
end

local function removeRagdolls()
    for i,v in pairs(Character:WaitForChild("RagdollConstraints"):GetChildren()) do
        v.Enabled = false
    end
end

local function finaliseProtections()
    -- // Anti Fall/Ragdoll
    Humanoid:SetStateEnabled(Enum.HumnaoidStateType.FallingDown, false)
    Humanoid:SetStateEnabled(Enum.HumnaoidStateType.Ragdoll, false)
    Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None -- Hide your name

    removeAvatarItems()
    removeAnimationSlowdowns()
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
            if args[2] == "MouseUpdatedPos" and typeof(args[3]) == "Vector3" and AimHacks["SilentAimEnabled"] then
                return AimHacks["Selected"].Character.Head.Position
            end
        end
    end
    
    return backupnamecall(...)
end)

mt.__index = newcclosure(function(t, k)
    if t == Mouse then
        if k == "Hit" then
            return AimHacks["Selected"].Character.Head.CFrame
        elseif k == "Target" then
            return AimHacks["Selected"].Character.Head
        end
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

function connectProtectChar()
    finaliseProtections()
    LocalPlayer.CharacterAdded:Connect(finaliseProtections())
end

function connectRemoveRagdoll()
    removeRagdolls()
    LocalPlayer.CharacterAdded:Connect(removeRagdolls())
end