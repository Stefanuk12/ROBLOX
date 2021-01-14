-- // Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Notoriety/UILibrary.lua", true))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Notoriety/API.lua"))()
repeat wait() until NotorietyAPI

-- // Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- // Vars
local LocalPlayer = Players.LocalPlayer

-- // Remote Key Check
local checkRemoteKey = function()
    local remoteKey = NotorietyAPI.RemoteKey
    if (remoteKey == nil or remoteKey == "") then
        remoteKey = NotorietyAPI.getRemoteKey()

        if (remoteKey == nil or remoteKey == "") then
            error("Unable to get remote key, make sure you are loaded into the game!")
        end
    end
end

-- // TP Bypass
NotorietyAPI.antiBypass(LocalPlayer.Character)

-- // Player Tab
local Player = Library:CreateTab("Player", "Player Functions", true)

Player:CreateButton("Low Detection", function()
    NotorietyAPI.LowDetection(LocalPlayer.Character)
end)

-- // Tools Tab
local Tools = Library:CreateTab("Tools", "Some functions that can help you", true)

local ToolsTeleportBack = Tools:CreateToggle("Teleport Back")

Tools:CreateButton("Equip Mask", function()
    ReplicatedStorage.RS_Package.Assets.Remotes.MaskOn:FireServer()
end)
Tools:CreateButton("Kill Security", function()
    checkRemoteKey()
    NotorietyAPI.killSecurity(ToolsTeleportBack:Get(), true)
end)
Tools:CreateButton("Get Lootables", function()
    local saved = LocalPlayer.Character.HumanoidRootPart.CFrame
    NotorietyAPI.getLootables()
    if (ToolsTeleportBack:Get()) then
        LocalPlayer.Character.HumanoidRootPart.CFrame = saved
    end
end)
Tools:CreateButton("Get Big Loot", function()
    local saved = LocalPlayer.Character.HumanoidRootPart.CFrame
    NotorietyAPI.getBigLoot()
    if (ToolsTeleportBack:Get()) then
        LocalPlayer.Character.HumanoidRootPart.CFrame = saved
    end
end)
Tools:CreateButton("Break All Glass", function()
    checkRemoteKey()
    NotorietyAPI.breakAllGlass()
end)
Tools:CreateButton("Secure Bags", function()
    NotorietyAPI.dropOffBags(ToolsTeleportBack:Get())
end)

-- // Auto Farm Tab
local AutoFarm = Library:CreateTab("Auto Farm", "Manage and start the auto farm", true)

local AutoFarmKillSecurity = AutoFarm:CreateToggle("Disable Cameras")
local AutoFarmGetLootables = AutoFarm:CreateToggle("Get Lootables")
local AutoFarmGetBigLoot = AutoFarm:CreateToggle("Get Big Loot")
local AutoFarmBreakGlassAfter = AutoFarm:CreateToggle("Break Glass")
local AutoFarmDropBags = AutoFarm:CreateToggle("Secure Bags")

AutoFarm:CreateButton("Start", function()
    local start = function(Character)
        if (Character == LocalPlayer.Character) then
            ReplicatedStorage.RS_Package.Assets.Remotes.MaskOn:FireServer()
            
            repeat wait() until Character:FindFirstChild("Mask ON")
            NotorietyAPI.LowDetection(Character)
            checkRemoteKey()

            if (AutoFarmKillSecurity:Get()) then
                NotorietyAPI.killSecurity(false, true)
            end
            if (AutoFarmGetLootables:Get()) then
                NotorietyAPI.getLootables()
            end
            if (AutoFarmGetBigLoot:Get()) then
                NotorietyAPI.getBigLoot()
            end
            if (AutoFarmBreakGlassAfter:Get()) then
                NotorietyAPI.breakAllGlass()
            end
            wait(0.5)
            if (AutoFarmDropBags:Get()) then
                NotorietyAPI.dropOffBags()
            end

            return true
        end

        return false
    end

    if (LocalPlayer.Character and LocalPlayer.Character.Parent ~= Workspace.Criminals) then
        local Connection
        Connection = Workspace.Criminals.ChildAdded:Connect(function(Character)
            wait(0.1)
            if (start(Character) or done) then
                Connection:Disconnect()
            end
        end)
    end

    start(LocalPlayer.Character)
end)