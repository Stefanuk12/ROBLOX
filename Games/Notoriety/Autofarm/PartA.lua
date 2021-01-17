-- // Only allow in menu
if (game.PlaceId ~= 21532277) then return end

-- // Wait until game loaded
repeat wait() until game:IsLoaded()

-- // Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- // Vars
local LocalPlayer = Players.LocalPlayer

local Heist = "Shadow Raid"
local Difficulty = "Nightmare"

-- // Create Lobby
local Lobby = ReplicatedStorage:WaitForChild("MakeLobby"):InvokeServer(Heist, Difficulty, 3, "PRIVATE", "ANY", false, false)

-- // Start the game
ReplicatedStorage:WaitForChild("StartGame"):FireServer(Lobby)

-- // Wait on teleport
LocalPlayer.OnTeleport:Connect(function(State)
    if (State == Enum.TeleportState.Started) then
        syn.queue_on_teleport(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Notoriety/Autofarm/PartB.lua"))
    end
end)