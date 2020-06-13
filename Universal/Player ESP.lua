-- made with crishoux's esp module also might be broken

-- // Valiant ENV
loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/ValiantENV.lua"))()

-- // Vars
local ValiantESP = {}
local trackingPlayer = {}
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local worldToViewportPoint = CurrentCamera.WorldToViewportPoint
local TracerStart = Vector2.new(CurrentCamera.ViewportSize.X / 2, CurrentCamera.ViewportSize.Y)
local HeadOffset = Vector3.new(0, 0.5, 0)
local legOffset = Vector3.new(0, 3, 0)

local PlayerESP = {
    Enabled = true,
    TeamCheck = false,
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
    NotVisibleColor = Color3.fromRGB(255, 0, 0),
}

rainbowcolour = Color3.fromHSV(1, 1, 1)
local rainbowroad = coroutine.wrap(function()
    while wait() do
        local hue = tick() % 5 / 5
        rainbowcolour = Color3.fromHSV(hue, 1, 1)
    end
end)()

function isPartVisible(Part, PartDescendant)
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
        Player = data.Player,
        Character = data.Player.Character,
        ObjectBox = nil,
        ObjectName = nil,
        ObjectTracer = nil,
        Health = data.Health or true,
        Distance = data.Distance or true,
        TracerColor = data.TracerColor or Color3.fromRGB(255, 255, 255),
        NameColor = data.NameColor or Color3.fromRGB(255, 255, 255),
        BoxColor = data.BoxColor or Color3.fromRGB(255, 255, 255),
        TeamCheck = data.TeamCheck or false,
    }, {__index = ValiantESP})

    local Player = self.Player
    local Character = self.Character
    local Boxes = data.Boxes
    local Tracers = data.Tracers
    local Names = data.Names
    local Text = data.Text
    if not Character and not PlayerESP["Enabled"] then return end

    local rootPart = Character.HumanoidRootPart
    local Head = Character.Head
    local rootPos, rootVis = worldToViewportPoint(CurrentCamera, rootPart.Position)
    local headPos = worldToViewportPoint(CurrentCamera, Head.Position + HeadOffset)
    local legPos = worldToViewportPoint(CurrentCamera, rootPart.Position - legOffset)
    local visible = (self.TeamCheck and Player.TeamColor ~= LocalPlayer.TeamColor) or (not self.TeamCheck)

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

function getPlayerText(Player, Health, Distance, Visbility)
    local PlayerHumanoid = Player.Character.FindFirstChildWhichIsA(Player.Character, "Humanoid")
    local HealthText = tostring(math.floor(PlayerHumanoid.Health / PlayerHumanoid.MaxHealth) * 100).."%"
    local DistanceText = tostring("["..math.floor(game.GetService(game, "Players").LocalPlayer.DistanceFromCharacter(game.GetService(game, "Players").LocalPlayer, Player.Character.PrimaryPart.Position)).."]")
    local PlayerText = tostring(Player.Name)
    local VisbilityText = (Visbility and PlayerESP["VisibleText"] or PlayerESP["NotVisibleText"])
  	local returnText = tostring((Distance and DistanceText or "").." "..PlayerText.." "..(Health and HealthText or "").." "..VisbilityText)
	return returnText
end

function ValiantESP:setTracer(visible)
    self.ObjectTracer[2] = visible
end

function ValiantESP:setText(text)
    self.ObjectName[2] = text
end

function ValiantESP:update()
    local Player, Character, ObjectBox, ObjectTracer, ObjectName = self.Player, self.Character, self.ObjectBox[1], self.ObjectTracer[1], self.ObjectName[1]
    local Boxes, Tracers, Text, Names = self.ObjectBox[2], self.ObjectTracer[2], self.ObjectName[2], self.ObjectName[3]
    local rootPart, Head = Character.PrimaryPart, Character:FindFirstChild("Head")

    if rootPart and PlayerESP["Enabled"] then
        local rootPos, rootVis = worldToViewportPoint(CurrentCamera, rootPart.Position)
        local headPos = worldToViewportPoint(CurrentCamera, Head.Position + HeadOffset)
        local legPos = worldToViewportPoint(CurrentCamera, rootPart.Position - legOffset)
        local visible = (self.TeamCheck and Player.TeamColor ~= LocalPlayer.TeamColor) or (not self.TeamCheck)

        if rootVis then
            if ObjectBox and ObjectTracer and ObjectName then
                ObjectBox.Size = Vector2.new(2350 / rootPos.Z, headPos.Y - legPos.Y)
                local BoxSize = ObjectBox.Size
                ObjectBox.Position = Vector2.new(rootPos.X - BoxSize.X / 2, rootPos.Y - BoxSize.Y / 2)
                if isPartVisible(rootPart, Character) then
                    ObjectBox.Color = (self.BoxColor == 'rainbow' and rainbowcolour or self.BoxColor)
                    ObjectName.Color = self.NameColor
                    ObjectTracer.Color = self.TracerColor
                    ObjectName.Text = getPlayerText(self.Player, self.Health, self.Distance, true)
                else
                    ObjectBox.Color = PlayerESP["NotVisibleColor"]
                    ObjectName.Color = PlayerESP["NotVisibleColor"]
                    ObjectTracer.Color = PlayerESP["NotVisibleColor"]
                    ObjectName.Text = getPlayerText(self.Player, self.Health, self.Distance, false)
                end
            
                ObjectTracer.To = Vector2.new(rootPos.X, rootPos.Y - BoxSize.Y / 2)
                ObjectTracer.Color = self.TracerColor
                ObjectName.Position = Vector2.new(rootPos.X, (rootPos.Y + BoxSize.Y / 2) - 25)
                ObjectName.Color = self.NameColor

                ObjectBox.Visible = Boxes and visible
                ObjectTracer.Visible = Tracers and visible
                ObjectName.Visible = Names and visible
            end
        elseif not rootVis and ObjectBox and ObjectTracer and ObjectName then
            ObjectBox.Visible = false
            ObjectTracer.Visible = false
            ObjectName.Visible = false
        end

    end

end

function ValiantESP:remove()
    self.ObjectBox[1]:Remove()
    self.ObjectTracer[1]:Remove()
    self.ObjectName[1]:Remove()
    function self:update() end
end

local function CharacterRemoving(Character)
    for i, v in next, trackingPlayer do
        if v.Character == Character then
            v:remove()
            table.remove(trackingPlayer, i)
        end
    end
end

local function CharacterAdded(Player)
    local Character = Player.Character or Player.CharacterAdded:wait()
    Character:WaitForChild("HumanoidRootPart"); Character:WaitForChild("Head")
    trackingPlayer[#trackingPlayer + 1] = ValiantESP.new({
        Player = Player,
        Boxes = PlayerESP["Boxes"],
        Tracers = PlayerESP["Tracers"],
        Names = PlayerESP["Names"],
        TeamCheck = PlayerESP["TeamCheck"],
        Health = PlayerESP["Health"],
        Distance = PlayerESP["Distance"],
        Text = getPlayerText(Player, PlayerESP["Health"], PlayerESP["Distance"]),
        NameColor = PlayerESP["NameColor"],
        TracerColor = PlayerESP["TracerColor"],
        BoxColor = PlayerESP["BoxColor"],
    })
end

for i, v in next, Players.GetPlayers(Players) do
    if v ~= LocalPlayer then
        local Character = v.Character
        if Character and Character:WaitForChild(Character.PrimaryPart.Name) and Character:WaitForChild("Head") then
            trackingPlayer[#trackingPlayer + 1] = ValiantESP.new({
                Player = v,
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
            CharacterAdded(v)
        end)
        v.CharacterRemoving:Connect(CharacterRemoving)
    end
end

local function PlayerAdded(Player)
    Player.CharacterAdded:Connect(function()
        CharacterAdded(Player)
    end)
    Player.CharacterRemoving:Connect(CharacterRemoving)
end

Players.PlayerAdded:Connect(PlayerAdded)

RunService.RenderStepped:Connect(function()
    for i, v in next, trackingPlayer do
        v:update()
    end
end)