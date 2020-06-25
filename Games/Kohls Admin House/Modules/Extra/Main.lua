-- // Main Controller Script for the Extra Module

-- // Initialise
if not getgenv()["KAHHax"] then getgenv()["KAHHax"] = {} end
if not getgenv()["KAHHax"]["InitialisedModules"] then getgenv()["KAHHax"]["InitialisedModules"] = {} end
KAHHax.ExtraController = {}
local ExtraController = KAHHax.ExtraController

loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Kohls%20Admin%20House/CommonVariables.lua"))()-- // Common Vars
repeat wait() until KAHHax["vars"]
local vars = KAHHax["vars"]

if not KAHHax.InitialisedModules.Extra then
    ExtraController.antiPunish = false
    ExtraController.antiBlind = false
    ExtraController.antiKill = false
    ExtraController.antiJail = false
    local Character = vars.Character
    
    game:GetService("Lighting").ChildAdded:Connect(function(child) -- // Anti Punish
        if ExtraController.antiPunish and child.Name == vars.LocalPlayer.Name then
            vars.Chat(":reset me")
        end
    end)

    vars.LocalPlayer.PlayerGui.ChildAdded:Connect(function(child) -- // Anti Blind
        if ExtraController.antiBlind and child.Name == "EFFECTGUIBLIND" then
            wait(0.1)
            child:Destroy()
        end
    end)

    Character:WaitForChild("Humanoid").Died:Connect(function() -- // Anti Kill
        if ExtraController.antiKill then vars.Chat(":reset me") end
    end)

    vars.LocalPlayer.CharacterAdded:Connect(function(Character)
        Character:WaitForChild("Humanoid").Died:Connect(function() -- // Anti Kill
            if ExtraController.antiKill then vars.Chat(":reset me") end
        end)
    end)

    vars.HolderFolder.ChildAdded:Connect(function(child)
        if ExtraController.antiJail and child.Name == vars.LocalPlayer.Name.."'s jail" then
            vars.Chat(":removejails")
        end
    end)
    KAHHax.InitialisedModules.Extra = true
end