if not getgenv()["KAHHax"] then getgenv()["KAHHax"] = {} end
if not KAHHax["intAdmin"] then
    function KAHHax.regenAdmin()
        local Regen = game:GetService("Workspace").Terrain["_Game"]["Admin"].Regen
        fireclickdetector(Regen.ClickDetector, 0)
        print('Regened Admin.')
    end
    KAHHax.regenAdmin()
    wait(0.1)
    function KAHHax.getAdmin()
        if not game:GetService("Workspace").Terrain["_Game"]["Admin"].Pads:FindFirstChild("Touch to get admin") then
            KAHHax.regenAdmin()
            wait(0.1)
        end
        firetouchinterest(game:GetService("Players").LocalPlayer.Character["Left Leg"], game:GetService("Workspace").Terrain["_Game"]["Admin"].Pads:FindFirstChild("Touch to get admin").Head, 0)
        print('Got Admin.')
    end

    coroutine.wrap(function()
        KAHHax.regenAdmin()
        local Pad = game:GetService("Workspace").Terrain["_Game"]["Admin"].Pads:FindFirstChildWhichIsA("Model")
        local Clone = Pad:Clone()
        Clone.Parent = game:GetService("Workspace").Terrain["_Game"]["Admin"].Pads
        if Pad.Head:FindFirstChildWhichIsA("Humanoid") then Pad.Head:FindFirstChildWhichIsA("Humanoid"):Destroy() end
        while wait() do 
            if KAHHax.PersistantAdmin and game:GetService("Players").LocalPlayer.Character:FindFirstChild("Left Leg") then
                if string.match(Pad.Name, "admin") and (Pad.Head.BrickColor == BrickColor.new("Really red") and not string.match(Pad.Name, game:GetService("Players").LocalPlayer.Name)) then
                    KAHHax.regenAdmin()
                end
                Pad.Head.Size = Vector3.new(0.1, 0.1, 0.1)
                Pad.Head.CanCollide = false
                Pad.Head.Transparency = 1
                Pad.Head.CFrame = game:GetService("Players").LocalPlayer.Character:FindFirstChild("Left Leg").CFrame
                Clone.Head.BrickColor = BrickColor.new("Really red")
                Clone.Name = game:GetService("Players").LocalPlayer.Name.."'s admin"
            elseif not KAHHax.PersistantAdmin then
                Clone.Head.BrickColor = BrickColor.new("Bright green")
                Clone.Name = "Touch for admin"
            end
        end
    end)()

    KAHHax["intAdmin"] = true
end