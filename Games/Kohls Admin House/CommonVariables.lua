if not getgenv()["KAHHax"] then getgenv()["KAHHax"] = {} end
local GameFolder = game:GetService("Workspace"):WaitForChild("Terrain"):WaitForChild("_Game")

function getPlayer(String)
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

function checkWhitelisted(UserId)
    for _,v in pairs(KAHHax["vars"].WhilelistedUsers) do
        if UserId == v then
            return true
        end
    end
    return false
end

function checkAllWhitelisted()
    for _,v in pairs(KAHHax["vars"].Players:GetPlayers()) do
        for _,x in pairs(KAHHax["vars"].WhilelistedUsers) do
            if v ~= KAHHax["vars"].LocalPlayer and v.UserId == x then
                return true
            end
        end
    end
    return false
end


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
    WhilelistedUsers = {91318356},
    checkWhitelisted = checkWhitelisted,
    checkAllWhitelisted = checkAllWhitelisted,
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
    MusicAPI = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Music%20API/Controller.lua"))().
}
-- // Player Manager
function addPlayerToManager(Player)
    if typeof(Player) == 'Instance' and Player.Parent == KAHHax["vars"].Players then
        KAHHax["vars"].PlayerManager[Player.UserId] = {
            ["Lagging"] = false,
            ["SpamList"] = {},
            ["BlacklistedPhrases"] = {},
            ["BlacklistConnection"] = {},
        }
        for i,v in pairs(KAHHax["vars"].WhilelistedUsers) do
            if Player.UserId == v then
                KAHHax["vars"].PlayerManager[Player.UserId]["Whitelisted"] = true
            else
                KAHHax["vars"].PlayerManager[Player.UserId]["Whitelisted"] = false
            end
        end
    end
end

function removePlayerFromManager(Player)
    if typeof(Player) == 'Instance' and Player.Parent == KAHHax["vars"].Players and KAHHax["vars"].PlayerManager[Player.UserId] then
        count = 0
        for i,v in pairs(KAHHax["vars"].PlayerManager) do
            count = count + 1
            if i == Player.UserId then
                for a,x in pairs(v.BlacklistConnection) do
                    if typeof(x) == "RBXScriptConnection" then
                        x:Disconnect()
                    end
                end
                table.remove(KAHHax["vars"].PlayerManager, count)
                break
            end
        end
    end
end

for i,v in pairs(KAHHax["vars"].Players:GetPlayers()) do
    addPlayerToManager(v)
end

KAHHax["vars"].PlayerAdded:Connect(function(player)
    addPlayerToManager(player)
end)

KAHHax["vars"].PlayerRemoving:Connect(function(player)
    removePlayerFromManager(player)
end)

-- // Rainbow Color
coroutine.wrap(function()
    while wait() do
        KAHHax["vars"].RainbowColor = Color3.fromHSV(tick() % 5 / 5, 1, 1)
    end
end)()

return KAHHax["vars"]