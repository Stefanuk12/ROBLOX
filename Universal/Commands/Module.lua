-- // Services
local Players = game:GetService("Players")

-- // Vars
local LocalPlayer = Players.LocalPlayer

-- // Command handler class
local CommandHandler = {}
do
    -- //
    CommandHandler.__index = CommandHandler

    -- // Constructor
    function CommandHandler.new(Data)
        -- // Initialise
        local self = setmetatable({}, CommandHandler)

        -- // Set vars
        self.AllowedUsers = Data.AllowedUsers or {LocalPlayer}
        self.ArgSeperator = Data.ArgSeperator or " "
        self.ChatListenerConnections = {}
        self.Commands = Data.Commands or {}
        self.Prefix = Data.Prefix or "!"

        -- // Return
        return self
    end

    -- // Add Command
    function CommandHandler.AddCommand(self, _Command)
        _Command.Handler = self
        table.insert(self.Commands, _Command)
    end

    -- //
    function CommandHandler.Execute(self, ExecutePlayer, Message)
        -- // Prefix failsafe
        if (self.Prefix ~= "") then
            -- // Check if starts with prefix
            if not (Message:sub(1, 1) == self.Prefix) then
                return
            end

            -- // Trim prefix off
            Message = Message:sub(2)
        end

        -- // Vars
        local Command
        local SeperatorIndex = Message:find(self.ArgSeperator) or 0
        local CommandName = Message:sub(1, SeperatorIndex - 1)

        -- // Loop through each command
        for _, _Command in ipairs(self.Commands) do
            -- // Find the command
            if (table.find(_Command.Name, CommandName) and _Command.Active) then
                -- // Set
                Command = _Command

                -- // Break
                break
            end
        end

        -- // Make sure command exists
        if not (Command) then
            return
        end

        -- // Make sure was executed by allowed player
        if not (table.find(self.AllowedUsers, ExecutePlayer) and table.find(Command.AllowedUsers, ExecutePlayer)) then
            return
        end

        -- // Get arguments
        local Body = SeperatorIndex == 0 and "" or Message:sub(SeperatorIndex + 1)
        local Arguments = Body:split(self.ArgSeperator)

        -- // Remove "ghost argument"
        if (#Arguments == 1 and Arguments[1] == "") then
            Arguments = {}
        end

        -- // Parse arguments
        local MissedArguments
        Arguments, MissedArguments = Command:ParseArguments(ExecutePlayer, Arguments)

        -- // Ignore if missed any arguments
        if (MissedArguments) then
            return
        end

        -- // Callback
        Command.Callback(ExecutePlayer, Arguments)
    end

    -- // Starts a chat listener to all players
    function CommandHandler.StartChatListen(self)
        -- // Start a listener for all current players
        local Connection = Players.PlayerChatted:Connect(function(ChatType, Player, Message, TargetPlayer)
            self:Execute(Player, Message)
        end)

        -- // Add to connections
        table.insert(self.ChatListenerConnections, Connection)
    end
end

-- // Command class
local CommandClass = {}
do
    -- //
    CommandClass.__index = CommandClass

    -- // Constructor
    function CommandClass.new(Data)
        -- // Initialise
        local self = setmetatable({}, CommandClass)

        -- // Set Vars
        self.Active = Data.Active or true
        self.AllowedUsers = Data.AllowedUsers or {LocalPlayer}
        self.ArgParse = Data.ArgParse or {}
        self.ArgSeperator = Data.ArgSeperator or ""
        self.Callback = Data.Callback or function() end
        self.Handler = nil
        self.Name = Data.Name

        -- // Check if handler given
        if (Data.Handler) then
            -- // Set and add to handler
            self.Handler = Data.Handler
            self.Handler:AddCommand(self)
        end

        -- // Return
        return self
    end

    -- // Parses a type
    function CommandClass.ParseType(ExecutePlayer, Argument, Type)
        -- // Vars
        local Parsed = nil

        -- // Parse
        if (Type == "string" or Type == "any") then
            Parsed = Argument
        elseif (Type == "number") then
            Parsed = tonumber(Argument)
        elseif (Type == "color") then
            -- // Split into three numbers
            local R = tonumber(Argument:sub(1, 3))
            local G = tonumber(Argument:sub(3, 6))
            local B = tonumber(Argument:sub(6, 9))

            -- // Make sure we have each
            if (R and G and B) then
                Parsed = Color3.fromRGB(R, G, B)
            end
        elseif (Type == "player") then
            if (Parsed == "me") then
                Parsed = ExecutePlayer
            elseif (Parsed == "all") then
                -- // Get everyone
                Parsed = Players:GetPlayers()
            elseif (Parsed == "others") then
                -- // Get everyone
                local AllPlayers = Players:GetPlayers()

                -- // Remove self
                table.remove(AllPlayers, table.find(AllPlayers, ExecutePlayer))

                -- //
                Parsed = AllPlayers
            elseif (Parsed == "random") then
                -- // Get everyone
                local AllPlayers = Players:GetPlayers()

                -- // Select random player
                Parsed = AllPlayers[math.random(1, #AllPlayers)]
            else
                -- // Loop through each player
                for _, Player in ipairs(Players:GetPlayers()) do
                    -- // See if their name matches
                    if (Player.Name:lower():sub(1, #Argument) == Argument) then
                        -- // Set
                        Parsed = Player

                        -- // Break
                        break
                    end
                end
            end
        else
            Parsed = Argument
        end

        -- // Return
        return Parsed
    end

    -- // Parse Arguments
    function CommandClass.ParseArguments(self, ExecutePlayer, Arguments)
        -- // Vars
        local ParsedArguments = Arguments
        local MissedArguments = false

        -- // Loop through each argument type
        for i, Types in ipairs(self.ArgParse) do
            -- // Vars
            local Argument = Arguments[i]

            -- // Convert string -> table
            if (typeof(Types) == "string") then
                Types = {Types}
                self.ArgParse[i] = Types
            end

            -- // Check for missing arguments
            local isOptional = table.find(Types, "optional")
            if (not isOptional and not Argument) then
                MissedArguments = true
                ParsedArguments[i] = nil
                warn("missed")
                continue
            end

            -- // Attempt to parse
            local Parsed
            for _, Type in ipairs(Types) do
                -- // Parse
                Parsed = self.ParseType(ExecutePlayer, Argument, Type)

                -- // Stop if parsed
                if (Parsed) then
                    continue
                end
            end

            -- // Set
            ParsedArguments[i] = Parsed
        end

        -- //
        return ParsedArguments, MissedArguments
    end
end

-- // Return
-- getgenv().CommandHandler = CommandHandler
-- getgenv().CommandClass = CommandClass
return CommandHandler, CommandClass