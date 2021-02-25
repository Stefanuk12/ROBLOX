-- // Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- // Vars
local LocalPlayer = Players.LocalPlayer

-- // Load ESP Module
local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/ESP/Module.lua"))()
local Update = ESP.Update.Player

-- // Drawing Objects
local DrawingObjects = {}

local function manageNewPlayer(Player)
    local Character, PrimaryPart = ESP.Utilites.GetCharacter(Player)

    local Box = ESP.Creation.Box({
        Model = Character,
        TargetPart = PrimaryPart,
    })
    local Tracer = ESP.Creation.Tracer({
        Model = Character,
        TargetPart = PrimaryPart,
    })
    local Header = ESP.Creation.Header({
        Model = Character,
        TargetPart = PrimaryPart,
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

-- // Handle Left Player
local function manageLeavePlayer(Player)
    for i = #DrawingObjects, 1, -1 do
        local Object = DrawingObjects[i]

        if (Object[1] == Player) then
            Object[2].Object:Remove()

            table.remove(DrawingObjects, i)
        end
    end
end

-- // Handle ESP Update
local function manageUpdate()
    for i = 1, #DrawingObjects do
        local v = DrawingObjects[i]

        local Player = v[1]
        local Object = v[2]
        local objectType = v[3]

        local data = TypeToUpdate[objectType](Player, Object)
        v[2] = data
    end
end

-- // Add Existing Players
do
    local AllPlayers = Players:GetPlayers()
    for i = 1, #AllPlayers do
        local Player = AllPlayers[i]

        if (Player ~= LocalPlayer) then
            manageNewPlayer(AllPlayers[i])
        end
    end
end

-- // Add New Players
Players.PlayerAdded:Connect(manageNewPlayer)

-- // Remove Old Players
Players.PlayerRemoving:Connect(manageLeavePlayer)

-- // Constantly updating the ESP
RunService:BindToRenderStep("ESP", 0, manageUpdate)