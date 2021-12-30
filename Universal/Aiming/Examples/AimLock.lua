-- // Dependencies
local Aiming = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Aiming/Load.lua"))()

-- // Services
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- // Vars
local Keybind = Enum.KeyCode.E
local CurrentCamera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- //
local function ShouldUseCamera()
    -- // Vars
    local Character = Aiming.Character(LocalPlayer)
    local Head = Character.Head

    -- //
    local IsFirstPerson = (Head.CFrame.Position - CurrentCamera.CFrame.Position).Magnitude < 1
    local IsShiftLocked = (UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter)

    -- //
    return IsFirstPerson or IsShiftLocked
end

-- // Constantly run
RunService:BindToRenderStep("AimLockAiming", 0, function()
    -- // Make sure key is down
    if (UserInputService:IsKeyDown(Keybind) and Aiming.Check()) then
        -- // Aim with camera
        if (ShouldUseCamera()) then
            local LookAt = CFrame.lookAt(CurrentCamera.CFrame.Position, Aiming.SelectedPart.Position)
            CurrentCamera.CFrame = LookAt
        else
            -- // Vars
            local SelectedPosition = Aiming.SelectedPosition

            -- // Aim with mouse
            Aiming.BeizerCurve.AimTo({
                TargetPosition = Vector2.new(SelectedPosition.X, SelectedPosition.Y)
            })
        end
    end
end)

-- //
return "AimLockAiming"