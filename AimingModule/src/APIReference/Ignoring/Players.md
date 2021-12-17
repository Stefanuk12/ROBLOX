# Ignoring Players
Sometimes, you don't want to target your friends (or you change your mind) and we can achieve this through the `Aiming.IgnorePlayer` and `Aiming.UnIgnorePlayer` functions.

!!! note
    You must provide a `<Instance> Player` as the parameter for the Player

## Examples

### Ignoring a player
```lua
Aiming.IgnorePlayer(
    game:GetService("Players").epicgamer69
)
```

### Unignoring a player
```lua
Aiming.UnIgnorePlayer(
    game:GetService("Players").epicgamer69
)
```