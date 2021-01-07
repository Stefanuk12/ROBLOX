-- Game: https://roblox.com/games/3403470694

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
local strEnc = require(ReplicatedStorage["strEnc"])

-- // Base MT Vars + Funs
local mt = getrawmetatable(game)
local backupnamecall = mt.__namecall
local backupnewindex = mt.__newindex
local backupindex = mt.__index 
setreadonly(mt, false)

-- // MT
--[[
mt.__namecall = newcclosure(function(...)
    local method = getnamecallmethod()
    local args = {...}
    if not checkcaller() then
        if method == "InvokeServer" then
            if tostring(args[1]) == "GamepassHandle" then
                return true
            end
        end
    end
    return backupnamecall(...)
end)
]]
-- // Remote Keys
function encodeRemote(arg)
    return strEnc.enc(arg)
end

function decodeRemote(arg)
    return strEnc.dec(arg)
end

print(decodeRemote("16|jFwHqtu"))