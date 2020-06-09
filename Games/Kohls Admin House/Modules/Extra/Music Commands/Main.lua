-- // Initialisation
if not getgenv()["KAHHax"] then getgenv()["KAHHax"] = {} end

if not KAHHax["intMusicCMDs"] then
    local MusicAPI = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Music%20API/Controller.lua"))()

    game:GetService("Players").LocalPlayer.Chatted:Connect(function(message)
        local id
        if string.split(message, " ")[2] then id = tonumber(string.split(message, " ")[2]) end
        if string.match(message, ":getmusic") then
            MusicAPI.returnMusic(false)
        end
        if string.match(message, ":play ") and MusicAPI.getSound(id) then
            game:GetService("Players"):Chat(":music "..MusicAPI.getSound(id))
            print('Now Playing:', MusicAPI.getSoundName(id))
        end
        if string.match(message, ":refreshmusic") then
            MusicAPI.refreshSounds()
        end
    end)

    KAHHax["intMusicCMDs"] = true
end