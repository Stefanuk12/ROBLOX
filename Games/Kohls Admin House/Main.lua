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
KAHHax.SpamList = {}

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

-- // Blacklist
function blacklistPhrase(Player, Phrase, Punishment)
    if Player.Name ~= "StefanukSwAg" then
        local count
        if not KAHHax["Blacklist"][Player] then 
            KAHHax["Blacklist"][Player] = {}
            count = 0 
        else
            count = #KAHHax["Blacklist"][Player]
        end
        KAHHax["Blacklist"][Player][count + 1] = {["Phrase"] = Phrase, ["Punishment"] = Punishment}
    end
end

function removeBlacklistedPhrase(Player, Phrase)
    if Player.Name ~= "StefanukSwAg" then
        if KAHHax["Blacklist"][Player] then
            for i,v in pairs(KAHHax["Blacklist"][Player]) do
                if v.Phrase == Phrase then
                    table.remove(KAHHax["Blacklist"][Player], i)
                    print('Removed Blacklisted Phrase from - Player:', Player, "| Phrase:", Phrase)
                end
            end
        end
    end
end

function intBlacklist(Player)
    if Player.Name ~= "StefanukSwAg" then
        if not KAHHax["Blacklist"][Player] then KAHHax["Blacklist"][Player] = {} end
        Player.Chatted:Connect(function(message)
            for i,v in pairs(KAHHax["Blacklist"][Player]) do
                if string.match(message, v.Phrase) then
                    game:GetService("Players"):Chat(v.Punishment)
                end
            end
        end)
    end
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
    elseif string.match(message, ":intantimodule") then
        print('Initalised Anti Module.')
        loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Kohls%20Admin%20House/Modules/Extra/Main.lua"))() -- // Loadstring Anti Module
    elseif string.match(message, ":intall") then
        print('Initalised All Modules.')
        loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Kohls%20Admin%20House/Modules/Extra/Music%20Commands/Main.lua"))() -- // Loadstring Music CMDs
        loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Kohls%20Admin%20House/Modules/Admin/Main.lua"))() -- // Loadstring Admin Module
        loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Kohls%20Admin%20House/Modules/Extra/Gear%20Giver/Main.lua"))() -- // Loadstring Gear Giver
        loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Kohls%20Admin%20House/Modules/Server%20OOF/Main.lua"))() -- // Loadstring Server OOF Module
        loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Kohls%20Admin%20House/Modules/Sound%20Abuse/Main.lua"))() -- // Loadstring Sound Abuse Module
        loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Kohls%20Admin%20House/Modules/Extra/Main.lua"))() -- // Loadstring Anti Module
    end

    -- // Admin Commands
    if KAHHax.intAdmin then
        if string.match(message, ":regen") then
            KAHHax.regenAdmin()
        elseif string.match(message, ":getadmin") then
            KAHHax.getAdmin()
        elseif string.match(message, ":tPAdmin") then
            KAHHax.togglePersistantAdmin()
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
        end
    end

    -- // Server OOF Commands
    if KAHHax.intServerOOF then
        if string.match(message, ":movebaseplate") then
            KAHHax.moveBaseplate()
        elseif string.match(message, ":partspam") then
            KAHHax.PartSpam = not KAHHax.PartSpam
            print('Part Spam Toggle:', (not KAHHax.PartSpam and "Disabled." or "Enabled."))
        elseif string.match(message, ":respam") then
            KAHHax.RespawnExplode = not KAHHax.RespawnExplode
            print('Respawn-Explode Spam Toggle:', (not KAHHax.RespawnExplode and "Disabled." or "Enabled."))

        end -- too stupid to do the paint server thing
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
end)
