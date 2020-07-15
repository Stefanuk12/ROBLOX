-- // Vars
local LocalPlayer = game:GetService("Players").LocalPlayer

-- // Base MT Vars + Funs
local mt = getrawmetatable(game)
local backupnamecall = mt.__namecall
setreadonly(mt, false)

-- // Anti kick
hookfunction(LocalPlayer.Kick, warn)
hookfunction(LocalPlayer.kick, warn)

mt.__namecall = newcclosure(function(...)
    if string.lower(getnamecallmethod()) == "kick" then return end
    return backupnamecall(...)
end)