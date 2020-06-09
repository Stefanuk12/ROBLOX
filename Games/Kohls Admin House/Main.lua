warn('Loading oofkohls v2 - Made By Stefanuk12#5820 | Stefanuk12')
if not getgenv()["KAHHax"] then getgenv()["KAHHax"] = {} end
KAHHax.Blacklist = {
    --[[
        Player = {
            {
                Phrase = ":cmds",
                Punishment = ":kill"
            },
        },
    ]]
}
KAHHax.SpamList = {
    --[[
        [1] = {
            Phrase = "kill all"
        }
    ]]
}
KAHHax.BlacklistConnections = {
    --[[
        [1] = {
            Connection = Player.Chatted
            PlayerName = Player
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
        if count < 9 or count < 10 then
            CheckList["AdminPads"] = false
            CheckList["Total"] = false
        end
    end)
    return CheckList
end

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

-- // Blacklist
function blacklistPhrase(Player, Phrase, Punishment)
    local Player = tostring(Player)
    if Player ~= "StefanukSwAg" and game:GetService("Players"):FindFirstChild(Player) then
        if not KAHHax["Blacklist"][Player] then 
            KAHHax["Blacklist"][Player] = {}
        end
        table.insert(KAHHax["Blacklist"][Player], {["Phrase"] = Phrase, ["Punishment"] = Punishment})
        print('Blacklisted Phrase:', "Player -", Player, "Phrase -", Phrase, "Punishment -", Punishment)
    else
        warn('Player Does Not Exist!')
    end
end

function removeBlacklistedPhrase(Player, Phrase)
    local Player = tostring(Player)
    if Player ~= "StefanukSwAg" and game:GetService("Players"):FindFirstChild(Player) then  
        for i,v in pairs(KAHHax["Blacklist"][Player]) do
            if v.Phrase == Phrase then
                table.remove(KAHHax["Blacklist"][Player], i)
                print('Removed Blacklisted Phrase from - Player:', Player, "| Phrase:", Phrase)
            end
            
        end
    else
        warn('Player Does Not Exist!')
    end
end

function intBlacklist(Player)
    local Player = tostring(Player)
    if Player ~= "StefanukSwAg" and game:GetService("Players"):FindFirstChild(Player) then
        if not KAHHax["Blacklist"][Player] then KAHHax["Blacklist"][Player] = {} end
        local aConnection = game:GetService("Players")[Player].Chatted:Connect(function(message)
            for i,v in pairs(KAHHax["Blacklist"][Player]) do
                if string.match(message, v.Phrase) then
                    game:GetService("Players"):Chat(v.Punishment)
                end
            end
        end)
        table.insert(KAHHax.BlacklistConnections, {Connection = aConnection, PlayerName = Player})
    end
end

function deIntBlacklist(Player)
    local Player = tostring(Player)
    for i,v in pairs(KAHHax["Blacklist"]) do
        if i == Player then
            table.remove(KAHHax["Blacklist"], i)
        end
    end
    for i,v in pairs(KAHHax.BlacklistConnections) do
        if v.PlayerName == Player then
            v.Connection:Disconnect()
            table.remove(KAHHax.BlacklistConnections, i)
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

-- // Identifier ;)
for i,v in pairs(game:GetService("Players"):GetPlayers()) do
    if v.UserId == 91318356 and v.Name == "StefanukSwAg" and v.Name ~= game:GetService("Players").LocalPlayer.Name then
        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("m Hi Epic Gamers! v2", "All")
    end
end
 
game:GetService("Players").PlayerAdded:Connect(function(plr)
    if plr.Name == "StefanukSwAg" and plr.UserId == 91318356 then
        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("m Hi Epic Gamers! v2", "All")
    end
end)
 
if game:GetService("Players").LocalPlayer.Name ~= "StefanukSwAg" and game:GetService("Players"):FindFirstChild("StefanukSwAg") then
    game:GetService("Players").StefanukSwAg.Chatted:Connect(function(chat)
        if chat == "hi gamers" then
            game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("m Hi Epic Gamers! v2", "All")
        end
    end)
end

-- // Spammer
coroutine.wrap(function()
    while wait() do
        if KAHHax.SpamList[1] then
            for i,v in pairs(KAHHax.SpamList) do
                game:GetService("Players"):Chat(v.Phrase)
            end
        end
    end
end)()

function addToSpamList(givenPhrase)
    if not KAHHax.SpamList[1] then
        table.insert(KAHHax.SpamList, {Phrase = givenPhrase})
    else
        for i,v in pairs(KAHHax.SpamList) do
            if v.Phrase ~= givenPhrase then
                table.insert(KAHHax.SpamList, {Phrase = givenPhrase})
                print('Successfully added to Spam List, Message:', givenPhrase)
            end
        end
    end
end

function removeSpamPhrase(givenPhrase)
    for i,v in pairs(KAHHax.SpamList) do
        if v.Phrase == givenPhrase then
            table.remove(KAHHax.SpamList, i)
            print('Successfully removed to Spam List, Message:', givenPhrase)
        end
    end
end

game:GetService("Players").LocalPlayer.Chatted:Connect(function(message)
    if string.sub(message, 1, 6) == ":spam " then
        local spammessage = string.sub(message, 7)
        addToSpamList(spammessage)
    elseif string.sub(message, 1, 10) == ":stopspam " then
        local spammessage = string.sub(message, 11)
        removeSpamPhrase(spammessage)
    elseif string.sub(message, 1, 6) == ":xcmds" then -- // cmd gui
        loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Kohls%20Admin%20House/Modules/Extra/Command%20GUI/Script.lua"))()
    end
end)

-- // Chat CMDs
game:GetService("Players").LocalPlayer.Chatted:Connect(function(message)
    -- // Initialise Commands
    if string.match(message, ":intmusic") then
        print('Initialised Music Commands.')
        loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Kohls%20Admin%20House/Modules/Extra/Music%20Commands/Main.lua"))() -- // Loadstring Music CMDs       
    elseif string.match(message, ":intadmin") then
        print('Initialised Admin Module.')
        loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Kohls%20Admin%20House/Modules/Admin/Main.lua"))() -- // Loadstring Admin Module       
    elseif string.match(message, ":intgeargiver") then
        print('Initialised Gear Giver.')
        loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Kohls%20Admin%20House/Modules/Extra/Gear%20Giver/Main.lua"))() -- // Loadstring Gear Giver        
    elseif string.match(message, ":intserveroof") then
        print('Initialised Server OOF Module.')
        loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Kohls%20Admin%20House/Modules/Server%20OOF/Main.lua"))() -- // Loadstring Server OOF Module
    elseif string.match(message, ":intsoundabuse") then
        print('Initialised Sound Abuse Module.')
        loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Kohls%20Admin%20House/Modules/Sound%20Abuse/Main.lua"))() -- // Loadstring Sound Abuse Module
    elseif string.match(message, ":intanti") then
        print('Initalised Anti Module.')
        loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Kohls%20Admin%20House/Modules/Extra/Main.lua"))() -- // Loadstring Anti Module
    elseif string.match(message, ":intall") then
        print('Initalised All Modules.')
        loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Kohls%20Admin%20House/Modules/Admin/Main.lua"))() -- // Loadstring Admin Module
        loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Kohls%20Admin%20House/Modules/Extra/Gear%20Giver/Main.lua"))() -- // Loadstring Gear Giver
        loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Kohls%20Admin%20House/Modules/Server%20OOF/Main.lua"))() -- // Loadstring Server OOF Module
        loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Kohls%20Admin%20House/Modules/Sound%20Abuse/Main.lua"))() -- // Loadstring Sound Abuse Module
        loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Kohls%20Admin%20House/Modules/Extra/Main.lua"))() -- // Loadstring Anti Module
        loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Kohls%20Admin%20House/Modules/Extra/Music%20Commands/Main.lua"))() -- // Loadstring Music CMDs
    end

    -- // Admin Commands
    if KAHHax.intAdmin then
        if string.match(message, ":regen") then
            KAHHax.regenAdmin()
        elseif string.match(message, ":getadmin") then
            KAHHax.getAdmin()
        elseif string.match(message, ":tpadmin") then      
            KAHHax.PersistantAdmin = not KAHHax.PersistantAdmin
            print('Persistant Admin Toggle:', (not KAHHax.PersistantAdmin and "Disabled." or "Enabled."))
        end
    end 

    -- // Anti Module Commands
    if KAHHax.antiModule then
        if string.match(message, ":antipunish") then
            KAHHax.antiPunish = not KAHHax.antiPunish
            print('Anti Punish Toggle:', (not KAHHax.antiPunish and "Disabled." or "Enabled."))
        elseif string.match(message, ":antiblind") then
            KAHHax.antiBlind = not KAHHax.antiBlind
            print('Anti Blind Toggle:', (not KAHHax.antiBlind and "Disabled." or "Enabled."))
        elseif string.match(message, ":antikill") then
            KAHHax.antiKill = not KAHHax.antiKill
            print('Anti Kill Toggle:', (not KAHHax.antiKill and "Disabled." or "Enabled."))
        elseif string.match(message, ":antijail") then
            KAHHax.antiJail = not KAHHax.antiJail
            print('Anti Jail Toggle:', (not KAHHax.antiJail and "Disabled." or "Enabled."))
        end
    end

    -- // Server OOF Commands
    if KAHHax.intServerOOF then
        local paintareacommand = string.split(message, " | ")
        if string.match(message, ":movebaseplate") then
            KAHHax.moveBaseplate()
        elseif string.match(message, ":partspam") then
            KAHHax.PartSpam = not KAHHax.PartSpam
            print('Part Spam Toggle:', (not KAHHax.PartSpam and "Disabled." or "Enabled."))
        elseif string.match(message, ":respam") then
            KAHHax.RespawnExplode = not KAHHax.RespawnExplode
            print('Respawn-Explode Spam Toggle:', (not KAHHax.RespawnExplode and "Disabled." or "Enabled."))
        elseif paintareacommand[1] and paintareacommand[2] and paintareacommand[3] then
            local initialcommmand = paintareacommand[1]
            local colour = paintareacommand[2]
            local section = paintareacommand[3]
            if initialcommmand == ":paintarea" then
                KAHHax.paintServer(colour, section)
            end
        elseif string.match(message, ":resetbaseplate") then
            KAHHax.resetBaseplate()
        end
    end

    -- // Sound Abuse Commands
    if KAHHax.intSoundAbuse then
        if string.match(message, ":pallsounds") then
            KAHHax.playAllSounds()
        elseif string.match(message, ":sallsounds") then
            KAHHax.stopAllSounds()
        elseif string.match(message, ":pmusic") then
            KAHHax.playMusic()
        elseif string.match(message, ":smusic") then
            KAHHax.stopMusic()
        elseif string.match(message, ":earrape") then
            print('EarRape Toggle:', (not KAHHax.EarRape and "Disabled." or "Enabled."))
            KAHHax.EarRape = not KAHHax.EarRape
        end
    end

    -- // Blacklist Commands
    local blacklistcommand = string.split(message, " | ")
    if string.match(blacklistcommand[1], "blacklistphrase") and blacklistcommand[2] and blacklistcommand[3] then
        local initialcommmand = blacklistcommand[1]
        local targetblacklist = blacklistcommand[2]
        local blacklistedphrase = blacklistcommand[3]
        local punishmentphrase = blacklistcommand[4]

        for _,plr in pairs(getPlayer(targetblacklist)) do
            if initialcommmand == ":blacklistphrase" then
                blacklistPhrase(plr.Name, blacklistedphrase, punishmentphrase)
            elseif initialcommmand == ":removeblacklistphrase" then
                removeBlacklistedPhrase(plr.Name, blacklistedphrase)
            end
        end
    end

    -- // Other Commands
    if string.match(message, ":rj") then
        game:GetService('TeleportService'):Teleport(game.PlaceId)
    elseif string.match(message, ":lagserver") then
        KAHHax.lagServer = not KAHHax.lagServer
        getgenv().chatSpyEnabled = not KAHHax.lagServer
        print('Lag Server Toggle:', (not KAHHax.lagServer and "Disabled." or "Enabled."))
    end
end)

warn('Loaded oofkohls v2 - Made By Stefanuk12#5820 | Stefanuk12')
