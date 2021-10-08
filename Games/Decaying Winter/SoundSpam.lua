-- // Services
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

-- // Vars
local ServerStuff = Workspace.ServerStuff
local playAudio = ServerStuff.playAudio

-- //
local function PlayAudio(SoundCategory, SoundType, BodyPart, Time)
    -- // Loop through players
    for _, Player in ipairs(Players:GetPlayers()) do
        -- // Vars
        local Character = Player.Character

        -- // Make sure has character
        if (not Character) then
            continue
        end

        -- // Vars
        BodyPart = Character:FindFirstChild(BodyPart or "HumanoidRootPart")

        -- // Make sure body part exists
        if (not BodyPart) then
            continue
        end

        -- // Fire
        playAudio:FireServer(SoundCategory, SoundType, BodyPart, Time)
    end
end

-- //
while (true) do wait()
    PlayAudio({"general"}, "falldamage1", "Head")
end