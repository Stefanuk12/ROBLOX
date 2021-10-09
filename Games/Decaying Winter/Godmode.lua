-- // Services
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

-- // Vars
local LocalPlayer = Players.LocalPlayer
local Backpack = LocalPlayer.Backpack
local mainHandler = Backpack:WaitForChild("mainHandler")

local ServerStuff = Workspace.ServerStuff
local dealDamage = ServerStuff.dealDamage

-- // Get the remote key
local RemoteKey = ""
do
    -- // Vars
    local stagger = getsenv(mainHandler).stagger

    -- //
    RemoteKey = debug.getupvalue(stagger, 6)
end

-- // Constantly bandage up
while (true) do wait()
    dealDamage:FireServer("regenheal", nil, RemoteKey)
end