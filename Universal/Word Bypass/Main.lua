-- // Credits: https://v3rmillion.net/showthread.php?tid=1077700

-- // Filters the text to allow you to say naughty words
local seperater = "\243\160\128\149\243\160\128\150\243\160\128\151\243\160\128\152\243\160\128\149\243\160\128\150\243\160\128\151\243\160\128\152\243\160\128\149\243\160\128\150\243\160\128\151\243\160\128\152\243\160\128\149\243\160\128\150\243\160\128\151\243\160\128\152\243\160\128\149\243\160\128\150\243\160\128\151\243\160\128\152\243\160\128\149\243\160\128\150\243\160\128\151\243\160\128\152\243\160\128\149\243\160\128\150\243\160\128\151\243\160\128\152\243\160\128\149\243\160\128\150\243\160\128\151\243\160\128\151"
local function filterString(text)
    local middleOfText = math.round(#text / 2)
    return string.sub(text, 1, middleOfText) .. seperater .. string.sub(text, middleOfText + 1)
end

-- // Vars
local ReplicatedStorage = game.GetService(game, "ReplicatedStorage")
local SayMessageRequest = ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest
getgenv().BypassText = true

-- // Metatables
local mt = getrawmetatable(game)
local backupnamecall = mt.__namecall
setreadonly(mt, false)

-- // Overwriting your chats
mt.__namecall = newcclosure(function(...)
    local args = {...}
    local method = getnamecallmethod()

    if (method == "FireServer" and args[1] == SayMessageRequest and getgenv().BypassText) then
        args[2] = filterString(args[2])
        return backupnamecall(args)
    end
    return backupnamecall(...)
end)

-- // Metatables
setreadonly(mt, true)

-- //
return getgenv().BypassText