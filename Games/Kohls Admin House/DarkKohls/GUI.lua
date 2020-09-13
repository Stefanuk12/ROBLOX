repeat wait() until game:IsLoaded();

-- // Initialise
if getgenv().DarkKohls then return getgenv().DarkKohls; end;
getgenv().DarkKohls = {
    MaterialLuaConfig = {
        Title = "Dark Kohls",
        Style = 3,
        SizeX = 500,
        SizeY = 350,
        Theme = "Dark",
    },
};

-- // Services
local Players = game:GetService("Players");
local HttpService = game:GetService("HttpService");

-- // Vars
loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Kohls%20Admin%20House/DarkKohls/API.lua"))()({
    Errors = false,
    ScriptName = "DarkKohls"
});

-- // GUI
local MaterialUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/MaterialLua/master/Module.lua"))();
local Material = MaterialUI.Load(DarkKohls.MaterialLuaConfig);
local GUIConfig = HttpService:JSONDecode(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Kohls%20Admin%20House/DarkKohls/GUIData.json"));
local Inputs = {
    {Name = "SelectedBlacklistedGear", nil}
};

-- // Automatically do some config
local function SetupTextMenu(Page, CommandName, Options)
    local Module = tostring(Page);
    local CommandConfig = GUIConfig[Module][CommandName];

    local Config = {
        Text = CommandConfig["Name"],
        Menu = {
            Infomation = function(self)
                local Description = CommandConfig["Description"];
                if (CommandConfig["Admin"] or CommandConfig["Persons299"]) then
                    Description = Description .. (CommandConfig["Persons299"] and " Person's 299 Admin is required" or " Admin is required.")
                end;

                Material.Banner({
                    Text = Description
                });
            end;
        }
    };

    for i,v in pairs(Options) do
        if (i ~= "Text" or i ~= "Menu") then
            Config[i] = v;
        end;
    end;

    local Object = Page[CommandConfig["Type"]](Config);

    return Object;
end;

-- // Get Input (internal)
local function getSetInput(InputName, InputValue)
    for i = 1, #Inputs do
        local v = Inputs[i];

        if (v.Name == InputName) then
            if (InputValue) then
                v.Value = InputValue;
            end;

            return true, v.Value;
        end;
    end;

    return false;
end;

-- // Failsafe commands
local function FailsafeCommand(Requirements)
    for i = 1, #Requirements do
        local v = Requirements[i];
        local Success, Value = getSetInput(v.Name);

        if (not Success) then
            return false, "Input is not a valid input.";
        else
            if (Value == nil) then
                return false, v.ErrorReason;
            end;
        end;
    end;

    return true;
end;

-- // Page Creation
local Pages = {};
local function createPage(PageName)
    local newPage = setmetatable(Material.New({Title = PageName}), {__tostring = function() return PageName; end;});
    Pages[#Pages + 1] = newPage;

    return newPage;
end;

-- // Create Pages
local Admin = createPage("Admin");
local Blacklist = createPage("Blacklist");
local Commands = createPage("Commands");
local Misc = createPage("Misc");
local Player = createPage("Player");
local Protections = createPage("Protections");
local Server = createPage("Server");
local SoundAbuse = createPage("SoundAbuse");
local Whitelist = createPage("Whitelist");

-- // Admin: Regenerate Admin
local RegenerateAdmin = SetupTextMenu(Admin, "RegenerateAdmin", {
    Callback = function()
        local Command, ErrorReason = KohlsAPI.Admin.RegenerateAdmin();

        if (not Command) then
            Material.Banner({
                Text = "Error: " .. ErrorReason
            });
        else
            Material.Banner({
                Text = "Successfully regenerated the admin pads."
            });
        end;
    end;
});

-- // Admin: Get Admin
local GetAdmin = SetupTextMenu(Admin, "GetAdmin", {
    Callback = function()
        local Command, ErrorReason = KohlsAPI.Admin.GetAdmin();

        if (not Command) then
            Material.Banner({
                Text = "Error: " .. ErrorReason
            });
        else
            Material.Banner({
                Text = "Successfully got admin."
            });
        end;
    end;
});

-- // Admin: Permanant Admin
local PermanantAdmin = SetupTextMenu(Admin, "PermanantAdmin", {
    Enabled = KohlsAPI.SettingGetSet("AdminPermanantAdmin"),
    Callback = function(Value)
        KohlsAPI.SettingGetSet("AdminPermanantAdmin", Value);

        if (Value) then
            KohlsAPI.Admin.GetAdmin(KohlsAPI.SelectedPad);
        end;
    end;
});

-- // Blacklist: Blacklist Gear
local BlacklistGear = SetupTextMenu(Blacklist, "BlacklistGear", {
    Callback = function()
        -- // Failsafe command
        local FailsafeSuccess, FailsafeSuccessErrorReason = FailsafeCommand({
            {
                InputName = "SelectedBlacklistedGear",
                ErrorReason = "Please specify a gear to blacklist."
            }
        });
        if (not FailsafeSuccess) then
            Material.Banner({
                Text = FailsafeSuccessErrorReason;
            })
        end;

        -- // Get the input and failsafing
        local SelectedGearSuccess, SelectedGear = getSetInput("SelectedBlacklistedGear");
        if (not SelectedGearSuccess) then
            local ErrorReason = "This gear is not blacklisted.";

            Material.Banner({
                Text = ErrorReason
            });

            return false, ErrorReason;
        end;

        -- // Blacklist the gear and failsafing
        local BlacklistGearSuccess, ErrorReason = KohlsAPI.Blacklist.BlacklistUnblacklistGear(SelectedGear);
        if (not BlacklistGearSuccess) then
            Material.Banner({
                Text = ErrorReason;
            });
        else
            Material.Banner({
                Text = "Successfully blacklisted gear.";
            });
        end;
    end;
});

-- // Blacklist: Unblacklist Gear
local UnblacklistGear = SetupTextMenu(Blacklist, "UnblacklistGear", {
    Callback = function()
        -- // Failsafe command
        local FailsafeSuccess, FailsafeSuccessErrorReason = FailsafeCommand({
            {
                InputName = "SelectedBlacklistedGear",
                ErrorReason = "Please specify a gear to blacklist."
            }
        });
        if (not FailsafeSuccess) then
            Material.Banner({
                Text = FailsafeSuccessErrorReason;
            })
        end;

        -- // Get the input and failsafing
        local SelectedGearSuccess, SelectedGear = getSetInput("SelectedBlacklistedGear");
        if (not SelectedGearSuccess) then
            local ErrorReason = "This gear is already blacklisted.";

            Material.Banner({
                Text = ErrorReason
            });

            return false, ErrorReason;
        end;

        -- // Unblacklist the gear and failsafing
        local BlacklistGearSuccess, ErrorReason = KohlsAPI.Blacklist.BlacklistUnblacklistGear(SelectedGear, true);
        if (not BlacklistGearSuccess) then
            Material.Banner({
                Text = ErrorReason;
            });
        else
            Material.Banner({
                Text = "Successfully Unblacklisted gear.";
            });
        end;
    end;
});

-- // Blacklist: Alert Blacklisted Gear Use

-- // Blacklist: Blacklist Phrase

-- // Blacklist: Unblacklist Phrase

-- // Commands: Say Phrase

-- // Commands: Spam Phrase

-- // Commands: Stop Spam Phrase

-- // Misc: Paint Area

-- // Misc: Rejoin

-- // Misc: Shutdown GUI

-- // Player: Get Age

-- // Player: Give Client BTools

-- // Protecitons: Anti Blind

-- // Protections: Anti Jail

-- // Protections: Anti Kill

-- // Protections: Anti Punish

-- // Server: Alert C System Use

-- // Server: Crash Server

-- // Server: Create Phantom Baseplate

-- // Server: Epilepsy

-- // Server: Move Baseplate

-- // Server: Part Spam

-- // Server: Remove Phantom Baseplates

-- // Server: Respawn Explode

-- // Server: Click Spawn Water

-- // Sound Abuse: Ear Rape

-- // Sound Abuse: Play All Sounds

-- // Sound Abuse: Play Music

-- // Sound Abuse: Stop All Sounds

-- // Sound Abuse: Stop Music

-- // Whitelist: Whitelist Player

-- // Whitelist: Unwhitelist Player