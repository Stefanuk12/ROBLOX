-- // Main Script
if getgenv().KAHHaxLoaded then warn("oofkohls v2 already loaded!") return end
warn("Loading oofkohls v2 - Made By Stefanuk12#5820 | Stefanuk12")

-- // Initialise
if not getgenv()["KAHHax"] then getgenv()["KAHHax"] = {} end
if not getgenv()["KAHHax"]["InitialisedModules"] then getgenv()["KAHHax"]["InitialisedModules"] = {} end

loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Kohls%20Admin%20House/CommonVariables.lua"))() -- // Common Vars
repeat wait() until KAHHax["vars"]
local vars = KAHHax["vars"]

KAHHax.CMDs = {--[[
    {
        CommandName = v,
        ModuleName = w,
        Example = x,
        Description = y,
        Function = z,
    }
]]}

-- // Controller Vars
KAHHax.ServerOOFController = {}
KAHHax.ServerOOFController.RE = false
KAHHax.ServerOOFController.PS = false
KAHHax.ServerOOFController.lagServer = false
KAHHax.ServerOOFController.crashSpammer = {}

KAHHax.SoundAbuseController = {}
KAHHax.SoundAbuseController.EarRape = false

KAHHax.AdminController = {}
KAHHax.AdminController.PersistantAdmin = false

-- // Script
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

function fireCommand(command, message)
    if KAHHax.CMDs[command] then
        KAHHax.CMDs[command].Function(message)
    end
end

-- // Anti
antiPunish = false
antiBlind = false
antiKill = false
antiJail = false
game:GetService("Lighting").ChildAdded:Connect(function(child) -- // Anti Punish
    if antiPunish and child.Name == vars.LocalPlayer.Name then
        vars.Chat(":reset me")
    end
end)

vars.LocalPlayer.PlayerGui.ChildAdded:Connect(function(child) -- // Anti Blind
    if antiBlind and child.Name == "EFFECTGUIBLIND" then
        wait(0.1)
        child:Destroy()
    end
end)

vars.Character:WaitForChild("Humanoid").Died:Connect(function() -- // Anti Kill
    if antiKill then vars.Chat(":reset me") end
end)

vars.LocalPlayer.CharacterAdded:Connect(function(Character)
    Character:WaitForChild("Humanoid").Died:Connect(function() -- // Anti Kill
        if antiKill then vars.Chat(":reset me") end
    end)
end)

vars.HolderFolder.ChildAdded:Connect(function(child) -- // Anti Jail
    if antiJail and child.Name == vars.LocalPlayer.Name.."'s jail" then
        vars.Chat(":removejails")
    end
end)

-- // Identifier ;)
for _,v in pairs(game:GetService("Players"):GetPlayers()) do
    for _,x in pairs(vars.WhitelistedUsers) do
        if v == vars.LocalPlayer and v.UserId == x then
        elseif v.UserId == x then
            game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("m Hi Epic Gamers! v2", "All")
        end
    end
end
 
game:GetService("Players").PlayerAdded:Connect(function(plr)
    if vars.checkWhitelisted(plr.UserId) then
        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("m Hi Epic Gamers! v2", "All")
    end
end)
 
for _,v in pairs(vars.WhitelistedUsers) do
    local Player = vars.Players:GetNameFromUserIdAsync(v)
    if vars.Players:FindFirstChild(Player) then
        local Player = vars.Players:FindFirstChild(Player)
        Player.Chatted:Connect(function(chat)
            if string.lower(chat) == "hi gamers" then
                game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("m Hi Epic Gamers! v2", "All")
            end
        end)
    end
end

-- // All of the Coroutines
KAHHax.ServerOOFController.RECoroutine = coroutine.wrap(function() -- // Respawn Explode Spam
    while wait() do
        if KAHHax.ServerOOFController.RE then
            for i,v in pairs(vars.getPlayer("others")) do
                if not vars.checkWhitelisted(v.UserId) then
                    vars.Chat(":respawn others")
                    wait(0.1)
                    vars.Chat(":explode others")
                end
            end
        end
    end
end)()

KAHHax.ServerOOFController.PartCoroutine = coroutine.wrap(function() -- // Part Spam
    while wait() do
        if KAHHax.ServerOOFController.PS then
            vars.Chat("part/10/10/10")
        end
    end
end)()
if not game:GetService("MarketplaceService"):UserOwnsGamePassAsync(vars.LocalPlayer.UserId, 35748) then coroutine.yield(KAHHax.ServerOOFController.PartCoroutine) vars.Alert("You do not have Person299's Admin, cannot part spam!") end

KAHHax.ServerOOFController.PMCoroutine = coroutine.wrap(function() -- // PM Lag Spammer
    while wait() do
        for i,v in pairs(vars.PlayerManager) do
            if v.Lagging then
                vars.Chat(":pm "..i.." "..vars.largeText)
            end
        end
    end
end)()

KAHHax.ServerOOFController.SVRLagCoroutine = coroutine.wrap(function() -- // Server Lag
    while wait() do
        if KAHHax.ServerOOFController.lagServer and not vars.checkAllWhitelisted() then
            vars.Chat(":pm others "..vars.largeText)
        end
    end
end)()

KAHHax.SoundAbuseController.mainCoroutine = coroutine.wrap(function()
    while wait(0.25) do
        if KAHHax.SoundAbuseController.EarRape then
            for i,v in pairs(game:GetService("Workspace"):GetDescendants()) do
                if v:IsA("Sound") then
                    v:Play()
                end
            end
        end
    end
end)()

coroutine.wrap(function()
    while wait() do
        if vars.SpamList[1] then
            for _,v in pairs(vars.SpamList) do
                vars.Chat(v.Phrase)
            end
        end
    end
end)()

KAHHax.AdminController.PAdminCoroutine = coroutine.wrap(function()
    fireCommand("regen")

    local Pad = vars.Pads:FindFirstChildWhichIsA("Model")
    local PadClone = Pad:Clone()

    PadClone.Parent = vars.Pads
    PadClone.Name = "ClonedPad"
    if Pad:FindFirstChildWhichIsA("Humanoid") then Pad:FindFirstChildWhichIsA("Humanoid"):Destroy() end
    if PadClone:FindFirstChildWhichIsA("Humanoid") then PadClone:FindFirstChildWhichIsA("Humanoid"):Destroy() end
    
    while wait() do       
        if KAHHax.AdminController.PersistantAdmin and vars.Character:FindFirstChildWhichIsA("BasePart") then
            if string.match(Pad.Name, "admin") and Pad.Head.BrickColor == BrickColor.new("Really red") then
                fireCommand("regen")
            end
            Pad.Head.Size = Vector3.new(0.1, 0.1, 0.1)
            Pad.Head.CanCollide = false
            Pad.Head.Transparency = 1
            Pad.Head.CFrame = vars.Character["Left Leg"].CFrame

            PadClone.Head.BrickColor = BrickColor.new("Really red")
        end
    end       
end)()

-- // Anti Lava Blocks
for _,v in pairs(vars.Obby:GetDescendants()) do
    if v:IsA("TouchTransmitter") then
        v:Destroy()
    end
end


-- // CMD Handler
function addCMD(CommandName, ModuleName, Example, Description, Function)
    if not CommandName or not ModuleName or not Example or not Description or not Function then
        vars.Alert("addCMDs invalid!", CommandName)
        return
    end
    local CMDs = KAHHax.CMDs
    CMDs[CommandName] = {
        ModuleName = ModuleName,
        Example = Example,
        Description = Description,
        Function = Function,
    }
end

vars.LocalPlayer.Chatted:Connect(function(message)
    for i,v in pairs(KAHHax.CMDs) do
        local Command = vars.Prefix..i
        if v.Function and string.sub(message, 1, #Command) == Command then
            v.Function(message)
        end
    end
end)

local Prefix = vars.Prefix
-- // CMDs: Admin Module
addCMD("regen", "Admin", Prefix.."regen", "Regens the admin.", function(message)
    local verbrose = string.split(message, " ")[2]
    local RegenPad = vars.AdminFolder.Regen
    fireclickdetector(vars.AdminFolder.Regen.ClickDetector, 0)
    if verbrose then print('Regened Admin.') end
end)

addCMD("getadmin", "Admin", Prefix.."getadmin", "Gets admin.", function(message)
    local verbrose = string.split(message, " ")[2]
    fireCommand("regen", verbrose)
    wait(0.25)
    firetouchinterest(vars.Character["Left Leg"], vars.Pads:FindFirstChild("Touch to get admin").Head, 0)
    if verbrose then print('Got Admin.') end
end)

addCMD("peradmin", "Admin", Prefix.."peradmin", "Toggles Persistant Admin.", function(message)
    KAHHax.AdminController.PersistantAdmin = not KAHHax.AdminController.PersistantAdmin
    vars.Notify('Persistant Admin Toggle:', (not KAHHax.AdminController.PersistantAdmin and "Disabled." or "Enabled."))
end)

-- // CMDs: Extra (Anti) Module
addCMD("antipunish", "Anti", Prefix.."antipunish", "Toggles Anti Punish.", function(message)
    antiPunish = not antiPunish
    vars.Notify('Anti Punish Toggle:', (not antiPunish and "Disabled." or "Enabled."))
end)

addCMD("antiblind", "Anti", Prefix.."antiblind", "Toggles Anti Blind.", function(message)
    antiBlind = not antiBlind
    vars.Notify('Anti Blind Toggle:', (not antiBlind and "Disabled." or "Enabled."))
end)

addCMD("antikill", "Anti", Prefix.."antikill", "Toggles Anti Kill.", function(message)
    antiKill = not antiKill
    vars.Notify('Anti Kill Toggle:', (not antiKill and "Disabled." or "Enabled."))
end)

addCMD("antijail", "Anti", Prefix.."antijail", "Toggles Anti Jail.", function(message)
    antiJail = not antiJail
    vars.Notify('Anti Jail Toggle:', (not antiJail and "Disabled." or "Enabled."))
end)

-- // CMDs: Gear Giver Module
addCMD("give", "Gear Giver", Prefix.."give me SuperRLauncher", "Give yourself and others gears!", function(message)
    local splitString = string.split(message, " ")
    if splitString[2] and splitString[3] and vars.gearList[splitString[3]] then
        vars.Chat(":gear "..splitString[2].." "..vars.gearList[splitString[3]])
    elseif not splitString[2] or splitString[3] then
        vars.Alert("Invalid Arguments!")
    end
end)

addCMD("givehelp", "Gear Giver", Prefix.."givehelp", "Returns all of the givable gears.", function(message)
    print('Welcome to Gear Giver - for Kohls Admin House. Prefix is :give - You need admin! All of the available gears will be listed below.')
    for i,v in pairs(vars.gearList) do
        local itemName = game:GetService("MarketplaceService"):GetProductInfo(v).Name
        print("> "..itemName.." = "..i)
    end
    print('Example - :give all SSTripmine')
end)

-- // CMDs: Sound Abuse Module
addCMD("pasounds", "Sound Abuse", Prefix.."pasounds", "Plays all of the sounds in the game.", function(message)
    for i,v in pairs(game:GetService("Workspace"):GetDescendants()) do
        if v:IsA("Sound") then
            v:Play()
        end
    end
    vars.Notify('Played All Sounds.')
end)

addCMD("sallsounds", "Sound Abuse", Prefix.."sallsounds", "Stops all of the sounds in the game.", function(message)
    for i,v in pairs(game:GetService("Workspace"):GetDescendants()) do
        if v:IsA("Sound") then
            v:Stop()
        end
    end
    vars.Notify('Stopped All Sounds.')
end)

addCMD("pmusic", "Sound Abuse", Prefix.."pmusic", "Plays the 'Music' Sound.", function(message)
    if vars.HolderFolder:FindFirstChildWhichIsA("Sound") then
        vars.HolderFolder:FindFirstChildWhichIsA("Sound"):Play()
    end
    vars.Notify('Played Music.')
end)

addCMD("smusic", "Sound Abuse", Prefix.."smusic", "Stops the 'Music' Sound.", function(message)
    if vars.HolderFolder:FindFirstChildWhichIsA("Sound") then
        vars.HolderFolder:FindFirstChildWhichIsA("Sound"):Stop()
    end
    vars.Notify('Stopped Music.')
end)

addCMD("earrape", "Sound Abuse", Prefix.."earrape", "Toggles EarRape.", function(message)
    KAHHax.SoundAbuseController.EarRape = not KAHHax.SoundAbuseController.EarRape
    vars.Notify('EarRape Toggle:', (not KAHHax.SoundAbuseController.EarRape and "Disabled." or "Enabled."))
end)

-- // CMDs: Server OOF Module
addCMD("movebaseplate", "Server OOF", Prefix.."movebaseplate", "Makes you able to move the baseplate.", function(message)
    local Spawn = vars.WorkspaceFolder.Spawn3
    local Baseplate = vars.WorkspaceFolder.Baseplate
    vars.Character.HumanoidRootPart.CFrame = CFrame.new(Spawn.Position.X, Baseplate.Position.Y + 1, Spawn.Position.Z)
    wait(1.5)
    vars.Chat(":stun me")
    vars.Notify("Done!")
end)

addCMD("partspam", "Server OOF", Prefix.."partspam", "Toggles Spam Parts (Persons299's Admin Needed!).", function(message)
    KAHHax.ServerOOFController.PS = not KAHHax.ServerOOFController.PS
    getgenv().chatSpyEnabled = not KAHHax.ServerOOFController.PS
    vars.Notify('Part Spam Toggle:', (not KAHHax.ServerOOFController.PS and "Disabled." or "Enabled."))
end)

addCMD("respam", "Server OOF", Prefix.."respam", "Toggles Server Respawn-Explode Spam.", function(message)
    KAHHax.ServerOOFController.RE = not KAHHax.ServerOOFController.RE
    getgenv().chatSpyEnabled = not KAHHax.ServerOOFController.RE
    vars.Notify('Respawn-Explode Spam Toggle:', (not KAHHax.ServerOOFController.RE and "Disabled." or "Enabled."))
end)

addCMD("makepbaseplate", "Server OOF", Prefix.."makepbaseplate", "Makes a 'fake' baseplate.", function(message)
    local Baseplate = Instance.new("Part", vars.WorkspaceFolder)
    Baseplate.Name = "PhantomBaseplate"
    Baseplate.BrickColor = BrickColor.new("Bright green")
    Baseplate.Size = Vector3.new(1000, 1.2, 1000)
    Baseplate.TopSurface = "Studs"
    Baseplate.Anchored = true
    vars.Notify("Made Fake Baseplate.")
end)

addCMD("removepbaseplates", "Server OOF", Prefix.."removepbaseplates", "Removes all 'fake' baseplates.", function(message)
    for i,v in pairs(vars.WorkspaceFolder:GetChildren()) do
        if v.Name == "PhantomBaseplate" then
            v:Destroy()
        end
    end
    vars.Notify("Removed Fake Baseplates.")
end)

addCMD("paintarea", "Server OOF", Prefix.."paintarea | 255 0 0 (You may use BrickColor or RGB) | Obby Box", "Paints the specified section as the specified colour.", function(message)
    local splitString = string.split(message, " | ")
    if splitString[1] and splitString[2] and splitString[3] then
        local Colour 
        local Section = splitString[3]
        if string.gmatch(splitString[2], "%d") and not string.gmatch(splitString[2], "[%a%p%c]+") then
            Colour = Vector3.new(0, 0, 0)
            local colorSplit = string.split(splitString[2], " ")
            if colorSplit[1] and tonumber(colorSplit[1]) then Colour.X = colorSplit[1] end
            if colorSplit[2] and tonumber(colorSplit[2]) then Colour.Y = colorSplit[2] end
            if colorSplit[3] and tonumber(colorSplit[3]) then Colour.Z = colorSplit[3] end
        end
        -- // Check if you already have a Paint Bucket
        vars.Character.Humanoid:UnequipTools(); wait(0.5)
        if not vars.LocalPlayer.Backpack:FindFirstChild("PaintBucket") then
            vars.Chat(":gear me 18474459"); wait(0.5)
            vars.Character.Humanoid:EquipTool(vars.LocalPlayer.Backpack.PaintBucket)
        end

        -- // Vars
        local Remote = vars.Character:WaitForChild("PaintBucket"):WaitForChild("Remotes").ServerControls
        local SelectedColor

        if typeof(SelectedColor) == 'Vector3' then 
            SelectedColor = Color.fromRGB(SelectedColor.X, SelectedColor.Y, SelectedColor.Z) 
        elseif typeof(SelectedColor) == 'BrickColor' then 
            SelectedColor = SelectedColor.Color 
        elseif typeof(SelectedColor) == 'string' then 
            if SelectedColor == "rainbow" then 
                SelectedColor = vars.RainbowColor 
            else 
                SelectedColor = BrickColor.new(SelectedColor).Color 
            end 
        end

        -- // The Actual Painting Part
        if string.lower(Section) == "all" then
            for i,v in pairs(vars.WorkspaceFolder:GetChildren()) do
                if string.match(string.lower(v.Name), string.lower(Section)) then
                    for _, part in pairs(v:GetDescendants()) do
                        if part:IsA("BasePart") then
                            Remote:InvokeServer("PaintPart", {["Part"] = part, ["Color"] = SelectedColor})
                        end
                    end
                end
            end
        end
    else
        vars.Alert("Invalid Arguments!")
    end
end)

addCMD("tlag", "Server OOF", Prefix.."tlag EpicGamer69", "Toggles lagging player.", function(message)
    local splitString = string.split(message, " ")
    if splitString[1] and splitString[2] then
        local targetUser = splitString[2]
        for i,v in pairs(vars.getPlayer(targetUser)) do
            if not vars.checkWhitelisted(v.UserId) then
                vars.PlayerManager[v.Name].Lagging = not vars.PlayerManager[v.Name].Lagging
                getgenv().chatSpyEnabled = not vars.PlayerManager[v.Name].Lagging
                vars.Notify(vars.PlayerManager[v.Name].Lagging and v.Name.." is being lagged." or v.Name.." has stopped being lagged.")
            end
        end
    else
        vars.Alert("Invalid Arguments!")
    end
end)

addCMD("svrlag", "Server OOF", Prefix.."svrlag", "Toggles lagging the whole server.", function(message)
    getgenv().chatSpyEnabled = KAHHax.ServerOOFController.lagServer
    KAHHax.ServerOOFController.lagServer = not KAHHax.ServerOOFController.lagServer
    vars.Notify('Lag Server Toggle:', (not KAHHax.ServerOOFController.lagServer and "Disabled." or "Enabled."))
end)

addCMD("spam", "Server OOF", Prefix.."spam kill all", "Spams a message.", function(message)
    local Str = Prefix.."spam  "
    local givenPhrase = string.sub(message, #Str, -1)
    if not givenPhrase then
        vars.Alert("Invalid Arguments!")
        return
    end
    getgenv().chatSpyEnabled = false
    if not vars.SpamList[1] then
        table.insert(vars.SpamList, {Phrase = givenPhrase})
        vars.Notify('Successfully added to Spam List, Message:', givenPhrase)
    else
        for i,v in pairs(vars.SpamList) do
            if v.Phrase ~= givenPhrase then
                table.insert(vars.SpamList, {Phrase = givenPhrase})
                vars.Notify('Successfully added to Spam List, Message:', givenPhrase)
            else
                vars.Alert("Already spamming this message:", givenPhrase)
            end
        end
    end
end)

addCMD("rspam", "Server OOF", Prefix.."rspam kill all", "Removes a spam message.", function(message)
    local Str = Prefix.."rspam  "
    local givenPhrase = string.sub(message, #Str, -1)
    if #vars.SpamList < 1 then getgenv().chatSpyEnabled = true end
    for i,v in pairs(vars.SpamList) do
        if v.Phrase == givenPhrase then
            table.remove(vars.SpamList, i)
            vars.Notify('Successfully removed to Spam List, Message:', givenPhrase)
        end
    end
end)

addCMD("blphrase", "Server OOF", Prefix.."blphrase | EpicGamer69 | kill all | reset all", "When Player says Phrase, Punishment is said.", function(message)
    local splitString = string.split(message, " | ")
    if splitString[1] and splitString[2] and splitString[3] and splitString[4] then
        local targetPlayer = vars.getPlayer(splitString[2])
        for _,v in pairs(targetPlayer) do
            if v and not vars.checkWhitelisted(v.UserId) then
                local bLTBL = vars.PlayerManager[v.Name].BlacklistedPhrases
                table.insert(bLTBL, {Phrase = splitString[3], Punishment = splitString[4]})
                vars.Notify('Blacklisted Phrase: Player -', v.Name, "Phrase -", splitString[3], "Punishment -", splitString[4])
            else
                vars.Alert(targetPlayer, " - unable to blacklist phrases")
            end
        end    
    else
        vars.Alert("Invalid Arguments!")
    end
end)

addCMD("rblphrase", "Server OOF", Prefix.."rblphrase | EpicGamer69 | kill all", "Remove Blacklisted Phrase.", function(message)
    local splitString = string.split(message, " | ")
    if splitString[1] and splitString[2] and splitString[3]then
        local targetPlayer = vars.getPlayer(splitString[2])
        for _,v in pairs(targetPlayer) do
            if v and not vars.checkWhitelisted(v.UserId) then
                for a,x in pairs(vars.PlayerManager[v.Name].BlacklistedPhrases) do
                    if x.Phrase == splitString[3] then
                        table.remove(vars.PlayerManager[v.Name].BlacklistedPhrases, a)
                        vars.Notify('Removed Blacklisted Phrase: Player -', v.Name, "Phrase -", splitString[3])
                    end
                end
            end
        end
    else
        vars.Alert("Invalid Arguments!")
    end
end)

-- // CMDs: Music Commands
addCMD("getmusic", "Music Commands", Prefix.."getmusic", "Prints all of the playable music.", function(message)
    vars.MusicAPI.returnMusic(false)
end)

addCMD("refreshmusic", "Music Commands", Prefix.."refreshmusic", "Refreshes the music table.", function(message)
    vars.MusicAPI.refreshSounds()
end)

addCMD("play", "Music Commands", Prefix.."play 53", "Plays the sound indexed at the number.", function(message)
    local SoundId
    local splitString = string.split(message, " ")
    if splitString[1] and splitString[2] and tonumber(splitString[2]) and vars.MusicAPI.getSound(tonumber(splitString[2])) then
        vars.Chat(":music "..vars.MusicAPI.getSound(tonumber(splitString[2])))
        vars.Notify("Now Playing: "..vars.MusicAPI.getSoundName(tonumber(splitString[2])))
    else
        vars.Alert("Invalid Arguments!")
    end
end)

-- // CMDs: Misc. Commands
addCMD("rj", "Misc", Prefix.."rj", "Rejoins the game.", function(message)
    game:GetService('TeleportService'):Teleport(game.PlaceId)
end)

addCMD("execute", "Misc", Prefix.."execute print('hi'))", "Executes whatever you want.", function(message)
    local Str = Prefix.."execute  "
    loadstring(string.sub(message, #Str, -1))()
end)

addCMD("copycmds", "Misc", Prefix.."copycmds", "Copies all of the commands to your clipboard.", function(message)
    local CommandCount = 0
    for i,v in pairs(KAHHax.CMDs) do
        CommandCount = CommandCount + 1
    end
    local Holder = "oofkohls v2 Command List | Total Commands: "..CommandCount.." | Prefix - "..Prefix.."\n"
    Holder = Holder.."--~~-- Admin Module --~~--\n"
    for i,v in pairs(KAHHax.CMDs) do
        if v.ModuleName == "Admin" then
            Holder = Holder.."> "..i.." - Description: "..v.Description.." - Example: "..v.Example.."\n"
        end
    end
    Holder = Holder.."--~~-- Server OOF Module --~~--\n"
    for i,v in pairs(KAHHax.CMDs) do
        if v.ModuleName == "Server OOF" then
            Holder = Holder.."> "..i.." - Description: "..v.Description.." - Example: "..v.Example.."\n"
        end
    end
    Holder = Holder.."--~~-- Sound Abuse Module --~~--\n"
    for i,v in pairs(KAHHax.CMDs) do
        if v.ModuleName == "Sound Abuse" then
            Holder = Holder.."> "..i.." - Description: "..v.Description.." - Example: "..v.Example.."\n"
        end
    end
    Holder = Holder.."--~~-- Music Commands Module --~~--\n"
    for i,v in pairs(KAHHax.CMDs) do
        if v.ModuleName == "Music Commands" then
            Holder = Holder.."> "..i.." - Description: "..v.Description.." - Example: "..v.Example.."\n"
        end
    end
    Holder = Holder.."--~~-- Gear Giver Module --~~--\n"
    for i,v in pairs(KAHHax.CMDs) do
        if v.ModuleName == "Gear Giver" then
            Holder = Holder.."> "..i.." - Description: "..v.Description.." - Example: "..v.Example.."\n"
        end
    end
    Holder = Holder.."--~~-- Anti Module --~~--\n"
    for i,v in pairs(KAHHax.CMDs) do
        if v.ModuleName == "Anti" then
            Holder = Holder.."> "..i.." - Description: "..v.Description.." - Example: "..v.Example.."\n"
        end
    end
    Holder = Holder.."--~~-- Misc Module --~~--\n"
    for i,v in pairs(KAHHax.CMDs) do
        if v.ModuleName == "Misc" then
            Holder = Holder.."> "..i.." - Description: "..v.Description.." - Example: "..v.Example.."\n"
        end
    end
    setclipboard(Holder)
    vars.Notify("Copied all Commands to clipboard!")
end)

-- // CMDs: Misc. Commands - CMD GUI
addCMD("xcmds", "Misc", Prefix.."xcmds", "Shows all of the CMDs.", function(message)
    local ScriptCMDs = Instance.new("ScreenGui")
    local Container = Instance.new("Frame")
    local Header = Instance.new("Frame")
    local Title = Instance.new("TextButton")
    local Close = Instance.new("TextButton")
    local Body = Instance.new("Frame")
    local CMDFrame = Instance.new("ScrollingFrame")
    local UIListLayout = Instance.new("UIListLayout")
    local example = Instance.new("TextButton")
    local ExamplePrompt = Instance.new("TextButton")
    ScriptCMDs.Name = "ScriptCMDs"
    ScriptCMDs.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    ScriptCMDs.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    Container.Name = "Container"
    Container.Parent = ScriptCMDs
    Container.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Container.BackgroundTransparency = 1.000
    Container.BorderSizePixel = 0
    Container.Position = UDim2.new(0.399999976, 0, 0.200000033, 0)
    Container.Size = UDim2.new(0, 400, 0, 50)
    Header.Name = "Header"
    Header.Parent = Container
    Header.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    Header.BorderSizePixel = 0
    Header.Size = UDim2.new(0, 400, 0, 50)
    Title.Name = "Title"
    Title.Parent = Header
    Title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    Title.BackgroundTransparency = 1.000
    Title.BorderSizePixel = 0
    Title.Size = UDim2.new(0, 0, 0, 50)
    Title.AutoButtonColor = false
    Title.Font = Enum.Font.GothamBlack
    Title.Text = "    | Epic Script CMDs"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 14.000
    Title.TextStrokeColor3 = Color3.fromRGB(200, 200, 200)
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Close.Name = "Close"
    Close.Parent = Header
    Close.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Close.BorderSizePixel = 0
    Close.Position = UDim2.new(0.88500005, 0, 0, 0)
    Close.Size = UDim2.new(0, 45, 0, 50)
    Close.AutoButtonColor = false
    Close.Font = Enum.Font.GothamBold
    Close.Text = "X"
    Close.TextColor3 = Color3.fromRGB(255, 105, 97)
    Close.TextSize = 14.000
    Close.TextStrokeColor3 = Color3.fromRGB(200, 200, 200)
    Body.Name = "Body"
    Body.Parent = Header
    Body.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Body.BackgroundTransparency = 1.000
    Body.BorderSizePixel = 0
    Body.Position = UDim2.new(0, 0, 0.985000014, 0)
    Body.Size = UDim2.new(0, 400, 0, 350)
    CMDFrame.Name = "CMDFrame"
    CMDFrame.Parent = Body
    CMDFrame.Active = true
    CMDFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    CMDFrame.BorderSizePixel = 0
    CMDFrame.Size = UDim2.new(0, 400, 0, 350)
    CMDFrame.CanvasSize = UDim2.new(0, 0, 5, 0)
    UIListLayout.Parent = CMDFrame
    example.Name = ":example"
    example.Parent = CMDFrame
    example.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    example.BackgroundTransparency = 1.000
    example.BorderSizePixel = 0
    example.Position = UDim2.new(0, 0, -0.0114285713, 0)
    example.Size = UDim2.new(0, 400, 0, 50)
    example.Visible = false
    example.AutoButtonColor = false
    example.Font = Enum.Font.Gotham
    example.Text = "    > :example - example description"
    example.TextColor3 = Color3.fromRGB(255, 255, 255)
    example.TextSize = 14.000
    example.TextStrokeColor3 = Color3.fromRGB(200, 200, 200)
    example.TextXAlignment = Enum.TextXAlignment.Left
    ExamplePrompt.Name = "Example Prompt"
    ExamplePrompt.Parent = Header
    ExamplePrompt.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    ExamplePrompt.BackgroundTransparency = 1.000
    ExamplePrompt.BorderSizePixel = 0
    ExamplePrompt.Position = UDim2.new(0.38499999, 0, 0, 0)
    ExamplePrompt.Size = UDim2.new(0, 200, 0, 50)
    ExamplePrompt.AutoButtonColor = false
    ExamplePrompt.Font = Enum.Font.Gotham
    ExamplePrompt.Text = " click cmds 4 example print"
    ExamplePrompt.TextColor3 = Color3.fromRGB(255, 255, 255)
    ExamplePrompt.TextSize = 14.000

    for i,v in pairs(KAHHax.CMDs) do
        local Clone = example:Clone()
        wait()
        Clone.Name = v.Example
        Clone.Text = "    > "..Prefix..i.." - "..v.Description
        Clone.Parent = CMDFrame
        Clone.Visible = true 
    end
    example = nil

    -- // Script
    local Dragger = {}; do
        local Mouse = game:GetService("Players").LocalPlayer:GetMouse()
        local UIS = game:GetService("UserInputService")
        local Heartbeat = game:GetService("RunService").Heartbeat
        function Dragger.new(Frame)
            local success, response = pcall(function()
                return Frame.MouseEnter
            end)
            if success then
                Frame.Active = true
                response:Connect(function()
                    local Input = Frame.InputBegan:Connect(function(Key)
                        if Key.UserInputType == Enum.UserInputType.MouseButton1 then
                            local objectPosition = Vector2.new(Mouse.X - Frame.AbsolutePosition.X, Mouse.Y - Frame.AbsolutePosition.Y)
                            while Heartbeat:Wait() and UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
                                pcall(function()
                                    Frame:TweenPosition(UDim2.new(0, Mouse.X - objectPosition.X + (Frame.Size.X.Offset * Frame.AnchorPoint.X), 0, Mouse.Y - objectPosition.Y + (Frame.Size.Y.Offset * Frame.AnchorPoint.Y)), 'Out', 'Linear', 0.1, true)
                                end)
                            end
                        end
                    end)

                    local Leave
                    Leave = Frame.MouseLeave:Connect(function()
                        Input:Disconnect()
                        Leave:Disconnect()
                    end)
                end)
            end
        end

    end
    Dragger.new(Container)

    local Connections = {}
    function hoverGlow(hoverPart, affectedPart)
        local TweenService = game:GetService("TweenService")
        local hPartMouseEnter = hoverPart.MouseEnter:Connect(function()
            TweenService:Create(affectedPart, TweenInfo.new(0.2), {TextStrokeTransparency = 0.8}):Play()
        end)
        local hPartMouseLeave = hoverPart.MouseLeave:Connect(function()
            TweenService:Create(affectedPart, TweenInfo.new(0.2), {TextStrokeTransparency = 1}):Play()
        end)      
        local hPartMouseDown = hoverPart.MouseButton1Down:Connect(function()
            TweenService:Create(affectedPart, TweenInfo.new(0.2), {TextStrokeTransparency = 0.5}):Play()
        end)         
        local hPartMouseUp = hoverPart.MouseButton1Up:Connect(function()
            TweenService:Create(affectedPart, TweenInfo.new(0.2), {TextStrokeTransparency = 1}):Play()
        end)
        table.insert(Connections, {Connection = hPartMouseEnter})
        table.insert(Connections, {Connection = hPartMouseLeave})
        table.insert(Connections, {Connection = hPartMouseDown})
        table.insert(Connections, {Connection = hPartMouseUp})
    end

    hoverGlow(Close, Close)
    local CloseConnection = Close.MouseButton1Click:Connect(function()
        for i,v in pairs(Connections) do
            v.Connection:Disconnect()
        end
        for i,v in pairs(ScriptCMDs:GetDescendants()) do
            if string.match(v.ClassName, "Frame") then
                game:GetService("TweenService"):Create(v, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()
                game:GetService("TweenService"):Create(v, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()
            end
            if string.match(v.ClassName, "Text") then
                game:GetService("TweenService"):Create(v, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()
                game:GetService("TweenService"):Create(v, TweenInfo.new(1), {TextTransparency = 1}):Play()
                game:GetService("TweenService"):Create(v, TweenInfo.new(1), {TextTransparency = 1}):Play()
                v.TextStrokeTransparency = 1
            end
            if string.match(v.ClassName, "ScrollingFrame") then
                game:GetService("TweenService"):Create(v, TweenInfo.new(1), {ScrollBarImageTransparency = 1}):Play()
            end
        end
        wait(2)
        ScriptCMDs:Destroy()
    end)

    hoverGlow(Title, Title)
    local TitleClickConnection = Title.MouseButton1Click:Connect(function()
        print("hi epic scirpt comandsa")
    end)

    for i,v in pairs(CMDFrame:GetChildren()) do
        if v:IsA("TextButton") then
            hoverGlow(v, v)
            local ButtonClickConnection = v.MouseButton1Click:Connect(function()
                print('Command Example - '..v.Name)
            end)
            table.insert(Connections, {Connection = ButtonClickConnection})
        end
    end
    table.insert(Connections, {Connection = CloseConnection})
    table.insert(Connections, {Connection = TitleClickConnection})
end)
getgenv().KAHHaxLoaded = true
warn("Loaded oofkohls v2 - Made by Stefanuk12#5820 | Stefanuk12")