# CommandClass.ParseType
```lua
<<any> Argument> CommandClass.ParseType(<Player> ExecutePlayer, <string> Argument, <string> Type)
```
This converts an argument to the Type, e.g. to a number, boolean, etc.

!!!note
    This is used within [CommandClass.ParseArguments](./parsearguments.md)

### Parameters
* `Player` ExecutePlayer
> The player who executed the command

* `string` Argument
> The argument lol

* `string` Type
> The type of argument to parse to. This can be one of the following:
```md
- string
- any
- boolean
- number
- colorrgb (rrrgggbbb is the format, e.g. 001255255)
- player
```

### Returns
* `any` Argument
> The parsed argument

[Source](https://github.com/Stefanuk12/ROBLOX/blob/master/Universal/Commands/Module.lua#L250)