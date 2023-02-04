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
local Configuration = {
    Secret = "hello comrade",
    Signals = Manager,
    Exploiters = {},
    Connections = {}
}

-- // Services
local Players = game:GetService("Players")

-- // Vars
local LocalPlayer = Players.LocalPlayer
local AllChatType = Enum.PlayerChatType.All

-- // Create signals
Manager:Add("ExploiterJoined")
Manager:Add("ExploiterLeaving")
Manager:Add("ExploiterChatted")

-- // See when people chat
Configuration.Connections.ChatConnection = Players.PlayerChatted:Connect(function(ChatType, Player, Message, TargetPlayer)
    -- // Make sure message matches and we have not already gotten the user
    if (Player ~= LocalPlayer and Message == Configuration.Secret and ChatType == AllChatType and TargetPlayer == nil and not table.find(Configuration.Exploiters, Player)) then
        -- // Add the the player
        table.insert(Configuration.Exploiters, Player)

        -- // Chat
        Players:Chat(Configuration.Secret)

        -- // Fire
        Manager:Fire("ExploiterJoined", Player)
    end
end)

-- // See when people leave
Configuration.Connections.PlayerConnection = Players.PlayerRemoving:Connect(function(Player)
    -- // Check if found
    local i = table.find(Configuration.Exploiters, Player)
    if (i) then
        -- // Remove
        table.remove(Configuration.Exploiters, i)

        -- // Fire
        Manager:Fire("ExploiterLeaving", Player)
    end
end)

-- // See when an exploiter chats
Configuration.Connections.ChattedConnection = Players.PlayerChatted:Connect(function(ChatType, Player, Message, TargetPlayer)
    -- // Check if the player is cached
    if (table.find(Configuration.Exploiters, Player)) then
        -- // Fire
        Manager:Fire("ExploiterChatted", ChatType, Player, Message, TargetPlayer)
    end
end)

-- // Chat the secret
Players:Chat(Configuration.Secret)

-- // Return
return Configuration
