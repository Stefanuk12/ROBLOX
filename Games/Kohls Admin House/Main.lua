if not getgenv()["KAHHax"] then getgenv()["KAHHax"] = {} end
KAHHax.Blacklist = {
    --[[
        Player = {
            {
                Phrase = ":cmds",
                Punishment = ":kill"
            }
        }
    ]]
}

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
        if count < 9 then
            CheckList["AdminPads"] = false
            CheckList["Total"] = false
        end
    end)
    return CheckList
end


function blacklistPhrase(Player, Phrase, Punishment)
    local count
    if not KAHHax["Blacklist"][Player] then 
        KAHHax["Blacklist"][Player] = {}
        count = 0 
    else
        count = #KAHHax["Blacklist"][Player]
    end
    KAHHax["Blacklist"][Player][count + 1] = {["Phrase"] = Phrase, ["Punishment"] = Punishment}
end

function removeBlacklistedPhrase(Player, Phrase)
    if KAHHax["Blacklist"][Player] then
        for i,v in pairs(KAHHax["Blacklist"][Player]) do
            if v.Phrase == Phrase then
                table.remove(KAHHax["Blacklist"][Player], i)
                print('Removed Blacklisted Phrase from - Player:', Player, "| Phrase:", Phrase)
            end
        end
    end
end

function intBlacklist(Player)
    if not KAHHax["Blacklist"][Player] then KAHHax["Blacklist"][Player] = {} end
    Player.Chatted:Connect(function(message)
        for i,v in pairs(KAHHax["Blacklist"][Player]) do
            if string.match(message, v.Phrase) then
                game:GetService("Players"):Chat(v.Punishment)
            end
        end
    end)
end

function deIntBlacklist(Player)
    for i,v in pairs(KAHHax["Blacklist"]) do
        if i == Player then
            table.remove(KAHHax["Blacklist"], i)
        end
    end
end

for _,v in pairs(game:GetService("Players"):GetPlayers()) do
    intBlacklist(v)
end

game:GetService("Players").PlayerAdded:Connect(function(Player)
    intBlacklist(Player)
end)

game:GetService("Players").PlayerRemoving:Connect(function(Player)
    intBlacklist(Player)
end)