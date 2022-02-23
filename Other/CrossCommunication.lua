-- // Information
--[[
    This can be used to identify fellow exploiters in your game. Make sure your message is secure or regular users may be false flagged.

    The way this works is whenever you execute this script, you chat out the secret.
    If another user picks up on that secret, they also chat the secret.
    Now you both know each other.
    If another person were to execute, this cycle would repeat.
]]

-- // Dependencies
local SignalManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/Signal/main/Manager.lua"))()
local Manager = SignalManager.new()

-- // Configuration
local Secret = "hello comrade"

-- // Services
local Players = game:GetService("Players")

-- // Vars
local Comrades = {}
local AllChatType = Enum.PlayerChatType.All

-- // Create signals
Manager:Add("ExploiterJoined")
Manager:Add("ExploiterLeaving")

-- // See when people chat
local ChatConnection
ChatConnection = Players.PlayerChatted:Connect(function(ChatType, Player, Message, TargetPlayer)
    -- // Make sure message matches and we have not already gotten the user
    if (Message == Secret and ChatType == AllChatType and TargetPlayer == nil and not table.find(Comrades, Player)) then
        -- // Add the the player
        table.insert(Comrades, Player)

        -- // Chat
        Players:Chat(Secret)

        -- // Fire
        Manager:Fire("ExploiterJoined", Player)
    end
end)

-- // See when people leave
local PlayerConnection
PlayerConnection = Players.PlayerRemoving:Connect(function(Player)
    -- // Check if found
    local i = table.find(Comrades, Player)
    if (i) then
        -- // Remove
        table.remove(Comrades, i)

        -- // Fire
        Manager:Fire("ExploiterLeaving", Player)
    end
end)

-- // Connect to signals
Manager:Connect("ExploiterJoined", function(Player)
    print("Hello fellow comrade: " .. Player.Name)
end)

Manager:Connect("ExploiterLeaving", function(Player)
    print("Goodbye fellow comrade: " .. Player.Name .. " :(")
end)

-- // Chat the secret
Players:Chat(Secret)