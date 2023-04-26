-- // Wait until the game is loaded
repeat task.wait() until game:IsLoaded()

-- // Services
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")

-- // Vars
local LocalPlayer = Players.LocalPlayer
local queue_on_teleport = (syn and syn.queue_on_teleport) or (fluxus and fluxus.queue_on_teleport) or queue_on_teleport or function(Script) end

-- // Utilities
local Utilities = {}
do
    -- // Combine two tables
    function Utilities.CombineTables(Base, ToAdd)
        -- // Default
        Base = Base or {}
        ToAdd = ToAdd or {}

        -- // Loop through data we want to add
        for i, v in pairs(ToAdd) do
            -- // Recursive
            local BaseValue = Base[i] or false
            if (typeof(v) == "table" and typeof(BaseValue) == "table") then
                Utilities.CombineTables(BaseValue, v)
                continue
            end

            -- // Set
            Base[i] = v
        end

        -- // Return
        return Base
    end

    -- // Deep copying
    function Utilities.DeepCopy(Original)
        -- // Assert
        assert(typeof(Original) == "table", "invalid type for Original (expected table)")

        -- // Vars
        local Copy = {}

        -- // Loop through original
        for i, v in pairs(Original) do
            -- // Recursion if table
            if (typeof(v) == "table") then
                v = Utilities.DeepCopy(v)
            end

            -- // Set
            Copy[i] = v
        end

        -- // Return the copy
        return Copy
    end
end

-- // Hop Manager
local HopManager = {}
HopManager.__index = HopManager
HopManager.__type = "HopManager"
do
    -- // Default data
    HopManager.DefaultData = {
        HopMode = "Random", -- // if a number, that index will be selected. options: (number), Random, Middle
        KickBeforeTeleport = true,
        KickMessage = "Teleporting...",
        MinimumPlayers = 1,
        MaximumPlayers = 1/0,
        HopInterval = 300,
        RetryDelay = 1,
        DataRetryDelay = 1,
        SaveLocation = "recenthops.json",
        ServerFormat = "https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=100&excludeFullGames=true&cursor=%s",
        RecentHops = {},
        MassServerList = {
            Enabled = false,
            RemoveAfterTeleport = false,
            Refresh = 300,
            Amount = 500,
            MinimumServers = 100,
            SaveLocation = "massserver.json",
        },
        RetrySame = {
            Enum.TeleportResult.Flooded
        }
    }

    -- // Constructor
    function HopManager.new(Data)
        -- // Default and assert
        Data = Data or {}
        assert(typeof(Data) == "table", "invalid type for Data (expected table)")

        -- // Create the object
        local self = setmetatable({}, HopManager)

        -- // Load the defaults
        self.Data = Utilities.CombineTables(Utilities.DeepCopy(HopManager.DefaultData), Data)

        -- // Load the recent hops
        self:LoadFromFile()

        -- // Return the object
        return self
    end

    -- // Load hop data
    function HopManager:LoadFromFile()
        -- // Get the data
        local Data = self.Data
        local RecentHopData = isfile(Data.SaveLocation) and readfile(Data.SaveLocation) or "{}"

        -- // Decode it
        local _, RecentHops = pcall(HttpService.JSONDecode, HttpService, RecentHopData)
        Data.RecentHops = typeof(RecentHops) == "table" and RecentHops or {}

        -- // Return it
        return Data.RecentHops
    end

    -- // Saves the hop data to to a file
    function HopManager:Save()
        local Data = self.Data
        writefile(Data.SaveLocation, HttpService:JSONEncode(Data.RecentHops))
    end

    -- // Set hop data
    function HopManager:SaveJobId(JobId)
        -- // Assert
        assert(typeof(JobId) == "string", "invalid type for JobId (expected string)")

        -- // Add it and save
        self.Data.RecentHops[JobId] = DateTime.now().UnixTimestamp
        self:Save()

        -- // Return
        return true
    end

    -- // Check if valid server
    function HopManager:ValidateServer(Server)
        -- // Vars
        local Data = self.Data
        local PlayerCount = Server.playing or 0
        local MaxPlayers = Server.maxPlayers or 1/0
        local ServerJobId = Server.id

        -- // Check the server is not the current server
        if (game.JobId == ServerJobId) then
            return false
        end

        -- // Validate player count
        if not (PlayerCount >= Data.MinimumPlayers and PlayerCount <= MaxPlayers and PlayerCount <= Data.MaximumPlayers) then
            return false
        end

        -- // Check against recent hops
        local Now = DateTime.now().UnixTimestamp
        local HopData = Data.RecentHops[ServerJobId]
        if (HopData and (Now - HopData) > Data.HopInterval) then
            return false
        end

        -- // Success
        return true
    end

    -- // Grabs server data from URL, automatically retries if error
    function HopManager:GetServerDataURL(Url)
        -- // Vars
        local Data

        -- // Keep on getting data
        while (not Data) do
            -- // To avoid errors
            pcall(function()
                Data = HttpService:JSONDecode(game:HttpGet(Url))
            end)

            -- // Break if we got data
            if (Data) then
                break
            end

            -- // Log
            local Delay = self.Data.DataRetryDelay
            print("GetServerDataURL errored, retrying in", Delay, "seconds")

            -- // So we don't crash
            task.wait(Delay)
        end

        -- // Return the data
        return Data
    end

    -- // Mass server list function
    function HopManager:GetMassServerListCreate(PlaceId, Count)
        -- // Vars
        local Data = self.Data
        Count = Count or Data.MassServerList.Amount
        PlaceId = PlaceId or game.PlaceId
        assert(typeof(PlaceId) == "number", "invalid type for PlaceId (expected number)")
        assert(typeof(Count) == "number", "invalid type for Count (expected number)")

        -- // Vars
        local ServerListPlaceId = {}

        -- // Infinite loop
        local Cursor = ""
        while (true) do
            -- // Check if big enough
            if (not Cursor or #ServerListPlaceId >= Count) then
                break
            end

            -- // Get the servers
            local ServersURL = Data.ServerFormat:format(PlaceId, Cursor)
            local ServerData = self:GetServerDataURL(ServersURL)

            -- // Loop through the server list
            for _, Server in ipairs(ServerData.data) do
                -- // Check we got enough
                if (#ServerListPlaceId >= Count) then
                    break
                end

                -- // Check
                if (not self:ValidateServer(Server)) then
                    continue
                end

                -- // Add server
                table.insert(ServerListPlaceId, Server)
            end

            -- // Increment cursor
            Cursor = ServerData.nextPageCursor
        end

        -- // Return
        return ServerListPlaceId
    end
    function HopManager:GetMassServerList(PlaceId)
        -- // Default and assert
        PlaceId = PlaceId or game.PlaceId
        assert(typeof(PlaceId) == "number", "invalid type for PlaceId (expected number)")
        local sPlaceId = tostring(PlaceId)

        -- // Check the file already exist
        local ConfigData = self.Data.MassServerList
        if (not isfile(ConfigData.SaveLocation)) then
            writefile(ConfigData.SaveLocation, "{}")
        end

        -- // Get the file
        local Now = DateTime.now().UnixTimestamp

        local _, ServerList = pcall(HttpService.JSONDecode, HttpService, readfile(ConfigData.SaveLocation))
        ServerList = ServerList or {}
        ServerList.Time = ServerList.Time or Now
        ServerList[sPlaceId] = ServerList[sPlaceId] or {}

        -- // Check the place id length / Check time
        if (#ServerList[sPlaceId] <= ConfigData.MinimumServers) or (Now - ServerList.Time > ConfigData.Refresh)  then
            ServerList[sPlaceId] = self:GetMassServerListCreate(PlaceId)
            ServerList.Time = Now
            writefile(ConfigData.SaveLocation, HttpService:JSONEncode(ServerList))
        end

        -- // Return
        return ServerList
    end

    -- // Gets a server list of valid servers
    function HopManager:GetServerList(PlaceId)
        -- // Default and assert
        PlaceId = PlaceId or game.PlaceId
        assert(typeof(PlaceId) == "number", "invalid type for PlaceId (expected number)")

        -- // Return all of the servers
        return self.Data.MassServerList.Enabled and self:GetMassServerList(PlaceId) or {
            Time = DateTime.now().UnixTimestamp,
            [tostring(PlaceId)] = self:GetMassServerListCreate(PlaceId, 100)
        }
    end

    -- // Retries teleport (additional args passed to :Hop)
    function HopManager:FailsafeHop(...)
        -- // Vars
        local ExtraArgs = {...}
        local Data = self.Data

        -- // See whenever the teleport failed
        local Connection
        Connection = TeleportService.TeleportInitFailed:Connect(function(Player, TeleportResult, ErrorMessage, PlaceId, TeleportOptions)
            -- // Make sure we failed to teleport
            if (Player ~= LocalPlayer) then
                return
            end

            -- // Set the JobId to hop to
            local JobId = table.find(Data.RetrySame, TeleportResult) and TeleportOptions.ServerInstanceId

            -- // Notify then disconnect
            print("Teleport failed, TeleportResult: " .. TeleportResult.Name)
            Connection:Disconnect()

            -- // Retry teleport in time
            task.delay(Data.RetryDelay, function()
                print("Reattempting teleport")
                self:Hop(PlaceId, JobId, unpack(ExtraArgs))
            end)
        end)

        -- // Return
        return Connection
    end

    -- // Hop servers
    function HopManager:Hop(PlaceId, JobId, Script)
        -- // Default and assert
        PlaceId = PlaceId or game.PlaceId
        Script = Script or ""
        assert(typeof(PlaceId) == "number", "invalid type for PlaceId (expected number)")
        assert(typeof(JobId) == "string" or JobId == nil, "invalid type for JobId (expected string or nil)")
        assert(typeof(Script) == "string", "invalid type for Script (expected string)")

        -- // Grab the server if we're not given one
        local sPlaceId = tostring(PlaceId)
        local Servers
        if (not JobId) then
            -- // Get the list
            local HopMode = self.Data.HopMode
            Servers = self:GetServerList(PlaceId)
            local PlaceServers = Servers[sPlaceId]
            assert(PlaceServers, "unable to get PlaceServers")

            -- // Check the amount of servers
            if (#PlaceServers == 0) then
                -- // Recursion
                print("Got 0 servers, trying again...")
                return self:Hop(PlaceId, JobId, Script)
            end

            -- // Find which server we want
            local i = HopMode
            if (typeof(HopMode) == "string") then
                if (HopMode == "Random") then
                    i = math.random(1, #PlaceServers)
                elseif (HopMode == "Middle") then
                    i = math.round(#PlaceServers / 2)
                end
            end
            local TargetServer = PlaceServers[i]

            -- // Set
            JobId = TargetServer.id
        end

        -- // Save the Id so we don't come back to it
        self:SaveJobId(JobId)

        -- // Execute script
        queue_on_teleport(Script)

        -- // Kicking
        if (self.Data.KickBeforeTeleport) then
            LocalPlayer:Kick(self.Data.KickMessage)
            task.wait()
        end

        -- // Remove server
        local MassServerList = self.Data.MassServerList
        if (Servers and MassServerList.Enabled and MassServerList.RemoveAfterTeleport) then
            table.remove(Servers[sPlaceId], 1)
            writefile(MassServerList.SaveLocation, HttpService:JSONEncode(Servers))
        end

        -- // Teleport to the server
        self:FailsafeHop(Script)
        TeleportService:TeleportToPlaceInstance(PlaceId, JobId)
    end
end

-- // Return
return HopManager, Utilities