--[[
    Game: https://www.roblox.com/games/17541179
]]

-- // Vars
if getgenv().MMHax then return getgenv().MMHax end

getgenv().MMHax = {}
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Minerock = workspace.Minerock
MMHax.captureGems = {"Diamond", "Emerald", "Crystal"}
MMHax.tRemoveLava = true 

-- // Funcs
function MMHax.removeLava()
    for _, v in next, Minerock:GetChildren() do
        if MMHax.tRemoveLava and v.Name == "Lava" and v:FindFirstChildWhichIsA("TouchTransmitter") then 
            v:FindFirstChildWhichIsA("TouchTransmitter"):Destroy()
        end
    end
end

function MMHax.getAllGems()
    for _, v in next, Minerock:GetChildren() do
        if table.find(MMHax.captureGems, v.Name) then
            Character:SetPrimaryPartCFrame(v.CFrame)
            wait(0.5)
        end
    end
end

-- // Script
Minerock.ChildAdded:Connect(function(child)
    if MMHax.tRemoveLava and child.Name == "Lava" and child:FindFirstChildWhichIsA("TouchTransmitter") then
        child:FindFirstChildWhichIsA("TouchTransmitter"):Destroy()
    end
end)
