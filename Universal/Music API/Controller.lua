getgenv().ValiantMusicAPI = {}
ValiantMusicAPI.GHMusicTable = 'https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Music%20API/MusicTable.json'
ValiantMusicAPI.musicTable = {}
ValiantMusicAPI.oldMusicTable = {}

ValiantMusicAPI.removedAssets = {
    'https://t6.rbxcdn.com/70608418c648be7ac4e323e3294bb059',
    'https://t5.rbxcdn.com/d28c1b5eed271a7aa76f16689e74ca04',
    'This audio asset has been blocked due to copyright violations.',
}
function ValiantMusicAPI.checkBadSound(SoundId)
    local url = game:HttpGetAsync('https://www.roblox.com/library/'..SoundId)
    if url then
        for i,v in pairs(ValiantMusicAPI.removedAssets) do
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

function ValiantMusicAPI.removeDuplicates(tbl)
    local checkTable = {}
    local function checkInTable(tbl, SoundId)
        for i,v in pairs(tbl) do
            return (v.SoundId == SoundId)
        end
    end
    for i,v in pairs(tbl) do
        if not checkInTable(checkTable, v.SoundId) then
            table.insert(checkTable, v)
        end
    end
    return checkTable
end

function ValiantMusicAPI.testAllSounds(mode)
    if not ValiantMusicAPI.testingInProgress then
        ValiantMusicAPI.testingInProgress = true
        warn('--~~-- Commencing Music Checks - Allow upto 30 seconds! --~~--')  
        ValiantMusicAPI.oldMusicTable = game:GetService("HttpService"):JSONDecode(game:HttpGetAsync(ValiantMusicAPI.GHMusicTable))
        for i,v in pairs(ValiantMusicAPI.oldMusicTable) do
            coroutine.wrap(function()
                if ValiantMusicAPI.checkBadSound(v.SoundId) then
                    wait(math.random(1, 10))
                    ValiantMusicAPI.oldMusicTable[i] = nil
                    if mode then print('Removed:', v.Name) end
                end
            end)()
        end
        wait(25)
        ValiantMusicAPI.musicTable = {}
        ValiantMusicAPI.oldMusicTable = ValiantMusicAPI.removeDuplicates(ValiantMusicAPI.oldMusicTable)
        for i,v in pairs(ValiantMusicAPI.oldMusicTable) do
            table.insert(ValiantMusicAPI.musicTable, v)
        end
        warn('--~~-- Music Checks Finished! --~~--')
        ValiantMusicAPI.testingInProgress = false
    else
        warn('--~~-- Music Checks Already In Progress! --~~--')
    end
end
ValiantMusicAPI.testAllSounds(mode)

function ValiantMusicAPI.refreshSounds(mode)
    ValiantMusicAPI.musicTable = {}
    ValiantMusicAPI.oldMusicTable = {}
    ValiantMusicAPI.testAllSounds(mode)
end

function ValiantMusicAPI.returnMusic(mode)
    for i,v in pairs(ValiantMusicAPI.musicTable) do
        print(i, "|", v.Name)
    end
end

function ValiantMusicAPI.getSound(Index)
    return ValiantMusicAPI.musicTable[Index].SoundId
end
function ValiantMusicAPI.getSoundName(Index)
    return ValiantMusicAPI.musicTable[Index].Name
end

return ValiantMusicAPI