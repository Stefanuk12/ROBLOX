-- // Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Notoriety/UILibrary.lua", true))()
local NotorietyAPI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Notoriety/API.lua"))()

-- // Services
local Players = game:GetService("Players")

-- // Vars
local LocalPlayer = Players.LocalPlayer

-- // Player Tab
local Player = Library:CreateTab("Player", "Player Controls", true)

Player:CreateButton("Teleport Bypass", function()
    NotorietyAPI.antiBypass(LocalPlayer.Character)
end)

local AutoTeleportBypass = Player:CreateToggle("Automatic Teleport Bypass On Death")
LocalPlayer.CharacterAdded:Connect(function(Character)
    if (AutoTeleportBypass:Get()) then
        NotorietyAPI.antiBypass(Character)
    end
end)

-- // Tools Tab
local Tools = Library:CreateTab("Tools", "Some functions that can help you", true)

local ToolsTeleportBack = Library:CreateToggle("Teleport Back")

Tools:CreateButton("Kill Security", function()
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
    NotorietyAPI.breakAllGlass()
end)
Tools:CreateButton("Secure Bags", function()
    NotorietyAPI.dropOffBags(ToolsTeleportBack:Get())
end)

-- // Auto Farm Tab
local AutoFarm = Library:CreateTab("Auto Farm", "Manage and start the auto farm", true)

local AutoFarmKillSecurity = Library:CreateToggle("Kill Security / Disable Cameras")
local AutoFarmGetLootables = Library:CreateToggle("Get Lootables")
local AutoFarmGetBigLoot = Library:CreateToggle("Get Big Loot")
local AutoFarmBreakGlassAfter = Library:CreateToggle("Break Glass")
local AutoFarmDropBags = Library:CreateToggle("Secure Bags")

AutoFarm:CreateButton("Start", function()
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
    if (AutoFarmDropBags:Get()) then
        NotorietyAPI.dropOffBags()
    end
end)

-- // Misc Tab
local Misc = Library:CreateTab("Misc", "Misc. things", true)
local RemoteKeyLabel = Library:CreateTextBox("Remote Key: " .. NotorietyAPI.RemoteKey)