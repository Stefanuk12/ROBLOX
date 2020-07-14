-- Game: https://roblox.com/games/5278850819

-- // Valiant ENV
loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/ValiantENV.lua"))()

-- // Vars
local RenderStepped = RunService.RenderStepped
local Heartbeat = RunService.Heartbeat
local LocalPlayer = Players.LocalPlayer
local Backpack = LocalPlayer.Backpack
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded.Wait(LocalPlayer.CharacterAdded)
local Humanoid = Character.WaitForChild(Character, "Humanoid")
local CurrentCamera = Workspace.CurrentCamera
local Mouse = LocalPlayer.GetMouse(LocalPlayer)
local Connections = {
    LocalPlayer.Character.AntiExploit.Changed,
    Character.Head.HUD.HealthDisplay.TextLabel.HealthUpdater.Changed,
    Character.Head.HUD.HUDSettings.Changed,
    Character.Head.HUD.TimeDisplay.TextLabel.TimeUpdater.Changed,
    Workspace.Structure.Leaderboard.Changed,
    Workspace.Structure.Floor.Changed,
    Workspace.Structure.KillPart.Changed,
    Workspace.Structure.KillRoof.Changed,
}

-- // Base MT Vars + Funs
local mt = getrawmetatable(game)
local backupnamecall = mt.__namecall
local backupnewindex = mt.__newindex
local backupindex = mt.__index 
setreadonly(mt, false)

-- // Functions
function removeAC() -- // I couldve done better but cba
    Character:WaitForChild("Head")
    for _, v in pairs(getgc()) do
        if typeof(v) == 'function' then
            if getfenv(v).script then
                if getfenv(v).script.Name == "HUDSettings" then
                    for a, x in pairs(debug.getconstants(v)) do
                        debug.setconstant(v, a, nil)
                    end
                end
            end
            if debug.getinfo(v).name == "tpcheck" then
                hookfunction(v, function() return end)
            end
        end
    end
    pcall(function()
        for i, v in pairs(Connections) do
            for _, connection in pairs(getconnections(v)) do
                connection:Disable()
            end
        end
    end) 
end

removeAC()
LocalPlayer.CharacterAdded:Connect(removeAC)

-- // MT Spoofing
mt.__index = newcclosure(function(t, k)
    if not checkcaller() then
        if tostring(t) == "Handle" and k == "Size" then
            return Vector3.new(1, 0.8, 4)
        end
        if tostring(t) == "Sword" and k == "GripPos" then
            return Vector3.new(0, 0, -1.7)
        end
    end
    return backupindex(t, k)
end)