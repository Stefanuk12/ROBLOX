# Aiming.BeizerCurve.AimTo
As described previously, this allows you to aim to a position on screen based upon the Beizer Curve path to that position.

## Parameters
* `table` Data

| Name           | Type     | Default  | Description                                           | Optional |
| -------------- | -------- | -------- | ----------------------------------------------------- |--------- |
| IsLinear       | boolean  | false    | Whether to use a linear system or a quadratic system  | YES      |
| TargetPosition | Vector2  | nil      | Where you would like your cursor to be in the end     | NO       |
| Smoothness     | number   | 0.0025   | How smooth/fast it aims to the target                 | YES      |
| ControlPoint   | function | Midpoint | Returns the control point for the quadratic system    | YES      |

### ControlPoint
This function takes two parameters `MousePosition` and `EndPoint`. Both are `Vector2` types.

## Example
```lua
Aiming.BeizerCurve.AimTo({
    IsLinear = false,
    TargetPosition = Vector2.new(),
    Smoothness = 0.0025,
    ControlPoint = function(MousePosition, EndPoint)
        local Midpoint = (MousePosition.X + EndPoint.X) / 2
        return Vector2.new(Midpoint, EndPoint.Y)
    end
})
```