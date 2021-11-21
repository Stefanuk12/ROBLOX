-- // Dependencies
local PlayerManager, Base, Signals = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/ESP/PlayerManager.lua"))()

-- // Create a manager
local Manager = PlayerManager.new()

-- // Start the ESP
Manager:Start()