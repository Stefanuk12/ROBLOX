local SilentCMDs = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local TextBox = Instance.new("TextBox")
local Execute = Instance.new("TextButton")
local Title = Instance.new("TextLabel")
local Close = Instance.new("TextButton")
local Spam = Instance.new("TextButton")

SilentCMDs.Name = "Silent CMDs"
SilentCMDs.Parent = game.CoreGui
SilentCMDs.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Main.Name = "Main"
Main.Parent = SilentCMDs
Main.Active = true
Main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Main.Position = UDim2.new(0.0220170617, 0, 0.79061377, 0)
Main.Selectable = true
Main.Size = UDim2.new(0, 427, 0, 100)
Main.Style = Enum.FrameStyle.ChatBlue
Main.Draggable = true

TextBox.Parent = Main
TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextBox.Position = UDim2.new(0.0585480034, 0, 0.099999994, 0)
TextBox.Size = UDim2.new(0, 200, 0, 50)
TextBox.Font = Enum.Font.SourceSans
TextBox.PlaceholderText = "Insert CMD here"
TextBox.Text = ""
TextBox.TextColor3 = Color3.fromRGB(0, 0, 0)
TextBox.TextSize = 14.000

Execute.Name = "Execute"
Execute.Parent = Main
Execute.BackgroundColor3 = Color3.fromRGB(156, 200, 207)
Execute.BorderSizePixel = 0
Execute.Position = UDim2.new(0.683674991, 0, 0.122095942, 0)
Execute.Size = UDim2.new(0, 95, 0, 23)
Execute.Font = Enum.Font.SourceSans
Execute.Text = "Execute"
Execute.TextColor3 = Color3.fromRGB(0, 0, 0)
Execute.TextSize = 14.000

Title.Name = "Title"
Title.Parent = Main
Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title.BorderSizePixel = 0
Title.Position = UDim2.new(0.222012192, 0, -0.245000005, 0)
Title.Size = UDim2.new(0, 71, 0, 21)
Title.Font = Enum.Font.SourceSansItalic
Title.Text = "Silent + Spam CMDs"
Title.TextColor3 = Color3.fromRGB(0, 0, 0)
Title.TextSize = 14.000

Close.Name = "Close"
Close.Parent = Main
Close.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Close.BorderSizePixel = 0
Close.Position = UDim2.new(0.960550189, 0, -0.19999665, 0)
Close.Size = UDim2.new(0, 30, 0, 21)
Close.Font = Enum.Font.SourceSansBold
Close.Text = "x"
Close.TextColor3 = Color3.fromRGB(0, 0, 0)
Close.TextSize = 14.000

Spam.Name = "Spam"
Spam.Parent = Main
Spam.BackgroundColor3 = Color3.fromRGB(207, 162, 162)
Spam.BorderSizePixel = 0
Spam.Position = UDim2.new(0.683674991, 0, 0.502095938, 0)
Spam.Size = UDim2.new(0, 95, 0, 23)
Spam.Font = Enum.Font.SourceSans
Spam.Text = "Spam"
Spam.TextColor3 = Color3.fromRGB(0, 0, 0)
Spam.TextSize = 14.000

Close.MouseButton1Click:Connect(function()
	SilentCMDs:Destroy()
end)

Execute.MouseButton1Click:Connect(function()
	game:GetService("Players"):Chat(tostring(TextBox.Text))
end)

local silentCMDToggle = false
Spam.MouseButton1Click:Connect(function()
    silentCMDToggle = not silentCMDToggle
	if silentCMDToggle then do
		warn('Silent CMDs: Commencing Spam')
		Spam.Text = "Stop"
		coroutine.wrap(function()
			while wait() do
				if not silentCMDToggle then break end
				game:GetService("Players"):Chat(tostring(TextBox.Text))
				wait(0.1)
			end
		end)()
	end
	
	if not silentCMDToggle then
		print('Silent CMDs: Ended')
		Spam.Text = "Spam"
	end
end)

print('Silent + Spam Commands for Kohls Admin House loaded - made by Stefanuk#5820')