-- // Services
local Players = game:GetService("Players")

-- // Vars
local tablefind = table.find
local kohlsCommands = {
    "fix",
    "clear",
    "logs",
    "m",
    "h",
    "kill",
    "respawn",
    "reload",
    "paint",
    "unpaint",
    "powerjump",
    "normaljump",
    "glow",
    "unglow",
    "trip",
    "skydive",
    "unskydive",
    "size",
    "unsize",
    "stun",
    "unstun",
    "jump",
    "sit",
    "trail",
    "particle",
    "unparticle",
    "invisible",
    "visible",
    "explode",
    "bonfire",
    "fire",
    "unfire",
    "smoke",
    "unsmoke",
    "sparkles",
    "unsparkle",
    "ff",
    "unff",
    "punish",
    "unpunish",
    "freeze",
    "thaw",
    "heal",
    "god",
    "ungod",
    "ambient",
    "outdoorambient",
    "colorshiftbottom",
    "colorshifttop",
    "brightness",
    "time",
    "fogcolor",
    "fogend",
    "fogstart",
    "removetools",
    "damage",
    "grav",
    "setgrav",
    "nograv",
    "health",
    "speed",
    "name",
    "unname",
    "teleport",
    "infect",
    "rainbowify",
    "flashify",
    "noobify",
    "ghostify",
    "goldify",
    "shiny",
    "normal",
    "package",
    "unpackage",
    "blind",
    "unblind",
    "guifix",
    "fling",
    "seizure",
    "music",
    "stopmusic",
    "lock",
    "unlock",
    "removelimbs",
    "jail",
    "unjail",
    "fly",
    "unfly",
    "noclip",
    "clip",
    "pm",
    "dog",
    "undog",
    "creeper",
    "uncreeper",
    "char",
    "unchar",
    "rank",
    "sword",
    "bighead",
    "normalhead",
    "minihead",
    "spin",
    "disco",
    "flash",
    "musiclist",
    "packagelist",
    "facelist",
    "cape",
    "uncape",
    "unspin",
    "undisco",
    "unflash",
    "gear",
    "hat",
    "unhat",
    "shirt",
    "unshirt",
    "tshirt",
    "untshirt",
    "pants",
    "unpants",
    "face",
    "swagify",
    "clone",
    "unclone",
    "removejails",
    "removeclones"
}
local personsCommands = {
    "fix",
    "kill",
    "heal",
    "damage",
    "health",
    "explode",
    "rocket",
    "unrocket",
    "removetools",
    "sit",
    "jump",
    "stand",
    "part",
    "respawn",
    "jail",
    "unjail",
    "punish",
    "unpunish",
    "teleport",
    "control",
    "time",
    "ambient",
    "outdoorambient",
    "fogend",
    "fogstart",
    "unblind",
    "nograv",
    "antigrav",
    "grav",
    "highrav",
    "setgrav",
    "trip",
    "walkspeed",
    "invisible",
    "visible",
    "freeze",
    "thaw",
    "unlock",
    "lock",
    "ff",
    "unff",
    "sparkles",
    "unsparkles",
    "shield",
    "unshield",
    "god",
    "ungod",
    "zombify",
    "normal",
    "m",
    "h",
    "clear",
}

-- // Signal Constructor
local Signal = loadstring(game:HttpGet("https://raw.githubusercontent.com/Quenty/NevermoreEngine/version2/Modules/Shared/Events/Signal.lua"))()

-- // Add custom property to an Object
local addProperty = function(Object, Name, Value)
    local ObjectMT = getrawmetatable(Object)
    local ObjectMTIndex = ObjectMT.__index
    local ObjectMTNewIndex = ObjectMT.__newindex
    setreadonly(ObjectMT, false)

    ObjectMT.__index = newcclosure(function(t, k)
        if (t == Object and k == Name) then
            return Value
        end

        return ObjectMTIndex(t, k)
    end)

    ObjectMT.__newindex = newcclosure(function(t, k, v)
        if (t == Object and k == Name) then
            Value = v
            return
        end

        return ObjectMTNewIndex(t, k, v)
    end)

    setreadonly(ObjectMT, true)
end

-- // On Chatted
local onChatted = function(Player, Message)
    -- // Remove colon
    if (Message:sub(1, 1) == ":") then
        Message = Message:sub(2)
    end

    -- // Vars
    local FirstSpace = Message:find(" ") or -1
    local FirstSlash = Message:find("/") or -1

    -- // If someone does ": kill" or " kill", that invalids the command
    if (Message:sub(1, 1) == " ") then
        return
    end

    -- // Vars
    local Command
    local Body
    local Arguments = {}

    -- // Check if Kohls Admin
    local IsKohls = FirstSpace > FirstSlash
    if (IsKohls) then
        -- // Check if command exists
        Command = Message:sub(1, FirstSpace - 1):lower()
        if not (tablefind(kohlsCommands, Command)) then
            return
        end

        -- //
        Body = Message:sub(FirstSpace + 1)
        Arguments = Body:split(" ")
    else -- // Persons299 Admin
        -- // Check if command exists
        Command = Message:sub(1, FirstSlash - 1):lower()
        if not (tablefind(personsCommands, Command)) then
            return
        end

        -- //
        Body = Message:sub(FirstSlash + 1)
        Arguments = Body:split("/")
    end

    -- // Fire Events
    Players.CommandChatted:Fire(Player, Command, Arguments)
    Player.CommandChatted:Fire(Command, Arguments)
end

-- // Initialise Player
addProperty(Players, "CommandChatted", Signal.new("CommandChatted"))
local initPlayer = function(Player)
    addProperty(Player, "CommandChatted", Signal.new("CommandChatted"))

    Player.Chatted:Connect(function(Message)
        onChatted(Player, Message)
    end)
end

-- // Initialise all players
do
    local allPlayers = Players:GetPlayers()
    for _, Player in ipairs(allPlayers) do
        initPlayer(Player)
    end
end

-- // Initialise new players
Players.PlayerAdded:Connect(initPlayer)