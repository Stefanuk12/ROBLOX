-- // Information
--[[
    Original Creator: Credits to https://v3rmillion.net/showthread.php?tid=1140198#likepid8052355
    Item List: https://ghostbin.com/wGi25/12121
]]

-- // Services
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

-- // Vars
local LocalPlayer = Players.LocalPlayer
local Backpack = LocalPlayer.Backpack
local mainHandler = Backpack:WaitForChild("mainHandler")

local ServerStuff = Workspace.ServerStuff
local throwWeapon = ServerStuff.throwWeapon

-- // Get the remote key
local RemoteKey = ""
do
    -- // Vars
    local stagger = getsenv(mainHandler).stagger

    -- //
    RemoteKey = debug.getupvalue(stagger, 6)
end

-- // Spawns an item in
local function SpawnItem(ItemId, CFrOffset, AmmoAmount)
    -- // Default values
    CFrOffset = CFrOffset or CFrame.new()
    AmmoAmount = AmmoAmount or 30

    -- // Spawn
    throwWeapon:FireServer(ItemId, nil, CFrOffset, "drop", {}, AmmoAmount, false, RemoteKey)
end

-- // Example
SpawnItem("KShotgun")