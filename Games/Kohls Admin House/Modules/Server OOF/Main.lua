-- // Main Controller Script for the Server OOF Module

-- // Initialise
if not getgenv()["KAHHax"] then getgenv()["KAHHax"] = {} end
if not getgenv()["KAHHax"]["InitialisedModules"] then getgenv()["KAHHax"]["InitialisedModules"] = {} end

loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Kohls%20Admin%20House/CommonVariables.lua"))() -- // Common Vars
repeat wait() until KAHHax["vars"]

KAHHax.ServerOOFController = {}
local ServerOOFController = KAHHax.ServerOOFController
local vars = KAHHax["vars"]

if not KAHHax.InitialisedModules.ServerOOF then
    -- // Vars
    ServerOOFController.RE = false
    ServerOOFController.PS = false
    ServerOOFController.lagServer = false
    ServerOOFController.crashSpammer = {}

    -- // Paint Function
    function ServerOOFController.paintServer(Color, Section)
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
    end

    -- // Gets you stuck in the Baseplate so you can move it
    function ServerOOFController.moveBaseplate()
        local Spawn = vars.WorkspaceFolder.Spawn3
        local Baseplate = vars.WorkspaceFolder.Baseplate
        vars.Character.HumanoidRootPart.CFrame = CFrame.new(Spawn.Position.X, Baseplate.Position.Y + 1, Spawn.Position.Z)
        wait(1.5)
        vars.Chat(":stun me")
    end

    -- // Make a phantom/fake baseplate
    function ServerOOFController.phantomBaseplate()
        local Baseplate = Instance.new("Part", vars.WorkspaceFolder)
        Baseplate.Name = "PhantomBaseplate"
        Baseplate.BrickColor = BrickColor.new("Bright green")
        Baseplate.Size = Vector3.new(1000, 1.2, 1000)
        Baseplate.TopSurface = "Studs"
        Baseplate.Anchored = true
    end

    -- // Remove all phanton/fake baseplates
    function ServerOOFController.removePhantomBaseplate()
        for i,v in pairs(vars.WorkspaceFolder:GetChildren()) do
            if v.Name == "PhantomBaseplate" then
                v:Destroy()
            end
        end
    end

    -- // Functions for the PM Lag Spammer
    function ServerOOFController.toggleLagUser(targetUser)
        for i,v in pairs(vars.getPlayer(targetUser)) do
            if not vars.checkWhitelisted(v.UserId) then
                vars.PlayerManager[v.Name].Lagging = not vars.PlayerManager[v.Name].Lagging
                getgenv().chatSpyEnabled = not vars.PlayerManager[v.Name].Lagging
                vars.Notify(vars.PlayerManager[v.Name].Lagging and v.Name.." is being lagged." or v.Name.." has stopped being lagged.")
            end
        end
    end

    -- // Spam Coroutines
    ServerOOFController.RECoroutine = coroutine.wrap(function() -- // Respawn Explode Spam
        while wait() do
            if ServerOOFController.RE then
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

    ServerOOFController.PartCoroutine = coroutine.wrap(function() -- // Part Spam
        while wait() do
            if ServerOOFController.PS then
                if not game:GetService("MarketplaceService"):UserOwnsGamePassAsync(vars.LocalPlayer.UserId, 35748) then vars.Alert("You do not have Person299's Admin, cannot part spam!") end
                vars.Chat("part/10/10/10")
            end
        end
    end)()

    ServerOOFController.PMCoroutine = coroutine.wrap(function() -- // PM Lag Spammer
        while wait() do
            for i,v in pairs(vars.PlayerManager) do
                if v.Lagging then
                    vars.Chat(":pm "..i.." "..vars.largeText)
                end
            end
        end
    end)()

    ServerOOFController.SVRLagCoroutine = coroutine.wrap(function() -- // Server Lag
        while wait() do
            if ServerOOFController.lagServer and not vars.checkAllWhitelisted() then
                vars.Chat(":pm others "..vars.largeText)
            end
        end
    end)()

    KAHHax.InitialisedModules.ServerOOF = true
end