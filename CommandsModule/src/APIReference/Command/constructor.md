# CommandClass.new
```lua
<<CommandClass> Command> CommandClass.new(<CommandClassData> Data)
```
You use this to create a new command instance

### Parameters
* `CommandClassData` Data
> There is a lot of things you may configure, see below

| Name            | Description                                           | Type              | Default         | Required   |
| --------------- | ----------------------------------------------------- | ----------------- | --------------- | ---------- |
| Active          | This is currently not working / not implemented       | `boolean`         | `true`          | `NO`       |
| Members         | These are the allowed/disallowed players              | `Player[]`        | `{LocalPlayer}` | `NO`       |
| MemberType      | Can either be `Whitelist` or `Blacklist`              | `string`          | `Whitelist`     | `NO`       |
| ArgSeperator    | This is what seperates each argument out              | `string`          |                 | `NO`       |
| TargetSeperator | This is what seperates each target out                | `string`          | `nil`           | `NO`       |
| Callback        | This function is called when the command is           | `function`        | `empty func`    | `NO`       |
| Description     | The description of the command - useless atm          | `string`          |                 | `NO`       |
| Handler         | The handler this command is registered to             | `CommandHandler`  |                 | `NO`       |
| Name            | The name of the command                               | `string/string[]` |                 | `YES`      |

!!! note
    The callback back gets passed the `ExecutePlayer, Arguments` arguments.
    If the handler is specified, it is automatically registered to that command

### Returns
* `CommandClass` Command
> The created command

[Source](https://github.com/Stefanuk12/ROBLOX/blob/master/Universal/Commands/Module.lua#L172)