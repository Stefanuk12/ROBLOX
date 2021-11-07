# CommandClass.ParsePlayerType
```lua
<<Player[]> Target> CommandClass.ParsePlayerType(<string> Argument, <Player> ExecutePlayer)
```
This converts a target player into an array containing all of the targets.

!!!note
    This is used within [CommandClass.ParseType](./parsetype.md)

### Parameters
* `string` Argument
> The target, e.g. `all`, `others`, `random`, `me`, or the partial spelling of a username

* `Player` ExecutePlayer
> The player who executed the command

### Returns
* `Player[]` Target
> An array of player instances (targets)

[Source](https://github.com/Stefanuk12/ROBLOX/blob/master/Universal/Commands/Module.lua#L207)