if getgenv().Orbit then return getgenv().Orbit end

-- // Vars
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local primaryPart = Character:WaitForChild("HumanoidRootPart")
local GameFolder = game:GetService("Workspace").Terrain["_Game"]
local Folder = GameFolder.Folder
local NotificationHandler = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Notifications/Script.lua"))()
NotificationHandler["StorageLocation"] = game:GetService("CoreGui")
if not MarketplaceService:UserOwnsGamePassAsync(LocalPlayer.UserId, 35748) then warn("You don't have Persons299 admin!") return end

-- // Network Ownership
if sethiddenproperty and gethiddenproperty then
    if gethiddenproperty(LocalPlayer, "SimulationRadius") ~= math.huge then
        game:GetService("RunService"):BindToRenderStep("NetworkRep", 0, function()
            if gethiddenproperty(LocalPlayer, "SimulationRadius") ~= math.huge then
                sethiddenproperty(LocalPlayer, "SimulationRadius", math.huge)
                sethiddenproperty(LocalPlayer, "MaximumSimulationRadius", math.huge)
            end
        end)
    end
else
    warn("You do not have sethiddenproperty or gethiddenproperty!")
    return
end

-- // Orbit
getgenv().Orbit = {
    Enabled = true,
    Speed = 15,
    offSet = 10,
    Mode = "Visualiser",
    targetPlayer = LocalPlayer,
    Parts = {},
    CMDs = {},
    Prefix = ":",
    LoopOrbit = false,
    LoopOrbitTime = 1,
}
Orbit = getgenv().Orbit

local rotX = 0
local rotZ = math.pi / 2
local L = 1

-- // Funcs
function roundDecimals(num, places)
    places = math.pow(10, places or 0)
    num = num * places
    if num >= 0 then 
        num = math.floor(num + 0.5) 
    else 
        num = math.ceil(num - 0.5) 
    end
    return num / places  
end

function Orbit.commenceParts(numOfParts)
	for i = 1, numOfParts do
        -- // Create Part
        Players:Chat("part/1/1/1")
    end
end

function Orbit.getPos()
    local targetPlayer = Orbit.targetPlayer
    if targetPlayer and targetPlayer.Character and targetPlayer.Character.PrimaryPart then
        return targetPlayer.Character.PrimaryPart.Position
    end
end

function Orbit.updateTable()
    Orbit.Parts = {}
    for _, child in pairs(Folder:GetChildren()) do
        if child:IsA("Part") and child.Size == Vector3.new(1, 1, 1) then
            child.CanCollide = false
            table.insert(Orbit.Parts, child)
        end
    end
end

Folder.ChildAdded:Connect(function(child)
    Orbit.updateTable()
end)

Folder.ChildRemoved:Connect(function(child)
    if child:IsA("Part") and child.Size == Vector3.new(1, 1, 1) and Orbit.Enabled then
        Orbit.commenceParts(1)
    end
end)

-- // Makes 100 parts
Orbit.commenceParts(100)

-- // Makes it spiny spiny spin
RunService.RenderStepped:Connect(function()
    if Folder and Orbit.Enabled then
        rotX = rotX + Orbit.Speed / 100
        rotZ = rotZ + Orbit.Speed / 100
        L = (L >= 360 and 1 or L + Orbit.Speed)
        local Audio = Folder:FindFirstChild("Sound") -- PLEASE SPECIFY WHICH SOUND
        local Y = 0

        -- // This makes it orbit around you
        for i,v in pairs(Orbit.Parts) do
            if v:IsA("BasePart") and not v.Anchored then
                -- // Audio Visualiser
                if Orbit.Mode == "Visualiser" and Audio then
                    Y = math.clamp(roundDecimals((Audio.PlaybackLoudness / 200) / 1.5, 3), 0, 5)
                end

                targetPrimaryPart = nil
                if Orbit.targetPlayer and Orbit.targetPlayer.Character and Orbit.targetPlayer.Character.PrimaryPart then
                    targetPrimaryPart = Orbit.targetPlayer.Character.PrimaryPart.Position
                end

                if targetPrimaryPart then
                    local newPos = targetPrimaryPart + Vector3.new(0, Y, 0)
                    local EndCFrame = CFrame.new(newPos) * CFrame.fromEulerAnglesXYZ(0, math.rad(L + (360 / #Orbit.Parts) * i + Orbit.Speed), 0) * CFrame.new(Orbit.offSet, 0, 0)
                    local EndCFrame2 = CFrame.new(targetPrimaryPart) * CFrame.fromEulerAnglesXYZ(0, math.rad(L + (360 / #Orbit.Parts) * i + Orbit.Speed), 0) * CFrame.new(Orbit.offSet, 0, 0)
                    v.CFrame = EndCFrame
                end
            end
        end
    end
end)

-- // CMD So you can give it to other peeps
function getPlayer(String)
    local Found = {}
    local Target = string.lower(String)
    if Target == "all" then
        for i,v in pairs(game:GetService("Players"):GetPlayers()) do
            table.insert(Found, v)
        end
    elseif Target == "others" then
        for i,v in pairs(game:GetService("Players"):GetPlayers()) do
            if v ~= game:GetService("Players").LocalPlayer then
                table.insert(Found, v)
            end
        end
    elseif Target == "me" then
        table.insert(Found, game:GetService("Players").LocalPlayer)
    else
        for i,v in pairs(game:GetService("Players"):GetPlayers()) do
            if v.Name:lower():sub(1, #String) == String:lower() then
                table.insert(Found, v)
            end
        end
    end
    return Found
end

function addCMD(CommandName, ModuleName, Example, Description, Function)
    if not CommandName or not ModuleName or not Example or not Description or not Function then
        vars.Alert("addCMDs invalid! ".. CommandName)
        return
    end
    local CMDs = Orbit.CMDs
    local Prefix = Orbit.Prefix
    CMDs[CommandName] = {
        ModuleName = ModuleName,
        Example = Example,
        Description = Prefix..Description,
        Function = Function,
    }
end

LocalPlayer.Chatted:Connect(function(message)
    for i,v in pairs(Orbit.CMDs) do
        local Command = Orbit.Prefix..i
        if not message then message = "" end
        if v.Function and string.sub(message, 1, #Command) == Command then
            v.Function(message)
        end
    end
end)

addCMD("orbit", "Orbiter", "orbit EpicGamer69", "Give the orbiter to someone.", function(message)
    local splitString = string.split(message, " ")
    if splitString[2] then
        for _,v in pairs(getPlayer(splitString[2])) do
            Orbit.targetPlayer = v
            NotificationHandler.newNotification("SUCCESS", "Gave Orbiter to: "..v.Name, "Success")
            break
        end
    end
end)

addCMD("refreshorbit", "Orbiter", "refreshorbiter", "Refreshes the parts.", function(message)
    Players:Chat("clr")
    wait(0.5)
    local count = 0
    for _,v in pairs(Folder:GetChildren()) do
        if v:IsA("Part") and v.Size == Vector3.new(1, 1, 1) and not v.Anchored then
            count = count + 1
        end
    end
    if count < 100 then
        Orbit.commenceParts(100 - count)
        NotificationHandler.newNotification("SUCCESS", "Refreshed Orbiter", "Success")
    end  
end)

addCMD("looporbit", "Orbiter", "looporbit", "Everyone takes turns with the Orbiter.", function(message)
    Orbit.LoopOrbit = not Orbit.LoopOrbit
    NotificationHandler.newNotification("SUCCESS", "Toggle - Loop Orbiter: "..(Orbit.LoopOrbit and "Enabled." or "Disabled."), "Success")
end)

addCMD("looporbittime", "Orbiter", "looporbit", "Set the time of the turns of the Orbiter.", function(message)
    local splitString = string.split(message, " ")
    if splitString[2] and tonumber(spitString[2]) then
        Orbit.LoopOrbitTime = tonumber(splitString[2])
        NotificationHandler.newNotification("SUCCESS", "Loop Orbiter Time: "..splitString[2], "Success")
    end
end)

-- // Coroutine
coroutine.wrap(function()
    while wait() do
        for _,v in pairs(Players:GetPlayers()) do
            Orbit.targetPlayer = v
            wait(Orbit.LoopOrbitTime)
        end
    end
)()