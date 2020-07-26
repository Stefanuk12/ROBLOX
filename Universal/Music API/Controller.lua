--[[
    Documentation:
        Variables:
            <table> ValiantMusicAPI - The main holder table with all of the functions and most variables.
            <string> ValiantMusicAPI.GitHubTable - The table that holds all of the IDs and Names of the audios that will be filtered through.
            <table> ValiantMusicAPI.removedAssets - Things that indicate that the audio has been deleted
            <table> ValiantMusicAPI.musicTable - holds all of the filtered audios

        Functions:
            <bool> ValiantMusicAPI.checkBadSound(<string> SoundId, <string> SoundName, <bool> UseMarketplace, <bool> Verbose) - Returns true/false depending on whether the audio has been removed or not
            <table> ValiantMusicAPI.removeDuplicates(<table> targetTable) - Removes any duplicate SoundIds from the table
            <table> ValiantMusicAPI.testAllSounds(<bool> Verbose, <number> waitTime, <bool> UseMarketplace) - Tests all of the sounds in the ValiantMusicAPI.GitHubTable table then updates the ValiantMusicAPI.musicTable table
            <void> ValiantMusicAPI.printMusic(<void>) - Prints all of the Sound Names + their indexes
            <string/number idk> ValiantMusicAPI.getSound(<number> Index) - Returns the SoundId of the Sound present at the Index of the ValiantMusicAPI.musicTable table
            <string> ValiantMusicAPI.getSoundName(<number> Index) - Returns the Sound Name of the Sound present at the Index of the ValiantMusicAPI.musicTable table
            <void> ValiantMusicAPI.saveMusicTableJSON(<bool> Verbose) - Saves the filtered Music Table as .json to your workspace folder
            <void> ValiantMusicAPI.exportMusicToClipboard(<bool> Verbose) - Saves the filtered Music Table to your clipboard in a formatted version
]]

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
    if not SoundName then SoundName = "No Sound Name Provided" end
    if not UseMarketplace then UseMarketplace = false end
    if not Verbose then Verbose = false end

    -- // Checking 
    local TargetURL = game:HttpGetAsync('https://www.roblox.com/library/'..SoundId) -- // Gets the source
    if not UseMarketplace and TargetURL then
        for _,v in pairs(ValiantMusicAPI.removedAssets) do
            if string.find(TargetURL, v) then
                if Verbose then print(SoundName.." ("..SoundId..")".." removed!") end
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
    local CheckTable = {}
    local function isInTable(targetTable, SoundId)
        for _,v in pairs(targetTable) do
            if v and v.SoundId == SoundId then
               return true
            end
        end
        return false
    end
    for i,v in pairs(targetTable) do
        if not isInTable(CheckTable, v.SoundId) then
            table.insert(CheckTable, v)
        end
    end

    return CheckTable
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
                table.remove(ValiantMusicAPI.musicTable, i)
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
    local tbl = {}
    for i = 1, #ValiantMusicAPI.musicTable do 
        if ValiantMusicAPI.musicTable[i] then
            ValiantMusicAPI.musicTable[i].UUID = i
            table.insert(tbl, ValiantMusicAPI.musicTable[i]) 
        end
    end

    local contents = game:GetService("HttpService"):JSONEncode(tbl)
    local success = false
    if writefile then
        writefile("MusicTable.json", contents)
        if Verbose then print('Successfully saved MusicTable.json to workspace!') end
    end
end

function ValiantMusicAPI.exportMusicToClipboard(Verbose)
    local Holder = "Stefanuk12's Music API Audios (Current Count: "..#ValiantMusicAPI.musicTable.." audios):".."\n"
    for i,v in pairs(ValiantMusicAPI.musicTable) do
        Holder = Holder..i.." ["..v.SoundId.."] | "..v.Name.."\n"
    end
    Holder = Holder.."Stefanuk12's Music API Audios (Current Count: "..#ValiantMusicAPI.musicTable.." audios)".."\n"
    setclipboard(Holder)
    if Verbose then print("Exported Music Table to Clipboard!") end

    return Holder
end

ValiantMusicAPI.testAllSounds(true)

return getgenv().ValiantMusicAPI