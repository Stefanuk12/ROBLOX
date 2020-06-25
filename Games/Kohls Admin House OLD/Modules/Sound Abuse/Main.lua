-- // Initialisation
if not getgenv()["KAHHax"] then getgenv()["KAHHax"] = {} end
if not KAHHax["intSoundAbuse"] then
    getgenv().KAHHax["EarRape"] = false

    -- // Script
    function KAHHax.playAllSounds()
        for i,v in pairs(game:GetService("Workspace"):GetDescendants()) do
            if v:IsA("Sound") then
                v:Play()
            end
        end
        print('Played All Sounds.')
    end
    function KAHHax.stopAllSounds()
        for i,v in pairs(game:GetService("Workspace"):GetDescendants()) do
            if v:IsA("Sound") then
                v:Stop()
            end
        end
        print('Stopped All Sounds.')
    end
    function KAHHax.playMusic()
        if game:GetService("Workspace").Terrain["_Game"].Folder:FindFirstChildWhichIsA("Sound") then
            game:GetService("Workspace").Terrain["_Game"].Folder:FindFirstChildWhichIsA("Sound"):Play()
        end
        print('Played Music.')
    end
    function KAHHax.stopMusic()
        if game:GetService("Workspace").Terrain["_Game"].Folder:FindFirstChildWhichIsA("Sound") then
            game:GetService("Workspace").Terrain["_Game"].Folder:FindFirstChildWhichIsA("Sound"):Stop()
        end
        print('Stopped Music.')
    end
    coroutine.wrap(function()
        while wait(0.25) do
            if KAHHax.EarRape then
                KAHHax.playAllSounds()
            end
        end
    end)()

    KAHHax["intSoundAbuse"] = true
end