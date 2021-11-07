-- // Dependencies
local CommandHandler, CommandClass = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Commands/Module.lua"))()

-- // Create a handler
local Handler = CommandHandler.new({
    Prefix = "."
})

-- // Create a command
CommandClass.new({
    Name = {"stringtest"},
    Description = "Test",
    ArgParse = {"string"},
    Handler = Handler,
    Callback = function(ExecutePlayer, Arguments)
        warn(Arguments[1], typeof(Arguments[1]))
    end
})

CommandClass.new({
    Name = {"booleantest"},
    Description = "Test",
    ArgParse = {"boolean"},
    Handler = Handler,
    Callback = function(ExecutePlayer, Arguments)
        warn(Arguments[1], typeof(Arguments[1]))
    end
})

CommandClass.new({
    Name = {"numbertest"},
    Description = "Test",
    ArgParse = {"number"},
    Handler = Handler,
    Callback = function(ExecutePlayer, Arguments)
        warn(Arguments[1], typeof(Arguments[1]))
    end
})

CommandClass.new({
    Name = {"colorrgbtest"},
    Description = "Test",
    ArgParse = {"colorrgb"},
    Handler = Handler,
    Callback = function(ExecutePlayer, Arguments)
        warn(Arguments[1], typeof(Arguments[1]))
    end
})

CommandClass.new({
    Name = {"playertest"},
    Description = "Test",
    ArgParse = {"player"},
    TargetSeperator = ","
    Handler = Handler,
    Callback = function(ExecutePlayer, Arguments)
        warn(Arguments[1], typeof(Arguments[1]))
    end
})

CommandClass.new({
    Name = {"misctest"},
    Description = "Test",
    ArgParse = {"fdsfiuhdsji"},
    Handler = Handler,
    Callback = function(ExecutePlayer, Arguments)
        warn(Arguments[1], typeof(Arguments[1]))
    end
})

-- //
Handler:StartChatListen()