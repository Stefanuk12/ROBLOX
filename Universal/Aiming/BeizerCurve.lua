-- // Services
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- // Vars
local RenderStepped = RunService.RenderStepped

-- //
local function PerformBeizerCurveQuadratic(t, StartPoint, EndPoint, Curve)
    local t1 = (1 - t)

    local A = t1^2 * StartPoint
    local B = 2 * t1 * t * Curve
    local C = t^2 * EndPoint

    return A + B + C
end

-- //
local function PerformBeizerCurveLinear(t, StartPoint, EndPoint)
    local A = StartPoint
    local B = t * (EndPoint - StartPoint)

    return A + B
end

-- //
local function AimTo(Position, Smoothness, Curve)
    -- // Work out curve type
    local BeizerCurve = PerformBeizerCurveLinear
    if (Curve) then
        BeizerCurve = PerformBeizerCurveQuadratic
    else
        -- // Just so it doesn't break
        Curve = Vector2.new()
    end

    -- //
    for i = 0, 1, Smoothness do RenderStepped:Wait()
        -- // Vars
        local MousePosition = UserInputService:GetMouseLocation()

        -- // Work out X, Y based upon the curve
        local X = BeizerCurve(i, MousePosition.X, Position.X, Curve.Y)
        local Y = BeizerCurve(i, MousePosition.Y, Position.Y, Curve.Y)

        -- // Move mouse
        mousemoveabs(X, Y)
    end
end

-- //
wait(2)
AimTo(Vector2.new(500, 500), 0.01, Vector2.new(1, 1))