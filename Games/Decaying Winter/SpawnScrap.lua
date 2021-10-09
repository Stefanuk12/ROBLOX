-- // DO NOT GO OVER 1910 SCRAP, YOU WILL GET KICKED

-- // Configuration
local DropAmount = 100 -- // DO NOT GO OVER 1999, YOU WILL GET BANNED

-- // Services
local Workspace = game:GetService("Workspace")

-- // Vars
local ServerStuff = Workspace.ServerStuff
local dropAmmo = ServerStuff.dropAmmo

-- // Drop scrap (pick it up after)
dropAmmo:FireServer("scrap", DropAmount)