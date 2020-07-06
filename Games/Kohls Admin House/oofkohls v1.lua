if game.PlaceId == 112420803 then
    warn('oofkolhs: Loading...')
    local NotificationHandler = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Notifications/Script.lua"))()
    NotificationHandler["StorageLocation"] = game:GetService("CoreGui")
    NotificationHandler.newNotification("ALERT", "You are using oofkohls v1! Please use the updated version. Get it at: bit.ly/oofkohlsv2", "Alert")

    local library = loadstring(game:HttpGet("https://pastebin.com/raw/DnDhCpxd", true))()
    library.options.underlinecolor = "rainbow"
    local admin = library:CreateWindow('Admin')
    local serverd = library:CreateWindow('Server OOF')
    local soundoof = library:CreateWindow('Sound Abuse')
    local extra = library:CreateWindow('Extra')
    local credits = library:CreateWindow("Credits")
    credits:Section('pls no leech')
    credits:Button("Made By Stefanuk12#5820", function()
        print("Made By Stefanuk12#5820")
    end)

    fireclickdetector = fireclickdetector or click_detector
    --
    banned = {""}
    local character = game:GetService("Players").LocalPlayer.Character
    local AdminFolder = game:GetService("Workspace")["Terrain"]["_Game"]["Admin"]
    local plr = game:GetService("Players").LocalPlayer
    function isPerm()
        return game:GetService("MarketplaceService"):UserOwnsGamePassAsync(tonumber(game:GetService("Players").LocalPlayer.UserId), 66254)
    end
    _G.chatt = true
    local chatloop = function(chat1, chat2)
        local chatloopcoroutine = coroutine.wrap(function()
            while wait() do
                if _G.chatt == true then break end
                game:GetService("Players"):Chat(chat1)
                game:GetService("Players"):Chat(chat2)
            end
        end)()
    end

    local crashhser = function()
        local crashservercoroutine = coroutine.wrap(function()
            while wait() do
                game:GetService("Players"):Chat("swagify all")
            end
        end)()
    end

    local function ServerCheck()
        if AdminFolder:FindFirstChild("Regen") and AdminFolder.Regen:FindFirstChild("ClickDetector") then
          fireclickdetector(AdminFolder.Regen.ClickDetector, 0)
          wait(0.1)
          if AdminFolder.Pads:FindFirstChild("Touch to get admin") then
            if AdminFolder.Pads["Touch to get admin"]:FindFirstChild("Head") then
              return true
            else
              return false
            end
          else
            return false
          end
        else
          return false
        end
      end

    local function SendNotification(title,text,duration,...)
        game.StarterGui:SetCore("SendNotification", {
          Title = title;
          Text = text;
          Icon = "";
          Duration = duration;
        })
    end
    if isPerm() == false then do
        if ServerCheck() then
			print('oofkolhs: Got Admin!')
            local pad = AdminFolder.Pads["Touch to get admin"].Head
            local currentpos = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position
            game:GetService("Players").LocalPlayer.Character:MoveTo(pad.Position)
            wait(1)
            game:GetService("Players").LocalPlayer.Character:MoveTo(currentpos) -- Gives you Admin
        else
            SendNotification("Unable to Teleport","No Admin Pads available")
        end
    end
    end
    
    game:GetService("Players"):Chat("clr")
    -- admin menu
    admin:Section('General')
    -- admin menu: general
    local tpadmin = admin:Button("Get Admin", function()
        if ServerCheck() then
          local pad = AdminFolder.Pads["Touch to get admin"].Head
          local currentpos = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position
          game:GetService("Players").LocalPlayer.Character:MoveTo(pad.Position)
          wait(1)
          game:GetService("Players").LocalPlayer.Character:MoveTo(currentpos) -- Gives you Admin
        else
          SendNotification("Unable to Teleport","No Admin Pads available")
        end
    end)
    local regenadmin = admin:Button("Regen Admin Pads", function()
        if ServerCheck() then else SendNotification("Regen Failed", "Regen Pad unavailble.") end
    end)

    --[[local shutdown = admin:Button("Shutdown", function()
        local times = 10
        for i = 1, times do
            for i,v in pairs(game.Players:GetChildren()) do
                if v.Name ~= plr.Name then
                    local remote = plr.Backpack:WaitForChild("Delete"):WaitForChild("delete")
                    wait(0.1)
                    remote:FireServer(v)
                end
            end
        plr:Kick("Game has shutdown.")
    end
    end)]]

    visiblespawnpadstoggle = false
    local visiblespawnpads = admin:Toggle('Visible Spawn Pads', {flag = "visiblespawnpads"}, function()
        if visiblespawnpadstoggle == false then 
            visiblespawnpadstoggle = true
        else
            visiblespawnpadstoggle = false
        end

        if visiblespawnpadstoggle == true then do
            print('Visible Spawn Pads: Enabled')
            for i,v in pairs(game["Workspace"]["Terrain"]["_Game"]["Workspace"]:GetChildren()) do
                    for i = 1, 1 do
                        if v:IsA("SpawnLocation") then do
                            v.Transparency = 0
                        end end
                    end
                end
            end
        end

        if visiblespawnpadstoggle == false then do
            print('Visible Spawn Pads: Disabled')
            for i,v in pairs(game["Workspace"]["Terrain"]["_Game"]["Workspace"]:GetChildren()) do
                    for i = 1, 1 do
                        if v:IsA("SpawnLocation") then do
                            v.Transparency = 1
                        end end
                    end
                end
            end
		end
    end)

    slocktoggle = false
    --[[local slock = admin:Toggle('Slock', {flag = "slock"}, function()
        if slocktoggle == false then
            slocktoggle = true
        else
            slocktoggle = false
        end

        if slocktoggle == true then do
            print('Slock: Enabled')
            game:GetService("Players").PlayersAdded:connect(function(slockedplr)
                local remote = plr:WaitForChild("Backpack"):WaitForChild("Delete"):WaitForChild("delete")
                remote:FireServer(slockedplr)
                warn("Slock:", slockedplr.Name, " - Slocked")
            end)
        end
        end
        
        if slocktoggle == false then do
            print('Slock: Disabled')
        end
        end
    end)]]

    workspaceunlocktoggle = false
    local workspaceunlock = admin:Toggle('Workspace Unlock', {flag = "workspaceunlock"}, function()
        if workspaceunlocktoggle == false then
            workspaceunlocktoggle = true
        else
            workspaceunlocktoggle = false
        end

        if workspaceunlocktoggle == true then do
            function unlockall(root)
                for _,v in pairs(root:GetChildren()) do
                    if v:IsA("Part") then
                        v.Locked = false
                    end
                    unlockall(v)
                end
                end
            unlockall(game.Workspace)
            print('Workspace Unlock: Enabled')
            end
			end  

        if workspaceunlocktoggle == false then do
            function lockall(root)
                for _,v in pairs(root:GetChildren()) do
                    if v:IsA("Part") then
                        v.Locked = true
                    end
                lockall(v)
                end
                end
                lockall(game.Workspace)
                print('Workspace Unlock: Disabled')
               end
			   end
    end)
            

    autobtoolstoggle = false
    --[[local autobtools = admin:Toggle('Auto Btools', {flag = "autobtools"}, function()
        if autobtoolstoggle == false then
            autobtoolstoggle = true
			print('AutoBtools: Enabled')
        else
            autobtoolstoggle = false
			print('AutoBtools: Disabled')
        end

        if autobtoolstoggle == true then do
            game.Players:Chat("btools me")
			print('AutoBtools: Gave Btools')
            game.Players.LocalPlayer.CharacterAdded:connect(function(player)
                if player.Name == game.Players.LocalPlayer.Name then
                    game.Players:Chat("btools me")
					print('AutoBtools: Gave Btools')
                end
            end)
        end
		end
    end)]]

    persistantadmintoggle = false
    local persistantadmin = admin:Toggle('Persistant Admin', {flag = "persistantadmin"}, function()
        if persistantadmintoggle == false then
            persistantadmintoggle = true
        else
            persistantadmintoggle = false
        end

        if persistantadmintoggle == true then do
            local persistantadmincoroutine = coroutine.wrap(function()
                print('Persistant Admin: Enabled')
                if ServerCheck() then
                    local pad = game:GetService("Workspace")["Terrain"]["_Game"]["Admin"]["Pads"]["Touch to get admin"]
                    if pad:FindFirstChild(" ") then
                        pad[" "]:destroy()
                    end
                    while wait() do
                        if persistantadmintoggle == true then break end
                        pad.Head.Size = Vector3.new(0.1,0.1,0.1)
                        pad.Head.CanCollide = false
                        pad.Head.CFrame = CFrame.new(character["Left Leg"].Position)
                    end
                end
            end)()
        end
        end
    

        if persistantadmintoggle == false then do
            print('Persistant Admin: Disabled')
        end
        end
    end)

    -- admin menu: player menu
    admin:Section('Player Menu')
    local plrarray = game.Players:GetPlayers() 
    local Players = game:GetService("Players")
    list1 = {}

    for i=1, #plrarray do
        table.insert(list1, plrarray[i].Name)
    end

    Players.PlayerAdded:Connect(function(player)
        table.insert(list1, player.Name)
        print(player, "has joined and added to the Dropdown")
    end)

    Players.PlayerRemoving:Connect(function(player) 
        for i,v in pairs(list1) do 
            if v == player.Name then
                table.remove(list1, i)
                print(v, "has been removed from the Dropdown")
            end
        end
    end)

    local PlayerList = admin:Dropdown("Players", {
    location = _G;
    flag = "selectplr";
    list = list1;
    }, function(new)
    print(_G.selectplr, "selected.") 
    end)

    --[[local kick1button = admin:Button("Kick Player", function()
        local remote = plr:WaitForChild("Backpack"):WaitForChild("Delete"):WaitForChild("delete")
        remote:FireServer(game:GetService("Players")[_G.selectplr])
        print(_G.selectplr, "has been kicked.")
    end)

    local kickallbutton = admin:Button("Kick All", function()
        for i,v in pairs(game.Players:GetPlayers()) do
            if v.Name ~= plr.Name then
                local remote = plr:WaitForChild("Backpack"):WaitForChild("Delete"):WaitForChild("delete")
                remote:FireServer(v)
            end		
        end
        print("Everyone has been kicked.")
    end)

    local ban1button = admin:Button("Ban Player", function()
        table.insert(banned, _G.selectplr)
        local remote = plr:WaitForChild("Backpack"):WaitForChild("Delete"):WaitForChild("delete")
        remote:FireServer(game:GetService("Players")[_G.selectplr])
        print(_G.selectplr, "has been banned.")
    end)]]

    respawnexplodeplayertoggle = false
    local respawnexplodeplayertoggle = admin:Toggle("Respawn + Explode Player", {flag = 'respawnexplodeplayer'}, function()
        if respawnexplodeplayertoggle == false then
            respawnexplodeplayertoggle = true
        else
            respawnexplodeplayertoggle = false
        end

        if respawnexplodeplayertoggle == true then do
            local respawnexplodeplayercoroutine = coroutine.wrap(function()
                print('Respawn + Explode: Enabled for', _G.selectplr)
                while wait() do
                    if respawnexplodeplayertoggle == false then break end
                    game:GetService("Players"):Chat("explode "..tostring(_G.selectplr))
				    wait()
                    game:GetService("Players"):Chat("respawn "..tostring(_G.selectplr))
                end
            end)()
        end 
        end

		if respawnexplodeplayertoggle == false then do 
			print('Respawn + Explode: Disabled for', _G.selectplr)
		end
		end
	end)
    -- extra menu
    extra:Section('epic')
    -- extra menu: epic
    antipunishtoggle = false
    local antipunish = extra:Toggle('Anti Punish', {flag = 'antipunish'}, function()
        if antipunishtoggle == false then
            antipunishtoggle = true
        else
            antipunishtoggle = false
        end

        if antipunishtoggle == true then do
            print('Anti Punish: Enabled')
            local antipunishcoroutine = coroutine.wrap(function()
                while wait() do
                    if antipunishtoggle == false then break end
                    if game:GetService("Workspace"):FindFirstChild(tostring(game:GetService("Players").LocalPlayer.Name)) == nil then
                        game:GetService("Players"):Chat("reset me")
                        wait(0.2)
                    end
                end
            end)() 
        end
        end
        
        if antipunishtoggle == false then do
            print('Anti Punish: Disabled')
        end
        end
    end)

    local antikilltoggle = false
    local antikill = extra:Toggle('Anti Kill', {flag = 'antikill'}, function()
        if antikilltoggle == false then
            antikilltoggle = true
        else
            antikilltoggle = false
        end
        local connection
        if antikilltoggle == true then do
            print('Anti Kill: Enabled')
            characteraddedconnect = game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function(character)
                humanoiddiedconnect = character:WaitForChild("Humanoid").Died:Connect(function()
                    game:GetService("Players"):Chat("reset me")
                end)
            end)
        end
        end

        if antikilltoggle == false then do
            print('Anti Kill: Disabled')
			characteraddedconnect:Disconnect()
        end
        end
	end)
    
    local antiblindtoggle = false
    local antiblind = extra:Toggle('Anti Blind', {flag = 'antiblind'}, function()
        if antiblindtoggle == false then
            antiblindtoggle = true
        else
            antiblindtoggle = false
        end

        if antiblindtoggle == true then do
            print('Anti Blind: Enabled')
            local antiblindcoroutine = coroutine.wrap(function()
                while wait() do
                    if antiblindtoggle == false then break end
                    for _,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui:GetChildren()) do
                        if v.Name == "EFFECTGUIBLIND" then
                            game:GetService("Players"):Chat("unblind all")
                        end
                    end
                end
            end)()
        end
        end

        if antiblindtoggle == false then
            print('Anti Blind: Disabled')
        end
    end)

    local silentcmd = extra:Button("Silent Commands", function()
        loadstring(game:HttpGet('https://pastebin.com/raw/dV9qycU5', true))()
    end)

    local geargiver = extra:Button("Gear Giver", function()
        loadstring(game:HttpGet('https://pastebin.com/raw/9x3yet05', true))()
        SendNotification("Gear Giver", ":givehelp for available gears")
    end)
    -- serverd menu
    serverd:Section('Abusive Menu')
    -- serverd menu: server crashing
    --[[local clipm = serverd:Button("Crash Server", function()
        crashhser()
    end)]]

    local gamefolder = game:GetService("Workspace").Terrain["_Game"]
    local spawn1 = gamefolder.Workspace.Spawn1
    function movePart(part)
        local newcframe = part.CFrame * CFrame.new(0, 2, 0)
        local players = game:GetService("Players")
        local character = players.LocalPlayer.Character

        character:WaitForChild("HumanoidRootPart").CFrame = newcframe
        wait(1)
        character:WaitForChild("Humanoid").Sit = true
        wait(0.5)
        players:Chat("punish me")
        wait(4)
        players:Chat("unpunish me")
    end

    partspamtoggle = false
    local partspam = serverd:Toggle("Part Spam", {flag = 'partspam'}, function()
        if partspamtoggle == false then
            partspamtoggle = true
        else
            partspamtoggle = false
        end

        if partspamtoggle == true then do
            print('Part Spam: Enabled')
            local partspamcoroutine = coroutine.wrap(function()
                while wait(0.2) do
                    if partspamtoggle == false then break end
                    game:GetService("Players"):Chat("part/10/10/10")
                end
            end)()
        end
        end

        if partspamtoggle == false then
            print('Part Spam: Disabled')
        end
    end)
    
    respawnexplodetoggle = false
    local respawnexplode = serverd:Toggle("Respawn + Explode", {flag = 'respawnexplode'}, function()
        if respawnexplodetoggle == false then
            respawnexplodetoggle = true
        else
            respawnexplodetoggle = false
        end

        if respawnexplodetoggle == true then do
            local respawnexplodecoroutine = coroutine.wrap(function()
                print('Respawn + Explode: Enabled')
                while wait() do
                    if respawnexplodetoggle == false then break end
                    game:GetService("Players"):Chat("respawn others")
				    wait()
                    game:GetService("Players"):Chat("explode others")
                end
            end)()
        end 
        end
        
        if respawnexplodetoggle == false then do
            print('Respawn + Explode: Disabled')
        end
        end
    end)

    serverd:Button("Move Baseplate", function()
        movePart(spawn1)
        wait(0.5)
        game:GetService("Players"):Chat("skydive me")
    end)
    
    serverd:Section("Colour Change")
    serverd:Dropdown("Colours", {
        location = _G;
        flag = "selectcolour";
        list = {
            "";
            "Rainbow";
            "Random";
            "White";
            "Gray";
            "Dark gray";
            "Black";
            "Bright red";
            "Bright yellow";
            "Bright green";
            "Bright blue";
        }
    }, function(new)
        print("oofkohls: Selected Colour:",_G.selectcolour)
    end)

    rainbowcolour = Color3.fromHSV(1, 1, 1)
    local rainbowroad = coroutine.wrap(function()
        while wait() do
            local hue = tick() % 5 / 5
            rainbowcolour = Color3.fromHSV(hue, 1, 1)
        end
    end)()
    
    

    local v1 = "PaintPart"
    serverd:Button("Start", function()
        function transformToColor3(col) --Function to convert, just cuz c;
            local r = col.r --Red value
            local g = col.g --Green value
            local b = col.b --Blue value
            return Color3.new(r,g,b); --Color3 datatype, made of the RGB inputs
        end

        game:GetService("Players"):Chat(":gear me 18474459")
        wait(0.5)
        game:GetService("Players").LocalPlayer.Character.Humanoid:EquipTool(game:GetService("Players").LocalPlayer.Backpack.PaintBucket)
        local remote = game:GetService("Workspace")[game:GetService("Players").LocalPlayer.Name].PaintBucket:WaitForChild("Remotes").ServerControls

        if _G.selectcolour == "Rainbow" then do
            for i,v in pairs(game:GetService("Workspace").Terrain:GetDescendants()) do
                if v:IsA("Part") then
                    local v2 =
                    {
                        ["Part"] = v,
                        ["Color"] = rainbowcolour
                    }
                    remote:InvokeServer(v1, v2)
                end
            end
        end
        end

        if _G.selectcolour == "Random" then do
            for i,v in pairs(game:GetService("Workspace").Terrain:GetDescendants()) do
                if v:IsA("Part") then
                    local v2 =
                    {
                        ["Part"] = v,
                        ["Color"] = Color3.new(math.random(0, 255), math.random(0, 255), math.random(0, 255))
                    }
                    remote:InvokeServer(v1, v2)
                end
            end
        end
        end

        if _G.selectcolour ~= "Random" and _G.selectcolour ~= "Rainbow" then do
            for i,v in pairs(game:GetService("Workspace").Terrain:GetDescendants()) do
                if v:IsA("Part") then
                    local v2 =
                    {
                        ["Part"] = v,
                        ["Color"] = transformToColor3(BrickColor.new(tostring(_G.selectcolour)))
                    }
                    remote:InvokeServer(v1, v2)
                end
            end
        end
        end
        print("Painted everything as:", _G.selectcolour)
        end)


        soundoof:Section('General')

        soundoof:Button("Play All Sounds", function()
            print('oofkohls: Played All Sounds.')
            for i,v in pairs(game:GetDescendants()) do
                if v:IsA("Sound") then
                    v:Play()
                end
            end
        end)

        soundoof:Button("Stop All Sounds", function()
            print('oofkohls: Stopped All Sounds.')
            for i,v in pairs(game:GetDescendants()) do
                if v:IsA("Sound") then
                    v:Stop()
                end
            end
        end)

        soundoof:Button("Play Music", function()
            print('oofkohls: Played Music.')
            for i,v in pairs(game:GetService("Workspace").Terrain["_Game"].Folder:GetDescendants()) do
                if v:IsA("Sound") then
                    v:Play()
                end
            end
        end)

        soundoof:Button("Stop Music", function()
            print('oofkohls: Stopped Music.')
            for i,v in pairs(game:GetService("Workspace").Terrain["_Game"].Folder:GetDescendants()) do
                if v:IsA("Sound") then
                    v:Stop()
                end
            end
        end)

        soundoof:Section('Fun')

        earrapesound = false
        local Earrapetoggle = soundoof:Toggle("Earrape", {flag = 'Earrapetoggle'}, function()
            if earrapesound == false then
                earrapesound = true
            else
                earrapesound = false
            end

            if earrapesound == true then do
                print('oofkohls: Earrape Enabled')
                local earrapesoundcoroutine = coroutine.wrap(function()
                    while wait(0.25) do
                        if earrapesound == false then break end
                        for i,v in pairs(game:GetDescendants()) do
                            if v:IsA("Sound") then
                                v:Play()
                            end
                        end
                    end
                end)()
            end
            end

            if earrapesound == false then
                print('oofkohls: Earrape Disabled')
            end
        end)
        
    print('oofkohls: Loaded!')
    print('Made by Stefanuk12#5820!')
end