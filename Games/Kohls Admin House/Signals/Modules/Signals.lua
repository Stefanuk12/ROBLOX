-- // Services
local Players = game:GetService("Players")

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

-- // Command stuff
do
    -- //
    local tablefind = table.find
    local tableremove = table.remove
    local tableinsert = table.insert

    -- // Format command arguments correctly
    local formatArguments = function(Player, Command, Arguments)
        -- // Vars
        local Targets = {}
        local CommandArguments = Command.Arguments
        local TargetIndex = tablefind(CommandArguments, "player") or -1

        -- // Find target index
        for i, Argument in ipairs(CommandArguments) do
            if (Argument == "number") then
                local _Argument = Arguments[i]
                Arguments[i] = tonumber(Argument) or _Argument
            end
        end

        -- // Check if there are any targets
        if (TargetIndex == -1) then
            return {Arguments = Arguments, Targets = Targets, TargetIndex = -1}
        end

        -- // Get Targets
        for _, Target in ipairs(Arguments[TargetIndex]:split(",")) do
            -- // Lower
            Target = Target:lower()

            -- // Affect self
            if (Target == "me" and not tablefind(Targets, Player)) then
                tableinsert(Targets, Player)
            elseif (Target == "others") then
                -- // Affect others
                local others = Players:GetPlayers()
                local selfIndex = tablefind(others, Player)

                tableremove(others, selfIndex)
            elseif (Targets == "all") then
                -- // Affect everyone
                Targets = Players:GetPlayers()
            else
                -- // Affect individual
                for _, _Player in ipairs(Players:GetPlayers()) do
                    if (_Player.Name:lower():sub(1, #Target) == Target and not tablefind(Targets, Player)) then
                        tableinsert(Targets, _Player)
                    end
                end
            end
        end

        -- // Return
        return {Arguments = Arguments, Targets = Targets}
    end

    -- // Every command in the game
    local Commands = {
        Kohls = {
            ["fix"] = {Arguments = {"player"}},
            ["clear"] = {Arguments = {"player"}},
            ["logs"] = {Arguments = {"player"}},
            ["m"] = {Arguments = {"string"}},
            ["message"] = {Arguments = {"string"}},
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
            ["fix"] = {Arguments = {}},
            ["kill"] = {Arguments = {"player"}},
            ["heal"] = {Arguments = {"player"}},
            ["damage"] = {Arguments = {"player", "number"}},
            ["health"] = {Arguments = {"player", "number"}},
            ["explode"] = {Arguments = {"player"}},
            ["rocket"] = {Arguments = {"player"}},
            ["unrocket"] = {Arguments = {"player"}},
            ["removetools"] = {Arguments = {"player"}},
            ["sit"] = {Arguments = {"player"}},
            ["jump"] = {Arguments = {"player"}},
            ["stand"] = {Arguments = {"player"}},
            ["part"] = {Arguments = {"number", "number", "number"}},
            ["respawn"] = {Arguments = {"player"}},
            ["jail"] = {Arguments = {"player"}},
            ["unjail"] = {Arguments = {"player"}},
            ["punish"] = {Arguments = {"player"}},
            ["unpunish"] = {Arguments = {"player"}},
            ["teleport"] = {Arguments = {"player", "string"}},
            ["control"] = {Arguments = {"player"}},
            ["time"] = {Arguments = {"number"}},
            ["ambient"] = {Arguments = {"number"}},
            ["outdoorambient"] = {Arguments = {"number", "number", "number"}},
            ["fogend"] = {Arguments = {"number"}},
            ["fogstart"] = {Arguments = {"number"}},
            ["unblind"] = {Arguments = {"player"}},
            ["nograv"] = {Arguments = {"player"}},
            ["antigrav"] = {Arguments = {"player"}},
            ["grav"] = {Arguments = {"player"}},
            ["highrav"] = {Arguments = {"player"}},
            ["setgrav"] = {Arguments = {"player", "number"}},
            ["trip"] = {Arguments = {"player"}},
            ["walkspeed"] = {Arguments = {"player", "number"}},
            ["invisible"] = {Arguments = {"player"}},
            ["visible"] = {Arguments = {"player"}},
            ["freeze"] = {Arguments = {"player"}},
            ["thaw"] = {Arguments = {"player"}},
            ["unlock"] = {Arguments = {"player"}},
            ["lock"] = {Arguments = {"player"}},
            ["ff"] = {Arguments = {"player"}},
            ["unff"] = {Arguments = {"player"}},
            ["sparkles"] = {Arguments = {"player"}},
            ["unsparkles"] = {Arguments = {"player"}},
            ["shield"] = {Arguments = {"player"}},
            ["unshield"] = {Arguments = {"player"}},
            ["god"] = {Arguments = {"player"}},
            ["ungod"] = {Arguments = {"player"}},
            ["zombify"] = {Arguments = {"player"}},
            ["normal"] = {Arguments = {"player"}},
            ["m"] = {Arguments = {"player"}},
            ["message"] = {Arguments = {"string"}},
            ["h"] = {Arguments = {"player"}},
            ["clear"] = {Arguments = {"player"}},
        }
    }
    local kohlsCommands = Commands.Kohls
    local personsCommands = Commands.Persons

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
        if (Message:sub(1, 1) ~= " ") then
            return
        end

        -- // Vars
        local Command
        local CommandData
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
            CommandData = kohlsCommands[Command]
            Body = Message:sub(FirstSpace + 1)
            Arguments = formatArguments(Player, CommandData, Body:split(" "))
        else -- // Persons299 Admin
            -- // Check if command exists
            Command = Message:sub(1, FirstSlash - 1):lower()
            if not (tablefind(personsCommands, Command)) then
                return
            end

            -- //
            CommandData = personsCommands[Command]
            Body = Message:sub(FirstSlash + 1)
            Arguments = formatArguments(Player, CommandData, Body:split("/"))
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
end

-- // Return
return addProperty