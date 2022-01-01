-- // Dependencies
local Aiming = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Aiming/Load.lua"))()

-- // Services
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- // Vars
Aiming.AimLock = {
    Enabled = true,
    Keybind = Enum.UserInputType.MouseButton2, -- // You can also have Enum.KeyCode.E, etc.
}
local Settings = Aiming.AimLock

-- //
function Settings.ShouldUseCamera()
    -- //
    return (UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter)
end

-- // Allows for custom
function Settings.AimLockPosition(CameraMode)
    local Position = CameraMode and Aiming.SelectedPart.Position or Aiming.SelectedPosition
    return Position, {}
end

-- // Constantly run
RunService:BindToRenderStep("AimLockAiming", 0, function()
    -- // Vars
    local Keybind = Settings.Keybind
    local IsToggled = (Keybind.EnumType == Enum.KeyCode and UserInputService:IsKeyDown(Keybind) or UserInputService:IsMouseButtonPressed(Keybind))

    -- // Make sure key (or mouse button) is down
    if (Settings.Enabled and IsToggled and Aiming.Check()) then
        -- // Vars
        local CameraMode = Settings.ShouldUseCamera()
        local Position, BeizerData = Settings.AimLockPosition(CameraMode)

        -- // Aim with camera
        if (CameraMode) then
            Aiming.CameraLookAt(Position)
        else
            -- // Aim with mouse
            BeizerData.TargetPosition = Position
            Aiming.BeizerCurve.AimTo(BeizerData)
        end
    end
end)

-- //
return Aiming