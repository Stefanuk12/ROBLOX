-- // Initialisation
KAHHax["Admin"] = {}
KAHHax["Admin"]["Functions"] = {}
KAHHax["Admin"]["Coroutines"] = {}
KAHHax["Admin"]["Toggles"] = {}
KAHHax["Admin"]["Toggles"].EarRape = false

-- // Script
function KAHHax["Admin"]["Functions"].playAllSounds()
    for i,v in pairs(game:GetService("Workspace"):GetDescendants()) do
        if v:IsA("Sound") then
            v:Play()
        end
    end
end
function KAHHax["Admin"]["Functions"].stopAllSounds()
    for i,v in pairs(game:GetService("Workspace"):GetDescendants()) do
        if v:IsA("Sound") then
            v:Stop()
        end
    end
end
function KAHHax["Admin"]["Functions"].playMusic()
    if game:GetService("Workspace").Terrain["_Game"].Folder:FindFirstChildWhichIsA("Sound") then
        game:GetService("Workspace").Terrain["_Game"].Folder:FindFirstChildWhichIsA("Sound"):Play()
    end
end
function KAHHax["Admin"]["Functions"].stopMusic()
    if game:GetService("Workspace").Terrain["_Game"].Folder:FindFirstChildWhichIsA("Sound") then
        game:GetService("Workspace").Terrain["_Game"].Folder:FindFirstChildWhichIsA("Sound"):Stop()
    end
end
function KAHHax["Admin"]["Functions"].toggleEarRape()
    KAHHax["Admin"]["Toggles"].EarRape = not KAHHax["Admin"]["Toggles"].EarRape
    coroutine.wrap(function()
        while wait(0.25) do
            if not KAHHax["Admin"]["Toggles"].EarRape then break end
            if KAHHax["Admin"]["Toggles"].EarRape then
                playAllSounds()
            end
        end
    end)()
end