-- // Services
local HttpService = game:GetService("HttpService")

-- // Music API Table
getgenv().MusicAPI = {
    Verbose = true, -- // prints audio failed if it did,
    MusicTableLink = "https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Music%20API/MusicTable.json",
    RemovedAssets = {
        "https://images.rbxcdn.com/9281912c23312bc0d08ab750afa588cc.png",
        "https://t6.rbxcdn.com/70608418c648be7ac4e323e3294bb059",
        "https://t5.rbxcdn.com/d28c1b5eed271a7aa76f16689e74ca04",
        "This audio asset has been blocked due to copyright violations."
    }
}
MusicAPI.MusicTable = HttpService:JSONDecode(game:HttpGet(MusicAPI.MusicTableLink))

-- // Check if a sound works
function MusicAPI.CheckSound(SoundId)
    local Source = game:HttpGet("https://roblox.com/library/" .. SoundId)

    -- // Loop through Removed assets and see if they're found 
    for i = 1, #MusicAPI.RemovedAssets do
        if (Source:find(MusicAPI.RemovedAssets[i])) then
            return false
        end
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
    local checkedAmount = 0

    -- // Remove duplicates
    MusicTable = MusicAPI.RemoveDuplicates(MusicTable)
    local startAmount = #MusicTable

    -- // Loop through all sounds and remove bad sounds
    for i = 1, #MusicTable do
        coroutine.wrap(function()
            wait(math.random(0, 5))
            if (not MusicAPI.CheckSound(MusicTable[i].SoundId)) then
                table.remove(MusicTable, i)
            end
    
            checkedAmount = checkedAmount + 1
        end)()
    end

    -- // Wait for finish
    repeat wait() until (checkedAmount == startAmount)

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
    
    local MusicTable = MusicAPI.SetUUIDs()
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

function MusicAPI.SetClipboard()
    setclipboard(MusicAPI.GetAll())
end

return MusicAPI