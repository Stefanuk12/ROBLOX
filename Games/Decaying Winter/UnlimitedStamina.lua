-- // Services
local Players = game:GetService("Players")

-- // Vars
local LocalPlayer = Players.LocalPlayer
local Backpack = LocalPlayer.Backpack
local mainHandler = Backpack:WaitForChild("mainHandler")

-- // Find the stat init function
local StatInit
do
    -- // Vars
    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local Humanoid = Character:WaitForChild("Humanoid")

    -- // Loop through .Changed connections
    for _, Connection in ipairs(getconnections(Humanoid.Changed)) do
        -- // Vars
        local ConnectionFunction = Connection.Function

        -- // Makes sure is mainHandler
        if (getfenv(ConnectionFunction).script == mainHandler) then
            StatInit = debug.getupvalue(ConnectionFunction, 6)
        end
    end
end

-- // Constantly set stamina
while (true) do wait()
    debug.setupvalue(StatInit, 1, 100)
end