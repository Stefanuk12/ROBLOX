--[[
    Information:

    - Phantom Forces (https://www.roblox.com/games/292439477/)
]]

-- // Dependencies
local Aiming = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Aiming/Module.lua"))()
local ClientManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Phantom%20Forces/ClientManager.lua"))()

-- //
Aiming.TargetPart = {"Head", "Torso"}
local Client = ClientManager.new()

-- // Overwrites // --
function Aiming.Character(Player)
    local Parts = Client.Characters[Player]
    return Parts and Parts.torso.Parent or nil
end

function Aiming.CheckHealth(Player)
    local Health, MaxHealth = Client.hud:getplayerhealth(Player)
    return Health > 0
end

function Aiming.CameraLookAt(Position)
    local ClientCamera = Client.camera

    local LookAt = CFrame.lookAt(ClientCamera.cframe.Position, Position)
    local Angles = Vector3.new(LookAt:ToOrientation())

    ClientCamera.angles = Angles
end

-- //
return Aiming, Client