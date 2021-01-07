-- // Services
local Players = game:GetService("Players")

-- // Vars
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer.PlayerGui
local GameGUI = PlayerGui.GameGUI

-- // Metatable Vars
local mt = getrawmetatable(game)
local backupnamecall = mt.__namecall
setreadonly(mt, false)

-- // Hook
mt.__namecall = newcclosure(function(...)
    -- // Vars
    local args = {...}
    local method = getnamecallmethod()
    
    -- //
    local Crouch = GameGUI.FindFirstChild(GameGUI, "Crouch")
    if (not checkcaller() and Crouch and method == "IsA" and args[2] == "Instance") then
        local doorScript = Crouch.FindFirstChild(Crouch, "DoorScript")
        if (doorScript and getcallingscript() == doorScript) then
            return wait(9e9)
        end
    end
    -- // Return
    return backupnamecall(...)
end)

-- // Revert
setreadonly(mt, true)