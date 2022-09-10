--[[
    Information:

    Fixes old .Chatted scripts by firing it when OnMessageDoneFiltering is called instead.
    Also works for PlayerChatted but some things are nil

    Simply put in autoexec.
]]

-- // Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- // Vars
local LocalPlayer = Players.LocalPlayer

-- // Connect to the "new event"
ReplicatedStorage.DefaultChatSystemChatEvents.OnMessageDoneFiltering.OnClientEvent:Connect(function(Data)
    -- // Get all of the data
    local Player = Players[Data.FromSpeaker]
    local Message = Data.Message
    local Channel = Data.OriginalChannel

    -- // Ignore if it is LocalPlayer as that event already fires
    if (Player == LocalPlayer) then
        return
    end

    -- // Fire
    firesignal(Player.Chatted, Message, Channel)
    firesignal(Players.PlayerChatted, nil, Player, Message, nil)
end)