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
        while wait() do 
            if KAHHax.PersistantAdmin and game:GetService("Players").LocalPlayer.Character:FindFirstChild("Left Leg") then
                local function stuff()
                    for i,v in pairs(game:GetService("Workspace").Terrain["_Game"]["Admin"].Pads:GetChildren()) do
                        local Pad = v
                        if string.match(Pad.Name, "admin") then
                            if Pad.Head.BrickColor == BrickColor.new("Really red") and not string.match(Pad.Name, game:GetService("Players").LocalPlayer.Name) then
                                KAHHax.regenAdmin()
                            end
                            Pad.Head.Size = Vector3.new(0.1, 0.1, 0.1)
                            Pad.Head.CanCollide = false
                            Pad.Head.CFrame = game:GetService("Players").LocalPlayer.Character:FindFirstChild("Left Leg").CFrame
                        end      
                        return 
                    end
                end
                stuff()
            end
        end
    end)()

    KAHHax["intAdmin"] = true
end