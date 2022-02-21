-- // Information
--[[
    This can be used to identify fellow exploiters in your game. Make sure your message is secure or regular users may be false flagged.

    The way this works is whenever you execute this script, you chat out the secret.
    If another user picks up on that secret, they also chat the secret.
    Now you both know each other.
    If another person were to execute, this cycle would repeat.
]]

-- // Configuration
local Secret = "hello comrade"

-- // Services
local Players = game:GetService("Players")

-- // Vars
local Comrades = {}
local AllChatType = Enum.PlayerChatType.All

-- //
local ChatConnection
ChatConnection = Players.PlayerChatted:Connect(function(ChatType, Player, Message, TargetPlayer)
    -- // Make sure message matches and we have not already gotten the user
    if (Message == Secret and ChatType == AllChatType and TargetPlayer == nil and not table.find(Comrades, Player)) then
        -- // Add the the player
        table.insert(Comrades, Player)

        -- // Chat
        Players:Chat(Secret)

        -- //
        print("Found a fellow comrade, welcome: " .. Player.Name)
    end
end)

-- // Chat the secret
Players:Chat(Secret)