getgenv().AntiVoid = true -- // toggle it on and off

-- // Services
local Players = game:GetService("Players")

-- // Vars
local LocalPlayer = Players.LocalPlayer

-- // Check if anyone has the same handle as you
local function toolMatch(Handle)
    local allPlayers = Players:GetPlayers()
    for i = 1, #allPlayers do
        local Player = allPlayers[i]
        if (Player == LocalPlayer) then continue end -- // ignore local player

        local Character = Player.Character
        local RightArm = Character:WaitForChild("Right Arm")
        local RightGrip = RightArm:FindFirstChild("RightGrip")

        if (RightGrip and RightGrip.Part1 == Handle) then
            return Player
        end
    end
end

-- // Manager
local function onCharacter(Character)
    local RightArm = Character:WaitForChild("Right Arm")

    -- // See when you equip something
    RightArm.ChildAdded:Connect(function(child)
        if (child:IsA("Weld") and child.Name == "RightGrip" and getgenv().AntiVoid) then
            -- // Vars
            local ConnectedHandle = child.Part1

            -- // Check if someone else has something equipped too with the same handle as you
            local matched = toolMatch(ConnectedHandle)

            -- // Destroy the tool is found someone who is voiding you
            if (matched) then
                ConnectedHandle.Parent:Destroy()
                print(matched, "just tried to void you lol!")
            end
        end
    end)
end

-- // Initialise the script
onCharacter(LocalPlayer.Character)
LocalPlayer.CharacterAdded:Connect(onCharacter)