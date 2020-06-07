if not getgenv()["KAHHax"] then getgenv()["KAHHax"] = {} end
if not KAHHax["intAdmin"] then
    function KAHHax.regenAdmin()
        local Regen = game:GetService("Workspace").Terrain["_Game"]["Admin"].Regen
        fireclickdetector(Regen.ClickDetector, 0)
        print('Regened Admin.')
    end
    function KAHHax.getAdmin()
        KAHHax.regenAdmin()
        wait(0.25)
        local Pad = game:GetService("Workspace").Terrain["_Game"]["Admin"].Pads:FindFirstChild("Touch to get admin")
        local PreviousPos = game:GetService("Players").LocalPlayer.Character.PrimaryPart.Position
        game:GetService("Players").LocalPlayer.Character:MoveTo(Pad.Head.Position)
        wait(1)
        game:GetService("Players").LocalPlayer.Character:MoveTo(PreviousPos)
        print('Got Admin.')
    end
    function KAHHax.togglePersistantAdmin()
        KAHHax.PersistantAdmin = not KAHHax.PersistantAdmin
        print('Persistant Admin Toggle:', (not KAHHax.PersistantAdmin and "Disabled." or "Enabled."))
        if KAHHax.PersistantAdmin then
            KAHHax.regenAdmin()
            local Pad = game:GetService("Workspace").Terrain["_Game"]["Admin"].Pads:FindFirstChild("Touch to get admin").Head
            coroutine.wrap(function()
                while wait() do 
                    if not KAHHax.PersistantAdmin then break end
                    if Pad.Parent.Name == "Touch to get admin" then
                        firetouchinterest(game:GetService("Players").LocalPlayer.Character["Left Leg"], Pad, 0)
                    end
                end
            end)()
        end
    end

    KAHHax["intAdmin"] = true
end