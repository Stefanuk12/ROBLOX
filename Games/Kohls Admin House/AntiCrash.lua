-- // I cannot say it works all the time, when I tested it against myself, it worked. If you are going to rewrite this, make sure the clone check is on the top as I believe the clone causes the crash so we want to get rid of that one first.
-- // I also made this quite quickly so yeah, I spent more time making these comments than actually scripting it lol
-- // Why do people randomly join servers and crash? It is not cool
-- // Anyway, this should cover most of the crash methods I know
-- // This uses my signals API, but know that this version is not polished as the polished version is being kept private at the moment and is able to "dehash" certain commands. Its very OP :smirk:
-- // ^ there is another verison within Signals/Modules/Signals.lua but i didnt use it because it might slow things down
-- // Also reason I made reset all and stuff a variable, same with Chat is to make sure it is as fast as possible to intercept the crashes. The clone crash is very effective so you want to make sure you are as fast as possible, so fast that if you put it (the check) lower down - it might not be able to catch it!

-- // Load Dependencies
loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Kohls%20Admin%20House/Signals/Main.lua"))()

-- // Services
local Players = game:GetService("Players")

-- // Vars
local Chat = Players.Chat

local ResetAll = ":reset all"
local Clear = ":clr"

-- // See when someone says a command
Players.CommandChatted:Connect(function(_, Command, Arguments)
    -- // Anti Clone
    if (Command == "clone") then
        Chat(Players, Clear)
    end

    -- // Anti Size and Freeze
    if (Command == "size" or Command == "freeze") then
        Chat(Players, ResetAll)
    end

    -- // Crashes that involve tools - Vampire/Car
    if (Command == "gear") then
        local Gear = tonumber(Arguments[2])

        if (Gear == 94794847 or Gear == 253519495) then
            Chat(Players, ResetAll)
        end
    end

    -- // Disable messages
    if (Command == "m" or Command == "h" or Command == "pm" or Command == "message") then
        Chat(Players, Clear)
    end
end)

-- //
print("Loaded Anti Crash")
