-- // Services
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- // Vars
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local RSPackage = ReplicatedStorage.RS_Package
local Remotes = RSPackage.Remotes
local RemotesB = RSPackage.Assets.Remotes
local InteractList = require(RSPackage.ReplicatedScripts.InteractList)()

-- // Make sure we are in game
if (not Workspace:FindFirstChild("Lootables")) then
    return
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
local Interact = function(Item, waitTime)
    Remotes.StartInteraction:FireServer(Item)
    wait(waitTime or InteractList[Item.Name].timer)
    Remotes.CompleteInteraction:FireServer(Item)
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
                Character.HumanoidRootPart.CFrame = _Item.PrimaryPart.CFrame
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
    local EscapeVan = Workspace.BagSecuredArea.EscapeVan

    -- // Teleporting to van and dropping
    print(EscapeVan.PrimaryPart.CFrame)
    LocalPlayer.Character.HumanoidRootPart.CFrame = EscapeVan[EscapeVan.PrimaryPart.Name].CFrame
    wait(0.5)
    Remotes.ThrowBag:FireServer(Vector3.new())

    -- // Teleporting back
    if (tpBack) then
        Character.HumanoidRootPart.CFrame = saved
    end
end

-- // Get All Lootables
local saved = Character.HumanoidRootPart.CFrame
for i = 1, 3 do
    local allLootables = Workspace.Lootables:GetChildren()
    for i = 1, #allLootables do
        local lootable = allLootables[i]

        getItem(lootable)
    end
end

-- // Get All Big Loot
if (Workspace:FindFirstChild("BigLoot")) then
    local allBigLoot = Workspace.BigLoot:GetChildren()
    for i = 1, #allBigLoot do
        local bigLoot = allBigLoot[i]

        getItem(bigLoot)
    end
end

-- // Dropping bags off
dropOffBags()
wait(0.5)

Character.HumanoidRootPart.CFrame = saved