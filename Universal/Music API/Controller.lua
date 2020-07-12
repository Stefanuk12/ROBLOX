-- // Initialise
if getgenv().ValiantMusicAPI then return getgenv().ValiantMusicAPI end

-- // Vars
getgenv().ValiantMusicAPI = {} 
ValiantMusicAPI.GitHubTable = 'https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Music%20API/MusicTable.json'
ValiantMusicAPI.musicTable = {}
ValiantMusicAPI.removedAssets = {
    "https://images.rbxcdn.com/9281912c23312bc0d08ab750afa588cc.png",
    "https://t6.rbxcdn.com/70608418c648be7ac4e323e3294bb059",
}
local MarketplaceService = game:GetService("MarketplaceService")

-- // Check if a Sound has been removed
function ValiantMusicAPI.checkBadSound(SoundId, SoundName, UseMarketplace, Verbose)
    -- // Fail-safing
    if not SoundId then return false end

    -- // Checking 
    local TargetURL = game:HttpGetAsync('https://www.roblox.com/library/'..SoundId) -- // Gets the source
    if not UseMarketplace and TargetURL then
        for _,v in pairs(ValiantMusicAPI.removedAssets) do
            if string.find(TargetURL, v) then
                if Verbose then print(SoundName.."("..SoundId..")".." removed!") end
                return true -- // The Sound has been removed, return true
            end
        end
    end

    -- // Checking w/ Marketplace
    if UseMarketplace then
        local ProductInfo = MarketplaceService:GetProductInfo(SoundId, Enum.InfoType.Asset)
        return (GPI.Description == '(Removed for copyright)' or GPI.Description == '[ Content Deleted ]')
    end

    return false -- // The sound stil exists, return false
end

-- // Remove any duplicate SoundIds
function ValiantMusicAPI.removeDuplicates(targetTable)
    local CheckTable = targetTable
    for i, v in pairs(targetTable) do
        if table.find(CheckTable, v.SoundId) then
            table.remove(targetTable, i)
        end
    end
    
    return targetTable
end

-- // Test All Of the Sounds
function ValiantMusicAPI.testAllSounds(Verbose, waitTime, UseMarketplace)
    if not waitTime then waitTime = 15 end 
    ValiantMusicAPI.musicTable = game:GetService("HttpService"):JSONDecode(game:HttpGetAsync(ValiantMusicAPI.GitHubTable))
    warn("Starting Music Checks, please wait "..waitTime.." seconds!")

    -- // Remove Duplicates
    ValiantMusicAPI.musicTable = ValiantMusicAPI.removeDuplicates(ValiantMusicAPI.musicTable)

    -- // Check over all of the sounds
    for i,v in pairs(ValiantMusicAPI.musicTable) do
        coroutine.wrap(function() -- // Coroutine to speed everything up
            if ValiantMusicAPI.checkBadSound(v.SoundId, v.Name, UseMarketplace, Verbose) then
                ValiantMusicAPI.musicTable[i] = nil
            end
        end)()
    end
    wait(waitTime)
    
    -- // Finishing up
    warn("Music Checks Finished!")
    return ValiantMusicAPI.musicTable
end

function ValiantMusicAPI.printMusic()
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

function ValiantMusicAPI.saveMusicTableJSON(Verbose)
    local contents = game:GetService("HttpService"):JSONEncode(ValiantMusicAPI.musicTable)
    local success = false
    if writefile then
        writefile("MusicTable.json", contents)
        if Verbose then print('Successfully saved MusicTable.json to workspace!') end
    end
end

function ValiantMusicAPI.exportMusicToClipboard(Verbose)
    local Holder = "Stefanuk12's Music API Audios (Current Count: "..#ValiantMusicAPI.musicTable.." audios):".."\n"
    for i,v in pairs(ValiantMusicAPI.musicTable) do
        Holder = Holder.."["..v.SoundId.."] - "..v.Name.."\n"
    end
    Holder = Holder.."Stefanuk12's Music API Audios (Current Count: "..#ValiantMusicAPI.musicTable.." audios):".."\n"
    setclipboard(Holder)
    if Verbose then print("Exported Music Table to Clipboard!") end

    return Holder
end

ValiantMusicAPI.testAllSounds(true)

return getgenv().ValiantMusicAPI