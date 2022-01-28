-- // Services
local Workspace = game:GetService("Workspace")

-- // Vars
local HarmfulNames = {
    "FireballFolder",
    "MeteorFolder",
    "BlackHoleFolder"
}

-- // Remove
for _, Name in ipairs(HarmfulNames) do
    -- // Make sure exists
    local Harmful = Workspace:FindFirstChild(Name)
    if (Harmful) then
        -- // Remove
        Harmful:Destroy()
    end
end