-- // Services
local Players = game:GetService("Players")

-- // Vars
local LocalPlayer = Players.LocalPlayer
local PhantomTable
local PhantomTable2
local PhantomTable3

-- // Metatable Vars
local mt = getrawmetatable(game)
local backupnamecall = mt.__namecall
setreadonly(mt, false)

-- // Get Phantom Forces' player table thing
do
    local gGC = getgc(true)
    for i = 1, #gGC do
        local v = gGC[i]
        
        if (typeof(v) == "table") then
            if (rawget(v, "getbodyparts")) then
                PhantomTable = v
            elseif (rawget(v, "getplayerhealth")) then
                PhantomTable2 = v
            elseif (rawget(v, "basecframe")) then
                PhantomTable3 = v
            end
        end
    end
end

-- // Silent Aim
loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Experimental%20Silent%20Aim%20Module.lua"))()

-- // Override get character
function ValiantAimHacks.getCharacter(Player)
    local BodyParts = PhantomTable.getbodyparts(Player)
    if (BodyParts and typeof(BodyParts) == "table" and rawget(BodyParts, "rootpart")) then
        return BodyParts.rootpart.Parent
    end
end

-- // Override get health
function ValiantAimHacks.getHealth(Player)
    return PhantomTable2:getplayerhealth(Player)
end

-- // Override aiming system
mt.__namecall = newcclosure(function(...)
    -- // Vars
    local args = {...}
    local method = getnamecallmethod()

    -- //
    if (method == "FindPartOnRayWithWhitelist" and ValiantAimHacks.checkSilentAim()) then
        local Direction, _, _ = ValiantAimHacks.findDirectionNormalMaterial(args[2].Origin, ValiantAimHacks.getCharacter(ValiantAimHacks.Selected).HumanoidRootPart.Position)
        args[2].Direction = Direction
        print("sex")
        return backupnamecall(unpack(args))
    end

    -- // Return
    return backupnamecall(...)
end)

-- // Reset metatable
setreadonly(mt, true)