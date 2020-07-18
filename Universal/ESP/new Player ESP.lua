--[[
    Bugs:
        1. Only makes ESP for one player 
        2. getPlayerText function doesn't work properly
        3. Errors when person dies or leaves or smting idk
]]

-- // Vars
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = nil
local CurrentCamera = workspace.CurrentCamera
local WorldToViewportPoint = CurrentCamera.WorldToViewportPoint

getgenv().PlayerESP = {
    Settings = {
        GlobalEnabled = true,
        TeamCheck = true,
        MaxRenderDistance = 10000,
        BoxSettings = {
            Enabled = true,
            ColourVisible = Color3.fromRGB(255, 255, 255),
            ColourInvisible = Color3.fromRGB(255, 0, 0),
        },
        TracerSettings = {
            Enabled = true,
            ColourVisible = Color3.fromRGB(255, 255, 255),
            ColourInvisible = Color3.fromRGB(255, 0, 0),
        },
        NameTagSettings = {
            Enabled = true,
            Text = "Placeholder",
            ShowHealth = true,
            ShowDistance = true,
            ColourVisible = Color3.fromRGB(255, 255, 255),
            ColourInvisible = Color3.fromRGB(255, 0, 0),
            ShowVisibility = true,
            VisibleText = ":)",
            InvisibleText = ":(",
        },
    },
    PlayerDrawings = {
        --[[
        [PlayerName] = {
            ObjectBox = DrawingHere,
            ObjectTracer = DrawingHere,
            ObjectNameTag = DrawingHere,
        }
        ]]
    }
}

-- // Functions
function getCharacter(Player) -- // Just in case I need to apply patches to games that do funky stuff to the character
    return Player.Character or Player.CharacterAdded:Wait()
end
Character = getCharacter(LocalPlayer)

-- // Initialise a player
function initialisePlayer(Player, Verbose) 
    if not PlayerESP.PlayerDrawings[Player.Name] then
        PlayerESP.PlayerDrawings[Player.Name] = {}
        PlayerESP.PlayerDrawings[Player.Name] = {
            ObjectBox = nil,
            ObjectTracer = nil,
            ObjectNameTag = nil,
        }
        if Verbose then print('Initialised Player ESP for '..Player.Name) end
        return PlayerESP.PlayerDrawings[Player.Name]
    else
        if Verbose then warn(Player.Name.." has already been drawn!") return end
    end
end

-- // Deinitalise a player
function deInitialisePlayer(Player, Verbose)
    if PlayerESP.PlayerDrawings[Player.Name] then
        local tCount = 1
        for i,v in next, PlayerESP.PlayerDrawings do
            if i == Player.Name then
                if v.ObjectBox then v.ObjectBox:Remove() end
                if v.ObjectTracer then v.ObjectTracer:Remove() end
                if v.ObjectNameTag then v.ObjectTracer:Remove() end
                table.remove(PlayerESP.PlayerDrawings, tCount)
                if Verbose then print('Deinitialised Player ESP for '..Player.Name) end
                break 
            end
            tCount = tCount + 1
        end
    else
        if Verbose then warn(Player.Name.." has not been drawn yet!") return end
    end
end

-- // Create a new Drawing Object
function createDrawingObject(DrawingType, DrawingProperties)
    local newDrawing = Drawing.new(DrawingType)
    for i,v in next, DrawingProperties do
        newDrawing[i] = v 
    end
    return newDrawing
end

-- // Check if a part is visible
function isPartVisible(Part, PartDescendant)
    local Character = getCharacter(LocalPlayer)
    local Origin = CurrentCamera.CFrame.p
    local _, OnScreen = WorldToViewportPoint(CurrentCamera, Part.Position)
    if OnScreen then
        local newRay = Ray.new(Origin, Part.Position - Origin)
        local PartHit, _ = Workspace:FindPartOnRayWithIgnoreList(newRay, {Character, CurrentCamera})
        local Visible = (not PartHit or PartHit:IsDescendantOf(PartDescendant))
        return Visible
    end
    return false
end

-- // Making the NameTag Text
function getPlayerText(Player, NameTagSettings)
    local Name = Player.Name
    local Character = getCharacter(Player)
    local ShowHealth = NameTagSettings.ShowHealth
    local ShowDistance = NameTagSettings.ShowDistance
    local ShowVisibility = NameTagSettings.ShowVisibility
    local VisibleText = NameTagSettings.VisibleText
    local InvisibleText = NameTagSettings.InvisibleText
    local Health, Distance, Visibility, BaseText = "", "", "", ""
    
    if Character and Character.PrimaryPart then
        if ShowDistance then
            local DistanceFromPrimaryPart = math.floor(LocalPlayer:DistanceFromCharacter(Character.PrimaryPart.Position))
            local new = "["..tostring(DistanceFromCharacter).."]"
            BaseText = BaseText..new.." "
        end
        BaseText = BaseText..Name.." "
        if ShowHealth then
            local CurrentHealth = math.floor(Character:FindFirstChildWhichIsA("Humanoid").Health)
            local MaxHealth = math.floor(Character:FindFirstChildWhichIsA("Humanoid").MaxHealth)
            local HealthPercentage = math.clamp(CurrentHealth / MaxHealth * 100, 0, 1/0)
            if tostring(HealthPercentage) == "-nan(ind)" then HealthPercentage = 100 end
            local new = tostring(HealthPercentage).."%"
            BaseText = BaseText..new.." "
        end
        if ShowVisibility then
            local VisiblityText = (isPartVisible(Character.PrimaryPart, Character) and VisibleText or InvisibleText)
            local BaseText = BaseText..VisibleText
        end
    end
    
    return BaseText
end

-- // Creating ESP
function PlayerESP.new(data)
    -- // Getting all of the Data we need. Might be slow but I like organisation
    Player = data.Player
    Settings = {
        GlobalEnabled = PlayerESP.Settings.GlobalEnabled,
        BoxSettings = PlayerESP.Settings.BoxSettings,
        TracerSettings = PlayerESP.Settings.TracerSettings,
        NameTagSettings = PlayerESP.Settings.NameTagSettings,
    }
    if data.Settings then
        if data.Settings.GlobalEnabled then Settings.GlobalEnabled = data.GlobalEnabled end
        for i,v in pairs(data.Settings.BoxSettings) do
            if Settings.BoxSettings[i] then Settings.BoxSettings[i] = v end
        end
        for i,v in next, data.Settings.TracerSettings do
            if Settings.TracerSettings[i] then Settings.TracerSettings[i] = v end
        end
        for i,v in next, data.Settings.NameTagSettings do
            if Settings.NameTagSettings[i] then Settings.NameTagSettings[i] = v end
        end
    end

    -- // Setting some base variables
    if not PlayerESP.PlayerDrawings[Player.Name] then
        initialisePlayer(Player) -- // If the Player is not initialised then initialise them
    end

    -- // Making the ESP, setting base properties
    local Holder = PlayerESP.PlayerDrawings[Player.Name]
    Holder.ObjectBox = createDrawingObject("Square", {
        Thickness = 2,
        Filled = false,
        Transparency = 0.8,
    })
    Holder.ObjectTracer = createDrawingObject("Line", {
        From = Vector2.new(CurrentCamera.ViewportSize.X / 2, CurrentCamera.ViewportSize.Y),
        Color = Settings.TracerSettings.ColourVisible,
        Thickness = 2,
        Transparency = 0.8,
    })
    Holder.ObjectNameTag = createDrawingObject("Text", {
        Text = getPlayerText(Player, Settings.NameTagSettings),
        Color = Settings.NameTagSettings.ColourVisible,
        Center = true,
        Outline = true,
        Size = 16,
    })
    Holder.Settings = Settings

    -- // Making our 'update' function for the ESP
    function Holder.UpdateESP()
        -- // Check if the whole ESP is enabled
        if Holder and Holder.Settings.GlobalEnabled and PlayerESP.Settings.GlobalEnabled then
            -- // Vars
            local Character = getCharacter(Player)

            local ObjectBox = Holder.ObjectBox
            local ObjectTracer = Holder.ObjectTracer
            local ObjectNameTag = Holder.ObjectNameTag

            local Settings = Holder.Settings
            local BoxSettings = Settings.BoxSettings
            local TracerSettings = Settings.TracerSettings
            local NameTagSettings = Settings.NameTagSettings

            -- // Check if they have a PrimaryPart
            if Character and Character.PrimaryPart and ObjectBox and ObjectTracer and ObjectNameTag then
                -- // Vars
                local PrimaryPart = Character.PrimaryPart
                local PrimaryPartPosition, PrimaryPartVisible = WorldToViewportPoint(CurrentCamera, PrimaryPart.Position)
                local TeamCheck = (PlayerESP.Settings.TeamCheck and Player.TeamColor ~= LocalPlayer.TeamColor) or (not PlayerESP.Settings.TeamCheck)

                -- // Check if PrimaryPart is visible on Screen
                if PrimaryPartVisible and ObjectBox and ObjectTracer and ObjectNameTag then
                    -- // Vars
                    local headPos = WorldToViewportPoint(CurrentCamera, Character.Head.Position + Vector3.new(0, 0.5, 0))
                    local legPos = WorldToViewportPoint(CurrentCamera, PrimaryPart.Position - Vector3.new(0, 3, 0))

                    -- // Setting NameTag Text
                    ObjectNameTag.Text = getPlayerText(Player, Settings.NameTagSettings) 

                    -- // Setting Size, Positions, To
                    ObjectBox.Size = Vector2.new(2350 / PrimaryPartPosition.Z, headPos.Y - legPos.Y)
                    ObjectBox.Position = Vector2.new((PrimaryPartPosition.X - ObjectBox.Size.X / 2), (PrimaryPartPosition.Y - ObjectBox.Size.Y / 2))

                    ObjectTracer.To = Vector2.new(PrimaryPartPosition.X, PrimaryPartPosition.Y - ObjectBox.Size.Y / 2)
                    
                    ObjectNameTag.Position = Vector2.new(PrimaryPartPosition.X, (PrimaryPartPosition.Y + ObjectBox.Size.Y / 2) - 25)

                    -- // Setting Colours
                    ObjectBox.Color = BoxSettings.ColourVisible
                    ObjectTracer.Color = TracerSettings.ColourVisible
                    ObjectNameTag.Color = NameTagSettings.ColourVisible

                    -- // Settings Colours based on whether VisibilityCheck is enabled
                    if not isPartVisible(PrimaryPart, Character) and Settings.NameTagSettings.ShowVisibility then
                        ObjectBox.Color = BoxSettings.ColourInvisible
                        ObjectTracer.Color = TracerSettings.ColourInvisible
                        ObjectNameTag.Color = NameTagSettings.ColourInvisible
                    end

                    -- // Setting Visiblity
                    ObjectBox.Visible = --[[BoxSettings.Enabled and TeamCheck]] true
                    ObjectTracer.Visible = --[[TracerSettings.Enabled and TeamCheck]] true
                    ObjectNameTag.Visible = --[[NameTagSettings.Enabled and TeamCheck]] true
                else
                    ObjectBox.Visible = false
                    ObjectTracer.Visible = false
                    ObjectNameTag.Visible = false
                end
            else
                if ObjectBox and ObjectTracer and ObjectNameTag then
                    ObjectBox.Visible = false
                    ObjectTracer.Visible = false
                    ObjectNameTag.Visible = false
                end
            end
        end
    end

    return Holder
end

-- // Creates an ESP for a Player
function newESP(Player, Verbose)
    if PlayerESP.PlayerDrawings[Player.Name] then return end
    local initialised = initialisePlayer(Player)
    local makeESP = PlayerESP.new({
        Player = Player,
        -- // Can add extra config settings if you want
    })
    if initialised and makeESP and Verbose then print('Fully made ESP for '..Player.Name..'!') end
end

-- // Makes ESP on all players except LocalPlayer
for _, Player in next, Players:GetPlayers() do
    if Player ~= LocalPlayer then
        newESP(Player, true)
    end
end

-- // Making/Removing ESP when Players join and leave
Players.PlayerAdded:Connect(function(Player)
    newESP(Player, true)
end)
Players.PlayerRemoving:Connect(function(Player)
    deInitialisePlayer(Player, true)
end)

-- // Loop update the ESP
game:GetService("RunService"):BindToRenderStep("UpdateESP", 0, function()
    for _, v in pairs(PlayerESP.PlayerDrawings) do
        if rawget(v, "UpdateESP") then rawget(v, "UpdateESP")() end
    end
end)