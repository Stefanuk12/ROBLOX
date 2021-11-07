-- // Services
local Players = game:GetService("Players")

-- // Vars
local LocalPlayer = Players.LocalPlayer

-- // Remove duplicates from array
local function RemoveDuplicates(Array)
    -- // Vars
    local Sorted = {}
    local ArrayB = {}

    -- // Loop through A
    for _, v in ipairs(Array) do
        -- // Make sure it isn't in B
        if (not table.find(ArrayB, v)) then
            table.insert(ArrayB, v)
            table.insert(Sorted, v)
        end
    end

    -- // Return sorted
    return Sorted
end

-- // Command handler class
local CommandHandler = {}
do
    -- //
    CommandHandler.__index = CommandHandler

    -- // Constructor
    function CommandHandler.new(Data)
        -- // Default values
        Data = Data or {}

        -- // Initialise
        local self = setmetatable({}, CommandHandler)

        -- // Set vars
        self.Members = Data.Members or {LocalPlayer}
        self.MemberType = Data.MemberType or "Whitelist"

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

    -- // Check if a user is whitelisted/blacklisted
    function CommandHandler.CheckUser(self, User)
        -- // Vars
        local isInMembers = table.find(self.Members, User) ~= nil

        -- // Return
        return (self.MemberType == "Whitelist" and isInMembers or not isInMembers)
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
        local IsAllowedUser = self:CheckUser(ExecutePlayer) and Command:CheckUser(ExecutePlayer)
        if (not IsAllowedUser) then
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

    -- // Generates a help menu
    function CommandHandler.HelpMenu(self)
        -- // Vars
        local Output = ""

        -- // Loop through each command
        for i, Command in ipairs(self.Commands) do
            -- // Add to output
            Output = Output .. self.Prefix .. tostring(Command) .. (i == #self.Commands and "" or "\n")
        end

        -- // Return
        return Output
    end
end

-- // Command class
local CommandClass = {}
do
    -- //
    CommandClass.__index = CommandClass

    -- //
    local tostringPattern = "%s -- %s"
    CommandClass.__tostring = function(t)
        local Name = table.concat(t.Name, "/")
        return tostringPattern:format(Name, t.Description)
    end

    -- // Constructor
    function CommandClass.new(Data)
        -- // Initialise
        local self = setmetatable({}, CommandClass)

        -- // Set Vars
        self.Active = Data.Active or true

        self.Members = Data.Members or {LocalPlayer}
        self.MemberType = Data.MemberType or "Whitelist"

        self.ArgParse = Data.ArgParse or {}
        self.ArgSeperator = Data.ArgSeperator or ""
        self.TargetSeperator = Data.TargetSeperator or nil
        self.Callback = Data.Callback or function() end
        self.Description = Data.Description or ""
        self.Handler = nil
        self.Name = Data.Name

        -- // Check if handler given
        if (Data.Handler) then
            -- // Set and add to handler
            self.Handler = Data.Handler
            self.Handler:AddCommand(self)
        end

        -- // Convert string name into table
        if (typeof(self.Name) == "string") then
            self.Name = {self.Name}
        end

        -- // Return
        return self
    end

    -- // Parses player type
    function CommandClass.ParsePlayerType(Argument, ExecutePlayer)
        -- // Yourself
        if (Argument == "me") then
            return {ExecutePlayer}
        end

        -- // Everyone
        if (Argument == "all") then
            return Players:GetPlayers()
        end

        -- // Everyone but yourself
        if (Argument == "others") then
            -- // Get everyone
            local AllPlayers = Players:GetPlayers()

            -- // Remove self
            table.remove(AllPlayers, table.find(AllPlayers, ExecutePlayer))

            -- //
            return AllPlayers
        end

        -- // Any random player
        if (Argument == "random") then
            -- // Get everyone
            local AllPlayers = Players:GetPlayers()

            -- // Select random player
            return {AllPlayers[math.random(1, #AllPlayers)]}
        end

        -- // Loop through each player
        for _, Player in ipairs(Players:GetPlayers()) do
            -- // See if their name matches
            if (Player.Name:lower():sub(1, #Argument) == Argument) then
                -- // Return
                return {Player}
            end
        end
    end

    -- // Parses a type
    function CommandClass.ParseType(ExecutePlayer, Argument, Type)
        -- // Skip strings/any type
        if (Type == "string" or Type == "any") then
            return Argument
        end
    
        -- // boolean
        if (Type == "boolean") then
            return Argument:lower() == "true"
        end

        -- // tonumber
        if (Type == "number") then
            return tonumber(Argument)
        end
        
        -- // colorrgb
        if (Type == "colorrgb") then
            -- // Split into three numbers
            local R = tonumber(Argument:sub(1, 3))
            local G = tonumber(Argument:sub(3, 6))
            local B = tonumber(Argument:sub(6, 9))

            -- // Make sure we have each
            if (R and G and B) then
                return Color3.fromRGB(R, G, B)
            else
                return Color3.fromRGB(0, 0, 0)
            end
        end
    
        -- // player
        if (Type == "player") then
            -- //
            if (self.TargetSeperator) then
                -- // Split to get each target
                local TargetsSplit = RemoveDuplicates(Argument:split(self.TargetSeperator))
                local Parsed = {}

                -- // Optimisation to skip if it's all
                if (table.find(TargetsSplit, "all")) then
                    return self.ParsePlayerType(TargetSplit, ExecutePlayer)
                end

                -- // Optimisation to do others
                local othersI = table.find(TargetsSplit, "others")
                if (othersI) then
                    Parsed = self.ParsePlayerType(TargetSplit, ExecutePlayer)
                    table.remove(Parsed, othersI)
                end

                -- // Loop through each target
                for _, TargetSplit in ipairs(TargetsSplit) do
                    -- // Parse each target to a player
                    local ParsedTargets = self.ParsePlayerType(TargetSplit, ExecutePlayer)[1]

                    -- // Make sure isn't already in there
                    if (not table.find(Parsed, Target)) then
                        -- // Add it
                        table.insert(Parsed, Target)

                        -- // Optimisations to check if everyone is already in there
                        if (othersI and Parsed == ExecutePlayer) then
                            break
                        end
                    end
                end

                -- // Return
                return Parsed
            end

            -- // Return
            return self.ParsePlayerType(Argument, ExecutePlayer)
        end

        -- // Return
        return Argument
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
                continue
            end

            -- // Attempt to parse
            local Parsed
            for _, Type in ipairs(Types) do
                -- // Parse
                Parsed = self:ParseType(ExecutePlayer, Argument, Type)

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

    -- // Check if a user is whitelisted/blacklisted
    function CommandClass.CheckUser(self, User)
        -- // Vars
        local isInMembers = table.find(self.Members, User) ~= nil

        -- // Return
        return (self.MemberType == "Whitelist" and isInMembers or not isInMembers)
    end
end

-- // Return
getgenv().CommandHandler = CommandHandler
getgenv().CommandClass = CommandClass
return CommandHandler, CommandClass