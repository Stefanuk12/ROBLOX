-- // Initialise
if (getgenv().NotorietyAPI) then return getgenv().NotorietyAPI end
getgenv().NotorietyAPI = {
    RemoteKey = ""
}

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

-- // Get Remote Key
NotorietyAPI.getRemoteKey = function()
    local gGC = getgc()
    for i = 1, #gGC do
        local v = gGC[i]
        if (debug.getinfo(v).name == "shoot") then
            NotorietyAPI.RemoteKey = debug.getupvalue(v, 21)
            break
        end
    end

    return NotorietyAPI.RemoteKey
end
NotorietyAPI.getRemoteKey()

-- // Teleport Bypass
NotorietyAPI.antiBypass = function(Character, removeConnection)
    local Connection
    RunService.Heartbeat:Connect(function()
        if (not Character and removeConnection) then
            Connection:Disconnect()
        end

        local characterChildren = LocalPlayer.Character:GetChildren()
        for i = 1, #characterChildren do
            local child = characterChildren[i]

            if (child and child.Name == "Health" or child.Name == "Detection") then
                child:Destroy()
            end
        end
    end)
end

-- // Interact
NotorietyAPI.Interact = function(Item, waitTime, customName)
    Remotes.StartInteraction:FireServer(Item)
    wait(waitTime or InteractList[customName or Item.Name].timer)
    Remotes.CompleteInteraction:FireServer(Item)
end

-- // Hit Function
NotorietyAPI.HitObject = function(Part)
    RemotesB.HitObject:FireServer(NotorietyAPI.RemoteKey, Part, false, nil, nil, Part.CFrame.lookVector * 56)
end

-- // Low Detection (simulates as if you have no mask)
NotorietyAPI.LowDetection = function(Character)
    local Mask = Character:FindFirstChild("Mask ON")
    if (Mask) then
        local MaskClone = Mask:Clone()
        MaskClone.Parent = Character
        Mask:Destroy()
    end
end

-- // Answer Pager
NotorietyAPI.answerPager = function(tpBack, breakAtX)
    local allBodies = Workspace.Bodies:GetChildren()
    local saved = Character.HumanoidRootPart.CFrame

    for i = 1, #allBodies do
        local body = allBodies[i]

        if (body.Name == "Pager") then
            Character.HumanoidRootPart.CFrame = body.HumanoidRootPart.CFrame
            NotorietyAPI.Interact(body, nil, "Pager")
        end

        if (breakAtX and i >= breakAtX) then
            break
        end
    end

    if (tpBack) then
        Character.HumanoidRootPart.CFrame = saved
    end
end

NotorietyAPI.killSecurity = function(tpBack, answerPage)
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
                NotorietyAPI.Interact(child, nil, "Pager")
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
                NotorietyAPI.HitObject(camera.CamPart)
            end
        end
    end

    -- // Teleport back
    if (tpBack) then
        Character.HumanoidRootPart.CFrame = saved
    end
end

-- // Get Item
NotorietyAPI.getItem = function(Item, tpBack)
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
                Character.HumanoidRootPart.CFrame = _Item.PrimaryPart.CFrame
            end
        end)()

        -- // Interacting
        NotorietyAPI.Interact(_Item)
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
NotorietyAPI.dropOffBags = function(tpBack)
    -- // Vars
    local saved = Character.HumanoidRootPart.CFrame
    local EscapeVan = Workspace.BagSecuredArea.EscapeVan

    -- // Teleporting to van and dropping
    LocalPlayer.Character.HumanoidRootPart.CFrame = EscapeVan[EscapeVan.PrimaryPart.Name].CFrame + Vector3.new(0, 1, 0)
    wait(0.5)
    Remotes.ThrowBag:FireServer(Vector3.new())

    -- // Teleporting back
    if (tpBack) then
        Character.HumanoidRootPart.CFrame = saved
    end
end

-- // Get Loot Bag Amount
NotorietyAPI.lootBagAmount = function()
    local missionEquipment = LocalPlayer.PlayerGui.SG_Package.MainGui.PlayerStats.LocalPlayerStats.info_items.MissionEquipment
    local lootBag = missionEquipment:FindFirstChild("Loot Bag")

    if (lootBag) then
        local amount = lootBag.txtamt.Text

        return (amount == "" and 1 or tonumber(amount))
    else
        return 0
    end
end

-- // Get Lootables
NotorietyAPI.getLootables = function(bagAmount)
    if (not Workspace:FindFirstChild("Lootables")) then return end

    local allLootables = Workspace.Lootables:GetChildren()
    for k = 1, #allLootables do
        local lootable = allLootables[k]

        -- // Stop at when you have x amount of bags
        if (bagAmount and NotorietyAPI.lootBagAmount() >= bagAmount) then return end

        -- // Get Item
        NotorietyAPI.getItem(lootable)
    end
end

-- // Get Big Loot
NotorietyAPI.getBigLoot = function(bagAmount)
    if (not Workspace:FindFirstChild("BigLoot")) then return end

    local allBigLoot = Workspace.BigLoot:GetChildren()
    for i = 1, #allBigLoot do
        local bigLoot = allBigLoot[i]
        
        -- // Stop at when you have x amount of bags
        if (bagAmount and NotorietyAPI.lootBagAmount() >= bagAmount) then return end

        -- // Get Item
        NotorietyAPI.getItem(bigLoot)
    end
end

-- // Break All Glass
NotorietyAPI.breakAllGlass = function()
    if (not Workspace:FindFirstChild("Glass")) then return end

    local allGlass = Workspace.Glass:GetChildren()
    for i = 1, #allGlass do
        local glass = allGlass[i]
        NotorietyAPI.HitObject(glass)
    end
end