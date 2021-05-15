# Aiming.Raycast
```lua
<<Vector3> Direction, <Vector3> Normal, <Material> Material> Aiming.Raycast(<Vector3> Origin, <Vector3> Destination, <number> UnitMultiplier = 1) 
```
This simple function does the maths for you and fires a ray. You only need to input the origin, the desired destination, and unit multiplier (default to 1). It returns the Direction, Normal, and material if the ray hits something.

## Parameters
* `Vector3` Direction
* `Vector3` Normal
* `number` Unit Multiplier

## Returns
* `Vector3` Direction
* `Vector3` Normal
* `Material` Material