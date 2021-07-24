# ESP.Utilites.IsVisible
```lua
<<Vector3> Position> ESP.Utilites.IsVisible(<Vector3> TargetPosition)
```
This whether the center of the `TargetPosition` is within line of sight. This casts a ray to the `TargetPosition` and sees if the place the ray hits is the `TargetPosition`.

## Parameters
* `Vector3` TargetPosition
> The position you want see if it is visible to you

## Returns
* `boolean` Visible
* `Instance` PartHit
> This is the part the ray hit, just in case.

[Source](https://github.com/Stefanuk12/ROBLOX/blob/master/Universal/ESP/Rewrite.lua#L148)