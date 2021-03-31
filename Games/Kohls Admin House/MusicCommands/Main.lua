-- // To stop from being executed multiple times
if (getgenv().MusicCommands) then return end
getgenv().MusicCommands = true;

-- // Dependencies
local MusicAPI = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Music%20API/Controller.lua"))()
getgenv().MusicAPI.MusicTable = MusicAPI.CheckAllSounds()

-- // Services
local Players = game:GetService("Players")

-- // Vars
local LocalPlayer = Players.LocalPlayer
local Prefix = "."

-- // CMD Handlers
local Commands = {}
local function addCommand(Command, Function)
    Commands[#Commands + 1] = {
        Name = Command,
        Function = Function
    }
end

LocalPlayer.Chatted:Connect(function(message)
    if (message:sub(1, 1) ~= Prefix) then return end
    for i = 1, #Commands do
        local v = Commands[i];

        if (message:sub(#Prefix + 1):split(" ")[1] == v.Name) then
            v.Function(message:sub(#v.Name + #Prefix + 2))
        end
    end
end)

-- // Commands
addCommand("play", function(message)
    local songNumber = tonumber(message)
    local SoundObject = getgenv().MusicAPI.MusicTable[songNumber]

    if (songNumber and SoundObject) then
        Players:Chat(":music " .. SoundObject.SoundId)
        print('Now Playing: ' .. SoundObject.Name)
    else
        warn('Sound does not exist in database!')
    end
end)

addCommand("music", function(message)
    print("\n" .. getgenv().MusicAPI.GetAll())
end)

addCommand("refresh", function(message)
    getgenv().MusicAPI.MusicTable = getgenv().MusicAPI.CheckAllSounds()
end)

addCommand("help", function(message)
    print([[
        Music Commands - Help Menu - Prefix: .

        help - prints out the help menu
        play [index] - plays the song at the index
        music - prints out the music database
        refresh - refreshes all of the sounds

        Example: .play 1

        Music Commands - Help Menu - Prefix: .
    ]])
end)
print('Loaded Music Commands')
