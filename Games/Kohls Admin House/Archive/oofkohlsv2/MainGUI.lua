--[[
    Credits:
        Kinlei for the UI Library: MaterialLUA
    General Infomation:
        If you crash, it's because of the music api.
]]


repeat wait() until game:IsLoaded();

-- // Services
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local HttpService = game:GetService("HttpService");
local Workspace = game:GetService("Workspace");
local MarketplaceService = game:GetService("MarketplaceService");
local TeleportService = game:GetService("TeleportService");
local Lighting = game:GetService("Lighting");
local UserInputService = game:GetService("UserInputService");

-- // Vars
local GameFolder = Workspace.Terrain["_Game"];
local LocalPlayer = Players.LocalPlayer;
local Mouse = LocalPlayer:GetMouse();
local MusicAPI = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Music%20API/Controller.lua"))();
local WorkspaceFolder = GameFolder["Workspace"];
local ProtectedWhitelistedPlayers = {91318356, LocalPlayer.UserId};
local CommandInfo = HttpService:JSONDecode(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Kohls%20Admin%20House/Data.json"));
local CommandsSpamPhrase = {};
local LongText = game:HttpGetAsync("https://github.com/Stefanuk12/ROBLOX/blob/master/Games/Kohls%20Admin%20House/LongText.txt");
local DropdownPlayers = {};

-- // Music Table
local musicTable = MusicAPI.CheckAllSounds();
local MusicTable = {};
for i = 1, #musicTable do
    local v = musicTable[i];
    local String = v["Name"] .. " | " .. v["SoundId"];
    MusicTable[#MusicTable + 1] = String;
end;
local function sortByName(a, b) return a < b; end;
table.sort(MusicTable, sortByName);

-- // GUI
local MaterialUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/MaterialLua/master/Module.lua"))();
local Material = MaterialUI.Load({
	Title = "oofkohls",
	Style = 3,
	SizeX = 500,
	SizeY = 350,
	Theme = "Light",
	ColorOverrides = {
		MainFrame = Color3.fromRGB(235,235,235)
	}
});

-- // Gear Giver
local GearGiverGears = {
    {Name = "PaintBucket", Id = 18474459},
    {Name = "Hyperlaser", Id = 130113146},
    {Name = "RainbowCarpet", Id = 225921000},
    {Name = "Airstrike", Id = 88885539},
    {Name = "SuperRLauncher", Id = 190094159},
    {Name = "RLauncher", Id = 32356064},
    {Name = "SSTripmine", Id = 11999247},
    {Name = "ASSentry", Id = 68603151},
    {Name = "RPOSword", Id = 159229806},
    {Name = "IceStaff", Id = 19704064},
    {Name = "Transmorph", Id = 29099749},
    {Name = "ShiftingPolarity", Id = 61459706},
    {Name = "PortableJustice", Id = 82357101},
};
local GearGiverGearNames = {};
local BlacklistedGears = {"94794847"};
for i = 1, #GearGiverGears do
    local v = GearGiverGears[i];
    table.insert(GearGiverGearNames, v["Name"]);
end;

-- // Saved Settings
local Settings = {
    AdminPermanantAdmin = false,
    ProtectionsAntiBlind = false,
    ProtectionsAntiJail = false,
    ProtectionsAntiKill = false,
    ProtectionsAntiPunish = false,
    SoundAbuseEarRape = false,
    ServerEpilepsy = false,
    ServerLagServer = false,
    ServerRespawnExplode = false,
    ServerPartSpam = false,
    ServerCSystemAlert = false,
    ServerClickSpawnWater = false,
    MusicCommandsSelectSound = "Not selected",
    BlacklistSelectGearId = "Not selected",
    BlacklistSelectPhrase = "Not selected",
    BlacklistedSelectPunishmentPhrase = "Not selected",
    BlacklistAlertUse = false,
    CommandsSelectPhrase = "Not selected",
    MiscSelectPaintColour = Color3.fromRGB(255, 150, 150),
    MiscSelectPaintArea = "Not selected",
    PlayerSelectPlayer = "Not selected",
    PlayerSelectGear = "Not selected",
    WhitelistSelectPlayer = "Not selected"
};

-- // Load settings
if (writefile) then
    if (not isfile("oofkohlsSettings.json")) then
        writefile("oofkohlsSettings.json", tostring(HttpService:JSONEncode(Settings)));
    end;
    local SettingsHolder = HttpService:JSONDecode(readfile("oofkohlsSettings.json"));

    -- // Make it so you can add new settings
    for i,v in pairs(Settings) do
        if (not SettingsHolder[i]) then
            SettingsHolder[i] = v;
        end;
    end;

    Settings = SettingsHolder;
    writefile("oofkohlsSettings.json", HttpService:JSONEncode(Settings) );
end;

-- // Configuring and adding the Player to the PlayerTable
local PlayerTable = {};
local GetPlayers = Players:GetPlayers();
function PlayerChatConfig(msg, v)
    local PlrTable = GetPlayerTable(v.UserId);
    local BLPhrases = PlrTable.BlacklistedPhrases;
    local WLCheck = IsWhitelisted(v.UserId);
    local Whitelisted = (WLCheck[3] ~= "Not defined");

    -- // Checking if the player has said any Blacklisted Phrases
    for i = 1, #BLPhrases do
        local BlacklistedPhrase = BLPhrases[i];
        if (BlacklistedPhrase and msg:find(BlacklistedPhrase.Phrase)) then
            Players:Chat(BlacklistedPhrase.Punishment);
        end;
    end;

    -- // Checking if the player has given anyone a blacklisted gear
    for i = 1, #BlacklistedGears do
        local BLGear = BlacklistedGears[i];
        local splitString = msg:split(" ");
        if (splitString[3] == BLGear and not Whitelisted) then
            local Target = splitString[2];
            if (Target == "me") then Target = v.Name; end;
            Players:Chat(":removetools " .. Target);
            if (Settings["BlacklistAlertUse"]) then
                Players:Chat(":h Imagine trying to gear yourself/others a blacklisted gear, ahem: " .. v.Name);
            end;
        end;
    end;

    if (not Whitelisted) then
        -- // /c system Alert
        if (Settings["ServerCSystemAlert"] and msg == "/c system") then
            Players:Chat(":h Imagine using /c system to hide your commands, ahem: " .. v.Name);
        end;
    end;

    -- // Identifier ;)
    if (WLCheck[2] and v ~= LocalPlayer and msg.lower() == "hi gamers") then
        Players:Chat("Hi gamer!");
    end;
end;
for i = 1, #GetPlayers do
    local v = GetPlayers[i];
    if (v ~= LocalPlayer) then
        -- // Main Table that holds Player Data
        local tbl = {
            Instance = v,
            Name = v.Name,
            UserId = v.UserId,
            Whitelisted = false,
            Lagging = false,
            BlacklistedPhrases = {}
        };
        local Index = #PlayerTable + 1;
        table.insert(PlayerTable, tbl);

        -- // Configuring
        v.Chatted:Connect(function(msg)
            PlayerChatConfig(msg, v);
        end);
    else
        -- // Main Table that holds Player Data
        local tbl = {
            Instance = v,
            Name = v.Name,
            UserId = v.UserId,
            Whitelisted = false,
            Lagging = false,
            BlacklistedPhrases = {}
        };
        table.insert(PlayerTable, tbl);
    end;
end;

-- // Configuring and adding the Player to the PlayerTable
Players.PlayerAdded:Connect(function(v)
    -- // Main Table that holds Player Data
    local tbl = {
        Instance = v,
        Name = v.Name,
        UserId = v.UserId,
        Whitelisted = false,
        Lagging = false,
        BlacklistedPhrases = {}
    };
    local Index = #PlayerTable + 1;
    table.insert(PlayerTable, tbl);
    updateDropdownPlayers();

    -- // Configuring
    v.Chatted:Connect(function(msg)
        PlayerChatConfig(msg, v);
    end);

    -- // If the Respawn Explode is happening, update the spammer.
    if (Settings["ServerRespawnExplode"]) then
        AddPhrase(":respawn " .. v.Name);
        AddPhrase(":explode " .. v.Name);
    end;
end);

-- // Remove from the Player Table
Players.PlayerRemoving:Connect(function(v)
    for i = 1, #PlayerTable do
        local PlrTable = PlayerTable[i];
        if (PlrTable and PlrTable.UserId == v.UserId)then
            table.remove(PlayerTable, i);
        end;
    end;
    updateDropdownPlayers();

    -- // If the Respawn Explode is happening, update the spammer.
    if (Settings["ServerRespawnExplode"]) then
        RemovePhrase(":respawn " .. v.Name);
        RemovePhrase(":explode " .. v.Name);
    end;
end);

-- // Get All Player Name in a Table
function GetAllPlayerNamesAsTable()
    local tbl = {};
    for i = 1, #PlayerTable do
        local v = PlayerTable[i];
        table.insert(tbl, v.Name);
    end;

    return tbl;
end;

-- // Get Player Data
function GetPlayerTable(Player)
    if (typeof(Player) == 'Instance') then Player = Player.UserId; end;
    for i = 1, #PlayerTable do
        local v = PlayerTable[i];
        if (v.Name == Player or v.UserId == Player) then
            return v;
        end;
    end;
end;

-- // Update any Dropdowns that use the PlayerTable when the PlayerTable updates
function updateDropdownPlayers()
    for i = 1, #DropdownPlayers do
        local v = DropdownPlayers[i];
        v:SetOptions(GetAllPlayerNamesAsTable());
    end;
end;

-- // Check if the User is a Protected Whitelisted User
function isPWL(PlayerID)
    -- // Handling if the PlayerID is actually the Player Name
    if (type(PlayerID) == "string") then
        for i = 1, #PlayerTable do
            local v = PlayerTable[i];
            if (v.Name == PlayerID) then
                PlayerID = v.UserId;
            end;
        end;
    end;

    for i = 1, #ProtectedWhitelistedPlayers do
        local v = ProtectedWhitelistedPlayers[i];
        if (v == PlayerID) then
            return true;
        end;
    end;

    return false;
end;

-- // Checking if a Player is whitelisted
function IsWhitelisted(PlayerID)
    -- // Handling if the PlayerID is actually the Player Name
    if (type(PlayerID) == "string") then
        for i = 1, #PlayerTable do
            local v = PlayerTable[i];
            if (v.Name == PlayerID) then
                PlayerID = v.UserId;
            end;
        end;
    end;

    -- // Vars
    local Whitelisted = false;
    local ProtectedWhitelist = false;
    local Index = "Not defined";

    -- // Check if Player is whitelisted
    for i = 1, #PlayerTable do
        local v = PlayerTable[i];
        if (v.Whitelisted) then
            Whitelisted = true;
            Index = i;
        end;
    end;

    -- // Check if Player is Protected
    for i = 1, #ProtectedWhitelistedPlayers do
        local v = ProtectedWhitelistedPlayers[i];
        if (tonumber(v) == tonumber(PlayerID)) then
            ProtectedWhitelist = true;
            Index = i;
        end;
    end;

    return {Whitelisted, ProtectedWhitelist, Index};
end;

-- // Get all players that aren't whitelisted
function GetUnblacklistedPlayers()
    local AllPlayers = Players:GetPlayers();
    for i = 1, #AllPlayers do
        local v = AllPlayers[i];
        if (v) then
            local WL = IsWhitelisted(v.UserId)[3];
            if (WL ~= "Not defined") then
                table.remove(AllPlayers, i);
            end;
        end;
    end;

    return AllPlayers;
end;

-- // Get all players that are whitelisted
function GetWhitelistedPlayers(Search)
    local AllPlayers = Players:GetPlayers();
    local WhitelistedPlayers = {};
    
    if (Search == "All") then
        for i = 1, #AllPlayers do
            local v = AllPlayers[i];
            if (v) then
                local WL = IsWhitelisted(v.UserId)[3];
                if (WL ~= "Not defined") then
                    WhitelistedPlayers[#WhitelistedPlayers + 1] = v;
                end;
            end;
        end;
    elseif (Search == "Normal") then
        for i = 1, #AllPlayers do
            local v = AllPlayers[i];
            if (v) then
                local WL = IsWhitelisted(v.UserId)[1];
                if (WL) then
                    WhitelistedPlayers[#WhitelistedPlayers + 1] = v;
                end;
            end;
        end;
    elseif (Search == "Protected") then
        for i = 1, #AllPlayers do
            local v = AllPlayers[i];
            if (v) then
                local WL = IsWhitelisted(v.UserId)[2];
                if (WL) then
                    WhitelistedPlayers[#WhitelistedPlayers + 1] = v;
                end;
            end;
        end;
    end;

    return WhitelistedPlayers;
end;

function AreTherePWLInTheServer()
    local WL = GetWhitelistedPlayers("Protected");
    for i = 1, #WL do
        local v = WL[i];
        if (v == LocalPlayer) then
            return false;
        end;
    end;

    return #WL > 0;
end;

-- // Spammers
RunService.RenderStepped:Connect(function()
    -- // Phrase Spammer
    coroutine.wrap(function()
        for i = 1, #CommandsSpamPhrase do
            local v = CommandsSpamPhrase[i];
            Players:Chat(v.Phrase);
        end;
    end)();

    -- // Lagger
    coroutine.wrap(function()
        for i = 1, #PlayerTable do
            local v = PlayerTable[i];
            if (v.Lagging) then
                Players:Chat(":pm " .. v.Name .. " " .. LongText);
            end;
        end;
    end)();
end);

-- // Epilepsy
coroutine.wrap(function()
    while wait() do
        if (Settings["ServerEpilepsy"]) then
            Players:Chat(":colorshifttop 10000 0 0"); wait(0.1);
            Players:Chat(":colorshiftbottom 10000 0 0"); wait(0.1);
            Players:Chat(":colorshifttop 0 10000 0"); wait(0.1);
            Players:Chat(":colorshiftbottom 0 10000 0"); wait(0.1);
            Players:Chat(":colorshifttop 0 0 10000"); wait(0.1);
            Players:Chat(":colorshiftbottom 0 0 10000"); wait(0.1);
        end;
    end;
end)();

-- // Ear Rape
coroutine.wrap(function()
    while wait(0.5) do
        if (Settings["SoundAbuseEarRape"]) then
            local WorkspaceDescendants = Workspace:GetDescendants();
            for i = 1, #WorkspaceDescendants do
                local v = WorkspaceDescendants[i];
                if (v:IsA("Sound")) then
                    v:Play();
                end;
            end;
        end;
    end;
end)();

-- // Click Spawn Water
UserInputService.InputBegan:Connect(function(Key, GPE)
    if (not GPE and Key.KeyCode == Enum.KeyCode.LeftControl and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)) then
        Players:Chat(":gear me 236438668");

        local Tool = LocalPlayer.Backpack:WaitForChild("SeaThemedCrossbow");
        local Humanoid = LocalPlayer.Character:WaitForChild("Humanoid");
        
        Humanoid:EquipTool(Tool);

        local Remote = LocalPlayer.Character:WaitForChild("SeaThemedCrossbow"):WaitForChild("Remote");
        Remote:FireServer("LeftDown", Mouse.Hit.Position);

        wait(1);
        Players:Chat(":removetools me");
    end;
end);

-- // Admin checking
function isAdmin()
    local Pads = GameFolder["Admin"]["Pads"]:GetChildren();
    local isPermKohls = false;
    local isPermPersons = false;
    local isNormalAdmin = false;

    if (MarketplaceService:UserOwnsGamePassAsync(LocalPlayer.UserId, 66254)) then 
        isPermKohls = true; 
    end;

    if (MarketplaceService:UserOwnsGamePassAsync(LocalPlayer.UserId, 35748)) then 
        isPermPersons = true; 
    end;

    for i = 1, #Pads do
        local v = Pads[i];

        if (v.Name == LocalPlayer.Name .. "'s admin") then 
            isNormalAdmin = true; 
        end;
    end;

    return (isNormalAdmin or isPermKohls or isPermPersons), isNormalAdmin, isPermKohls, isPermPersons;
end;

-- // Failsafing commadns
function FailSafeCommand(Page, CommandName, ...)
    local Module = tostring(Page)
    local ComamndInfoTableModule = CommandInfo[Module];
    local ComamndInfoTable = ComamndInfoTableModule[CommandName];
    local SelectionArgs = {...};
    local AdminGeneral, _ , _, _ = isAdmin();

    if (ComamndInfoTable["Admin"] and not AdminGeneral) then
        Material.Banner({
            Text = "You don't have admin, this command requries admin."
        });

        return false;
    end;

    -- // Selection
    for i = 1, #SelectionArgs do
        local v = SelectionArgs[i];
        if (v.Requirement and v.Requirement == "Not selected") then
            Material.Banner({
                Text = v.Error;
            });

            return false;
        end;
    end;

    -- // Final return
    return true;
end

-- // Automatically setup the Text and Menu
function SetupTextMenu(Page, CommandName, Options)
    local Module = tostring(Page)
    local ComamndInfoTableModule = CommandInfo[Module];
    local ComamndInfoTable = ComamndInfoTableModule[CommandName];
    local Creation = {
        Text = ComamndInfoTable["Name"],
        Menu = {
            Information = function(self)
                local Description = ComamndInfoTable["Description"];
                if (ComamndInfoTable["Admin"]) then Description = Description .. " This command requires Admin." end;

                Material.Banner({
                    Text = Description
                });
            end;
        }
    };

    if (CommandName == "Select Player") then
        Creation.Options = GetAllPlayerNamesAsTable();
    end;

    for i,v in pairs(Options) do
        if (i ~= "Text" or i ~= "Menu") then
            Creation[i] = v;
        end;
    end;

    local Type = ComamndInfoTable["Type"];

    local Object = Page[Type](Creation);
    if (CommandName == "Select Player") then
        table.insert(DropdownPlayers, Object);
    end;

    return Object;
end;

-- // Building GUI
local Pages = {};
function createPage(PageName)
    local mt = setmetatable(Material.New({Title = PageName}), {__tostring = function() return PageName end});
    table.insert(Pages, mt);
    return mt;
end;

-- // Create Pages
local Admin = createPage("Admin");
local Blacklist = createPage("Blacklist");
local Commands = createPage("Commands");
local Misc = createPage("Misc");
local MusicCommands = createPage("Music Commands");
local Player = createPage("Player");
local Protections = createPage("Protections");
local Server = createPage("Server");
local SoundAbuse = createPage("Sound Abuse");
local Whitelist = createPage("Whitelist");

-- // Admin
local GetAdmin = SetupTextMenu(Admin, "Get Admin", {
    Callback = function()
        if (not fireclickdetector) then
            Material.Banner({
				Text = "Your exploit does not support Get Admin."
			});
            return;
        end;
        fireclickdetector(GameFolder["Admin"].Regen.ClickDetector, 0);
        local TargetPad = GameFolder["Admin"]["Pads"]:FindFirstChild("Touch to get admin").Head;
        if (firetouchinterest) then
            firetouchinterest(LocalPlayer.Character.HumanoidRootPart, TargetPad, 0);
        else
            local savedPos = LocalPlayer.Character.HumanoidRootPart.CFrame;
            LocalPlayer.Character:SetPrimaryPartCFrame(TargetPad.CFrame);
            wait(1);
            LocalPlayer.Character:SetPrimaryPartCFrame(savedPos);
        end;

        Material.Banner({
            Text = "Got admin."
        });
    end;
});

local RegenerateAdmin = SetupTextMenu(Admin, "Regenerate Admin", {
    Callback = function()
        if (not fireclickdetector) then
            Material.Banner({
				Text = "Your exploit does not support Regenerate Admin."
			});
            return;
        end;
        if (GameFolder["Admin"]:FindFirstChild("Regen")) then
            fireclickdetector(GameFolder["Admin"].Regen.ClickDetector, 0);
            Material.Banner({
                Text = "Regenerated admin."
            });
            return;
        end;
        Material.Banner({
            Text = "Could not find regen button, it's likely been tp'd away and you need to load it in first."
        });
    end;
});

local CSelectedPad;
local RegenPad;
local PadSize = Vector3.new(3, 0.4, 3);
local PadCFrame;
coroutine.wrap(function()
    if (fireclickdetector) then
        -- // Base Vars
        CSelectedPad = GameFolder["Admin"]["Pads"]:FindFirstChild(LocalPlayer.Name .."'s admin");
        warn("Waiting for regen pad...");
        RegenPad = GameFolder["Admin"]:WaitForChild("Regen");
        warn("Found regen pad!");
        SelectedPad = GameFolder["Admin"]["Pads"]:FindFirstChild("Touch to get admin");

        -- // Check if you already have a pad, if not, get one
        if (not SelectedPad) then
            if (CSelectedPad) then
                warn("Trying to get a pad...");
                SelectedPad = CSelectedPad;
                warn("Got a pad.");
            else
                warn("Trying to get a pad...");
                fireclickdetector(RegenPad.ClickDetector, 0);
                GameFolder["Admin"]["Pads"]:WaitForChild("Touch to get admin");
                wait(math.random()); -- // Hopefully to allow more than one person to use this
                SelectedPad = GameFolder["Admin"]["Pads"]["Touch to get admin"];
                warn("Got a pad.");
            end;
        end;

        PadCFrame = SelectedPad.Head.CFrame;

        -- // Check when the pad is regen
        SelectedPad:GetPropertyChangedSignal("Name"):Connect(function(Value)
            -- // Check if the pad is not ours and if Permanant Admin is enabled
            if (Settings["AdminPermanantAdmin"] and Value ~= LocalPlayer.Name .."'s admin") then
                fireclickdetector(RegenPad.ClickDetector, 0);

                -- // Constantly tp the Pad to you until you have admin
                repeat wait()
                    SelectedPad.Head.Size = Vector3.new(1, 1, 1);
                    SelectedPad.Head.CFrame = LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame;
                    SelectedPad.Head.CanCollide = false;
                    SelectedPad.Head.Transparency = 1;
                until SelectedPad.Name == LocalPlayer.Name .."'s admin";

                -- // Reset the Pad's Size and CFrame
                SelectedPad.Head.Size = PadSize;
                SelectedPad.Head.CFrame = PadCFrame;
                SelectedPad.Head.CanCollide = true;
                SelectedPad.Head.Transparency = 0;
            end;
        end);
    end;         
end)();

coroutine.wrap(function()
    local PermanantAdmin = SetupTextMenu(Admin, "Permanant Admin", {
        Enabled = Settings["AdminPermanantAdmin"],
        Callback = function(Value)
            if (not fireclickdetector) then
                Material.Banner({
                    Text = "Your exploit does not support Permanant Admin."
                });
                return;
            end;
            Settings["AdminPermanantAdmin"] = Value;

            if (Value) then
                if (not RegenPad) then
                    Material.Banner({
                        Text = "Please find the regen pad for Permanant Admin to work."
                    });
                    warn("Please find the regen pad for Permanant Admin to work.");
                    repeat wait() until SelectedPad ~= nil;
                    Material.Banner({
                        Text = "Found the regen pad."
                    });
                    warn("Found the regen pad.");
                end;

                if (not SelectedPad) then
                    Material.Banner({
                        Text = "Waiting to get a pad..."
                    });
                    warn("Waiting to get a pad...");
                    repeat wait() until SelectedPad ~= nil;
                    Material.Banner({
                        Text = "Got a pad."
                    });
                    warn("Got a pad.");
                end;

                if (SelectedPad.Name ~= LocalPlayer.Name .."'s admin") then
                    fireclickdetector(RegenPad.ClickDetector, 0);

                    -- // Constantly tp the Pad to you until you have admin
                    repeat wait()
                        SelectedPad.Head.Size = Vector3.new(1, 1, 1);
                        SelectedPad.Head.CFrame = LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame;
                        SelectedPad.Head.CanCollide = false;
                        SelectedPad.Head.Transparency = 1;
                    until SelectedPad.Name == LocalPlayer.Name .."'s admin";

                    -- // Reset the Pad's Size and CFrame
                    SelectedPad.Head.Size = PadSize;
                    SelectedPad.Head.CFrame = PadCFrame;
                    SelectedPad.Head.CanCollide = true;
                    SelectedPad.Head.Transparency = 0;
                end;
            else
                if (SelectedPad) then
                    SelectedPad.Head.Size = PadSize;
                    SelectedPad.Head.CFrame = PadCFrame;
                    SelectedPad.Head.CanCollide = true;
                    SelectedPad.Head.Transparency = 0;
                end;
            end;
        end;
    });
end)();

-- // Blacklist
local BlacklistSelectGearId = SetupTextMenu(Blacklist, "Select Gear ID", {
    Callback = function(Value)
        if (not tonumber(Value)) then
            Material.Banner({
                Text = "Please enter a number."
            });
            return;
        end;
        Settings["BlacklistSelectGearId"] = tostring(Value); 
    end;
});

local BlacklistGear = SetupTextMenu(Blacklist, "Blacklist Gear", {
    Callback = function()
        local FailSafeResult = FailSafeCommand(Blacklist, "Blacklist Gear", {
            {
                Requirement = Settings["BlacklistSelectGearId"],
                Error = "Please select a gear."
            };
        });
        if (not FailSafeResult) then return; end;
        
        for i = 1, #BlacklistedGears do
            local v = BlacklistedGears[i];
            if (v == Settings["BlacklistSelectGearId"]) then
                Material.Banner({
                    Text = "This gear has already been blacklisted."
                });
                return;
            end;
        end;

        table.insert(BlacklistedGears, Settings["BlacklistSelectGearId"]);
        Material.Banner({
            Text = "Blacklisted gear."
        });
    end;
});

local UnblacklistGear = SetupTextMenu(Blacklist, "Unblacklist Gear", {
    Callback = function()
        local FailSafeResult = FailSafeCommand(Blacklist, "Unblacklist Gear", {
            {
                Requirement = Settings["BlacklistSelectGearId"],
                Error = "Please select a gear."
            };
        });
        if (not FailSafeResult) then return; end;

        for i = 1, #BlacklistedGears do
            local v = BlacklistedGears[i];
            if (v == Settings["BlacklistSelectGearId"]) then
                table.remove(BlacklistedGears, i);
                Material.Banner({
                    Text = "Unblacklisted gear."
                });
                return;
            end;
        end;

        Material.Banner({
            Text = "This gear has not been blacklisted."
        });
    end;
});

local AlertUse = SetupTextMenu(Blacklist, "Alert Use", {
    Enabled = Settings["BlacklistAlertUse"];
    Callback = function(Value)
        Settings["BlacklistAlertUse"] = Value;
    end;
});

local BlacklistSelectPlayer = SetupTextMenu(Blacklist, "Select Player", {
    Callback = function(Value)
        Settings["BlacklistSelectPlayer"] = Value;
    end;
});

local BlacklistSelectPhrase = SetupTextMenu(Blacklist, "Select Phrase", {
    Callback = function(Value)
        Settings["BlacklistSelectPhrase"] = Value;
    end;
});

local BlacklistedSelectPunishmentPhrase = SetupTextMenu(Blacklist, "Select Punishment Phrase", {
    Callback = function(Value)
        Settings["BlacklistedSelectPunishmentPhrase"] = Value;
    end;
});

local BlacklistPhrase = SetupTextMenu(Blacklist, "Blacklist Phrase", {
    Callback = function()
        local FailSafeResult = FailSafeCommand(Blacklist, "Blacklist Phrase", {
            {
                Requirement = Settings["BlacklistSelectPhrase"],
                Error = "Please input a phrase."
            },
            {
                Requirement = Settings["BlacklistedSelectPunishmentPhrase"],
                Error = "Please input a punishment phrase."
            };
        });
        if (not FailSafeResult) then return; end;

        local BLPhrases = GetPlayerTable(Settings["BlacklistSelectPlayer"]).BlacklistedPhrases;
        for i = 1, #BLPhrases do
            local v = BLPhrases[i];
            if (v.Phrase == Settings["BlacklistSelectPhrase"]) then
                Material.Banner({
                    Text = "This phrase has already been blacklisted for this player."
                });
                return;
            end;
        end;

        table.insert(BLPhrases, {Phrase = Settings["BlacklistSelectPhrase"], Punishment = Settings["BlacklistedSelectPunishmentPhrase"]});
        Material.Banner({
            Text = "Blacklisted Phrase."
        });
    end;
});

local UnblacklistPhrase = SetupTextMenu(Blacklist, "Unblacklist Phrase", {
    Callback = function()
        local FailSafeResult = FailSafeCommand(Blacklist, "Unblacklist Phrase", {
            {
                Requirement = Settings["BlacklistSelectPhrase"],
                Error = "Please input a phrase."
            };
        });
        if (not FailSafeResult) then return; end;

        local BLPhrases = GetPlayerTable(Settings["BlacklistSelectPlayer"]).BlacklistedPhrases;
        for i = 1, #BLPhrases do
            local v = BLPhrases[i];
            if (v.Phrase == Settings["BlacklistSelectPhrase"]) then
                table.remove(BLPhrases, i);
                Material.Banner({
                    Text = "Unblacklisted Phrase."
                });
                return;
            end;
        end;

        Material.Banner({
            Text = "This phrase has not been blacklisted for this player."
        });
    end;
});

-- // Commands
local CommandsSelectPhrase = SetupTextMenu(Commands, "Select Phrase", {
    Callback = function(Value)
        Settings["CommandsSelectPhrase"] = Value;
    end;
});

local SayPhrase = SetupTextMenu(Commands, "Say Phrase", {
    Callback = function()
        local FailSafeResult = FailSafeCommand(Commands, "Say Phrase", {
            {
                Requirement = Settings["CommandsSelectPhrase"],
                Error = "Please input a phrase."
            }
        });
        if (not FailSafeResult) then return; end;

        Players:Chat(Settings["CommandsSelectPhrase"]);
    end;
});

-- // Add Phrase to the Spammer
function AddPhrase(_Phrase)
    local IsInSpammer = false;

    -- // Check if the phrase is already in the Spammer
    for i = 1, #CommandsSpamPhrase do
        local v = CommandsSpamPhrase[i];
        if (v.Phrase == _Phrase) then
            IsInSpammer = true;
            break;
        end;
    end;

    -- // If it's not in the spammer, add it to the spammer
    if (not IsInSpammer) then
        table.insert(CommandsSpamPhrase, {Phrase = _Phrase});
        return true;
    end;

    return false;
end;

-- // Remove Phrase from the Spammer
function RemovePhrase(_Phrase)
    -- // Vars
    local IsInSpammer = false;
    local Index = 1;

    -- // Check if the phrase is already in the Spammer
    for i = 1, #CommandsSpamPhrase do
        local v = CommandsSpamPhrase[i];
        if (v.Phrase == _Phrase) then
            IsInSpammer = true;
            Index = i;
        end;
    end;

    -- // If it's in the spammer, remove it
    if (IsInSpammer) then
        table.remove(CommandsSpamPhrase, Index);
        return true;
    end;

    return false;
end;

local SpamPhrase = SetupTextMenu(Commands, "Spam Phrase", {
    Callback = function()
        local FailSafeResult = FailSafeCommand(Commands, "Spam Phrase", {
            {
                Requirement = Settings["CommandsSelectPhrase"],
                Error = "Please input a phrase."
            }
        });
        if (not FailSafeResult) then return; end;

        local InsertIntoSpammer = AddPhrase(Settings["CommandsSelectPhrase"]);
        if (InsertIntoSpammer) then
            Material.Banner({
				Text = "Successfully added phrase to spammer."
			});
        else
            Material.Banner({
				Text = "Phrase is already in the spammer."
			});
        end;
    end;
});

local StopSpamPhrase = SetupTextMenu(Commands, "Stop Spam Phrase", {
    Callback = function()
        local FailSafeResult = FailSafeCommand(Commands, "Stop Spam Phrase", {
            {
                Requirement = Settings["CommandsSelectPhrase"],
                Error = "Please input a phrase."
            }
        });
        if (not FailSafeResult) then return; end;

        local InsertIntoSpammer = RemovePhrase(Settings["CommandsSelectPhrase"]);
        if (InsertIntoSpammer) then
            Material.Banner({
				Text = "Successfully added phrase to spammer."
			});
        else
            Material.Banner({
				Text = "Phrase is not in the spammer."
			});
        end;
    end;
});

-- // Misc
local MiscSelectPaintColour = SetupTextMenu(Misc, "Select Paint Colour", {
    Default = Settings["MiscSelectPaintColour"];
    Callback = function(Value)
        Settings["MiscSelectPaintColour"] = Value;
    end;
});

local MiscSelectPaintArea = SetupTextMenu(Misc, "Select Paint Area", {
    Options = {
        "All",
        "Admin Dividers",
        "Basic House",
        "Obby",
        "Building Bricks",
        "Obby Box",
    },
    Callback = function(Value)
        Settings["MiscSelectPaintArea"] = Value
    end;
});

local PaintArea = SetupTextMenu(Misc, "Paint Area", {
    Callback = function()
        local FailSafeResult = FailSafeCommand(Misc, "Select Paint Colour", {
            {
                Requirement = Settings["MiscSelectPaintColour"],
                Error = "Please input a colour."
            },
            {
                Requirement = Settings["MiscSelectPaintArea"],
                Error = "Please select an area to paint."
            }
        });
        if (not FailSafeResult) then return; end;

        -- // Check if you already have a Paint Bucket
        if (not ( LocalPlayer.Backpack:FindFirstChild("PaintBucket") or LocalPlayer.Character:FindFirstChild("PaintBucket") )) then
            Players:Chat(":gear me 18474459");
        end;
        LocalPlayer.Backpack:WaitForChild("PaintBucket");
        LocalPlayer.Character.Humanoid:EquipTool(LocalPlayer.Backpack.PaintBucket);
        LocalPlayer.Character:WaitForChild("PaintBucket");

        -- // Painting
        local Remote = LocalPlayer.Character:WaitForChild("PaintBucket"):WaitForChild("Remotes"):WaitForChild("ServerControls");
        local SelectedArea = Settings["MiscSelectPaintArea"];
        local SelectedColour = Settings["MiscSelectPaintColour"];

        if (SelectedArea == "All") then
            local AllDescendants = WorkspaceFolder:GetDescendants();
            for i = 1, #AllDescendants do
                local part = AllDescendants[i];
                coroutine.wrap(function()
                    if (part:IsA("BasePart")) then
                        Remote:InvokeServer("PaintPart", {["Part"] = part, ["Color"] = SelectedColour});
                    end;
                end)();
            end;
        else
            local AreaDescendants = WorkspaceFolder[SelectedArea]:GetDescendants();
            for i = 1, #AreaDescendants do
                local part = AreaDescendants[i];
                coroutine.wrap(function()
                    if (part:IsA("BasePart")) then
                        Remote:InvokeServer("PaintPart", {["Part"] = part, ["Color"] = SelectedColour});
                    end;
                end)();
            end;
        end;
    end;
});

local Rejoin = SetupTextMenu(Misc, "Rejoin", {
    Callback = function()
        TeleportService:Teleport(game.PlaceId);
    end;
});

local StartAudioVisualiser = SetupTextMenu(Misc, "Start Audio Visualiser", {
    Callback = function()
        loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Kohls%20Admin%20House/AudioVisualiser.lua"))();
        Material.Banner({
            Text = "Audio Visualiser Started. Check the documentation for all of the commands here: bit.ly/kahvisual."
        });
    end;
});

local SaveSettings = SetupTextMenu(Misc, "Save Settings", {
    Callback = function()
        if (writefile) then
            writefile("oofkohlsSettings.json", HttpService:JSONEncode(Settings) );
            Material.Banner({
				Text = "Settings have been saved."
			});
        else
            Material.Banner({
				Text = "Your exploit does not support Save Settings."
			});
        end;
    end;
});

-- // Music Commands
local SelectSound = SetupTextMenu(MusicCommands, "Select Sound", {
    Options = MusicTable,
    Callback = function(Value)
        local Find = Value:find("| ");
        local Value2 = Value:sub(Find);
        local Value3 = Value2:sub(3);
        Settings["MusicCommandsSelectSound"] = Value3;
    end;
});

local PlaySound = SetupTextMenu(MusicCommands, "Play Sound", {
    Callback = function()
        local Failsafe = FailSafeCommand(MusicCommands, "Play Sound", {
            {
                Requirement = Settings["MusicCommandsSelectSound"],
                Error = "Please select a sound."
            }
        });
        if (not Failsafe) then return; end;

        Players:Chat(":music " .. Settings["MusicCommandsSelectSound"]);
        Material.Banner({
            Text = "Played Sound."
        });
    end;
});

local RefreshSounds = SetupTextMenu(MusicCommands, "Refresh Sounds", {
    Callback = function()
        Material.Banner({
            Text = "Refreshing Sounds, please wait."
        });

        musicTable = MusicAPI.CheckAllSounds();
        MusicTable = {};
        for i = 1, #musicTable do
            local v = musicTable[i];
            local String = v["Name"] .. " | " .. v["SoundId"];
            MusicTable[#MusicTable + 1] = String;
        end;
        table.sort(MusicTable, sortByName);

        SelectSound:SetOptions(MusicTable);

        Material.Banner({
            Text = "Refreshed Sounds."
        });
    end;
});

-- // Player
local PlayerSelectPlayer = SetupTextMenu(Player, "Select Player", {
    Callback = function(Value)
        Settings["PlayerSelectPlayer"] = Value;
    end;
});

local PlayerSelectGear = SetupTextMenu(Player, "Select Gear", {
    Options = GearGiverGearNames;
    Callback = function(Value)
        Settings["PlayerSelectGear"] = Value;
    end;
});

local GetAge = SetupTextMenu(Player, "Get Age", {
    Callback = function()
        local FailSafeResult = FailSafeCommand(Player, "Get Age", {
            {
                Requirement = Settings["PlayerSelectPlayer"],
                Error = "Please select a player."
            }
        });
        if (not FailSafeResult) then return; end;
        local TargetPlayer = Settings["PlayerSelectPlayer"];
        Material.Banner({
			Text = TargetPlayer .. "'s Account Age is: " .. Players[TargetPlayer]["AccountAge"] .. " days.";
		});
    end;
});

local GiveClientBTools = SetupTextMenu(Player, "Give Client BTools", {
    Callback = function()
        local FailSafeResult = FailSafeCommand(Player, "Give Client BTools", {
            {
                Requirement = Settings["PlayerSelectPlayer"],
                Error = "Please select a player."
            }
        });
        if (not FailSafeResult) then return; end;

        Players:Chat(":gear " .. Settings["PlayerSelectPlayer"] .. " 16200204");
        Players:Chat(":gear " .. Settings["PlayerSelectPlayer"] .. " 16200402");
        Players:Chat(":gear " .. Settings["PlayerSelectPlayer"] .. " 16969792");
        Players:Chat(":gear " .. Settings["PlayerSelectPlayer"] .. " 73089190");
        Players:Chat(":gear " .. Settings["PlayerSelectPlayer"] .. " 21001552");
    end;
});

local GiveGear = SetupTextMenu(Player, "Give Gear", {
    Callback = function()
        local FailSafeResult = FailSafeCommand(Player, "Give Gear", {
            {
                Requirement = Settings["PlayerSelectPlayer"],
                Error = "Please select a player."
            },
            {
                Requirement = Settings["PlayerSelectGear"],
                Error = "Please select a gear."
            }
        });
        if (not FailSafeResult) then return; end;

        local GearId;
        for i = 1, #GearGiverGears do
            local v = GearGiverGears[i];
            if (v.Name == Settings["PlayerSelectGear"]) then
                GearId = v.Id;
            end;
        end;

        Players:Chat(":gear " .. Settings["PlayerSelectPlayer"] .. " " .. GearId);
    end;
});

local GiveTeapotTurret = SetupTextMenu(Player, "Give Teapot Turret", {
    Callback = function()
        local FailSafeResult = FailSafeCommand(Player, "Give Teapot Turret", {
            {
                Requirement = Settings["PlayerSelectPlayer"],
                Error = "Please select a player."
            }
        });
        if (not FailSafeResult) then return; end;

        Players:Chat(":hat " .. Settings["PlayerSelectPlayer"] .. " 1055299");
    end;
});

local LagPlayer = SetupTextMenu(Player, "Lag Player", {
    Callback = function()
        local FailSafeResult = FailSafeCommand(Player, "Lag Player", {
            {
                Requirement = Settings["PlayerSelectPlayer"],
                Error = "Please select a player."
            }
        });
        if (not FailSafeResult) then return; end;

        if (isPWL(Settings["PlayerSelectPlayer"])) then
            Material.Banner({
                Text = "This player is protected from abusive commands."
            });
            return;
        end;

        local PlrTable = GetPlayerTable(Settings["PlayerSelectPlayer"]);
        if (PlrTable.Lagging) then
            Material.Banner({
                Text = "This player is already being lagged."
            });
            return;
        elseif (not PlrTable.Lagging) then
            PlrTable.Lagging = true;
            Material.Banner({
                Text = "Lagging player."
            });
        end;
    end;
});

local StopLagPlayer = SetupTextMenu(Player, "Stop Lag Player", {
    Callback = function()
        local FailSafeResult = FailSafeCommand(Player, "Stop Lag Player", {
            {
                Requirement = Settings["PlayerSelectPlayer"],
                Error = "Please select a player."
            }
        });
        if (not FailSafeResult) then return; end;
        local PlrTable = GetPlayerTable(Settings["PlayerSelectPlayer"]);

        if (not PlrTable.Lagging) then
            Material.Banner({
                Text = "This player is not being lagged at the moment."
            });
            return;
        elseif (PlrTable.Lagging) then
            PlrTable.Lagging = false;
            Material.Banner({
                Text = "Stopped lagging player"
            });
        end;
    end;
});

-- // Protections
Lighting.ChildAdded:Connect(function(child) -- // Anti Punish
    if (Settings["ProtectionsAntiPunish"] and child.Name == LocalPlayer.Name) then
        Players:Chat(":reset me");
    end;
end);

LocalPlayer.PlayerGui.ChildAdded:Connect(function(child) -- // Anti Blind
    if (Settings["ProtectionsAntiBlind"] and child.Name == "EFFECTGUIBLIND") then
        wait(0.1);
        child:Destroy();
    end
end);

LocalPlayer.Character:WaitForChild("Humanoid").Died:Connect(function() -- // Anti Kill
    if (Settings["ProtectionsAntiKill"]) then
        Players:Chat(":reset me");
    end;
end);

LocalPlayer.CharacterAdded:Connect(function(Character)
    Character:WaitForChild("Humanoid").Died:Connect(function() -- // Anti Kill
        if (Settings["ProtectionsAntiKill"]) then
            Players:Chat(":reset me");
        end;
    end);
end);

GameFolder["Folder"].ChildAdded:Connect(function(child) -- // Anti Jail
    if (Settings["ProtectionsAntiJail"] and child.Name == LocalPlayer.Name.."'s jail") then
        Players:Chat(":removejails");
    end;
end);

local AntiBlind = SetupTextMenu(Protections, "Anti Blind", {
    Enabled = Settings["ProtectionsAntiBlind"],
    Callback = function(Value)
        Settings["ProtectionsAntiBlind"] = Value
    end;
});

local AntiJail = SetupTextMenu(Protections, "Anti Jail", {
    Enabled = Settings["ProtectionsAntiJail"],
    Callback = function(Value)
        Settings["ProtectionsAntiJail"] = Value
    end;
});

local AntiKill = SetupTextMenu(Protections, "Anti Kill", {
    Enabled = Settings["ProtectionsAntiKill"],
    Callback = function(Value)
        Settings["ProtectionsAntiKill"] = Value
    end;
});

local AntiPunish = SetupTextMenu(Protections, "Anti Punish", {
    Enabled = Settings["ProtectionsAntiPunish"],
    Callback = function(Value)
        Settings["ProtectionsAntiPunish"] = Value
    end;
});

-- // Server
local csystemAlert = SetupTextMenu(Server, "/c system Alert", {
    Enabled = Settings["ServerCSystemAlert"],
    Callback = function(Value)
        Settings["ServerCSystemAlert"] = Value;
    end;
});

local CrashServer = SetupTextMenu(Server, "Crash Server", {
    Callback = function()
        local WL = GetWhitelistedPlayers("Protected");
        if (AreTherePWLInTheServer()) then
            Material.Banner({
                Text = "There is a protected whitelist user in this server, you may not crash it."
            });
            return;
        end;

        Players:Chat(":gear me 94794847");
        LocalPlayer.Backpack:WaitForChild("VampireVanquisher");
        LocalPlayer.Character.Humanoid:EquipTool(LocalPlayer.Backpack.VampireVanquisher);
        LocalPlayer.Character:WaitForChild("VampireVanquisher");
        for i = 1, 10 do
            Players:Chat(":size me .3");
            wait();
        end;

        Material.Banner({
			Text = "Crashed Server."
		});
    end;
});

local CreatePhantomBaseplate = SetupTextMenu(Server, "Create Phantom Baseplate", {
    Callback = function()
        local Baseplate = Instance.new("Part", GameFolder["Workspace"])
        Baseplate.Name = "PhantomBaseplate"
        Baseplate.BrickColor = BrickColor.new("Bright green")
        Baseplate.Size = Vector3.new(1000, 1.2, 1000)
        Baseplate.TopSurface = "Studs"
        Baseplate.Anchored = true
        Material.Banner({
			Text = "Made Phantom Baseplate."
		});
    end;
});

local Epilepsy = SetupTextMenu(Server, "Epilepsy", {
    Enabled = Settings["ServerEpilepsy"],
    Callback = function(Value)
        Settings["ServerEpilepsy"] = Value;
    end;
});

local MoveBaseplate = SetupTextMenu(Server, "Move Baseplate", {
    Callback = function()
        local Spawn = WorkspaceFolder.Spawn3;
        local Baseplate = WorkspaceFolder.Baseplate;

        local testCFrame = Baseplate.CFrame;
        local testPosition = Spawn.Position;
        local X, Y, Z, R00, R01, R02, R10, R11, R12, R20, R21, R22 = testCFrame:GetComponents();
        local X, Y, Z = testPosition.X, Y + 3, testPosition.Z;
        local newCFrame = CFrame.new(X, Y, Z, R00, R01, R02, R10, R11, R12, R20, R21, R22);

        LocalPlayer.Character:SetPrimaryPartCFrame(newCFrame);
        wait(1.5);
        Players:Chat(":stun me");
        Material.Banner({
			Text = "Put you in the position to move the baseplate."
		});
    end;
});

local PartSpam = SetupTextMenu(Server, "Part Spam", {
    Enabled = Settings["ServerPartSpam"],
    Callback = function(Value)
        if (not MarketplaceService:UserOwnsGamePassAsync(LocalPlayer.UserId, 35748)) then
            Material.Banner({
                Text = "You need Persons299 admin for this command to function."
            });
            return;
        end;
        Settings["ServerPartSpam"] = Value;

        if (Settings["ServerPartSpam"]) then
            AddPhrase("part/10/10/10");
        else
            RemovePhrase("part/10/10/10");
        end;
    end;
});

local RemovePhantomBaseplate = SetupTextMenu(Server, "Remove Phantom Baseplates", {
    Callback = function()
        local PhantomBaseplates = GameFolder["Workspace"]:GetChildren();
        for i = 1, #PhantomBaseplates do
            local v = PhantomBaseplates[i];
            if v.Name == "PhantomBaseplate" then
                v:Destroy();
            end;
        end;
    end;
});

local RespawnExplode = SetupTextMenu(Server, "Respawn Explode", {
    Enabled = Settings["ServerRespawnExplode"],
    Callback = function(Value)
        Settings["ServerRespawnExplode"] = Value;
        local UnblacklistedPlayers = GetUnblacklistedPlayers();

        if (Settings["ServerRespawnExplode"]) then
            for i = 1, #UnblacklistedPlayers do
                local v = UnblacklistedPlayers[i];
                AddPhrase(":respawn " .. v.Name);
                AddPhrase(":explode " .. v.Name);
            end;
        elseif (not Settings["ServerRespawnExplode"]) then
            for i = 1, #UnblacklistedPlayers do
                local v = UnblacklistedPlayers[i];
                RemovePhrase(":respawn " .. v.Name);
                RemovePhrase(":explode " .. v.Name);
            end;
        end;
    end;
});

local ClickSpawnWater = SetupTextMenu(Server, "Click Spawn Water", {
    Enabled = Settings["ServerClickSpawnWater"],
    Callback = function(Value)
        Settings["ServerClickSpawnWater"] = Value;
    end;
});

-- // Sound Abuse
local SoundAbuseEarRape = SetupTextMenu(SoundAbuse, "Ear Rape", {
    Enabled = Settings["SoundAbuseEarRape"],
    Callback = function(Value)
        Settings["SoundAbuseEarRape"] = Value;
    end;
});

local PlayAllSounds = SetupTextMenu(SoundAbuse, "Play All Sounds", {
    Callback = function()
        local WorkspaceDescendants = Workspace:GetDescendants();
        for i = 1, #WorkspaceDescendants do
            local v = WorkspaceDescendants[i];
            if (v:IsA("Sound")) then
                v:Play();
            end;
        end;

        Material.Banner({
            Text = "Played all sounds."
        });
    end;
});

local PlayMusic = SetupTextMenu(SoundAbuse, "Play Music", {
    Callback = function()
        local Sound = GameFolder.Folder:FindFirstChildWhichIsA("Sound");
		if (Sound) then
            Sound:Play();
            Material.Banner({
				Text = "Played music."
			});
		else
			Material.Banner({
				Text = "There is no music sound."
			});
			return;
		end;
    end;
});

local StopAllSounds = SetupTextMenu(SoundAbuse, "Stop All Sounds", {
    Callback = function()
        local WorkspaceDescendants = Workspace:GetDescendants();
        for i = 1, #WorkspaceDescendants do
            local v = WorkspaceDescendants[i];
            if (v:IsA("Sound")) then
                v:Stop();
            end;
        end;

        Material.Banner({
            Text = "Stop all sounds."
        });
    end;
});

local StopMusic = SetupTextMenu(SoundAbuse, "Stop Music", {
    Callback = function()
        local Sound = GameFolder.Folder:FindFirstChildWhichIsA("Sound");
		if (Sound) then
            Sound:Stop();
            Material.Banner({
				Text = "Stopped music."
			});
		else
			Material.Banner({
				Text = "There is no music sound."
			});
			return;
		end;
    end;
});

-- // Whitelist
local WhitelistSelectPlayer = SetupTextMenu(Whitelist, "Select Player", {
    Callback = function(Value)
        Settings["WhitelistSelectPlayer"] = Value;
    end;
});

local UnwhitelistPlayer = SetupTextMenu(Whitelist, "Unwhitelist Player", {
    Callback = function()
        local FailSafeResult = FailSafeCommand(Whitelist, "Unwhitelist Player", {
            {
                Requirement = Settings["WhitelistSelectPlayer"],
                Error = "Please select a player."
            }
        });
        if (not FailSafeResult) then return; end;

        local Whitelisted = IsWhitelisted(Settings["WhitelistSelectPlayer"]);
        local WL, PWL, Index = Whitelisted[1], Whitelisted[2], Whitelisted[3];
        if (WL) then
            for i = 1, #PlayerTable do
                local v = PlayerTable[i];
                if (v.Name == Settings["WhitelistSelectPlayer"]) then
                    v.Whitelisted = false;
                end;
            end;
            Material.Banner({
				Text = "Unwhitelisted Player."
            });
            return;
        end;
        if (PWL) then
            Material.Banner({
				Text = "This player cannot be unwhitelisted, they are protected."
            });
            return;
        end;
        if (not WL) then
            Material.Banner({
				Text = "This player is not whitelisted."
            });
            return;
        end;
    end;
});

local WhitelistPlayer = SetupTextMenu(Whitelist, "Whitelist Player", {
    Callback = function()
        local FailSafeResult = FailSafeCommand(Whitelist, "Whitelist Player", {
            {
                Requirement = Settings["WhitelistSelectPlayer"],
                Error = "Please select a player."
            }
        });
        if (not FailSafeResult) then return; end;

        local Whitelisted = IsWhitelisted(Settings["WhitelistSelectPlayer"]);
        local WL, PWL, Index = Whitelisted[1], Whitelisted[2], Whitelisted[3];
        if (PWL) then
            Material.Banner({
				Text = "This player has already been whitelisted."
            });
            return;
        end;
        if (not WL) then
            for i = 1, #PlayerTable do
                local v = PlayerTable[i];
                if (v.Name == Settings["WhitelistSelectPlayer"]) then
                    v.Whitelisted = true;
                end;
            end;
            Material.Banner({
				Text = "Whitelisted Player."
            });
            return;
        else
            Material.Banner({
				Text = "This player is already whitelisted."
            });
            return;
        end;
    end;
});