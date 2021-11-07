# CommandClass.ParseArguments
```lua
<<any> Arguments> CommandClass.ParseArguments(<CommandClass> self, <Player> ExecutePlayer, <string[]> Arguments)
```
This converts a `string[]` (string array) of arguments into an array of typed arguments. This means a number argument becomes a number, etc.

### Parameters
* `CommandClass` Command
> The command

* `Player` ExecutePlayer
> The player who executed the command

* `string[]` Arguments
> The string array of arguments, usually the stuff after the command has been said but all chopped up. e.g. `:particle me red` -> `["me", "red"]`

### Returns
* `any` Arguments
> The parsed arguments with types

[Source](https://github.com/Stefanuk12/ROBLOX/blob/master/Universal/Commands/Module.lua#L331)