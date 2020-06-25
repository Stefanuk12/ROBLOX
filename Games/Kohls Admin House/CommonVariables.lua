if not getgenv()["KAHHax"] then getgenv()["KAHHax"] = {} end
if not KAHHax.CommonVars then return end

local GameFolder = game:GetService("Workspace"):WaitForChild("Terrain"):WaitForChild("_Game")
KAHHax["vars"] = {
    Players = game:GetService("Players"),
    PlayerManager = {--[[
        PlayerUID = {
            Lagging = true,
            SpamList = {},
            BlacklistedPhrases = {},
            BlacklistConnection = {},
        },
    ]]},
    Chat = function (...) game:GetService("Players"):Chat(...) end,
    GameFolder = GameFolder,
    AdminFolder = GameFolder:WaitForChild("Admin"),
    PadFolder = GameFolder:WaitForChild("Admin"):WaitForChild("Pads"),
    WorkspaceFolder = GameFolder:WaitForChild("Workspace"),
    HolderFolder = GameFolder:WaitForChild("Folder"),
    Pads = GameFolder:WaitForChild("Admin"):WaitForChild("Pads"),
    Obby = GameFolder["Workspace"].Obby,
    LocalPlayer = game:GetService("Players").LocalPlayer,
    Character = game:GetService("Players").LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait(),
    RainbowColor = Color3.fromRGB(0, 0, 0),
    getPlayer = getPlayer,
    WhitelistedUsers = {91318356},
    Alert = warn,
    Notify = print,
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
    },
    SpamList = {},
    Prefix = ":",
    MusicAPI = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Music%20API/Controller.lua"))(),
}
vars = KAHHax.vars
local vars = KAHHax["vars"]
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
    for _,v in pairs(vars.WhitelistedUsers) do
        if UserId == v then
            return true
        end
    end
    return false
end

function KAHHax.vars.checkAllWhitelisted()
    for _,v in pairs(vars.Players:GetPlayers()) do
        for _,x in pairs(vars.WhitelistedUsers) do
            if v ~= vars.LocalPlayer and v.UserId == x then
                return true
            end
        end
    end
    return false
end

function KAHHax.vars.addPlayerToManager(Player)
    if typeof(Player) == 'Instance' and Player.Parent == vars.Players then
        vars.PlayerManager[Player.Name] = {
            ["Lagging"] = false,
            ["SpamList"] = {},
            ["BlacklistedPhrases"] = {},
            ["BlacklistConnection"] = {},
        }
        for i,v in pairs(vars.WhitelistedUsers) do
            if Player.UserId == v then
                vars.PlayerManager[Player.Name]["Whitelisted"] = true
            else
                vars.PlayerManager[Player.Name]["Whitelisted"] = false
            end
        end
        vars.PlayerManager[Player.Name].BlacklistConnection.A = Player.Chatted:Connect(function(message)
            for i,v in pairs(vars.PlayerManager[Player.Name].BlacklistedPhrases) do
                if string.match(message, v.Phrase) then
                    vars.Chat(v.Punishment)
                end
            end
        end)
        vars.Notify(Player.Name, "has joined and added to the PlayerManager.")
    end
end

function KAHHax.vars.removePlayerFromManager(Player)
    if typeof(Player) == 'Instance' and Player.Parent == vars.Players and vars.PlayerManager[Player.Name] then
        count = 0
        for i,v in pairs(vars.PlayerManager) do
            count = count + 1
            if i == Player.Name then
                for a,x in pairs(v.BlacklistConnection) do
                    if typeof(x) == "RBXScriptConnection" then
                        x:Disconnect()
                    end
                end
                table.remove(vars.PlayerManager, count)
                vars.Notify(Player.Name, "has left and been removed from the PlayerManager.")
                break
            end
        end
    end
end
wait(0.5)

-- // Player Manager
for i,v in pairs(vars.Players:GetPlayers()) do
    vars.addPlayerToManager(v)
end

vars.Players.PlayerAdded:Connect(function(player)
    vars.addPlayerToManager(player)
end)

vars.Players.PlayerRemoving:Connect(function(player)
    vars.removePlayerFromManager(player)
end)

-- // Rainbow Color
coroutine.wrap(function()
    while wait() do
        vars.RainbowColor = Color3.fromHSV(tick() % 5 / 5, 1, 1)
    end
end)()
    
KAHHax.CommonVars = true

return vars