-- made with crishoux's esp module

-- // Valiant ENV
loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/ValiantENV.lua"))()

-- // Vars
local ValiantItemESP = {}
local trackingitem = {}
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local worldToViewportPoint = CurrentCamera.WorldToViewportPoint
local TracerStart = Vector2.new(CurrentCamera.ViewportSize.X / 2, CurrentCamera.ViewportSize.Y)
local ItemESP = {
    Enabled = false,
    Boxes = true,
    Tracers = true,
    Names = true,
    Distance = true,
    NameColor = Color3.fromRGB(255, 255, 255),
    TracerColor = Color3.fromRGB(255, 255, 255),
    BoxColor = Color3.fromRGB(255, 255, 255),
    Divider = 10,
    Isle = {
        Categories = {
            Usables = true,
            Accessory = true,
            Weapons = true,
        },
        Items = {
            ["Fuse"] = {
                ["Part"] = "Tube",
                ["Category"] = "Usables"
            },
            ["Night Vision Goggles"] = {
                ["Part"] = "Handle",
                ["Category"] = "Accessory"
            },
            ["Climbing Tool"] = {
                ["Part"] = "Handle",
                ["Category"] = "Accessory"
            },
            ["Lantern"] = {
                ["Part"] = "Handle",
                ["Category"] = "Accessory"
            },
            ["Revolver"] = {
                ["Part"] = "Handle",
                ["Category"] = "Weapons"
            },
            ["Ballistic Vest"] = {
                ["Part"] = "Handle",
                ["Category"] = "Accessory"
            },
            ["Proximity Explosive"] = {
                ["Part"] = "Handle",
                ["Category"] = "Weapons"
            },
            ["GPS"] = {
                ["Part"] = "Handle",
                ["Category"] = "Accessory"
            },
            ["Double Barrel Shotgun"] = {
                ["Part"] = "Handle",
                ["Category"] = "Weapons"
            },
            ["Medical Kit"] = {
                ["Part"] = "Handle",
                ["Category"] = "Accessory"
            },
            ["Watch"] = {
                ["Part"] = "Handle",
                ["Category"] = "Accessory"
            },
            ["Flashlight"] = {
                ["Part"] = "Handle",
                ["Category"] = "Accessory"
            },
            ["Experimental Vision Goggles"] = {
                ["Part"] = "Handle",
                ["Category"] = "Accessory"
            },
            ["Flare Gun"] = {
                ["Part"] = "Handle",
                ["Category"] = "Accessory"
            },
            ["Assistant Drone"] = {
                ["Part"] = "Handle",
                ["Category"] = "Accessory"
            },
            ["Scoped Rifle"] = {
                ["Part"] = "Handle",
                ["Category"] = "Weapons"
            },
            ["Master Bypass Console"] = {
                ["Part"] = "Handle",
                ["Category"] = "Usables"
            },
            ["Diving Gear"] = {
                ["Part"] = "Handle",
                ["Category"] = "Usables"
            },
            ["Ammunition Crate"] = {
                ["Part"] = "Handle",
                ["Category"] = "Weapons"
            },
            ["Strange Drink"] = {
                ["Part"] = "Handle",
                ["Category"] = "Accessory"
            },
            ["Treasure Map"] = {
                ["Part"] = "Handle",
                ["Category"] = "Accessory"
            },
            ["Walky Talky"] = {
                ["Part"] = "Handle",
                ["Category"] = "Accessory"
            },
            ["Energy Lancer"] = {
                ["Part"] = "Handle",
                ["Category"] = "Weapons"
            },
            ["Healing Spray"] = {
                ["Part"] = "Handle",
                ["Category"] = "Accessory"
            },
            ["Proton Cannon"] = {
                ["Part"] = "Handle",
                ["Category"] = "Weapons"
            },
            ["Fuel"] = {
                ["Part"] = "Handle",
                ["Category"] = "Accessory"
            },
            ["Keycard (Level 1)"] = {
                ["Part"] = "Handle",
                ["Category"] = "Usables"
            },
            ["Keycard (Level 2)"] = {
                ["Part"] = "Handle",
                ["Category"] = "Usables"
            },
            ["Keycard (Level 3)"] = {
                ["Part"] = "Handle",
                ["Category"] = "Usables"
            },
            ["Plane Steering Wheel"] = {
                ["Part"] = "Handle",
                ["Category"] = "Usables"
            },
            ["Plane Propeller"] = {
                ["Part"] = "Handle",
                ["Category"] = "Usables"
            },
            ["Plane Wheel"] = {
                ["Part"] = "Handle",
                ["Category"] = "Usables"
            },
        },
    }
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

--// ItemESP
function removeHashNum(str)
    return str:gsub("[^%a%s_]+", "")
end

function getItemESPName(item, itemName, Distance)
    local n = ((LocalPlayer.Character.Head.Position - item.Position).magnitude)
    local n = (n + 0.5) - (n + 0.5) % 1
	local Text = tostring(itemName.. " - ".. n)
    return (Distance and Text or itemName)
end

function itemCheckCat(Game, itemName)
    local itemName = itemName:gsub("[^%a%s_]+", "")
	local itemCatagory = ItemESP[Game]["Items"][itemName]["Category"]
    for i,v in next, ItemESP[Game]["Categories"] do
        if i == itemCatagory then
			return v
		end
    end
end


function ValiantItemESP.new(data)
    local self = setmetatable({
        part = data.part,
        ObjectBox = nil,
        ObjectName = nil,
        ObjectTracer = nil,
        Distance = data.Distance or true,
        NameColor = data.NameColor or fromRGB(255, 255, 255),
        TracerColor = data.TracerColor or fromRGB(255, 255, 255),
        BoxColor = data.BoxColor or fromRGB(255, 255, 255),
    }, {__index = ValiantItemESP})

    local part = data.part
    local Boxes = data.Boxes
    local Tracers = data.Tracers
    local Text = data.Text
    local partPos, partVis = worldToViewportPoint(CurrentCamera, part.Position)

    if not part and not ItemESP["Enabled"] then return end

    local ObjectBox = newDrawing("Square")
    ObjectBox.Thickness = 2
    ObjectBox.Filled = false
    ObjectBox.Transparency = 0.8
    local ObjectTracer = newDrawing("Line")
    ObjectTracer.From = TracerStart
    ObjectTracer.Color = self.TracerColor
    ObjectTracer.Thickness = 2
    ObjectTracer.Transparency = 0.8
    local ObjectName = newDrawing("Text")
    ObjectName.Text = Text
    ObjectName.Size = 16
    ObjectName.Color = self.NameColor
    ObjectName.Center = true
    ObjectName.Outline = true

    if not partVis then
        ObjectBox.Size = Vector2.new(ItemESP["Divider"] / part.Size.X, part.Size.Y)
        ObjectBox.Position = Vector2.new(partPos.X, partPos.Y)
        ObjectTracer.To = Vector2.new(partPos.X, partPos.Y - ObjectBox.Size.Y / 2)
        ObjectName.Position = Vector2.new(partPos.X, (partPos.Y + ObjectBox.Size.Y / 2) - 25)

        ObjectBox.Visible = Boxes
        ObjectTracer.Visible = Tracers
        ObjectName.Visible = true
    end

    self.ObjectBox = {ObjectBox, Boxes}
    self.ObjectTracer = {ObjectTracer, Tracers}
    self.ObjectName = {ObjectName, Text, Names}

    return self
end


function ValiantItemESP:update()
    local part, ObjectBox, ObjectTracer, ObjectName = self.part, self.ObjectBox[1], self.ObjectTracer[1], self.ObjectName[1]
    local Boxes, Tracers, Text, Names = self.ObjectBox[2], self.ObjectTracer[2], self.ObjectName[2], self.ObjectName[3]
    if part then
        local destroyed = not part:IsDescendantOf(workspace)
        if destroyed and ObjectBox.__OBJECT_EXISTS and ObjectTracer.__OBJECT_EXISTS and ObjectName.__OBJECT_EXISTS then
            ObjectBox:Remove()
            ObjectTracer:Remove()
            ObjectName:Remove()
        end
        local partPos, partVis = worldToViewportPoint(CurrentCamera, part.Position)
        if partVis and ItemESP["Enabled"] then
            if ObjectBox.__OBJECT_EXISTS and ObjectTracer.__OBJECT_EXISTS and ObjectName.__OBJECT_EXISTS then
                ObjectBox.Size = Vector2.new(ItemESP["Divider"] / part.Size.X, part.Size.Y)
                local ObjectBoxSize = ObjectBox.Size
                ObjectBox.Position = Vector2.new(partPos.X - ObjectBoxSize.X / 2, partPos.Y - ObjectBoxSize.Y / 2)
                
                if isPartVisible(part, part.Parent) then
                    ObjectBox.Color = (self.BoxColor == 'rainbow' and rainbowcolour or self.BoxColor)
                    ObjectName.Color = self.ObjectNameColor
                    ObjectTracer.Color = self.ObjectTracerColor
                else
                    ObjectBox.Color = fromRGB(255, 105, 97)
                    ObjectName.Color = fromRGB(255, 105, 97)
                    ObjectTracer.Color = fromRGB(255, 105, 97)
                end

                ObjectTracer.To = Vector2.new(partPos.X, partPos.Y - ObjectBoxSize.Y / 2)
                
                ObjectName.Position = Vector2.new(partPos.X, (partPos.Y + ObjectBoxSize.Y / 2) - 25)

                if game.PlaceId == 3431407618 then -- Isle
                    if part.Parent:IsA("Model") and itemCheckCat("Isle", part.Parent.Name) then
                       Text = getItemESPName(part, removeHashNum(part.Parent.Name), ItemESP["Distance"])
                    end
                    
                    if part.Parent:IsA("Model") then
                        if itemCheckCat("Isle", part.Parent.Name) then
                            ObjectBox.Visible = Boxes
                            ObjectTracer.Visible = Tracers
                            ObjectName.Visible = Names
                        else
                            ObjectBox.Visible = false
                            ObjectTracer.Visible = false
                            ObjectName.Visible = false
                        end
                    end
                end

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

RunService.RenderStepped:Connect(function()
    for i, v in next, trackingitem do
        v:update()
    end
end)

--[[
    Example:

    for i,v in pairs(game:GetService("Workspace"):GetDescendants()) do 
		if v.Name == "Fuse" and v:IsA("Model") and v.Parent == game:GetService("Workspace") then
			if itemCheckCat("Isle", v.Name) then
				trackingitem[#trackingitem + 1] = ValiantItemESP.new({
					part = v[ItemESP["Isle"]["Items"]["Fuse"]["Part"]*],
					Text = getItemESPName(v[IsleItemESP["Fuse"]["Part"]*], "Fuse", ItemESP["Distance"]),
					Boxes = ItemESP["Boxes"],
                    Tracers = ItemESP["Tracers"],
                    Names = ItemESP["Names"],
					NameColor = ItemESP["NameColor"],
					TracerColor = ItemESP["TracerColor"],
					BoxColor = ["BoxColor"],
				})
			end
		end
    end
    
--]]