-- // Services
local ScriptContext = game:GetService("ScriptContext")
local Players = game:GetService("Players")

-- // Metatable Stuff
local mt = getrawmetatable(game)
local backupindex = mt.__index
setreadonly(mt, false)

-- // Disable error detection
do
    local connections = getconnections(ScriptContext.Error)
    for i = 1, #connections do
        local v = connections[i]
        v:Disable()
    end
end

-- // Silent Aim
local ValiantAimHacks = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Experimental%20Silent%20Aim%20Module.lua"))()
ValiantAimHacks["TeamCheck"] = false
mt.__index = newcclosure(function(t, k)
    if t:IsA("Mouse") and (k == "Hit" or k == "Target") then
        if ValiantAimHacks.checkSilentAim() then
            local CPlayer = rawget(ValiantAimHacks, "Selected")
            if CPlayer and CPlayer.Character and CPlayer.Character.FindFirstChild(CPlayer.Character, "Head") then
                return (k == "Hit" and CPlayer.Character.Head.CFrame or CPlayer.Character.Head)
            end
        end
    end
    return backupindex(t, k)
end)

-- // Metatable
setreadonly(mt, true)