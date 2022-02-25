-- // Dependencies
local SignalManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/Signal/main/Manager.lua"))()
local Signals = SignalManager.new()
Signals:Add("Purchase")

-- // Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- // Vars
local LocalPlayer = Players.LocalPlayer
local Events = ReplicatedStorage.Events

-- //
local Connection
Connection = Events.ChatAlert.OnClientEvent:Connect(function(Tipper, Amount, Reciever)
    -- // Convert tipper/reciever
    Tipper = Players:FindFirstChild("Tipper")
    Reciever = Players:FindFirstChild("Reciever")

    -- // Check that we were donated to
    if (Reciever == LocalPlayer) then
        Signals:Fire("Purchase", Tipper, Amount)
    end
end)

-- // Return
return Signals, Connection