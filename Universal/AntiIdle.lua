-- // Wait until game is loaded
repeat wait() until game:IsLoaded()

-- // Services
local Players = game:GetService("Players")
local VirtualInputManager = game:GetService("VirtualInputManager")

-- // Vars
local LocalPlayer = Players.LocalPlayer

-- // See when we are being idle
LocalPlayer.Idled:Connect(function()
    -- // Press mouse down
    VirtualInputManager:SendMouseButtonEvent(0, 0, 2, true, nil, 0)

    -- // Wait
    wait(1)

    -- // Press mouse up
    VirtualInputManager:SendMouseButtonEvent(0, 0, 2, false, nil, 0)
end)