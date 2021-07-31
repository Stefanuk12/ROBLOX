--[[
Within Synapse, 3ds still has not fixed the issue with Core-Script made connections. Doing anything with the connection object will result in a crash. In this example, HealthChanged is a connection made by some CoreScript, and we indexed the Function of that connection object. You may also enable it, disable it, etc. Do anything to it, you crash.

- ez 1 line crash
--]]

local crash = getconnections(game.Players.LocalPlayer.Character.Humanoid.HealthChanged)[1].Function