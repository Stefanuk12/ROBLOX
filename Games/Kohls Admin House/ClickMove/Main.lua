--[[
    Controls:

    Hold Z + Left Click = Select Part
    X = Weld to part
    C = Remove selection
]]

-- // Services
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")

-- // Vars
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local SelectedPart = nil
local GameFolder = Workspace.Terrain["_Game"]

-- // Function
local function attachToPart(Part)
    -- // Vars
    local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart
    local Humanoid = LocalPlayer.Character.Humanoid
    local originalCC = {}

    -- // So you cannot trip
    Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
    Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)

    -- // Setting CanCollide to false
    local gameDescendants = workspace.Terrain["_Game"]:GetDescendants()
    for i = 1, #gameDescendants do
        local part = gameDescendants[i]

        if (part:IsA("BasePart") and part.CanCollide) then
            part.CanCollide = false
            originalCC[#originalCC + 1] = part
        end
    end

    -- // Getting Teleport Position + Original Can Collide
	local Pos = Part.CFrame * CFrame.new((Part.Size.X / 2) + 0.05, (Part.Size.Y / 2) * -1, (Part.Size.Z / 2) + 1.005)

    -- // Setting Part so we cannot colide to it and Teleporting to the Position
    HumanoidRootPart.CFrame = Pos * CFrame.Angles(math.rad(Part.Orientation.X), math.rad(90), math.rad(Part.Orientation.Z))

    -- // Making a part under us to stop us from falling (if there is nothing under)
    local TempPart = Instance.new("Part", Part.Parent)
    TempPart.Position = Pos.Position - Vector3.new(0, 3, 0)
    TempPart.Size = Vector3.new(5, 1, 5)
    TempPart.Anchored = true

    -- // Attaching to the part
    wait(0.5)
    Players:Chat(":unpunish me")

    -- // Destroy part made earlier
    wait(0.1)
    TempPart:Destroy()

    -- // Setting the Collision back
    for i = 1, #originalCC do
        local part = originalCC[i]

        if (part) then
            part.CanCollide = true
        end
    end
end

-- //
Mouse.Button1Down:Connect(function()
    -- // Vars
    local mouseTarget = Mouse.Target

    -- // Get selected part
    if (UserInputService:IsKeyDown(Enum.KeyCode.Z) and mouseTarget) then
        -- // Remove old part selectionbox
        if (SelectedPart and SelectedPart:FindFirstChild("SelectionBox")) then
            SelectedPart.SelectionBox:Destroy()
        end
        
        SelectedPart = mouseTarget

        -- // SelectionBox
        local SelectionBox = Instance.new("SelectionBox", SelectedPart)
        SelectionBox.Adornee = SelectedPart
        SelectionBox.Color3 = Color3.fromRGB(255, 0, 0)
    end
end)

-- //
UserInputService.InputBegan:Connect(function(inputObject, gameProcessedEvent)
    if (gameProcessedEvent) then return end

    -- //
    if (SelectedPart) then
        if (inputObject.KeyCode == Enum.KeyCode.X) then
            attachToPart(SelectedPart)
        elseif (inputObject.KeyCode == Enum.KeyCode.C and SelectedPart) then
            if (SelectedPart:FindFirstChild("SelectionBox")) then
                SelectedPart.SelectionBox:Destroy()
            end
            
            SelectedPart = nil
        end
    end
end)