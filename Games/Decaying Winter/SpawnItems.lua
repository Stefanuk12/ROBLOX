-- // Information
--[[
    Original Creator: Credits to https://v3rmillion.net/showthread.php?tid=1140198#likepid8052355
    Item List: https://ghostbin.com/wGi25/12121

    CURRENTLY NOT WORKING
]]

-- // Dependencies
local DecayHax = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Decaying%20Winter/GetRemoteKey.lua"))()

-- // Services
local Workspace = game:GetService("Workspace")

-- // Vars
local ServerStuff = Workspace.ServerStuff
local throwWeapon = ServerStuff.throwWeapon

-- // Spawns an item in
local function SpawnItem(ItemId, CFrOffset, AmmoAmount)
    -- // Default values
    CFrOffset = CFrOffset or CFrame.new()
    AmmoAmount = AmmoAmount or 30

    -- // Spawn
    throwWeapon:FireServer(ItemId, nil, CFrOffset, "drop", {}, AmmoAmount, false, DecayHax.RemoteKey, DecayHax.RemoteKey2)
end

-- // Example
SpawnItem("KShotgun")