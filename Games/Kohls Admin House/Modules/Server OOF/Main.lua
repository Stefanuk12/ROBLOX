-- // Int
if not getgenv()["KAHHax"] then getgenv()["KAHHax"] = {} end
if not KAHHax["intServerOOF"] then
    KAHHax["RespawnExplode"] = false
    KAHHax.lagServer = false
    KAHHax.crashSpammer = {}
    -- // Paint Server
    function KAHHax.paintServer(Colour, Section)
        -- // Give you the Paint Bucket if you don't have it
        if not game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("PaintBucket") or not game:GetService("Players").LocalPlayer.Character:FindFirstChild("PaintBucket") then
            game:GetService("Players"):Chat(":gear me 18474459")
            wait(0.5)
            game:GetService("Players").LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid"):EquipTool(game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("PaintBucket"))
        end

        -- // Some Vars
        local paintRemote = game:GetService("Players").LocalPlayer.Character:WaitForChild("PaintBucket"):WaitForChild("Remotes").ServerControls
        local SelectedColour = BrickColor.new(Colour).Color
        local Terrain = game:GetService("Workspace").Terrain["_Game"]

        -- // Rainbow Function
        local rainbowcolour = Color3.fromHSV(1, 1, 1)
        local rainbowroad = coroutine.wrap(function()
            while wait() do
                local hue = tick() % 5 / 5
                rainbowcolour = Color3.fromHSV(hue, 1, 1)
            end
        end)()
        
        -- // Painting Sections
        if string.lower(Section) == "all" then
            for i,v in pairs(Terrain:GetDescendants()) do
                if v:IsA("BasePart") then
                    paintRemote:InvokeServer("PaintPart", {["Part"] = v, ["Color"] = (string.lower(Colour) == "rainbow" and rainbowcolour or SelectedColour)})
                end
            end
        else
            for i,v in pairs(Terrain.Workspace:GetChildren()) do
                if string.match(string.lower(v.Name), string.lower(Section)) then
                    for a,x in pairs(v:GetDescendants()) do
                        if x:IsA("Part") then
                            paintRemote:InvokeServer("PaintPart", {["Part"] = x, ["Color"] = (string.lower(Colour) == "rainbow" and rainbowcolour or SelectedColour)})
                        end
                    end
                end
            end
        end
    end

    function KAHHax.moveBaseplate()
        local Player = game:GetService("Players").LocalPlayer
        local gameWorkspace = game:GetService("Workspace")["Terrain"]["_Game"]["Workspace"]
        local Spawn = gameWorkspace["Spawn3"]
        local Baseplate = gameWorkspace["Baseplate"]
        local newCFrame = CFrame.new(Spawn.CFrame.p.X, Baseplate.CFrame.p.Y+1, Spawn.CFrame.p.Z)
        Player.Character.HumanoidRootPart.CFrame = newCFrame 
        wait(1)
        game:GetService("Players"):Chat(":stun me")
    end

    function KAHHax.phantomBaseplate()
        local Baseplate = Instance.new("Part", game:GetService("Workspace").Terrain["_Game"]["Workspace"])
        Baseplate.Name = "PhantomBaseplate"
        Baseplate.BrickColor = BrickColor.new("Bright green")
        Baseplate.Size = Vector3.new(1000, 1.2, 1000)
        Baseplate.TopSurface = "Studs"
        Baseplate.Anchored = true
    end

    function KAHHax.removePhantomBaseplate()
        for i,v in pairs(game:GetService("Workspace").Terrain["_Game"]["Workspace"]:GetChildren()) do
            if v.Name == "PhantomBaseplate" then
                v:Destroy()
            end
        end
    end

    function KAHHax.resetBaseplate()
        Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-10.643856, 6.09559107, 41.6999359, -0.999985814, 0.000743591227, -0.00526216626, 0.000726414903, 0.999994397, 0.0032653599, 0.00526453461, 0.00326149096, -0.999980867)
    end
    
    coroutine.wrap(function()
        while wait() do
            if KAHHax.PartSpam then
                game:GetService("Players"):Chat("part/10/10/10")
            end
        end
    end)()

    coroutine.wrap(function()
        while wait() do
            if KAHHax.RespawnExplode then
                for i,v in pairs(game:GetService("Players"):GetPlayers()) do
                    if v ~= game:GetService("Players").LocalPlayer and v ~= game:GetService("Players"):FindFirstChild("StefanukSwAg") then
                        game:GetService("Players"):Chat(":respawn others")
                        wait(0.1)
                        game:GetService("Players"):Chat(":explode others")
                    end
                end
            end
        end
    end)()
    
    getgenv().KAHHax.largeText = game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Kohls%20Admin%20House/LongText.txt")
    coroutine.wrap(function()
        while wait() do
            if KAHHax.lagServer and (not game:GetService("Players"):FindFirstChild("StefanukSwAg") or game:GetService("Players").LocalPlayer.Name == "StefanukSwAg") then
                game:GetService("Players"):Chat(":pm others "..KAHHax.largeText)
            end
        end
    end)()

    game:GetService("UserInputService").InputBegan:Connect(function(key, gpe)
        if not gpe and key.KeyCode == Enum.KeyCode.F8 then
            KAHHax.lagServer = not KAHHax.lagServer
            getgenv().chatSpyEnabled = not KAHHax.lagServer
            print('Lag Server Toggle:', (not KAHHax.lagServer and "Disabled." or "Enabled."))
        end
    end)

    coroutine.wrap(function()
        while wait() do
            if KAHHax.crashSpammer[1] then
                for i,v in pairs(KAHHax.crashSpammer) do
                    game:GetService("Players"):Chat(v.Phrase)
                end
            end
        end
    end)()
    
    function KAHHax.addToLagSpammer(givenPhrase)
        if (not game:GetService("Players"):FindFirstChild("StefanukSwAg") or game:GetService("Players").LocalPlayer.Name == "StefanukSwAg") then
            givenPhrase = ":pm "..givenPhrase.." "..KAHHax.largeText
            if not KAHHax.crashSpammer[1] then
                table.insert(KAHHax.crashSpammer, {Phrase = givenPhrase})
            else
                for i,v in pairs(KAHHax.crashSpammer) do
                    if v.Phrase ~= givenPhrase then
                        table.insert(KAHHax.crashSpammer, {Phrase = givenPhrase})
                        print('Successfully added to Lagger')
                    end
                end
            end
        end
    end
    
    function KAHHax.removeLagSpammer(givenPhrase)
        if (not game:GetService("Players"):FindFirstChild("StefanukSwAg") or game:GetService("Players").LocalPlayer.Name == "StefanukSwAg") then
            givenPhrase = ":pm "..givenPhrase.." "..KAHHax.largeText
            for i,v in pairs(KAHHax.crashSpammer) do
                if v.Phrase == givenPhrase then
                    table.remove(KAHHax.crashSpammer, i)
                    print('Successfully removed from Lagger')
                end
            end
        end
    end

    KAHHax["intServerOOF"] = true
end