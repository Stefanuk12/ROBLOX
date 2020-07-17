-- // Game: https://www.roblox.com/games/1213026131

--[[
    Features:
        Gun Mods,
        AC Bypass,
        Silent Aim
]]

-- // Valiant ENV
local ValiantENV = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/ValiantENV.lua"))()

-- // Vars
local UIS = game:GetService("UserInputService")
local RenderStepped = RunService.RenderStepped
local Heartbeat = RunService.Heartbeat
local LocalPlayer = game:GetService("Players").LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded.Wait(LocalPlayer.CharacterAdded)
local Backpack = LocalPlayer.Backpack
local PlayerGui = LocalPlayer.PlayerGui
local Humanoid = Character.WaitForChild(Character, "Humanoid")
local CurrentCamera = Workspace.CurrentCamera
local Mouse = LocalPlayer.GetMouse(LocalPlayer)
getgenv().USADC = {}
USADC.GunMods = {
    ["A"] = {
        ["Clip"] = 1/0,
        ["MagazineBullets"] = 1/0,
    },
    ["B"] = {
        ["BULLET_SPEED"] = 1/0,
        ["DISTANCE_TO_SPREAD_RATIO"] = 0, -- // Doesn't seem to work?
        ["MAX_DISTANCE"] = 1/0,
    }
}

-- // Base MT Vars + Funs
local mt = getrawmetatable(game)
local backupnamecall = mt.__namecall
local backupnewindex = mt.__newindex
local backupindex = mt.__index 
setreadonly(mt, false)

-- // Reload func - Bypasses anti inf ammo
function USADC.reloadWeapon(targetWeapon)
    if not targetWeapon then targetWeapon = Character:FindFirstChildWhichIsA("Tool") end
    game:GetService("ReplicatedStorage").Events.BulletHandler:FireServer("reload", {["tool"] = targetWeapon})
end

coroutine.wrap(function()
    while wait() do
        if Character:FindFirstChildWhichIsA("Tool") then
            USADC.reloadWeapon(Character:FindFirstChildWhichIsA("Tool"))
        end
    end
end)()

-- // Disable Connections (AC)
function USADC.disableConnections()
    local Connections = {
        {Connection = PlayerGui.DescendantRemoving, Script1 = "AEClient", Script2 = "Script2Holder"},
        {Connection = PlayerGui.AEClient.Changed, Script1 = "AEClient", Script2 = "Verify"},
        {Connection = PlayerGui.AEClient.Verify.Changed, Script1 = "AEClient", Script2 = "Verify"},
        {Connection = LocalPlayer.Changed, Script1 = "AEClient", Script2 = "Script2Holder"},
        {Connection = game:GetService("Selection").SelectionChanged, Script1 = "AEClient", Script2 = "Script2Holder"},
        {Connection = Backpack.DescendantAdded, Script1 = "AEClient", Script2 = "Script2Holder"},
        {Connection = Character.DescendantAdded, Script1 = "AEClient", Script2 = "Script2Holder"},
        {Connection = Humanoid.Changed, Script1 = "PlayerSetup", Script2 = "Script2Holder"},
        {Connection = Character:WaitForChild("Torso").Changed, Script1 = "PlayerSetup", Script2 = "Script2Holder"},
    }
    local checkScript = false
    for _,v in pairs(Connections) do
        local targetConnection = v.Connection
        local Script1, Script2 = v.Script1, v.Script2

        for _, connection in pairs(getconnections(targetConnection)) do 
            if checkScript then
                local connectionFunction = connection.Function -- // Crashes on Synapse :(
                if getfenv(connectionFunction).script and getfenv(connectionFunction).script.Name == Script1 or getfenv(connectionFunction).script.Name == Script2 then
                    connection:Disable()
                    print('Disabled')
                end
            end
        end
    end
end
USADC.disableConnections()
LocalPlayer.CharacterAdded:Connect(USADC.disableConnections)

-- // AC Bypass 
mt.__namecall = newcclosure(function(...)
    local args = {...}
    local method = getnamecallmethod()

    if method == "FireServer" then
        if tostring(args[1]) == "BanningPlayer" and args[2] == "Kick" and args[3] == nil and args[4] == "Invisible Exploiting" then
            return
        end
        if tostring(args[1]) == "AE" then
            if args[2] == "Exploit" and typeof(args[3]) == 'number' and args[3] > 0 and args[3] < 10 and args[3] ~= 7 then
                return
            elseif args[2] == "ReplicatedPartCheck" then
                return 
            end
        end
    end
    return backupnamecall(...)
end)

-- // Get the gun table so we can mod it
function USADC.returnGunTable(targetGun)
    local returnA, returnB
    for _,v in pairs(getgc(true)) do
        if v and typeof(v) == 'table' then
            if v and typeof(v) == 'table' and tostring(rawget(v, "Tool")) == tostring(targetGun) then
                returnA = v
            elseif v and typeof(v) == 'table' and rawget(v, "BULLET_SPEED") then
                returnB = v
            end
        end
    end
    return returnA, returnB
end

-- // Does GunMods
function USADC.doGunMods(targetGun)
    local gA, gB = USADC.returnGunTable(targetGun)
    for i,v in pairs(USADC.GunMods["B"]) do
        if rawget(gB, i) and rawget(gB, i) ~= v then
            rawset(gB, i, v)
            print(i,"=",v)
        end
    end
    if targetGun then
        for i,v in pairs(USADC.GunMods["A"]) do
            if rawget(gA, i) and rawget(gA, i) ~= v then
                rawset(gA, i, v)
                print(i,"=",v)
            end
        end
    end
end

local function tableHandler(targetTable, onUA)
    local onUA = onUA or function() end
	return setmetatable({}, {
		__index = targetTable,
		__newindex = function(self, index, value)
		    local updateTable = {}
		    table.insert(updateTable, {index, value, targetTable[index]})
			targetTable[index] = value
			table.insert(updateTable, {index, value, targetTable[index]})
            onUA(updateTable)
		end
	})
end
USADC.GunMods = tableHandler(USADC.GunMods, function(givenTable)
    USADC.doGunMods(Character:FindFirstChildWhichIsA("Tool"))
end)

Character.ChildAdded:Connect(function(child)
    if child:IsA("Tool") then wait(0.1) USADC.doGunMods(child) end
end)

-- // Silent Aim
loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Experimental%20Silent%20Aim%20Module.lua"))()
ValiantAimHacks["TeamCheck"] = false
mt.__index = newcclosure(function(t, k)
    if t:IsA("Mouse") and (k == "Hit" or k == "Target") then
        if ValiantAimHacks.checkSilentAim() then
            local CPlayer = rawget(ValiantAimHacks, "Selected").Character
            if CPlayer and CPlayer:FindFirstChild("Head") then
                return (k == "Hit" and CPlayer.Head.CFrame or CPlayer.Head)
            end
        end
    end
    return backupindex(t, k)
end)

--[[
    --// Remote: game:GetService("ReplicatedStorage").Events.BulletHandler
    --// Script: game:GetService("Workspace").PLAYERNAMENONO.M9.GunScript
    --// Function: function: 0x930bbfd4b03e46b8

    local v1 = "fire"
    local v2 = 
    {
        ["hitPos"] = Vector3.new(741.669128, 115.246994, 61.0208435), 
        ["tool"] = game:GetService("Workspace").PLAYERNAMENONO.M9, 
        ["raw_dis"] = 9991.380859375, 
        ["spread"] = 279.8, 
        ["target"] = Vector3.new(-6099.13867, 1764.06409, -6005.29834), 
        ["dis"] = 701.00006103516, 
        ["key"] = 143218973, 
        ["start"] = Vector3.new(1253.88843, 7.04982615, 527.203003), 
        ["expected"] = 1, 
        ["spreadVector"] = Vector3.new(108.5, 180.900009, 258.399994), 
        ["count"] = 1
    }
    local rem = game:GetService("ReplicatedStorage").Events.BulletHandler

    rem:FireServer(v1, v2)
]]