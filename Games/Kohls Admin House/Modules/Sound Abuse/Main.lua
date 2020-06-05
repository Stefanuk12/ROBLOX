-- // Initialisation
getgenv().KAHHax["Admin"] = {}
getgenv().KAHHax["Admin"]["Functions"] = {}
getgenv().KAHHax["Admin"]["Coroutines"] = {}
getgenv().KAHHax["Admin"]["Toggles"] = {}
getgenv().KAHHax["Admin"]["Toggles"].EarRape = false

-- // Script
function getgenv().KAHHax["Admin"]["Functions"].playAllSounds()
    for i,v in pairs(game:GetService("Workspace"):GetDescendants()) do
        if v:IsA("Sound") then
            v:Play()
        end
    end
end
function getgenv().KAHHax["Admin"]["Functions"].stopAllSounds()
    for i,v in pairs(game:GetService("Workspace"):GetDescendants()) do
        if v:IsA("Sound") then
            v:Stop()
        end
    end
end
function getgenv().KAHHax["Admin"]["Functions"].playMusic()
    if game:GetService("Workspace").Terrain["_Game"].Folder:FindFirstChildWhichIsA("Sound") then
        game:GetService("Workspace").Terrain["_Game"].Folder:FindFirstChildWhichIsA("Sound"):Play()
    end
end
function getgenv().KAHHax["Admin"]["Functions"].stopMusic()
    if game:GetService("Workspace").Terrain["_Game"].Folder:FindFirstChildWhichIsA("Sound") then
        game:GetService("Workspace").Terrain["_Game"].Folder:FindFirstChildWhichIsA("Sound"):Stop()
    end
end
function getgenv().KAHHax["Admin"]["Functions"].toggleEarRape()
    getgenv().KAHHax["Admin"]["Toggles"].EarRape = not getgenv().KAHHax["Admin"]["Toggles"].EarRape
    coroutine.wrap(function()
        while wait(0.25) do
            if not getgenv().KAHHax["Admin"]["Toggles"].EarRape then break end
            if getgenv().KAHHax["Admin"]["Toggles"].EarRape then
                playAllSounds()
            end
        end
    end)()
end