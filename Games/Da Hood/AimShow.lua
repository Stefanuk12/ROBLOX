--[[
    Information:

    - This shows you where people are aiming.
    - By default: red = aiming at you = danger, green = aiming away from you = safe
]]

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

-- // Checks if the beam is hitting our character and can't go through walls
local function IsBeamHit(Beam, MousePos)
    -- // Get our character
    local Character = LocalPlayer.Character
    local Attachment = Beam.Attachment1

    -- // Workout the direction
    local Origin = Beam.Attachment0.WorldPosition
    local Direction = MousePos - Origin

    -- // Fire the ray, making sure it hits something (should unless aiming at sky?)
    local raycastParms = RaycastParams.new()
    raycastParms.FilterDescendantsInstances = {Character, Workspace.CurrentCamera}
    local RaycastResult = Workspace:Raycast(Origin, Direction * 2, raycastParms) -- // Multiplied by 2 as ray might fall too short
    if (not RaycastResult) then
        Beam.Color = Colours.Away
        Attachment.WorldPosition = MousePos
        return
    end

    -- // Set the colour based upon if aiming at us or not
    if (Character) then
        Beam.Color = RaycastResult.Instance:IsDescendantOf(Character) and Colours.At or Colours.Away
    end

    -- // Set the position so the beam can't go through walls
    Attachment.WorldPosition = RaycastResult.Position
end

-- // Creates a beam with the default properties
local function CreateBeam(Character)
    -- // Create beam
    local Beam = Instance.new("Beam", Character)

    -- // Set important properties
    Beam.Attachment0 = Character:WaitForChild("Head"):WaitForChild("FaceCenterAttachment")
    Beam.Enabled = Character:FindFirstChild("GunScript", true) ~= nil

    -- // Set visual properties
    Beam.Width0 = 0.1
    Beam.Width1 = 0.1

    -- // Add to beam table so can modify all at once
    table.insert(Beams, Beam)

    -- // Return
    return Beam
end

-- // Apply whenever we get a new character
local function OnCharacter(Character)
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
    IsBeamHit(Beam, MousePos.Value)
    MousePos.Changed:Connect(function()
        IsBeamHit(Beam, MousePos.Value)
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
local function OnPlayer(Player)
    OnCharacter(Player.Character)
    Player.CharacterAdded:Connect(OnCharacter)
end

for _, v in ipairs(Players:GetPlayers()) do
    OnPlayer(v)
end

-- // Redo for each new player
Players.PlayerAdded:Connect(OnPlayer)