repeat wait() until game:IsLoaded();

-- // Initialise
if getgenv().DarkKohls then return getgenv().DarkKohls; end;
getgenv().DarkKohls = {
    MaterialLuaConfig = {
        Title = "Dark Kohls",
        Style = 3,
        SizeX = 500,
        SizeY = 350,
        Theme = "Light",
        ColorOverrides = {
            MainFrame = Color3.fromRGB(235,235,235)
        }
    },
};

-- // Services
local Players = game:GetService("Players");
local HttpService = game:GetService("HttpService");

-- // Vars
local KohlsAPI = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Kohls%20Admin%20House/DarkKohls/API.lua"))()({
    Errors = false,
    ScriptName = "DarkKohls"
});

-- // GUI
local MaterialUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/MaterialLua/master/Module.lua"))();
local Material = MaterialUI.Load(DarkKohls.MaterialLuaConfig);
local GUIConfig = HttpService:JSONDecode(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Kohls%20Admin%20House/DarkKohls/GUIData.lua"));
local Inputs = {

};

-- // Automatically do some config
local function SetupTextMenu(Page, CommandName, Options)
    local Module = tostring(Page);
    local CommandConfig = GUIConfig[Module][CommandName];

    local Config = {
        Text = CommandConfig["Name"],
        Menu = {
            Infomation = function()
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
        end;;
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
        KohlsAPI.SettingGetSet("AdminPermanantAdmin", Value)
    end;
});

-- // Blacklist: Blacklist Gear

-- // Blacklist: Unblacklist Gear

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