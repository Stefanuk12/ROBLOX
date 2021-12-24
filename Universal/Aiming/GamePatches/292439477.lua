--[[
    Information:

    - Phantom Forces (https://www.roblox.com/games/292439477/)
]]

-- // Dependencies
local Aiming = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Aiming/Module.lua"))()
local ClientManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Phantom%20Forces/ClientManager.lua"))()

-- //
local Client = ClientManager.new()

-- // Overwrites // --
function Aiming.Character(Player)
    return Client.Network:getbodyparts(Player)
end

function Aiming.CheckHealth(Player)
    return Client.HUD:getplayerhealth(Player)
end

-- //
return Aiming, Client