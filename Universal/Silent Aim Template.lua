-- // Valiant ENV
loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/ValiantENV.lua"))()

-- // Vars
local RenderStepped = RunService.RenderStepped
local Heartbeat = RunService.Heartbeat
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded.Wait(LocalPlayer.CharacterAdded)
local Humanoid = Character.WaitForChild(Character, "Humanoid")
local CurrentCamera = Workspace.CurrentCamera
local Mouse = LocalPlayer.GetMouse(LocalPlayer)

-- // Base MT Vars + Funs
local mt = getrawmetatable(game)
local backupnamecall = mt.__namecall
local backupnewindex = mt.__newindex
local backupindex = mt.__index 
setreadonly(mt, false)

-- // Silent Aim Vars
getgenv().AimHacks = {
    SilentAimEnabled = true,
    AimbotEnabled = false,
    ShowFOV = true,
    VisibleCheck = true,
    TeamCheck = true,
    FOV = 60,
    HitChance = 100,
    Selected = LocalPlayer,
    BlacklistedPlayers = {game:GetService("Players").LocalPlayer.Name},
    BlacklistedTeams = {tostring(game:GetService("Players").LocalPlayer.Team)},
}

-- // Show FOV
local circle = Drawing.new("Circle")
function updateCircle()
    if circle then
        circle.Transparency = 1
        circle.Visible = AimHacks["ShowFOV"]
        circle.Thickness = 2
        circle.Color = Color3.fromRGB(231, 84, 128)
        circle.NumSides = 12
        circle.Radius = (AimHacks["FOV"] * 6) / 2
        circle.Filled = false
        circle.Position = Vector2.new(Mouse.X, Mouse.Y + (GuiService.GetGuiInset(GuiService).Y))
    end
end

-- // Custom Functions
setreadonly(math, false); math.chance = function(percentage) local percentage = math.floor(percentage); local chance = math.floor(Random.new().NextNumber(Random.new(), 0, 1) * 100)/100; return chance <= percentage/100 end; setreadonly(math, true);
setreadonly(table, false); table.loopforeach = function(tbl, func) for index, value in pairs(tbl) do if type(value) == 'table' then table.loopforeach(value, func); elseif type(value) == 'function' then table.loopforeach(debug.getupvalues(value)); else func(index, value); end; end; end; setreadonly(table, true);

-- // Silent Aim Function
function checkTable(Item, Table)
    local Passed = false
    if type(Item) ~= "string" then Item = tostring(Item) end
	for i,v in pairs(Table) do 
		if Table[i] then 
			Passed = true
		end
	end
	return Passed
end

local getClosestPlayerToCursor = function()
    local ClosestPlayer = nil
    local Chance = math.chance(AimHacks["HitChance"])
    local ShortestDistance = math.huge
    if not Chance then AimHacks["Selected"] = (Chance and LocalPlayer or LocalPlayer) return (Chance and LocalPlayer or LocalPlayer) end
    local isPartVisible = function(Part, PartDescendant)
        local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded.Wait(LocalPlayer.CharacterAdded)
        local Origin = CurrentCamera.CFrame.p
        local _, OnScreen = CurrentCamera.WorldToViewportPoint(CurrentCamera, Part.Position)
        if OnScreen then
            local newRay = Ray.new(Origin, Part.Position - Origin)
            local PartHit, _ = Workspace.FindPartOnRayWithIgnoreList(Workspace, newRay, {Character, CurrentCamera})
            local Visible = (not PartHit or PartHit.IsDescendantOf(PartHit, PartDescendant))
            return Visible
        end
        return false
    end
    for _,plr in pairs(Players.GetPlayers(Players)) do
        if plr ~= LocalPlayer and plr.Character and plr.Character.FindFirstChild(plr.Character, "Humanoid") and plr.Character.Humanoid.Health > 0 and not checkTable(plr.Name, AimHacks["BlacklistedPlayers"]) then
            if (AimHacks["TeamCheck"] and plr.Team ~= LocalPlayer.Team and not checkTable(tostring(plr.Team), AimHacks["BlacklistedTeams"])) then
                local PartPos, OnScreen = CurrentCamera.WorldToViewportPoint(CurrentCamera, plr.Character.PrimaryPart.Position)
                local Magnitude = (Vector2.new(PartPos.X, PartPos.Y) - Vector2.new(Mouse.X, Mouse.Y)).magnitude  
                if (Magnitude < (AimHacks["FOV"] * 6 - 8)) and (Magnitude < ShortestDistance) then
                    if AimHacks["VisibleCheck"] and isPartVisible(plr.Character.PrimaryPart, plr.Character) then
                        ClosestPlayer = plr
                        ShortestDistance = Magnitude
                    elseif not AimHacks["VisibleCheck"] then
                        ClosestPlayer = plr
                        ShortestDistance = Magnitude
                    end
                end
            else
                local PartPos, OnScreen = CurrentCamera.WorldToViewportPoint(CurrentCamera, plr.Character.PrimaryPart.Position)
                local Magnitude = (Vector2.new(PartPos.X, PartPos.Y) - Vector2.new(Mouse.X, Mouse.Y)).magnitude  
                if (Magnitude < (AimHacks["FOV"] * 6 - 8)) and (Magnitude < ShortestDistance) then
                    if AimHacks["VisibleCheck"] and isPartVisible(plr.Character.PrimaryPart, plr.Character) then
                        ClosestPlayer = plr
                        ShortestDistance = Magnitude
                    elseif not AimHacks["VisibleCheck"] then
                        ClosestPlayer = plr
                        ShortestDistance = Magnitude
                    end
                end
            end
        end
    end
    AimHacks["Selected"] = (Chance and ClosestPlayer or LocalPlayer)
    return (Chance and ClosestPlayer or LocalPlayer)
end

-- // Heartbeat Function
local HBFuncs = function()
    updateCircle()
    getClosestPlayerToCursor()
end
Heartbeat.Connect(Heartbeat, HBFuncs)

-- // Silent Aim 
--[[
mt.__index = newcclosure(function(t, k)
    if t:IsA("Mouse") and AimHacks["SilentAimEnabled"] and (AimHacks["Selected"] ~= game:GetService("Players").LocalPlayer) and (tostring(k) == "Hit" or tostring(k) == "Target") then
		local CPlayer = AimHacks["Selected"] 
		return (tostring(k) == "Target" and CPlayer.Character.Head or CPlayer.Character.Head.CFrame)	
	end
    return backupindex(t, k)
end)
]]
--[[
mt.__namecall = newcclosure(function(...)
    local args = {...}
    if tostring(args[1]) == "RenderBull" and AimHacks["Selected"] ~= LocalPlayer then
        local CPlayer = AimHacks["Selected"]
        args[2] = CPlayer.Character.Head.Position
        args[3] = CPlayer.Character.Head.Position
       	return backupnamecall(unpack(args))
    end
    return backupnamecall(...)
end)
]]

setreadonly(mt, true)