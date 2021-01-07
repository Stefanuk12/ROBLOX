-- // Credits: https://v3rmillion.net/showthread.php?tid=1077700

-- // Filters the text to allow you to say naughty words
local seperater = "\243\160\128\149\243\160\128\150\243\160\128\151\243\160\128\152\243\160\128\149\243\160\128\150\243\160\128\151\243\160\128\152\243\160\128\149\243\160\128\150\243\160\128\151\243\160\128\152\243\160\128\149\243\160\128\150\243\160\128\151\243\160\128\152\243\160\128\149\243\160\128\150\243\160\128\151\243\160\128\152\243\160\128\149\243\160\128\150\243\160\128\151\243\160\128\152\243\160\128\149\243\160\128\150\243\160\128\151\243\160\128\152\243\160\128\149\243\160\128\150\243\160\128\151\243\160\128\151"
local function filterString(text)
    -- // Remove Punctutation
    text = string.gsub(text, "[%p]+", "")
    
    -- // Filtering
    local function filterWord(word)
        local iterationCount = 0
        
        for i = 1, #word do
            if (i % 2 == 0) then
                i = i + iterationCount
                local a = string.sub(word, 0, i)
                local b = string.sub(word, i + 1, -1)
                
                word = a .. seperater .. b
                iterationCount = iterationCount + #seperater
            end
        end
        
        return word
    end

    -- // Filtering each word
    text = string.split(text, " ")
    for i = 1, #text do
        text[i] = filterWord(text[i])
    end

    -- // Putting it all back together
    text = table.concat(text, " ")
    
    -- // Finishing Bypassing
    return text
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
        return backupnamecall(unpack(args))
    end
    return backupnamecall(...)
end)

-- // Metatables
setreadonly(mt, true)

-- // Return
return getgenv().BypassText