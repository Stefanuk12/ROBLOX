-- // Dependencies
local Manager, Base = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/ESP/Manager.lua"))()

-- // Services
local Workspace = game:GetService("Workspace")

-- // Vars
local SpawnedPiles = Workspace.Filter.SpawnedPiles

-- // Make an ESP manager
local ScrapESP = Manager.new(SpawnedPiles)

-- // Disable tracers
Base.Tracers.GlobalEnabled = false

-- // Start
ScrapESP:Start()