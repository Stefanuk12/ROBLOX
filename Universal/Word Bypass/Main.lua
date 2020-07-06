-- // Initialise
if getgenv().ChatBypasser then return getgenv().ChatBypasser end
if not getgenv().ChatBypasser then getgenv().ChatBypasser = {} end

-- // Vars
local ChatBypasser = getgenv().ChatBypasser
ChatBypasser.ChatBypassEnabled = true
ChatBypasser.SpecialChar1 = "ꜞ"

-- // Base MT Vars
local mt = getrawmetatable(game)
local backupnamecall = mt.__namecall

-- // Function that bypasses the text
function ChatBypasser.bypassText(text, removepunctuation)
    if removepunctuation then
        text = string.gsub(text, "[%p]+", "")
    end
    return string.gsub(text, "(...)", "%1"..ChatBypasser.SpecialChar1)
end

-- // MT Itself
setreadonly(mt, false)
mt.__namecall = newcclosure(function(...)
    local args = {...}
    if ChatBypasser.ChatBypassEnabled and tostring(args[1]) == "SayMessageRequest" then
        args[2] = ChatBypasser.bypassText(args[2], true)
        return backupnamecall(unpack(args))
    end
    return backupnamecall(unpack(args))
end)
setreadonly(mt, true)

-- // Finish
return getgenv().ChatBypasser