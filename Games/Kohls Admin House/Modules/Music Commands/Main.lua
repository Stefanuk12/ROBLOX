
local musicTable = game:GetService("HttpService"):JSONDecode(game:HttpGetAsync('https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Kohls%20Admin%20House/Modules/Music%20Commands/MusicTable.json'))
function testAllSounds()
    for i,v in pairs(musicTable) do
        local Sound = Instance.new("Sound", game:GetService("Lighting"))
        Sound.SoundId = v.SoundId
        Sound:Play()
        wait(0.1)
        if Sound.TimeLength < 1 then
            table.remove(musicTable, i)
        end
        Sound:Destroy()
    end
end

game:GetService("Players").LocalPlayer.Chatted:Connect(function(message)
    local id
    if string.split(message, " ")[2] then id = tonumber(string.split(message, " ")[2]) end
    if string.match(message, ":getmusic") then
        testAllSounds()
        for i,v in pairs(musicTable) do
            print(i, "|", v.Name)
        end
    end
    if string.match(message, ":play ") and musicTable[id] then
        game:GetService("Players"):Chat(":music "..musicTable[id].SoundId)
    end
end)