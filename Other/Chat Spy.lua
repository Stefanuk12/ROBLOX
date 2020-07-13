-- // Initialise
if getgenv().ChatSpy then return getgenv().ChatSpy end
repeat wait() until game:GetService("ContentProvider").RequestQueueSize == 0

-- // Vars
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local DefaultChatSystemChatEvents = ReplicatedStorage:WaitForChild("DefaultChatSystemChatEvents")
local SayMessageRequest = DefaultChatSystemChatEvents:WaitForChild("SayMessageRequest")
local OnMessageDoneFiltering = DefaultChatSystemChatEvents:WaitForChild("OnMessageDoneFiltering")
getgenv().ChatSpy = {
    Enabled = true,
    SpyOnSelf = true,
    Public = false,
    Chat = {
        Colour  = Color3.fromRGB(255, 0, 0),
        Font = Enum.Font.SourceSans,
        TextSize = 18,
        Text = "",
    },
    IgnoreList = {
        {Message = "part/1/1/1", ExactMatch = false},
        {Message = "A?????????", ExactMatch = false},
        {Message = "colorshifttop 10000 0 0", ExactMatch = false},
        {Message = "colorshiftbottom 10000 0 0", ExactMatch = false},
        {Message = "colorshifttop 0 10000 0", ExactMatch = false},
        {Message = "colorshiftbottom 0 10000 0", ExactMatch = false},
        {Message = "colorshifttop 0 0 10000", ExactMatch = false},
        {Message = "colorshiftbottom 0 0 10000", ExactMatch = false},
    },
}

-- // Function
function ChatSpy.checkIgnored(message)
    local Check = false
    for _,v in pairs(ChatSpy.IgnoreList) do
        if (v.ExactMatch and (message == v.Message)) or (not v.ExactMatch and string.find(message, v.Message)) then 
            Check = true
        end
    end
    return Check
end

function ChatSpy.onChatted(targetPlayer, message)
    if targetPlayer == LocalPlayer and string.lower(message):sub(1, 4) == "/spy" then
        ChatSpy.Enabled = not ChatSpy.Enabled; wait(0.3)
        ChatSpy.Chat.Text = "[SPY] - "..(ChatSpy.Enabled and "Enabled." or "Disabled.")
        StarterGui:SetCore("ChatMakeSystemMessage", ChatSpy.Chat)
    elseif ChatSpy.Enabled and (ChatSpy.SpyOnSelf or targetPlayer ~= LocalPlayer) then
        local message = message:gsub("[\n\r]",''):gsub("\t",' '):gsub("[ ]+",' ')
        local Hidden = true
        local Connection = OnMessageDoneFiltering.OnClientEvent:Connect(function(packet, channel)
            if packet.SpeakerUserId == targetPlayer.UserId and packet.Message == message:sub(#message - #packet.Message + 1) and (channel == "All" or (channel == "Team" and not ChatSpy.Public and Players[packet.FromSpeaker].Team == LocalPlayer.Team)) then
                Hidden = false
            end
        end)
        wait(1)
        Connection:Disconnect()
        if Hidden and ChatSpy.Enabled and not ChatSpy.checkIgnored(message) then
            ChatSpy.Chat.Text = "[SPY] - ["..targetPlayer.Name.."]: "..message
            if ChatSpy.Public then
                SayMessageRequest:FireServer(ChatSpy.Chat.Text, "All")
            else      
                StarterGui:SetCore("ChatMakeSystemMessage", ChatSpy.Chat)
            end
        end
    end
end

-- // Handling Chats
for _, player in pairs(Players:GetPlayers()) do 
    player.Chatted:Connect(function(message)
        ChatSpy.onChatted(player, message)
    end)
end

Players.PlayerAdded:Connect(function(player)
    player.Chatted:Connect(function(message)
        ChatSpy.onChatted(player, message)
    end)
end)

-- // Initialise Text
ChatSpy.Chat.Text = "[SPY] - "..(ChatSpy.Enabled and "Enabled." or "Disabled.")
StarterGui:SetCore("ChatMakeSystemMessage", ChatSpy.Chat)

-- // Update Chat Frame
local chatFrame = LocalPlayer.PlayerGui.Chat.Frame
chatFrame.ChatChannelParentFrame.Visible = true
chatFrame.ChatBarParentFrame.Position = chatFrame.ChatChannelParentFrame.Position + UDim2.new(UDim.new(), chatFrame.ChatChannelParentFrame.Size.Y)