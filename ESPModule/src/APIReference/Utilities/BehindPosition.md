# ESP.Utilites.BehindPosition
```lua
<<Vector3> Position> ESP.Utilites.BehindPosition(<Vector3> TargetPosition)
```
This returns the position of the `TargetPosition` relative to your screen, and factors in if they are behind.

## Parameters
* `Vector3` TargetPosition
> The position you want to get relative to your screen

## Returns
* `Vector3` Position
> Make sure you do `Vector2.new(Position.X, Position.Y)`, the reason for it being `Vector3` is because of what [Camera.WorldToViewportPoint](https://developer.roblox.com/en-us/api-reference/function/Camera/WorldToViewportPoint) returns

[Source](https://github.com/Stefanuk12/ROBLOX/blob/master/Universal/ESP/Rewrite.lua#L36)