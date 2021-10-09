-- // Honestly, I have no idea what this even does. It was just requested.

-- // Services
local Players = game:GetService("Players")

-- // Vars
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- // Get the stat holder thing idk
local StatHolder
do
    for _, Connection in ipairs(getconnections(Mouse.Button2Down)) do
        StatHolder = debug.getupvalue(debug.getupvalue(Connection.Function, 6), 4)
        break
    end
end

-- // Set dog tags
StatHolder.dogtags = 100