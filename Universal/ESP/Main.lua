-- // Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- // Load ESP Module
local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/ESP/Module.lua"))()
local Update = ESP.Update

-- // Player Manager
local ESPManager = {}

local function manageNewPlayer(Player)
    if (not ESPManager[Player.Name]) then
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

        ESPManager[Player.Name] = {
            Box = Box,
            Tracer = Tracer,
            Header = Header
        }
    end
end

local TypeToUpdate = {
    Box = ESP.Update.Box,
    Tracer = ESP.Update.Tracer,
    Header = ESP.Update.Header
}

local function manageOldPlayer(Player)
    for i,v in pairs(ESPManager[Player.Name]) do
        local TypeUpdate = TypeToUpdate[i]

        if (TypeUpdate) then
            v.Object:Remove()
        end
    end

    if (ESPManager[Player.Name]) then
        ESPManager[Player.Name] = nil
    end
end

local function manageUpdate()
    for _,v in pairs(ESPManager) do
        for a,x in pairs(v) do
            local TypeUpdate = TypeToUpdate[a]

            if (TypeUpdate) then
                TypeUpdate(x)
            end
        end
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