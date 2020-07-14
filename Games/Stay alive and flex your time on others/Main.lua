-- Game: https://roblox.com/games/5278850819

-- // Vars
local LocalPlayer = game:GetService("Players").LocalPlayer
local Backpack = LocalPlayer.Backpack
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
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
getgenv().spoofValues = {
    WalkSpeed = 16,
    JumpPower = 50,
    HipHeight = 0.1,
    Health = 100,
    MaxHealth = 100,
    PlatformStand = false,
}

-- // Base MT Vars + Funs
local mt = getrawmetatable(game)
local backupindex = mt.__index 
local backupnamecall = mt.__namecall
setreadonly(mt, false)

-- // Anti Kick
hookfunction(LocalPlayer.Kick, warn)
hookfunction(LocalPlayer.kick, warn)
mt.__namecall = newcclosure(function(...)
    if string.lower(getnamecallmethod()) == "kick" then return end
    return backupnamecall(...)
end)


-- // MT Spoofing
mt.__index = newcclosure(function(t, k)
    if not checkcaller() then
        if tostring(t) == "Handle" and k == "Size" then
            return Vector3.new(1, 0.8, 4)
        elseif tostring(t) == "Sword" and k == "GripPos" then
            return Vector3.new(0, 0, -1.7)
        elseif rawget(spoofValues, k) then
            return rawget(spoofValues, k)
        end
    end
    return backupindex(t, k)
end)

-- // Functions
function removeAC() -- // I couldve done better but cba
    Character:WaitForChild("Head")
    for _,v in pairs(getgc()) do
        if debug.getinfo(v).name == "tpcheck" then
            for a,x in pairs(debug.getconstants(v)) do
                debug.setconstant(v, a, nil)
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