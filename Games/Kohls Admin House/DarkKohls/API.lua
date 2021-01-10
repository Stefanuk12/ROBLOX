--[[
    Infomation:
        This is just a BETA version and I'll update it further.

    Bugs:
        - probably some i havent discovered
        - Permanant Admin bugs
]]

-- // Exploit compatability
if (not getgenv().isfile) then
	getgenv().isfile = function(...)
		local success, _ = pcall(readfile, ...)
		return success
	end
end

return function(Arguments)
    -- // Initialise
    if (not Arguments) then Arguments = {} end

    -- // Services
    local Players = game:GetService("Players")
    local Lighting = game:GetService("Lighting")
    local Workspace = game:GetService("Workspace")
    local HttpService = game:GetService("HttpService")
    local UserInputService = game:GetService("UserInputService")
    local RunService = game:GetService("RunService")

    -- // Vars
    local GameFolder = Workspace.Terrain["_Game"]
    local CoroutineKillSwitch = false
    getgenv().KohlsAPI = {
        SelectedPad = GameFolder["Admin"]["Pads"]:GetChildren()[math.random(1, 9)],
        Connections = {},
        BlacklistedGears = {"94794847"}, -- // Anti Crash
        GlobalBlacklistedPhrases = {},
        PlayerManager = {
            Players = {}
        },
        Spammer = {},
        Configurable = {
            Errors = Arguments["Errors"],
            ScriptName = Arguments["ScriptName"],
            CSystemAlertNote = ":h [ DarkKohls ] Imagine using /c system to hide your commands, ahem: PLAYERNAME",
            BlacklistedGearNote = ":h [ DarkKohls ] Didn't you know this gear isn't allowed? Ahem: PLAYERNAME",
            AntiLogsNote = ":h [ DarkKohls ] no no logs PLAYERNAME",
            Settings = {
                {Name = "AdminPermanantAdmin", Value = false},
                {Name = "BlacklistAlertBlacklistGearUse", Value = false},
                {Name = "ProtectionsAntiBlind", Value = false},
                {Name = "ProtectionsAntiFreeze", Value = false},
                {Name = "ProtectionsAntiFling", Value = false},
                {Name = "ProtectionsAntiJail", Value = false},
                {Name = "ProtectionsAntiKill", Value = false},
                {Name = "ProtectionsAntiPunish", Value = false},
                {Name = "ProtectionsAntiMessageSpam", Value = false},
                {Name = "ProtectionsAntiSkydive", Value = false},
                {Name = "ProtectionsAntiSit", Value = false},
                {Name = "ProtectionsAntiLogs", Value = false},
                {Name = "SoundAbuseEarRape", Value = false},
                {Name = "ServerEpilepsy", Value = false},
                {Name = "ServerCSystemAlert", Value = false},
                {Name = "ServerClickSpawnWater", Value = false},
                {Name = "ServerRespawnExplode", Value = false},
            },
        }
    }
    KohlsAPI.Admin = {}
    KohlsAPI.Blacklist = {}
    KohlsAPI.Commands = {}
    KohlsAPI.Misc = {}
    KohlsAPI.Player = {}
    KohlsAPI.Protections = {}
    KohlsAPI.Server = {}
    KohlsAPI.SoundAbuse = {}
    KohlsAPI.Trolling = {}
    KohlsAPI.Whitelist = {}

    local LocalPlayer = Players.LocalPlayer
    local Mouse = LocalPlayer:GetMouse()

    -- // Shutdown
    function KohlsAPI.Shutdown()
        for i = 1, #KohlsAPI.Connections do
            local v = KohlsAPI.Connections
            if (v and v.Connection) then
                v.Connection:Disconnect()
            end
        end

        getgenv().KohlsAPI = nil
        return true
    end

    if (writefile and readfile and isfile) then -- // Load Settings
        if (not isfile(KohlsAPI.Configurable.ScriptName .. ".json")) then
            writefile(KohlsAPI.Configurable.ScriptName .. ".json", HttpService:JSONEncode(KohlsAPI.Configurable.Settings))
        end

        local Settings = HttpService:JSONDecode(readfile(KohlsAPI.Configurable.ScriptName .. ".json"))

        -- // Check if a setting exists (internal function)
        local function DoesSettingExist(SettingName, SettingTable)
            for i = 1, #SettingTable do
                local v = SettingTable[i]
                if (v.Name and v.Name == SettingName) then
                    return true
                end
            end

            return false
        end

        -- // Add new settings to the Configuration
        for i = 1, #KohlsAPI.Configurable.Settings do
            local v = KohlsAPI.Configurable.Settings[i]
            if (not DoesSettingExist(v.Name, Settings)) then
                Settings[#Settings + 1] = v
            end
        end

        -- // End
        KohlsAPI.Configurable.Settings = Settings
    end

    -- // Settings: Get/Set Setting
    function KohlsAPI.SettingGetSet(Name, Value)
        -- // Handling
        if (typeof(Name) ~= 'string') then
            local ErrorReason = "Argument #1 expected string got " .. typeof(Name)
            if (KohlsAPI.Configurable.Errors) then
                error(ErrorReason)
            end
            return false, ErrorReason
        end

        -- // Script
        for i = 1, #KohlsAPI.Configurable.Settings do
            local v = KohlsAPI.Configurable.Settings[i]
            if (v.Name == Name) then
                if (Value ~= nil) then
                    v.Value = Value
                    return true
                elseif (Value == nil) then
                    return v.Value
                end
            end
        end
    end

    -- // Settings: Save Settings
    function KohlsAPI.SaveSettings()
        -- // Handling
        if (not writefile) then
            local ErrorReason = "Cannot save settings, you do not have writefile."
            if (KohlsAPI.Configurable.Errors) then
                error(ErrorReason)
            end
            return false, ErrorReason
        end

        -- // Script
        local Save = KohlsAPI.Configurable.Settings

        -- // Export
        writefile(KohlsAPI.Configurable.ScriptName .. ".json", HttpService:JSONEncode(Save))
        return true
    end

    -- // Player Manager: Whitelist
    local ProtectedWhitelistedUsers = {LocalPlayer.UserId, 91318356}
    function isWhitelisted(Player)
        -- // Handling
        if (typeof(Player) ~= 'Instance') then
            local ErrorReason = "Argument #1 expected Instance got " .. typeof(Player)
            if (KohlsAPI.Configurable.Errors) then
                error(ErrorReason)
            end
            return false, ErrorReason
        end
        if (Player.Parent ~= Players) then
            local ErrorReason = "Argument #1 is not a member of Players"
            if (KohlsAPI.Configurable.Errors) then
                error(ErrorReason)
            end
            return false, ErrorReason
        end

        -- // Script
        local Whitelisted = false
        local isProtectedWhitelisted = false

        -- // Check if Whitelisted
        for i = 1, #KohlsAPI.PlayerManager.Players do
            local v = KohlsAPI.PlayerManager.Players[i]
            if (v.UserId == Player.UserId and v.Whitelisted) then
                Whitelisted = true
            end
        end

        -- // Check if Protected Whitelisted
        for i = 1, #ProtectedWhitelistedUsers do
            local v = ProtectedWhitelistedUsers[i]

            if (v == Player.UserId) then
                isProtectedWhitelisted = true
            end
        end

        -- // Return
        return true, (Whitelisted or isProtectedWhitelisted), Whitelisted, isProtectedWhitelisted
    end

    -- // Player Manager: Handler (internal)
    function PlayerManagerHandler(Message, Player)
        -- // Script
        local PlayerData
        local _, GWhitelisted, _, isProtectedWhitelisted = isWhitelisted(Player)

        -- // Get Player Data
        for i = 1, #KohlsAPI.PlayerManager.Players do
            local v = KohlsAPI.PlayerManager.Players[i]
            if (v.UserId == Player.UserId) then
                PlayerData = v
            end
        end

        -- // Handle Blacklisted Gears
        local splitMessage = Message:split(" ")
        if (not GWhitelisted) then
            -- // Gear Blacklist
            if (splitMessage[1]:lower():find("gear") and splitMessage[3]) then
                local gearId = splitMessage[3]
    
                for i = 1, #KohlsAPI.BlacklistedGears do
                    local BlacklistedGear = KohlsAPI.BlacklistedGears[i]
    
                    if (gearId:find(BlacklistedGear)) then
                        Players:Chat(":removetools " .. (splitMessage[2]:lower() == "me" and Player.Name or splitMessage[2]) )
                        if (KohlsAPI.SettingGetSet("BlacklistAlertBlacklistGearUse") and not GWhitelisted) then
                            Players:Chat(KohlsAPI.Configurable.BlacklistedGearNote:gsub("PLAYERNAME", Player.Name))
                        end
                    end
                end
            end

            -- // Anti Skydive
            if (splitMessage[1]:lower():find("skydive") and splitMessage[2] and KohlsAPI.SettingGetSet("ProtectionsAntiSkydive")) then
                -- // Message that is said to counter the skydive
                local counterText = ""

                -- // Get the message to say to counter the skydive
                for i = 2, #splitMessage do
                    -- // Me
                    if (splitMessage[i]:lower() == "me") then
                        splitMessage[i] = Player.Name
                    end

                    counterText = counterText .. splitMessage[i] .. " "
                end
                
                -- // Counter
                wait(0.1)
                Players:Chat(":unskydive " .. counterText)
            end

            -- // Anti sit
            if (splitMessage[1]:lower():find("sit") and splitMessage[2] ~= nil and KohlsAPI.SettingGetSet("ProtectionsAntiSit")) then
                -- // Message that is said to counter the sit
                local counterText = ""

                -- // Get the message to say to counter the sit
                for i = 2, #splitMessage do
                    -- // Me
                    if (splitMessage[i]:lower() == "me") then
                        splitMessage[i] = Player.Name
                    end

                    counterText = counterText .. splitMessage[i] .. " "
                end
                
                -- // Counter
                wait(0.1)
                Players:Chat(":reset " .. counterText)
            end

            -- // Anti logs
            if (splitMessage[1]:lower():find("logs") and KohlsAPI.SettingGetSet("ProtectionsAntiLogs")) then
                Players:Chat(":reset " .. Player.Name)
                for i = 1, 50 do
                    Players:Chat(KohlsAPI.Configurable.AntiLogsNote:gsub("PLAYERNAME", Player.Name))
                end
            end
        end
        
        -- // Handle Blacklisted Phrases
        local PlayerBlacklistedPhrases = PlayerData.BlacklistedPhrases

        for i = 1, #PlayerBlacklistedPhrases do -- // Player
            local v = PlayerBlacklistedPhrases[i]

            if (Message:find(v.Phrase)) then
                Players:Chat(v.Punishment)
            end
        end

        for i = 1, #KohlsAPI.GlobalBlacklistedPhrases do -- // Global
            local v = KohlsAPI.GlobalBlacklistedPhrases[i]

            if (Message:find(v.Phrase)) then
                Players:Chat(v.Punishment)
            end
        end

        -- // Server: /c system Alert
        if (KohlsAPI.SettingGetSet("ServerCSystemAlert") and Message == "/c system" and not GWhitelisted) then
            Players:Chat(KohlsAPI.Configurable.CSystemAlertNote:gsub("PLAYERNAME", Player.Name))
        end

        -- // Identifier ;)
        if (not isProtectedWhitelisted and Player ~= LocalPlayer and Message:lower() == "hi gamers") then
            Players:Chat(":h Hi gamer!")
        end
    end

    -- // Player Manager: Get Players
    function KohlsAPI.PlayerManager.GetPlayers(Sort) 
        if (Sort == "Unwhitelisted") then
            local PlayerTable = {}
            local AllPlayers = Players:GetPlayers()

            for i = 1, #AllPlayers do
                local v = AllPlayers[i]
                local _, GeneralWhitelisted, _, _ = isWhitelisted(v)

                if (not GeneralWhitelisted) then
                    PlayerTable[#PlayerTable + 1] = v
                end
            end

            return true, PlayerTable
        elseif (Sort == "GeneralWhitelisted") then
            local PlayerTable = {}
            local AllPlayers = Players:GetPlayers()

            for i = 1, #AllPlayers do
                local v = AllPlayers[i]
                local _, GeneralWhitelisted, _, _ = isWhitelisted(v)

                if (GeneralWhitelisted) then
                    PlayerTable[#PlayerTable + 1] = v
                end
            end

            return true, PlayerTable
        elseif (Sort == "Whitelisted") then
            local PlayerTable = {}
            local AllPlayers = Players:GetPlayers()

            for i = 1, #AllPlayers do
                local v = AllPlayers[i]
                local _, _, Whitelisted, _ = isWhitelisted(v)

                if (Whitelisted) then
                    PlayerTable[#PlayerTable + 1] = v
                end
            end

            return true, PlayerTable
        elseif (Sort == "ProtectedWhitelisted") then
            local PlayerTable = {}
            local AllPlayers = Players:GetPlayers()

            for i = 1, #AllPlayers do
                local v = AllPlayers[i]
                local _, _, _, isProtectedWhitelisted = isWhitelisted(v)

                if (isProtectedWhitelisted) then
                    PlayerTable[#PlayerTable + 1] = v
                end
            end

            return true, PlayerTable
        end
    end

    -- // Player Manager: Check if there any protected whitelist players in the game (internal)
    function AreTherePWLInTheServer()
        local _, ProtectedUsers = KohlsAPI.PlayerManager.GetPlayers("ProtectedWhitelisted")
 
        for i = 1, #ProtectedUsers do
            local v = ProtectedUsers[i]
            if (v.UserId ~= LocalPlayer.UserId) then
                return true
            end
        end

        return false
    end

    -- // Player Manager: Adding existing players to table
    local AllPlayers = Players:GetPlayers()

    for i = 1, #AllPlayers do
        local Player = AllPlayers[i]

        if (Player ~= LocalPlayer) then
            KohlsAPI.PlayerManager.Players[#KohlsAPI.PlayerManager.Players + 1] = {
                Instance = Player,
                Name = Player.Name,
                UserId = Player.UserId,
                Whitelisted = false,
                BlacklistedPhrases = {}
            }

            -- // Activating the Chat Handler
            KohlsAPI.Connections[#KohlsAPI.Connections + 1] = {Name = Player.UserId .. "Chatted", Connection = Player.Chatted:Connect(function(Message)
                PlayerManagerHandler(Message, Player)
            end)}
        else
            KohlsAPI.PlayerManager.Players[#KohlsAPI.PlayerManager.Players + 1] = {
                Instance = Player,
                Name = Player.Name,
                UserId = Player.UserId,
                Whitelisted = true,
                BlacklistedPhrases = {}
            }
        end
    end

    -- // Player Manager: Adding new players to table
    KohlsAPI.Connections[#KohlsAPI.Connections + 1] = {Name = "PlayerManagerNew", Connection = Players.PlayerAdded:Connect(function(Player)
        KohlsAPI.PlayerManager.Players[#KohlsAPI.PlayerManager.Players + 1] = {
            Instance = Player,
            Name = Player.Name,
            UserId = Player.UserId,
            Whitelisted = false,
            BlacklistedPhrases = {}
        }

        -- // Activating the Chat Handler
        Player.Chatted:Connect(function(Message)
            PlayerManagerHandler(Message, Player)
        end)

        -- // Respawn Explode
        local _, GWhitelisted, _, _ = isWhitelisted(Player)
        if (KohlsAPI.SettingGetSet("ServerRespawnExplode") and not GWhitelisted) then
            KohlsAPI.Commands.StopStartSpamPhrase(":respawn " .. Player.Name)
            KohlsAPI.Commands.StopStartSpamPhrase(":explode " .. Player.Name)
        end
    end)}
    
    -- // Player Manager: Remove leaving players from table
    KohlsAPI.Connections[#KohlsAPI.Connections + 1] = {Name = "PlayerManagerRemove", Connection = Players.PlayerRemoving:Connect(function(Player)
        for i = 1, #KohlsAPI.PlayerManager.Players do
            local PlayerData = KohlsAPI.PlayerManager.Players

            if (PlayerData and PlayerData.UserId == Player.UserId) then
                table.remove(KohlsAPI.PlayerManager.Players, i)
            end
        end

        -- // Respawn Explode
        if (KohlsAPI.SettingGetSet("ServerRespawnExplode")) then
            KohlsAPI.Commands.StopStartSpamPhrase(":respawn " .. Player.Name, true)
            KohlsAPI.Commands.StopStartSpamPhrase(":explode " .. Player.Name, true)
        end
    end)}

    -- // Admin: Regenerate Admin
    function KohlsAPI.Admin.RegenerateAdmin()
        -- // Failsafing
        if (not fireclickdetector) then
            local ErrorReason = "fireclickdetector is required for Regen Admin"
            if (KohlsAPI.Configurable.Errors) then
                error(ErrorReason)
            end
            return false, ErrorReason
        end
        if (not GameFolder["Admin"]:FindFirstChild("Regen")) then
            local ErrorReason = "Unable to find the Regen Pad!"
            if (KohlsAPI.Configurable.Errors) then
                error(ErrorReason)
            end
            return false, ErrorReason
        end

        -- // Regen the admin
        fireclickdetector(GameFolder["Admin"].Regen.ClickDetector, 0)

        -- // Final Return
        return true
    end

    -- // Admin: Get Admin
    local KohlsAPIAdminGetAdminRunning = false
    function KohlsAPI.Admin.GetAdmin(SpecifyPad)
        -- // Handling
        if (KohlsAPIAdminGetAdminRunning) then
            local ErrorReason = "KohlsAPI.Admin.GetAdmin is already running!"
            if (KohlsAPI.Configurable.Errors) then
                error(ErrorReason)
            end
            return false, ErrorReason
        end
        KohlsAPIAdminGetAdminRunning = true
        if (SpecifyPad ~= nil) then
            if (typeof(SpecifyPad) ~= 'Instance') then
                local ErrorReason = "Argument #1 expected Instance got " .. typeof(SpecifyPad)
                if (KohlsAPI.Configurable.Errors) then
                    error(ErrorReason)
                end
                return false, ErrorReason
            end
            if (SpecifyPad.Parent ~= GameFolder["Admin"]["Pads"]) then
                local ErrorReason = "Argument #1 is not a member of the Admin Pads"
                if (KohlsAPI.Configurable.Errors) then
                    error(ErrorReason)
                end
                return false, ErrorReason
            end
        end
        if (not fireclickdetector) then
            local ErrorReason = "fireclickdetector is required for Get Admin"
            if (KohlsAPI.Configurable.Errors) then
                error(ErrorReason)
            end
            return false, ErrorReason
        end

        -- // Regen the admin
        local Holder = GameFolder["Admin"]["Pads"]:FindFirstChild("Touch to get admin")
        if (not Holder and not SpecifyPad) then
            local _, ErrorReason = KohlsAPI.Admin.RegenerateAdmin()
            if (KohlsAPI.Configurable.Errors) then
                error(ErrorReason)
            end
            return false, ErrorReason
        end
        Holder = nil

        -- // Vars
        local DesiredPadName = LocalPlayer.Name .. "'s admin"
        local SelectedPad = SpecifyPad or GameFolder["Admin"]["Pads"]:GetChildren()[math.random(1, 9)]
        local SavedPadCFrame = SelectedPad.Head.CFrame

        if (SelectedPad.Name ~= DesiredPadName and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")) then
            local HumanoidRootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

            if (not firetouchinterest) then
                -- // Setting Pad Properties
                SelectedPad.Head.Transparency = 1
                SelectedPad.Head.Size = Vector3.new(0, 0, 0)
                SelectedPad.Head.CanCollide = false

                -- // Constantly teleporting the pad to the Player until the player has admin
                while SelectedPad.Name ~= LocalPlayer.Name .. "'s admin" do
                    wait()
                    SelectedPad.Head.CFrame = HumanoidRootPart.CFrame
                end

                -- // Reset Pad Properties
                SelectedPad.Head.CFrame = SavedPadCFrame
                SelectedPad.Head.Transparency = 0
                SelectedPad.Head.Size = Vector3.new(3, 0.4, 3)
                SelectedPad.Head.CanCollide = true
            else
                while SelectedPad.Name ~= LocalPlayer.Name .. "'s admin" do
                    wait()
                    firetouchinterest(HumanoidRootPart, SelectedPad.Head, 0)
                    firetouchinterest(HumanoidRootPart, SelectedPad.Head, 1)
                end
            end
        end

        -- // Final Return
        KohlsAPIAdminGetAdminRunning = false
        return true, SelectedPad
    end
    
    -- // Admin: Permanant Admin
    coroutine.wrap(function() -- // Coroutine to not hold the rest of the script up
        if (fireclickdetector) then
            -- // Vars
            local DesiredPadName = LocalPlayer.Name .. "'s admin"

            -- // Get a pad if it's enabled
            if (KohlsAPI.SettingGetSet("AdminPermanantAdmin") and KohlsAPI.SelectedPad.Name ~= DesiredPadName) then
                KohlsAPI.Admin.GetAdmin(KohlsAPI.SelectedPad)
            end

            -- // Connection
            KohlsAPI.Connections[#KohlsAPI.Connections + 1] = {Name = "Permanant Admin", Connection = KohlsAPI.SelectedPad:GetPropertyChangedSignal("Name"):Connect(function(Value)
                if (KohlsAPI.SettingGetSet("AdminPermanantAdmin") and Value ~= DesiredPadName) then
                    KohlsAPI.Admin.GetAdmin(KohlsAPI.SelectedPad)
                end
            end)}
        end
    end)()

    -- // Blacklist: Blacklist Gear
    function KohlsAPI.Blacklist.BlacklistUnblacklistGear(GearId, Unblacklist)
        -- // Handling
        GearId = tostring(GearId)
        if (Unblacklist ~= nil and typeof(Unblacklist) ~= 'boolean') then
            local ErrorReason = "Argument #1 expected boolean got " .. typeof(Unblacklist)
            if (KohlsAPI.Configurable.Errors) then
                error(ErrorReason)
            end
            return false, ErrorReason
        end

        local GearInTable = false
        for i = 1, #KohlsAPI.BlacklistedGears do
            local v = KohlsAPI.BlacklistedGears[i]
            if (v == GearId) then
                GearInTable = true
                if (not Unblacklist) then
                    local ErrorResaon = "Gear is already blacklisted."
                    return false, ErrorResaon
                else
                    table.remove(KohlsAPI.BlacklistedGears, i)
                    return true
                end
            end
        end

        if (not GearInTable) then
            if (not Unblacklist) then
                -- // Script
                KohlsAPI.BlacklistedGears[#KohlsAPI.BlacklistedGears + 1] = GearId
            else
                -- // Handling
                local ErrorReason = "Gear is not blacklisted."
                if (KohlsAPI.Configurable.Errors) then
                    error(ErrorReason)
                end
                return false, ErrorReason
            end
        end

        return true
    end

    -- // Blacklist: Blacklist Phrase
    function KohlsAPI.Blacklist.BlacklistUnblacklistPhrase(Phrase, Punishment, Player, Unblacklist)
        -- // Handling
        if (typeof(Phrase) ~= 'string') then
            local ErrorReason = "Argument #1 expected string got " .. typeof(Phrase)
            if (KohlsAPI.Configurable.Errors) then
                error(ErrorReason)
            end
            return false, ErrorReason
        end
        if (Punishment ~= nil and typeof(Punishment) ~= 'string') then
            local ErrorReason = "Argument #2 expected string got " .. typeof(Phrase)
            if (KohlsAPI.Configurable.Errors) then
                error(ErrorReason)
            end
            return false, ErrorReason
        end
        if (Player ~= nil and typeof(Player) ~= 'Instance') then
            local ErrorReason = "Argument #3 expected Instance got " .. typeof(Player)
            if (KohlsAPI.Configurable.Errors) then
                error(ErrorReason)
            end
            return false, ErrorReason
        end
        if (typeof(Player) == 'Instance' and Player.Parent ~= Players) then
            local ErrorReason = "Argument #3 is not a member of Players"
            if (KohlsAPI.Configurable.Errors) then
                error(ErrorReason)
            end
            return false, ErrorReason
        end
        if (Unblacklist ~= nil and typeof(Unblacklist) ~= 'boolean') then
            local ErrorReason = "Argument #4 expected boolean got " .. typeof(Unblacklist)
            if (KohlsAPI.Configurable.Errors) then
                error(ErrorReason)
            end
            return false, ErrorReason
        end
        if (Unblacklist == nil) then
            if (Punishment == nil) then
                local ErrorReason = "Argument #2 expected string got nil"
                if (KohlsAPI.Configurable.Errors) then
                    error(ErrorReason)
                end
                return false, ErrorReason
            end
        end

        -- // Script
        local PlayerData
        local PlayerDataIndex
        local isPhraseBlacklistedPlayer = false
        local isPhraseBlacklisedGlobal = false
        local Success, GWhitelisted, Whitelisted, ProtectedWhitelisted = false, nil, nil, nil
        if (Player) then Success, GWhitelisted, Whitelisted, ProtectedWhitelisted = isWhitelisted(Player) end

        -- // Get Player Data
        if (Player) then
            for i = 1, #KohlsAPI.PlayerManager.Players do
                local v = KohlsAPI.PlayerManager.Players[i]

                if (v.UserId == Player.UserId) then
                    PlayerData = v
                    PlayerDataIndex = i

                    -- // Check if the phrase is blacklisted for the user
                    if (v.Phrase == Phrase) then
                        isPhraseBlacklistedPlayer = true
                    end
                end
            end
        end

        -- // Check if the phrase is blacklisted globally
        for i = 1, #KohlsAPI.GlobalBlacklistedPhrases do
            local v = KohlsAPI.GlobalBlacklistedPhrases[i]

            if (v.Phrase == Phrase) then
                isPhraseBlacklisedGlobal = true
            end
        end

        -- // Handling
        if (Unblacklist) then -- // Unblacklisting
            if ((not Player and not isPhraseBlacklisedGlobal) or (Player and not isPhraseBlacklistedPlayer)) then
                local ErrorReason = "Phrase is not blacklisted"
                if (KohlsAPI.Configurable.Errors) then
                    error(ErrorReason)
                end
                return false, ErrorReason
            end
        else -- // Blacklisting
            if (ProtectedWhitelisted) then
                local ErrorReason = "Player is protected."
                if (KohlsAPI.Configurable.Errors) then
                    error(ErrorReason)
                end
                return false, ErrorReason
            end
            if (isPhraseBlacklistedPlayer) then
                local ErrorReason = "Phrase is already blacklisted for the player"
                if (KohlsAPI.Configurable.Errors) then
                    error(ErrorReason)
                end
                return false, ErrorReason
            end
            if (isPhraseBlacklisedGlobal) then
                local ErrorReason = "Phrase is already blacklisted globally"
                if (KohlsAPI.Configurable.Errors) then
                    error(ErrorReason)
                end
                return false, ErrorReason
            end
        end

        -- // Script
        if (Player ~= nil) then
            PlayerData["BlacklistedPhrases"][#PlayerData["BlacklistedPhrases"] + 1] = {
                Phrase = Phrase,
                Punishment = Punishment
            }
        else
            KohlsAPI.GlobalBlacklistedPhrases[#KohlsAPI.GlobalBlacklistedPhrases + 1] = {
                Phrase = Phrase,
                Punishment = Punishment
            }
        end

        return true
    end

    -- // Commands: Say Phrase
    function KohlsAPI.Commands.SayPhrase(...)
        local Stuff = {...}
        for i = 1, #Stuff do
            Stuff[i] = tostring(Stuff[i])
        end

        local Phrase = table.concat(Stuff, " ")
        Players:Chat(Phrase)

        return true
    end

    -- // Commands: Spam Phrase
    KohlsAPI.Connections[#KohlsAPI.Connections + 1] = {Name = "Spammer", Connection = RunService.RenderStepped:Connect(function()
        for i = 1, #KohlsAPI.Spammer do
            local v = KohlsAPI.Spammer[i]
            Players:Chat(v)
        end
    end)}

    function KohlsAPI.Commands.StopStartSpamPhrase(Phrase, Stop)
        -- // Handling
        if (typeof(Phrase) ~= 'string') then
            local ErrorReason = "Argument #1 expected string got " .. typeof(Phrase)
            if (KohlsAPI.Configurable.Errors) then
                error(ErrorReason)
            end
            return false, ErrorReason
        end
        if (Stop ~= nil and typeof(Stop) ~= 'boolean') then
            local ErrorReason = "Argument #2 expected boolean got " .. typeof(Phrase)
            if (KohlsAPI.Configurable.Errors) then
                error(ErrorReason)
            end
            return false, ErrorReason
        end

        local isInSpammer = false
        for i = 1, #KohlsAPI.Spammer do
            local v = KohlsAPI.Spammer[i]
            if (v == Phrase) then
                isInSpammer = true
            end
        end

        if (Stop and not isInSpammer) then
            local ErrorReason = "Phrase is not in the spammer"
            if (KohlsAPI.Configurable.Errors) then
                error(ErrorReason)
            end
            return false, ErrorReason
        end
        if (not Stop and isInSpammer) then
            local ErrorReason = "Phrase is already in the spammer"
            if (KohlsAPI.Configurable.Errors) then
                error(ErrorReason)
            end
            return false, ErrorReason
        end

        -- // Script
        if (Stop) then
            for i = 1, #KohlsAPI.Spammer do
                local v = KohlsAPI.Spammer[i]
                if (v == Phrase) then
                    table.remove(KohlsAPI.Spammer, i)
                end
            end

        else
            KohlsAPI.Spammer[#KohlsAPI.Spammer + 1] = Phrase
        end

        return true
    end

    -- // Misc: Paint Area
    function KohlsAPI.Misc.PaintArea(Area, Colour)
        -- // Handling
        if (typeof(Area) ~= 'string') then
            local ErrorReason = "Argument #1 expected string got " .. typeof(Area)
            if (KohlsAPI.Configurable.Errors) then
                error(ErrorReason)
            end
            return false, ErrorReason
        end
        if (typeof(Colour) ~= 'Color3') then
            local ErrorReason = "Argument #2 expected Color3 got " .. typeof(Colour)
            if (KohlsAPI.Configurable.Errors) then
                error(ErrorReason)
            end
            return false, ErrorReason
        end

        -- // Check if you already have a Paint Bucket
        if (not (LocalPlayer.Backpack:FindFirstChild("PaintBucket") or LocalPlayer.Character:FindFirstChild("PaintBucket"))) then
            Players:Chat(":gear me 18474459")
        end
        LocalPlayer.Backpack:WaitForChild("PaintBucket")
        LocalPlayer.Character.Humanoid:EquipTool(LocalPlayer.Backpack.PaintBucket)
        LocalPlayer.Character:WaitForChild("PaintBucket")

        -- // Painting
        local Remote = LocalPlayer.Character:WaitForChild("PaintBucket"):WaitForChild("Remotes"):WaitForChild("ServerControls")

        if (Area:lower() == "all") then
            -- // Paint everything
            local AllDescendants = GameFolder["Workspace"]:GetDescendants()
            for i = 1, #AllDescendants do
                local part = AllDescendants[i]
                coroutine.wrap(function()
                    if (part:IsA("BasePart")) then
                        Remote:InvokeServer("PaintPart", {["Part"] = part, ["Color"] = Colour})
                    end
                end)()
            end
        else
            -- // Paint certain areaa
            local AreaDescendants = GameFolder["Workspace"][Area]:GetDescendants()
            for i = 1, #AreaDescendants do
                local part = AreaDescendants[i]
                coroutine.wrap(function()
                    if (part:IsA("BasePart")) then
                        Remote:InvokeServer("PaintPart", {["Part"] = part, ["Color"] = Colour})
                    end
                end)()
            end
        end

        return true
    end

    -- // Misc: Rejoin
    function KohlsAPI.Misc.Rejoin()
        game:GetService("TeleportService"):Teleport(game.PlaceId)
        return true
    end

    -- // Misc: Disable Obby Kill
    function KohlsAPI.Misc.DisableObbyKill()
        local Children = GameFolder["Workspace"].Obby:GetChildren()
        local returnValue = true
        for i = 1, #Children do
            local part = Children[i]
            if (part:FindFirstChildWhichIsA("TouchTransmitter")) then
                part:FindFirstChildWhichIsA("TouchTransmitter"):Destroy()
            else
                returnValue = false
            end
        end

        -- // Return
        return returnValue
    end

    -- // Misc: Export GUI Data
    function KohlsAPI.Misc.ExportGUIData()
        -- // Vars
        local GUIConfig = HttpService:JSONDecode(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Kohls%20Admin%20House/DarkKohls/GUIData.json"))
        local Current = ""

        -- // Exporting
        for name, module in pairs(GUIConfig) do
            Current = Current .. Current.format("-- %s Module --\n", name)
            
            for _, command in pairs(module) do
                Current = Current .. Current.format("%s - %s (%s)\n", command.Name, command.Description, command.Type)
            end
            
            Current = Current .. "\n"
        end

        -- // Final
        return Current
    end
    
    -- // Player: Get Age
    function KohlsAPI.Player.GetAge(Player)
        -- // Handling
        if (typeof(Player) ~= 'Instance') then
            local ErrorReason = "Argument #1 expected Instance got " .. typeof(Player)
            if (KohlsAPI.Configurable.Errors) then
                error(ErrorReason)
            end
            return false, ErrorReason
        end
        if (Player.Parent ~= Players) then
            local ErrorReason = "Argument #1 is not a member of Players"
            if (KohlsAPI.Configurable.Errors) then
                error(ErrorReason)
            end
            return false, ErrorReason
        end

        -- // Script
        return true, Player.AccountAge
    end

    -- // Player: Give Client BTools
    function KohlsAPI.Player.GiveClientBtools(Player)
        -- // Handling
        if (typeof(Player) ~= 'Instance') then
            local ErrorReason = "Argument #1 expected Instance got " .. typeof(Player)
            if (KohlsAPI.Configurable.Errors) then
                error(ErrorReason)
            end
            return false, ErrorReason 
        end
        if (Player.Parent ~= Players) then
            local ErrorReason = "Argument #1 is not a member of Players"
            if (KohlsAPI.Configurable.Errors) then
                error(ErrorReason)
            end
            return false, ErrorReason
        end

        -- // Script
        Players:Chat(":gear " .. Player.Name .. " 16200204")
        Players:Chat(":gear " .. Player.Name .. " 16200402")
        Players:Chat(":gear " .. Player.Name .. " 16969792")
        Players:Chat(":gear " .. Player.Name .. " 73089190")
        Players:Chat(":gear " .. Player.Name .. " 21001552")

        return true
    end

    -- // Protections: Anti Blind
    KohlsAPI.Connections[#KohlsAPI.Connections + 1] = {Name = "AntiBlind", Connection = LocalPlayer.PlayerGui.ChildAdded:Connect(function(child)
        if (KohlsAPI.SettingGetSet("ProtectionsAntiBlind") and child.Name == "EFFECTGUIBLIND") then
            wait(0.1)
            child:Destroy()
        end
    end)}

    -- // Protections: Anti Jail
    KohlsAPI.Connections[#KohlsAPI.Connections + 1] = {Name = "AntiJail", Connection = GameFolder["Folder"].ChildAdded:Connect(function(child)
        if (KohlsAPI.SettingGetSet("ProtectionsAntiJail") and child.Name == LocalPlayer.Name.."'s jail") then
            Players:Chat(":removejails")
        end
    end)}

    -- // Protections: Anti Kill
    function AntiKillConnection()
        -- // Remove the old connection if there is one
        for i = 1, #KohlsAPI.Connections do
            local v = KohlsAPI.Connections[i]
            if (v and v.Name == "AntiKill") then
                if (v.Connection) then
                    v.Connection:Disconnect()
                end
                table.remove(KohlsAPI.Connections, i)
            end   
        end

        local Connection = LocalPlayer.Character:WaitForChild("Humanoid").Died:Connect(function()
            if (KohlsAPI.SettingGetSet("ProtectionsAntiKill")) then
                Players:Chat(":reset me")
            end
        end)
        KohlsAPI.Connections[#KohlsAPI.Connections + 1] = {Name = "AntiKill", Connection = Connection}
    end
    AntiKillConnection()
    LocalPlayer.CharacterAdded:Connect(AntiKillConnection)

    -- // Protections: Anti Punish
    KohlsAPI.Connections[#KohlsAPI.Connections + 1] = {Name = "AntiPunish", Connection = Lighting.ChildAdded:Connect(function(child)
        if (KohlsAPI.SettingGetSet("ProtectionsAntiPunish") and child.Name == LocalPlayer.Name) then
            Players:Chat(":reset me")
        end
    end)}

    -- // Protections: Anti Freeze
    function AntiFreezeConnection()
        -- // Remove the old connection if there is one
        for i = 1, #KohlsAPI.Connections do
            local v = KohlsAPI.Connections[i]
            if (v and v.Name == "AntiFreeze") then
                if (v.Connection) then
                    v.Connection:Disconnect()
                end
                table.remove(KohlsAPI.Connections, i)
            end
        end

        local Connection = LocalPlayer.Character.ChildAdded:Connect(function(child)
            if (child:IsA("Part") and child.Name == "ice" and KohlsAPI.SettingGetSet("ProtectionsAntiFreeze")) then
                Players:Chat(":reset me")
            end
        end)
        KohlsAPI.Connections[#KohlsAPI.Connections + 1] = {Name = "AntiFreeze", Connection = Connection}
    end
    AntiFreezeConnection()
    LocalPlayer.CharacterAdded:Connect(AntiFreezeConnection)

    -- // Protections: Anti Fling
    function AntiFlingConnection()
        -- // Remove the old connection if there is one
        for i = 1, #KohlsAPI.Connections do
            local v = KohlsAPI.Connections[i]
            if (v and v.Name == "AntiFling") then
                if (v.Connection) then
                    v.Connection:Disconnect()
                end
                table.remove(KohlsAPI.Connections, i)
            end
        end

        local Connection = LocalPlayer.Character:WaitForChild("Torso").ChildAdded:Connect(function(child)
            if (child.Name == "BFRC" and KohlsAPI.SettingGetSet("ProtectionsAntiFling")) then
                local savedCFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
                wait(0.1)
                LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
                LocalPlayer.Character.HumanoidRootPart.CFrame = savedCFrame
                LocalPlayer.Character.Humanoid.Sit = false
            end
        end)
        KohlsAPI.Connections[#KohlsAPI.Connections + 1] = {Name = "AntiFling", Connection = Connection}
    end
    AntiFlingConnection()
    LocalPlayer.CharacterAdded:Connect(AntiFlingConnection)

    -- // Protections: Anti Message Spam
    KohlsAPI.Connections[#KohlsAPI.Connections + 1] = {Name = "AntiMessageSpam", Connection = GameFolder.Folder.ChildAdded:Connect(function(child)
        if (KohlsAPI.SettingGetSet("ProtectionsAntiMessageSpam") and child:IsA("Message")) then
            local messageCount = 0
            do
                local Children = GameFolder.Folder:GetChildren()
                for i = 1, #Children do
                    local v = Children[i]
                    if (v:IsA("Message")) then
                        messageCount = messageCount + 1
                    end
                end
            end

            if (messageCount > 4) then
                Players:Chat(":clr")
            end
        end
    end)}
    KohlsAPI.Connections[#KohlsAPI.Connections + 1] = {Name = "AntiMessageSpamB", Connection = LocalPlayer.PlayerGui.ChildAdded:Connect(function(child)
        if (KohlsAPI.SettingGetSet("ProtectionsAntiMessageSpam") and child.Name == "MessageGUI") then
            local messageCount = 0
            do
                local Children = LocalPlayer.PlayerGui:GetChildren()
                for i = 1, #Children do
                    local v = Children[i]
                    if (v.Name == "MessageGUI") then
                        messageCount = messageCount + 1
                    end
                end
            end

            if (messageCount > 4) then
                Players:Chat(":clr")
            end
        end
    end)}

    -- // Server: Crash Server
    function KohlsAPI.Server.CrashServer()
        if (AreTherePWLInTheServer()) then
            local ErrorReason = "There are protected whitelisted people in the server."
            if (KohlsAPI.Configurable.Errors) then
                error(ErrorReason)
            end
            return false, ErrorReason
        end

        Players:Chat(":gear me 94794847")
        LocalPlayer.Backpack:WaitForChild("VampireVanquisher")
        LocalPlayer.Character.Humanoid:EquipTool(LocalPlayer.Backpack.VampireVanquisher)
        LocalPlayer.Character:WaitForChild("VampireVanquisher")
        for i = 1, 10 do
            Players:Chat(":size me .3")
            wait()
        end

        wait(1)
        if (LocalPlayer.Character:FindFirstChild("VampireVanquisher")) then
            LocalPlayer.Character["VampireVanquisher"].Parent = Workspace
        end
        

        return true
    end

    -- // Server: Create Phantom Baseplate
    function KohlsAPI.Server.CreatePhantomBaseplate()
        local Baseplate = Instance.new("Part", GameFolder["Workspace"])
        Baseplate.Name = "PhantomBaseplate"
        Baseplate.BrickColor = BrickColor.new("Bright green")
        Baseplate.Size = Vector3.new(1000, 1.2, 1000)
        Baseplate.TopSurface = "Studs"
        Baseplate.Anchored = true

        return true
    end

    -- // Server: Epilepsy
    coroutine.wrap(function()
        while wait() do
            if (CoroutineKillSwitch) then break end
            if (KohlsAPI.SettingGetSet("ServerEpilepsy")) then
                Players:Chat(":colorshifttop 10000 0 0") wait(0.1)
                Players:Chat(":colorshiftbottom 10000 0 0") wait(0.1)
                Players:Chat(":colorshifttop 0 10000 0") wait(0.1)
                Players:Chat(":colorshiftbottom 0 10000 0") wait(0.1)
                Players:Chat(":colorshifttop 0 0 10000") wait(0.1)
                Players:Chat(":colorshiftbottom 0 0 10000") wait(0.1)
            end
        end
    end)()

    -- // Server: Move Baseplate
    function KohlsAPI.Server.MoveBaseplate()
        -- // Handling
        if (AreTherePWLInTheServer()) then
            local ErrorReason = "There are protected whitelisted people in the server."
            if (KohlsAPI.Configurable.Errors) then
                error(ErrorReason)
            end
            return false, ErrorReason
        end

        -- // Vars
        local Spawn = GameFolder["Workspace"].Spawn3
        local Baseplate = GameFolder["Workspace"].Baseplate
        local AntiPunishDisabled = false
        local testCFrame = Baseplate.CFrame
        local testPosition = Spawn.Position
        local X, Y, Z, R00, R01, R02, R10, R11, R12, R20, R21, R22 = testCFrame:GetComponents()
        X, Y, Z = testPosition.X, Y + 3, testPosition.Z
        local newCFrame = CFrame.new(X, Y, Z, R00, R01, R02, R10, R11, R12, R20, R21, R22)

        -- // So you don't float in water
        local CharacterDescendants = LocalPlayer.Character:GetDescendants()
        for i = 1, #CharacterDescendants do
            local v = CharacterDescendants[i]
            if (v:IsA("BasePart")) then
                v.CustomPhysicalProperties = PhysicalProperties.new(1, 0.3, 0.5)
            end
        end

        -- // Script
        LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = newCFrame
        wait(1.5)
        Players:Chat(":stun me")

        if (KohlsAPI.SettingGetSet("ProtectionsAntiPunish")) then
            KohlsAPI.SettingGetSet("ProtectionsAntiPunish", false)
            AntiPunishDisabled = true
        end

        wait(1)
        Players:Chat(":punish me")
        wait(1)

        Players:Chat(":unpunish me")
        if (AntiPunishDisabled) then
            KohlsAPI.SettingGetSet("ProtectionsAntiPunish", true)
        end

        return true
    end

    -- // Server: Part Spam
    function KohlsAPI.Server.PartSpam(Stop)
        -- // Handling
        if (Stop ~= nil and typeof(Stop) ~= 'boolean') then
            local ErrorReason = "Argument #1 expected boolean got " .. typeof(Stop)
            if (KohlsAPI.Configurable.Errors) then
                error(ErrorReason)
            end
            return false, ErrorReason
        end

        -- // Script
        return true, KohlsAPI.Commands.StopStartSpamPhrase(":part/10/10/10", Stop)
    end

    -- // Server: Remove Phantom Baseplates
    function KohlsAPI.Server.RemovePhantomBaseplates()
        local PhantomBaseplates = GameFolder["Workspace"]:GetChildren()
        for i = 1, #PhantomBaseplates do
            local v = PhantomBaseplates[i]
            if v.Name == "PhantomBaseplate" then
                v:Destroy()
            end
        end

        return true
    end

    -- // Server: Respawn Explode
    function KohlsAPI.Server.RespawnExplode(Stop)
        -- // Handling
        if (Stop ~= nil and typeof(Stop) ~= 'boolean') then
            local ErrorReason = "Argument #1 expected boolean got " .. typeof(Stop)
            if (KohlsAPI.Configurable.Errors) then
                error(ErrorReason)
            end
            return false, ErrorReason
        end

        -- // Script
        local Success, TargetPlayers = KohlsAPI.PlayerManager.GetPlayers("Unwhitelisted")
        if (not Success) then return false end

        KohlsAPI.SettingGetSet("ServerRespawnExplode", not Stop)

        for i = 1, #TargetPlayers do
            local v = TargetPlayers[i]

            KohlsAPI.Commands.StopStartSpamPhrase(":respawn " .. v.Name, Stop)
            KohlsAPI.Commands.StopStartSpamPhrase(":explode " .. v.Name, Stop)
        end

        return true
    end

    -- // Server: Click Spawn Water
    KohlsAPI.Connections[#KohlsAPI.Connections + 1] = {Name = "ClickSpawnWater", Connection = UserInputService.InputBegan:Connect(function(Key, GPE)
        if (KohlsAPI.SettingGetSet("ServerClickSpawnWater") and not GPE and Key.KeyCode == Enum.KeyCode.LeftControl and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)) then
            Players:Chat(":gear me 236438668")

            local Tool = LocalPlayer.Backpack:WaitForChild("SeaThemedCrossbow")
            local Humanoid = LocalPlayer.Character:WaitForChild("Humanoid")

            Humanoid:EquipTool(Tool)

            local Remote = LocalPlayer.Character:WaitForChild("SeaThemedCrossbow"):WaitForChild("Remote")
            Remote:FireServer("LeftDown", Mouse.Hit.Position)

            wait(1)
            Players:Chat(":removetools me")
        end
    end)}

    -- // Sound Abuse: Ear Rape
    coroutine.wrap(function()
        while wait(0.5) do
            if (CoroutineKillSwitch) then break end
            if (KohlsAPI.SettingGetSet("SoundAbuseEarRape")) then
                local WorkspaceDescendants = Workspace:GetDescendants()
                for i = 1, #WorkspaceDescendants do
                    local v = WorkspaceDescendants[i]
                    if (v:IsA("Sound")) then
                        v:Play()
                    end
                end
            end
        end
    end)()

    -- // Sound Abuse: Play All Sounds
    function KohlsAPI.SoundAbuse.PlayAllSounds()
        local WorkspaceDescendants = Workspace:GetDescendants()
        for i = 1, #WorkspaceDescendants do
            local v = WorkspaceDescendants[i]
            if (v:IsA("Sound")) then
                v:Play()
            end
        end

        return true
    end

    -- // Sound Abuse: Play Music
    function KohlsAPI.SoundAbuse.PlayMusic()
        local Sound = GameFolder.Folder:FindFirstChildWhichIsA("Sound")
        if (Sound) then
            Sound:Play()
            return true
        else
            local ErrorReason = "There is no music sound."
            if (KohlsAPI.Configurable.Errors) then
                error(ErrorReason)
            end
            return false, ErrorReason
        end

        return true
    end

    -- // Sound Abuse: Stop All Sounds
    function KohlsAPI.SoundAbuse.StopAllSounds()
        local WorkspaceDescendants = Workspace:GetDescendants()
        for i = 1, #WorkspaceDescendants do
            local v = WorkspaceDescendants[i]
            if (v:IsA("Sound")) then
                v:Stop()
            end
        end

        return true
    end

    -- // Sound Abuse: Stop Music
    function KohlsAPI.SoundAbuse.StopMusic()
        local Sound = GameFolder.Folder:FindFirstChildWhichIsA("Sound")
        if (Sound) then
            Sound:Stop()
            return true
        else
            local ErrorReason = "There is no music sound."
            if (KohlsAPI.Configurable.Errors) then
                error(ErrorReason)
            end
            return false, ErrorReason
        end

        return true
    end

    -- // Trolling: Fill Screen with text
    function KohlsAPI.Trolling.TextScreenFill(text, x, y, duration, repeatText, index)
        -- // Vars
        x = x or 45
        y = y or 90
        duration = duration or 2
        repeatText = repeatText or false
        local newLines = ""
        local lineText = text

        -- // Text
        while (#lineText < 286 and repeatText) do
            lineText = lineText .. text .. " "
        end

        -- // New lines
        for i = 1, y do
            newLines = newLines .. "\n"
        end

        -- // Message
        if (repeatText) then
            for i = 1, x do
                newLines = newLines .. lineText .. "\n"
            end
        end

        -- // Duration handling
        if (duration % 2 ~= 0) then
            duration = duration + duration % 2
        end

        -- // Output
        for i = 1, (duration / 2) do
            if (index == true) then
                Players.Chat(Players, "h/" .. newLines .. lineText)
            else
                Players:Chat("h/" .. newLines .. lineText)
            end
            wait(2)
        end
    end

    -- // Whitelist: Whitelist
    function KohlsAPI.Whitelist.WhitelistUnwhitelist(Player, Unwhitelist)
        -- // Handling
        if (typeof(Player) ~= 'Instance') then
            local ErrorReason = "Argument #1 expected Instance got " .. typeof(Player)
            if (KohlsAPI.Configurable.Errors) then
                error(ErrorReason)
            end
            return false, ErrorReason
        end
        if (Player.Parent ~= Players) then
            local ErrorReason = "Argument #1 is not a member of Players"
            if (KohlsAPI.Configurable.Errors) then
                error(ErrorReason)
            end
            return false, ErrorReason
        end
        if (Unwhitelist ~= nil and typeof(Unwhitelist) ~= 'boolean') then
            local ErrorReason = "Argument #2 expected boolean got " .. typeof(Unwhitelist)
            if (KohlsAPI.Configurable.Errors) then
                error(ErrorReason)
            end
            return false, ErrorReason
        end

        -- // Script
        local Success, GeneralWhitelisted, Whitelisted, ProtectedWhitelisted = isWhitelisted(Player)

        if (ProtectedWhitelisted) then
            local ErrorReason = Unwhitelist and "This player is protected." or "This player has already been whitelisted."
            if (KohlsAPI.Configurable.Errors) then
                error(ErrorReason)
            end
            return false, ErrorReason
        end

        if (GeneralWhitelisted) then
            if (Unwhitelist) then
                for i = 1, #KohlsAPI.PlayerManager.Players do
                    local v = KohlsAPI.PlayerManager.Players[i]
                    if (v.UserId == Player.UserId) then
                        v.Whitelisted = false
                        return true
                    end
                end
            else
                local ErrorReason = "This player has already been whitelisted."
                if (KohlsAPI.Configurable.Errors) then
                    error(ErrorReason)
                end
                return false, ErrorReason
            end
        else
            if (Unwhitelist) then
                local ErrorReason = "This player has not been whitelisted."
                if (KohlsAPI.Configurable.Errors) then
                    error(ErrorReason)
                end
                return false, ErrorReason
            else
                for i = 1, #KohlsAPI.PlayerManager.Players do
                    local v = KohlsAPI.PlayerManager.Players[i]
                    if (v.UserId == Player.UserId) then
                        v.Whitelisted = true
                        return true
                    end
                end
            end
        end

        local ErrorReason = "Something went wrong."
        if (KohlsAPI.Configurable.Errors) then
            error(ErrorReason)
        end
        return false, ErrorReason
    end

    -- // End
    return KohlsAPI
end