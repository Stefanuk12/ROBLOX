-- // Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- // Load ESP Module
local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/ESP/Module.lua"))()
local Update = ESP.Update.Player

-- // Drawing Objects
local DrawingObjects = {}

local function manageNewPlayer(Player)
    wait(0.1)

    local PlayerCharacter = ESP.Utilites.GetCharacter(Player)

    local Box = ESP.Creation.Box({
        Player = Player,
        PrimaryPart = PlayerCharacter.PrimaryPart,
    })
    local Tracer = ESP.Creation.Tracer({
        Player = Player,
        PrimaryPart = PlayerCharacter.PrimaryPart,
    })
    local Header = ESP.Creation.Header({
        Player = Player,
        PrimaryPart = PlayerCharacter.PrimaryPart,
    })

    DrawingObjects[#DrawingObjects + 1] = {Player, Box, "Box"}
    DrawingObjects[#DrawingObjects + 1] = {Player, Tracer, "Tracer"}
    DrawingObjects[#DrawingObjects + 1] = {Player, Header, "Header"}
end

local TypeToUpdate = {
    Box = Update.Box,
    Tracer = Update.Tracer,
    Header = Update.Header
}

local function manageOldPlayer(Player)
    for i = 1, #DrawingObjects do
        local Object = DrawingObjects[i]

        if (Object[1] == Player) then
            Object[2]:Remove()
            table.remove(DrawingObjects, i)
        end
    end
end

local function manageUpdate()
    for i = 1, #DrawingObjects do
        local v = DrawingObjects[i]

        local Player = v[1]
        local Object = v[2]
        local objectType = v[3]

        TypeToUpdate[objectType](Player, Object)
    end
end

-- // Add Existing Players
do
    local AllPlayers = Players:GetPlayers()
    for i = 1, #AllPlayers do
        manageNewPlayer(AllPlayers[i])
    end
end

-- // Add New Players
Players.PlayerAdded:Connect(manageNewPlayer)

-- // Remove Old Players
Players.PlayerRemoving:Connect(manageOldPlayer)

-- // Constantly updating the ESP
RunService:BindToRenderStep("ESP", 0, manageUpdate)