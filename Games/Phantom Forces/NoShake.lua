-- // Dependencies
local ClientManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Phantom%20Forces/ClientManager.lua"))().new()

-- // Hook
hookfunction(ClientManager.camera.shake, function(...)
    return
end)