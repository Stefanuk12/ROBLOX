
local musicTable = game:GetService("HttpService"):JSONDecode(game:HttpGetAsync('https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Kohls%20Admin%20House/Modules/Music%20Commands/MusicTable.json'))
local badstuff = {
    'https://t6.rbxcdn.com/70608418c648be7ac4e323e3294bb059',
    'https://t5.rbxcdn.com/d28c1b5eed271a7aa76f16689e74ca04',
    'This audio asset has been blocked due to copyright violations.',
}
function checkBadSound(url, SoundId)
    if url then
        for i,v in pairs(badstuff) do
            if string.match(url, v) then
                return true
            end
        end
    end
    if SoundId then
        return (game:GetService("MarketplaceService"):GetProductInfo(SoundId, Enum.InfoType.Asset).Name == '(Removed for copyright)')
    end
    return false
end

function testAllSounds()
    warn('--~~-- Commencing Music Checks - Allow upto 30 seconds! --~~--')
    for i,v in pairs(musicTable) do
        coroutine.wrap(function()
            local url = game:HttpGetAsync('https://www.roblox.com/library/'..v.SoundId)
            if checkBadSound(url, v.SoundId) then
                table.remove(musicTable, i)
                print('Removed:', v.Name)
            end
        end)()
    end
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
    if string.match(message, ":refreshmusic") then
        testAllSounds()
    end
end)