-- Gui to Lua
-- Version: 3.2

-- Instances:

local ScriptCMDs = Instance.new("ScreenGui")
local Container = Instance.new("Frame")
local Header = Instance.new("Frame")
local Title = Instance.new("TextButton")
local Close = Instance.new("TextButton")
local Body = Instance.new("Frame")
local CMDFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local spammessage = Instance.new("TextButton")
local stopspammessage = Instance.new("TextButton")
local getmusic = Instance.new("TextButton")
local refreshmusic = Instance.new("TextButton")
local playnumber = Instance.new("TextButton")

--Properties:

ScriptCMDs.Name = "ScriptCMDs"
ScriptCMDs.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScriptCMDs.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Container.Name = "Container"
Container.Parent = ScriptCMDs
Container.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Container.BackgroundTransparency = 1.000
Container.BorderSizePixel = 0
Container.Position = UDim2.new(0.399999976, 0, 0.200000033, 0)
Container.Size = UDim2.new(0, 300, 0, 50)

Header.Name = "Header"
Header.Parent = Container
Header.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Header.BorderSizePixel = 0
Header.Size = UDim2.new(0, 300, 0, 50)

Title.Name = "Title"
Title.Parent = Header
Title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Title.BackgroundTransparency = 1.000
Title.BorderSizePixel = 0
Title.Size = UDim2.new(0, 0, 0, 50)
Title.AutoButtonColor = false
Title.Font = Enum.Font.GothamBlack
Title.Text = "    | Epic Script CMDs"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 14.000
Title.TextStrokeColor3 = Color3.fromRGB(200, 200, 200)
Title.TextXAlignment = Enum.TextXAlignment.Left

Close.Name = "Close"
Close.Parent = Header
Close.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Close.BorderSizePixel = 0
Close.Position = UDim2.new(0.850000024, 0, 0, 0)
Close.Size = UDim2.new(0, 45, 0, 50)
Close.AutoButtonColor = false
Close.Font = Enum.Font.GothamBold
Close.Text = "X"
Close.TextColor3 = Color3.fromRGB(255, 105, 97)
Close.TextSize = 14.000
Close.TextStrokeColor3 = Color3.fromRGB(200, 200, 200)

Body.Name = "Body"
Body.Parent = Header
Body.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Body.BackgroundTransparency = 1.000
Body.BorderSizePixel = 0
Body.Position = UDim2.new(0, 0, 0.985000014, 0)
Body.Size = UDim2.new(0, 300, 0, 350)

CMDFrame.Name = "CMDFrame"
CMDFrame.Parent = Body
CMDFrame.Active = true
CMDFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
CMDFrame.BorderSizePixel = 0
CMDFrame.Size = UDim2.new(0, 300, 0, 350)

UIListLayout.Parent = CMDFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

spammessage.Name = ":spam <\"message\">"
spammessage.Parent = CMDFrame
spammessage.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
spammessage.BackgroundTransparency = 1.000
spammessage.BorderSizePixel = 0
spammessage.Size = UDim2.new(0, 300, 0, 50)
spammessage.AutoButtonColor = false
spammessage.Font = Enum.Font.Gotham
spammessage.Text = "    > :spam <\"message\">"
spammessage.TextColor3 = Color3.fromRGB(255, 255, 255)
spammessage.TextSize = 14.000
spammessage.TextStrokeColor3 = Color3.fromRGB(200, 200, 200)
spammessage.TextXAlignment = Enum.TextXAlignment.Left

stopspammessage.Name = ":stopspam <\"message\">"
stopspammessage.Parent = CMDFrame
stopspammessage.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
stopspammessage.BackgroundTransparency = 1.000
stopspammessage.BorderSizePixel = 0
stopspammessage.Size = UDim2.new(0, 300, 0, 50)
stopspammessage.AutoButtonColor = false
stopspammessage.Font = Enum.Font.Gotham
stopspammessage.Text = "    > :stopspam <\"message\">"
stopspammessage.TextColor3 = Color3.fromRGB(255, 255, 255)
stopspammessage.TextSize = 14.000
stopspammessage.TextStrokeColor3 = Color3.fromRGB(200, 200, 200)
stopspammessage.TextXAlignment = Enum.TextXAlignment.Left

getmusic.Name = ":getmusic"
getmusic.Parent = CMDFrame
getmusic.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
getmusic.BackgroundTransparency = 1.000
getmusic.BorderSizePixel = 0
getmusic.Size = UDim2.new(0, 300, 0, 50)
getmusic.AutoButtonColor = false
getmusic.Font = Enum.Font.Gotham
getmusic.Text = "    > :getmusic - returns all playable songs"
getmusic.TextColor3 = Color3.fromRGB(255, 255, 255)
getmusic.TextSize = 14.000
getmusic.TextStrokeColor3 = Color3.fromRGB(200, 200, 200)
getmusic.TextXAlignment = Enum.TextXAlignment.Left

refreshmusic.Name = ":refreshmusic"
refreshmusic.Parent = CMDFrame
refreshmusic.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
refreshmusic.BackgroundTransparency = 1.000
refreshmusic.BorderSizePixel = 0
refreshmusic.Size = UDim2.new(0, 300, 0, 50)
refreshmusic.AutoButtonColor = false
refreshmusic.Font = Enum.Font.Gotham
refreshmusic.Text = "    > :refreshmusic - refreshes musictable"
refreshmusic.TextColor3 = Color3.fromRGB(255, 255, 255)
refreshmusic.TextSize = 14.000
refreshmusic.TextStrokeColor3 = Color3.fromRGB(200, 200, 200)
refreshmusic.TextXAlignment = Enum.TextXAlignment.Left

playnumber.Name = ":play <\"number\">"
playnumber.Parent = CMDFrame
playnumber.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
playnumber.BackgroundTransparency = 1.000
playnumber.BorderSizePixel = 0
playnumber.Size = UDim2.new(0, 300, 0, 50)
playnumber.AutoButtonColor = false
playnumber.Font = Enum.Font.Gotham
playnumber.Text = "    > :play <\"number\">"
playnumber.TextColor3 = Color3.fromRGB(255, 255, 255)
playnumber.TextSize = 14.000
playnumber.TextStrokeColor3 = Color3.fromRGB(200, 200, 200)
playnumber.TextXAlignment = Enum.TextXAlignment.Left

-- // Script
local Dragger = {}; do
    local Mouse = game:GetService("Players").LocalPlayer:GetMouse()
    local UIS = game:GetService("UserInputService")
    local Heartbeat = game:GetService("RunService").Heartbeat
    function Dragger.new(Frame)
        local success, response = pcall(function()
            return Frame.MouseEnter
        end)
        if success then
            Frame.Active = true
            response:Connect(function()
                local Input = Frame.InputBegan:Connect(function(Key)
                    if Key.UserInputType == Enum.UserInputType.MouseButton1 then
                        local objectPosition = Vector2.new(Mouse.X - Frame.AbsolutePosition.X, Mouse.Y - Frame.AbsolutePosition.Y)
                        while Heartbeat:Wait() and UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
                            pcall(function()
                                Frame:TweenPosition(UDim2.new(0, Mouse.X - objectPosition.X + (Frame.Size.X.Offset * Frame.AnchorPoint.X), 0, Mouse.Y - objectPosition.Y + (Frame.Size.Y.Offset * Frame.AnchorPoint.Y)), 'Out', 'Linear', 0.1, true)
                            end)
                        end
                    end
                end)

                local Leave
                Leave = Frame.MouseLeave:Connect(function()
                    Input:Disconnect()
                    Leave:Disconnect()
                end)
            end)
        end
    end

end
Dragger.new(Container)

local Connections = {}
function hoverGlow(hoverPart, affectedPart)
	local TweenService = game:GetService("TweenService")
	local hPartMouseEnter = hoverPart.MouseEnter:Connect(function()
		TweenService:Create(affectedPart, TweenInfo.new(0.2), {TextStrokeTransparency = 0.8}):Play()
	end)
   	local hPartMouseLeave = hoverPart.MouseLeave:Connect(function()
		TweenService:Create(affectedPart, TweenInfo.new(0.2), {TextStrokeTransparency = 1}):Play()
	end)      
    local hPartMouseDown = hoverPart.MouseButton1Down:Connect(function()
        TweenService:Create(affectedPart, TweenInfo.new(0.2), {TextStrokeTransparency = 0.5}):Play()
    end)         
    local hPartMouseUp = hoverPart.MouseButton1Up:Connect(function()
        TweenService:Create(affectedPart, TweenInfo.new(0.2), {TextStrokeTransparency = 1}):Play()
    end)
	table.insert(Connections, {Connection = hPartMouseEnter})
	table.insert(Connections, {Connection = hPartMouseLeave})
	table.insert(Connections, {Connection = hPartMouseDown})
	table.insert(Connections, {Connection = hPartMouseUp})
end

hoverGlow(Close, Close)
local CloseConnection = Close.MouseButton1Click:Connect(function()
	for i,v in pairs(Connections) do
		v.Connection:Disconnect()
	end
	for i,v in pairs(ScriptCMDs:GetDescendants()) do
		if string.match(v.ClassName, "Frame") then
			game:GetService("TweenService"):Create(v, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()
			game:GetService("TweenService"):Create(v, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()
		end
		if string.match(v.ClassName, "Text") then
			game:GetService("TweenService"):Create(v, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()
			game:GetService("TweenService"):Create(v, TweenInfo.new(1), {TextTransparency = 1}):Play()
			game:GetService("TweenService"):Create(v, TweenInfo.new(1), {TextTransparency = 1}):Play()
			v.TextStrokeTransparency = 1
		end
		if string.match(v.ClassName, "ScrollingFrame") then
			game:GetService("TweenService"):Create(v, TweenInfo.new(1), {ScrollBarImageTransparency = 1}):Play()
		end
	end
	wait(2)
	ScriptCMDs:Destroy()
end)

hoverGlow(Title, Title)
local TitleClickConnection = Title.MouseButton1Click:Connect(function()
	print("hi epic scirpt comandsa")
end)

for i,v in pairs(CMDFrame:GetChildren()) do
	if v:IsA("TextButton") then
		hoverGlow(v, v)
		local ButtonClickConnection = v.MouseButton1Click:Connect(function()
			print(v.Name)
		end)
		table.insert(Connections, {Connection = ButtonClickConnection})
	end
end
table.insert(Connections, {Connection = CloseConnection})
table.insert(Connections, {Connection = TitleClickConnection})