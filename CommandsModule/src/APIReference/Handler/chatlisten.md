# CommandHandler.StartChatListen
```lua
<<nil> nil> CommandHandler.StartChatListen(<CommandHandler> self)
```
This starts the handler. It listens to every message chatted by every user and executes a command if they said one.

!!! note "How this works"
    It passes the message to [CommandHandler.Execute](./execute.md)

### Parameters
* `CommandHandler` Handler
> The command handler

### Returns
* `nil` nil

[Source](https://github.com/Stefanuk12/ROBLOX/blob/master/Universal/Commands/Module.lua#L69)