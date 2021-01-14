-- // Services
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

-- // Vars
local LocalPlayer = Players.LocalPlayer
local SoundParent
local PartLocation
local isStudio = RunService:IsStudio()
local NotificationHandler
local rotX = 0
local rotZ = math.pi / 2
local L = 1

-- // Studio Compatability
if (isStudio) then
	getgenv = getfenv
	function setclipboard() end
	function setsimulationradius(a, b) end
	
	SoundParent = Workspace
	PartLocation = Workspace.Parts
	
	NotificationHandler = require(script.NotificationHandler)
	NotificationHandler.StorageLocation = LocalPlayer.PlayerGui
else
	-- // So you do not execute this more than once
	if (getgenv().Orbit) then return getgenv().Orbit end
	
	SoundParent = Workspace.Terrain["_Game"].Folder
	PartLocation = Workspace.Terrain["_Game"].Folder
	
	NotificationHandler = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Notifications/Script.lua"))()
	NotificationHandler["StorageLocation"] = game:GetService("CoreGui")
end

-- // So you do not execute this more than once
if (getgenv().Orbit) then return getgenv().Orbit end

-- // Check for Persons299 Admin
if (not isStudio) then
	if (not MarketplaceService:UserOwnsGamePassAsync(LocalPlayer.UserId, 35748)) then
		warn("You don't have Persons299 admin!")
		return false
	end
end

-- // Orbit Table
getgenv().Orbit = {
	Enabled = true,
	Speed = 0.5,
	offSet = 10,
	Mode = true,
	targetPlayer = LocalPlayer,
	CMDs = {},
	Parts = {},
	Prefix = ":",
	LoopOrbit = false,
	LoopOrbitTime = 1,
	TargetParts = 100,
	LockPlaceCFrame = nil
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
getgenv().Orbit.CreateParts = function(numOfParts)
	if (not isStudio) then
		for i = 1, numOfParts do
			-- // Create Part
			Players:Chat(":part/1/1/1")
		end
	else
		for i = 1, numOfParts do
			Instance.new("Part", PartLocation).Size = Vector3.new(1, 1, 1)
		end
	end
end

-- // Getting Target Parts
getgenv().Orbit.GetParts = function()
	local PartFolder = PartLocation:GetChildren()
	local AllParts = {}

	-- // Find all parts and add to table
	for i = 1, #PartFolder do
		local child = PartFolder[i]

		if (child:IsA("Part") and child.Size == Vector3.new(1, 1, 1) and not child.Anchored) then
			AllParts[#AllParts + 1] = child
		end
	end

	-- // Return
	return AllParts
end

-- // Make the parts spin
RunService.RenderStepped:Connect(function()
	setsimulationradius(9e9, 9e9)

	-- // Parts table
	getgenv().Orbit.Parts = getgenv().Orbit.GetParts()

	if (SoundParent and getgenv().Orbit.Enabled) then
		rotX = rotX + getgenv().Orbit.Speed / 100
		rotZ = rotZ + getgenv().Orbit.Speed / 100
		L = (L >= 360 and 1 or L + getgenv().Orbit.Speed)
		local Audio = SoundParent:FindFirstChild("Sound")
		local Y = 0

		-- // Making the parts orbit
		local AllParts = getgenv().Orbit.Parts
		for i = 1, #AllParts do
			local part = AllParts[i]

			-- // Audio Visualiser
			if (getgenv().Orbit.Mode and Audio) then
				local roundedAudioLoudness = mathRound((Audio.PlaybackLoudness / 200) / 1.5, 3)
				Y = math.clamp(roundedAudioLoudness, 0, 5)
			end

			-- // Spinning
			if (not getgenv().Orbit.targetPlayer.Character or not getgenv().Orbit.targetPlayer.Character:FindFirstChild("HumanoidRootPart")) then return end
			local targetOrbit = getgenv().Orbit.LockPlaceCFrame or getgenv().Orbit.targetPlayer.Character.HumanoidRootPart
			local newPos = CFrame.new(targetOrbit.Position + Vector3.new(0, Y, 0))
			local B = CFrame.fromEulerAnglesXYZ(0, math.rad(L + (360 / #AllParts) * i + getgenv().Orbit.Speed), 0)
			local endCFrame = newPos * B * CFrame.new(getgenv().Orbit.offSet, 0, 0)

			part.CFrame = endCFrame
		end
	end
end)

-- // Always meet target parts
local function RepairOrbit(part)
	getgenv().Orbit.CreateParts(1)
end
PartLocation.ChildRemoved:Connect(RepairOrbit)

coroutine.wrap(function()
	while wait(1) do
		local NeededParts = getgenv().Orbit.TargetParts - #getgenv().Orbit.Parts

		-- // Adding Parts
		if (NeededParts > 0) then
			getgenv().Orbit.CreateParts(NeededParts)
		end
	end
end)()

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
			if getgenv().Orbit.LoopOrbit then
				getgenv().Orbit.targetPlayer = v
			end
			wait(getgenv().Orbit.LoopOrbitTime)
		end
	end
end)()

-- // Command Handler
local function addCMD(CommandName, ModuleName, Example, Description, Function)
	local Prefix = getgenv().Orbit.Prefix
	getgenv().Orbit.CMDs[#getgenv().Orbit.CMDs + 1] = {
		CommandName = CommandName,
		ModuleName = ModuleName,
		Example = Prefix..Example,
		Description = Description,
		Function = Function,
	}
end

local function getCommand(CommandName)
	for i = 1, #getgenv().Orbit.CMDs do
		local v = getgenv().Orbit.CMDs[i]

		if (v.CommandName == CommandName) then
			return v
		end
	end
end

-- // Chat Listener
LocalPlayer.Chatted:Connect(function(message)
	local Prefix = getgenv().Orbit.Prefix
	if (not message:sub(1, #Prefix) == Prefix) then return end

	for i = 1, #getgenv().Orbit.CMDs do
		local v = getgenv().Orbit.CMDs[i]
		local Command = v.CommandName
		if (message:sub(#Prefix + 1, #Command + #Prefix) == Command) then
			v.Function(message)
		end
	end
end)

-- // Orbiter
addCMD("orbit", "Orbiter", "orbit EpicGamer69", "Give the orbiter to a player.", function(message)
	local splitString = message:split(" ")

	if (splitString[2]) then
		getgenv().Orbit.LoopOrbit = false
		local Target = getPlayer(splitString[2])

		for i = 1, #Target do
			local v = Target[i]

			getgenv().Orbit.targetPlayer = v
			NotificationHandler.newNotification("SUCCESS", "Gave Orbiter to: "..v.Name, "Success")
			break
		end
	end
end)

addCMD("refreshorbit", "Orbiter", "refreshorbit", "Refreshes the parts.", function(message)
	Players:Chat(":clr")
	wait(0.5)
	local PartCount = #getgenv().Orbit.Parts
	getgenv().Orbit.CreateParts(getgenv().Orbit.TargetParts - PartCount)
	NotificationHandler.newNotification("SUCCESS", "Refreshed Orbiter", "Success")
end)

addCMD("lockorbit", "Orbiter", "lockorbit", "Locks the orbit in current place", function(message)
	getgenv().Orbit.LockPlaceCFrame = LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame
	NotificationHandler.newNotification("SUCCESS", "Turned on lock orbit to current location.", "Success")
end)

addCMD("offlockorbit", "Orbiter", "offlockorbit", "Unlocks the orbiter", function(message)
	getgenv().Orbit.LockPlaceCFrame = nil
	NotificationHandler.newNotification("SUCCESS", "Turned off lock orbit.", "Success")
end)

addCMD("timelooporbit", "Orbiter Settings", "timelooporbit", "Set the time of the turns of the Orbiter.", function(message)
	local splitString = message:split(" ")
	if (splitString[2] and tonumber(splitString[2])) then
		getgenv().Orbit.LoopOrbitTime = tonumber(splitString[2])
		NotificationHandler.newNotification("SUCCESS", "Loop Orbiter Time: "..splitString[2].." seconds.", "Success")
	end
end)

addCMD("offset", "Orbiter Settings", "offset 20", "Set the offset of the Orbiter, how far away it is from the targetPlayer.", function(message)
	local splitString = message:split(" ")
	if (splitString[2] and tonumber(splitString[2])) then
		getgenv().Orbit.offSet = tonumber(splitString[2])
		NotificationHandler.newNotification("SUCCESS", "Orbiter Offset: "..splitString[2]..".", "Success")
	end
end)

addCMD("speed", "Orbiter Settings", "speed 20", "Set the speed of the Orbiter, how fast it spins.", function(message)
	local splitString = message:split(" ")
	if (splitString[2] and tonumber(splitString[2])) then
		getgenv().Orbit.Speed = tonumber(splitString[2])
		NotificationHandler.newNotification("SUCCESS", "Orbiter Speed: "..splitString[2]..".", "Success")
	end
end)

addCMD("partamount", "Orbiter Settings", "partamount 50", "Set the amount of parts for the Orbiter.", function(message)
	local splitString = message:split(" ")
	if (splitString[2] and tonumber(splitString[2])) then
		getgenv().Orbit.TargetParts = tonumber(splitString[2])
		getCommand("refreshorbit").Function()
		NotificationHandler.newNotification("SUCCESS", "Orbiter Parts: "..splitString[2].." Parts.", "Success")
	end
end)

-- // Orbiter Settings
addCMD("torbiter", "Orbiter Settings", "torbiter", "Toggles the Orbiter.", function(message)
	getgenv().Orbit.Enabled = not getgenv().Orbit.Enabled
	NotificationHandler.newNotification("SUCCESS", "Orbiter: "..(getgenv().Orbit.Enabled and "Enabled" or "Disabled")..".", "Success")
end)

addCMD("tvisualise", "Orbiter Settings", "tvisualise", "Toggles the Orbiter Visualiser.", function(message)
	getgenv().Orbit.Mode = not getgenv().Orbit.Mode
	NotificationHandler.newNotification("SUCCESS", "Orbiter Visualiser: "..(getgenv().Orbit.Mode and "Enabled" or "Disabled")..".", "Success")
end)

addCMD("looporbit", "Orbiter Settings", "looporbit", "Everyone takes turns with the Orbiter.", function(message)
	getgenv().Orbit.LoopOrbit = not getgenv().Orbit.LoopOrbit
	NotificationHandler.newNotification("SUCCESS", "Toggle - Loop Orbiter: "..(getgenv().Orbit.LoopOrbit and "Enabled." or "Disabled."), "Success")
end)

-- // Misc
addCMD("orbitcmds", "Misc", "orbitcmds", "Prints the Orbiter Commands.", function(message)
	for i = 1, #getgenv().Orbit.CMDs do
		local v = getgenv().Orbit.CMDs[i]
		print("> "..i.." - Description: "..v.Description.." - Example: "..v.Example)
	end
	NotificationHandler.newNotification("SUCCESS", "Orbiter Commands Printed in Console!", "Success")
end)

addCMD("copyorbitcmds", "Misc", "copyorbitercmds", "Copies all of the orbiter commands to your clipboard", function(message)
	local CommandCount = 0
	for i = 1, #getgenv().Orbit.CMDs do
		local v = getgenv().Orbit.CMDs[i]
		CommandCount = CommandCount + 1
	end
	local Holder = "Audio Visualiser Command List | Total Commands: "..CommandCount.." | Prefix - "..getgenv().Orbit.Prefix.."\n"

	Holder = Holder.."--~~-- Orbiter Module --~~--\n"
	for i = 1, #getgenv().Orbit.CMDs do
		local v = getgenv().Orbit.CMDs[i]
		if (v.ModuleName == "Orbiter") then
			Holder = Holder.."> "..i.." - Description: "..v.Description.." - Example: "..v.Example.."\n"
		end
	end

	Holder = Holder.."--~~-- Orbiter Settings Module --~~--\n"
	for i = 1, #getgenv().Orbit.CMDs do
		local v = getgenv().Orbit.CMDs[i]
		if v.ModuleName == "Orbiter Settings" then
			Holder = Holder.."> "..i.." - Description: "..v.Description.." - Example: "..v.Example.."\n"
		end
	end

	Holder = Holder.."--~~-- Misc Module --~~--\n"
	for i = 1, #getgenv().Orbit.CMDs do
		local v = getgenv().Orbit.CMDs[i]
		if v.ModuleName == "Misc" then
			Holder = Holder.."> "..i.." - Description: "..v.Description.." - Example: "..v.Example.."\n"
		end
	end
	
	setclipboard(Holder)
	NotificationHandler.newNotification("SUCCESS", "Orbiter Commands Copied To Clipboard!", "Success")
end)

-- // End
RepairOrbit()