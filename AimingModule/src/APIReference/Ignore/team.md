# Aiming.IgnoreTeam
```lua
<<bool> success> Aiming.IgnoreTeam(<Team> Team, <Color3> TeamColor)
```
Of course, you do not want to shoot against your own teams, so you can use this function to ignore certain teams (including your own)

### Parameters
* `Team` Team
> The team you want to ignore
* `Color3` TeamColor
> The team color of the team you want to ignore

### Returns
* `bool` success
> Returns false if already is being ignored


# Un-ignore Teams
```lua
<<bool> success> Aiming.UnIgnoreTeam(<Team> Team, <Color3> TeamColor)
```
However, if they are being toxic, you can get back at them with this function which un-ignores them

### Parameters
* `Team` Team
> The team you want to ignore
* `Color3` TeamColor
> The team color of the team you want to ignore

### Returns
* `bool` success
> Returns false if already is being ignored