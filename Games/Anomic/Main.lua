-- Game: https://www.roblox.com/games/4581966615

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
local Sprinting = false
local changeVals = {
    Firemode = "Auto",
    MaxAmmo = math.huge,
    Firerate = 2000,
    Range = 2000000,
    ReloadTime = 0.1,
    Accuracy = 0.1,
    Speed = 250,
    Price = 0,
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
    for i,v in pairs(Character.GetChildren(Character)) do
        if v.IsA(v, "Tool") and v.FindFirstChild(v, "MainGunScript") then
            return v
        end
    end
end

-- // Silent Aim + Anti Kick
hookfunction(LocalPlayer.Kick, warn)
hookfunction(LocalPlayer.kick, warn)

local ValiantAimHacks = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Experimental%20Silent%20Aim%20Module.lua"))()
ValiantAimHacks["TeamCheck"] = false

mt.__index = newcclosure(function(t, k)
    if t == Mouse and (k == "Target" or k == "Hit") and ValiantAimHacks.checkSilentAim() then
        local CPlayer = ValiantAimHacks["Selected"].Character.Head
        return (k == "Target" and CPlayer or CPlayer.CFrame)
    end
    return backupindex(t, k)
end)

mt.__namecall = newcclosure(function(...)
    local args = {...}
    local method = getnamecallmethod()
    if method == "FireServer" then
        if args[1] == Remotes.RayDrawer and ValiantAimHacks.checkSilentAim() then
            local CPlayer = ValiantAimHacks["Selected"].Character
            args[2] = CPlayer.Head.Position
            backupnamecall(Remotes.WeaponServer, "Player", CPlayer.Humanoid, returnGun().Name, CPlayer.Head)
            return backupnamecall(unpack(args))
        end
    elseif method == "UserOwnsGamePassAync" and game:GetService("MarketplaceService"):GetProductInfo(tostring(args[2])) then
        return true
    elseif string.lower(method) == "kick" then
        return nil
    end
    return backupnamecall(...)
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


-- // Unlimited Stamina
UIS.InputBegan:Connect(function(Key, GPE)
    if not GPE and Key.KeyCode == Enum.KeyCode.LeftShift then Sprinting = true end
end)
UIS.InputEnded:Connect(function(Key, GPE)
    if not GPE and Key.KeyCode == Enum.KeyCode.LeftShift then Sprinting = false end
end)

function unlimitedStamina()
    for _,v in pairs(getgc()) do
        if getfenv(v).script and getfenv(v).script.Name == "SprintHandler" then
            for a,x in pairs(debug.getupvalues(v)) do
                if type(x) == 'number' then
                    coroutine.wrap(function()
                        while wait(0.05) do
                            if Sprinting then
                                debug.setupvalue(v, a, 100)
                            end
                        end
                    end)()
                end
            end
        end
    end
    print('Done Unlimited Stamina!')
end
unlimitedStamina()

-- // Unlimited Ammo
coroutine.wrap(function()
    while wait() do
        if returnGun() then
            local Gun = returnGun()
            if Gun then
                Gun:WaitForChild("Handle"):WaitForChild("Mag").Value = math.huge
            end
        end
    end
end)()

-- // Gun Mods
for i,v in pairs(changeVals) do
    for a,x in pairs(require(ItemList)) do
        if rawget(x, a) then
            rawset(x, a, v)
            print(a,"=",v)
        end
    end
end
print('Done Gun Mods!')

-- // Backpack
LocalPlayer.PlayerScripts.OwnsBackpackPass.Value = true
LocalPlayer.CharacterAdded:Connect(function() 
    wait(1) 
    unlimitedStamina() 
    LocalPlayer.PlayerScripts:WaitForChild("OwnsBackpackPass").Value = true 
    print('Got Backpack Gamepass!')
end)