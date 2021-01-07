--[[
    uh theres a bug where the gui doesnt fully load sometimes idk why
]]

repeat wait() until game:IsLoaded()

-- // Initialise
if getgenv().DarkKohls then return getgenv().DarkKohls end
getgenv().DarkKohls = {
    MaterialLuaConfig = {
        Title = "Dark Kohls",
        Style = 3,
        SizeX = 500,
        SizeY = 350,
        Theme = "Dark",
    },
}

-- // Services
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")

-- // Vars
local DropdownPlayers = {}
local PlayerConnections = {}
loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Kohls%20Admin%20House/DarkKohls/API.lua"))()({
    Errors = false,
    ScriptName = "DarkKohls"
})

-- // GUI
local MaterialUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/MaterialLua/master/Module.lua"))()
local Material = MaterialUI.Load(DarkKohls.MaterialLuaConfig)
local GUIConfig = HttpService:JSONDecode(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Kohls%20Admin%20House/DarkKohls/GUIData.json"))
local Inputs = {
    {Name = "BlacklistSelectGear", Value = nil},
    {Name = "BlacklistSelectGear", Value = nil},
    {Name = "BlacklistSelectPlayer", Value = nil},
    {Name = "BlacklistSelectPhrase", Value = nil},
    {Name = "BlacklistSelectPunishmentPhrase", Value = nil},
    {Name = "CommandsSelectPhrase", Value = nil},
    {Name = "MiscSelectColour", Value = Color3.fromRGB(255, 150, 150)},
    {Name = "SelectArea", Value = nil},
    {Name = "PlayerSelectPlayer", Value = nil},
    {Name = "WhitelistSelectPlayer", Value = nil}
}

-- // Get All Player Names
local function GetAllPlayerNames()
    local PlayerTable = Players:GetPlayers()
    local AllPlayers = {}

    for i = 1, #PlayerTable do
        local v = PlayerTable[i]
        AllPlayers[#AllPlayers + 1] = v.Name
    end

    return AllPlayers
end

-- // Update Player Dropdowns
local function UpdatePlayerDropdowns()
    for i = 1, #DropdownPlayers do
        local v = DropdownPlayers[i]
        v:SetOptions(GetAllPlayerNames())
    end
    return true
end

PlayerConnections[1] = Players.PlayerAdded:Connect(UpdatePlayerDropdowns)
PlayerConnections[2] = Players.PlayerRemoving:Connect(UpdatePlayerDropdowns)

-- // Automatically do some config
local function SetupTextMenu(Page, CommandName, Options)
    if (not Options) then Options = {} end

    local Module = Page.Name
    local CommandConfig = GUIConfig[Module][CommandName]
    local Config

    if (CommandConfig["Type"] == "Label") then
        Config = {
            Text = CommandConfig["Text"]
        }
    else
        Config = {
            Text = CommandConfig["Name"],
            Menu = {
                Infomation = function(self)
                    local Description = CommandConfig["Description"]
                    if (CommandConfig["Admin"] or CommandConfig["Persons299"]) then
                        Description = Description .. (CommandConfig["Persons299"] and " Person's 299 Admin is required" or " Admin is required.")
                    end
    
                    Material.Banner({
                        Text = Description
                    })
                end
            }
        }
    end

    if (not Options.Callback) then
        Options.Callback = function(...)
            
        end
    end

    if (CommandName:find("SelectPlayer")) then
        Config.Options = GetAllPlayerNames()
    end

    for i,v in pairs(Options) do
        if (i ~= "Text" or i ~= "Menu") then
            Config[i] = v
        end
    end
    
    local Object = Page[CommandConfig["Type"]](Config)
    if (CommandName:find("SelectPlayer")) then
        DropdownPlayers[#DropdownPlayers + 1] = Object
    end

    return Object
end

-- // Get Input (internal)
local function getSetInput(Name, InputValue)
    for i = 1, #Inputs do
        local v = Inputs[i]

        if (v.Name == Name) then
            if (InputValue) then
                v.Value = InputValue
            end

            return v.Value
        end
    end

    return false
end

-- // Failsafe commands
local function FailsafeCommand(Requirements)
    for i = 1, #Requirements do
        local v = Requirements[i]
        local Value = getSetInput(v.Name)

        if (not Value) then
            return false, v.ErrorReason
        end
    end

    return true
end

-- // Page Creation
local Pages = {}
local function createPage(PageName)
    local newPage = Material.New({Title = PageName})
    newPage.Name = PageName
    Pages[#Pages + 1] = newPage

    return newPage
end

-- // Create Pages
local Admin = createPage("Admin")
local Blacklist = createPage("Blacklist")
local Commands = createPage("Commands")
local Misc = createPage("Misc")
local Player = createPage("Player")
local Protections = createPage("Protections")
local Server = createPage("Server")
local SoundAbuse = createPage("Sound Abuse")
local Trolling = createPage("Trolling")
local Whitelist = createPage("Whitelist")

-- // Admin: Main Functions Label
SetupTextMenu(Admin, "MainFunctions")

-- // Admin: Regenerate Admin
local RegenerateAdmin = SetupTextMenu(Admin, "RegenerateAdmin", {
    Callback = function()
        local Command, ErrorReason = KohlsAPI.Admin.RegenerateAdmin()

        if (not Command) then
            Material.Banner({
                Text = "Error: " .. ErrorReason
            })
        else
            Material.Banner({
                Text = "Successfully regenerated the admin pads."
            })
        end
    end
})

-- // Admin: Get Admin
local GetAdmin = SetupTextMenu(Admin, "GetAdmin", {
    Callback = function()
        local Command, ErrorReason = KohlsAPI.Admin.GetAdmin()

        if (not Command) then
            Material.Banner({
                Text = "Error: " .. ErrorReason
            })
        else
            Material.Banner({
                Text = "Successfully got admin."
            })
        end
    end
})

-- // Admin: Permanant Admin
coroutine.wrap(function()
    local PermanantAdmin = SetupTextMenu(Admin, "PermanantAdmin", {
        Enabled = KohlsAPI.SettingGetSet("AdminPermanantAdmin"),
        Callback = function(Value)
            KohlsAPI.SettingGetSet("AdminPermanantAdmin", Value)

            if (Value) then
                KohlsAPI.Admin.GetAdmin(KohlsAPI.SelectedPad)
            end
        end
    })
end)()

-- // Blacklist: Blacklist Options (Gear) Label
SetupTextMenu(Blacklist, "BlacklistOptionsGearLabel")

-- // Blacklist: Blacklist Gear
local BlacklistSelectGear = SetupTextMenu(Blacklist, "BlacklistSelectGear", {
    Callback = function(Value)
        if (not tonumber(Value)) then
            Material.Banner({
                Text = "Please input a number value."
            })
            return false
        end
    end
})

-- // Blacklist: Main Functions (Gear) Label
SetupTextMenu(Blacklist, "MainFunctionsGearLabel")

-- // Blacklist: Blacklist Gear
local BlacklistGear = SetupTextMenu(Blacklist, "BlacklistGear", {
    Callback = function()
        -- // Failsafe command
        local FailsafeSuccess, FailsafeSuccessErrorReason = FailsafeCommand({
            {
                Name = "BlacklistSelectGear",
                ErrorReason = "Please specify a gear to blacklist."
            }
        })
        if (not FailsafeSuccess) then
            Material.Banner({
                Text = FailsafeSuccessErrorReason
            })
            return false, FailsafeSuccessErrorReason
        end

        -- // Get the input
        local SelectedGear = getSetInput("BlacklistSelectGear")

        -- // Blacklist the gear and failsafing
        local BlacklistGearSuccess, ErrorReason = KohlsAPI.Blacklist.BlacklistUnblacklistGear(SelectedGear)
        if (not BlacklistGearSuccess) then
            Material.Banner({
                Text = ErrorReason
            })
            return false, ErrorReason
        else
            Material.Banner({
                Text = "Successfully blacklisted gear."
            })
        end
    end
})

-- // Blacklist: Unblacklist Gear
local UnblacklistGear = SetupTextMenu(Blacklist, "UnblacklistGear", {
    Callback = function()
        -- // Failsafe command
        local FailsafeSuccess, FailsafeSuccessErrorReason = FailsafeCommand({
            {
                Name = "BlacklistSelectGear",
                ErrorReason = "Please specify a gear to blacklist."
            }
        })
        if (not FailsafeSuccess) then
            Material.Banner({
                Text = FailsafeSuccessErrorReason
            })
            return false, FailsafeSuccessErrorReason
        end

        -- // Get the input
        local SelectedGear = getSetInput("BlacklistSelectGear")

        -- // Blacklist the gear and failsafing
        local BlacklistGearSuccess, ErrorReason = KohlsAPI.Blacklist.BlacklistUnblacklistGear(SelectedGear, true)
        if (not BlacklistGearSuccess) then
            Material.Banner({
                Text = ErrorReason
            })
            return false, ErrorReason
        else
            Material.Banner({
                Text = "Successfully unblacklisted gear."
            })
        end
    end
})

-- // Blacklist: Alerts Label
SetupTextMenu(Blacklist, "AlertsLabel")

-- // Blacklist: Alert Blacklisted Gear Use
local AlertBlacklistGearUse = SetupTextMenu(Blacklist, "AlertBlacklistGearUse", {
    Enabled = KohlsAPI.SettingGetSet("BlacklistAlertBlacklistGearUse"),
    Callback = function(Value)
        KohlsAPI.SettingGetSet("BlacklistAlertBlacklistGearUse", Value)
    end
})

-- // Blacklist: Blacklist Options (Phrase) Label
SetupTextMenu(Blacklist, "BlacklistOptionsPhraseLabel")

-- // Blacklist: Select Player
local BlacklistSelectPlayer = SetupTextMenu(Blacklist, "BlacklistSelectPlayer", {
    Callback = function(Value)
        getSetInput("BlacklistSelectPlayer", Players[Value])
    end
})

-- // Blacklist: Select Phrase
local BlacklistSelectPhrase = SetupTextMenu(Blacklist, "BlacklistSelectPhrase", {
    Callback = function(Value)
        getSetInput("BlacklistSelectPhrase", Value)
    end
})

-- // Blacklist: Select Phrase
local BlacklistSelectPunishmentPhrase = SetupTextMenu(Blacklist, "BlacklistSelectPunishmentPhrase", {
    Callback = function(Value)
        getSetInput("BlacklistSelectPunishmentPhrase", Value)
    end
})

-- // Blacklist: Main Functions (Phrase) Label
SetupTextMenu(Blacklist, "MainFunctionsPhraseLabel")

-- // Blacklist: Blacklist Phrase
local BlacklistPhrase = SetupTextMenu(Blacklist, "BlacklistPhrase", {
    Callback = function()
        -- // Failsafe command
        local FailsafeSuccess, FailsafeSuccessErrorReason = FailsafeCommand({
            {
                Name = "BlacklistSelectPhrase",
                ErrorReason = "Please specify a phrase."
            },
            {
                Name = "BlacklistSelectPunishmentPhrase",
                ErrorReason = "Please specify a phrase."
            }
        })
        if (not FailsafeSuccess) then
            Material.Banner({
                Text = FailsafeSuccessErrorReason
            })
            return false, FailsafeSuccessErrorReason
        end

        -- // Script
        local CommandReturn, ErrorReason = KohlsAPI.Blacklist.BlacklistUnblacklistPhrase(getSetInput("BlacklistSelectPhrase"), getSetInput("BlacklistSelectPunishmentPhrase"), getSetInput("BlacklistSelectPlayer"))
        if (not CommandReturn) then
            Material.Banner({
                Text = ErrorReason
            })
            return false, ErrorReason
        else
            Material.Banner({
                Text = "Blacklisted phrase."
            })
        end
    end
})

-- // Blacklist: Unblacklist Phrase
local UnblacklistPhrase = SetupTextMenu(Blacklist, "UnblacklistPhrase", {
    Callback = function()
        -- // Failsafe command
        local FailsafeSuccess, FailsafeSuccessErrorReason = FailsafeCommand({
            {
                Name = "BlacklistSelectPhrase",
                ErrorReason = "Please specify a phrase."
            }
        })
        if (not FailsafeSuccess) then
            Material.Banner({
                Text = FailsafeSuccessErrorReason
            })
            return false, FailsafeSuccessErrorReason
        end

        -- // Script
        local CommandReturn, ErrorReason = KohlsAPI.Blacklist.BlacklistUnblacklistPhrase(getSetInput("BlacklistSelectPhrase"), getSetInput("BlacklistSelectPunishmentPhrase"), getSetInput("BlacklistSelectPlayer"), true)
        if (not CommandReturn) then
            Material.Banner({
                Text = ErrorReason
            })
            return false, ErrorReason
        else
            Material.Banner({
                Text = "Unblacklisted phrase."
            })
        end
    end
})

-- // Commands: Select Phrase
local CommandsSelectPhrase = SetupTextMenu(Commands, "CommandsSelectPhrase", {
    Callback = function(Value)
        getSetInput("CommandsSelectPhrase", Value)
    end
})

-- // Commands: Main Functions Label
SetupTextMenu(Commands, "MainFunctionsLabel")

-- // Commands: Say Phrase
local SayPhrase = SetupTextMenu(Commands, "SayPhrase", {
    Callback = function()
        -- // Failsafe command
        local FailsafeSuccess, FailsafeSuccessErrorReason = FailsafeCommand({
            {
                Name = "CommandsSelectPhrase",
                ErrorReason = "Please specify a phrase."
            }
        })
        if (not FailsafeSuccess) then
            Material.Banner({
                Text = FailsafeSuccessErrorReason
            })
            return false, FailsafeSuccessErrorReason
        end

        -- // Script
        Players:Chat(getSetInput("CommandsSelectPhrase"))
    end
})

-- // Commands: Spam Phrase
local SpamPhrase = SetupTextMenu(Commands, "SpamPhrase", {
    Callback = function()
        -- // Failsafe command
        local FailsafeSuccess, FailsafeSuccessErrorReason = FailsafeCommand({
            {
                Name = "CommandsSelectPhrase",
                ErrorReason = "Please specify a phrase."
            }
        })
        if (not FailsafeSuccess) then
            Material.Banner({
                Text = FailsafeSuccessErrorReason
            })
            return false, FailsafeSuccessErrorReason
        end

        -- // Script
        local CommandReturn, ErrorReason = KohlsAPI.Commands.StopStartSpamPhrase(getSetInput("CommandsSelectPhrase"))

        if (not CommandReturn) then
            Material.Banner({
                Text = ErrorReason
            })
            return false, ErrorReason
        else
            Material.Banner({
                Text = "Spamming phrase."
            })
        end
    end
})

-- // Commands: Stop Spam Phrase
local StopSpamPhrase = SetupTextMenu(Commands, "StopSpamPhrase", {
    Callback = function()
        -- // Failsafe command
        local FailsafeSuccess, FailsafeSuccessErrorReason = FailsafeCommand({
            {
                Name = "CommandsSelectPhrase",
                ErrorReason = "Please specify a phrase."
            }
        })
        if (not FailsafeSuccess) then
            Material.Banner({
                Text = FailsafeSuccessErrorReason
            })
            return false, FailsafeSuccessErrorReason
        end

        -- // Script
        local CommandReturn, ErrorReason = KohlsAPI.Commands.StopStartSpamPhrase(getSetInput("CommandsSelectPhrase"), true)

        if (not CommandReturn) then
            Material.Banner({
                Text = ErrorReason
            })
            return false, ErrorReason
        else
            Material.Banner({
                Text = "Stopped spamming phrase."
            })
        end
    end
})

-- // Misc: Painting Label
SetupTextMenu(Misc, "PaintingLabel")

-- // Misc: Select Colour
local MiscSelectColour = SetupTextMenu(Misc, "MiscSelectColour", {
    Default = Color3.fromRGB(255, 150, 150),
    Callback = function(Value)
        getSetInput("MiscSelectColour", Value)
    end
})

-- // Misc: Select Area
local SelectArea = SetupTextMenu(Misc, "SelectArea", {
    Options = {"All", "Admin Dividers", "Basic House", "Obby", "Building Bricks", "Obby Box",},
    Callback = function(Value)
        getSetInput("SelectArea", Value)
    end
})

-- // Misc: Paint Area
local PaintArea = SetupTextMenu(Misc, "PaintArea", {
    Callback = function()
        -- // Failsafe command
        local FailsafeSuccess, FailsafeSuccessErrorReason = FailsafeCommand({
            {
                Name = "MiscSelectColour",
                ErrorReason = "Please specify a colour."
            },
            {
                Name = "SelectArea",
                ErrorReason = "Please specify an area."
            }
        })
        if (not FailsafeSuccess) then
            Material.Banner({
                Text = FailsafeSuccessErrorReason
            })
            return false, FailsafeSuccessErrorReason
        end

        -- // Script
        local CommandReturn, ErrorReason = KohlsAPI.Misc.PaintArea(getSetInput("SelectArea"), getSetInput("MiscSelectColour"))

        if (not CommandReturn) then
            Material.Banner({
                Text = ErrorReason
            })
            return false, ErrorReason
        else
            Material.Banner({
                Text = "Painted."
            })
        end
    end
})

-- // Misc: Helpful Label
SetupTextMenu(Misc, "HelpfulLabel")

-- // Misc: Disable Obby Kill
local DisableObbyKill = SetupTextMenu(Misc, "DisableObbyKill", {
    Callback = function()
        if (KohlsAPI.Misc.DisableObbyKill()) then
            Material.Banner({
                Text = "Done!"
            })
        else
            Material.Banner({
                Text = "This has already been done."
            })
        end
    end
})

-- // Misc: Fun Label 
SetupTextMenu(Misc, "FunLabel")

-- // Misc: Start Audio Visualiser
local StartAudioVisualiser = SetupTextMenu(Misc, "StartAudioVisualiser", {
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Kohls%20Admin%20House/AudioVisualiser/AudioVisualiser.lua"))()
    end
})

-- // Misc: Start Music Commands
local StartMusicCommands = SetupTextMenu(Misc, "StartMusicCommands", {
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Kohls%20Admin%20House/MusicCommands/Main.lua"))()
    end
})

-- // Misc: Chat Bypass
--[[
loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Word%20Bypass/Main.lua"))()
getgenv().BypassText = false
local ChatBypass = SetupTextMenu(Misc, "ChatBypass", {
    Callback = function(Value)
        getgenv().BypassText = Value
    end
})
]]

-- // Misc: GUI Label
SetupTextMenu(Misc, "GUILabel")

-- // Misc: Save Settings
local SaveSettings = SetupTextMenu(Misc, "SaveSettings", {
    Callback = function()
        local Success, ErrorReason = KohlsAPI.SaveSettings()

        if (not Success) then
            Material.Banner({
                Text = ErrorReason
            })
            return false, ErrorReason
        else
            Material.Banner({
                Text = "Saved settings!"
            })
        end
    end
})

-- // Misc: Export GUI Data
local ExportGUIData = SetupTextMenu(Misc, "ExportGUIData", {
    Callback = function()
        -- // Failsafing
        if (not setclipboard) then
            local FailsafeSuccessErrorReason = "You do not have setclipbaord function."
            Material.Banner({
                Text = FailsafeSuccessErrorReason
            })

            return false, FailsafeSuccessErrorReason
        end

        -- // Script
        local exportedGUIData = KohlsAPI.Misc.ExportGUIData()
        setclipboard(exportedGUIData)

        Material.Banner({
            Text = "GUI Data copied to clipboard."
        })
    end
})

-- // Misc: Shutdown GUI
local ShutdownGUI = SetupTextMenu(Misc, "ShutdownGUI", {
    Callback = function()
        KohlsAPI.Shutdown()
        for i = 1, #PlayerConnections do
            local v = PlayerConnections[i]
            if (v) then
                v:Disconnect()
            end
        end
        game:GetService("CoreGui")["Dark Kohls"]:Destroy()
        getgenv().DarkKohls = nil
    end
})

-- // Misc: Other Label
SetupTextMenu(Misc, "OtherLabel")

-- // Misc: Rejoin
local Rejoin = SetupTextMenu(Misc, "Rejoin", {
    Callback = function()
        TeleportService:Teleport(game.PlaceId)
    end
})

-- // Player: Select Player
local PlayerSelectPlayer = SetupTextMenu(Player, "PlayerSelectPlayer", {
    Callback = function(Value)
        getSetInput("PlayerSelectPlayer", Players[Value])
    end
})

-- // Player: Player Functions Label
SetupTextMenu(Player, "PlayerFunctionsLabel")

-- // Player: Get Age
local GetAge = SetupTextMenu(Player, "GetAge", {
    Callback = function()
        -- // Failsafe command
        local FailsafeSuccess, FailsafeSuccessErrorReason = FailsafeCommand({
            {
                Name = "PlayerSelectPlayer",
                ErrorReason = "Please specify a player."
            }
        })
        if (not FailsafeSuccess) then
            Material.Banner({
                Text = FailsafeSuccessErrorReason
            })
            return false, FailsafeSuccessErrorReason
        end

        -- // Script
        local SPlayer = getSetInput("PlayerSelectPlayer")
        Material.Banner({
            Text = SPlayer.Name .. "'s Account Age is: " .. SPlayer.AccountAge .. " days."
        })
    end
})

-- // Player: Give Client BTools
local GiveClientBtools = SetupTextMenu(Player, "GiveClientBtools", {
    Callback = function()
        -- // Failsafe command
        local FailsafeSuccess, FailsafeSuccessErrorReason = FailsafeCommand({
            {
                Name = "PlayerSelectPlayer",
                ErrorReason = "Please specify a player."
            }
        })
        if (not FailsafeSuccess) then
            Material.Banner({
                Text = FailsafeSuccessErrorReason
            })
            return false, FailsafeSuccessErrorReason
        end

        -- // Script
        local SPlayer = getSetInput("PlayerSelectPlayer")
        local GearIds = {16200204, 16200402, 16969792, 73089190, 21001552}
        for i = 1, #GearIds do
            local v = GearIds[i]
            Players:Chat(":gear " .. SPlayer.Name .. " " .. v)
        end
    end
})

-- // Protections: Main Functions Label
SetupTextMenu(Protections, "MainFunctionsLabel")

-- // Protections: Anti Blind
local AntiBlind = SetupTextMenu(Protections, "AntiBlind", {
    Enabled = KohlsAPI.SettingGetSet("ProtectionsAntiBlind"),
    Callback = function(Value)
        KohlsAPI.SettingGetSet("ProtectionsAntiBlind", Value)
    end
})


-- // Protections: Anti Freeze
local AntiFreeze = SetupTextMenu(Protections, "AntiFreeze", {
    Enabled = KohlsAPI.SettingGetSet("ProtectionsAntiFreeze"),
    Callback = function(Value)
        KohlsAPI.SettingGetSet("ProtectionsAntiFreeze", Value)
    end
})

-- // Protections: Anti Fling
local AntiFling = SetupTextMenu(Protections, "AntiFling", {
    Enabled = KohlsAPI.SettingGetSet("ProtectionsAntiFling"),
    Callback = function(Value)
        KohlsAPI.SettingGetSet("ProtectionsAntiFling", Value)
    end
})

-- // Protections: Anti Jail
local AntiJail = SetupTextMenu(Protections, "AntiJail", {
    Enabled = KohlsAPI.SettingGetSet("ProtectionsAntiJail"),
    Callback = function(Value)
        KohlsAPI.SettingGetSet("ProtectionsAntiJail", Value)
    end
})

-- // Protections: Anti Kill
local AntiKill = SetupTextMenu(Protections, "AntiKill", {
    Enabled = KohlsAPI.SettingGetSet("ProtectionsAntiKill"),
    Callback = function(Value)
        KohlsAPI.SettingGetSet("ProtectionsAntiKill", Value)
    end
})

-- // Protections: Anti Punish
local AntiPunish = SetupTextMenu(Protections, "AntiPunish", {
    Enabled = KohlsAPI.SettingGetSet("ProtectionsAntiPunish"),
    Callback = function(Value)
        KohlsAPI.SettingGetSet("ProtectionsAntiPunish", Value)
    end
})

-- // Protections: Anti Message Spam
local AntiMessageSpam = SetupTextMenu(Protections, "AntiMessageSpam", {
    Enabled = KohlsAPI.SettingGetSet("ProtectionsAntiMessageSpam"),
    Callback = function(Value)
        KohlsAPI.SettingGetSet("ProtectionsAntiMessageSpam", Value)
    end
})

-- // Protections: Anti Skydive
local AntiSkydive = SetupTextMenu(Protections, "AntiSkydive", {
    Enabled = KohlsAPI.SettingGetSet("ProtectionsAntiSkydive"),
    Callback = function(Value)
        KohlsAPI.SettingGetSet("ProtectionsAntiSkydive", Value)
    end
})

-- // Protections: Anti Sit
local AntiSit = SetupTextMenu(Protections, "AntiSit", {
    Enabled = KohlsAPI.SettingGetSet("ProtectionsAntiSit"),
    Callback = function(Value)
        KohlsAPI.SettingGetSet("ProtectionsAntiSit", Value)
    end
})

-- // Protections: Anti Logs
local AntiLogs = SetupTextMenu(Protections, "AntiLogs", {
    Enabled = KohlsAPI.SettingGetSet("ProtectionsAntiLogs"),
    Callback = function(Value)
        KohlsAPI.SettingGetSet("ProtectionsAntiLogs", Value)
    end
})

-- // Server: Alerts Label
SetupTextMenu(Server, "AlertsLabel")

-- // Server: Alert C System Use
local AlertCSystemUse = SetupTextMenu(Server, "AlertCSystemUse", {
    Enabled = KohlsAPI.SettingGetSet("ServerCSystemAlert"),
    Callback = function(Value)
        KohlsAPI.SettingGetSet("ServerCSystemAlert", Value)
    end
})

-- // Server: Helpful Label
SetupTextMenu(Server, "HelpfulLabel")

-- // Server: Create Phantom Baseplate
local CreatePhantomBaseplate = SetupTextMenu(Server, "CreatePhantomBaseplate", {
    Callback = function()
        KohlsAPI.Server.CreatePhantomBaseplate()

        Material.Banner({
            Text = "Made a phantom baseplate."
        })
    end
})

-- // Server: Remove Phantom Baseplates
local RemovePhantomBaseplates = SetupTextMenu(Server, "RemovePhantomBaseplates", {
    Callback = function()
        KohlsAPI.Server.RemovePhantomBaseplates()

        Material.Banner({
            Text = "Removed Phantom Baseplates."
        })
    end
})

-- // Server: Abusive Label
SetupTextMenu(Server, "AbusiveLabel")

-- // Server: Respawn Explode
local RespawnExplode = SetupTextMenu(Server, "RespawnExplode", {
    Callback = function(Value)
        Value = not Value
        pcall(KohlsAPI.Server.RespawnExplode, Value)
    end
})

-- // Server: Epilepsy
local Epilepsy = SetupTextMenu(Server, "Epilepsy", {
    Callback = function(Value)
        KohlsAPI.SettingGetSet("ServerEpilepsy", Value)
    end
})

-- // Server: Click Spawn Water
local ClickSpawnWater = SetupTextMenu(Server, "ClickSpawnWater", {
    Callback = function(Value)
        KohlsAPI.SettingGetSet("ServerClickSpawnWater", Value)
    end
})

-- // Server: Part Spam
local PartSpam = SetupTextMenu(Server, "PartSpam", {
    Callback = function(Value)
        Value = not Value
        pcall(KohlsAPI.Commands.StopStartSpamPhrase, ":part/10/10/10", Value)
    end
})

-- // Server: Move Baseplate
local MoveBaseplate = SetupTextMenu(Server, "MoveBaseplate", {
    Callback = function()
        local CommandSuccess, ErrorReason = KohlsAPI.Server.MoveBaseplate()

        if (not CommandSuccess) then
            Material.Banner({
                Text = ErrorReason
            })
            return false, ErrorReason
        else
            Material.Banner({
                Text = "Put you in the position to move the baseplate, you may move it by tping or skydiving."
            })
        end
    end
})

-- // Server: Crash Server
local CrashServer = SetupTextMenu(Server, "CrashServer", {
    Callback = function()
        local CommandSuccess, ErrorReason = KohlsAPI.Server.CrashServer()

        if (not CommandSuccess) then
            Material.Banner({
                Text = ErrorReason
            })
            return false, ErrorReason
        else
            Material.Banner({
                Text = "Crashed server."
            })
        end
    end
})

-- // Sound Abuse: Main Functions Label
SetupTextMenu(SoundAbuse, "MainFunctionsLabel")

-- // Sound Abuse: Ear Rape
local EarRape = SetupTextMenu(SoundAbuse, "EarRape", {
    Callback = function(Value)
        KohlsAPI.SettingGetSet("SoundAbuseEarRape", Value)
    end
})

-- // Sound Abuse: Play All Sounds
local PlayAllSounds = SetupTextMenu(SoundAbuse, "PlayAllSounds", {
    Callback = function()
        KohlsAPI.SoundAbuse.PlayAllSounds()
    end
})

-- // Sound Abuse: Play Music
local PlayMusic = SetupTextMenu(SoundAbuse, "PlayMusic", {
    Callback = function()
        KohlsAPI.SoundAbuse.PlayMusic()
    end
})

-- // Sound Abuse: Stop All Sounds
local StopAllSounds = SetupTextMenu(SoundAbuse, "StopAllSounds", {
    Callback = function()
        KohlsAPI.SoundAbuse.StopAllSounds()
    end
})

-- // Sound Abuse: Stop Music
local StopMusic = SetupTextMenu(SoundAbuse, "StopMusic", {
    Callback = function()
        KohlsAPI.SoundAbuse.StopMusic()
    end
})

-- // Trolling: Text Trolling
SetupTextMenu(Trolling, "TextTrolling")

-- // Trolling: Text
local TrollingText = SetupTextMenu(Trolling, "TrollingText", {
    Text = "hi"
})

-- // Trolling: X
local TrollingX = SetupTextMenu(Trolling, "TrollingX", {
    Text = "45"
})

-- // Trolling: Y
local TrollingY = SetupTextMenu(Trolling, "TrollingY", {
    Text = "90"
})

-- // Trolling: Duration
local TrollingDuration = SetupTextMenu(Trolling, "TrollingDuration", {
    Text = "2"
})

-- // Trolling: Fill Screen
local TrollingFillScreen = SetupTextMenu(Trolling, "TrollingFillScreen")

-- // Trolling: Main Functions
SetupTextMenu(Trolling, "MainFunctionsLabel")

-- // Trolling: Start
local TrollingStart = SetupTextMenu(Trolling, "TrollingStart", {
    Callback = function()
        -- // Vars
        local Text = TrollingText:GetText()
        local X = tonumber(TrollingX:GetText())
        local Y = tonumber(TrollingY:GetText())
        local Duration = tonumber(TrollingDuration:GetText())
        local FillScreen = TrollingFillScreen:GetState()
        
        -- // Handling
        if (not X) then
            local ErrorReason = "The input for 'X' is not a number"
            Material.Banner({
                Text = ErrorReason
            })
            return false, ErrorReason
        end
        if (not Y) then
            local ErrorReason = "The input for 'Y' is not a number"
            Material.Banner({
                Text = ErrorReason
            })
            return false, ErrorReason
        end
        if (not Duration) then
            local ErrorReason = "The input for 'Duration' is not a number"
            Material.Banner({
                Text = ErrorReason
            })
            return false, ErrorReason
        end

        -- // Start
        KohlsAPI.Trolling.TextScreenFill(Text, X, Y, Duration, FillScreen)
    end
})

-- // Whitelist: Select Player
local WhitelistSelectPlayer = SetupTextMenu(Whitelist, "WhitelistSelectPlayer", {
    Callback = function(Value)
        getSetInput("WhitelistSelectPlayer", Players[Value])
    end
})

-- // Whitelist: Player Functions Label
SetupTextMenu(Whitelist, "PlayerFunctionsLabel")

-- // Whitelist: Whitelist Player
local WhitelistPlayer = SetupTextMenu(Whitelist, "Whitelist", {
    Callback = function()
        -- // Failsafe command
        local FailsafeSuccess, FailsafeSuccessErrorReason = FailsafeCommand({
            {
                Name = "WhitelistSelectPlayer",
                ErrorReason = "Please specify a player."
            }
        })
        if (not FailsafeSuccess) then
            Material.Banner({
                Text = FailsafeSuccessErrorReason
            })
            return false, FailsafeSuccessErrorReason
        end

        -- // Script
        local CommandSuccess, ErrorReason = KohlsAPI.Whitelist.WhitelistUnwhitelist(getSetInput("WhitelistSelectPlayer"))

        if (not CommandSuccess) then
            Material.Banner({
                Text = ErrorReason
            })
        else
            Material.Banner({
                Text = "Whitelisted Player."
            })
        end
    end
})

-- // Whitelist: Unwhitelist Player
local Unwhitelist = SetupTextMenu(Whitelist, "Unwhitelist", {
    Callback = function()
        -- // Failsafe command
        local FailsafeSuccess, FailsafeSuccessErrorReason = FailsafeCommand({
            {
                Name = "WhitelistSelectPlayer",
                ErrorReason = "Please specify a player."
            }
        })
        if (not FailsafeSuccess) then
            Material.Banner({
                Text = FailsafeSuccessErrorReason
            })
            return false, FailsafeSuccessErrorReason
        end

        -- // Script
        local CommandSuccess, ErrorReason = KohlsAPI.Whitelist.WhitelistUnwhitelist(getSetInput("WhitelistSelectPlayer"), true)

        if (not CommandSuccess) then
            Material.Banner({
                Text = ErrorReason
            })
        else
            Material.Banner({
                Text = "Unwhitelisted Player."
            })
        end
    end
})
