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
local Backpack = LocalPlayer.Backpack;
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
local MusicAPI = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Music%20API/Controller2.lua"))();
local WorkspaceFolder = GameFolder["Workspace"];

-- // Settings + Command Info
local CommandInfo = HttpService:JSONDecode(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Kohls%20Admin%20House/Data.json"));
local musicTable = MusicAPI.CheckAllSounds();
local MusicTable = {};

for i = 1, #musicTable do
    local v = musicTable[i];
    table.insert(MusicTable, v["Name"]);
end;

local GearGiverGears = {

};
local GearGiverGearNames = {};
for i, _ in pairs(Gears) do
    table.insert(GearGiverGearNames, i);
end;

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
    MusicCommandsSelectSound = "Not selected",
    BlacklistSelectGearId = "Not selected",
    BlacklistSelectPhrase = "Not selected",
    BlacklistSelectPhrase = "Not selected",
    CommandsSelectPhrase = "Not selected",
    MiscSelectPaintColour = "Not selected",
    MiscSelectPaintArea = "Not selected",
    PlayerSelectPlayer = "Not selected",
    PlayerSelectGear = "Not selected",
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
        local TargetPad = GameFolder["Admin"]["Pads"]:FindFirstChild("Touch to get admin").Head;
        if (firetouchinterest and false) then
            firetouchinterest(Character.HumanoidRootPart, TargetPad, 0); -- // doesn't work on synap(sex) :(
        else
            local savedPos = Character.HumanoidRootPart.CFrame;
            Character:SetPrimaryPartCFrame(TargetPad.CFrame);
            wait(1);
            Character:SetPrimaryPartCFrame(savedPos);
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

local MiscSelectPaintArea = SetupTextMenu(Misc, "Select Painting Area", {
    Options = {
        "All",
        "Admin Dividers",
        "Basic House",
        "Obby",
        "Building Bricks",
        "Obby Box",
    }
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
        if (not ( Backpack:FindFirstChild("PaintBucket") or Character:FindFirstChild("PaintBucket") )) then
            Players:Chat(":gear me 18474459");
        end;
        Backpack:WaitForChild("PaintBucket");
        Character.Humanoid:EquipTool(Backpack.PaintBucket);
        Character:WaitForChild("PaintBucket");

        -- // Painting
        local Remote = Character:WaitForChild("PaintBucket"):WaitForChild("Remotes"):WaitForChild("ServerControls");
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

        Players:Chat(":gear " .. Settings["PlayerSelectPlayer"] .. "16200204");
        Players:Chat(":gear " .. Settings["PlayerSelectPlayer"] .. "16200402");
        Players:Chat(":gear " .. Settings["PlayerSelectPlayer"] .. "16969792");
        Players:Chat(":gear " .. Settings["PlayerSelectPlayer"] .. "73089190");
        Players:Chat(":gear " .. Settings["PlayerSelectPlayer"] .. "21001552");
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

        Players:Chat(":gear " .. Settings["PlayerSelectPlayer"] .. " " .. GearGiverGears[Settings["PlayerSelectGear"]]);
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
        Players:Chat(":gear me 94794847");
        LocalPlayer.Backpack:WaitForChild("VampireVanquisher");
        Character.Humanoid:EquipTool(LocalPlayer.Backpack.VampireVanquisher);
        Character:WaitForChild("VampireVanquisher");
        for i = 1, 3 do
            Players:Chat(":size me .3");
            wait(1);
        end;
    end;
});

local CreatePhantomBaseplate = SetupTextMenu(Server, "Create Phantom Baseplate", {
    Enabled = false,
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
    Enabled = false,
    Callback = function(Value)
        Settings["ServerEpilepsy"] = Value;
    end;
});

local LagServer = SetupTextMenu(Server, "Lag Server", {
    Enabled = false,
    Callback = function(Value)
        Settings["ServerLagServer"] = Value;
    end;
});

local MoveBaseplate = SetupTextMenu(Server, "Move Baseplate", {
    Enabled = false,
    Callback = function()
        local Spawn = WorkspaceFolder.Spawn3;
        local Baseplate = WorkspaceFolder.Baseplate;

        local testCFrame = Baseplate.CFrame;
        local testPosition = Spawn.Position;
        local X, Y, Z, R00, R01, R02, R10, R11, R12, R20, R21, R22 = testCFrame:GetComponents();
        local X, Y, Z = testPosition.X, Y + 1, testPosition.Z;
        local newCFrame = CFrame.new(X, Y, Z, R00, R01, R02, R10, R11, R12, R20, R21, R22);
        
        Character.HumanoidRootPart.CFrame = newCFrame;
        wait(1.5);
        Players:Chat(":stun me");
        Material.Banner({
			Text = "Put you in the position to move the baseplate."
		});
    end;
});

local PartSpam = SetupTextMenu(Server, "Part Spam", {
    Enabled = false,
    Callback = function(Value)
        Settings["ServerPartSpam"] = Value;
    end;
});

local RemovePhantomBaseplate = SetupTextMenu(Server, "Remove Phantom Baseplates", {
    Enabled = false,
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
    Enabled = false,
    Callback = function(Value)
        Settings["ServerRespawnExplode"] = Value;
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