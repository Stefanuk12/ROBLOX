--[[
    Information:

    - Rush Point (https://www.roblox.com/games/5993942214/)
]]

-- // Dependencies
local Aiming = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Aiming/Module.lua"))()
Aiming.TargetPart = {"HumanoidRootPart", "Head", "LowerTorso", "UpperTorso"}

-- // Services
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

-- // Vars
local CurrentCamera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local GameStats = Workspace.MapFolder.GameStats
local MapFolder = Workspace.MapFolder

-- // Team Check
function Aiming.IsIgnoredTeam(Player)
    -- // Deathmatch check
    if (GameStats.GameMode.Value == "Deathmatch") then
        return false
    end

    -- //
    return (LocalPlayer.PermanentTeam.Value == Player.PermanentTeam.Value)
end

-- // Ignore
function Aiming.RaycastIgnore()
    local Ignored = {LocalPlayer.Character, CurrentCamera, Workspace.RaycastIgnore, Workspace.DroppedWeapons, MapFolder.Map.Ramps, MapFolder.Map.Walls.MapWalls}
    return Ignored
end

-- // Return
return Aiming