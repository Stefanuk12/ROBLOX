-- // Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- // Vars
local GunCamera = require(ReplicatedStorage.Modules.Camera.Subsystems.GunCamera)

-- // Hook recoil
hookfunction(GunCamera.Recoil, function() end)