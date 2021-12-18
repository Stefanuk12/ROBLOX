-- // Dependencies
local Aiming = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Aiming/Module.lua"))()
Aiming.TeamCheck(false)

-- // Services
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- // Vars
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = Workspace.CurrentCamera

local DaHoodSettings = {
    Prediction = 0.165,

    SilentAim = true,

    AimLock = true,
    AimLockKeybind = Enum.KeyCode.E,
    BeizerLock = {
        Enabled = true,
        Smoothness = 0.05,
        CurvePoints = {
            Vector2.new(0.83, 0),
            Vector2.new(0.17, 1)
        }
    }
}
getgenv().DaHoodSettings = DaHoodSettings

-- // Overwrite to account downed
function Aiming.Check()
    -- // Check A
    if not (Aiming.Enabled == true and Aiming.Selected ~= LocalPlayer and Aiming.SelectedPart ~= nil) then
        return false
    end

    -- // Check if downed
    local Character = Aiming.Character(Aiming.Selected)
    local KOd = Character:WaitForChild("BodyEffects")["K.O"].Value
    local Grabbed = Character:FindFirstChild("GRABBING_CONSTRAINT") ~= nil

    -- // Check B
    if (KOd or Grabbed) then
        return false
    end

    -- //
    return true
end

-- // Hook
local __index
__index = hookmetamethod(game, "__index", function(t, k)
    -- // Check if it trying to get our mouse's hit or target and see if we can use it
    if (t:IsA("Mouse") and (k == "Hit" or k == "Target") and Aiming.Check()) then
        -- // Vars
        local SelectedPart = Aiming.SelectedPart

        -- // Hit/Target
        if (DaHoodSettings.SilentAim and (k == "Hit" or k == "Target")) then
            -- // Hit to account prediction
            local Hit = SelectedPart.CFrame + (SelectedPart.Velocity * DaHoodSettings.Prediction)

            -- // Return modded val
            return (k == "Hit" and Hit or SelectedPart)
        end
    end

    -- // Return
    return __index(t, k)
end)

-- // Aimlock
RunService:BindToRenderStep("AimLock", 0, function()
    if (DaHoodSettings.AimLock and Aiming.Check() and UserInputService:IsKeyDown(DaHoodSettings.AimLockKeybind)) then
        -- // Vars
        local SelectedPart = Aiming.SelectedPart

        -- // Hit to account prediction
        local Hit = SelectedPart.CFrame + (SelectedPart.Velocity * DaHoodSettings.Prediction)
        local HitPosition = Hit.Position

        -- //
        local BeizerLock = DaHoodSettings.BeizerLock
        if (BeizerLock.Enabled) then
            -- // Work out in 2d
            local Vector, _ = CurrentCamera:WorldToViewportPoint(HitPosition)
            local Vector2D = Vector2.new(Vector.X, Vector.Y)

            -- // Aim
            Aiming.BeizerCurve.AimTo({
                TargetPosition = Vector2D,
                Smoothness = BeizerLock.Smoothness,
                CurvePoints = BeizerLock.CurvePoints
            })
        else
            -- // Set the camera to face towards the Hit
            CurrentCamera.CFrame = CFrame.lookAt(CurrentCamera.CFrame.Position, HitPosition)
        end
    end
end)