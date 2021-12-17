# Ignoring Teams
You also (un)ignore teams through the `Aiming.IgnoreTeam` and `Aiming.UnIgnoreTeam` functions.

!!! note
    You need to pass in the `Team` **and** `Team Colour`

## Examples

### Ignoring a team
```lua
Aiming.IgnoreTeam(
    LocalPlayer.Team
    LocalPlayer.TeamColor
)
```

### Unignoring a team
```lua
Aiming.UnIgnoreTeam(
    LocalPlayer.Team
    LocalPlayer.TeamColor
)
```