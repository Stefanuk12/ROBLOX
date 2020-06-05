-- // Initialisation
getgenv().KAHHax["Admin"] = {}
getgenv().KAHHax["Admin"]["Functions"] = {}
getgenv().KAHHax["Admin"]["Coroutines"] = {}
getgenv().KAHHax["Admin"]["Toggles"] = {}
getgenv().KAHHax["Admin"]["Toggles"].PersistantAdmin = false

-- // Script
function getgenv().KAHHax["Admin"]["Functions"].regenAdmin()
    local Regen = game:GetService("Workspace").Terrain["_Game"]["Admin"].Regen
    fireclickdetector(Regen.ClickDetector, 0)
end
function getgenv().KAHHax["Admin"]["Functions"].getAdmin()
    regenAdmin()
    wait(0.25)
    local Pad = game:GetService("Workspace").Terrain["_Game"]["Admin"].Pads:FindFirstChild("Touch to get admin")
    local PreviousPos = game:GetService("Players").LocalPlayer.Character.PrimaryPart.CFrame
    game:GetService("Players").LocalPlayer.Character.PrimaryPart.CFrame = Pad.Head.CFrame
    wait(1)
    game:GetService("Players").LocalPlayer.Character.PrimaryPart.CFrame = PreviousPos
end
function getgenv().KAHHax["Admin"]["Functions"].togglePersistantAdmin()
    getgenv().KAHHax["Admin"]["Toggles"].PersistantAdmin = not getgenv().KAHHax["Admin"]["Toggles"].PersistantAdmin
    if getgenv().KAHHax["Admin"]["Toggles"].PersistantAdmin then
        regenAdmin()
        getgenv().KAHHax["Admin"]["Coroutines"].togglePersistantAdmin1 = coroutine.wrap(function()
            while wait() do 
                if not getgenv().KAHHax["Admin"]["Toggles"].PersistantAdmin then break end
                if getgenv().KAHHax["Admin"]["Toggles"].PersistantAdmin then
                    local Pad = game:GetService("Workspace").Terrain["_Game"]["Admin"].Pads:FindFirstChild("Touch to get admin").Head
                    firetouchinterest(game:GetService("Players").LocalPlayer.Character["Left Leg"], Pad, 0)
                end
            end
        end)()
    end
end