-- // Initialisation
if not getgenv()["KAHHax"] then getgenv()["KAHHax"] = {} end
getgenv().KAHHax["EarRape"] = false

-- // Script
function playAllSounds()
    for i,v in pairs(game:GetService("Workspace"):GetDescendants()) do
        if v:IsA("Sound") then
            v:Play()
        end
    end
end
function stopAllSounds()
    for i,v in pairs(game:GetService("Workspace"):GetDescendants()) do
        if v:IsA("Sound") then
            v:Stop()
        end
    end
end
function playMusic()
    if game:GetService("Workspace").Terrain["_Game"].Folder:FindFirstChildWhichIsA("Sound") then
        game:GetService("Workspace").Terrain["_Game"].Folder:FindFirstChildWhichIsA("Sound"):Play()
    end
end
function stopMusic()
    if game:GetService("Workspace").Terrain["_Game"].Folder:FindFirstChildWhichIsA("Sound") then
        game:GetService("Workspace").Terrain["_Game"].Folder:FindFirstChildWhichIsA("Sound"):Stop()
    end
end
function earRape()
    KAHHax.EarRape = not KAHHax.EarRape
    while wait(0.25) do
        if not KAHHax.EarRape then break end
        if KAHHax.EarRape then
            playAllSounds()
        end
    end)()
end