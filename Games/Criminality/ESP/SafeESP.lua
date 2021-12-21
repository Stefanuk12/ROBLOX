-- // Dependencies
local Manager, Base = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/ESP/Manager.lua"))()

-- // Services
local Workspace = game:GetService("Workspace")

-- // Vars
local Safes = Workspace.Map.BredMakurz

-- // Make an ESP manager
local SafeESP = Manager.new(Safes, {
    Filter = function(self, child)
        return child.Name:find("Safe")
    end
})

-- // Disable tracers
Base.Tracers.GlobalEnabled = false

-- // Start
SafeESP:Start()