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

local Keys = {
    [Enum.KeyCode.W] = {"LookVector", false},
    [Enum.KeyCode.S] = {"LookVector", true},
    [Enum.KeyCode.A] = {"RightVector", true},
    [Enum.KeyCode.D] = {"RightVector", false}
}

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

    -- // Vars
    local KeyCode = input.KeyCode
    local MoveData = Keys[KeyCode]

    -- // Check if it is a recognised key
    if (MoveData) then
        -- // Vars
        local Multiplier = MoveData[2] and -1 or 1
        local Velocity = LocalPlayer.Character.HumanoidRootPart.CFrame[MoveData[1]] * Speed

        -- // Fly
        startFly(Velocity * Multiplier)
        return
    end

    -- // Check if it is a recognised key
    if (KeyCode == Enum.KeyCode.Space) then
        -- // Fly
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

    -- // Vars
    local KeyCode = input.KeyCode

    -- // Check if it is a recognised key
    if (Keys[KeyCode] or KeyCode == Enum.KeyCode.Space) then
        stopFly()
    end
end)