-- // Metatable vars
local mt = getrawmetatable(game)
local backupnamecall = mt.__namecall
setreadonly(mt, false)

-- // Hook
mt.__namecall = newcclosure(function(...)
    -- // Vars
    local args = {...}
    local method = getnamecallmethod()
    
    -- // Checking if naughty
    if (method == "FireServer" and tostring(args[1]):len() == 100 and args[3] == "Not Gamer") then
        return wait(9e9)
    end
    
    -- // Return
    return backupnamecall(...)
end)

-- // Metatable
setreadonly(mt, true)