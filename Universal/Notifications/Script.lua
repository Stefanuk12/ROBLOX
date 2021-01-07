local NotificationTheme = {
	-- // Theme Colours
	MainColour = Color3.fromRGB(255, 119, 244),
	BackgroundColour = Color3.fromRGB(25, 25, 25),
	SecondaryBackgroundColour = Color3.fromRGB(15, 15, 15),
	Success = Color3.fromRGB(119, 221, 119),
	Error = Color3.fromRGB(255, 150, 150),
	Alert = Color3.fromRGB(253, 253, 150),
	
	-- // Text Configuration
	BodyFont = Enum.Font.SourceSans,
	BodyTextColor3 = Color3.fromRGB(255, 255, 255),
	
	TitleFont = Enum.Font.GothamBlack,
	TitleTextColor3 = Color3.fromRGB(255, 255, 255),
	
	-- // Default Settings
	WaitTime = 2,
	StorageLocation = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"),
	GUIName = "NotificationGUI",
	NotificationName = "Notification",
}

function NotificationTheme.failSafeChecks(CustomTheme)
	-- // If CustomTheme is not provided or CustomTheme is not a table
	if not CustomTheme or (CustomTheme and type(CustomTheme) ~= "table") then CustomTheme = NotificationTheme
		return CustomTheme
	end
	
	-- // If CustomTheme's keys are incorrect or nil
	for i,v in pairs(NotificationTheme) do
		for a,x in pairs(CustomTheme) do
			if (not CustomTheme[i]) or (typeof(CustomTheme[i]) ~= typeof(v)) then
				CustomTheme[i] = v
			end
		end
	end
	return CustomTheme
end

function NotificationTheme.returnBaseNotification(CustomTheme)
	CustomTheme = NotificationTheme.failSafeChecks(CustomTheme)

	local Notification = Instance.new("Frame")
	local StatusBar = Instance.new("Frame")
	local StatusColour = Instance.new("Frame")
	local Title = Instance.new("TextLabel")
	local Body = Instance.new("TextLabel")
	local StatusColourLine = Instance.new("Frame")
	if not CustomTheme["StorageLocation"]:FindFirstChild(CustomTheme["GUIName"]) then
		local NotificationGUI = Instance.new("ScreenGui")
		NotificationGUI.Name = CustomTheme["GUIName"]
		NotificationGUI.Parent = CustomTheme["StorageLocation"]
		NotificationGUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	end
	local NotificationGUI = CustomTheme["StorageLocation"]:WaitForChild(CustomTheme["GUIName"])
	Notification.Name = CustomTheme["NotificationName"]
	Notification.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	Notification.BorderColor3 = Color3.fromRGB(255, 119, 244)
	Notification.ClipsDescendants = true
	Notification.Position = UDim2.new(0, 0, 0, 0)
	Notification.Size = UDim2.new(0, 400, 0, 100)
	StatusBar.Name = "StatusBar"
	StatusBar.Parent = Notification
	StatusBar.BackgroundColor3 = Color3.fromRGB(255, 146, 245)
	StatusBar.BorderSizePixel = 0
	StatusBar.Size = UDim2.new(0, 20, 0, 100)
	StatusBar.ZIndex = 5
	StatusColour.Name = "StatusColour"
	StatusColour.Parent = Notification
	StatusColour.BackgroundColor3 = Color3.fromRGB(199, 255, 174)
	StatusColour.BorderSizePixel = 0
	StatusColour.Size = UDim2.new(0, 25, 0, 100)
	StatusColour.ZIndex = 4
	Title.Name = "Title"
	Title.Parent = Notification
	Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Title.BackgroundTransparency = 1.000
	Title.BorderSizePixel = 0
	Title.Position = UDim2.new(0.0625, 0, 0, 0)
	Title.Size = UDim2.new(0, 375, 0, 35)
	Title.ZIndex = 3
	Title.Font = Enum.Font.GothamBlack
	Title.Text = "Title"
	Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title.TextSize = 16.000
	Body.Name = "Body"
	Body.Parent = Notification
	Body.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	Body.BorderColor3 = Color3.fromRGB(27, 42, 53)
	Body.BorderSizePixel = 0
	Body.Position = UDim2.new(0.0625, 0, 0.349999994, 0)
	Body.Size = UDim2.new(0, 375, 0, 65)
	Body.ZIndex = 2
	Body.Font = Enum.Font.SourceSans
	Body.Text = "Body"
	Body.TextColor3 = Color3.fromRGB(255, 255, 255)
	Body.TextSize = 16.000
	Body.TextWrapped = true
	StatusColourLine.Name = "StatusColourLine"
	StatusColourLine.Parent = Notification
	StatusColourLine.BackgroundColor3 = Color3.fromRGB(199, 255, 174)
	StatusColourLine.BorderSizePixel = 0
	StatusColourLine.Position = UDim2.new(0, 0, 0.349999994, 0)
	StatusColourLine.Size = UDim2.new(0, 400, 0, 1)
	StatusColourLine.ZIndex = 2

	return Notification
end

function NotificationTheme.getY(CustomTheme)
	local Highest = 0.80
	local FrameCount = 0
	local NotificationGUI = CustomTheme["StorageLocation"]:WaitForChild(CustomTheme["GUIName"])
	
	for i,v in pairs(NotificationGUI:GetChildren()) do -- // Support Multiple Notifications
		if v.Position.Y.Scale > Highest then
			Highest = v.Position.Y.Scale - 0.15
		end
	end
	
	return Highest 
end

function NotificationTheme.newNotification(TitleText, BodyText, NotificationType, CustomTheme)
	-- // Initialise
	coroutine.wrap(function()
		TitleText = tostring(TitleText)
		CustomTheme = NotificationTheme.failSafeChecks(CustomTheme)
		local Notification = NotificationTheme.returnBaseNotification(CustomTheme)	
		local NotificationGUI = CustomTheme["StorageLocation"]:WaitForChild(CustomTheme["GUIName"])
		local Theme = NotificationTheme
		
		if not TitleText or (TitleText and type(TitleText) ~= "string") then TitleText = "" end
		if not BodyText or (BodyText and type(BodyText) ~= "string") then TitleText = "" end
		if not NotificationType or (typeof(NotificationType) ~= 'string' and typeof(NotificationType) ~= 'Color3') or (typeof(NotificationType) == 'string' and not CustomTheme[NotificationType]) then NotificationType = "Success" end

		if type(NotificationType) == 'string' then
			NotificationType = CustomTheme[NotificationType]
		end
		
		-- // Actually making the Notification
		Notification.Position = UDim2.new(0, 0, NotificationTheme.getY(CustomTheme), 0)
		Notification.Size = UDim2.new(0, 0, 0, 100)
		Notification.StatusBar.Size = UDim2.new(0, 0, 0, 100)
		Notification.StatusColour.Size = UDim2.new(0, 0, 0, 100)
		
		Notification.BorderColor3 = CustomTheme["MainColour"]
		Notification.BackgroundColor3 = CustomTheme["BackgroundColour"]
		Notification.StatusBar.BackgroundColor3 = CustomTheme["MainColour"]
		Notification.StatusColourLine.BackgroundColor3 = NotificationType
		Notification.StatusColour.BackgroundColor3 = NotificationType
		
		Notification.Title.Text = TitleText
		Notification.Title.Font = CustomTheme["TitleFont"]
		
		Notification.Body.BackgroundColor3 = CustomTheme["SecondaryBackgroundColour"]
		Notification.Body.Text = BodyText
		Notification.Body.Font = CustomTheme["BodyFont"]
		
		Notification.Parent = NotificationGUI
		-- // Auto Re Position
		local Connection = NotificationGUI.ChildRemoved:Connect(function(child)
			if child ~= Notification then
				Notification:TweenPosition(UDim2.new(0, 0, Notification.Position.Y.Scale + 0.15, 0), "In", "Quad", 0.5)
			end
		end)
		
		-- // Tweening Start
		if Notification and Notification:FindFirstChild("StatusColour") and Notification:FindFirstChild("StatusBar") then
			Notification:TweenSize(UDim2.new(0, 400, 0, 100), "In", "Quad", 0.25)
			Notification.StatusColour:TweenSize(UDim2.new(0, 400, 0, 100), "In", "Quad", 0.25)
			wait(0.25)
			local timetaken = tick()
			coroutine.wrap(function()
				Notification.StatusBar:TweenSize(UDim2.new(0, 400, 0, 100), "In", "Quad", 0.35)
				wait(0.35)
				Notification.StatusBar:TweenSize(UDim2.new(0, 20, 0, 100), "Out", "Quad", 0.35)
				wait(0.35)
			end)()
			coroutine.wrap(function()
				wait(0.60)
				Notification.StatusColour:TweenSize(UDim2.new(0, 25, 0, 100), "Out", "Quad", 0.30)
			end)()
				
			-- // Tweening End
			wait(CustomTheme["WaitTime"])
			if Notification and Notification:FindFirstChild("StatusColour") and Notification:FindFirstChild("StatusBar") then
				Notification.StatusColour:TweenSize(UDim2.new(0, 25, 0, 100), "Out", "Quad", 0.30)
				wait(0.30)
				Notification.StatusBar:TweenSize(UDim2.new(0, 400, 0, 100), "In", "Quad", 0.35)
				wait(0.30)
				Notification:TweenSize(UDim2.new(0, 0, 0, 100), "In", "Quad", 0.25, false, function()
					-- // Destroying
					Notification:Destroy()
					Connection:Disconnect()
				end)
			end
		end
	end)()
end

return NotificationTheme