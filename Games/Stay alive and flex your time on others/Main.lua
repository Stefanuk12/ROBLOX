-- Game: https://roblox.com/games/5278850819

-- // Vars
local Workspace = game:GetService("Workspace")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Backpack = LocalPlayer.Backpack
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local Connections = {
    {Part = LocalPlayer.Character.AntiExploit, Disabled = false, Remove = true},
    {Part = Character.Head.HUD.HealthDisplay.TextLabel.HealthUpdater, Disabled = false, Remove = true},
    {Part = Character.Head.HUD.HUDSettings, Disabled = false, Remove = true},
    {Part = Character.Head.HUD.TimeDisplay.TextLabel.TimeUpdater, Disabled = false, Remove = true},
    {Part = Workspace.Structure.Leaderboard, Disabled = false},
    {Part = Workspace.Structure.Floor, Disabled = false},
    {Part = Workspace.Structure.KillPart, Disabled = false, Remove = true},
    {Part = Workspace.Structure.KillRoof, Disabled = false, Remove = true},
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
        elseif string.match(tostring(t), "Sword") and k == "GripPos" then
            return Vector3.new(0, 0, -1.7)
        elseif t == Humanoid and rawget(spoofValues, k) then
            return rawget(spoofValues, k)
        end
    end
    return backupindex(t, k)
end)

-- // Functions
function removeIdentifying()
    for _,v in pairs(Character:GetChildren()) do
        if v:IsA("Accessory") then v:Destroy() end
        if v:FindFirstChild("HUD") then v.HUD:Destroy() end
        if v:FindFirstChildWhichIsA("Decal") then v:FindFirstChildWhichIsA("Decal"):Destroy() end
        if v:IsA("Humanoid") then v.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff v.NameDisplayDistance = Enum.HumanoidDisplayDistanceType.None end
    end
end

function removeAC() -- // I couldve done better but cba
    Character:WaitForChild("Head")
    for _,v in pairs(getgc()) do
        if debug.getinfo(v).name == "tpcheck" then
            for a,x in pairs(debug.getconstants(v)) do
                debug.setconstant(v, a, nil)
            end
        end
    end
    for _, v in pairs(Connections) do
        if v.Part then
            for _, connection in pairs(getconnections(v.Part.Changed)) do
                connection:Disable() -- // why doesnt this work :(
                v.Disabled = true
            end
        end
    end  
end

function killAll() -- // crashse on synapse but added bc why not
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local Sword = LocalPlayer.Character:FindFirstChild("Sword")
    
    if Sword then
        local SwordHandle = Sword.Handle
        for _,v in pairs(Players:GetPlayers()) do
            coroutine.wrap(function()
                if v ~= LocalPlayer and v.Character and v.Character.PrimaryPart then
                    local targetPart = v.Character.PrimaryPart
                    repeat
                        firetouchinterest(Sword, targetPart, 0); wait()
                        firetouchinterest(Sword, targetPart, 1); wait()
                    until not v or not v.Character or (v and v.Character and v.Character.Humanoid.Health > 0 )
                end
            end)()
        end
    end
end

LocalPlayer.CharacterAdded:Connect(function()
    removeIdentifying()
    removeAC()
end)