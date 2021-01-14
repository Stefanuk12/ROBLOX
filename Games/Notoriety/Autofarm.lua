-- // Services
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

-- // Vars
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local RSPackage = ReplicatedStorage.RS_Package
local Remotes = RSPackage.Remotes
local RemotesB = RSPackage.Assets.Remotes
local InteractList = require(RSPackage.ReplicatedScripts.InteractList)()
local RemoteKey

-- // Make sure we are in game
if (not Workspace:FindFirstChild("Lootables")) then
    return
end

-- // Wait until loaded in
repeat wait() until (Character and Character.Parent == Workspace.Criminals)

-- // Get Remote Key
do
    local gGC = getgc()
    for i = 1, #gGC do
        local v = gGC[i]
        if (debug.getinfo(v).name == "shoot") then
            RemoteKey = debug.getupvalue(v, 21)
            break
        end
    end
end

-- // TP Bypass + Godmode
local tpGod = function(Character)
    -- // Put Mask on
    RemotesB.MaskOn:FireServer()

    if (Character:FindFirstChild("Health")) then
        Character.Health:Destroy()
    end
    if (Character:FindFirstChild("Detection")) then
        Character.Detection:Destroy()
    end

    Character.ChildAdded:Connect(function(child)
        if (child.Name == "Health" or child.Name == "Detection") then
            Character:WaitForChild(child.Name):Destroy()
        end
    end)
end
tpGod(LocalPlayer.Character)
LocalPlayer.CharacterAdded:Connect(tpGod)

-- // Interact
local Interact = function(Item, waitTime, customName)
    Remotes.StartInteraction:FireServer(Item)
    wait(waitTime or InteractList[customName or Item.Name].timer)
    Remotes.CompleteInteraction:FireServer(Item)
end

-- // Hit Function
local HitObject = function(Part)
    RemotesB.HitObject:FireServer(RemoteKey, Part, false, nil, nil, Part.CFrame.lookVector * 56)
end

-- // Answer Pager
local answerPager = function(tpBack, breakAtX)
    local allBodies = Workspace.Bodies:GetChildren()
    local saved = Character.HumanoidRootPart.CFrame

    for i = 1, #allBodies do
        local body = allBodies[i]

        if (body.Name == "Pager") then
            Character.HumanoidRootPart.CFrame = body.HumanoidRootPart.CFrame
            Interact(body, nil, "Pager")
        end

        if (breakAtX and i >= breakAtX) then
            break
        end
    end

    if (tpBack) then
        Character.HumanoidRootPart.CFrame = saved
    end
end

-- // Kill Security
local killSecurity = function(tpBack, answerPage)
    -- // Vars
    local targetGuard
    local saved = Character.HumanoidRootPart.CFrame

    -- // Get Target Guard
    do
        local allGuards = Workspace.Police:GetChildren()
        for i = 1, #allGuards do
            local guard = allGuards[i]

            if (guard:FindFirstChild("Security")) then
                targetGuard = guard
                wait(0.1)
            end
        end
    end

    -- // Check if a guard exists
    if (targetGuard and targetGuard.Humanoid.Health > 0) then
        -- // Answer Pager
        local Connection
        Connection = Workspace.Bodies.ChildAdded:Connect(function(child)
            if ((child.Name == "Guard" or child.Name == "Pager") and answerPage) then
                wait(0.1)
                Character.HumanoidRootPart.CFrame = child.HumanoidRootPart.CFrame
                Interact(child, nil, "Pager")
                answerPage = false
                Connection:Disconnect()
            end
        end)

        -- // Melee the guard until he is dead
        Character.HumanoidRootPart.CFrame = targetGuard.HumanoidRootPart.CFrame
        repeat wait()
            RemotesB.MeleeDamage:FireServer(targetGuard, 999, 100)
        until (not targetGuard or (targetGuard and targetGuard.Humanoid.Health < 1))
        repeat wait() until (not answerPage)
    else
        -- // Disable camera
        local allCameras = Workspace.Cameras:GetChildren()
        for i = 1, #allCameras do
            local camera = allCameras[i]
            if (camera:FindFirstChild("CamPart")) then
                Character.HumanoidRootPart.CFrame = camera.CamPart.CFrame
                wait(0.25)
                HitObject(camera.CamPart)
            end
        end
    end

    -- // Teleport back
    if (tpBack) then
        Character.HumanoidRootPart.CFrame = saved
    end
end

-- // Get Item
local getItem = function(Item, tpBack)
    -- // Vars
    local saved = Character.HumanoidRootPart.CFrame

    -- // Get
    local function get(_Item)
        -- // Handling
        if (_Item.Name == "OpenedRegister") then return end

        -- // Vars
        local doTeleport = true

        -- // Teleporting
        coroutine.wrap(function()
            while (doTeleport) do
                wait()
                Character.HumanoidRootPart.CFrame = _Item.PrimaryPart.CFrame - Vector3.new(0, 4, 0)
            end
        end)()

        -- // Interacting
        Interact(_Item)
        doTeleport = false
    end

    -- // Handling
    if (Item.Name == "JewelSpot") then
        repeat
            local allJewels = Item:GetChildren()
            for i = 1, #allJewels do
                local jewel = allJewels[i]

                if (jewel.PrimaryPart) then
                    get(jewel)
                end
            end
        until #Item:GetChildren() <= 1
    else
        get(Item)
    end

    -- // Teleporting back
    if (tpBack) then
        Character.HumanoidRootPart.CFrame = saved
    end
end

-- // Drop off bags in van
local dropOffBags = function(tpBack)
    -- // Vars
    local saved = Character.HumanoidRootPart.CFrame
    if (not Workspace:FindFirstChild("BagSecuredArea")) then return end
    local EscapeVan = Workspace.BagSecuredArea.EscapeVan

    -- // Teleporting to van and dropping
    print(EscapeVan.PrimaryPart.CFrame)
    LocalPlayer.Character.HumanoidRootPart.CFrame = EscapeVan[EscapeVan.PrimaryPart.Name].CFrame + Vector3.new(0, 1, 0)
    wait(0.5)
    Remotes.ThrowBag:FireServer(Vector3.new())

    -- // Teleporting back
    if (tpBack) then
        Character.HumanoidRootPart.CFrame = saved
    end
end

-- // Kill Security / Remove cameras
local saved = Character.HumanoidRootPart.CFrame
killSecurity(false, true)

-- // Get All Lootables
repeat
    local allLootables = Workspace.Lootables:GetChildren()
    for k = 1, #allLootables do
        local lootable = allLootables[k]

        getItem(lootable)
    end
until #Workspace.Lootables:GetChildren() < 3

-- // Get All Big Loot
if (Workspace:FindFirstChild("BigLoot")) then
    local allBigLoot = Workspace.BigLoot:GetChildren()
    for i = 1, #allBigLoot do
        local bigLoot = allBigLoot[i]

        getItem(bigLoot)
    end
end

-- // Break All Glass
local breakAllGlass = function()
    local allGlass = Workspace.Glass:GetChildren()
    for i = 1, #allGlass do
        local glass = allGlass[i]
        HitObject(glass)
    end
end

-- // Dropping bags off
wait(0.5)
dropOffBags()
wait(1)
Character.HumanoidRootPart.CFrame = saved