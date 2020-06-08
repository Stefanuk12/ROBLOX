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
        KAHHax.regenAdmin()
        wait(0.1)
        firetouchinterest(game:GetService("Players").LocalPlayer.Character["Left Leg"], KAHHax.Pad.Head, 0)
        print('Got Admin.')
    end
    function xor (a, b)
        if a ~= b then return true else return false end
    end
    coroutine.wrap(function()
        while wait() do 
            if KAHHax.PersistantAdmin then
                if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Left Leg") then
                    if xor(KAHHax.Pad.Name ~= tostring(game:GetService("Players").LocalPlayer.Name.."'s admin"), KAHHax.Pad.Name ~= "Touch to get admin") then
                        KAHHax.regenAdmin()
                    end
                    wait(0.25)
                    firetouchinterest(game:GetService("Players").LocalPlayer.Character["Left Leg"], KAHHax.Pad.Head, 0)
                end
            end
        end
    end)()

    KAHHax["intAdmin"] = true
end