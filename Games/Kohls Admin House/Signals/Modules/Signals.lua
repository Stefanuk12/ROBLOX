-- // Services
local Players = game:GetService("Players")

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

-- // Command stuff
do
    -- // Array find
    local arrayFind = function(Array, Find)
        for i = 1, #Array do
            local result = Array[i]

            if (result == Find) then
                return i
            end
        end
    end

    -- // Format command arguments correctly
    local formatArguments = function(Player, Command, Arguments)
        -- // Vars
        local Template = {Arguments = Arguments, Targets = {}, TargetIndex = -1}
        local TargetIndex = Template.TargetIndex

        -- // Find target index
        for i = 1, #Command.Arguments do
            local Argument = Command.Arguments[i]

            if (Argument == "player") then
                TargetIndex = i
            elseif (Argument == "number") then
                local _Argument = Template.Arguments[i]
                Template.Arguments[i] = tonumber(Argument) or _Argument
            end
        end

        -- // Check if there are any targets
        if (TargetIndex ~= -1) then
            -- // Get Targets
            local Targets = Arguments[TargetIndex]:split(",")
            for i = 1, #Targets do
                local Target = Targets[i]

                -- // Affect self
                if (Target == "me" and not arrayFind(Template.Targets, Player)) then
                    Template.Targets[#Template.Targets + 1] = Player
                elseif (Target == "others") then -- // Affect others
                    local others = Players:GetPlayers()
                    local selfIndex = arrayFind(others, Player)

                    table.remove(others, selfIndex)
                elseif (Targets == "all") then -- // Affect everyone
                    Template.Targets = Players:GetPlayers()
                else -- // Affect individual
                    local allPlayers = Players:GetPlayers()
                    for i2 = 1, #allPlayers do
                        local _Player = allPlayers[i2]

                        if (_Player.Name:lower():sub(1, #Target) == Target:lower() and not arrayFind(Template.Targets, Player)) then
                            Template.Targets[#Template.Targets + 1] = _Player
                        end
                    end
                end
            end

            -- // Set Arguments
            table.remove(Template.Arguments, TargetIndex)
        end

        -- // Return
        return Template
    end

    -- // Every command in the game
    local Commands = {
        Kohls = {
            ["fix"] = {Arguments = {"player"}},
            ["clear"] = {Arguments = {"player"}},
            ["logs"] = {Arguments = {"player"}},
            ["m"] = {Arguments = {"string"}},
            ["h"] = {Arguments = {"string"}},
            ["kill"] = {Arguments = {"player"}},
            ["respawn"] = {Arguments = {"player"}},
            ["reload"] = {Arguments = {"player"}},
            ["paint"] = {Arguments = {"player", "string"}},
            ["unpaint"] = {Arguments = {"player"}},
            ["powerjump"] = {Arguments = {"player"}},
            ["normaljump"] = {Arguments = {"player"}},
            ["glow"] = {Arguments = {"player", "number", "number", "number"}},
            ["unglow"] = {Arguments = {"player"}},
            ["trip"] = {Arguments = {"player"}},
            ["skydive"] = {Arguments = {"player"}},
            ["unskydive"] = {Arguments = {"player"}},
            ["size"] = {Arguments = {"player", "number"}},
            ["unsize"] = {Arguments = {"player", "number"}},
            ["stun"] = {Arguments = {"player"}},
            ["unstun"] = {Arguments = {"player"}},
            ["jump"] = {Arguments = {"player"}},
            ["sit"] = {Arguments = {"player"}},
            ["trail"] = {Arguments = {"player", "string"}},
            ["particle"] = {Arguments = {"player", "string"}},
            ["unparticle"] = {Arguments = {"player"}},
            ["invisible"] = {Arguments = {"player"}},
            ["visible"] = {Arguments = {"player"}},
            ["explode"] = {Arguments = {"player"}},
            ["bonfire"] = {Arguments = {"player"}},
            ["fire"] = {Arguments = {"player"}},
            ["unfire"] = {Arguments = {"player"}},
            ["smoke"] = {Arguments = {"player"}},
            ["unsmoke"] = {Arguments = {"player"}},
            ["sparkles"] = {Arguments = {"player"}},
            ["unsparkle"] = {Arguments = {"player"}},
            ["ff"] = {Arguments = {"player"}},
            ["unff"] = {Arguments = {"player"}},
            ["punish"] = {Arguments = {"player"}},
            ["unpunish"] = {Arguments = {"player"}},
            ["freeze"] = {Arguments = {"player"}},
            ["thaw"] = {Arguments = {"player"}},
            ["heal"] = {Arguments = {"player"}},
            ["god"] = {Arguments = {"player"}},
            ["ungod"] = {Arguments = {"player"}},
            ["ambient"] = {Arguments = {"number", "number", "number"}},
            ["outdoorambient"] = {Arguments = {"number", "number", "number"}},
            ["colorshiftbottom"] = {Arguments = {"number", "number", "number"}},
            ["colorshifttop"] = {Arguments = {"number", "number", "number"}},
            ["brightness"] = {Arguments = {"number"}},
            ["time"] = {Arguments = {"number"}},
            ["fogcolor"] = {Arguments = {"number", "number", "number"}},
            ["fogend"] = {Arguments = {"number"}},
            ["fogstart"] = {Arguments = {"number"}},
            ["removetools"] = {Arguments = {"player"}},
            ["damage"] = {Arguments = {"player"}},
            ["grav"] = {Arguments = {"player"}},
            ["setgrav"] = {Arguments = {"player", "number"}},
            ["nograv"] = {Arguments = {"player"}},
            ["health"] = {Arguments = {"player", "number"}},
            ["speed"] = {Arguments = {"player", "number"}},
            ["name"] = {Arguments = {"player", "string"}},
            ["unname"] = {Arguments = {"player"}},
            ["teleport"] = {Arguments = {"player", "player"}},
            ["infect"] = {Arguments = {"player"}},
            ["rainbowify"] = {Arguments = {"player"}},
            ["flashify"] = {Arguments = {"player"}},
            ["noobify"] = {Arguments = {"player"}},
            ["ghostify"] = {Arguments = {"player"}},
            ["goldify"] = {Arguments = {"player"}},
            ["shiny"] = {Arguments = {"player"}},
            ["normal"] = {Arguments = {"player"}},
            ["package"] = {Arguments = {"player", "number"}},
            ["unpackage"] = {Arguments = {"player"}},
            ["blind"] = {Arguments = {"player"}},
            ["unblind"] = {Arguments = {"player"}},
            ["guifix"] = {Arguments = {"player"}},
            ["fling"] = {Arguments = {"player"}},
            ["seizure"] = {Arguments = {"player"}},
            ["music"] = {Arguments = {"player", "number"}},
            ["stopmusic"] = {Arguments = {}},
            ["lock"] = {Arguments = {"player"}},
            ["unlock"] = {Arguments = {"player"}},
            ["removelimbs"] = {Arguments = {"player"}},
            ["jail"] = {Arguments = {"player"}},
            ["unjail"] = {Arguments = {"player"}},
            ["fly"] = {Arguments = {"player"}},
            ["unfly"] = {Arguments = {"player"}},
            ["noclip"] = {Arguments = {"player"}},
            ["clip"] = {Arguments = {"player"}},
            ["pm"] = {Arguments = {"player", "string"}},
            ["dog"] = {Arguments = {"player"}},
            ["undog"] = {Arguments = {"player"}},
            ["creeper"] = {Arguments = {"player"}},
            ["uncreeper"] = {Arguments = {"player"}},
            ["char"] = {Arguments = {"player", "number"}},
            ["unchar"] = {Arguments = {"player", "number"}},
            ["rank"] = {Arguments = {"player", "number"}},
            ["sword"] = {Arguments = {"player"}},
            ["bighead"] = {Arguments = {"player"}},
            ["normalhead"] = {Arguments = {"player"}},
            ["minihead"] = {Arguments = {"player"}},
            ["spin"] = {Arguments = {"player"}},
            ["disco"] = {Arguments = {"player"}},
            ["flash"] = {Arguments = {"player"}},
            ["musiclist"] = {Arguments = {"player"}},
            ["packagelist"] = {Arguments = {"player"}},
            ["facelist"] = {Arguments = {"player"}},
            ["cape"] = {Arguments = {"player", "string"}},
            ["uncape"] = {Arguments = {"player"}},
            ["unspin"] = {Arguments = {"player"}},
            ["undisco"] = {Arguments = {"player"}},
            ["unflash"] = {Arguments = {"player"}},
            ["gear"] = {Arguments = {"player", "number"}},
            ["hat"] = {Arguments = {"player", "number"}},
            ["unhat"] = {Arguments = {"player"}},
            ["shirt"] = {Arguments = {"player", "number"}},
            ["unshirt"] = {Arguments = {"player"}},
            ["tshirt"] = {Arguments = {"player", "number"}},
            ["untshirt"] = {Arguments = {"player"}},
            ["pants"] = {Arguments = {"player", "number"}},
            ["unpants"] = {Arguments = {"player"}},
            ["face"] = {Arguments = {"player", "number"}},
            ["swagify"] = {Arguments = {"player"}},
            ["clone"] = {Arguments = {"player"}},
            ["unclone"] = {Arguments = {"player"}},
            ["removejails"] = {Arguments = {"player"}},
            ["removeclones"] = {Arguments = {"player"}}
        },
        Persons = {
            ["fix/"] = {Arguments = {}},
            ["kill/"] = {Arguments = {"player"}},
            ["heal/"] = {Arguments = {"player"}},
            ["damage/"] = {Arguments = {"player", "number"}},
            ["health/"] = {Arguments = {"player", "number"}},
            ["explode/"] = {Arguments = {"player"}},
            ["rocket/"] = {Arguments = {"player"}},
            ["unrocket/"] = {Arguments = {"player"}},
            ["removetools/"] = {Arguments = {"player"}},
            ["sit/"] = {Arguments = {"player"}},
            ["jump/"] = {Arguments = {"player"}},
            ["stand/"] = {Arguments = {"player"}},
            ["part/"] = {Arguments = {"number", "number", "number"}},
            ["respawn/"] = {Arguments = {"player"}},
            ["jail/"] = {Arguments = {"player"}},
            ["unjail/"] = {Arguments = {"player"}},
            ["punish/"] = {Arguments = {"player"}},
            ["unpunish/"] = {Arguments = {"player"}},
            ["teleport/"] = {Arguments = {"player", "string"}},
            ["control/"] = {Arguments = {"player"}},
            ["time/"] = {Arguments = {"number"}},
            ["ambient/"] = {Arguments = {"number"}},
            ["outdoorambient/"] = {Arguments = {"number", "number", "number"}},
            ["fogend/"] = {Arguments = {"number"}},
            ["fogstart/"] = {Arguments = {"number"}},
            ["unblind/"] = {Arguments = {"player"}},
            ["nograv/"] = {Arguments = {"player"}},
            ["antigrav/"] = {Arguments = {"player"}},
            ["grav/"] = {Arguments = {"player"}},
            ["highrav/"] = {Arguments = {"player"}},
            ["setgrav/"] = {Arguments = {"player", "number"}},
            ["trip/"] = {Arguments = {"player"}},
            ["walkspeed/"] = {Arguments = {"player", "number"}},
            ["invisible/"] = {Arguments = {"player"}},
            ["visible/"] = {Arguments = {"player"}},
            ["freeze/"] = {Arguments = {"player"}},
            ["thaw/"] = {Arguments = {"player"}},
            ["unlock/"] = {Arguments = {"player"}},
            ["lock/"] = {Arguments = {"player"}},
            ["ff/"] = {Arguments = {"player"}},
            ["unff/"] = {Arguments = {"player"}},
            ["sparkles/"] = {Arguments = {"player"}},
            ["unsparkles/"] = {Arguments = {"player"}},
            ["shield/"] = {Arguments = {"player"}},
            ["unshield/"] = {Arguments = {"player"}},
            ["god/"] = {Arguments = {"player"}},
            ["ungod/"] = {Arguments = {"player"}},
            ["zombify/"] = {Arguments = {"player"}},
            ["normal/"] = {Arguments = {"player"}},
            ["m/"] = {Arguments = {"player"}},
            ["h/"] = {Arguments = {"player"}},
            ["clear/"] = {Arguments = {"player"}},
        }
    }

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
            Message = Message:lower()

            -- // Kohls Commands
            if (FirstSpace > FirstSlash) then
                local Command = Message:sub(1, FirstSpace - 1)
                local CommandData = Commands.Kohls[Command]

                -- // Check if command exists
                if (Command and CommandData) then
                    local Body = Message:sub(FirstSpace + 1)
                    local Arguments = formatArguments(Player, CommandData, Body:split(" "))

                    -- // Fire Events
                    Players.CommandChatted:Fire(Player, Command, Arguments)
                    Player.CommandChatted:Fire(Command, Arguments)
                end
            else -- // Persons299 Commands
                local Command = Message:sub(1, FirstSpace - 1)
                local CommandData = Commands.Kohls[Command]

                -- // Check if command exists
                if (Command and CommandData) then
                    local Body = Message:sub(FirstSpace + 1)
                    local Arguments = formatArguments(Player, CommandData, Body:split("/"))

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
end

-- // Return
return addProperty