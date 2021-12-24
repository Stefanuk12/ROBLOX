-- // Vars
local Format = "https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Aiming/GamePatches/%d.lua"

-- // Attempt to load a patch for the game
local Success, _ = pcall(loadstring, Format:format(game.PlaceId))

-- // Load default otherwise
if (not Success) then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Aiming/Module.lua"))()
end

-- // Return
return Aiming