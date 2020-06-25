-- // Main Script
warn("Loading oofkohls v2 - Made By Stefanuk12#5820 | Stefanuk12")

-- // Initialise
if not getgenv()["KAHHax"] then getgenv()["KAHHax"] = {} end
if not getgenv()["KAHHax"]["InitialisedModules"] then getgenv()["KAHHax"]["InitialisedModules"] = {} end

loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Kohls%20Admin%20House/CommonVariables.lua"))() -- // Common Vars
repeat wait() until KAHHax["vars"]
local vars = KAHHax["vars"]

KAHHax.CMDs = {--[[
    {
        CommandName = s,
        ModuleName = w,
        Example = x,
        Description = y,
        Function = z,
    }
]]}

-- // Get All Modules
loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Kohls%20Admin%20House/Modules/Admin/Main.lua"))() -- // Loadstring Admin Module
loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Kohls%20Admin%20House/Modules/Server%20OOF/Main.lua"))() -- // Loadstring Server OOF Module
loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Kohls%20Admin%20House/Modules/Sound%20Abuse/Main.lua"))() -- // Loadstring Sound Abuse Module
loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Kohls%20Admin%20House/Modules/Extra/Main.lua"))() -- // Loadstring Anti Module
wait(1)

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

-- // Blacklist Manager
function blacklistPhrase(targetPlayer, Phrase, Punishment)
    local targetPlayer = vars.getPlayer(tostring(Player))
    for _,v in pairs(targetPlayer) do
        if v and not vars.checkWhitelisted(v.UserId) then
            local bLTBL = vars.PlayerManager[v.Name].BlacklistedPhrases
            table.insert(bLTBL, {Phrase = Phrase, Punishment = Punishment})
            vars.Notify('Blacklisted Phrase:', "Player -", v.Name, "Phrase -", Phrase, "Punishment -", Punishment)
        else
            vars.Alert(targetPlayer, " - unable to blacklist phrases")
        end
    end
end

function removeBlacklistedPhrase(targetPlayer, Phrase)
    local targetPlayer = vars.getPlayer(tostring(Player))
    for _,v in pairs(targetPlayer) do
        if v and not vars.checkWhitelisted(v.UserId) then
            for a,x in pairs(vars.PlayerManager[v.Name].BlacklistedPhrases) do
                if x.Phrase == Phrase then
                    table.remove(vars.PlayerManager[v.Name].BlacklistedPhrases, a)
                end
            end
        end
    end
end

-- // Identifier ;)
for i,v in pairs(game:GetService("Players"):GetPlayers()) do
    if vars.checkWhitelisted(v.UserId) then
        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("m Hi Epic Gamers! v2", "All")
    end
end
 
game:GetService("Players").PlayerAdded:Connect(function(plr)
    if vars.checkWhitelisted(plr.UserId) then
        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("m Hi Epic Gamers! v2", "All")
    end
end)
 
for _,v in pairs(vars.WhilelistedUsers) do
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

-- // SpamList Handler
coroutine.wrap(function()
    while wait() do
        if vars.SpamList[1] then
            for _,v in pairs(vars.SpamList) do
                game:GetService("Players"):Chat(v.Phrase)
            end
        end
    end
end)

function addToSpamList(givenPhrase)
    if not vars.SpamList[1] then
        table.insert(vars.SpamList, {Phrase = givenPhrase})
    else
        for i,v in pairs(vars.SpamList) do
            if v.Phrase ~= givenPhrase then
                table.insert(vars.SpamList, {Phrase = givenPhrase})
            end
        end
    end
    vars.Notify('Successfully added to Spam List, Message:', givenPhrase)
end

function removeSpamPhrase(givenPhrase)
    for i,v in pairs(vars.SpamList) do
        if v.Phrase == givenPhrase then
            table.remove(vars.SpamList, i)
            vars.Notify('Successfully removed to Spam List, Message:', givenPhrase)
        end
    end
end

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
    local insertTable = {
        CommandName = CommandName,
        ModuleName = ModuleName,
        Example = Example,
        Description = Description,
        Function = Function,
    }
    table.insert(CMDs, insertTable)
end

vars.LocalPlayer.Chatted:Connect(function(message)
    for i,v in pairs(KAHHax.CMDs) do
        local Command = vars.Prefix..v.CommandName
        if v.Function and string.sub(message, 1, #Command) == Command then
            v.Function(message)
        end
    end
end)

local Prefix = vars.Prefix
-- // CMDs: Admin Module
addCMD("regen", "Admin", Prefix.."regen", "Regens the admin.", function(message)
    local verbrose = string.split(message, " ")[2]
    KAHHax.AdminController.regenAdmin(verbrose and true or false)
end)

addCMD("getadmin", "Admin", Prefix.."getadmin", "Gets admin.", function(message)
    local verbrose = string.split(message, " ")[2]
    KAHHax.AdminController.getAdmin(verbrose and true or false)
end)

addCMD("peradmin", "Admin", Prefix.."peradmin", "Toggles Persistant Admin.", function(message)
    local toggle = KAHHax.AdminController.PersistantAdmin
    toggle = not toggle
    vars.Notify('Persistant Admin Toggle:', (not toggle and "Disabled." or "Enabled."))
end)

-- // CMDs: Extra (Anti) Module
addCMD("antipunish", "Extra", Prefix.."antipunish", "Toggles Anti Punish.", function(message)
    local toggle = not KAHHax.ExtraController.antiPunish
    vars.Notify('Anti Punish Toggle:', (not toggle and "Disabled." or "Enabled."))
end)

addCMD("antiblind", "Extra", Prefix.."antiblind", "Toggles Anti Blind.", function(message)
    local toggle = not KAHHax.ExtraController.antiBlind
    vars.Notify('Anti Blind Toggle:', (not toggle and "Disabled." or "Enabled."))
end)

addCMD("antikill", "Extra", Prefix.."antikill", "Toggles Anti Kill.", function(message)
    local toggle = not KAHHax.ExtraController.antiKill
    vars.Notify('Anti Kill Toggle:', (not toggle and "Disabled." or "Enabled."))
end)

addCMD("antijail", "Extra", Prefix.."antijail", "Toggles Anti Jail.", function(message)
    local toggle = not KAHHax.ExtraController.antiJail
    vars.Notify('Anti Jail Toggle:', (not toggle and "Disabled." or "Enabled."))
end)

-- // CMDs: Gear Giver Module
addCMD("give help", "Gear Giver")

-- // CMDs: Sound Abuse Module
addCMD("pasounds", "Sound Abuse", Prefix.."pasounds", "Plays all of the sounds in the game.", function(message)
    KAHHax.SoundAbuseController.playAllSounds()
end)

addCMD("sallsounds", "Sound Abuse", Prefix.."sallsounds", "Stops all of the sounds in the game.", function(message)
    KAHHax.SoundAbuseController.stopAllSounds()
end)

addCMD("pmusic", "Sound Abuse", Prefix.."pmusic", "Plays the 'Music' Sound.", function(message)
    KAHHax.SoundAbuseController.playMusic()
end)

addCMD("smusic", "Sound Abuse", Prefix.."smusic", "Stops the 'Music' Sound.", function(message)
    KAHHax.SoundAbuseController.stopMusic()
end)

addCMD("earrape", "Sound Abuse", Prefix.."earrape", "Toggles EarRape.", function(message)
    local toggle = KAHHax.SoundAbuseController.EarRape
    toggle = not toggle
    vars.Notify('EarRape Toggle:', (not toggle and "Disabled." or "Enabled."))
end)

-- // CMDs: Server OOF Module
addCMD("movebaseplate", "Server OOF", Prefix.."movebaseplate", "Makes you able to move the baseplate.", function(message)
    KAHHax.ServerOOFController.moveBaseplate()
    vars.Notify("Done!")
end)

addCMD("partspam", "Server OOF", Prefix.."partspam", "Toggles Spam Parts (Persons299's Admin Needed!).", function(message)
    local toggle = KAHHax.ServerOOFController.PartSpam 
    toggle = not toggle
    getgenv().chatSpyEnabled = not toggle
    vars.Notify('Part Spam Toggle:', (not toggle and "Disabled." or "Enabled."))
end)

addCMD("respam", "Server OOF", Prefix.."respam", "Toggles Server Respawn-Explode Spam.", function(message)
    local toggle = KAHHax.ServerOOFController.RE
    toggle = not toggle
    getgenv().chatSpyEnabled = not toggle
    vars.Notify('Respawn-Explode Spam Toggle:', (not toggle and "Disabled." or "Enabled."))
end)

addCMD("makepbaseplate", "Server OOF", Prefix.."makepbaseplate", "Makes a 'fake' baseplate.", function(message)
    KAHHax.ServerOOFController.phantomBaseplate()
    vars.Notify("Made Fake Baseplate.")
end)

addCMD("removepbaseplates", "Server OOF", Prefix.."removepbaseplates", "Removes all 'fake' baseplates.", function(message)
    KAHHax.ServerOOFController.removePhantomBaseplate()
    vars.Notify("Removed Fake Baseplates.")
end)

addCMD("paintarea", "Server OOF", Prefix.."paintarea | 255 0 0 (You may use BrickColor or RGB) | Obby Box", "Paints the specified section as the specified colour.", function(message)
    local splitString = string.split(message, " | ")
    if splitString[1] and splitString[2] and splitString[3] then
        local Colour 
        if string.gmatch(splitString[2], "%d") and not string.gmatch(splitString[2], "[%a%p%c]+") then
            Colour = Vector3.new(0, 0, 0)
            local colorSplit = string.split(splitString[2], " ")
            if colorSplit[1] and tonumber(colorSplit[1]) then Colour.X = colorSplit[1] end
            if colorSplit[2] and tonumber(colorSplit[2]) then Colour.Y = colorSplit[2] end
            if colorSplit[3] and tonumber(colorSplit[3]) then Colour.Z = colorSplit[3] end
        end
        KAHHax.ServerOOFController.paintServer(Color, splitString[3])
    else
        vars.Alert("Invalid Arguments!")
    end
end)

addCMD("tlag", "Server OOF", Prefix.."tlag EpicGamer69", "Toggles lagging player.", function(message)
    local splitString = string.split(message, " ")
    if splitString[1] and splitString[2] then
        getgenv().chatSpyEnabled = not toggle
        KAHHax.ServerOOFController.toggleLagUser(splitString[2])
    else
        vars.Alert("Invalid Arguments!")
    end
end)

addCMD("svrlag", "Server OOF", Prefix.."svrlag", "Toggles lagging the whole server", function(message)
    local toggle = KAHHax.ServerOOFController.lagServer
    getgenv().chatSpyEnabled = toggle
    toggle = not toggle
    vars.Notify('Lag Server Toggle:', (not toggle and "Disabled." or "Enabled."))
end)

addCMD("spam", "Server OOF", Prefix.."spam kill all", "Spams a message", function(message)
    local Str = Prefix.."spam  "
    local spamString = string.sub(message, #Str)
    getgenv().chatSpyEnabled = false
    addToSpamList(spamString)
end)

addCMD("rspam", "Server OOF", Prefix.."rspam kill all", "Removes a spam message", function(message)
    local Str = Prefix.."rspam  "
    local spamString = string.sub(message, #Str)
    if #vars.SpamList < 1 then getgenv().chatSpyEnabled = true end
    removeSpamPhrase(spamString)
end)

addCMD("blphrase", "Server OOF", Prefix.."blphrase | EpicGamer69 | kill all | reset all", "When Player says Phrase, Punishment is said", function(message)
    local splitString = string.split(message, " | ")
    if splitString[1] and splitString[2] and splitString[3] and splitString[4] then
        blacklistPhrase(splitString[2], splitString[3], splitString[4])
    else
        vars.Alert("Invalid Arguments!")
    end
end)

addCMD("rblphrase", "Server OOF", Prefix.."rblphrase | EpicGamer69 | kill all", "Remove Blacklisted Phrase", function(message)
    local splitString = string.split(message, " | ")
    if splitString[1] and splitString[2] and splitString[3]then
        removeBlacklistedPhrase(splitString[2], splitString[3])
    else
        vars.Alert("Invalid Arguments!")
    end
end)

-- // CMDs: Music Commands
addCMD("getmusic", "Music Commands", Prefix.."getmusic", "Prints all of the playable music", function(message)
    vars.MusicAPI.returnMusic(false)
end)

addCMD("refreshmusic", "Music Commands", Prefix.."refreshmusic", "Refreshes the music table", function(message)
    vars.MusicAPI.refreshSounds()
end)

addCMD("play", "Music Commands", Prefix.."play 53", "Plays the sound indexed at the number", function(message)
    local SoundId
    local stringSplit = string.split(message, " ")
    if stringSplit[1] and splitString[2] and tostring(splitString[2]) and vars.MusicAPI.getSound(tostring(splitString[2])) then
        vars.Chat(":music "..vars.MusicAPI.getSound(tonumber(splitString[2])))
        vars.Notify("Now Playing: "..vars.MusicAPI.getSoundName(tonumber(splitString[2])))
    else
        vars.Alert("Invalid Arguments!")
    end
end)

-- // CMDs: Misc. Commands
addCMD("rj", "Misc", Prefix.."rj", "Rejoins the game", function(message)
    game:GetService('TeleportService'):Teleport(game.PlaceId)
end)

addCMD("execute", "Misc", Prefix.."execute print('hi'))", "Executes whatever you want", function(message)
    local Str = Prefix.."execute  "
    loadstring(string.sub(message, #Str, -1))()
end)

addCMD("copycmds", "Misc", Prefix.."copycmds", "Copys all of the commands to your clipboard", function(message)
    local Holder = ""
    for i,v in pairs(KAHHax.CMDs) do
        Holder = Holder..v.CommandName.." - Module: "..v.ModuleName.." - Description: "..v.Description.." - Example: "..v.Example.."\n"
    end
    setclipboard(Holder)
end)

-- // CMDs: Misc. Commands - CMD GUI
addCMD("xcmds", "Misc", Prefix.."xcmds", "Shows all of the CMDs", function(message)
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
        Clone.Text = "    > "..Prefix..v.CommandName.." - "..v.Description
        Clone.Parent = CMDFrame
        Clone.Visible = true 
    end
    clone:Destory()

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

warn("Loaded oofkohls v2 - Made by Stefanuk12#5820 | Stefanuk12")