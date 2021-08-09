-- // doesnt work lol someone fix it

-- // Dependencies
local Aiming = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Aiming/Module.lua"))()

-- // Services
local Workspace = game:GetService("Workspace")

-- // Vars
local CurrentCamera = Workspace.CurrentCamera
local MapStuff = {Workspace.Map_Objects, Workspace.MapBase}

-- // Hook
local __namecall
__namecall = hookmetamethod(game, "__namecall", function(self, ...)
    -- // Vars
    local args = {...}
    local method = getnamecallmethod()

    -- //
    if (method == "FindPartOnRayWithIgnoreList" and getfenv(2).script.Name == "RC" and Aiming.Check()) then -- // Instead of getfenv(2).script, can't you do getcallingscript() ?
        -- // Vars
        local SelectedPart = Aiming.SelectedPart
        local CurrentCameraPosition = CurrentCamera.CFrame.Position
        local Direction = (SelectedPart.Position - CurrentCameraPosition)

        -- // Overriding arguments
        args[1] = Ray.new(CurrentCameraPosition, Direction.Unit * Direction.Magnitude)
        args[2] = MapStuff

        -- //
        return __namecall(self, unpack(args))
    end

    -- //
    return __namecall(self, ...)
end)