-- Game: https://www.roblox.com/games/4581966615
--[[
    Bugs: 
        

    Caution:
        1. You will get kicked if you rapid fire for long enough. If you want to remove rapid fire then make:
            local changeVals = {
                Firemode = "Auto",
                MaxAmmo = math.huge,
                Firerate = 2000,
                Range = 2000000,
                ReloadTime = 0.1,
                Accuracy = 0.1,
                Speed = 250,
            }
        into this:
            local changeVals = {
                MaxAmmo = math.huge,
                Range = 2000000,
                ReloadTime = 0.1,
                Accuracy = 0.1,
                Speed = 250,
            }

    Unsure:
        1. Not sure if Firerate and Firemode even work. Removed for now. You can add it back in if you want.

    Side Notes:
        1. Infinite Stamina works weirdly. 3ds pls fix Connection.Function!!!!
        2. Silent Aim works, the hit marker just doesn't appear
]]

-- // Valiant ENV
loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/ValiantENV.lua"))()

-- // Vars
local UIS = game:GetService("UserInputService")
local RenderStepped = RunService.RenderStepped
local Heartbeat = RunService.Heartbeat
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded.Wait(LocalPlayer.CharacterAdded)
local Backpack = LocalPlayer.Backpack
local Humanoid = Character.WaitForChild(Character, "Humanoid")
local CurrentCamera = Workspace.CurrentCamera
local Mouse = LocalPlayer.GetMouse(LocalPlayer)
local ItemList = ReplicatedStorage.Client.ItemList
local changeVals = {
    --Firemode = "Auto",
    MaxAmmo = math.huge,
    --Firerate = 2000,
    Range = 2000000,
    ReloadTime = 0.1,
    Accuracy = 0.1,
    Speed = 250,
}
local Remotes = game:GetService("ReplicatedStorage")["_CS.Events"]

-- // Base MT Vars + Funs
local mt = getrawmetatable(game)
local backupnamecall = mt.__namecall
local backupnewindex = mt.__newindex
local backupindex = mt.__index 
setreadonly(mt, false)

-- // Get Gun
function returnGun()
    for i,v in pairs(Character:GetChildren()) do
        if v.IsA(v, "Tool") and v.FindFirstChild(v, "MainGunScript") and v.MainGunScript.FindFirstChild(v.MainGunScript, "FireEvent") then
            return v.Name
        end
    end
end
-- // Silent Aim + Anti Kick
hookfunction(LocalPlayer.Kick, warn)
hookfunction(LocalPlayer.kick, warn)


local ValiantAimHacks = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Experimental%20Silent%20Aim%20Module.lua"))()
ValiantAimHacks["TeamCheck"] = false
ValiantAimHacks["HitChance"] = 100

mt.__namecall = newcclosure(function(...)
    local args = {...}
    local method = getnamecallmethod()
    if not checkcaller() then
        if string.lower(method) == "kick" then
            return nil
        end
    end
    return backupnamecall(...)
end)

local randomBodyPart = {
    "Head",
    "UpperTorso",
    "LowerTorso",
    "LeftUpperLeg",
    "RightUpperLeg"
}

mt.__index = newcclosure(function(t, k)
    if not checkcaller() and t:IsA("Mouse") and (k == "Hit" or k == "Target") then
        if ValiantAimHacks.checkSilentAim() then
            local CPlayer = rawget(ValiantAimHacks, "Selected").Character
            local randomNum = math.random(1, 5)
            local targetPart = rawget(randomBodyPart, randomNum) -- // bc of stoopid "anti aimbot" that limits legit players
            if CPlayer and CPlayer.FindFirstChild(CPlayer, targetPart) then
                return (k == "Hit" and CPlayer[targetPart].CFrame or CPlayer[targetPart])
            end
        end
    end
    return backupindex(t, k)
end)
print('Done Silent Aim!')


--[[ // Trash AC Bypass
local connections = {
    Humanoid.GetPropertyChangedSignal(Humanoid, "WalkSpeed"),
    Workspace.ChildAdded,
    Character.DescendantAdded
}

function removeConnections()
    for _,v in pairs(connections) do
        for _,connection in pairs(getconnections(v)) do
            if getfenv(connection.Function).script and getfenv(connection.Function).script.Name == "KeyDetector" then
                connection:Disable()
                print('Connection Disabled!')
            end
        end
    end
end
removeConnections()
LocalPlayer.CharacterAdded:Connect(removeConnections)]]


-- // Unlimited Stamina + Toggle Silent Aim
UIS.InputBegan:Connect(function(Key, GPE)
    if not GPE then
        if Key.KeyCode == Enum.KeyCode.F4 then 
            ValiantAimHacks["SilentAimEnabled"] = not ValiantAimHacks["SilentAimEnabled"] 
            ValiantAimHacks["ShowFOV"] = not ValiantAimHacks["ShowFOV"]
        end
        if Key.KeyCode == Enum.KeyCode.LeftShift then Humanoid.WalkSpeed = 23 end
    end
end)
UIS.InputEnded:Connect(function(Key, GPE)
    if not GPE then
        if Key.KeyCode == Enum.KeyCode.LeftShift then Humanoid.WalkSpeed = 13 end
    end
end)

-- // Gun Mods
function gunMods()
    for i,v in pairs(changeVals) do
        for _,x in pairs(require(ItemList)) do
            if rawget(x, i) then
                rawset(x, i, v)
            end
        end
    end
    print('Done Gun Mods!')
end
gunMods()


-- // Unlimited Ammo
function unlimtedAmmo()
    LocalPlayer.Character.ChildAdded:Connect(function(v)
        if v.IsA(v, "Tool") and v.FindFirstChild(v, "MainGunScript") then
            v.Handle.Mag:GetPropertyChangedSignal("Value"):Connect(function()
                v.Handle.Mag.Value = math.huge
            end)
            v.Handle.Mag.Value = math.huge
            print('Done Unlimited Ammo!')
        end
    end)
end
unlimtedAmmo()

-- // Unlimited Stamina
function unlimitedStamina()
    wait(3)
    if game:GetService("StarterPlayer").StarterCharacterScripts:FindFirstChild("SprintHandler") then
        game:GetService("StarterPlayer").StarterCharacterScripts:FindFirstChild("SprintHandler"):Destroy()
    end
    for i,v in pairs(getgc()) do
        if getfenv(v).script and getfenv(v).script.Name == "SprintHandler" then
            for a,x in pairs(debug.getupvalues(v)) do
                if type(x) == 'number' then
                    coroutine.wrap(function()
                        while wait() do
                            debug.setupvalue(v, a, 100)
                        end
                    end)()
                end
            end
        end
    end
    print('Done Unlimited Stamina!')
end
unlimitedStamina()

-- // Backpack
LocalPlayer.PlayerScripts.OwnsBackpackPass.Value = true
LocalPlayer.CharacterAdded:Connect(function() 
    LocalPlayer.PlayerScripts:WaitForChild("OwnsBackpackPass").Value = true 
    print('Got Backpack Gamepass!')
    unlimtedAmmo()
    unlimitedStamina()
end)