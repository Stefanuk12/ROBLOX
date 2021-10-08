-- // Services
local Players = game:GetService("Players")

-- // Vars
local LocalPlayer = Players.LocalPlayer
local Backpack = LocalPlayer.Backpack
local mainHandler = Backpack:WaitForChild("mainHandler")

-- // Get the remote key
local RemoteKey = ""
do
    -- // Vars
    local stagger = getsenv(mainHandler).stagger

    -- //
    RemoteKey = debug.getupvalue(RemoteKey, 6)
end