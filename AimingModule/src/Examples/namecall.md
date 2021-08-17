# Namecall Example
!!! warning "Needed Changes"
    Make sure you add the names of the calling scripts to the `CallingScripts` variable because what this does it set **every** `Ray`'s direction towards the `Selected Part`'s position.

    If we make it do this to every single `Ray`, it *may* **break** the game.

    Also, if it **does not** use `FindPartOnRayWithIgnoreList`, you **need** to change it accordingly.

```lua
-- // Load Aiming Module
local Aiming = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Aiming/Module.lua"))()

-- // Services
local Workspace = game:GetService("Workspace")

-- // Vars
local CurrentCamera = Workspace.CurrentCamera

-- // Configure this
local CallingScripts = {
    "ScriptName"
}

-- // Hook
local __namecall
__namecall = hookmetamethod(game, "__namecall", function(...)
    -- // Vars
    local args = {...}
    local self = args[1]
    local method = getnamecallmethod()
    local callingscript = getcallingscript()

    -- // Checks
    if (not checkcaller() and method == "FindPartOnRayWithIgnoreList" and table.find(CallingScripts, callingscript.Name) and Aiming.Check()) then
        -- // Vars
        local Origin = args[2].Origin
        local Destination = Aiming.SelectedPart.Position
        local Direction = (Destination - Origin).Unit * 1000

        -- // Set ray
        args[2] = Ray.new(Origin, Direction)

        -- // Return modified arguments
        return __namecall(unpack(args))
    end

    -- // Return
    return __namecall(...)
end)
```