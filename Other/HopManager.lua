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
        if (HopData > self.HopInterval) then
            return self:Set(JobId)
        end

        -- // Return false
        return false
    end

    -- // Server hop
    function HopManager.Hop(self, PlaceId, KickBeforeTeleport)
        -- // Default
        PlaceId = PlaceId or tostring(game.PlaceId)
        KickBeforeTeleport = (KickBeforeTeleport == nil and true or KickBeforeTeleport)

        -- // Vars
        local Servers = HttpService:JSONDecode(game:HttpGet(self.ServerFormat:format(PlaceId)))

        -- // Loop through each server
        for _, Server in ipairs(Servers.data) do
            -- // Make sure isn't full and the same place and that we have not hopped to that place recently
            if (Server.playing ~= Server.maxPlayers and Server.id ~= game.JobId and self:CheckData(Server.id)) then
                -- // Set and save
                self:Set(Server.id)

                -- // Kick
                if (KickBeforeTeleport) then
                    LocalPlayer:Kick("Teleporting...")
                end

                -- // Teleport
                local Success, Error = pcall(TeleportService.TeleportToPlaceInstance, TeleportService, PlaceId, Server.id)
                while (Error ~= nil) do
                    Success, Error = pcall(TeleportService.TeleportToPlaceInstance, TeleportService, PlaceId, Server.id)
                    wait(0.1)
                end

                -- // Stop
                break
            end
        end
    end
end

-- // Return
return HopManager