-- // Initialisation
KAHHax["Admin"] = {}
KAHHax["Admin"]["Functions"] = {}
KAHHax["Admin"]["Coroutines"] = {}
KAHHax["Admin"]["Toggles"] = {}
KAHHax["Admin"]["Toggles"].PersistantAdmin = false

-- // Script
function KAHHax["Admin"]["Functions"].regenAdmin()
    local Regen = game:GetService("Workspace").Terrain["_Game"]["Admin"].Regen
    fireclickdetector(Regen.ClickDetector, 0)
end
function KAHHax["Admin"]["Functions"].getAdmin()
    regenAdmin()
    wait(0.25)
    local Pad = game:GetService("Workspace").Terrain["_Game"]["Admin"].Pads:FindFirstChild("Touch to get admin")
    local PreviousPos = game:GetService("Players").LocalPlayer.Character.PrimaryPart.CFrame
    game:GetService("Players").LocalPlayer.Character.PrimaryPart.CFrame = Pad.Head.CFrame
    wait(1)
    game:GetService("Players").LocalPlayer.Character.PrimaryPart.CFrame = PreviousPos
end
function KAHHax["Admin"]["Functions"].togglePersistantAdmin()
    KAHHax["Admin"]["Toggles"].PersistantAdmin = not KAHHax["Admin"]["Toggles"].PersistantAdmin
    if KAHHax["Admin"]["Toggles"].PersistantAdmin then
        regenAdmin()
        KAHHax["Admin"]["Coroutines"].togglePersistantAdmin1 = coroutine.wrap(function()
            while wait() do 
                if not KAHHax["Admin"]["Toggles"].PersistantAdmin then break end
                if KAHHax["Admin"]["Toggles"].PersistantAdmin then
                    local Pad = game:GetService("Workspace").Terrain["_Game"]["Admin"].Pads:FindFirstChild("Touch to get admin").Head
                    firetouchinterest(game:GetService("Players").LocalPlayer.Character["Left Leg"], Pad, 0)
                end
            end
        end)()
    end
end