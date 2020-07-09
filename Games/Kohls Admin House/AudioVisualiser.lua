if getgenv().Orbit then return getgenv().Orbit end

-- // Vars
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local primaryPart = Character:FindFirstChild("HumanoidRootPart")
local GameFolder = game:GetService("Workspace").Terrain["_Game"]
local Folder = GameFolder.Folder
local NotificationHandler = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Notifications/Script.lua"))()
NotificationHandler["StorageLocation"] = game:GetService("CoreGui")
if not MarketplaceService:UserOwnsGamePassAsync(LocalPlayer.UserId, 35748) then warn("You don't have Persons299 admin!") return end

-- // Network Ownership
if sethiddenproperty and gethiddenproperty then
    if gethiddenproperty(LocalPlayer, "SimulationRadius") ~= 1/0 then
        game:GetService("RunService"):BindToRenderStep("NetworkRep", 0, function()
            if gethiddenproperty(LocalPlayer, "SimulationRadius") ~= 1/0 then
                sethiddenproperty(LocalPlayer, "SimulationRadius", 1/0)
                sethiddenproperty(LocalPlayer, "MaximumSimulationRadius", 1/0)
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
    Mode = true,
    targetPlayer = LocalPlayer,
    Parts = {},
    CMDs = {},
    Prefix = ":",
    LoopOrbit = false,
    LoopOrbitTime = 1,
    TargetParts = 100,
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

function Orbit.partCount()
    local count = 0
    for _,v in pairs(Folder:GetChildren()) do
        if v:IsA("Part") and v.Size == Vector3.new(1, 1, 1) and not v.Anchored then
            count = count + 1
        end
    end
    return count
end

Folder.ChildAdded:Connect(function(child)
    Orbit.updateTable()
end)

Folder.ChildRemoved:Connect(function(child)
    if child:IsA("Part") and child.Size == Vector3.new(1, 1, 1) and Orbit.Enabled and (Orbit.partCount() <= Orbit.TargetParts)  then
        Orbit.commenceParts(1)
    end
end)

-- // Makes 100 parts
Orbit.commenceParts(Orbit.TargetParts)

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
                if Orbit.Mode and Audio then
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
        Example = Prefix..Example,
        Description = Description,
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
        Orbit.LoopOrbit = false
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
    local count = Orbit.partCount()
    Orbit.commenceParts(Orbit.TargetParts - count)
    NotificationHandler.newNotification("SUCCESS", "Refreshed Orbiter", "Success")
end)

addCMD("timelooporbit", "Orbiter Settings", "timelooporbit", "Set the time of the turns of the Orbiter.", function(message)
    local splitString = string.split(message, " ")
    if splitString[2] and tonumber(splitString[2]) then
        Orbit.LoopOrbitTime = tonumber(splitString[2])
        NotificationHandler.newNotification("SUCCESS", "Loop Orbiter Time: "..splitString[2].." seconds.", "Success")
    end
end)

addCMD("offset", "Orbiter Settings", "offset 20", "Set the offset of the Orbiter, how far away it is from the targetPlayer.", function(message)
    local splitString = string.split(message, " ")
    if splitString[2] and tonumber(splitString[2]) then
        Orbit.offSet = tonumber(splitString[2])
        NotificationHandler.newNotification("SUCCESS", "Orbiter Offset: "..splitString[2]..".", "Success")
    end
end)

addCMD("speed", "Orbiter Settings", "speed 20", "Set the speed of the Orbiter, how fast it spins.", function(message)
    local splitString = string.split(message, " ")
    if splitString[2] and tonumber(splitString[2]) then
        Orbit.Speed = tonumber(splitString[2])
        NotificationHandler.newNotification("SUCCESS", "Orbiter Speed: "..splitString[2]..".", "Success")
    end
end)

addCMD("partamount", "Orbiter Settings", "partamount 50", "Set the amount of parts for the Orbiter.", function(message)
    local splitString = string.split(message, " ")
    if splitString[2] and tonumber(splitString[2]) then
        Orbit.TargetParts = tonumber(splitString[2])
        Orbit.CMDs["refreshorbit"].Function()
        NotificationHandler.newNotification("SUCCESS", "Orbiter Parts: "..splitString[2].." Parts.", "Success")
    end
end)

-- // Toggles
addCMD("torbiter", "Orbiter Settings", "torbiter", "Toggles the Orbiter.", function(message)
    Orbit.Enabled = not Orbit.Enabled
    NotificationHandler.newNotification("SUCCESS", "Orbiter: "..(Orbit.Enabled and "Enabled" or "Disabled")..".", "Success")
end)

addCMD("tvisualise", "Orbiter Settings", "tvisualise", "Toggles the Orbiter Visualiser.", function(message)
    Orbit.Mode = not Orbit.Mode
    NotificationHandler.newNotification("SUCCESS", "Orbiter Visualiser: "..(Orbit.Mode and "Enabled" or "Disabled")..".", "Success")
end)

addCMD("looporbit", "Orbiter Settings", "looporbit", "Everyone takes turns with the Orbiter.", function(message)
    Orbit.LoopOrbit = not Orbit.LoopOrbit
    NotificationHandler.newNotification("SUCCESS", "Toggle - Loop Orbiter: "..(Orbit.LoopOrbit and "Enabled." or "Disabled."), "Success")
end)

-- // Misc
addCMD("orbitcmds", "Misc", "orbitcmds", "Prints the Orbiter Commands.", function(message)
    for i,v in pairs(Orbit.CMDs) do
        print("> "..i.." - Description: "..v.Description.." - Example: "..v.Example)
    end
    NotificationHandler.newNotification("SUCCESS", "Orbiter Commands Printed in Console!", "Success")
end)

addCMD("copyorbitercmds", "Misc", "copyorbitercmds", "Copies all of the orbiter commands to your clipboard", function(message)
    local CommandCount = 0
    for i,v in pairs(Orbit.CMDs) do
        CommandCount = CommandCount + 1
    end
    local Holder = "Audio Visualiser Command List | Total Commands: "..CommandCount.." | Prefix - "..Orbit.Prefix

    Holder = Holder.."--~~-- Orbiter Module --~~--\n"
    for i,v in pairs(Orbit.CMDs) do
        if v.ModuleName == "Orbiter" then
            Holder = Holder.."> "..i.." - Description: "..v.Description.." - Example: "..v.Example.."\n"
        end
    end

    Holder = Holder.."--~~-- Orbiter Settings Module --~~--\n"
    for i,v in pairs(Orbit.CMDs) do
        if v.ModuleName == "Orbiter Settings" then
            Holder = Holder.."> "..i.." - Description: "..v.Description.." - Example: "..v.Example.."\n"
        end
    end

    Holder = Holder.."--~~-- Misc Module --~~--\n"
    for i,v in pairs(Orbit.CMDs) do
        if v.ModuleName == "Misc" then
            Holder = Holder.."> "..i.." - Description: "..v.Description.." - Example: "..v.Example.."\n"
        end
    end

    setclipboard(Holder)
    NotificationHandler.newNotification("SUCCESS", "Orbiter Commands Copied To Clipboard!", "Success")
end)

-- // Coroutine
coroutine.wrap(function()
    while wait() do
        for _,v in pairs(Players:GetPlayers()) do
            if Orbit.LoopOrbit then
                Orbit.targetPlayer = v           
            end
            wait(Orbit.LoopOrbitTime)
        end
    end
end)()