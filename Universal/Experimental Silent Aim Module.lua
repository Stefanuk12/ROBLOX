if getgenv().ValiantAimHacks then return getgenv().ValiantAimHacks end
-- // Valiant ENV
loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/ValiantENV.lua"))()

-- // Vars
local Heartbeat = RunService.Heartbeat
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded.Wait(LocalPlayer.CharacterAdded)
local CurrentCamera = Workspace.CurrentCamera
local Mouse = LocalPlayer.GetMouse(LocalPlayer)

-- // Silent Aim Vars
getgenv().ValiantAimHacks = {
    SilentAimEnabled = true,
    AimbotEnabled = false,
    ShowFOV = true,
    VisibleCheck = true,
    TeamCheck = true,
    FOV = 60,
    HitChance = 100,
    Selected = LocalPlayer,
    BlacklistedTeams = {
        {
            Team = LocalPlayer.Team,
            TeamColor = LocalPlayer.TeamColor,
        },
    },
    BlacklistedPlayers = {game:GetService("Players").LocalPlayer},
    WhitelistedPUIDs = {91318356},
}

-- // Show FOV
local circle = Drawing.new("Circle")
function ValiantAimHacks.updateCircle()
    if circle then
        circle.Transparency = 1
        circle.Visible = ValiantAimHacks["ShowFOV"]
        circle.Thickness = 2
        circle.Color = Color3.fromRGB(231, 84, 128)
        circle.NumSides = 12
        circle.Radius = (ValiantAimHacks["FOV"] * 6) / 2
        circle.Filled = false
        circle.Position = Vector2.new(Mouse.X, Mouse.Y + (GuiService.GetGuiInset(GuiService).Y))
        return circle
    end
end

-- // Custom Functions
setreadonly(math, false); math.chance = function(percentage) local percentage = math.floor(percentage); local chance = math.floor(Random.new().NextNumber(Random.new(), 0, 1) * 100)/100; return chance <= percentage/100 end; setreadonly(math, true);
setreadonly(table, false); table.loopforeach = function(tbl, func) for index, value in pairs(tbl) do if type(value) == 'table' then table.loopforeach(value, func); elseif type(value) == 'function' then table.loopforeach(debug.getupvalues(value)); else func(index, value); end; end; end; setreadonly(table, true);

-- // Silent Aim Function
function ValiantAimHacks.getClosestPlayerToCursor()
    local ClosestPlayer = nil
    local Chance = math.chance(ValiantAimHacks["HitChance"])
    local ShortestDistance = math.huge
    if not Chance then ValiantAimHacks["Selected"] = (Chance and LocalPlayer or LocalPlayer) return (Chance and LocalPlayer or LocalPlayer) end
    function isPartVisible(Part, PartDescendant)
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
    function checkTeam(localPlayer, targetPlayer)
        if targetPlayer.Team ~= localPlayer.Team then
            for _,v in pairs(ValiantAimHacks.BlacklistedTeams) do
                if targetPlayer.Team ~= v.Team and targetPlayer.TeamColor ~= v.TeamColor then
                    return true
                end
            end
        end
        return false
    end
    function checkPlayer(targetPlayer)
        for i,v in pairs(ValiantAimHacks.BlacklistedPlayers) do
            if v ~= targetPlayer then
                return true
            end
        end
        return false
    end
    function checkWhitelisted(targetPlayer)
        for i,v in pairs(ValiantAimHacks.WhitelistedPUIDs) do
            if targetPlayer.UserId == v then
                return true
            end
        end
        return false
    end
    for _,plr in pairs(Players.GetPlayers(Players)) do
        if not checkWhitelisted(plr) and checkPlayer(plr) and plr.Character and plr.Character.PrimaryPart and plr.Character.FindFirstChildWhichIsA(plr.Character, "Humanoid") and plr.Character.FindFirstChildWhichIsA(plr.Character, "Humanoid").Health > 0 then
            if (ValiantAimHacks["TeamCheck"] and not checkTeam(LocalPlayer, plr)) then break end
            local PartPos, OnScreen = CurrentCamera.WorldToViewportPoint(CurrentCamera, plr.Character.PrimaryPart.Position)
            local Magnitude = (Vector2.new(PartPos.X, PartPos.Y) - Vector2.new(Mouse.X, Mouse.Y)).magnitude  
            if (Magnitude < (ValiantAimHacks["FOV"] * 6 - 8)) and (Magnitude < ShortestDistance) then
                if ValiantAimHacks["VisibleCheck"] and isPartVisible(plr.Character.PrimaryPart, plr.Character) then
                    ClosestPlayer = plr
                    ShortestDistance = Magnitude
                elseif not ValiantAimHacks["VisibleCheck"] then
                    ClosestPlayer = plr
                    ShortestDistance = Magnitude
                end
            end
        end
    end
    ValiantAimHacks["Selected"] = (Chance and ClosestPlayer or LocalPlayer)
    return (Chance and ClosestPlayer or LocalPlayer)
end

function ValiantAimHacks.findDirectionNormalMaterial(Origin, Destination, UnitMultiplier)
    if typeof(Origin) == "Vector3" and typeof(Destination) == "Vector3" then
        if not UnitMultiplier then UnitMultiplier = 1 end
        local Direction = (Destination - Origin).Unit * UnitMultiplier
        local RaycastResult = Workspace.Raycast(Workspace, Origin, Direction)
        if RaycastResult ~= nil then
            local Normal = RaycastResult.Normal
            local Material = RaycastResult.Material
            return Direction, Normal, Material
        end
    end
    return nil
end

function ValiantAimHacks.checkSilentAim()
    if ValiantAimHacks.SilentAimEnabled and ValiantAimHacks["Selected"] ~= LocalPlayer then
        return true
    end
    return false
end

-- // Heartbeat Function
local HBFuncs = function()
    ValiantAimHacks.updateCircle()
    ValiantAimHacks.getClosestPlayerToCursor()
end
Heartbeat.Connect(Heartbeat, HBFuncs)
--setreadonly(mt, true)
return ValiantAimHacks