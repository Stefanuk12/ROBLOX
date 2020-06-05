function regenAdmin()
    local Regen = game:GetService("Workspace").Terrain["_Game"]["Admin"].Regen
    fireclickdetector(Regen.ClickDetector, 0)
end
function getAdmin()
    regenAdmin()
    wait(0.25)
    local Pad = game:GetService("Workspace").Terrain["_Game"]["Admin"].Pads:FindFirstChild("Touch to get admin")
    local PreviousPos = game:GetService("Players").LocalPlayer.Character.PrimaryPart.CFrame
    game:GetService("Players").LocalPlayer.Character.PrimaryPart.CFrame = Pad.Head.CFrame
    wait(1)
    game:GetService("Players").LocalPlayer.Character.PrimaryPart.CFrame = PreviousPos
end
function togglePersistantAdmin()
    getgenv().KAHHax.PersistantAdmin = not getgenv().KAHHax.PersistantAdmin
    if getgenv().KAHHax.PersistantAdmin then
        getgenv().KAHHax.PersistantAdmin = false
        return
    else
        regenAdmin()
        while wait() do 
            if getgenv().KAHHax.PersistantAdmin then
                local Pad = game:GetService("Workspace").Terrain["_Game"]["Admin"].Pads:FindFirstChild("Touch to get admin").Head
                firetouchinterest(game:GetService("Players").LocalPlayer.Character["Left Leg"], Pad, 0)
            end
        end
    end
end