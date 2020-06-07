-- // Initialisation
if not getgenv()["KAHHax"] then getgenv()["KAHHax"] = {} end
if not KAHHax.intSoundAbuse then
    getgenv().KAHHax["EarRape"] = false

    -- // Script
    function KAHHax.playAllSounds()
        for i,v in pairs(game:GetService("Workspace"):GetDescendants()) do
            if v:IsA("Sound") then
                v:Play()
            end
        end
    end
    function KAHHax.stopAllSounds()
        for i,v in pairs(game:GetService("Workspace"):GetDescendants()) do
            if v:IsA("Sound") then
                v:Stop()
            end
        end
    end
    function KAHHax.playMusic()
        if game:GetService("Workspace").Terrain["_Game"].Folder:FindFirstChildWhichIsA("Sound") then
            game:GetService("Workspace").Terrain["_Game"].Folder:FindFirstChildWhichIsA("Sound"):Play()
        end
    end
    function KAHHax.stopMusic()
        if game:GetService("Workspace").Terrain["_Game"].Folder:FindFirstChildWhichIsA("Sound") then
            game:GetService("Workspace").Terrain["_Game"].Folder:FindFirstChildWhichIsA("Sound"):Stop()
        end
    end
    function KAHHax.earRape()
        KAHHax.EarRape = not KAHHax.EarRape
        while wait(0.25) do
            if not KAHHax.EarRape then break end
            if KAHHax.EarRape then
                playAllSounds()
            end
        end)()
    end

    KAHHax.intSoundAbuse = true
end