local removedAssets = {
    'https://t6.rbxcdn.com/70608418c648be7ac4e323e3294bb059',
    'https://t5.rbxcdn.com/d28c1b5eed271a7aa76f16689e74ca04',
    'This audio asset has been blocked due to copyright violations.',
}
function KAHHax["Extra"]["Music Commands"]["Functions"].checkBadSound(url, SoundId) 
    if url then
        for i,v in pairs(removedAssets) do
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

function KAHHax["Extra"]["Music Commands"]["Functions"].testAllSounds(mode)
    warn('--~~-- Commencing Music Checks - Allow upto 30 seconds! --~~--')
    getgenv().oldMusicTable = game:GetService("HttpService"):JSONDecode(game:HttpGetAsync('https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Kohls%20Admin%20House/Modules/Music%20Commands/MusicTable.json'))
    for i,v in pairs(oldMusicTable) do
        coroutine.wrap(function()
            wait(1)
            local url = game:HttpGetAsync('https://www.roblox.com/library/'..v.SoundId)
            wait(1)
            if KAHHax["Extra"]["Music Commands"]["Functions"].checkBadSound(url, v.SoundId) then
                oldMusicTable[i] = nil
                print('Removed:', v.Name)
            end
        end)()
    end
    wait(30)
    getgenv().musicTable = {}
    for i,v in pairs(oldMusicTable) do
        table.insert(musicTable, v)
    end
    if mode then print(musicTable) end
    warn('--~~-- Music Checks Finished! --~~--')
end

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
        KAHHax["Extra"]["Music Commands"]["Functions"].testAllSounds()
    end
end)