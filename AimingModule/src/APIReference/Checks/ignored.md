# Ignored Check
This check does a couple things, like returning true if:

* Player is on the same team - [code](https://github.com/Stefanuk12/ROBLOX/blob/master/Universal/Aiming/Module.lua#L206)
* Player is specifically ignored - [code](https://github.com/Stefanuk12/ROBLOX/blob/master/Universal/Aiming/Module.lua#L230)

[Source](https://github.com/Stefanuk12/ROBLOX/blob/master/Universal/Aiming/Module.lua#L248)

# Usage

## Team Check
```lua
<bool> Aiming.IsIgnoredTeam(<Player> Player)
```

# Team + Player Check
```lua
<bool> Aiming.IsIgnored(<Player> Player)
```