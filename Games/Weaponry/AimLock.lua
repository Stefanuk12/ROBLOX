-- // Services
local Workspace = game:GetService("Workspace")

-- // Vars
local CurrentCamera = Workspace.CurrentCamera

-- // Metatable Vars
local mt = getrawmetatable(game)
local backupindex = mt.__index
setreadonly(mt, false)

-- // Load Silent Aim
loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Experimental%20Silent%20Aim%20Module.lua"))()

-- // Hook
mt.__index = newcclosure(function(t, k)
    if (t:IsA("Mouse") and (k == "X" or k == "Y" or k == "Target" or "Hit") and ValiantAimHacks.checkSilentAim()) then
        -- // Vars
        local CPlayerHead = ValiantAimHacks.getCharacter(ValiantAimHacks.Selected).Head
        local HeadScreenPosition = CurrentCamera:WorldToViewportPoint(CPlayerHead.CFrame.Position)

        -- // X, Y
        if (k == "X" or k == "Y") then
            return (k == "X" and HeadScreenPosition.X or HeadScreenPosition.Y)
        end

        -- // Target, Hit
        if (k == "Target" or k == "Hit") then
            return (k == "Target" and CPlayerHead or CPlayerHead.CFrame)
        end
    end
    return backupindex(t, k)
end)

-- // Reset Metatable
setreadonly(mt, true)