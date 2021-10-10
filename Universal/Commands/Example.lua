-- // Dependencies
local CommandHandler, CommandClass = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Commands/Module.lua"))()

-- // Create a handler
local Handler = CommandHandler.new({
    Prefix = "."
})

-- // Create a command
local PrintCommand = CommandClass.new({
    Name = {"print"},
    ArgParse = {"string"},
    Callback = function(ExecutePlayer, Arguments)
        print(Arguments[1])
    end
})

-- // Add it to the handler
Handler:AddCommand(PrintCommand)

-- //
Handler:StartChatListen()