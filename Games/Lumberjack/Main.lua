-- Game: https://roblox.com/games/5061412825

-- // Valiant ENV
loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/ValiantENV.lua"))()

-- // Vars
local RenderStepped = RunService.RenderStepped
local Heartbeat = RunService.Heartbeat
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded.Wait(LocalPlayer.CharacterAdded)
local Humanoid = Character.WaitForChild(Character, "Humanoid")
local CurrentCamera = Workspace.CurrentCamera
local Mouse = LocalPlayer.GetMouse(LocalPlayer)
local Items = {}
local ARemoteEvents = {
    CollectPart = ReplicatedStorage.RemoteEvents.Interaction.CollectPart, -- arg1 = model of part | fireserver
    FreezeChar = ReplicatedStorage.RemoteEvents.FreezeChar, -- arg1 = player | fireserver
    ThawChar = ReplicatedStorage.RemoteEvents.ThawChar, -- arg1 = player | fireserver
}

-- // Base MT Vars + Funs
local mt = getrawmetatable(game)
local backupnamecall = mt.__namecall
local backupnewindex = mt.__newindex
local backupindex = mt.__index 
setreadonly(mt, false)

-- // Anti Kick
hookfunction(LocalPlayer.Kick, warn)
hookfunction(LocalPlayer.kick, warn)
mt.__namecall = newcclosure(function(...)
    local method = getnamecallmethod()
    local args = {...}
    if string.lower(method) == "kick" then
        return nil
    end
    return backupnamecall(...)
end)

-- // AC Bypass
function removeAC()
    local Player = Players.LocalPlayer
    if Player.PlayerScripts:FindFirstChild("Starter") then Player.PlayerScripts.Starter:Destroy() end
    if StarterPlayer.StarterPlayerScripts:FindFirstChild("Starter") then StarterPlayer.StarterPlayerScripts.Starter:Destroy() end
end
removeAC()

-- // Script 
function gameStarted()
    return (Workspace.CurrentMap:FindFirstChildWhichIsA("Model"))     
end

function indexItems()
    if gameStarted() then
        local Map = gameStarted()
        Items = {}
        local Count = 0
        for i,v in pairs(Map:GetDescendants()) do
            if v.Name == "ItemSpawn" and #v:GetChildren() > 0 then
                for a,x in pairs(v:GetChildren()) do      
                    Items[tostring(string.gsub(x.Name, "Model", "").."#"..Count)] = x
                    Count = Count + 1
                end
            end
        end
    end
end

function teleportToPart(partName)
    indexItems()
    for i,v in pairs(Items) do
        if string.split(i, "#")[1] == partName and Character:FindFirstChild("HumanoidRootPart") then
            Character.HumanoidRootPart.CFrame = v.PrimaryPart.CFrame
        end
    end            
end