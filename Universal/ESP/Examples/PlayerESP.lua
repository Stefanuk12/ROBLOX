-- // Dependencies
local PlayerManager, Base = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/ESP/PlayerManager.lua"))()

-- // Create a manager
local Manager = PlayerManager.new()

-- // Configure Base
Base.Box.GlobalLookAtCamera = true

-- // Start the ESP
Manager:Start()