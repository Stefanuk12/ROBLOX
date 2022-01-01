-- // Dependencies
local Aiming = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Aiming/Load.lua"))()

-- // Services
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- // Vars
local Keybind = Enum.UserInputType.MouseButton2 -- // You can also have Enum.KeyCode.E, etc.

-- //
local function ShouldUseCamera()
    -- //
    return (UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter)
end

-- // Allows for custom
function Aiming.AimLockPosition(CameraMode)
    return CameraMode and Aiming.SelectedPart.Position or Aiming.SelectedPosition
end

-- // Constantly run
RunService:BindToRenderStep("AimLockAiming", 0, function()
    -- // Vars
    local IsToggled = (Keybind.EnumType == Enum.KeyCode and UserInputService:IsKeyDown(Keybind) or UserInputService:IsMouseButtonPressed(Keybind))

    -- // Make sure key (or mouse button) is down
    if (IsToggled and Aiming.Check()) then
        -- // Vars
        local CameraMode = ShouldUseCamera()
        local Position = Aiming.AimLockPosition(CameraMode)

        -- // Aim with camera
        if (CameraMode) then
            Aiming.CameraLookAt(Position)
        else
            -- // Aim with mouse
            Aiming.BeizerCurve.AimTo({
                TargetPosition = Position
            })
        end
    end
end)

-- //
return "AimLockAiming"