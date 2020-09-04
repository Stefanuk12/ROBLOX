-- // This is updated and please switch to this as it's optimised

-- // Services
local MarketplaceService = game:GetService("MarketplaceService");
local HttpService = game:GetService("HttpService");
local RunService = game:GetService("RunService");

-- // Vars
local RenderStepped = RunService.RenderStepped;
getgenv().MusicAPI = {}; local MusicAPI = getgenv().MusicAPI;
MusicAPI.Verbose = true; -- // Will print what it's all doing
MusicAPI.MusicTableLink = "https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Music%20API/MusicTable.json";
MusicAPI.MusicTable = HttpService:JSONDecode(game:HttpGetAsync(MusicAPI.MusicTableLink));
MusicAPI.RemovedAssets = {
    "https://images.rbxcdn.com/9281912c23312bc0d08ab750afa588cc.png",
    "https://t6.rbxcdn.com/70608418c648be7ac4e323e3294bb059",
    "This audio asset has been blocked due to copyright violations."
};

-- // Return false if the Sound is not working
function MusicAPI.CheckSound(SoundId)
    local SoundURL = "https://www.roblox.com/library/" .. SoundId;
    local SoundSource = game:HttpGetAsync(SoundURL);

    for i = 1, #MusicAPI.RemovedAssets do
        local v = MusicAPI.RemovedAssets[i];
        
        if (SoundSource:find(v)) then
            return false;
        end;

        wait();
    end;

    return true;
end;

-- // Remove any duplicate Sounds
local function IsSoundInMusicTable(SoundId, MTable)
    for i = 1, #MTable do
        local v = MTable[i];
        
        if (v.SoundId == SoundId) then
            return true;
        end;
    end;
    
    return false;
end;
function MusicAPI.RemoveDuplicates(MTable)
    local Cleaned = {};
    
    for i = 1, #MTable do
        local v = MTable[i];
        
        if (not IsSoundInMusicTable(v.SoundId, Cleaned)) then
            table.insert(Cleaned, v);
            
            wait();
        end;
    end;

    return Cleaned;
end;

-- // Test all sounds
function MusicAPI.CheckAllSounds()
    local MusicTable = HttpService:JSONDecode(game:HttpGetAsync(MusicAPI.MusicTableLink));
    local Cleaned = {};
    local Count = 0;
    local StartTime = tick();

    -- // Remove duplicates
    MusicTable = MusicAPI.RemoveDuplicates(MusicTable);

    -- // Check over all the sounds
    for i = 1, #MusicTable do
        local v = MusicTable[i];
        local SoundId = v.SoundId;
        coroutine.wrap(function()
            if (MusicAPI.CheckSound(SoundId)) then
                Cleaned[#Cleaned + 1] = v;
                Count = Count + 1;
            else
                if (MusicAPI.Verbose) then warn('Audio Failed ' .. "#" .. i .. "/" .. #MusicTable .. ": " .. SoundId); end;
            end;
        end)();
    end;

    -- // Return
    repeat wait(2) until Count == #Cleaned;
    
    if (MusicAPI.Verbose) then print('Check All Sounds done in ' .. tick() - StartTime .. " seconds."); end;
    
    return Cleaned;
end;

function MusicAPI.Benchmark(FunctionToBench, Iterations, ...)
    local StartTime = tick();
    
    for i = 1, Iterations do
        FunctionToBench(...);
    end;
    
    return tick() - StartTime;
end;

--[[
    Benchmark Script:

    local BenchmarkTime = MusicAPI.Benchmark(MusicAPI.CheckAllSounds, 1);
    print(BenchmarkTime);
]]

-- // Set UUIDs
function MusicAPI.SetUUIDs()
    local MusicT = MusicAPI.MusicTable;
    
    for i = 1, #MusicT do
        local v = MusicT[i];
        v["UUID"] = i;
    end;

    return MusicT;
end;

-- // Save Music Table as JSON
function MusicAPI.SaveAsJSON()
    if (not writefile) then return false; end;
    
    local MusicTable = MusicAPI.SetUUIDs();
    local Content = HttpService:JSONEncode(MusicTable);
    
    writefile("MusicTable.json", Content);
end;

-- // Save to clipboard
function MusicAPI.SetClipboard()
    if (not setclipboard) then return false; end;

    local MusicTable = MusicAPI.MusicTable;
    local Credits = "Music API - Created By Stefanuk12 - Audio Count: " .. #MusicTable .. "\n";
    local String = Credits;

    for i = 1, #MusicTable do
        local v = MusicTable[i];
        String = String .. i .. " | " .. v.Name .. " (" .. v.SoundId .. ")\n";
    end;

    String = String .. Credits;

    setclipboard(String);
end;

return MusicAPI;