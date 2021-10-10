-- // Dependencies
local CommandHandler, CommandClass = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Commands/Module.lua"))()

-- // Create a handler
local Handler = CommandHandler.new({
    Prefix = "."
})

-- // Create a command
CommandClass.new({
    Name = {"aaa", "warn"},
    Description = "Test",
    ArgParse = {"string"},
    Handler = Handler,
    Callback = function(ExecutePlayer, Arguments)
        warn(Arguments[1])
    end
})

-- //
Handler:StartChatListen()