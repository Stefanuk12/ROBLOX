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
local Signal = {}
do
    -- // Credit: https://raw.githubusercontent.com/Quenty/NevermoreEngine/version2/Modules/Shared/Events/Signal.lua

    --- Lua-side duplication of the API of events on Roblox objects.
    -- Signals are needed for to ensure that for local events objects are passed by
    -- reference rather than by value where possible, as the BindableEvent objects
    -- always pass signal arguments by value, meaning tables will be deep copied.
    -- Roblox's deep copy method parses to a non-lua table compatable format.
    -- @classmod Signal

    local ENABLE_TRACEBACK = false

    Signal.ClassName = "Signal"

    --- Constructs a new signal.
    -- @constructor Signal.new()
    -- @treturn Signal
    function Signal.new(Name)
        Name = Name or ""
        local self = setmetatable({}, {
            __index = Signal,
            __type = "CustomScriptSignal",
            __tostring = function()
                return "Signal " .. Name
            end
        })

        self._bindableEvent = Instance.new("BindableEvent")
        self._argData = nil
        self._argCount = nil -- Prevent edge case of :Fire("A", nil) --> "A" instead of "A", nil

        self._source = ENABLE_TRACEBACK and debug.traceback() or ""

        return self
    end

    --- Fire the event with the given arguments. All handlers will be invoked. Handlers follow
    -- Roblox signal conventions.
    -- @param ... Variable arguments to pass to handler
    -- @treturn nil
    function Signal:Fire(...)
        if not self._bindableEvent then
            warn(("Signal is already destroyed. %s"):format(self._source))
            return
        end

        self._argData = {...}
        self._argCount = select("#", ...)
        self._bindableEvent:Fire()
        -- self._argData = nil
        -- self._argCount = nil
    end

    --- Connect a new handler to the event. Returns a connection object that can be disconnected.
    -- @tparam function handler Function handler called with arguments passed when `:Fire(...)` is called
    -- @treturn Connection Connection object that can be disconnected
    function Signal:Connect(handler)
        if not (type(handler) == "function") then
            error(("connect(%s)"):format(typeof(handler)), 2)
        end

        return self._bindableEvent.Event:Connect(function()
            handler(unpack(self._argData, 1, self._argCount))
        end)
    end

    --- Wait for fire to be called, and return the arguments it was given.
    -- @treturn ... Variable arguments from connection
    function Signal:Wait()
        self._bindableEvent.Event:Wait()
        assert(self._argData, "Missing arg data, likely due to :TweenSize/Position corrupting threadrefs.")
        return unpack(self._argData, 1, self._argCount)
    end

    --- Disconnects all connected events to the signal. Voids the signal as unusable.
    -- @treturn nil
    function Signal:Destroy()
        if self._bindableEvent then
            self._bindableEvent:Destroy()
            self._bindableEvent = nil
        end

        self._argData = nil
        self._argCount = nil

        setmetatable(self, nil)
    end
end

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
    local Body = Message:sub(FirstSpace + 1)
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
        Arguments = Body:split(" ")
    else -- // Persons299 Admin
        -- // Check if command exists
        Command = Message:sub(1, FirstSlash - 1):lower()
        if not (tablefind(personsCommands, Command)) then
            return
        end

        -- //
        Arguments = Body:split("/")
    end

    -- // Fire Events
    Players.CommandChatted:Fire(Player, Command, Arguments)
    Player.CommandChatted:Fire(Command, Arguments)
end

-- // Initialise Player
local initPlayer = function(Player)
    addProperty(Players, "CommandChatted", Signal.new("CommandChatted"))
    addProperty(Player, "CommandChatted", Signal.new("CommandChatted"))

    Player.Chatted:Connect(function(Message)
        onChatted(Player, Message)
    end)
end

-- // Initialise all players
do
    local allPlayers = Players:GetPlayers()
    for i = 1, #allPlayers do
        local Player = allPlayers[i]

        initPlayer(Player)
    end
end

-- // Initialise new players
Players.PlayerAdded:Connect(initPlayer)