# CommandHandler.new
```lua
<<CommandHandler> Handler> CommandHandler.new(<CommandHandlerData> Data)
```
You use this to create a new command handler instance

### Parameters
* `CommandHandlerData` Data
> There is a lot of things you may configure, see below

| Name         | Description                                           | Type              | Default         | Required   |
| ------------ | ----------------------------------------------------- | ----------------- | --------------- | ---------- |
| Members      | These are the allowed/disallowed players              | `Player[]`        | `{LocalPlayer}` | `NO`       |
| MemberType   | Can either be `Whitelist` or `Blacklist`              | `string`          | `Whitelist`     | `NO`       |
| ArgSeperator | This is what seperates each argument out              | `string`          | ` `             | `NO`       |
| Commands     | Holds all of the commands registered to this handler  | `Command[]`       | `{}`            | `NO`       |
| Prefix       | What the command has to start with in order to be one | `string/string[]` | `!`             | `NO`       |

### Returns
* `CommandHandler` Handler
> The created handler

[Source](https://github.com/Stefanuk12/ROBLOX/blob/master/Universal/Commands/Module.lua#L33)