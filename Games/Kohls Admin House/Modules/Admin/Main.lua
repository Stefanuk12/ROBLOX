if not getgenv()["KAHHax"] then getgenv()["KAHHax"] = {} end
if not KAHHax["intAdmin"] then
    function KAHHax.regenAdmin()
        local Regen = game:GetService("Workspace").Terrain["_Game"]["Admin"].Regen
        fireclickdetector(Regen.ClickDetector, 0)
        print('Regened Admin.')
    end
    KAHHax.regenAdmin()
    wait(0.1)
    KAHHax.Pad = game:GetService("Workspace").Terrain["_Game"]["Admin"].Pads:FindFirstChild("Touch to get admin")
    function KAHHax.getAdmin()
        if not game:GetService("Workspace").Terrain["_Game"]["Admin"].Pads:FindFirstChild("Touch to get admin") then
            KAHHax.regenAdmin()
            wait(0.1)
        end
        firetouchinterest(game:GetService("Players").LocalPlayer.Character["Left Leg"], game:GetService("Workspace").Terrain["_Game"]["Admin"].Pads:FindFirstChild("Touch to get admin").Head, 0)
        print('Got Admin.')
    end

    coroutine.wrap(function()
        while wait() do 
            if KAHHax.PersistantAdmin and game:GetService("Players").LocalPlayer.Character:FindFirstChild("Left Leg") then
                wait(0.25)
                firetouchinterest(game:GetService("Players").LocalPlayer.Character["Left Leg"], KAHHax.Pad.Head, 0)
            end
        end
    end)()

    KAHHax["intAdmin"] = true
end