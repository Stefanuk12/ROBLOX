-- // Custom Settings
getgenv().TreasureAutoFarm = {
    Enabled = true, -- // Toggle the auto farm on and off
    Teleport = 2, -- // How fast between each teleport between the stages and stuff
    ClaimGold = 2, -- // How long to wait until it claims the gold after going through all of the stages
}

-- // Services
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")

-- // Vars
local LocalPlayer = Players.LocalPlayer
local InstaLoadFunction = Workspace.InstaLoadFunction

-- // Claim money
local ClaimFunction = function()
    local RiverResultsGui = LocalPlayer.PlayerGui:FindFirstChild("RiverResultsGui")
    
    if (RiverResultsGui) then
        local ClaimButton = RiverResultsGui.Frame.BuyButton
        firesignal(ClaimButton.MouseButton1Click)
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
                wait(getgenv().TreasureAutoFarm.Teleport)
                Part:Destroy()
            end
        end
    end

    -- // Go to end
    repeat wait()
        Character.HumanoidRootPart.CFrame = NormalStages.TheEnd.GoldenChest.Trigger.CFrame
    until Lighting.ClockTime ~= 14

    -- // Instant Die
    wait(getgenv().TreasureAutoFarm.ClaimGold)
    InstaLoadFunction:InvokeServer(nil, true)
    LocalPlayer.CharacterAdded:Wait()

    -- // Claim gold (if you have any to get)
    ClaimFunction()
end

-- // Whilst the autofarm is enable, constantly do it
while wait() do
    if (getgenv().TreasureAutoFarm.Enabled) then
        walkthrough()
    end
end