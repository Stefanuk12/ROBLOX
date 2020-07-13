--[[
    Credit to: Immortal Donkey and his Chat Bypass: https://v3rmillion.net/showthread.php?tid=917549
    I decompiled it with dnSpy and grabbed the special character he used and copied how the program generally works then converted it to Lua!

    I grabbed the special character from the timer3_Tick function but I think you can also copy the special character from the metroButton1_Click function.
    You can also just make a phrase then copy the character they use that way.

    Probably 13+ too.

    09/07/2020: Updated and stole the character from: https://v3rmillion.net/showthread.php?tid=1006944
]]

-- // Initialise
if getgenv().ChatBypasser then return getgenv().ChatBypasser end
if not getgenv().ChatBypasser then getgenv().ChatBypasser = {} end

-- // Vars
local ChatBypasser = getgenv().ChatBypasser
ChatBypasser.ChatBypassEnabled = true
ChatBypasser.DefaultCharReplace = 3
ChatBypasser.SpecialChar1 = "ꜝ"

-- // Base MT Vars
local mt = getrawmetatable(game)
local backupnamecall = mt.__namecall

-- // Function that bypasses the text
function ChatBypasser.bypassText(text, removepunctuation, charReplace)
    -- // Failsafing
    if charReplace == nil or type(charReplace) ~= 'number' or (type(charReplace) == 'number' and charReplace < 1) then charReplace = ChatBypasser.DefaultCharReplace end
    if removepunctuation == nil then removepunctuation = true end

    -- // Remove Punctutation
    if removepunctuation then
        text = string.gsub(text, "[%p]+", "")
    end

    -- // Calculate after how many characters, the special character is added
    local epicDots = "("
    for i = 1, charReplace do 
        epicDots = epicDots.."."
    end
    epicDots = epicDots..")"

    -- // Finishing Bypassing
    local returnText, _ = string.gsub(text, epicDots, "%1"..ChatBypasser.SpecialChar1)
    return returnText
end

-- // MT Itself that auto bypasses what you type.
setreadonly(mt, false)
mt.__namecall = newcclosure(function(...)
    local args = {...}
    if ChatBypasser.ChatBypassEnabled and tostring(args[1]) == "SayMessageRequest" then
        args[2] = ChatBypasser.bypassText(args[2], true, ChatBypasser.DefaultCharReplace)
        return backupnamecall(unpack(args))
    end
    return backupnamecall(unpack(args))
end)
setreadonly(mt, true)

-- // Finish
return getgenv().ChatBypasser