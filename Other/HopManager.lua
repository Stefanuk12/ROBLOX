-- // Services
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")

-- // Vars
local LocalPlayer = Players.LocalPlayer

-- // Hop Manager
local HopManager = {}
HopManager.__index = HopManager
do
    -- // Constructor
    function HopManager.new(Data)
        -- // Default
        Data = Data or {}

        -- // Create object
        local self = setmetatable({}, HopManager)

        -- // Set vars
        self.SaveLocation = Data.SaveLocation or "recenthops.json"
        self.HopInterval = Data.HopInterval or 300
        self.RecentHops = Data.RecentHops or {}
        self.ServerFormat = Data.ServerFormat or "https://games.roblox.com/v1/games/%s/servers/Public?sortOrder=Asc&limit=100"
        self.ServerFormatCursor = Data.ServerFormat or "https://games.roblox.com/v1/games/%s/servers/Public?sortOrder=Asc&limit=100&cursor=%s"
        -- // Load
        self:LoadFromFile()

        -- // Return object
        return self
    end

    -- // Load hop data
    function HopManager.LoadFromFile(self)
        -- // Get the data
        local RecentHopData = isfile(self.SaveLocation) and readfile(self.SaveLocation) or '{}'

        -- // Decode it
        local RecentHops = HttpService:JSONDecode(RecentHopData)
        self.RecentHops = RecentHops

        -- // Return it
        return RecentHops
    end

    -- // Save hop data
    function HopManager.Save(self)
        writefile(self.SaveLocation, HttpService:JSONEncode(self.RecentHops))
    end

    -- // Set hop data
    function HopManager.Set(self, JobId)
        -- // Add it and save
        self.RecentHops[JobId] = tick()
        self:Save()

        -- // Return
        return true
    end

    -- // Check hop data
    function HopManager.CheckData(self, JobId)
        -- // Vars
        local HopData = self.RecentHops[JobId]

        -- // Make sure we have the data
        if (not HopData) then
            return self:Set(JobId)
        end

        -- // Check if it has been the interval since
        if ((tick() - HopData) > self.HopInterval) then
            return self:Set(JobId)
        end

        -- // Return false
        return false
    end

    -- // Failsafe hop
    function HopManager.FailsafeHop(self, PlaceId, JobId, RetryTime)
        -- // Default
        RetryTime = RetryTime or 1

        -- // See whenever the teleport failed
        local Connection
        Connection = TeleportService.TeleportInitFailed:Connect(function(Player, TeleportResult, ErrorMessage)
            -- // Make sure we failed to teleport
            if (Player == LocalPlayer) then
                print("Teleport failed, TeleportResult: " .. TeleportResult.Name)

                -- // Check the TeleportResult to ensure it is appropriate to retry
                if (TeleportResult == Enum.TeleportResult.Failiure or TeleportResult == Enum.TeleportResult.Flooded) then
                    -- // Disconnect
                    Connection:Disconnect()

                    -- // Retry in RetryTime seconds
                    delay(RetryTime, function()
                        print("Reattempting teleport")
                        TeleportService:TeleportToPlaceInstance(PlaceId, JobId)
                    end)
                end
            end
        end)
    end

    -- // Get Server List - idk how to explain foundgood a and b but its to make sure we get joinable servers
    function HopManager.GetServerList(self, PlaceId, StopOnceFoundGood)
        -- // Vars
        local Cursor = ""
        local Servers = {}
        local FoundGoodA = false
        local FoundGoodB = false

        -- // Get all the servers until we found good servers
        repeat
            -- // Get the servers
            local ServerData = HttpService:JSONDecode(game:HttpGet(self.ServerFormatCursor:format(PlaceId, Cursor)))
            local _FoundGoodB = false

            -- // Add to server list
            for _, Server in ipairs(ServerData.data) do
                -- // Check if server is eligable
                if (Server.playing ~= Server.maxPlayers and Server.id ~= game.JobId and self:CheckData(Server.id)) then
                    if (FoundGoodA) then
                        _FoundGoodB = true
                    end
                    FoundGoodA = true

                    table.insert(Servers, Server)
                end
            end

            -- //
            if (_FoundGoodB) then
                FoundGoodB = true
            end

            -- // Set cursor for next iteration
            Cursor = ServerData.nextPageCursor
        until not Cursor or FoundGoodB

        -- // Return all the servers
        return Servers
    end

    -- // Server hop
    function HopManager.Hop(self, PlaceId, KickBeforeTeleport)
        -- // Default
        PlaceId = PlaceId or tostring(game.PlaceId)
        KickBeforeTeleport = (KickBeforeTeleport == nil and true or KickBeforeTeleport)

        -- // Vars
        local Server = self:GetServerList(PlaceId)[1]

        -- // Vars
        local JobId = Server.id

        -- // Set and save
        self:Set(JobId)

        -- // Kick
        if (KickBeforeTeleport) then
            LocalPlayer:Kick("Teleporting...")
        end

        -- // Teleport
        self:FailsafeHop(PlaceId, JobId)
        local Success, Error = pcall(TeleportService.TeleportToPlaceInstance, TeleportService, PlaceId, JobId)
        while (Error ~= nil) do
            Success, Error = pcall(TeleportService.TeleportToPlaceInstance, TeleportService, PlaceId, JobId)
            wait(0.1)
        end
    end
end

-- //
local m = HopManager.new()
m:Hop()

-- // Return
return HopManager