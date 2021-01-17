-- // Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- // Vars
local Modules = ReplicatedStorage.Modules
local Client = Modules.Client

-- // Load Silent Aim
loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Experimental%20Silent%20Aim%20Module.lua"))()

-- // Hook
local old
old = hookfunction(require(Client.Get_Camera_Aim), function(CurrentCamera, Part, Crosshair)
    if (ValiantAimHacks.checkSilentAim()) then
        local selectedCharacter = ValiantAimHacks.getCharacter(ValiantAimHacks.Selected)
        local plrPos, _ = CurrentCamera:WorldToScreenPoint(selectedCharacter.Head.Position)

        local Vegetation = workspace:WaitForChild("Vegetation")
        local MapBoundaries = workspace:WaitForChild("Map_Boundaries")

        local ScreenToRay = CurrentCamera:ScreenPointToRay(plrPos.X, plrPos.Y)
        local newRay = Ray.new(ScreenToRay.Origin, ScreenToRay.Direction * 5000)
        local part, pos = workspace:FindPartOnRayWithIgnoreList(newRay, {Vegetation, Part, CurrentCamera, MapBoundaries})

        return part, pos, newRay
    else
        return old(CurrentCamera, Part, Crosshair)
    end
end)