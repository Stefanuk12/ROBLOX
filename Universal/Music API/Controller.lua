-- // Services
local HttpService = game:GetService("HttpService")
local LogService = game:GetService("LogService")

-- // Music API Table
getgenv().MusicAPI = {
    Verbose = true, -- // prints audio failed if it did,
    MusicTableLink = "https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Music%20API/MusicTable.json"
}
MusicAPI.MusicTable = HttpService:JSONDecode(game:HttpGet(MusicAPI.MusicTableLink))

-- // Check if a sound works
function MusicAPI.CheckSound(SoundId)
    -- // Vars
    local SoundIdAsset = "http://www.roblox.com/asset/?id=" .. SoundId

    -- // Create Sound and Play
    local Sound = Instance.new("Sound", workspace)
    Sound.Volume = 0
    Sound.SoundId = SoundIdAsset
    Sound:Play()

    wait(0.1)

    -- // Get Log History
    local LogHistory = LogService:GetLogHistory()
    local AudioLog = LogHistory[#LogHistory]
    local searchError = "Failed to load sound " .. SoundIdAsset .. ":"

    -- // Remove sound
    Sound:Destroy()

    -- // Check if the sound has been removed or not and return accordingly
    if (AudioLog and AudioLog.message:sub(1, #searchError) == searchError and AudioLog.messageType == Enum.MessageType.MessageError) then
        return false
    end

    -- // Return
    return true
end

-- // Remove duplicate sounds
local function soundInTable(SoundId, tbl)
    -- // Loop through table
    for i = 1, #tbl do
        -- // Check if found sound, then return
        if (tbl[i]["SoundId"] == SoundId) then
            return true
        end
    end

    return false
end
function MusicAPI.RemoveDuplicates(tbl)
    local Cleaned = {}

    for i = 1, #tbl do
        local soundObj = tbl[i]

        if (not soundInTable(soundObj.SoundId, Cleaned)) then
            Cleaned[#Cleaned + 1] = soundObj
        end
    end

    return Cleaned
end

-- // Set UUIDs to each sound
function MusicAPI.SetUUIDs(tbl)
    -- // Loop through table and set uuid
    for i = 1, #tbl do
        tbl[i]["UUID"] = i
    end

    --// Return
    return tbl
end

-- // Test all sounds
function MusicAPI.CheckAllSounds()
    -- // Vars
    local MusicTable = HttpService:JSONDecode(game:HttpGet(MusicAPI.MusicTableLink))
    local startTime = tick()

    -- // Remove duplicates
    MusicTable = MusicAPI.RemoveDuplicates(MusicTable)

    -- // Loop through all sounds and remove bad sounds
    for i = #MusicTable, 1, -1  do
        local validSound = MusicAPI.CheckSound(MusicTable[i].SoundId)
        if (not validSound) then
            table.remove(MusicTable, i)
        end
    end

    -- // Verbose output
    if (MusicAPI.Verbose) then
        print('Check All Sounds done in ' .. tick() - startTime .. " seconds.")
    end

    -- // Sort UUIDs and return
    return MusicAPI.SetUUIDs(MusicTable)
end

function MusicAPI.Benchmark(FunctionToBench, Iterations, ...)
    local startTime = tick()

    for i = 1, Iterations do
        FunctionToBench(...)
    end

    return tick() - startTime
end

--[[
    Benchmark Script:

    local BenchmarkTime = MusicAPI.Benchmark(MusicAPI.CheckAllSounds, 1)
    print(BenchmarkTime)
]]

-- // Save Music Table as JSON
function MusicAPI.SaveAsJSON()
    if (not writefile) then return false end

    local MusicTable = MusicAPI.SetUUIDs(MusicAPI.MusicTable)
    local Content = HttpService:JSONEncode(MusicTable)

    writefile("MusicTable.json", Content)
end

-- // Save to clipboard
function MusicAPI.GetAll()
    if (not setclipboard) then return false end

    local MusicTable = MusicAPI.MusicTable
    local Credits = "Music API - Created By Stefanuk12 - Audio Count: " .. #MusicTable .. "\n"
    local String = Credits

    for i = 1, #MusicTable do
        local v = MusicTable[i]
        String = String .. i .. " | " .. v.Name .. " (" .. v.SoundId .. ")\n"
    end

    String = String .. Credits

    return String
end

-- // Export Music Table to clipboard
function MusicAPI.SetClipboard()
    setclipboard(MusicAPI.GetAll())
end

-- // Search for a specific song
function MusicAPI.Search(searchTerm, MusicTable)
    -- // Failsafe
    if (not MusicTable) then MusicTable = MusicAPI.MusicTable end

    -- // Vars
    local FoundSongs = {}

    -- // Loop through Music Table
    for i = 1, #MusicTable do
        -- // Vars
        local sound = MusicTable[i]

        -- // Check if it closely matches it
        if (sound.Name:lower():sub(1, #searchTerm) == searchTerm:lower()) then

            -- // Add to found
            FoundSongs[#FoundSongs + 1] = FoundSongs
        end
    end

    -- // Return found
    return FoundSongs
end
return MusicAPI