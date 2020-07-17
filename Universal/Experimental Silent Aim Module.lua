if getgenv().ValiantAimHacks then return getgenv().ValiantAimHacks end

-- // Vars
local Heartbeat = game.GetService(game, "RunService").Heartbeat
local GuiService = game.GetService(game, "GuiService")
local LocalPlayer = game.GetService(game, "Players").LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded.Wait(LocalPlayer.CharacterAdded)
local CurrentCamera = game:GetService("Workspace").CurrentCamera
local Mouse = LocalPlayer.GetMouse(LocalPlayer)

-- // Silent Aim Vars
getgenv().ValiantAimHacks = {
    SilentAimEnabled = true,
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
    BlacklistedPlayers = {game.GetService(game, "Players").LocalPlayer},
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

-- // Customisable Checking Functions

function ValiantAimHacks.isPartVisible(Part, PartDescendant)
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

function ValiantAimHacks.checkTeam(targetPlayer)
    if targetPlayer.Team ~= LocalPlayer.Team then
        for _,v in pairs(ValiantAimHacks.BlacklistedTeams) do
            if targetPlayer.Team ~= v.Team and targetPlayer.TeamColor ~= v.TeamColor then
                return true
            end
        end
    end
    return false
end

function ValiantAimHacks.checkPlayer(targetPlayer)
    for i,v in pairs(ValiantAimHacks.BlacklistedPlayers) do
        if v ~= targetPlayer then
            return true
        end
    end
    return false
end

function ValiantAimHacks.checkWhitelisted(targetPlayer)
    for i,v in pairs(ValiantAimHacks.WhitelistedPUIDs) do
        if targetPlayer.UserId == v then
            return true
        end
    end
    return false
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

-- // Silent Aim Function
function ValiantAimHacks.getClosestPlayerToCursor()
    local ClosestPlayer = nil
    local Chance = math.chance(ValiantAimHacks["HitChance"])
    local ShortestDistance = 1/0
    if not Chance then ValiantAimHacks["Selected"] = (Chance and LocalPlayer or LocalPlayer) return (Chance and LocalPlayer or LocalPlayer) end
    for _,plr in pairs(Players.GetPlayers(Players)) do
        if not ValiantAimHacks.checkWhitelisted(plr) and ValiantAimHacks.checkPlayer(plr) and plr.Character and plr.Character.PrimaryPart and plr.Character.FindFirstChildWhichIsA(plr.Character, "Humanoid") and plr.Character.FindFirstChildWhichIsA(plr.Character, "Humanoid").Health > 0 then
            if (ValiantAimHacks["TeamCheck"] and not ValiantAimHacks.checkTeam(LocalPlayer, plr)) then break end
            local PartPos, OnScreen = CurrentCamera.WorldToViewportPoint(CurrentCamera, plr.Character.PrimaryPart.Position)
            local Magnitude = (Vector2.new(PartPos.X, PartPos.Y) - Vector2.new(Mouse.X, Mouse.Y)).magnitude  
            if (Magnitude < (ValiantAimHacks["FOV"] * 6 - 8)) and (Magnitude < ShortestDistance) then
                if ValiantAimHacks["VisibleCheck"] and ValiantAimHacks.isPartVisible(plr.Character.PrimaryPart, plr.Character) then
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

-- // Heartbeat Function
local HBFuncs = function()
    ValiantAimHacks.updateCircle()
    ValiantAimHacks.getClosestPlayerToCursor()
end
Heartbeat.Connect(Heartbeat, HBFuncs)

return ValiantAimHacks

--[[
Examples:

--// Namecall Version // --
local mt = getrawmetatable(game)
local backupindex = mt.__index
local ValiantAimHacks = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Experimental%20Silent%20Aim%20Module.lua"))()
ValiantAimHacks["TeamCheck"] = false
setreadonly(mt, false)

mt.__namecall = newcclosure(function(...)
    local args = {...}
    local method = getnamecallmethod()
    if method == "FireServer" then
        if tostring(args[1]) == "RemoteNameHere" then
            -- change args
            return backupnamecall(unpack(args))
        end
    end
    return backupnamecall(...)
end)
setreadonly(mt, true)

-- // Index Version // --
local mt = getrawmetatable(game)
local backupindex = mt.__index
local ValiantAimHacks = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Experimental%20Silent%20Aim%20Module.lua"))()
ValiantAimHacks["TeamCheck"] = false
setreadonly(mt, false)

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
setreadonly(mt, true)

]]

--[[

Some General Info:

> You must get the raw metatable of the game as the game metatable is usually locked and you can't look into it/get it normally.
> You must make a backup of the metamethod you're hooking so you can return it, if you dont, you break your game.
> You must unlock the game metatable or else we can not change it and lock it after just in case.

__namecall Silent Aim Explained:

So what we are doing is hooking the namecall metamethod. This metamethod is fired whenever the game uses ":" on something, for example "Remote:FireServer". Since multiple args can
be passed, we sum it all into {...}, a table that contains all of the args. Then, we get the method. In this instance, FireServer. Then we check if we got the correct remote, we can
also provide the full path of the remote (game.ReplicatedStorage.RemoteEvent, for example) or do args[1].Name, however, I decided to do it this way by tostring-ing it. If you didn't know,
args[1] is the thing before the ":". So in the previous example of "Remote:FireServer", args[1] would be "Remote", the method would be the thing after the ":", so "FireServer". After this,
you may change what arguments you need to change, for example if the first argument is the target player, you would do: "args[2] = ValiantAimHacks["Selected"]". Then, we return the new and
changed arguments. Finally, the return on the bottom just catches anything that didnt fit our checks and just doesn't change anything to it (it passes right through). 

__index Silent Aim Explained:

Like in __namecall, we are hooking it. This is a lot simplier. We just check if the table is our Mouse and if it is, check if the key is "Hit" or "Target" - (Mouse.Hit, Mouse.Target). Then,
we check if the Silent Aim can be used, if it can, we get the closest player and see if that closest player has a character and a head. If they do then they check if the key is Hit or if it's
Target. On the Roblox Docs, it says Hit returns a CFrame value so we return the Closest Player's Head CFrame. Then if it's Target, we return the Closest Player's Head as on the Roblox Docs, it
says that Target returns an Instance. Finally, we need a catcher like the __namecall hook, so anything that doesnt pass those checks can go through, untouched and basically pass right through.

Any Questions? Ask me them on Discord @ Stefanuk12#5820. If you're experiencing errors, please contact me on Discord and include the dev console errors so I can help you ASAP!
]]