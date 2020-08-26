-- // Credit to Kinlei for the UI Library: MaterialLUA.

-- // Services
local Players = game:GetService("Players");
local HttpService = game:GetService("HttpService");
local Workspace = game:GetService("Workspace");
local MarketplaceService = game:GetService("MarketplaceService");
local TeleportService = game:GetService("TeleportService");

-- // Vars
local GameFolder = Workspace.Terrain["_Game"];
local LocalPlayer = Players.LocalPlayer;
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
local MusicAPI = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Music%20API/Controller2.lua"))();

-- // Settings + Command Info
local CommandInfo = HttpService:JSONDecode(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Kohls%20Admin%20House/Data.json"));
local musicTable = MusicAPI.CheckAllSounds();
local MusicTable = {};

for i = 1, #musicTable do
    local v = musicTable[i];
    table.insert(MusicTable, v["Name"]);
end;

local Settings = {
    AdminPermanantAdmin = false,
    ProtectionsAntiBlind = false,
    ProtectionsAntiJail = false,
    ProtectionsAntiKill = false,
    ProtectionsAntiPunish = false,
    SoundAbuseEarRape = false,
    MusicCommandsSelectSound = "Not selected",
    BlacklistSelectGearId = "Not selected",
    BlacklistSelectPhrase = "Not selected",
    BlacklistSelectPhrase = "Not selected",
    CommandsSelectPhrase = "Not selected",
    MiscSelectPaintColour = "Not selected",
    PlayerSelectPlayer = "Not selected",
    WhitelistSelectPlayer = "Not selected"
};
if (writefile) then
    if (not isfile("oofkohlsSettings.json")) then
        writefile("oofkohlsSettings.json", tostring(HttpService:JSONEncode(Settings)));
    end;
    local SettingsHolder = HttpService:JSONDecode(readfile("oofkohlsSettings.json"));
    for i,v in pairs(Settings) do -- // Make it so you can add new settings
        if (not SettingsHolder[i]) then
            SettingsHolder[i] = v;
        end;
    end;
    Settings = SettingsHolder;
    writefile("oofkohlsSettings.json", HttpService:JSONEncode(Settings) );
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
    local v = GetPlayers[i];
    table.insert(PlayerTable, v.Name);
end;

Players.PlayerAdded:Connect(function(plr)
    table.insert(PlayerTable, plr.Name);
    updateDropdownPlayers();
end);

Players.PlayerRemoving:Connect(function(plr)
    for i = 1, #PlayerTable do
        local v = PlayerTable[i];
        if (v == plr.Name)then
            table.remove(PlayerTable, i);
        end;
    end;
    updateDropdownPlayers();
end);

-- // Update any Dropdowns that use the PlayerTable when the PlayerTable updates
function updateDropdownPlayers()
    for i = 1, #DropdownPlayers do
        local v = DropdownPlayers[i];
        v.SetOptions(PlayerTable);
    end;
end;

-- // Check if a Player is admin
function isAdmin(Player)
	local targetPlayer = Players:GetUserIdFromNameAsync(Player);
	if (MarketplaceService:UserOwnsGamePassAsync(targetPlayer, 66254)) then return true; end;
    local Pads = GameFolder["Admin"]["Pads"]:GetChildren();
    for i = 1, #Pads do
        local v = Pads[i];
        if (v.Name == Player .. "'s admin") then return true; end;
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

-- // Failsafing commadns
function FailSafeCommand(Page, CommandName, ...)
    local Module = tostring(Page)
    local ComamndInfoTableModule = CommandInfo[Module];
    local ComamndInfoTable = ComamndInfoTableModule[CommandName];
    local SelectionArgs = {...};

    -- // Admin checking
    if (ComamndInfoTable["Admin"] and not isAdmin(LocalPlayer.Name)) then
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
        Creation.Options = PlayerTable;
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
        if (firetouchinterest or true) then
            firetouchinterest(Character.HumanoidRootPart, TargetPad.Head, 0); -- // doesn't work on synap(sex) :(
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
        if (not fireclickdetector) then
            Material.Banner({
				Text = "Your exploit does not support this feature."
			});
            return;
        end;
        fireclickdetector(GameFolder["Admin"].Regen.ClickDetector, 0);
        Material.Banner({
			Text = "Regenerated admin."
		});
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
        Settings["BlacklistSelectGearId"] = Value;
    end;
});

local BlacklistSelectPhrase = SetupTextMenu(Blacklist, "Select Phrase", {
    Callback = function(Value)
        Settings["BlacklistSelectPhrase"] = Value;
    end;
});

local BlacklistSelectPlayer = SetupTextMenu(Blacklist, "Select Player", {
    Callback = function(Value)
        Settings["BlacklistSelectPlayer"] = Value;
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
    end;
});

local BlacklistPhrase = SetupTextMenu(Blacklist, "Blacklist Phrase", {
    Callback = function()
        local FailSafeResult = FailSafeCommand(Blacklist, "Blacklist Phrase", {
            {
                Requirement = Settings["BlacklistPhrase"],
                Error = "Please input a phrase."
            };
        });
        if (not FailSafeResult) then return; end;
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
    end;
});

local UnblacklistPhrase = SetupTextMenu(Blacklist, "Unblacklist Phrase", {
    Callback = function()
        local FailSafeResult = FailSafeCommand(Blacklist, "Unblacklist Phrase", {
            {
                Requirement = Settings["BlacklistPhrase"],
                Error = "Please input a phrase."
            };
        });
        if (not FailSafeResult) then return; end;
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

local SpamPhrase = SetupTextMenu(Commands, "Spam Phrase", {
    Callback = function()
        local FailSafeResult = FailSafeCommand(Commands, "Spam Phrase", {
            {
                Requirement = Settings["CommandsSelectPhrase"],
                Error = "Please input a phrase."
            }
        });
        if (not FailSafeResult) then return; end;
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
    end;
});

-- // Misc
local MiscSelectPaintColour = SetupTextMenu(Misc, "Select Paint Colour", {
    Default = Color3.fromRGB(255, 150, 150);
    Callback = function(Value)
        Settings["MiscSelectPaintColour"] = Value;
    end;
});

local PaintArea = SetupTextMenu(Misc, "Paint Area", {
    Callback = function()
        local FailSafeResult = FailSafeCommand(Misc, "Select Paint Colour", {
            {
                Requirement = Settings["MiscSelectPaintColour"],
                Error = "Please input a colour."
            }
        });
        if (not FailSafeResult) then return; end;
    end;
});

local Rejoin = SetupTextMenu(Misc, "Rejoin", {
    Callback = function()
        TeleportService:Teleport(game.PlaceId);
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
				Text = "Your exploit does not support this feature."
			});
        end;
    end;
});

-- // Music Commands
local SelectSound = SetupTextMenu(MusicCommands, "Select Sound", {
    Options = MusicTable,
    Callback = function(Value)       
        Settings["MusicCommandsSelectSound"] = musicTable[table.find(MusicTable, Value)].SoundId;
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
            table.insert(MusicTable, v["Name"]);
        end;
        
        SelectSound.SetOptions(MusicTable);
        
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

local GetAge = SetupTextMenu(Player, "Get Age", {
    Callback = function()
        local FailSafeResult = FailSafeCommand(Player, "Get Age", {
            {
                Requirement = Settings["PlayerSelectPlayer"],
                Error = "Please select a player."
            }
        });
        if (not FailSafeResult) then return; end;
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
    end;
});

local GiveGear = SetupTextMenu(Player, "Give Gear", {
    Callback = function()
        local FailSafeResult = FailSafeCommand(Player, "Give Gear", {
            {
                Requirement = Settings["PlayerSelectPlayer"],
                Error = "Please select a player."
            }
        });
        if (not FailSafeResult) then return; end;
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
    end;
});

-- // Protections
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
local SoundAbuseEarRape = SetupTextMenu(SoundAbuse, "Ear Rape", {
    Enabled = false,
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
        local Sound = GameFolder:FindFirstChildWhichIsA("Sound");
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
        local Sound = GameFolder:FindFirstChildWhichIsA("Sound");
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
                Requirement = Settings["PlayerSelectPlayer"],
                Error = "Please select a player."
            }
        });
        if (not FailSafeResult) then return; end;
    end;
});

local WhitelistPlayer = SetupTextMenu(Whitelist, "Whitelist Player", {
    Callback = function()
        local FailSafeResult = FailSafeCommand(Whitelist, "Whitelist Player", {
            {
                Requirement = Settings["PlayerSelectPlayer"],
                Error = "Please select a player."
            }
        });
        if (not FailSafeResult) then return; end;
    end;
});