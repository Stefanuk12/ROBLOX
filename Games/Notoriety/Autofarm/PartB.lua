-- // Wait until game has loaded in
repeat wait() until game:IsLoaded()

-- // NotorietyAPI
loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Notoriety/API.lua"))()
repeat wait() until NotorietyAPI

-- // Services
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- // Vars
local LocalPlayer = Players.LocalPlayer
local RSPackage = ReplicatedStorage.RS_Package
local Remotes = RSPackage.Remotes
local Remotes2 = RSPackage.Assets.Remotes

-- // Auto Farm Settings
local SelectedClass = "1"
local LootingSettings = {
    KillSecurity = false,
    GetLootables = true,
    GetBigLoot = true,
    BreakAllGlass = false,
    DropOffBags = true,
    AmountOfBags = 999
}

-- // TP Bypass
NotorietyAPI.antiBypass(LocalPlayer.Character)

-- // Activating autofarm on spawn
Workspace.Criminals.ChildAdded:Connect(function(Character)
    wait(0.1)

    if (Character == LocalPlayer.Character) then
        -- // Put Mask on
        Remotes2.MaskOn:FireServer()

        -- // Low Detection
        repeat wait() until Character:FindFirstChild("Mask ON")
        NotorietyAPI.LowDetection(Character)

        -- // Get Remote Key
        NotorietyAPI.getRemoteKey()

        -- // Kill Security
        if (LootingSettings.KillSecurity) then
            NotorietyAPI.killSecurity(false, true)
        end

        -- // Get Lootables
        if (LootingSettings.GetLootables) then
            NotorietyAPI.getLootables(LootingSettings.AmountOfBags)
        end

        -- // Get Big Loot
        if (LootingSettings.GetBigLoot) then
            NotorietyAPI.getBigLoot(LootingSettings.AmountOfBags)
        end

        -- // Break All Glass
        if (LootingSettings.BreakAllGlass) then
            NotorietyAPI.breakAllGlass()
        end

        -- // Drop off bags
        if (LootingSettings.DropOffBags) then
            wait(0.5)
            NotorietyAPI.dropOffBags()

            -- // Go back to menu
            wait(5)
            Remotes.GoToMenu:FireServer()
        end
    end
end)

-- // Getting ready
Remotes.PlayerReady:FireServer("Class " .. SelectedClass)

-- // Wait on teleport to repeat the process
LocalPlayer.OnTeleport:Connect(function(State)
    if (State == Enum.TeleportState.Started) then
        syn.queue_on_teleport(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Notoriety/Autofarm/PartA.lua"))
    end
end)