--[[
    Note: Ty to Aztup#8540 on Discord for basically doing all of this for me!

    Required Functions:
        getrawmetatable
        getfenv
        setreadonly
        newcclosure
        debug.validlevel
        pcall
        gethiddenproperty
        sethiddenproperty
]]

-- // MT Vars
local mt = getrawmetatable(game)
local backupindex = mt.__index
local backupnewindex = mt.__newindex
setreadonly(mt, false)

-- // Preventing C Stack Overflows
local BLEnv = getfenv(gethiddenproperty)

-- // __index
mt.__index = newcclosure(function(t, k)
    if (checkcaller() and debug.validlevel(3) and getfenv(3) ~= BLEnv) then -- // Preventing detections and C Stack Overflow
        local success, data = pcall(function() return backupindex(t, k) end)
        return (success and data) or gethiddenproperty(t, k)
    end
    return backupindex(t, k)
end)

-- // __newindex
mt.__newindex = newcclosure(function(t, k, v)
    if (checkcaller() and debug.validlevel(3) and getfenv(3) ~= BLEnv) then -- // Preventing detections and C Stack Overflow
        local success, data = pcall(function() return backupnewindex(t, k, v) end)
        return (success and data) or sethiddenproperty(t, k, v)
    end
    return backupnewindex(t, k, v)
end)

-- // Finishing up
setreadonly(mt, true)