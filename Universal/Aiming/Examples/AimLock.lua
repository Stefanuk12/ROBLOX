-- // Dependencies
local Aiming = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Aiming/Load.lua"))()

-- // Services
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- // Vars
local Keybind = Enum.KeyCode.E

-- // Constantly run
RunService:BindToRenderStep("AimLockAiming", 0, function()
    -- // Vars
    local SelectedPosition = Aiming.SelectedPosition

    -- // Make sure key is down
    if (UserInputService:IsKeyDown(Keybind) and SelectedPosition) then
        -- // Aim
        Aiming.BeizerCurve.AimTo({
            TargetPosition = Vector2.new(SelectedPosition.X, SelectedPosition.Y)
        })
    end
end)

-- //
return "AimLockAiming"