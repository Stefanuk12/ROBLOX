
local musicTable = game:GetService("HttpService"):JSONDecode(game:HttpGetAsync('https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Kohls%20Admin%20House/Modules/Music%20Commands/MusicTable.json'))
function testAllSounds()
    warn('--~~-- Commencing Music Checks - Please Wait --~~--')
    for i,v in pairs(musicTable) do
        local url = game:HttpGetAsync('https://www.roblox.com/library/'..v.SoundId)
        if string.match(url, 'https://t6.rbxcdn.com/70608418c648be7ac4e323e3294bb059') or string.match(url, 'https://t5.rbxcdn.com/d28c1b5eed271a7aa76f16689e74ca04') then
            table.remove(musicTable, i)
            print('Removed:', v.Name)
        end
    end
    warn('--~~-- Music Checks Done! --~~--')
end
testAllSounds()

game:GetService("Players").LocalPlayer.Chatted:Connect(function(message)
    local id
    if string.split(message, " ")[2] then id = tonumber(string.split(message, " ")[2]) end
    if string.match(message, ":getmusic") then
        for i,v in pairs(musicTable) do
            print(i, "|", v.Name)
        end
    end
    if string.match(message, ":play ") and musicTable[id] then
        game:GetService("Players"):Chat(":music "..musicTable[id].SoundId)
    end
end)