local Library = {}

-- // Customization

Library.Font = Enum.Font.Arial
Library.Name = "Library" -- Then name to appear on the ScreenGui

Library.CheatSettings = {}
Library.CheatSettings.EnabledColor = Color3.fromRGB(94, 255, 35)
Library.CheatSettings.DisabledColor = Color3.fromRGB(255, 255, 255)

Library.ToggleSettings = {}
Library.ToggleSettings.EnabledText = "YES"
Library.ToggleSettings.DisabledText = "NO"
Library.ToggleSettings.EnabledColor = Color3.fromRGB(94, 255, 35)
Library.ToggleSettings.DisabledColor = Color3.fromRGB(255, 41, 41)

-- //

local TweenService = game:GetService("TweenService")

function CreateCheatTemplate(Text, HoverGlow)
    local Cheat = Instance.new("TextButton")
    local Title = Instance.new("TextLabel")
    local Expand = Instance.new("TextButton")
    local Options = Instance.new("Frame")
    local UIListLayout = Instance.new("UIListLayout")
    
    Cheat.Name = "Cheat"
    Cheat.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Cheat.BackgroundTransparency = 1
    Cheat.Size = UDim2.new(1, 0, 0, 25)
    Cheat.Font = Enum.Font.SourceSans
    Cheat.Text = ""
    Cheat.TextColor3 = Color3.fromRGB(0, 0, 0)
    Cheat.TextSize = 14
    
    Title.Name = "Title"
    Title.Parent = Cheat
    Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Title.BackgroundTransparency = 1
    Title.BorderSizePixel = 0
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.Size = UDim2.new(1, -10, 0, 25)
    Title.Font = Enum.Font.Arial
    Title.Text = Text
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextStrokeColor3 = Color3.fromRGB(200, 200, 200)
    Title.TextSize = 14
    Title.TextXAlignment = Enum.TextXAlignment.Left
    
    Expand.Name = "Minimize"
    Expand.Parent = Cheat
    Expand.AnchorPoint = Vector2.new(1, 0)
    Expand.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Expand.BackgroundTransparency = 1
    Expand.BorderSizePixel = 0
    Expand.Position = UDim2.new(1, 0, 0, 0)
    Expand.Size = UDim2.new(0, 25, 0, 25)
    Expand.Font = Enum.Font.Arial
    Expand.Text = "+"
    Expand.TextColor3 = Color3.fromRGB(255, 255, 255)
    Expand.TextSize = 14

    Options.Name = "Options"
    Options.Parent = Cheat
    Options.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Options.BackgroundTransparency = 1.000
    Options.Position = UDim2.new(0, 0, 0, 25)
    Options.Size = UDim2.new(1, 0, 0, 0)
    Options.ClipsDescendants = true
    
    UIListLayout.Parent = Options
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

    if HoverGlow then
        Cheat.MouseEnter:Connect(function()
            TweenService:Create(Title, TweenInfo.new(0.2), {TextStrokeTransparency = 0.8}):Play()
        end)
        
        Cheat.MouseLeave:Connect(function()
            TweenService:Create(Title, TweenInfo.new(0.2), {TextStrokeTransparency = 1}):Play()
        end)
        
        Cheat.MouseButton1Down:Connect(function()
            TweenService:Create(Title, TweenInfo.new(0.2), {TextStrokeTransparency = 0.5}):Play()
        end)
        
        Cheat.MouseButton1Up:Connect(function()
            TweenService:Create(Title, TweenInfo.new(0.2), {TextStrokeTransparency = 1}):Play()
        end)
    end

    return Cheat
end

function CreateOptionTemplate(Name, HoverGlow)
    local Option = Instance.new("TextButton")
    local Title = Instance.new("TextLabel")
    local CheatObjects = Instance.new("Frame")
	local Field

    Option.Name = Name
    Option.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Option.BackgroundTransparency = 1.000
    Option.Size = UDim2.new(1, 0, 0, 25)
    Option.Font = Enum.Font.SourceSans
    Option.Text = ""
    Option.TextColor3 = Color3.fromRGB(0, 0, 0)
    Option.TextSize = 14.000

    Title.Name = "Title"
    Title.Parent = Option
    Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Title.BackgroundTransparency = 1.000
    Title.BorderSizePixel = 0
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.Size = UDim2.new(0.5, -10, 0, 25)
    Title.Font = Enum.Font.Arial
    Title.Text = Name
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextStrokeColor3 = Color3.fromRGB(200, 200, 200)
    Title.TextSize = 14.000
    Title.TextXAlignment = Enum.TextXAlignment.Left

    CheatObjects.Name = "CheatObjects"
    CheatObjects.Parent = Option
    CheatObjects.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    CheatObjects.BackgroundTransparency = 1.000
    CheatObjects.Position = UDim2.new(0.5, 0, 0, 0)
    CheatObjects.Size = UDim2.new(0.5, 0, 0, 25)

    if HoverGlow then
        Option.MouseEnter:Connect(function()
            TweenService:Create(Title, TweenInfo.new(0.2), {TextStrokeTransparency = 0.8}):Play()
        end)
        
        Option.MouseLeave:Connect(function()
            TweenService:Create(Title, TweenInfo.new(0.2), {TextStrokeTransparency = 1}):Play()
        end)
        
        Option.MouseButton1Down:Connect(function()
            TweenService:Create(Title, TweenInfo.new(0.2), {TextStrokeTransparency = 0.5}):Play()
        end)
        
        Option.MouseButton1Up:Connect(function()
            TweenService:Create(Title, TweenInfo.new(0.2), {TextStrokeTransparency = 1}):Play()
        end)
    end

    return Option
end

function Library.new()
    local LibraryClass = {}

    LibraryClass.ScreenGui = Instance.new("ScreenGui")

    do
        LibraryClass.ScreenGui.Name = Library.Name .. "UI"
        LibraryClass.ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
        LibraryClass.ScreenGui.ResetOnSpawn = false
        LibraryClass.ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    end

    function LibraryClass.AddCategory(Name, Callback, Data)
        local LibraryCategory = {}
		
		LibraryCategory.Enabled = Data and Data.Enabled or false
        LibraryCategory.Minimized = false
        LibraryCategory.Frame = Instance.new("Frame")
        
        local Minimize = Instance.new("TextButton")
		
        do
            local Title = Instance.new("TextLabel")
            local Line = Instance.new("Frame")
            local Content = Instance.new("Frame")
            local UIListLayout = Instance.new("UIListLayout")

            LibraryCategory.Frame.Name = Name
            LibraryCategory.Frame.Parent = LibraryClass.ScreenGui
            LibraryCategory.Frame.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
            LibraryCategory.Frame.BorderSizePixel = 0
            LibraryCategory.Frame.Position = UDim2.new(0, 5, 0, 5)
            LibraryCategory.Frame.Size = UDim2.new(0, 200, 0, 30)

            Title.Name = "Title"
            Title.Parent = LibraryCategory.Frame
            Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Title.BackgroundTransparency = 1
            Title.Size = UDim2.new(1, 0, 0, 30)
            Title.Font = Enum.Font.Arial
            Title.Text = Name
            Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    		Title.TextStrokeColor3 = Color3.fromRGB(200, 200, 200)
            Title.TextSize = 14
            Title.TextStrokeColor3 = Color3.fromRGB(106, 106, 106)
            Title.TextStrokeTransparency = 1

            Minimize.Name = "Minimize"
            Minimize.Parent = Title
            Minimize.AnchorPoint = Vector2.new(1, 0)
            Minimize.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Minimize.BackgroundTransparency = 1
            Minimize.Position = UDim2.new(1, 0, 0, 0)
            Minimize.Size = UDim2.new(0, 30, 0, 30)
            Minimize.Font = Enum.Font.Arial
            Minimize.Text = "-"
            Minimize.TextColor3 = Color3.fromRGB(255, 243, 243)
            Minimize.TextSize = 14

            Line.Name = "Line"
            Line.Parent = LibraryCategory.Frame
            Line.AnchorPoint = Vector2.new(0, 1)
            Line.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Line.BorderSizePixel = 0
            Line.Position = UDim2.new(0, 0, 0, 30)
            Line.Size = UDim2.new(1, 0, 0, 1)

            Content.Name = "Content"
            Content.Parent = LibraryCategory.Frame
            Content.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Content.BackgroundTransparency = 1
            Content.Position = UDim2.new(0, 0, 0, 32)
            Content.Size = UDim2.new(1, 0, 1, -32)
            Content.ClipsDescendants = true

            UIListLayout.Parent = Content
            UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        end

        function LibraryCategory.AddCheat(Name, Callback, Options)
            local LibraryCheat = {}

            LibraryCheat.Enabled = (Options and Options.Enabled) or false
            LibraryCheat.Minimized = (Options and Options.Minimized) or true
            LibraryCheat.Frame = CreateCheatTemplate(Name)

            function LibraryCheat.AddOption(Type, Name, Callback, Options)
                local LibraryOption = {}

                if Type == "Label" then
                    local Option = CreateOptionTemplate(Name)

                    Option.CheatObjects:Destroy()
                    Option.Title.Size = UDim2.new(1, -10, 0, 25)

                    LibraryOption.Frame = Option
                elseif Type == "Button" then
                    local Option = CreateOptionTemplate(Name, true)
                    
                    Option.CheatObjects:Destroy()
                    Option.Title.Size = UDim2.new(1, -10, 0, 25)

                    if Callback and type(Callback) == "function" then
                        Option.MouseButton1Click:Connect(function()
                            local S, E = pcall(function()
                                Callback()
                            end)

                            if not S then warn(E) end
                        end)
                    end

                    LibraryOption.Frame = Option
                elseif Type == "Toggle" then
                    LibraryOption.Enabled = (Options and Options.Enabled) or false

                    local Option = CreateOptionTemplate(Name, true)
                    local State = Instance.new("TextLabel")

                    Option.Title.Size = UDim2.new(1, -10, 0, 25)
                    Option.CheatObjects.Size = UDim2.new(0, 25, 0, 25)
                    Option.CheatObjects.Position = UDim2.new(1, -25, 0, 0)

                    State.Name = "State"
                    State.Parent = Option.CheatObjects
                    State.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    State.BackgroundTransparency = 1
                    State.Size = UDim2.new(1, 0, 1, 0)
                    State.Font = Enum.Font.Arial
                    State.TextSize = 9

                    State.Text = LibraryOption.Enabled and Library.ToggleSettings.EnabledText or Library.ToggleSettings.DisabledText
                    State.TextColor3 = LibraryOption.Enabled and Library.ToggleSettings.EnabledColor or Library.ToggleSettings.DisabledColor
                    
                    Option.MouseButton1Click:Connect(function()
                        LibraryOption.Enabled = not LibraryOption.Enabled

                        State.Text = LibraryOption.Enabled and Library.ToggleSettings.EnabledText or Library.ToggleSettings.DisabledText
                        State.TextColor3 = LibraryOption.Enabled and Library.ToggleSettings.EnabledColor or Library.ToggleSettings.DisabledColor

	                    if Callback and type(Callback) == "function" then
                            local S, E = pcall(function()
                                Callback(LibraryOption.Enabled)
                            end)

                            if not S then warn(E) end
	                    end
                    end)

                    LibraryOption.Frame = Option
                elseif Type == "Textbox" then
					LibraryOption.Value = ""
					LibraryOption.Placeholder = (Options and Options.Placeholder) or "String"
					
					local Option = CreateOptionTemplate(Name, true)
					local Field = Instance.new("TextBox")
					
					Field.Name = "Field"
					Field.Parent = Option.CheatObjects
					Field.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
					Field.BorderSizePixel = 0
					Field.Size = UDim2.new(1, -10, 1, 0)
					Field.TextXAlignment = Enum.TextXAlignment.Right
					Field.Font = Enum.Font.Arial
					Field.PlaceholderColor3 = Color3.fromRGB(147, 147, 147)
					Field.PlaceholderText = LibraryOption.Placeholder
					Field.Text = ""
					Field.TextColor3 = Color3.fromRGB(255, 255, 255)
					Field.TextSize = 14.000
					Field.TextStrokeColor3 = Color3.fromRGB(150, 150, 150)
					Field.TextWrapped = true
					
                    Option.MouseButton1Click:Connect(function()
						Field:CaptureFocus()
                    end)

					if Callback and type(Callback) == "function" then
						Field.FocusLost:Connect(function()
	                        local S, E = pcall(function()
	                            Callback(Field.Text)
	                        end)
	
	                        if not S then warn(E) end
						end)
                    end

                    LibraryOption.Frame = Option
                end

                LibraryOption.Frame.Parent = LibraryCheat.Frame.Options

                if not LibraryCategory.Minimized then 
                    LibraryCategory.Frame.Size = UDim2.new(0, 250, 0, 30 + 2 + 100)
                end

                LibraryCheat.Frame.Parent = LibraryCategory.Frame.Content

                return LibraryOption
            end

            LibraryCheat.Frame.Minimize.MouseButton1Click:Connect(function()
                LibraryCheat.Minimized = not LibraryCheat.Minimized
                LibraryCheat.Frame.Minimize.Text = LibraryCheat.Minimized and "+" or "-"

                if LibraryCheat.Minimized then
                    LibraryCheat.Frame.Size = UDim2.new(0, 250, 0, 25)
                    LibraryCheat.Frame.Options.Size = UDim2.new(0, 250, 0, 0)
                else
                    LibraryCheat.Frame.Size = UDim2.new(0, 250, 0, 25 + LibraryCheat.Frame.Options.UIListLayout.AbsoluteContentSize.Y)
                    LibraryCheat.Frame.Options.Size = UDim2.new(0, 250, 0, LibraryCheat.Frame.Options.UIListLayout.AbsoluteContentSize.Y)
                end

                LibraryCategory.Frame:TweenSize(LibraryCategory.Minimized and UDim2.new(0, 250, 0, 30) or UDim2.new(0, 250, 0, 30 + 2 + LibraryCategory.Frame.Content.UIListLayout.AbsoluteContentSize.Y), "Out", "Sine", 0.2, true)
            end)

            LibraryCheat.Frame.Minimize.Text = LibraryCheat.Minimized and "+" or "-"

            if LibraryCheat.Minimized then
                LibraryCheat.Frame.Size = UDim2.new(0, 250, 0, 25)
                LibraryCheat.Frame.Options.Size = UDim2.new(0, 250, 0, 0)
            else
                LibraryCheat.Frame.Size = UDim2.new(0, 250, 0, 25 + LibraryCheat.Frame.Options.UIListLayout.AbsoluteContentSize.Y)
                LibraryCheat.Frame.Options.Size = UDim2.new(0, 250, 0, LibraryCheat.Frame.Options.UIListLayout.AbsoluteContentSize.Y)
            end

            return LibraryCheat
        end

        Minimize.MouseButton1Click:Connect(function()
            LibraryCategory.Minimized = not LibraryCategory.Minimized

            LibraryCategory.Frame.Title.Minimize.Text = LibraryCategory.Minimized and "+" or "-"
            LibraryCategory.Frame:TweenSize(LibraryCategory.Minimized and UDim2.new(0, 250, 0, 30) or UDim2.new(0, 250, 0, 30 + 2 + LibraryCategory.Frame.Content.UIListLayout.AbsoluteContentSize.Y) , "Out", "Sine", 0.2, true)
        end)

        LibraryCategory.Frame.Title.Minimize.Text = LibraryCategory.Minimized and "+" or "-"
        LibraryCategory.Frame.Size = LibraryCategory.Minimized and UDim2.new(0, 250, 0, 30) or UDim2.new(0, 250, 0, 30 + 2 + LibraryCategory.Frame.Content.UIListLayout.AbsoluteContentSize.Y) 

        return LibraryCategory
    end

    return LibraryClass
end

local Category = Library.AddCategory("hi")
local Cheat = Category.AddCheat("Epic hack", function() print("") end)
local Option = Cheat.AddOption("Label", "Label")
local Option = Cheat.AddOption("Button", "Button", function() print("Button") end)
local Option = Cheat.AddOption("Toggle", "Toggle", function(State) print("Toggle", State) end)
local Option = Cheat.AddOption("Textbox", "Textbox", function(Text) print("Textbox", Text) end)
local Cheat = Category.AddCheat("Epic hack", function() print("") end)
local Option = Cheat.AddOption("Label", "Label")
local Option = Cheat.AddOption("Button", "Button", function() print("Button") end)
local Option = Cheat.AddOption("Toggle", "Toggle", function(State) print("Toggle", State) end)
local Option = Cheat.AddOption("Textbox", "Textbox", function(Text) print("Textbox", Text) end)