-- // Dependencies
local Aiming = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/Aiming/main/Examples/AimLock.lua"))()
local AimingChecks = Aiming.Checks
local AimingSelected = Aiming.Selected
local AimLockSettings = Aiming.AimLock

-- // Services
local Workspace = game:GetService("Workspace")

-- // Vars
local CurrentCamera = Workspace.CurrentCamera

local DaHoodSettings = {
    Prediction = 0.165,

    SilentAim = true,

    AimLock = AimLockSettings,
    BeizerLock = {
        Smoothness = 0.05,
        CurvePoints = {
            Vector2.new(0.83, 0),
            Vector2.new(0.17, 1)
        }
    }
}
getgenv().DaHoodSettings = DaHoodSettings

-- //
function DaHoodSettings.ApplyPredictionFormula(SelectedPart, Velocity)
    return SelectedPart.CFrame + (Velocity * DaHoodSettings.Prediction)
end

-- // Hook
local __index
__index = hookmetamethod(game, "__index", function(t, k)
    -- // Check if it trying to get our mouse's hit or target and see if we can use it
    if (t:IsA("Mouse") and (k == "Hit" or k == "Target") and AimingChecks.IsAvailable() and DaHoodSettings.SilentAim) then
        -- // Vars
        local SelectedPart = AimingSelected.Part
        local Hit = DaHoodSettings.ApplyPredictionFormula(SelectedPart, AimingSelected.Velocity * Vector3.new(1, 0.1, 1))

        -- // Return modded val
        return (k == "Hit" and Hit or SelectedPart)
    end

    -- // Return
    return __index(t, k)
end)

-- // Aimlock
function AimLockSettings.AimLockPosition(CameraMode)
    -- // Vars
    local Position
    local BeizerData = {}

    -- // Hit to account prediction
    local Hit = DaHoodSettings.ApplyPredictionFormula(AimingSelected.Part)
    local HitPosition = Hit.Position

    -- //
    if (CameraMode) then
        Position = HitPosition
    else
        -- // Convert 3d -> 2d
        local Vector, _ = CurrentCamera:WorldToViewportPoint(HitPosition)
        local Vector2D = Vector2.new(Vector.X, Vector.Y)

        -- // Vars
        local BeizerLock = DaHoodSettings.BeizerLock

        -- //
        Position = Vector2D
        BeizerData = {
            Smoothness = BeizerLock.Smoothness,
            CurvePoints = BeizerLock.CurvePoints
        }
    end

    -- // Return
    return Position, BeizerData
end

-- // Return
return DaHoodSettings