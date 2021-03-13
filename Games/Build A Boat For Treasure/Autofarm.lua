-- // Toggle
getgenv().autofarm = true

-- // Services
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")

-- // Vars
local LocalPlayer = Players.LocalPlayer
local ClaimFunction
local InstaLoadFunction = Workspace.InstaLoadFunction

-- // Get the claim function
do
    local gGC = getgc()
    for i = 1, #gGC do
        local v = gGC[i]
        local fScript = getfenv(v).script

        if (debug.getinfo(v).name == "claim" and fScript.Parent) then
            ClaimFunction = v
        end
    end
end

-- // Create a temp part under you
local createTempPart = function()
    local Part = Instance.new("Part", LocalPlayer.Character)
    Part.Anchored = true
    Part.Position = LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(0, 3, 0)

    return Part
end

-- // Goes through all of the stages
local walkthrough = function()
    -- // Claim gold (if you have any to get)
    ClaimFunction()

    -- // Variables
    local Character = LocalPlayer.Character
    local NormalStages = Workspace.BoatStages.NormalStages

    -- // Go to each stage thing
    do
        local Stages = NormalStages:GetChildren()
        for i = 1, #Stages do
            local Stage = Stages[i]
            local DarknessPart = Stage:FindFirstChild("DarknessPart")

            if (DarknessPart) then
                Character.HumanoidRootPart.CFrame = DarknessPart.CFrame

                local Part = createTempPart()
                wait(2)
                Part:Destroy()
            end
        end
    end

    -- // Go to end
    repeat wait()
        Character.HumanoidRootPart.CFrame = NormalStages.TheEnd.GoldenChest.Trigger.CFrame
    until Lighting.ClockTime ~= 14

    -- // Instant Die
    wait(2)
    InstaLoadFunction:InvokeServer(nil, true)
    LocalPlayer.CharacterAdded:Wait()

    -- // Claim gold (if you have any to get)
    ClaimFunction()
end

-- // Whilst the autofarm is enable, constantly do it
while wait() do
    if (getgenv().autofarm) then
        walkthrough()
    end
end