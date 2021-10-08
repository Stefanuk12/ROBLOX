-- // Not sure if this fully works, add more damage factors.

-- // Services
local Workspace = game:GetService("Workspace")

-- // Vars
local ServerStuff = Workspace.ServerStuff
local dealDamage = ServerStuff.dealDamage

local DamageFactors = {
    "bleed",
    "toxicated",
    "burning"
}

-- //
local __namecall
__namecall = hookmetamethod(game, "__namecall", function(...)
    -- // Vars
    local args = {...}
    local self = args[1]
    local callingscript = getcallingscript()

    -- // Make sure is damage remote and is taking damage (environmental)
    if (self == dealDamage and table.find(DamageFactors, args[2])) then
        return
    end

    -- //
    return __namecall(...)
end)