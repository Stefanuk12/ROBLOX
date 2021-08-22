-- // Services
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- // Vars
local CharacterState = require(ReplicatedStorage.Modules.UI.state.CharacterState)
local SpoofValue = 1

-- // I sadly could not think of a more efficient way of doing this
RunService:BindToRenderStep("UnlimitedStamina", 0, function()
    CharacterState.Stamina = SpoofValue
end)