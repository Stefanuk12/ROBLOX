-- // Initialisation
getgenv().KAHHax["Admin"] = {}
getgenv().KAHHax["Admin"]["Functions"] = {}
getgenv().KAHHax["Admin"]["Coroutines"] = {}
getgenv().KAHHax["Admin"]["Toggles"] = {}
getgenv().KAHHax["Admin"]["Toggles"].EarRape = false

-- // Script
getgenv().KAHHax["Admin"]["Functions"].playAllSounds = function()
    for i,v in pairs(game:GetService("Workspace"):GetDescendants()) do
        if v:IsA("Sound") then
            v:Play()
        end
    end
end
getgenv().KAHHax["Admin"]["Functions"].stopAllSounds = function()
    for i,v in pairs(game:GetService("Workspace"):GetDescendants()) do
        if v:IsA("Sound") then
            v:Stop()
        end
    end
end
getgenv().KAHHax["Admin"]["Functions"].playMusic = function()
    if game:GetService("Workspace").Terrain["_Game"].Folder:FindFirstChildWhichIsA("Sound") then
        game:GetService("Workspace").Terrain["_Game"].Folder:FindFirstChildWhichIsA("Sound"):Play()
    end
end
getgenv().KAHHax["Admin"]["Functions"].stopMusic = function()
    if game:GetService("Workspace").Terrain["_Game"].Folder:FindFirstChildWhichIsA("Sound") then
        game:GetService("Workspace").Terrain["_Game"].Folder:FindFirstChildWhichIsA("Sound"):Stop()
    end
end
<<<<<<< HEAD
function earRape()
    KAHHax.EarRape = not KAHHax.EarRape
    while wait(0.25) do
        if not KAHHax.EarRape then break end
        if KAHHax.EarRape then
            playAllSounds()
=======
getgenv().KAHHax["Admin"]["Functions"].toggleEarRape = function()
    getgenv().KAHHax["Admin"]["Toggles"].EarRape = not getgenv().KAHHax["Admin"]["Toggles"].EarRape
    coroutine.wrap(function()
        while wait(0.25) do
            if not getgenv().KAHHax["Admin"]["Toggles"].EarRape then break end
            if getgenv().KAHHax["Admin"]["Toggles"].EarRape then
                playAllSounds()
            end
>>>>>>> 05fb9af69d5f01896afded5cc93f86da9cca6913
        end
    end)()
end