-- // Services
local Players = game:GetService("Players")

-- // Vars
local kohlsCommands = {
    ["fix"] = true,
    ["clear"] = true,
    ["logs"] = true,
    ["m"] = true,
    ["h"] = true,
    ["kill"] = true,
    ["respawn"] = true,
    ["reload"] = true,
    ["paint"] = true,
    ["unpaint"] = true,
    ["powerjump"] = true,
    ["normaljump"] = true,
    ["glow"] = true,
    ["unglow"] = true,
    ["trip"] = true,
    ["skydive"] = true,
    ["unskydive"] = true,
    ["size"] = true,
    ["unsize"] = true,
    ["stun"] = true,
    ["unstun"] = true,
    ["jump"] = true,
    ["sit"] = true,
    ["trail"] = true,
    ["particle"] = true,
    ["unparticle"] = true,
    ["invisible"] = true,
    ["visible"] = true,
    ["explode"] = true,
    ["bonfire"] = true,
    ["fire"] = true,
    ["unfire"] = true,
    ["smoke"] = true,
    ["unsmoke"] = true,
    ["sparkles"] = true,
    ["unsparkle"] = true,
    ["ff"] = true,
    ["unff"] = true,
    ["punish"] = true,
    ["unpunish"] = true,
    ["freeze"] = true,
    ["thaw"] = true,
    ["heal"] = true,
    ["god"] = true,
    ["ungod"] = true,
    ["ambient"] = true,
    ["outdoorambient"] = true,
    ["colorshiftbottom"] = true,
    ["colorshifttop"] = true,
    ["brightness"] = true,
    ["time"] = true,
    ["fogcolor"] = true,
    ["fogend"] = true,
    ["fogstart"] = true,
    ["removetools"] = true,
    ["damage"] = true,
    ["grav"] = true,
    ["setgrav"] = true,
    ["nograv"] = true,
    ["health"] = true,
    ["speed"] = true,
    ["name"] = true,
    ["unname"] = true,
    ["teleport"] = true,
    ["infect"] = true,
    ["rainbowify"] = true,
    ["flashify"] = true,
    ["noobify"] = true,
    ["ghostify"] = true,
    ["goldify"] = true,
    ["shiny"] = true,
    ["normal"] = true,
    ["package"] = true,
    ["unpackage"] = true,
    ["blind"] = true,
    ["unblind"] = true,
    ["guifix"] = true,
    ["fling"] = true,
    ["seizure"] = true,
    ["music"] = true,
    ["stopmusic"] = true,
    ["lock"] = true,
    ["unlock"] = true,
    ["removelimbs"] = true,
    ["jail"] = true,
    ["unjail"] = true,
    ["fly"] = true,
    ["unfly"] = true,
    ["noclip"] = true,
    ["clip"] = true,
    ["pm"] = true,
    ["dog"] = true,
    ["undog"] = true,
    ["creeper"] = true,
    ["uncreeper"] = true,
    ["char"] = true,
    ["unchar"] = true,
    ["rank"] = true,
    ["sword"] = true,
    ["bighead"] = true,
    ["normalhead"] = true,
    ["minihead"] = true,
    ["spin"] = true,
    ["disco"] = true,
    ["flash"] = true,
    ["musiclist"] = true,
    ["packagelist"] = true,
    ["facelist"] = true,
    ["cape"] = true,
    ["uncape"] = true,
    ["unspin"] = true,
    ["undisco"] = true,
    ["unflash"] = true,
    ["gear"] = true,
    ["hat"] = true,
    ["unhat"] = true,
    ["shirt"] = true,
    ["unshirt"] = true,
    ["tshirt"] = true,
    ["untshirt"] = true,
    ["pants"] = true,
    ["unpants"] = true,
    ["face"] = true,
    ["swagify"] = true,
    ["clone"] = true,
    ["unclone"] = true,
    ["removejails"] = true,
    ["removeclones"] = true
}
local personsCommands = {
    ["fix/"] = true,
    ["kill/"] = true,
    ["heal/"] = true,
    ["damage/"] = true,
    ["health/"] = true,
    ["explode/"] = true,
    ["rocket/"] = true,
    ["unrocket/"] = true,
    ["removetools/"] = true,
    ["sit/"] = true,
    ["jump/"] = true,
    ["stand/"] = true,
    ["part/"] = true,
    ["respawn/"] = true,
    ["jail/"] = true,
    ["unjail/"] = true,
    ["punish/"] = true,
    ["unpunish/"] = true,
    ["teleport/"] = true,
    ["control/"] = true,
    ["time/"] = true,
    ["ambient/"] = true,
    ["outdoorambient/"] = true,
    ["fogend/"] = true,
    ["fogstart/"] = true,
    ["unblind/"] = true,
    ["nograv/"] = true,
    ["antigrav/"] = true,
    ["grav/"] = true,
    ["highrav/"] = true,
    ["setgrav/"] = true,
    ["trip/"] = true,
    ["walkspeed/"] = true,
    ["invisible/"] = true,
    ["visible/"] = true,
    ["freeze/"] = true,
    ["thaw/"] = true,
    ["unlock/"] = true,
    ["lock/"] = true,
    ["ff/"] = true,
    ["unff/"] = true,
    ["sparkles/"] = true,
    ["unsparkles/"] = true,
    ["shield/"] = true,
    ["unshield/"] = true,
    ["god/"] = true,
    ["ungod/"] = true,
    ["zombify/"] = true,
    ["normal/"] = true,
    ["m/"] = true,
    ["h/"] = true,
    ["clear/"] = true,
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

    -- // Kohls Command
    if (Message:sub(1, 1) ~= " ") then
        -- // Kohls Commands
        if (FirstSpace > FirstSlash) then
            Message = Message:lower()
            local Command = Message:sub(1, FirstSpace - 1)

            -- // Check if command exists
            if (kohlsCommands[Command]) then
                local Body = Message:sub(FirstSpace + 1)
                local Arguments = Body:split(" ") or {}

                -- // Fire Events
                Players.CommandChatted:Fire(Player, Command, Arguments)
                Player.CommandChatted:Fire(Command, Arguments)
            end
        else -- // Persons299 Commands
            Message = Message:lower()
            local Command = Message:sub(1, FirstSpace - 1)

            -- // Check if command exists
            if (personsCommands[Command]) then
                local Body = Message:sub(FirstSpace + 1)
                local Arguments = Body:split("/") or {}

                -- // Fire Events
                Players.CommandChatted:Fire(Player, Command, Arguments)
                Player.CommandChatted:Fire(Command, Arguments)
            end
        end
    end
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