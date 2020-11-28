-- // Valiant ENV
loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/ValiantENV.lua"))()

-- // Main Script
if getgenv().KAHHaxLoaded then warn("oofkohls v2 already loaded!") return end
warn("Loading oofkohls v2 - Made By Stefanuk12#5820 | Stefanuk12")

-- // Initialise
if not getgenv()["KAHHax"] then getgenv()["KAHHax"] = {} end
if not getgenv()["KAHHax"]["InitialisedModules"] then getgenv()["KAHHax"]["InitialisedModules"] = {} end

-- // Vars
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local GameFolder = Workspace:WaitForChild("Terrain"):WaitForChild("_Game")
local AdminFolder = GameFolder:WaitForChild("Admin")
local Pads = AdminFolder:WaitForChild("Pads")
local WorkspaceFolder = GameFolder:WaitForChild("Workspace")
local HolderFolder = GameFolder:WaitForChild("Folder")
local NotificationHandler = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Notifications/Script.lua"))()
NotificationHandler["StorageLocation"] = game:GetService("CoreGui")

KAHHax["vars"] = {
    PlayerManager = {--[[
        PlayerUID = {
            Lagging = true,
            SpamList = {},
            BlacklistedPhrases = {},
            BlacklistConnection = {},
        },
    ]]},
    RainbowColor = Color3.fromRGB(0, 0, 0),
    WhitelistedUsers = {91318356, 23294806},
    MusicAPI = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Music%20API/Controller.lua"))(),
    ChatBypasser = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Word%20Bypass/Main.lua"))(),
    largeText = game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Kohls%20Admin%20House/LongText.txt"),
    gearList = {
        PaintBucket = 18474459,
        Hyperlaser = 130113146,
        RainbowCarpet = 225921000,
        Airstrike = 88885539,
        SuperRLauncher = 190094159,
        RLauncher = 32356064,
        SSTripmine = 11999247,
        ASSentry = 68603151,
        RPOSword = 159229806,
        IceStaff = 19704064,
        Transmorph = 29099749,
        ShiftingPolarity = 61459706,
        PortableJustice = 82357101,
    },
    BlacklistedGears = {
        "82357101",
        "94794847",
    },
    WhitelistedCMDs = {
        "play",
        "give",
        "smusic",
        "pmusic",
        "sallsounds",
        "pasounds",
        "tturret",
        "epilepsy",
        "paintarea",
        "regen",
    },
    SpamList = {},
    Prefix = ":",
    NetworkOwner = false,
    WhileWait = 0.01,
}
vars = KAHHax.vars
vars.ChatBypasser.ChatBypassEnabled = false

vars.Alert = function(...)
    local text = tostring(...)
    NotificationHandler.newNotification("ALERT", text, "Alert")
end

vars.Notify = function(...)
    local text = tostring(...)
    NotificationHandler.newNotification("SUCCESS", text, "Success")
end

if sethiddenproperty then
    game:GetService("RunService"):BindToRenderStep("NetworkRep", 0, function()
        if vars.NetworkOwner and gethiddenproperty(LocalPlayer, "SimulationRadius") ~= 1/0 then
            sethiddenproperty(LocalPlayer, "SimulationRadius", 1/0)
            sethiddenproperty(LocalPlayer, "MaximumSimulationRadius", 1/0)
        end
    end)
end

function KAHHax.vars.getPlayer(String)
    local Found = {}
    local Target = string.lower(String)
    if Target == "all" then
        for i,v in pairs(game:GetService("Players"):GetPlayers()) do
            table.insert(Found, v)
        end
    elseif Target == "others" then
        for i,v in pairs(game:GetService("Players"):GetPlayers()) do
            if v ~= game:GetService("Players").LocalPlayer then
                table.insert(Found, v)
            end
        end
    elseif Target == "me" then
        table.insert(Found, game:GetService("Players").LocalPlayer)
    else
        for i,v in pairs(game:GetService("Players"):GetPlayers()) do
            if v.Name:lower():sub(1, #String) == String:lower() then
                table.insert(Found, v)
            end
        end
    end
    return Found
end

function KAHHax.vars.checkWhitelisted(UserId)
    local PlayerName = Players:GetNameFromUserIdAsync(UserId)
    if vars.PlayerManager[PlayerName] and vars.PlayerManager[PlayerName]["Whitelisted"] then
        return true
    end
    return false
end

function KAHHax.vars.checkAllWhitelisted()
    for _,v in pairs(Players:GetPlayers()) do
        if KAHHax.vars.checkWhitelisted(v.UserId) then return true end
    end
    return false
end

function KAHHax.vars.addPlayerToManager(Player)
    if typeof(Player) == 'Instance' and Player.Parent == Players and Player ~= LocalPlayer then
        vars.PlayerManager[Player.Name] = {
            ["Lagging"] = false,
            ["BlacklistedPhrases"] = {},
            ["BlacklistConnection"] = {},
            ["Whitelisted"] = false,
        }
        vars.PlayerManager[Player.Name].BlacklistConnection.A = Player.Chatted:Connect(function(message)
            local Whitelisted = vars.PlayerManager[Player.Name].Whitelisted

            -- // Blacklist Phrases
            for _,v in pairs(vars.PlayerManager[Player.Name].BlacklistedPhrases) do
                if string.match(message, v.Phrase) then
                    Players:Chat(v.Punishment)
                end
            end

            -- // Blacklist Gears
            local splitString = string.split(message, " ")
            if not Whitelisted and string.match(splitString[1], "gear") then
                for _,v in pairs(vars.BlacklistedGears) do
                    if string.match(message, v) and splitString[2] then
                        if string.lower(splitString[2]) == 'me' then splitString[2] = Player.Name end
                        wait(0.5)
                        Players:Chat(":removetools "..splitString[2])
                    end
                end
            end

            -- // Whitelist CMDs
            if Player ~= LocalPlayer and vars.PlayerManager[Player.Name]["Whitelisted"] then
                for _, v in pairs(vars.WhitelistedCMDs) do
                    local Command = vars.Prefix..v
                    if string.match(message, vars.Prefix..v) and string.sub(message, 1, #Command) == Command then
                        KAHHax.CMDs[v].Function(message)
                    end
                end
            end
        end)
        print(Player.Name.. " has joined and added to the PlayerManager.")
    end
end

function KAHHax.vars.removePlayerFromManager(Player)
    if typeof(Player) == 'Instance' and Player.Parent == Players and vars.PlayerManager[Player.Name] then
        for i,v in pairs(vars.PlayerManager) do
            if i == Player.Name then
                for a,x in pairs(v.BlacklistConnection) do
                    if typeof(x) == "RBXScriptConnection" then
                        x:Disconnect()
                    end
                end
                vars.PlayerManager[i] = nil
                print(Player.Name.. " has left and been removed from the PlayerManager.")
                break
            end
        end
    end
end
wait(0.5)

-- // Player Manager
for i,v in pairs(Players:GetPlayers()) do
    vars.addPlayerToManager(v)
end

Players.PlayerAdded:Connect(function(player)
    vars.addPlayerToManager(player)
end)

Players.PlayerRemoving:Connect(function(player)
    vars.removePlayerFromManager(player)
end)

-- // Rainbow Color
coroutine.wrap(function()
    while wait() do
        vars.RainbowColor = Color3.fromHSV(tick() % 5 / 5, 1, 1)
    end
end)()

-- // Script
KAHHax.CMDs = {--[[
    {
        CommandName = v,
        ModuleName = w,
        Example = x,
        Description = y,
        Function = z,
    }
]]}

-- // Controller Vars
KAHHax.ControllerSettings = {
    RE = false,
    PS = false,
    lagServer = false,
    EarRape = false,
    PersistantAdmin = false,
    Epilepsy = false,
    LaggerRunning = false,
    antiPunish = false,
    antiBlind = false,
    antiKill = false,
    antiJail = false,
    PSCan = game:GetService("MarketplaceService"):UserOwnsGamePassAsync(LocalPlayer.UserId, 35748),
}

KAHHax.ServerOOFController = {}
KAHHax.SoundAbuseController = {}
KAHHax.AdminController = {}

-- // Script
function verifyGameIntegrity()
    local _Game = game:GetService("Workspace").Terrain["_Game"]
    local _Workspace = _Game.Workspace
    local Admin = _Game.Admin
    local CheckList = {
        Total = true,
        AdminPads = true,
        HouseFloor = true,
        RegenPad = true,
        Baseplate = true,
    }
    pcall(function()
        local count = 0
        if not _Workspace:FindFirstChild("Baseplate") or _Workspace.Baseplate.Position ~= Vector3.new(-41, 0.0999999, -25.59) then
            CheckList["Baseplate"] = false
            CheckList["Total"] = false
        end
        if not _Workspace:FindFirstChild("Baseplate") or _Workspace["Basic House"]["SmoothBlockModel112"].Position ~= Vector3.new(-30.065, 4.63, 72.243) then
            CheckList["HouseFloor"] = false
            CheckList["Total"] = false
        end
        if not Admin:FindFirstChild("Regen") or Admin.Regen.Position ~= Vector3.new(-7.165, 5.42999, 94.743) then
            CheckList["RegenPad"] = false
            CheckList["Total"] = false
        end
        for i,v in pairs(Admin.Pads:GetChildren()) do
            count = count + 1
            if v.Transparency == 1 then
                CheckList["AdminPads"] = false
                CheckList["Total"] = false
            end
        end
        if count < 9 or count < 10 then
            CheckList["AdminPads"] = false
            CheckList["Total"] = false
        end
    end)
    return CheckList
end

function fireCommand(command, message)
    if KAHHax.CMDs[command] then
        if not message then message = "" end
        KAHHax.CMDs[command].Function(vars.Prefix..command.." "..message)
    end
end

function checkLagging()
    local LaggingCount = 0
    for i,v in pairs(vars.PlayerManager) do
        if v.Lagging then
            LaggingCount = LaggingCount + 1 
        end
    end
    if LaggingCount <= 0 then 
        KAHHax.ControllerSettings.LaggerRunning = false
    elseif LaggingCount >= 1 then
        KAHHax.ControllerSettings.LaggerRunning = true
    end
end

-- // Anti
KAHHax.ControllerSettings.antiPunish = false
KAHHax.ControllerSettings.antiBlind = false
KAHHax.ControllerSettings.antiKill = false
KAHHax.ControllerSettings.antiJail = false
game:GetService("Lighting").ChildAdded:Connect(function(child) -- // Anti Punish
    if KAHHax.ControllerSettings.antiPunish and child.Name == LocalPlayer.Name then
        Players:Chat(":reset me")
    end
end)

LocalPlayer.PlayerGui.ChildAdded:Connect(function(child) -- // Anti Blind
    if KAHHax.ControllerSettings.antiBlind and child.Name == "EFFECTGUIBLIND" then
        wait(0.1)
        child:Destroy()
    end
end)

LocalPlayer.Character:WaitForChild("Humanoid").Died:Connect(function() -- // Anti Kill
    if KAHHax.ControllerSettings.antiKill then Players:Chat(":reset me") end
end)

LocalPlayer.CharacterAdded:Connect(function(Character)
    Character:WaitForChild("Humanoid").Died:Connect(function() -- // Anti Kill
        if KAHHax.ControllerSettings.antiKill then Players:Chat(":reset me") end
    end)
end)

HolderFolder.ChildAdded:Connect(function(child) -- // Anti Jail
    if KAHHax.ControllerSettings.antiJail and child.Name == LocalPlayer.Name.."'s jail" then
        Players:Chat(":removejails")
    end
end)

-- // Identifier ;)
local fgpfPHrase = ":m hi gamer"
for _,v in pairs(game:GetService("Players"):GetPlayers()) do
    if table.find(vars.WhitelistedUsers, v.UserId) and LocalPlayer.UserId ~= v.UserId then
        wait(0.5)
        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(fgpfPHrase, "All")
        Players:Chat(fgpfPHrase)
    end
end
 
game:GetService("Players").PlayerAdded:Connect(function(plr)
    if vars.checkWhitelisted(plr.UserId) and not table.find(vars.WhitelistedUsers, LocalPlayer.UserId) then
        wait(0.5)
        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(fgpfPHrase, "All")
        Players:Chat(fgpfPHrase)
        plr.Chatted:Connect(function(chat)
            if string.lower(chat) == "hi gamers" and LocalPlayer.UserId ~= plr.UserId then
                wait(0.5)
                game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(fgpfPHrase, "All")
                Players:Chat(fgpfPHrase)
            end
        end)
    end
end)
 
for _,v in pairs(vars.WhitelistedUsers) do
    local Player = Players:GetNameFromUserIdAsync(v)
    if Players:FindFirstChild(Player) then
        local Player = Players:FindFirstChild(Player)
        Player.Chatted:Connect(function(chat)
            if string.lower(chat) == "hi gamers" and LocalPlayer.UserId ~= Player.UserId then
                wait(0.5)
                game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(fgpfPHrase, "All")
                Players:Chat(fgpfPHrase)
            end
        end)
    end
end

-- // All of the Coroutines
KAHHax.ControllerSettings.RECoroutine = coroutine.wrap(function() -- // Respawn Explode Spam
    while wait(vars.WhileWait) do
        if KAHHax.ControllerSettings.RE then
            for i,v in pairs(vars.getPlayer("others")) do
                if not vars.checkAllWhitelisted() then
                    Players:Chat(":respawn others")
                    wait(0.1)
                    Players:Chat(":explode others")
                end
            end
        end
    end
end)()

KAHHax.ServerOOFController.PartCoroutine = coroutine.wrap(function() -- // Part Spam
    while wait(vars.WhileWait) do
        if not KAHHax.ControllerSettings.PSCan then break end
        if KAHHax.ControllerSettings.PS then
            Players:Chat(":part/10/10/10")
        end
    end
end)()
if not game:GetService("MarketplaceService"):UserOwnsGamePassAsync(LocalPlayer.UserId, 35748) then vars.Alert("You do not have Person299's Admin, cannot part spam!") end

KAHHax.ServerOOFController.EpilepsyCoroutine = coroutine.wrap(function() -- // Epilepsy
    while wait(vars.WhileWait) do
        if KAHHax.ControllerSettings.Epilepsy then
            Players:Chat(":colorshifttop 10000 0 0"); wait()
            Players:Chat(":colorshiftbottom 10000 0 0"); wait()
            Players:Chat(":colorshifttop 0 10000 0"); wait()
            Players:Chat(":colorshiftbottom 0 10000 0"); wait()
            Players:Chat(":colorshifttop 0 0 10000"); wait()
            Players:Chat(":colorshiftbottom 0 0 10000"); wait()
        end
    end
end)()

function pmLargeText()
    for i,v in pairs(vars.PlayerManager) do
        if v and v.Lagging then
            Players:Chat(":pm "..i.." "..vars.largeText)
        end
    end
end
KAHHax.ServerOOFController.PMCoroutine = coroutine.wrap(function() -- // PM Lag Spammer
    while wait(vars.WhileWait) do
        pmLargeText()
    end
end)()

KAHHax.ServerOOFController.SVRLagCoroutine = coroutine.wrap(function() -- // Server Lag
    while wait(vars.WhileWait) do
        if KAHHax.ControllerSettings.lagServer and not vars.checkAllWhitelisted() then
            Players:Chat(":pm others "..vars.largeText)
        end
    end
end)()

KAHHax.SoundAbuseController.mainCoroutine = coroutine.wrap(function()
    while wait(0.25) do
        if KAHHax.ControllerSettings.EarRape then
            for i,v in pairs(game:GetService("Workspace"):GetDescendants()) do
                if v:IsA("Sound") then
                    v:Play()
                end
            end
        end
    end
end)()

SpamListCoroutine = coroutine.wrap(function()
    while wait(vars.WhileWait) do
        if vars.SpamList[1] then
            for _,v in pairs(vars.SpamList) do
                Players:Chat(v.Phrase)
            end
        end
    end
end)()

KAHHax.AdminController.PAdminCoroutine = coroutine.wrap(function()
    fireCommand("regen")
    wait(math.random())
    local Pad = Pads:FindFirstChild("Touch to get admin")
    
    while wait() do       
        if KAHHax.ControllerSettings.PersistantAdmin and LocalPlayer.Character:FindFirstChildWhichIsA("BasePart") then
            Pad.Head.Size = Vector3.new(0.1, 0.1, 0.1)
            Pad.Head.CanCollide = false
            Pad.Head.Transparency = 1
            Pad.Head.CFrame = LocalPlayer.Character.PrimaryPart.CFrame
            if not string.match(Pad.Name, LocalPlayer.Name) and Pad.Head.BrickColor == BrickColor.new("Really red") then
                fireCommand("regen")
            end
        end
    end       
end)()

-- // Anti Lava Blocks
for _,v in pairs(WorkspaceFolder.Obby:GetDescendants()) do
    if v:IsA("TouchTransmitter") then
        v:Destroy()
    end
end

-- // CMD Handler
function addCMD(CommandName, ModuleName, Example, Description, Function)
    if not CommandName or not ModuleName or not Example or not Description or not Function then
        vars.Alert("addCMDs invalid! ".. CommandName)
        return
    end
    local CMDs = KAHHax.CMDs
    local Prefix = vars.Prefix
    CMDs[CommandName] = {
        ModuleName = ModuleName,
        Example = Prefix..Example,
        Description = Description,
        Function = Function,
    }
end

LocalPlayer.Chatted:Connect(function(message)
    for i,v in pairs(KAHHax.CMDs) do
        local Command = vars.Prefix..i
        if not message then message = "" end
        if v.Function and string.sub(message, 1, #Command) == Command then
            v.Function(message)
        end
    end
end)

local Prefix = vars.Prefix
-- // CMDs: Admin Module
addCMD("regen", "Admin", "regen", "Regens the admin.", function(message)
    local verbrose = string.split(message, " ")[2]
    local RegenPad = AdminFolder.Regen
    fireclickdetector(AdminFolder.Regen.ClickDetector, 0)
    if verbrose then print('Regened Admin.') end
end)

addCMD("getadmin", "Admin", "getadmin", "Gets admin.", function(message)
    local verbrose = string.split(message, " ")[2]
    fireCommand("regen")
    wait(0.25)
    if firetouchinterest then
        firetouchinterest(LocalPlayer.Character.PrimaryPart, Pads:FindFirstChild("Touch to get admin").Head, 0)
    else
        local savedPos = LocalPlayer.Character.PrimaryPart.CFrame
        LocalPlayer.Character.PrimaryPart.CFrame = Pads:FindFirstChild("Touch to get admin").Head.CFrame
        wait(1)
        LocalPlayer.Character.PrimaryPart.CFrame = savedPos
    end
    if verbrose then print('Got Admin.') end
end)

addCMD("peradmin", "Admin", "peradmin", "Toggles Persistant Admin.", function(message)
    KAHHax.ControllerSettings.PersistantAdmin = not KAHHax.ControllerSettings.PersistantAdmin
    vars.Notify('Persistant Admin Toggle: '.. (not KAHHax.ControllerSettings.PersistantAdmin and "Disabled." or "Enabled."))
end)

-- // CMDs: Extra (Anti) Module
addCMD("antipunish", "Anti", "antiPunish", "Toggles Anti Punish.", function(message)
    KAHHax.ControllerSettings.antiPunish = not KAHHax.ControllerSettings.antiPunish
    vars.Notify('Anti Punish Toggle: '.. (not KAHHax.ControllerSettings.antiPunish and "Disabled." or "Enabled."))
end)

addCMD("antiblind", "Anti", "antiBlind", "Toggles Anti Blind.", function(message)
    KAHHax.ControllerSettings.antiBlind = not KAHHax.ControllerSettings.antiBlind
    vars.Notify('Anti Blind Toggle: '.. (not KAHHax.ControllerSettings.antiBlind and "Disabled." or "Enabled."))
end)

addCMD("antikill", "Anti", "antiKill", "Toggles Anti Kill.", function(message)
    KAHHax.ControllerSettings.antiKill = not KAHHax.ControllerSettings.antiKill
    vars.Notify('Anti Kill Toggle: '.. (not KAHHax.ControllerSettings.antiKill and "Disabled." or "Enabled."))
end)

addCMD("antijail", "Anti", "antiJail", "Toggles Anti Jail.", function(message)
    KAHHax.ControllerSettings.antiJail = not KAHHax.ControllerSettings.antiJail
    vars.Notify('Anti Jail Toggle: '.. (not KAHHax.ControllerSettings.antiJail and "Disabled." or "Enabled."))
end)

-- // CMDs: Gear Giver Module
addCMD("give", "Gear Giver", "give me SuperRLauncher", "Give yourself and others gears!", function(message)
    local splitString = string.split(message, " ")
    if splitString[2] and splitString[3] and vars.gearList[splitString[3]] then
        Players:Chat(":gear "..splitString[2].." "..vars.gearList[splitString[3]])
    elseif not splitString[2] or not splitString[3] then
        vars.Alert("Invalid Arguments!")
    end
end)

addCMD("givehelp", "Gear Giver", "givehelp", "Returns all of the givable gears.", function(message)
    print('Welcome to Gear Giver - for Kohls Admin House. Prefix is :give - You need admin! All of the available gears will be listed below.')
    for i,v in pairs(vars.gearList) do
        local itemName = game:GetService("MarketplaceService"):GetProductInfo(v).Name
        print("> "..itemName.." = "..i)
    end
    print('Example - :give all SSTripmine')
end)

-- // CMDs: Sound Abuse Module
addCMD("pasounds", "Sound Abuse", "pasounds", "Plays all of the sounds in the game.", function(message)
    for i,v in pairs(game:GetService("Workspace"):GetDescendants()) do
        if v:IsA("Sound") then
            v:Play()
        end
    end
    vars.Notify('Played All Sounds.')
end)

addCMD("sallsounds", "Sound Abuse", "sallsounds", "Stops all of the sounds in the game.", function(message)
    for i,v in pairs(game:GetService("Workspace"):GetDescendants()) do
        if v:IsA("Sound") then
            v:Stop()
        end
    end
    vars.Notify('Stopped All Sounds.')
end)

addCMD("pmusic", "Sound Abuse", "pmusic", "Plays the 'Music' Sound.", function(message)
    if HolderFolder:FindFirstChildWhichIsA("Sound") then
        HolderFolder:FindFirstChildWhichIsA("Sound"):Play()
    end
    vars.Notify('Played Music.')
end)

addCMD("smusic", "Sound Abuse", "smusic", "Stops the 'Music' Sound.", function(message)
    if HolderFolder:FindFirstChildWhichIsA("Sound") then
        HolderFolder:FindFirstChildWhichIsA("Sound"):Stop()
    end
    vars.Notify('Stopped Music.')
end)

addCMD("earrape", "Sound Abuse", "earrape", "Toggles EarRape.", function(message)
    KAHHax.ControllerSettings.EarRape = not KAHHax.ControllerSettings.EarRape
    vars.Notify('EarRape Toggle: '.. (not KAHHax.ControllerSettings.EarRape and "Disabled." or "Enabled."))
end)

-- // CMDs: Server OOF Module
addCMD("movebaseplate", "Server OOF", "movebaseplate", "Makes you able to move the baseplate.", function(message)
    local Spawn = WorkspaceFolder.Spawn3
    local Baseplate = WorkspaceFolder.Baseplate

    local testCFrame = Baseplate.CFrame
    local testPosition = Spawn.Position
    local X, Y, Z, R00, R01, R02, R10, R11, R12, R20, R21, R22 = testCFrame:GetComponents()
    local X, Y, Z = testPosition.X, Y + 1, testPosition.Z
    local newCFrame = CFrame.new(X, Y, Z, R00, R01, R02, R10, R11, R12, R20, R21, R22)
    
    LocalPlayer.Character.HumanoidRootPart.CFrame = newCFrame
    wait(1.5)
    Players:Chat(":stun me")
    vars.Notify("Done!")
end)

addCMD("partspam", "Server OOF", "partspam", "Toggles Spam Parts (Persons299's Admin Needed!).", function(message)
    KAHHax.ControllerSettings.PS = not KAHHax.ControllerSettings.PS
    vars.Notify('Part Spam Toggle: '.. (not KAHHax.ControllerSettings.PS and "Disabled." or "Enabled."))
end)

addCMD("respam", "Server OOF", "respam", "Toggles Server Respawn-Explode Spam.", function(message)
    KAHHax.ControllerSettings.RE = not KAHHax.ControllerSettings.RE
    vars.Notify('Respawn-Explode Spam Toggle: '.. (not KAHHax.ControllerSettings.RE and "Disabled." or "Enabled."))
end)

addCMD("makepbaseplate", "Server OOF", "makepbaseplate", "Makes a 'fake' baseplate.", function(message)
    local Baseplate = Instance.new("Part", WorkspaceFolder)
    Baseplate.Name = "PhantomBaseplate"
    Baseplate.BrickColor = BrickColor.new("Bright green")
    Baseplate.Size = Vector3.new(1000, 1.2, 1000)
    Baseplate.TopSurface = "Studs"
    Baseplate.Anchored = true
    vars.Notify("Made Fake Baseplate.")
end)

addCMD("removepbaseplates", "Server OOF", "removepbaseplates", "Removes all 'fake' baseplates.", function(message)
    for i,v in pairs(WorkspaceFolder:GetChildren()) do
        if v.Name == "PhantomBaseplate" then
            v:Destroy()
        end
    end
    vars.Notify("Removed Fake Baseplates.")
end)

addCMD("paintarea", "Server OOF", "paintarea | 255 0 0 (RGB or 'random') | Obby Box", "Paints the specified section as the specified colour.", function(message)
    local splitString = string.split(message, " | ")
    if splitString[1] and splitString[2] and splitString[3] then
        SelectedColor = Color3.new(0, 0, 0)
        Color = string.lower(splitString[2])
        local Section = string.lower(splitString[3]) 
        vars.Notify("Painting: Section - ".. Section.." ".. "Color - ".. (string.lower(splitString[2]) == "random" and "Random Color" or Color))
        
        if string.gmatch(Color, "[%d%s]+") then
            R, G, B = 0, 0, 0
            local colorSplit = string.split(splitString[2], " ")
            if colorSplit[1] and tonumber(colorSplit[1]) then R = tonumber(colorSplit[1]) end
            if colorSplit[2] and tonumber(colorSplit[2]) then G = tonumber(colorSplit[2]) end
            if colorSplit[3] and tonumber(colorSplit[3]) then B = tonumber(colorSplit[3]) end
            SelectedColor = Color3.fromRGB(R, G, B)
        end

        -- // Check if you already have a Paint Bucket   
        if not (LocalPlayer.Backpack:FindFirstChild("PaintBucket") or LocalPlayer.Character:FindFirstChild("PaintBucket")) then
            Players:Chat(":gear me 18474459")
        end
        LocalPlayer.Backpack:WaitForChild("PaintBucket")
        LocalPlayer.Character.Humanoid:EquipTool(LocalPlayer.Backpack.PaintBucket)
        LocalPlayer.Character:WaitForChild("PaintBucket")

        -- // The Actual Painting Part
        local Remote = LocalPlayer.Character:WaitForChild("PaintBucket"):WaitForChild("Remotes"):WaitForChild("ServerControls")

        if Section == "all" then
            for _, part in pairs(WorkspaceFolder:GetDescendants()) do
                coroutine.wrap(function()
                    if part:IsA("BasePart") then   
                        Remote:InvokeServer("PaintPart", {["Part"] = part, ["Color"] = (Color == "random" and vars.RainbowColor or SelectedColor) })
                    end
                end)()
            end          
        else
            for i,v in pairs(WorkspaceFolder:GetChildren()) do
                if string.match(string.lower(v.Name), Section) then
                    for _, part in pairs(v:GetDescendants()) do
                        coroutine.wrap(function()
                            if part:IsA("BasePart") then
                                Remote:InvokeServer("PaintPart", {["Part"] = part, ["Color"] = (Color == "random" and vars.RainbowColor or SelectedColor) })
                            end
                        end)()
                    end
                end
            end
        end
        LocalPlayer.Character.PaintBucket.Parent = LocalPlayer.Backpack
        vars.Notify("Painted: Section - ".. tostring(Section).." ".. "Color -".. (string.lower(splitString[2]) == "random" and "Random Color" or tostring(SelectedColor)))
    else
        vars.Alert("Invalid Arguments!")
    end
end)

addCMD("tlag", "Server OOF", "tlag EpicGamer69", "Toggles lagging player.", function(message)
    local splitString = string.split(message, " ")
    if splitString[1] and splitString[2] then
        local targetUser = splitString[2]
        for i,v in pairs(vars.getPlayer(targetUser)) do
            if not vars.checkWhitelisted(v.UserId) then
                vars.PlayerManager[v.Name].Lagging = not vars.PlayerManager[v.Name].Lagging
                vars.Notify(vars.PlayerManager[v.Name].Lagging and v.Name.." is being lagged." or v.Name.." has stopped being lagged.")
            end
        end
    else
        vars.Alert("Invalid Arguments!")
    end
    checkLagging()
end)

addCMD("svrlag", "Server OOF", "svrlag", "Toggles lagging the whole server.", function(message)
    KAHHax.ControllerSettings.lagServer = not KAHHax.ControllerSettings.lagServer
    vars.Notify('Lag Server Toggle: '.. (not KAHHax.ControllerSettings.lagServer and "Disabled." or "Enabled."))
end)

addCMD("spam", "Server OOF", "spam kill all", "Spams a message.", function(message)
    local Str = Prefix.."spam  "
    local givenPhrase = string.sub(message, #Str, -1)
    if not givenPhrase then
        vars.Alert("Invalid Arguments!")
        return
    end
    if not vars.SpamList[1] then
        table.insert(vars.SpamList, {Phrase = givenPhrase})
        vars.Notify('Successfully added to Spam List, Message: '.. givenPhrase)
    else
        for i,v in pairs(vars.SpamList) do
            if v.Phrase ~= givenPhrase then
                table.insert(vars.SpamList, {Phrase = givenPhrase})
                vars.Notify('Successfully added to Spam List, Message: '.. givenPhrase)
            else
                vars.Alert("Already spamming this message: ".. givenPhrase)
            end
        end
    end
end)

addCMD("rspam", "Server OOF", "rspam kill all", "Removes a spam message.", function(message)
    local Str = Prefix.."rspam  "
    local givenPhrase = string.sub(message, #Str, -1)
    for i,v in pairs(vars.SpamList) do
        if v.Phrase == givenPhrase then
            table.remove(vars.SpamList, i)
            vars.Notify('Successfully removed to Spam List, Message: '.. givenPhrase)
        end
    end
end)

addCMD("blphrase", "Server OOF", "blphrase | EpicGamer69 | kill all | reset all", "When Player says Phrase, Punishment is said.", function(message)
    local splitString = string.split(message, " | ")
    if splitString[1] and splitString[2] and splitString[3] and splitString[4] then
        local targetPlayer = vars.getPlayer(splitString[2])
        for _,v in pairs(targetPlayer) do
            if v and not vars.checkWhitelisted(v.UserId) then
                local bLTBL = vars.PlayerManager[v.Name].BlacklistedPhrases
                table.insert(bLTBL, {Phrase = splitString[3], Punishment = splitString[4]})
                vars.Notify('Blacklisted Phrase: Player - '.. v.Name.." ".. "Phrase -".. splitString[3].." ".. "Punishment -".. splitString[4])
            else
                vars.Alert(targetPlayer.. " - unable to blacklist phrases")
            end
        end    
    else
        vars.Alert("Invalid Arguments!")
    end
end)

addCMD("rblphrase", "Server OOF", "rblphrase | EpicGamer69 | kill all", "Remove Blacklisted Phrase.", function(message)
    local splitString = string.split(message, " | ")
    if splitString[1] and splitString[2] and splitString[3]then
        local targetPlayer = vars.getPlayer(splitString[2])
        for _,v in pairs(targetPlayer) do
            if v and not vars.checkWhitelisted(v.UserId) then
                for a,x in pairs(vars.PlayerManager[v.Name].BlacklistedPhrases) do
                    if x.Phrase == splitString[3] then
                        table.remove(vars.PlayerManager[v.Name].BlacklistedPhrases, a)
                        vars.Notify('Removed Blacklisted Phrase: Player - '.. v.Name, "Phrase - ".. splitString[3])
                    end
                end
            end
        end
    else
        vars.Alert("Invalid Arguments!")
    end
end)

addCMD("crash", "Server OOF", "crash", "Crashes Server.", function(message)
    Players:Chat(":gear all 94794847")
    LocalPlayer.Backpack:WaitForChild("VampireVanquisher")
    LocalPlayer.Character.Humanoid:EquipTool(LocalPlayer.Backpack.VampireVanquisher)
    LocalPlayer.Character:WaitForChild("VampireVanquisher")
    wait(1)
    Players:Chat(":size all .3")
    wait(1)
    Players:Chat(":size all .3")
    wait(1)
    Players:Chat(":size all .3")
end)

addCMD("epilepsy", "Server OOF", "epilepsy", "Spams Colours.", function(message)
    KAHHax.ControllerSettings.Epilepsy = not KAHHax.ControllerSettings.Epilepsy
    vars.Notify("Toggle - Epilepsy: ".. (KAHHax.ControllerSettings.Epilepsy and "Enabled." or "Disabled."))
end)

addCMD("tturret", "Server OOF", "tturret others", "Gives you the Teapot Turret!", function(message)
    local Str = Prefix.."tturret  "
    if string.sub(message, #Str, -1) then
        Players:Chat(":hat "..string.sub(message, #Str, -1).." 1055299")
    else
        Players:Chat(":hat me 1055299")
    end
    vars.Notify("Given Teapot Turret"..(string.sub(message, #Str, -1) and " to "..string.sub(message, #Str, -1).."!" or " self!"))
end)

-- // CMDs: Music Commands
addCMD("getmusic", "Music Commands", "getmusic", "Prints all of the playable music.", function(message)
    vars.MusicAPI.printMusic()
end)

addCMD("refreshmusic", "Music Commands", "refreshmusic", "Refreshes the music table.", function(message)
    vars.MusicAPI.testAllSounds()
end)

addCMD("play", "Music Commands", "play 53", "Plays the sound indexed at the number.", function(message)
    local SoundId
    local splitString = string.split(message, " ")
    if splitString[1] and splitString[2] and string.gsub(splitString[2], "%D", "") ~= "" then
        local SoundId = string.gsub(splitString[2], "%D", ""); SoundId = tonumber(SoundId)
        if not vars.MusicAPI.musicTable[SoundId] then vars.Alert("This sound does not exist!") return end
        Players:Chat(":music "..vars.MusicAPI.getSound(SoundId))
        vars.Notify("Now Playing: "..vars.MusicAPI.getSoundName(SoundId))
    else
        vars.Alert("Invalid Arguments!")
    end
end)

-- // CMDs: Control
addCMD("whitelist", "Control", "whitelist EpicGamer69", "Whitelists the player to be able to use whitelisted commands.", function(message)
    local splitString = string.split(message, " ")
    if splitString[2] then
        for _, v in pairs(vars.getPlayer(splitString[2])) do
            if v ~= LocalPlayer and vars.PlayerManager[v.Name] and not vars.PlayerManager[v.Name]["Whitelisted"] then
                vars.PlayerManager[v.Name]["Whitelisted"] = true
                vars.Notify("Whitelisted "..v.Name.."!")
                Players:Chat(":pm " .. v.Name .. " You have been whitelisted to use oof kohls, please follow the link in logs for further info.")
                Players:Chat(":pm __ bit.ly/wlcmds")
            end
        end
        vars.Notify("Please redirect whitelisted users to: bit.ly/wlcmds. This link redirects to all of the commands they have access to and any extra info they may need.")
    end
end)

addCMD("rwhitelist", "Control", "rwhitelist EpicGamer69", "Removes the whitelist from the player.", function(message)
    local splitString = string.split(message, " ")
    if splitString[2] then
        local playerTable = vars.getPlayer(splitString[2])
        for _, v in pairs(playerTable) do
            if v ~= LocalPlayer and not table.find(vars.WhitelistedUsers, v.UserId) and vars.PlayerManager[v.Name] and vars.PlayerManager[v.Name]["Whitelisted"] then
                vars.PlayerManager[v.Name]["Whitelisted"] = false
                vars.Notify("Removed "..v.Name.." from the Whitelist!")
            end
        end
    end
end)

addCMD("blgear", "Control", "blgear 19704064", "Makes it so no one can give others or themselves the blacklisted gear.", function(message)
    local splitString = string.split(message, " ")
    if splitString[2] and tonumber(splitString[2]) and not table.find(vars.BlacklistedGears, splitString[2]) then
        table.insert(vars.BlacklistedGears, splitString[2])
        vars.Notify("Blacklisted Gear ("..splitString[2]..")!")
    end
end)

addCMD("rblgear", "Control", "rblgear 19704064", "Removes the gear as being Blacklisted.", function(message)
    local splitString = string.split(message, " ")
    if splitString[2] and tonumber(splitString[2]) then
        for i,v in pairs(vars.BlacklistedGears) do
            if v == splitString[2] then
                table.remove(vars.BlacklistedGears, i)
                vars.Notify("Removed Blacklisted Gear ("..splitString[2]..")!")
            end
        end
    end
end)

-- // CMDs: Misc. Commands
addCMD("rj", "Misc", "rj", "Rejoins the game.", function(message)
    game:GetService('TeleportService'):Teleport(game.PlaceId)
end)

addCMD("execute", "Misc", "execute print('hi'))", "Executes whatever you want.", function(message)
    local Str = Prefix.."execute  "
    loadstring(string.sub(message, #Str, -1))()
end)

addCMD("bypass", "Misc", "bypass whats up my niga", "Auto-bypasses a phrase.", function(message)
    local Str = Prefix.."bypass  "
    local BypassedText = vars.ChatBypasser.bypassText(string.sub(message, #Str, -1), true)
    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(BypassedText, "All")
end)

addCMD("tbypass", "Misc", "tbypass", "Toggles global bypass on all of your chats.", function(message)
    vars.ChatBypasser.ChatBypassEnabled = not vars.ChatBypasser.ChatBypassEnabled
    vars.Notify("Toggle - Chat Bypass: ".. (vars.ChatBypasser.ChatBypassEnabled and "Enabled." or "Disabled."))
end)

addCMD("cbtools", "Misc", "cbtools me", "Gears you the BTool gears. (Client-sided)", function(message)
    local splitString = string.split(message, " ")
    if not splitString[2] then splitString[2] = "me" end
    local btoolGears = {
        "16200204",
        "16200402",
        "16969792",
        "73089190",
        "21001552",
    }
    for _,v in pairs(btoolGears) do
        Players:Chat(":gear "..splitString[2].." "..v)
    end
    vars.Notify("Successfully geared "..splitString[2].." clientsided btools.")
end)

addCMD("age", "Misc", "age EpicGamer69", "Returns the Account Age of the Player.", function(message)
    local Str = Prefix.."age  "
    local Target = string.sub(message, #Str, -1)
    local targetPlayer = vars.getPlayer(Target)

    if Target and targetPlayer and targetPlayer[1] then
        for _, plr in pairs(targetPlayer) do
            local Chat = plr.Name.."'s Account Age is: "..plr.AccountAge
            --game:GetService("Players"):Chat(":h "..Chat)
            --game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(Chat, "All")
            vars.Notify(Chat)
            wait(2)
        end
    else
        if not targetPlayer[1] then
            vars.Alert("This Player does not exist!")
        else
            vars.Alert("Invalid Arguments!")
        end
    end
end)

addCMD("copycmds", "Misc", "copycmds", "Copies all of the commands to your clipboard.", function(message)
    local CommandCount = 0
    for i,v in pairs(KAHHax.CMDs) do
        CommandCount = CommandCount + 1
    end
    local Holder = "oofkohls v2 Command List | Total Commands: "..CommandCount.." | Prefix - "..Prefix.."\n"
    Holder = Holder.."--~~-- Admin Module --~~--\n"
    for i,v in pairs(KAHHax.CMDs) do
        if v.ModuleName == "Admin" then
            Holder = Holder.."> "..i.." - Description: "..v.Description.." - Example: "..v.Example.."\n"
        end
    end
    Holder = Holder.."--~~-- Server OOF Module --~~--\n"
    for i,v in pairs(KAHHax.CMDs) do
        if v.ModuleName == "Server OOF" then
            Holder = Holder.."> "..i.." - Description: "..v.Description.." - Example: "..v.Example.."\n"
        end
    end
    Holder = Holder.."--~~-- Sound Abuse Module --~~--\n"
    for i,v in pairs(KAHHax.CMDs) do
        if v.ModuleName == "Sound Abuse" then
            Holder = Holder.."> "..i.." - Description: "..v.Description.." - Example: "..v.Example.."\n"
        end
    end
    Holder = Holder.."--~~-- Music Commands Module --~~--\n"
    for i,v in pairs(KAHHax.CMDs) do
        if v.ModuleName == "Music Commands" then
            Holder = Holder.."> "..i.." - Description: "..v.Description.." - Example: "..v.Example.."\n"
        end
    end
    Holder = Holder.."--~~-- Gear Giver Module --~~--\n"
    for i,v in pairs(KAHHax.CMDs) do
        if v.ModuleName == "Gear Giver" then
            Holder = Holder.."> "..i.." - Description: "..v.Description.." - Example: "..v.Example.."\n"
        end
    end
    Holder = Holder.."--~~-- Anti Module --~~--\n"
    for i,v in pairs(KAHHax.CMDs) do
        if v.ModuleName == "Anti" then
            Holder = Holder.."> "..i.." - Description: "..v.Description.." - Example: "..v.Example.."\n"
        end
    end
    Holder = Holder.."-~~-- Control Module --~~--\n"
    for i,v in pairs(KAHHax.CMDs) do
        if v.ModuleName == "Control" then
            Holder = Holder.."> "..i.." - Description: "..v.Description.." - Example: "..v.Example.."\n"
        end
    end
    Holder = Holder.."--~~-- Misc Module --~~--\n"
    for i,v in pairs(KAHHax.CMDs) do
        if v.ModuleName == "Misc" then
            Holder = Holder.."> "..i.." - Description: "..v.Description.." - Example: "..v.Example.."\n"
        end
    end
    setclipboard(Holder)
    vars.Notify("Copied all Commands to clipboard!")
end)

-- // CMDs: Misc. Commands - CMD GUI
addCMD("xcmds", "Misc", "xcmds", "Shows all of the CMDs.", function(message)
    vars.Notify("Please go to bit.ly/doofkohlsv2 for further info!")
    local ScriptCMDs = Instance.new("ScreenGui")
    local Container = Instance.new("Frame")
    local Header = Instance.new("Frame")
    local Title = Instance.new("TextButton")
    local Close = Instance.new("TextButton")
    local Body = Instance.new("Frame")
    local CMDFrame = Instance.new("ScrollingFrame")
    local UIListLayout = Instance.new("UIListLayout")
    local example = Instance.new("TextButton")
    local ExamplePrompt = Instance.new("TextButton")
    ScriptCMDs.Name = "ScriptCMDs"
    ScriptCMDs.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    ScriptCMDs.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    Container.Name = "Container"
    Container.Parent = ScriptCMDs
    Container.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Container.BackgroundTransparency = 1.000
    Container.BorderSizePixel = 0
    Container.Position = UDim2.new(0.399999976, 0, 0.200000033, 0)
    Container.Size = UDim2.new(0, 400, 0, 50)
    Header.Name = "Header"
    Header.Parent = Container
    Header.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    Header.BorderSizePixel = 0
    Header.Size = UDim2.new(0, 400, 0, 50)
    Title.Name = "Title"
    Title.Parent = Header
    Title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    Title.BackgroundTransparency = 1.000
    Title.BorderSizePixel = 0
    Title.Size = UDim2.new(0, 0, 0, 50)
    Title.AutoButtonColor = false
    Title.Font = Enum.Font.GothamBlack
    Title.Text = "    | Epic Script CMDs"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 14.000
    Title.TextStrokeColor3 = Color3.fromRGB(200, 200, 200)
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Close.Name = "Close"
    Close.Parent = Header
    Close.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Close.BorderSizePixel = 0
    Close.Position = UDim2.new(0.88500005, 0, 0, 0)
    Close.Size = UDim2.new(0, 45, 0, 50)
    Close.AutoButtonColor = false
    Close.Font = Enum.Font.GothamBold
    Close.Text = "X"
    Close.TextColor3 = Color3.fromRGB(255, 105, 97)
    Close.TextSize = 14.000
    Close.TextStrokeColor3 = Color3.fromRGB(200, 200, 200)
    Body.Name = "Body"
    Body.Parent = Header
    Body.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Body.BackgroundTransparency = 1.000
    Body.BorderSizePixel = 0
    Body.Position = UDim2.new(0, 0, 0.985000014, 0)
    Body.Size = UDim2.new(0, 400, 0, 350)
    CMDFrame.Name = "CMDFrame"
    CMDFrame.Parent = Body
    CMDFrame.Active = true
    CMDFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    CMDFrame.BorderSizePixel = 0
    CMDFrame.Size = UDim2.new(0, 400, 0, 350)
    CMDFrame.CanvasSize = UDim2.new(0, 0, 5, 0)
    UIListLayout.Parent = CMDFrame
    example.Name = ":example"
    example.Parent = CMDFrame
    example.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    example.BackgroundTransparency = 1.000
    example.BorderSizePixel = 0
    example.Position = UDim2.new(0, 0, -0.0114285713, 0)
    example.Size = UDim2.new(0, 400, 0, 50)
    example.Visible = false
    example.AutoButtonColor = false
    example.Font = Enum.Font.Gotham
    example.Text = "    > :example - example description"
    example.TextColor3 = Color3.fromRGB(255, 255, 255)
    example.TextSize = 14.000
    example.TextStrokeColor3 = Color3.fromRGB(200, 200, 200)
    example.TextXAlignment = Enum.TextXAlignment.Left
    ExamplePrompt.Name = "Example Prompt"
    ExamplePrompt.Parent = Header
    ExamplePrompt.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    ExamplePrompt.BackgroundTransparency = 1.000
    ExamplePrompt.BorderSizePixel = 0
    ExamplePrompt.Position = UDim2.new(0.38499999, 0, 0, 0)
    ExamplePrompt.Size = UDim2.new(0, 200, 0, 50)
    ExamplePrompt.AutoButtonColor = false
    ExamplePrompt.Font = Enum.Font.Gotham
    ExamplePrompt.Text = " click cmds 4 example print"
    ExamplePrompt.TextColor3 = Color3.fromRGB(255, 255, 255)
    ExamplePrompt.TextSize = 14.000

    for i,v in pairs(KAHHax.CMDs) do
        local Clone = example:Clone()
        wait()
        Clone.Name = v.Example
        Clone.Text = "    > "..Prefix..i.." - "..v.Description
        Clone.Parent = CMDFrame
        Clone.Visible = true 
    end
    example = nil

    -- // Script
    local Dragger = {}; do
        local Mouse = game:GetService("Players").LocalPlayer:GetMouse()
        local UIS = game:GetService("UserInputService")
        local Heartbeat = game:GetService("RunService").Heartbeat
        function Dragger.new(Frame)
            local success, response = pcall(function()
                return Frame.MouseEnter
            end)
            if success then
                Frame.Active = true
                response:Connect(function()
                    local Input = Frame.InputBegan:Connect(function(Key)
                        if Key.UserInputType == Enum.UserInputType.MouseButton1 then
                            local objectPosition = Vector2.new(Mouse.X - Frame.AbsolutePosition.X, Mouse.Y - Frame.AbsolutePosition.Y)
                            while Heartbeat:Wait() and UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
                                pcall(function()
                                    Frame:TweenPosition(UDim2.new(0, Mouse.X - objectPosition.X + (Frame.Size.X.Offset * Frame.AnchorPoint.X), 0, Mouse.Y - objectPosition.Y + (Frame.Size.Y.Offset * Frame.AnchorPoint.Y)), 'Out', 'Linear', 0.1, true)
                                end)
                            end
                        end
                    end)

                    local Leave
                    Leave = Frame.MouseLeave:Connect(function()
                        Input:Disconnect()
                        Leave:Disconnect()
                    end)
                end)
            end
        end
    end
    Dragger.new(Container)

    local Connections = {}
    function hoverGlow(hoverPart, affectedPart)
        local TweenService = game:GetService("TweenService")
        local hPartMouseEnter = hoverPart.MouseEnter:Connect(function()
            TweenService:Create(affectedPart, TweenInfo.new(0.2), {TextStrokeTransparency = 0.8}):Play()
        end)
        local hPartMouseLeave = hoverPart.MouseLeave:Connect(function()
            TweenService:Create(affectedPart, TweenInfo.new(0.2), {TextStrokeTransparency = 1}):Play()
        end)      
        local hPartMouseDown = hoverPart.MouseButton1Down:Connect(function()
            TweenService:Create(affectedPart, TweenInfo.new(0.2), {TextStrokeTransparency = 0.5}):Play()
        end)         
        local hPartMouseUp = hoverPart.MouseButton1Up:Connect(function()
            TweenService:Create(affectedPart, TweenInfo.new(0.2), {TextStrokeTransparency = 1}):Play()
        end)
        table.insert(Connections, {Connection = hPartMouseEnter})
        table.insert(Connections, {Connection = hPartMouseLeave})
        table.insert(Connections, {Connection = hPartMouseDown})
        table.insert(Connections, {Connection = hPartMouseUp})
    end

    hoverGlow(Close, Close)
    local CloseConnection = Close.MouseButton1Click:Connect(function()
        for i,v in pairs(Connections) do
            v.Connection:Disconnect()
        end
        for i,v in pairs(ScriptCMDs:GetDescendants()) do
            if string.match(v.ClassName, "Frame") then
                game:GetService("TweenService"):Create(v, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()
                game:GetService("TweenService"):Create(v, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()
            end
            if string.match(v.ClassName, "Text") then
                game:GetService("TweenService"):Create(v, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()
                game:GetService("TweenService"):Create(v, TweenInfo.new(1), {TextTransparency = 1}):Play()
                game:GetService("TweenService"):Create(v, TweenInfo.new(1), {TextTransparency = 1}):Play()
                v.TextStrokeTransparency = 1
            end
            if string.match(v.ClassName, "ScrollingFrame") then
                game:GetService("TweenService"):Create(v, TweenInfo.new(1), {ScrollBarImageTransparency = 1}):Play()
            end
        end
        wait(2)
        ScriptCMDs:Destroy()
    end)

    hoverGlow(Title, Title)
    local TitleClickConnection = Title.MouseButton1Click:Connect(function()
        print("hi epic scirpt comandsa")
    end)

    for i,v in pairs(CMDFrame:GetChildren()) do
        if v:IsA("TextButton") then
            hoverGlow(v, v)
            local ButtonClickConnection = v.MouseButton1Click:Connect(function()
                print('Command Example - '..v.Name)
            end)
            table.insert(Connections, {Connection = ButtonClickConnection})
        end
    end
    table.insert(Connections, {Connection = CloseConnection})
    table.insert(Connections, {Connection = TitleClickConnection})
end)
getgenv().KAHHaxLoaded = true
vars.Notify('Loaded oofkohls v2 - Made by Stefanuk12#5820 | Stefanuk12')
warn("Loaded oofkohls v2 - Made by Stefanuk12#5820 | Stefanuk12")