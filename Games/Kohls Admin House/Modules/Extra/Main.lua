if not getgenv()["KAHHax"] then getgenv()["KAHHax"] = {} end
if not KAHHax["antiModule"] then
    KAHHax.antiPunish = false
    KAHHax.antiBlind = false
    KAHHax.antiKill = false
    local Character = game:GetService("Players").LocalPlayer.Character or game:GetService("Players").LocalPlayer.CharacterAdded:Wait()

    game:GetService("Lighting").ChildAdded:Connect(function(child) -- // Anti Punish
        if KAHHax.antiPunish and child.Name == game:GetService("Players").LocalPlayer.Name then
            game:GetService("Players"):Chat(":reset me")
        end
    end)

    game:GetService("Players").LocalPlayer.PlayerGui.ChildAdded:Connect(function(child) -- // Anti Blind
        if KAHHax.antiBlind and child.Name == "EFFECTGUIBLIND" then
            wait(0.1)
            child:Destroy()
        end
    end)

    Character:WaitForChild("Humanoid").Died:Connect(function() -- // Anti Kill
        if KAHHax.antiKill then game:GetService("Players"):Chat(":reset me") end
    end)
    game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function(Character)
        Character:WaitForChild("Humanoid").Died:Connect(function() -- // Anti Kill
            if KAHHax.antiKill then game:GetService("Players"):Chat(":reset me") end
        end)
    end)
    KAHHax["antiModule"] = true
end