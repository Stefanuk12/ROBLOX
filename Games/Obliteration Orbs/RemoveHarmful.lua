-- // Services
local Workspace = game:GetService("Workspace")

-- // Vars
local HarmfulNames = {
    "Fireball",
    "Meteor",
    "Black Hole"
}

-- //
local function IsHarmful(Orb)
    -- // Make sure is a part
    if (not Orb:IsA("BasePart")) then
        return
    end

    -- // Checks
    local NameCheck = table.find(HarmfulNames, Orb.Name) ~= nil

    -- // Return
    return NameCheck
end

-- // Remove all current harmful
for _, child in ipairs(Workspace:GetChildren()) do
    -- // Check
    if (IsHarmful(child)) then
        -- // Remove
        child:Destroy()
    end
end

-- // Remove new
Workspace.ChildAdded:Connect(function(child)
    -- // Check
    if (IsHarmful(child)) then
        -- // Wait for it to be added
        child.Parent:WaitForChild(child.Name)
        task.wait(0.05)

        -- // Remove
        child:Destroy()
    end
end)