-- // Credit to Kinlei for the UI Library: MaterialLUA.

-- // Services
local Players = game:GetService("Players");
local HttpService = game:GetService("HttpService");
local Workspace = game:GetService("Workspace");
local MarketplaceService = game:GetService("MarketplaceService");

-- // Vars
local GameFolder = Workspace.Terrain["_Game"];
local LocalPlayer = Players.LocalPlayer;
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();

-- // Settings + Command Info
local CommandInfo = HttpService:JSONDecode(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Kohls%20Admin%20House/Data.json"));local MusicAPI = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Music%20API/Controller.lua"))();
local musicTable = MusicAPI.musicTable;
local MusicTable = {};
for i = 1, #musicTable do
    table.insert(MusicTable, musicTable[i]["Name"]);
end;
local Settings;
if (writefile) then
    if (not isfile("oofkohlsSettings.json")) then
        local jsonObj = {
            AdminPermanantAdmin = false,
            ProtectionsAntiBlind = false,
            ProtectionsAntiJail = false,
            ProtectionsAntiKill = false,
            ProtectionsAntiPunish = false
        };
        writefile("oofkohlsSettings.json", tostring(HttpService:JSONEncode(jsonObj)));
    end;
    Settings = HttpService:JSONDecode(readfile("oofkohlsSettings.json"));
else
    Settings = {
        AdminPermanantAdmin = false,
        ProtectionsAntiBlind = false,
        ProtectionsAntiJail = false,
        ProtectionsAntiKill = false,
        ProtectionsAntiPunish = false
    };
end;


-- // GUI Settings + Vars
local MaterialUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/MaterialLua/master/Module.lua"))();
local DropdownPlayers = {};
local PlayerTable = {};
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

-- // Add new/existing players and remove old players from PlayerTable
local GetPlayers = Players:GetPlayers();
for i = 1, #GetPlayers do
    table.insert(PlayerTable, GetPlayers[i].Name);
end;

Players.PlayerAdded:Connect(function(plr)
    table.insert(PlayerTable, plr.Name);
    updateDropdownPlayers();
end);

Players.PlayerRemoving:Connect(function(plr)
    for i = 1, #PlayerTable do
        if (PlayerTable[i] == plr.Name)then
            table.remove(PlayerTable, i);
        end;
    end;
    updateDropdownPlayers();
end);

-- // Update any Dropdowns that use the PlayerTable when the PlayerTable updates
function updateDropdownPlayers()
    for i = 1, #DropdownPlayers do
        if (DropdownPlayers[i].SetOptions) then DropdownPlayers[i].SetOptions(PlayerTable); end;
    end;
end;

-- // Check if a Player is admin
function isAdmin(Player)
	local targetPlayer = Players:GetUserIdFromNameAsync(Player);
	if (MarketplaceService:UserOwnsGamePassAsync(targetPlayer, 66254)) then return true; end;
    local Pads = GameFolder["Admin"]["Pads"]:GetChildren();
    for i = 1, #Pads do
        if (Pads[i].Name == Player .. "'s admin") then return true; end;
    end;
	return false;
end;

-- // Building GUI
local Pages = {};
function createPage(PageName)
    local mt = setmetatable(Material.New({Title = PageName}), {__tostring = function() return PageName end});
    table.insert(Pages, mt);
    return mt;
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
        Creation.Options = PlayerTable;
    end;

    for i,v in pairs(Options) do
        if (i ~= "Text" or i ~= "Menu") then
            Creation[i] = v;
        end;
    end;

    local Type = ComamndInfoTable["Type"];

    local Object = Page[Type](Creation);
    if (CommandName == "Select Player") then table.insert(DropdownPlayers, Object); end;

    return Object;
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

-- // Create GUI

-- // Admin
local GetAdmin = SetupTextMenu(Admin, "Get Admin", {
    Callback = function()
        local TargetPad = GameFolder["Admin"]["Pads"]:FindFirstChild("Touch to get admin");
        if (firetouchinterest) then
            firetouchinterest(Character.HumanoidRootPart, TargetPad.Head, 0);
        else
            local savedPos = Character.HumanoidRootPart.CFrame;
            Character.HumanoidRootPart.CFrame = TargetPad.Head.CFrame;
            wait(1);
            Character.HumanoidRootPart.CFrame = savedPos;
        end;

        Material.Banner({
            Text = "Got admin."
        });
    end;
});

local RegenerateAdmin = SetupTextMenu(Admin, "Regenerate Admin", {
    Callback = function()
        if (fireclickdetector) then
            fireclickdetector(GameFolder["Admin"].Regen.ClickDetector, 0);
            Material.Banner({
				Text = "Regenerated admin."
			});
        else
            Material.Banner({
				Text = "Your exploit does not support this feature."
			});
            return;
        end;
    end;
});

local PermanantAdmin = SetupTextMenu(Admin, "Permanant Admin", {
    Callback = function(Value)
        Settings["AdminPermanantAdmin"] = Value;
    end;
});

-- // Blacklist
local BlacklistSelectGearId = SetupTextMenu(Blacklist, "Select Gear ID", {
    Callback = function(Value)
        
    end;
});

local BlacklistSelectPhrase = SetupTextMenu(Blacklist, "Select Phrase", {
    Callback = function(Value)
        
    end;
});

local BlacklistSelectPlayer = SetupTextMenu(Blacklist, "Select Player", {
    Callback = function(Value)
        
    end;
});

local BlacklistGear = SetupTextMenu(Blacklist, "Blacklist Gear", {
    Callback = function()
        
    end;
});

local BlacklistPhrase = SetupTextMenu(Blacklist, "Blacklist Phrase", {
    Callback = function()
        
    end;
});

local UnblacklistGear = SetupTextMenu(Blacklist, "Unblacklist Gear", {
    Callback = function()
        
    end;
});

local UnblacklistPhrase = SetupTextMenu(Blacklist, "Unblacklist Phrase", {
    Callback = function()
        
    end;
});

-- // Commands
local CommandsSelectPhrase = SetupTextMenu(Commands, "Select Phrase", {
    Callback = function(Value)
        
    end;
});

local SayPhrase = SetupTextMenu(Commands, "Say Phrase", {
    Callback = function()
        
    end;
});

local SpamPhrase = SetupTextMenu(Commands, "Spam Phrase", {
    Callback = function()
        
    end;
});

local StopSpamPhrase = SetupTextMenu(Commands, "Stop Spam Phrase", {
    Callback = function()
        
    end;
});

-- // Misc
local MiscSelectPaintColour = SetupTextMenu(Misc, "Select Paint Colour", {
    Default = Color3.fromRGB(255, 150, 150);
    Callback = function()

    end;
});

local PaintArea = SetupTextMenu(Misc, "Paint Area", {
    Callback = function()
        
    end;
});

local Rejoin = SetupTextMenu(Misc, "Rejoin", {
    Callback = function()
        
    end;
});

local SaveSettings = SetupTextMenu(Misc, "Save Settings", {
    Callback = function()
        if (writefile) then
            writefile("oofkohlsSettings.json", tostring(HttpService:JSONEncode(jsonObj)));
        else 
            Material.Banner({
				Text = "Your exploit does not support this feature."
			});
        end;
    end;
});

-- // Music Commands
local SelectSound = SetupTextMenu(MusicCommands, "Select Sound", {
    Options = MusicTable,
    Callback = function()

    end;
})
local PlaySound = SetupTextMenu(MusicCommands, "Play Sound", {
    Callback = function()
        
    end;
});

local RefreshSounds = SetupTextMenu(MusicCommands, "Refresh Sounds", {
    Callback = function()
        
    end;
});

-- // Player
local PlayerSelectPlayer = SetupTextMenu(Player, "Select Player", {
    Callback = function(Value)
        
    end;
});

local GetAge = SetupTextMenu(Player, "Get Age", {
    Callback = function()
        
    end;
});

local GiveClientBTools = SetupTextMenu(Player, "Give Client BTools", {
    Callback = function()
        
    end;
});

local GiveGear = SetupTextMenu(Player, "Give Gear", {
    Callback = function()
        
    end;
});

local GiveTeapotTurret = SetupTextMenu(Player, "Give Teapot Turret", {
    Callback = function()
        
    end;
});

local LagPlayer = SetupTextMenu(Player, "Lag Player", {
    Callback = function()
        
    end;
});

local StopLagPlayer = SetupTextMenu(Player, "Stop Lag Player", {
    Callback = function()
        
    end;
});

-- // Protections
local AntiBlind = SetupTextMenu(Protections, "Anti Blind", {
    Enabled = false,
    Callback = function(Value)
        
    end;
});

local AntiJail = SetupTextMenu(Protections, "Anti Jail", {
    Enabled = false,
    Callback = function(Value)
        
    end;
});

local AntiKill = SetupTextMenu(Protections, "Anti Kill", {
    Enabled = false,
    Callback = function(Value)
        
    end;
});

local AntiPunish = SetupTextMenu(Protections, "Anti Punish", {
    Enabled = false,
    Callback = function(Value)
        
    end;
});

-- // Server
local CrashServer = SetupTextMenu(Server, "Crash Server", {
    Enabled = false,
    Callback = function()
        
    end;
});

local CreatePhantomBaseplate = SetupTextMenu(Server, "Create Phantom Baseplate", {
    Enabled = false,
    Callback = function()
        
    end;
});

local Epilepsy = SetupTextMenu(Server, "Epilepsy", {
    Enabled = false,
    Callback = function(Value)
        
    end;
});

local LagServer = SetupTextMenu(Server, "Lag Server", {
    Enabled = false,
    Callback = function()
        
    end;
});

local MoveBaseplate = SetupTextMenu(Server, "Move Baseplate", {
    Enabled = false,
    Callback = function()
        
    end;
});

local PartSpam = SetupTextMenu(Server, "Part Spam", {
    Enabled = false,
    Callback = function(Value)
        
    end;
});

local RemovePhantomBaseplate = SetupTextMenu(Server, "Remove Phantom Baseplates", {
    Enabled = false,
    Callback = function()
        
    end;
});

local RespawnExplode = SetupTextMenu(Server, "Respawn Explode", {
    Enabled = false,
    Callback = function(Value)
        
    end;
});

-- // Sound Abuse
local EarRape = SetupTextMenu(SoundAbuse, "Ear Rape", {
    Enabled = false,
    Callback = function(Value)
        
    end;
});

local PlayAllSounds = SetupTextMenu(SoundAbuse, "Play All Sounds", {
    Callback = function()
        
    end;
});

local PlayMusic = SetupTextMenu(SoundAbuse, "Play Music", {
    Callback = function()
        
    end;
});

local StopAllSounds = SetupTextMenu(SoundAbuse, "Stop All Sounds", {
    Callback = function()
        
    end;
});

local StopMusic = SetupTextMenu(SoundAbuse, "Stop Music", {
    Callback = function()
        
    end;
});

-- // Whitelist
local WhitelistSelectPlayer = SetupTextMenu(Whitelist, "Select Player", {
    Callback = function(Value)
        
    end;
});

local UnwhitelistPlayer = SetupTextMenu(Whitelist, "Unwhitelist Player", {
    Callback = function()
        
    end;
});

local WhitelistPlayer = SetupTextMenu(Whitelist, "Whitelist Player", {
    Callback = function()
        
    end;
});