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
    TweenSpeed = 5,
    TweenEasingStyle = Enum.EasingStyle.Quad,
    TweenEasingDirection = Enum.EasingDirection.In,
    targetPlayer = LocalPlayer,
    Parts = {}
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

Orbit.commenceParts(100)

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