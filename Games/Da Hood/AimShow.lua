-- // Services
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

-- // Vars
local Terrain = Workspace.Terrain
local LocalPlayer = Players.LocalPlayer
local Beams = {}

local Colours = {
    At = ColorSequence.new(Color3.new(1, 0, 0), Color3.new(1, 0, 0)),
    Away = ColorSequence.new(Color3.new(0, 1, 0), Color3.new(0, 1, 0))
}

-- // Checks if the beam is hitting our character
local function IsBeamHit(Beam: Beam)
    -- // Get our character
    local Character = LocalPlayer.Character
    if (not Character) then
        return false
    end

    -- // Workout the direction
    local Origin = Beam.Attachment0.WorldPosition
    local Destination = Beam.Attachment1.WorldPosition
    local Direction = Destination - Origin

    -- // Fire the ray, making sure it hits something (should unless aiming at sky?)
    local RaycastResult = Workspace:Raycast(Origin, Direction * 2) -- // Multiplied by 2 as ray might fall too short
    if (not RaycastResult) then
        return false
    end

    -- // Check if the part hit is parent of us
    return RaycastResult.Instance:IsDescendantOf(Character)
end

-- // Creates a beam with the default properties
local function CreateBeam(Character: Model)
    -- // Create beam
    local Beam = Instance.new("Beam", Character)

    -- // Set important properties
    Beam.Attachment0 = Character:WaitForChild("Head"):WaitForChild("FaceCenterAttachment")
    Beam.Enabled = Character:FindFirstDescendant("GunScript") ~= nil

    -- // Set visual properties
    Beam.Width0 = 0.1
    Beam.Width1 = 0.1

    -- // Add to beam table so can modify all at once
    table.insert(Beams, Beam)

    -- // Return
    return Beam
end

-- // Apply whenever we get a new character
local function OnCharacter(Character: Model | nil)
    -- // Make sure character exists
    if (not Character) then
        return
    end

    -- // Wait for the MousePos
    local MousePos = Character:WaitForChild("BodyEffects"):WaitForChild("MousePos")

    -- // Create the beam
    local Beam = CreateBeam(Character)

    -- // Attachment for the mouse position
    local Attachment = Instance.new("Attachment", Terrain)
    Beam.Attachment1 = Attachment

    -- // Constantly update when MousePos updates
    Attachment.WorldPosition = MousePos.Value
    Beam.Color = IsBeamHit(Beam) and Colours.At or Colours.Away
    MousePos.Changed:Connect(function()
        Attachment.WorldPosition = MousePos.Value
        Beam.Color = IsBeamHit(Beam) and Colours.At or Colours.Away
    end)

    -- // See whenever they equip a gun
    Character.DescendantAdded:Connect(function(Descendant)
        -- // Check if it is a gun, set enabled
        if (Descendant.Name == "GunScript") then
            Beam.Enabled = true
        end
    end)

    -- // See whenever they unequip a gun
    Character.DescendantRemoving:Connect(function(Descendant)
        -- // Check if it is a gun, set disabled
        if (Descendant.Name == "GunScript") then
            Beam.Enabled = false
        end
    end)
end

-- // Apply on each player
local function OnPlayer(Player: Player)
    OnCharacter(Player.Character)
    Player.CharacterAdded:Connect(OnCharacter)
end

for _, v in ipairs(Players:GetPlayers()) do
    OnPlayer(v)
end

-- // Redo for each new player
Players.PlayerAdded:Connect(OnPlayer)