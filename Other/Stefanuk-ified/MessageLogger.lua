-- // Information
--[[
    Original Thread: https://v3rmillion.net/showthread.php?tid=1140659
]]

-- // Services
local Players = game:GetService("Players")

-- // Vars
local LocalPlayer = Players.LocalPlayer
local LocalPlayerId = LocalPlayer.UserId

local MessagePrefix = "/"
local LogFormat = "[%d:%d] %s%s: %s\n"

-- //
local TypeToFunc = {
    info = rconsoleinfo,
    warn = rconsolewarn,
    error = rconsoleerr
}
local function Output(Text, Type)
    -- // Lower the type
    Type = Type:lower()

    -- // Resolve and execute
    TypeToFunc[Type](Text)
end

-- // Credits
Output("Made by Buki#2872:852409360835674112 - Modified by Stefanuk12#5820:398271060514045964", "error")
Output("Welcome, " .. LocalPlayer.Name .. "!", "warn")

-- // Countdown?
for i = 1, 2 do
    Output(tostring(i) .. "..", "warn")
    wait(1)
end

-- //
local function LogMessage(ChatType, Player, Message, TargetPlayer)
    -- // Vars
    local ByLocalPlayer = Player == LocalPlayer

    -- // Make sure you want to clean the console
    if (ByLocalPlayer and Message == MessagePrefix .. "clean") then
        -- // Clear, output, return
        rconsoleclear()
        Output("Console cleaned.", "warn")
        return
    end

    -- // Vars
    local Prefix = ""
    local Colour = "@@WHITE@@"
    local Time = os.date("*t")

    -- // Set the prefixes depending on who sent it, along with the colour
    if (ByLocalPlayer) then
        Prefix = "(You) "
        Colour = "@@CYAN@@"
    elseif (Player:IsFriendsWith(LocalPlayerId)) then
        Prefix = "(Friend) "
        Colour = "@@WHITE@@"
    end

    -- // Format the message
    local MessageFormatted = LogFormat:format(Time.hour, Time.min, Prefix, Player.Name, Message)

    -- // Set colour, print out message (formatted), set window name to message
    rconsoleprint(Colour)
    rconsoleprint(MessageFormatted)
    rconsolename(Message)
end

-- //
Players.PlayerChatted:Connect(LogMessage)