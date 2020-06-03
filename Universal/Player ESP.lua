-- made with crishoux's esp module

-- // Valiant ENV
loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/ValiantENV.lua"))()

-- // Vars
local ValiantESP = {}
local trackingitem = {}
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local worldToViewportPoint = CurrentCamera.WorldToViewportPoint
local TracerStart = Vector2.new(CurrentCamera.ViewportSize.X / 2, CurrentCamera.ViewportSize.Y)
local headOffset = Vector3.new(0, 0.5, 0)
local legOffset = Vector3.new(0, 3, 0)

local PlayerESP = {
    Enabled = true,
    TeamCheck = true,
    Health = true,
    Boxes = true,
    Tracers = true,
    Names = true,
    Distance = true,
    TracerColor = Color3.fromRGB(255, 255, 255),
    NameColor = Color3.fromRGB(255, 255, 255),
    BoxColor = 'rainbow',
    VisibleText = '>:)',
    NotVisibleText = '>:c',
    NotVisibleColor = Color3.fromRGB(231, 84, 128),
}

rainbowcolour = Color3.fromHSV(1, 1, 1)
local rainbowroad = coroutine.wrap(function()
    while wait() do
        local hue = tick() % 5 / 5
        rainbowcolour = Color3.fromHSV(hue, 1, 1)
    end
end)()

local isPartVisible = function(Part, PartDescendant)
    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded.Wait(LocalPlayer.CharacterAdded)
    local Origin = CurrentCamera.CFrame.p
    local _, OnScreen = CurrentCamera.WorldToViewportPoint(CurrentCamera, Part.Position)
    if OnScreen then
        local newRay = Ray.new(Origin, Part.Position - Origin)
        local PartHit, _ = Workspace.FindPartOnRayWithIgnoreList(Workspace, newRay, {Character, CurrentCamera})
        local Visible = (not PartHit or PartHit.IsDescendantOf(PartHit, PartDescendant))
        return Visible
    end
    return false
end
-- // PlayerESP
function ValiantESP.new(data)
    local self = setmetatable({
        Player = data.player,
        Character = data.player.Character,
        ObjectBox = nil,
        ObjectName = nil,
        ObjectTracer = nil,
        Health = data.Health or true,
        Distance = data.Distance or true,
        TracerColor = data.TracerColor or Color3.fromRGB(255, 255, 255),
        NameColor = data.NameColor or Color3.fromRGB(255, 255, 255),
        BoxColor = data.BoxColor or Color3.fromRGB(255, 255, 255),
        TeamCheck = data.TeamCheck or false
    }, {__index = ValiantESP})
    print(self, data)

    local player = self.player
    local character = self.character
    local Boxes = data.Boxes
    local Tracers = data.Tracers
    local Names = data.Names
    local Text = data.Text
    if not character and not PlayerESP["Enabled"] then return end

    local rootPart = character.HumanoidRootPart
    local head = character.Head
    local rootPos, rootVis = worldToViewportPoint(CurrentCamera, rootPart.Position)
    local headPos = worldToViewportPoint(CurrentCamera, head.Position + headOffset)
    local legPos = worldToViewportPoint(CurrentCamera, rootPart.Position - legOffset)
    local visible = (self.TeamCheck and player.TeamColor ~= LocalPlayer.TeamColor) or (not self.TeamCheck)

    local ObjectBox = Drawing.new("Square")
    ObjectBox.Thickness = 2
    ObjectBox.Filled = false
    ObjectBox.Transparency = 0.8
    local ObjectTracer = Drawing.new("Line")
    ObjectTracer.From = TracerStart
    ObjectTracer.Color = self.TracerColor
    ObjectTracer.Thickness = 2
    ObjectTracer.Transparency = 0.8
    local ObjectName = Drawing.new("Text")
    ObjectName.Text = Text
    ObjectName.Size = 16
    ObjectName.Color = self.NameColor
    ObjectName.Center = true
    ObjectName.Outline = true

    if rootVis then
        ObjectBox.Size = Vector2.new(2350 / rootPos.Z, headPos.Y - legPos.Y)
        ObjectBox.Position = Vector2.new(rootPos.X - ObjectBox.Size.X / 2, rootPos.Y - ObjectBox.Size.Y / 2)
        ObjectTracer.To = Vector2.new(rootPos.X, rootPos.Y - ObjectBox.Size.Y / 2)
        ObjectName.Position = Vector2.new(rootPos.X, (rootPos.Y + ObjectBox.Size.Y / 2) - 25)

        ObjectBox.Visible = Boxes and visible
        ObjectTracer.Visible = Tracers and visible
        ObjectName.Visible = Names and visible
    end

    self.ObjectBox = {ObjectBox, Boxes}
    self.ObjectTracer = {ObjectTracer, Tracers}
    self.ObjectName = {ObjectName, Text, Names}

    return self
end

function getPlayerText(player, Health, Distance, Visbility)
    local playerHumanoid = player.Character.FindFirstChild(player.Character, "Humanoid")
    local HealthText = tostring(playerHumanoid.Health / playerHumanoid.MaxHealth * 100).."%"
    local DistanceText = tostring("["..math.floor(game.GetService(game, "Players").LocalPlayer.DistanceFromCharacter(game.GetService(game, "Players").LocalPlayer, player.Character.PrimaryPart.Position)).."]")
    local playerText = tostring(player.Name)
    local VisbilityText = (Visbility and PlayerESP["VisibleText"] or PlayerESP["NotVisibleText"])
  	local returnText = tostring((Distance and DistanceText or "").." "..playerText.." "..(Health and HealthText or "").." "..VisbilityText)
	return returnText
end

function ValiantESP:update()
    local player, character, ObjectBox, ObjectTracer, ObjectName = self.player, self.character, self.ObjectBox[1], self.ObjectTracer[1], self.ObjectName[1]
    local Boxes, Tracers, Text, Names = self.ObjectBox[2], self.ObjectTracer[2], self.ObjectName[2], self.ObjectName[3]
    local rootPart, head = character.PrimaryPart, character:FindFirstChild("Head")

    if rootPart and PlayerESP["Enabled"] then
        local rootPos, rootVis = worldToViewportPoint(CurrentCamera, rootPart.Position)
        local headPos = worldToViewportPoint(CurrentCamera, head.Position + headOffset)
        local legPos = worldToViewportPoint(CurrentCamera, rootPart.Position - legOffset)
        local visible = (self.TeamCheck and player.TeamColor ~= LocalPlayer.TeamColor) or (not self.TeamCheck)

        if rootVis then
            if ObjectBox.__OBJECT_EXISTS and ObjectTracer.__OBJECT_EXISTS and ObjectName.__OBJECT_EXISTS then
                ObjectBox.Size = Vector2.new(2350 / rootPos.Z, headPos.Y - legPos.Y)
                local BoxSize = ObjectBox.Size
                ObjectBox.Position = Vector2.new(rootPos.X - BoxSize.X / 2, rootPos.Y - BoxSize.Y / 2)
                if isPartVisible(rootPart, character) then
                    print('vis')
                    ObjectBox.Color = (self.BoxColor == 'rainbow' and rainbowcolour or self.BoxColor)
                    ObjectName.Color = self.NameColor
                    ObjectTracer.Color = self.TracerColor
                    Text = getPlayerText(self.player, self.Health, self.Distance, true)
                else
                    print('notvis')
                    ObjectBox.Color = PlayerESP["NotVisibleColor"]
                    ObjectName.Color = PlayerESP["NotVisibleColor"]
                    ObjectTracer.Color = PlayerESP["NotVisibleColor"]
                    Text = getPlayerText(self.player, self.Health, self.Distance, false)
                end
            
                ObjectTracer.To = Vector2.new(rootPos.X, rootPos.Y - BoxSize.Y / 2)
                ObjectTracer.Color = self.TracerColor
                ObjectName.Position = Vector2.new(rootPos.X, (rootPos.Y + BoxSize.Y / 2) - 25)
                ObjectName.Color = self.NameColor

                ObjectBox.Visible = Boxes and visible
                ObjectTracer.Visible = Tracers and visible
                ObjectName.Visible = Names and visible
            end
        else
            if ObjectBox.__OBJECT_EXISTS and ObjectTracer.__OBJECT_EXISTS and ObjectName.__OBJECT_EXISTS then
                ObjectBox.Visible = false
                ObjectTracer.Visible = false
                ObjectName.Visible = false
            end
        end
    end
end

local function characterRemoving(character)
    for i, v in next, trackingplayer do
        if v.character == character then
            v:remove()
            table.remove(trackingplayer, i)
        end
    end
end

local function characterAdded(player)
    local character = player.Character or player.CharacterAdded:wait()
    character:WaitForChild("HumanoidRootPart"); character:WaitForChild("Head")
    trackingplayer[#trackingplayer + 1] = ValiantESP.new({
        player = player,
        Boxes = PlayerESP["Boxes"],
        Tracers = PlayerESP["Tracers"],
        Names = PlayerESP["Names"],
        TeamCheck = PlayerESP["TeamCheck"],
        Health = PlayerESP["Health"],
        Distance = PlayerESP["Distance"],
        Text = getPlayerText(player, PlayerESP["Health"], PlayerESP["Distance"]),
        NameColor = PlayerESP["NameColor"],
        TracerColor = PlayerESP["TracerColor"],
        BoxColor = PlayerESP["BoxColor"],
    })
end

for i, v in next, Players.GetPlayers(Players) do
    if v ~= LocalPlayer then
        local character = v.Character
        if character and character:WaitForChild("HumanoidRootPart") and character:WaitForChild("Head") then
            trackingplayer[#trackingplayer + 1] = ValiantESP.new({
                player = v,
                Boxes = PlayerESP["Boxes"],
                Tracers = PlayerESP["Tracers"],
                Names = PlayerESP["Names"],
                TeamCheck = PlayerESP["TeamCheck"],
                Health = PlayerESP["Health"],
                Distance = PlayerESP["Distance"],
                Text = getPlayerText(v, (PlayerESP["Health"]), (PlayerESP["Distance"])),
                NameColor = PlayerESP["NameColor"],
                TracerColor = PlayerESP["TracerColor"],
                BoxColor = PlayerESP["BoxColor"],
            })
        end
        v.CharacterAdded:Connect(function()
            characterAdded(v)
        end)
        v.CharacterRemoving:Connect(characterRemoving)
    end
end

local function playerAdded(player)
    player.CharacterAdded:Connect(function()
        characterAdded(player)
    end)
    player.CharacterRemoving:Connect(characterRemoving)
end

Players.PlayerAdded:Connect(playerAdded)

RunService.RenderStepped:Connect(function()
    for i, v in next, trackingplayer do
        v:update()
    end
end)