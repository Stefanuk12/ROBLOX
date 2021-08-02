-- // Not tested

-- // Services
local StarterPlayer = game:GetService("StarterPlayer")

-- // Vars
local StarterPlayerScripts = StarterPlayer.StarterPlayerScripts
local AntiCheatScript
local GunTables = {}
local BackupGunTables = {} -- // Do not touch

-- // Get the AntiCheat Script
do
    -- // Getting the name
    for _,v in ipairs(StarterPlayerScripts:GetChildren()) do
        local Module = v:FindFirstChildWhichIsA("ModuleScript")
        if (Module and Module.Name ~= "ChatMain") then
            AntiCheatScript = v
            break
        end
    end

    -- // Getting the actual script
    for _,v in ipairs(getnilinstances()) do
        if (v.Name == AntiCheatScript) then
            AntiCheatScript = v
            break
        end
    end
end

-- // Add all the guns to the gun table
for _,v in ipairs(getloadedmodules()) do
    if (v.Name == "Config") then
        local Require = require(v)
        local GunName = Require.Name
        GunTables[GunName] = Require
        BackupGunTables[GunName] = Require

        -- // To bypass any checks
        GunTables[GunName] = setmetatable({}, {
            __index = function(t, k)
                -- // Return the spoof values to the Anti Cheat Script only
                if (getcallingscript() == AntiCheatScript) then
                    local BackupGunTable = rawget(BackupGunTables, GunName)
                    return rawget(BackupGunTable, k)
                end

                -- // Return
                local GunTable = rawget(GunTables, GunName)
                return rawget(GunTable, k)
            end
        })
    end
end

-- // Gun Mod function
local function GunMod(GunName, Index, Value)
    -- // Vars
    local GunTable = GunTables[GunName]

    -- // Allow the modification of table vals and stuff
    local function Modify(t, k, v)
        -- //
        local Attribute = t[k]

        -- // If it's a table, then recursive
        if (typeof(Attribute) == "table") then
            return Modify(Attribute, k, v)
        end

        -- // Set it and return old value
        rawset(t, k, v)
        return Attribute
    end

    -- // Support for global
    if (GunName == "all") then
        for _,v in pairs(GunTables) do
            Modify(v, Index, Value)
        end

        return
    end

    -- //
    Modify(GunTable, Index, Value)
end

-- // Example
GunMod("all", "Recoil", 0)