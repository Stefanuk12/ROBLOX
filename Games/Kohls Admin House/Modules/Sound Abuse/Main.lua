-- // Initialisation
if not getgenv()["KAHHax"] then getgenv()["KAHHax"] = {} end
getgenv().KAHHax["EarRape"] = false

-- // Script
playAllSounds = function()
    for i,v in pairs(game:GetService("Workspace"):GetDescendants()) do
        if v:IsA("Sound") then
            v:Play()
        end
    end
end
stopAllSounds = function()
    for i,v in pairs(game:GetService("Workspace"):GetDescendants()) do
        if v:IsA("Sound") then
            v:Stop()
        end
    end
end
playMusic = function()
    if game:GetService("Workspace").Terrain["_Game"].Folder:FindFirstChildWhichIsA("Sound") then
        game:GetService("Workspace").Terrain["_Game"].Folder:FindFirstChildWhichIsA("Sound"):Play()
    end
end
stopMusic = function()
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