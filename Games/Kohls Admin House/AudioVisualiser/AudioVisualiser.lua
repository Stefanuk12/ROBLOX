-- // Initalise
if (getgenv().Orbit) then return getgenv().Orbit end

-- // Services
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

-- // Vars
local LocalPlayer = Players.LocalPlayer
local GameFolder = Workspace.Terrain["_Game"]
local Folder = GameFolder.Folder

local rotX = 0
local rotZ = math.pi / 2
local L = 1

-- // Notifications
local NotificationHandler = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Notifications/Script.lua"))()
NotificationHandler["StorageLocation"] = game:GetService("CoreGui")

-- // Check for Persons299 Admin
if (not MarketplaceService:UserOwnsGamePassAsync(LocalPlayer.UserId, 35748)) then
    warn("You don't have Persons299 admin!")
    return false
end

-- // Orbit Table
getgenv().Orbit = {
    Enabled = true,
    Speed = 15,
    offSet = 10,
    Mode = true,
    targetPlayer = LocalPlayer,
    CMDs = {},
    Prefix = ":",
    LoopOrbit = false,
    LoopOrbitTime = 1,
    TargetParts = 100,
}

-- // Round Function
function mathRound(number, sf)
    sf = math.pow(10, sf or 0)
    number = number * sf

    -- // Rounding
    if (number >= 0) then
        number = math.floor(number + 0.5)
    else
        number = math.ceil(number - 0.5)
    end

    -- // Return
    return number / sf
end

-- // Create Parts
Orbit.CreateParts = function(numOfParts)
    for i = 1, numOfParts do
        -- // Create Part
        Players:Chat(":part/1/1/1")
    end
end

-- // Getting Target Parts
Orbit.GetParts = function()
    local FolderChildren = Folder:GetChildren()
    local AllParts = {}

    -- // Find all parts and add to table
    for i = 1, #FolderChildren do
        local child = FolderChildren[i]

        if (child:IsA("Part") and child.Size == Vector3.new(1, 1, 1) and not child.Anchored) then
            AllParts[#AllParts + 1] = child
        end
    end

    -- // Return
    return AllParts
end

-- // Always meet target parts
Folder.ChildRemoved:Connect(function(child)
    local AllParts = Orbit.GetParts()
    local NeededParts = Orbit.TargetParts - #AllParts

    -- // Adding Parts
    if (NeededParts > 0) then
        Orbit.CreateParts(NeededParts)
    end
end)

-- // Make the parts spin
RunService:BindToRenderStep("OrbitSpin", 0, function()
    if (Folder and Orbit.Enabled) then
        rotX = rotX + Orbit.Speed / 100
        rotZ = rotZ + Orbit.Speed / 100
        L = (L >= 360 and 1 or L + Orbit.Speed)
        local Audio = Folder:FindFirstChild("Sound")
        local Y = 0

        -- // Making the parts orbit
        local AllParts = Orbit.GetParts()
        for i = 1, #AllParts do
            local part = AllParts[i]

            -- // Audio Visualiser
            if (Orbit.Mode and Audio) then
                local roundedAudioLoudness = mathRound((Audio.PlaybackLoudness / 200) / 1.5, 3)
                Y = math.clamp(roundedAudioLoudness, 0, 5)
            end

            -- // Spinning
            local targetOrbit = Orbit.targetPlayer.Character:WaitForChild("HumanoidRootPart")

            local newPos = CFrame.new(targetOrbit.Position + Vector3.new(0, Y, 0))
            local B = CFrame.fromEulerAnglesXYZ(0, math.rad(L + (360 / #AllParts) * i + Orbit.Speed), 0)
            local endCFrame = newPos * B * CFrame.new(Orbit.offSet, 0, 0)

            part.CFrame = endCFrame
        end
    end
end)

-- // Command Framework
local function getPlayer(String)
    local Found = {}
    local Target = string.lower(String)

    if (Target == "all" )then
        local AllPlayers = Players:GetPlayers()
        for i = 1, #AllPlayers do
            local v = AllPlayers[i]

            table.insert(Found, v)
        end
    elseif (Target == "others") then
        local AllPlayers = Players:GetPlayers()
        for i = 1, #AllPlayers do
            local v = AllPlayers[i]

            if (v ~= Players.LocalPlayer) then
                table.insert(Found, v)
            end
        end
    elseif (Target == "me") then
        table.insert(Found, Players.LocalPlayer)
    else
        local AllPlayers = Players:GetPlayers()
        for i = 1, #AllPlayers do
            local v = AllPlayers[i]

            if (v.Name:lower():sub(1, #String) == String:lower()) then
                table.insert(Found, v)
            end
        end
    end

    -- // Return
    return Found
end

-- // Loop Orbit including all players
coroutine.wrap(function()
    while wait() do
        local allPlayers = Players:GetPlayers()
        for i = 1, #allPlayers do
            local v = allPlayers[i]
            if Orbit.LoopOrbit then
                Orbit.targetPlayer = v
            end
            wait(Orbit.LoopOrbitTime)
        end
    end
end)()

-- // Command Handler
local function addCMD(CommandName, ModuleName, Example, Description, Function)
    local CMDs = Orbit.CMDs
    local Prefix = Orbit.Prefix
    CMDs[CommandName] = {
        ModuleName = ModuleName,
        Example = Prefix..Example,
        Description = Description,
        Function = Function,
    }
end

-- // Chat Listener
LocalPlayer.Chatted:Connect(function(message)
    for i = 1, #Orbit.CMDs do
        local v = Orbit.CMDs[i]
        local Command = Orbit.Prefix .. i
        
        if (string.sub(message, 1, #Command) == Command) then
            v.Function(message)
        end
    end
end)

-- // Orbiter
addCMD("orbit", "Orbiter", "orbit EpicGamer69", "Give the orbiter to a player.", function(message)
    local splitString = message:split(" ")

    if (splitString[2]) then
        Orbit.LoopOrbit = false
        local Target = getPlayer(splitString[2])

        for i = 1, #Target do
            local v = Target[i]

            Orbit.targetPlayer = v
            NotificationHandler.newNotification("SUCCESS", "Gave Orbiter to: "..v.Name, "Success")
            break
        end
    end
end)

addCMD("refreshorbit", "Orbiter", "refreshorbit", "Refreshes the parts.", function(message)
    Players:Chat(":clr")
    wait(0.5)
    local PartCount = Orbit.GetParts()
    Orbit.CreateParts(Orbit.TargetParts - PartCount)
    NotificationHandler.newNotification("SUCCESS", "Refreshed Orbiter", "Success")
end)

addCMD("timelooporbit", "Orbiter Settings", "timelooporbit", "Set the time of the turns of the Orbiter.", function(message)
    local splitString = message:split(" ")
    if (splitString[2] and tonumber(splitString[2])) then
        Orbit.LoopOrbitTime = tonumber(splitString[2])
        NotificationHandler.newNotification("SUCCESS", "Loop Orbiter Time: "..splitString[2].." seconds.", "Success")
    end
end)

addCMD("offset", "Orbiter Settings", "offset 20", "Set the offset of the Orbiter, how far away it is from the targetPlayer.", function(message)
    local splitString = message:split(" ")
    if (splitString[2] and tonumber(splitString[2])) then
        Orbit.offSet = tonumber(splitString[2])
        NotificationHandler.newNotification("SUCCESS", "Orbiter Offset: "..splitString[2]..".", "Success")
    end
end)

addCMD("speed", "Orbiter Settings", "speed 20", "Set the speed of the Orbiter, how fast it spins.", function(message)
    local splitString = message:split(" ")
    if (splitString[2] and tonumber(splitString[2])) then
        Orbit.Speed = tonumber(splitString[2])
        NotificationHandler.newNotification("SUCCESS", "Orbiter Speed: "..splitString[2]..".", "Success")
    end
end)

addCMD("partamount", "Orbiter Settings", "partamount 50", "Set the amount of parts for the Orbiter.", function(message)
    local splitString = message:split(" ")
    if (splitString[2] and tonumber(splitString[2])) then
        Orbit.TargetParts = tonumber(splitString[2])
        Orbit.CMDs["refreshorbit"].Function()
        NotificationHandler.newNotification("SUCCESS", "Orbiter Parts: "..splitString[2].." Parts.", "Success")
    end
end)

-- // Orbiter Settings
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
    for i = 1, #Orbit.CMDs do
        local v = Orbit.CMDs[i]
        print("> "..i.." - Description: "..v.Description.." - Example: "..v.Example)
    end
    NotificationHandler.newNotification("SUCCESS", "Orbiter Commands Printed in Console!", "Success")
end)

addCMD("copyorbitcmds", "Misc", "copyorbitercmds", "Copies all of the orbiter commands to your clipboard", function(message)
    local CommandCount = 0
    for i = 1, #Orbit.CMDs do
        local v = Orbit.CMDs[i]
        CommandCount = CommandCount + 1
    end
    local Holder = "Audio Visualiser Command List | Total Commands: "..CommandCount.." | Prefix - "..Orbit.Prefix.."\n"

    Holder = Holder.."--~~-- Orbiter Module --~~--\n"
    for i = 1, #Orbit.CMDs do
        local v = Orbit.CMDs[i]
        if (v.ModuleName == "Orbiter") then
            Holder = Holder.."> "..i.." - Description: "..v.Description.." - Example: "..v.Example.."\n"
        end
    end

    Holder = Holder.."--~~-- Orbiter Settings Module --~~--\n"
    for i = 1, #Orbit.CMDs do
        local v = Orbit.CMDs[i]
        if v.ModuleName == "Orbiter Settings" then
            Holder = Holder.."> "..i.." - Description: "..v.Description.." - Example: "..v.Example.."\n"
        end
    end

    Holder = Holder.."--~~-- Misc Module --~~--\n"
    for i = 1, #Orbit.CMDs do
        local v = Orbit.CMDs[i]
        if v.ModuleName == "Misc" then
            Holder = Holder.."> "..i.." - Description: "..v.Description.." - Example: "..v.Example.."\n"
        end
    end

    setclipboard(Holder)
    NotificationHandler.newNotification("SUCCESS", "Orbiter Commands Copied To Clipboard!", "Success")
end)

-- // End
Orbit.CreateParts(Orbit.TargetParts)