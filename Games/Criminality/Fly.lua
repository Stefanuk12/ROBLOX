-- // BARELY FUNCTIONAL - shows POC of how protect_gui can be used to bypass checks for certain parts. In order to stop being TP'd back, must be paired with a TP Bypass

-- // Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

-- // Vars
local LocalPlayer = Players.LocalPlayer
local CurrentlyFlying = false
local MaxForce = Vector3.new(123123, 123123, 123123)
local UpFly = Vector3.new(0, 25, 0)
local Speed = UpFly.Y

-- //
local BodyVelocity = Instance.new("BodyVelocity")
syn.protect_gui(BodyVelocity)

-- //
local function startFly(Velocity)
    CurrentlyFlying = true
    while (CurrentlyFlying) do
        BodyVelocity.Parent = LocalPlayer.Character.HumanoidRootPart
        BodyVelocity.MaxForce = MaxForce
        BodyVelocity.Velocity = Velocity

        wait(0.2)
    end
end

-- //
local function stopFly()
    CurrentlyFlying = false
    BodyVelocity.Parent = nil
    BodyVelocity.MaxForce = Vector3.new()
    BodyVelocity.Velocity = Vector3.new()
end

-- //
UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    -- // So you don't fly when typing in chat, etc
    if (gameProcessedEvent) then
        return
    end

    -- //
    if (input.KeyCode == Enum.KeyCode.W) then
        startFly(LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector * Speed)
        return
    end

    -- //
    if (input.KeyCode == Enum.KeyCode.S) then
        startFly(-(LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector * Speed))
        return
    end

    -- //
    if (input.KeyCode == Enum.KeyCode.A) then
        startFly(-(LocalPlayer.Character.HumanoidRootPart.CFrame.RightVector * Speed))
        return
    end

    -- //
    if (input.KeyCode == Enum.KeyCode.D) then
        startFly(LocalPlayer.Character.HumanoidRootPart.CFrame.RightVector * Speed)
        return
    end

    -- //
    if (input.KeyCode == Enum.KeyCode.Space) then
        startFly(UpFly)
        return
    end
end)

-- //
UserInputService.InputEnded:Connect(function(input, gameProcessedEvent)
    -- // So you don't fly when typing in chat, etc
    if (gameProcessedEvent) then
        return
    end

    -- //
    if (input.KeyCode == Enum.KeyCode.W or input.KeyCode == Enum.KeyCode.S or input.KeyCode == Enum.KeyCode.A or input.KeyCode == Enum.KeyCode.D or input.KeyCode == Enum.KeyCode.Space) then
        stopFly()
    end
end)