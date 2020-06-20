-- // Int Vars
local targetChannel = "targetChannel"
local AuthToken = "DiscordToken"
local EndNumber = 100000
getgenv().DiscordKS = false

-- // Vars
local currentcount = ""
local startval = 0
local endval = 600

-- // Counter Function
function returnNum()
    local holder = ""
    for i = startval, endval do
        holder = holder..i.."\n"
    end
    local currentnumber = string.split(holder, "\n")[#holder]
    print("String Length =", #holder)
    if #holder > 2000 then
        print('String is too big, adjusting...')
        local data = string.split(holder, "\n")
        repeat 
            table.remove(data, #data)
        until #table.concat(data, "\n") <= 2000
        print('String adjustment done!')
        currentcount = table.concat(data, "\n")
    end
    local a = string.split(currentcount, "\n")
    local a = a[#a]
    startval = tonumber(a)
    endval = tonumber(a) + 500
    print('Exited as count =', a)
    return currentcount
end

-- // Sends the messages
local started = time()
while startval < EndNumber do wait(3.5)
    if getgenv().DiscordKS then break end
    syn.request({
        Url = "https://discordapp.com/api/v6/channels/"..targetChannel.."/messages",
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json",
            ["Authorization"] = AuthToken
        },
        Body = game:GetService("HttpService"):JSONEncode({
            ["content"] = returnNum()
        })
    })
end

-- // Print how long it took
print("Took", time() - started , "seconds to complete!")