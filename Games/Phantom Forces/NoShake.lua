-- // Dependencies
local ClientManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Phantom%20Forces/ClientManager.lua"))().new()

-- // Vars
local Enabled = true

-- //
local shake
shake = hookfunction(ClientManager.camera.shake, function(...)
    -- // Disable if enabled
    if (Enabled) then
        return
    end

    -- // Return
    return shake(...)
end)