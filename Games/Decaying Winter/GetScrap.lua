-- // DO NOT GO OVER 1900 SCRAP, YOU WILL GET KICKED

-- // Configuration
local DropAmount = 100

-- // Services
local Workspace = game:GetService("Workspace")

-- // Vars
local ServerStuff = Workspace.ServerStuff
local dropAmmo = ServerStuff.dropAmmo

-- // Drop scrap (pick it up after)
dropAmmo:FireServer("scrap", DropAmount)