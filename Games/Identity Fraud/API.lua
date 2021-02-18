-- // Services
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

-- // Vars
local API = {}
getgenv().IdentityFraudAPI = API
local LocalPlayer = Players.LocalPlayer
local AllSounds = {}
API.Settings = {
    TeleportBypass = true
}

-- // Network Ownership
RunService:BindToRenderStep("NetworkOwnership", 0, function()
    setsimulationradius(9e9, 9e9)
end)

-- // Teleport Bypass
function API.teleportBypass()
    local allConnections = getconnections(RunService.Heartbeat)
    for i = 1, #allConnections do
        local connection = allConnections[i]
        local cscript = rawget(getfenv(connection.Function), "script")

        if (cscript and cscript.Name == "Frigid") then
            connection:Disable()
            print("Bypassed Teleport")
        end
    end
end

-- // Teleport NPC
function API.teleportNPC(NPC, CF)
    Workspace.NPCs[NPC]:SetPrimaryPartCFrame(CF)
end

-- // Attempt to kill NPC
function API.AttemptKillNPC(NPC)
    API.teleportNPC(NPC, CFrame.new(0, -1000, 0))
end

function API.GetTarget(player)
    -- // Just a player
    if (typeof(player) == "Instance") then
        player = {player}
    elseif (player == "all") then
        -- // Everyone
        player = Players:GetPlayers()
    elseif (player == "others") then
        -- // Everyone but yourself

        -- // Vars
        player = {}
        local players = Players:GetPlayers()

        -- // Loop through all players, if not self then add to table
        for i = 1, #players do
            local v = players[i]

            if (v ~= LocalPlayer) then
                player[#player + 1] = v
            end
        end
    elseif (player == "me") then
        -- // Yourself
        player = {LocalPlayer}
    else
        -- // Others

        -- // Vars
        local found = {}
        local allPlayers = Players:GetPlayers()

        -- // Loop through all players and find best match
        for i = 1, #allPlayers do
            local v = allPlayers[i]

            if (v.Name:lower():sub(1, #player) == player:lower()) then
                found[#found + 1] = v
            end
        end

        -- // End
        player = found
    end

    -- // Return
    return player
end

-- // Kill Player
function API.KillPlayers(Player)
    local TargetPlayers = API.GetTarget(Player)

    for i = 1, #TargetPlayers do
        local TargetPlayer = TargetPlayers[i]

        local Head = TargetPlayer.Character:FindFirstChild("Head")
        if (Head) then
            API.teleportNPC("Ralph", Head.CFrame)

            local failsafeCount = 0
            while (TargetPlayer.Character.Humanoid.Health ~= 0) do
                if (failsafeCount >= 5) then break end
                wait(1)
                failsafeCount = failsafeCount + 1
            end
        end
    end
end

-- // Sorting all sounds
do
    local workspaceDescendants = Workspace:GetDescendants()
    for i = 1, #workspaceDescendants do
        local descendant = workspaceDescendants[i]

        if (descendant:IsA("Sound")) then
            AllSounds[#AllSounds + 1] = descendant
        end
    end
end
local function removeSound(Sound)
    for i = 1, #AllSounds do
        if (AllSounds[i] == Sound) then
            table.remove(AllSounds, i)
        end
    end
end
Workspace.DescendantAdded:Connect(function(descendant)
    if (descendant:IsA("Sound")) then
        AllSounds[#AllSounds + 1] = descendant
    end
end)
Workspace.DescendantRemoving:Connect(function(descendant)
    if (descendant:IsA("Sound")) then
        removeSound(descendant)
    end
end)

-- // Sound Control - Play all sounds for example
function API.ControlSounds(Action)
    for i = 1, #AllSounds do
        local sound = AllSounds[i]
        sound[Action](sound)
    end
end

-- // Initalising the Character
function API.initaliseCharacter(Character)
    wait(0.1)

    if (API.Settings.TeleportBypass) then
        API.teleportBypass()
    end
end
API.initaliseCharacter(LocalPlayer.Character)
LocalPlayer.CharacterAdded:Connect(API.initaliseCharacter)
