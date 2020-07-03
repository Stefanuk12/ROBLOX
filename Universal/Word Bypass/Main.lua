-- // Switch
getgenv().ChatBypassEnabled = true

-- // The Bypass Character
local SpecialChar1 = "ꜞ"

-- // Base MT Vars
local mt = getrawmetatable(game)
local backupnamecall = mt.__namecall

-- // Function that makes text bypassed
function bypassText(text, removepunctuation)
    if removepunctuation then
        text = string.gsub(text, "[%p]+", "")
    end
    return string.gsub(text, "(...)", "%1"..SpecialChar1)
end

-- // MT Itself
setreadonly(mt, false)
mt.__namecall = newcclosure(function(...)
    local args = {...}
    if getgenv().ChatBypassEnabled and tostring(args[1]) == "SayMessageRequest" then
        args[2] = bypassText(args[2], true)
        return backupnamecall(unpack(args))
    end
    return backupnamecall(unpack(args))
end)
setreadonly(mt, true)

print('Initialised Chat Bypass!')