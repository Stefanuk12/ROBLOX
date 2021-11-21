-- // Information
--[[
    Employee ESP for: https://www.roblox.com/games/2768379856/3008-2-7
]]

-- // Dependencies
local Manager = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/ESP/Archive/Manager.lua"))()

-- // Services
local Workspace = game:GetService("Workspace")

-- // Vars
local Employees = Workspace.GameObjects.Physical.Employees

-- // Create Manager
local EmployeeManager = Manager.new(Employees)

-- // Start
EmployeeManager:Start()