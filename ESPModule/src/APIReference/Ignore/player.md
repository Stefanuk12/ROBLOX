# Ignoring Players
```lua
<<bool> success> Aiming.IgnorePlayer(<Player> Player)
```
Sometimes, you do not want to target your friends so you can "ignore" them with this simple function:

### Parameters
* `Player` Player
> The player you want to ignore

### Returns
* `bool` success
> Returns false if already is being ignored

[Source](https://github.com/Stefanuk12/ROBLOX/blob/master/Universal/Aiming/Module.lua#L116)


# Un-ignoring Players
```lua
<<bool> success> Aiming.UnIgnorePlayer(<Player> Player)
```
However, if they are getting on your nerves, you can revert that with this function:

### Parameters
* `Player` Player
> The player you want to un-ignore

### Returns
* `bool` success
> Returns false if already is being ignored

[Source](https://github.com/Stefanuk12/ROBLOX/blob/master/Universal/Aiming/Module.lua#L136)