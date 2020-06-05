
getgenv().musicTable = game:GetService("HttpService"):JSONDecode(game:HttpGetAsync('https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Kohls%20Admin%20House/Modules/Music%20Commands/MusicTable.json'))
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
        return (game:GetService("MarketplaceService"):GetProductInfo(SoundId, Enum.InfoType.Asset).Description == '(Removed for copyright)' or game:GetService("MarketplaceService"):GetProductInfo(SoundId, Enum.InfoType.Asset).Description == '[ Content Deleted ]')
    end
    return false
end

function testAllSounds(mode)
    warn('--~~-- Commencing Music Checks - Allow upto 30 seconds! --~~--')
    for i,v in pairs(musicTable) do
        coroutine.wrap(function()
            wait(1)
            local url = game:HttpGetAsync('https://www.roblox.com/library/'..v.SoundId)
            wait(1)
            if checkBadSound(url, v.SoundId) then
                musicTable[i] = nil
                wait(0.1)
                table.remove(musicTable, i)
                print('Removed:', v.Name)
            end
        end)()
    end
    wait(10)
    if mode then print(musicTable) end
end
testAllSounds(true)

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
        print('Now Playing:', musicTable[id].Name)
    end
    if string.match(message, ":refreshmusic") then
        getgenv().musicTable = game:GetService("HttpService"):JSONDecode(game:HttpGetAsync('https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Kohls%20Admin%20House/Modules/Music%20Commands/MusicTable.json'))
        testAllSounds()
    end
end)