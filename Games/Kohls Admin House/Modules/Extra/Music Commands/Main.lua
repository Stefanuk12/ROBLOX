local removedAssets = {
    'https://t6.rbxcdn.com/70608418c648be7ac4e323e3294bb059',
    'https://t5.rbxcdn.com/d28c1b5eed271a7aa76f16689e74ca04',
    'This audio asset has been blocked due to copyright violations.',
}
getgenv().KAHHax["Extra"]["Music Commands"]["Functions"].checkBadSound = function(url, SoundId) 
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

getgenv().KAHHax["Extra"]["Music Commands"]["Functions"].testAllSounds = function(mode)
    warn('--~~-- Commencing Music Checks - Allow upto 30 seconds! --~~--')
    getgenv().KAHHax["Extra"]["Music Commands"].oldMusicTable = game:GetService("HttpService"):JSONDecode(game:HttpGetAsync('https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Kohls%20Admin%20House/Modules/Extra/Music%20Commands/MusicTable.json'))
    local oldMusicTable = getgenv().KAHHax["Extra"]["Music Commands"].oldMusicTable
    for i,v in pairs(oldMusicTable) do
        coroutine.wrap(function()
            wait(1)
            local url = game:HttpGetAsync('https://www.roblox.com/library/'..v.SoundId)
            wait(1)
            if getgenv().KAHHax["Extra"]["Music Commands"]["Functions"].checkBadSound(url, v.SoundId) then
                oldMusicTable[i] = nil
                print('Removed:', v.Name)
            end
        end)()
    end
    wait(30)
    getgenv().KAHHax["Extra"]["Music Commands"].musicTable = {}
    local musicTable = getgenv().KAHHax["Extra"]["Music Commands"].musicTable
    for i,v in pairs(oldMusicTable) do
        table.insert(musicTable, v)
    end
    if mode then print(musicTable) end
    warn('--~~-- Music Checks Finished! --~~--')
end

game:GetService("Players").LocalPlayer.Chatted:Connect(function(message)
    local id
    local musicTable = getgenv().KAHHax["Extra"]["Music Commands"].musicTable
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
        getgenv().KAHHax["Extra"]["Music Commands"].musicTable = game:GetService("HttpService"):JSONDecode(game:HttpGetAsync('https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Kohls%20Admin%20House/Modules/Extra/Music%20Commands/MusicTable.json'))
        getgenv().KAHHax["Extra"]["Music Commands"]["Functions"].testAllSounds()
    end
end)