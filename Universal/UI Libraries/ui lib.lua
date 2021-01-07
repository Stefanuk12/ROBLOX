local Library = {Count = 0, Toggled = true, Queue = {}, RainbowTable = {}}
local dragger = {}; do
    -- // Drag Function

    local mouse        = game:GetService("Players").LocalPlayer:GetMouse()
    local inputService = game:GetService('UserInputService')
    local heartbeat    = game:GetService("RunService").Heartbeat
    function dragger.new(frame)
        local s, event = pcall(function()
            return frame.MouseEnter
        end)
    
        if s then
            frame.Active = true
                
            event:connect(function()
                local input = frame.InputBegan:connect(function(key)
                    if key.UserInputType == Enum.UserInputType.MouseButton1 then
                        local objectPosition = Vector2.new(mouse.X - frame.AbsolutePosition.X, mouse.Y - frame.AbsolutePosition.Y)
                        while heartbeat:wait() and inputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
                            pcall(function()
                                frame:TweenPosition(UDim2.new(0, mouse.X - objectPosition.X + (frame.Size.X.Offset * frame.AnchorPoint.X), 0, mouse.Y - objectPosition.Y + (frame.Size.Y.Offset * frame.AnchorPoint.Y)), 'Out', 'Linear', 0.1, true)
                            end)
                        end
                    end
                end)
    
                local leave
                leave = frame.MouseLeave:connect(function()
                    input:disconnect()
                    leave:disconnect()
                end)
            end)
        end
    end

    -- // Rainbow Table Function

    game:GetService("RunService"):BindToRenderStep("Rainbow", 1000, function()
        local Hue = tick() % Library.Options.LineSmoothness / Library.Options.LineSmoothness
        for _,object in pairs(Library.RainbowTable) do
            object.BackgroundColor3 = Color3.fromHSV(Hue, 1, 1)
        end
    end)

    -- // Customization

    default = {
        Name = 'Valiant',

        Font1 = Enum.Font.Arial,
        Font2 = Enum.Font.SourceSans,
        LineColour = Color3.fromRGB(255, 255, 255),
        LineSmoothness = 2,
        BorderSizePixel = 0,

        NormalBackgroundColor3 = Color3.fromRGB(35, 35, 35),
        ButtonBackgroundColor3 = Color3.fromRGB(25, 25, 25),
        LabelBackgroundColor3 = Color3.fromRGB(45, 45, 45),
        BorderColor3 = Color3.fromRGB(255, 255, 255),

        CategorySize = UDim2.new(0, 250, 0, 32),
        LinePosition = UDim2.new(0, 0, 0, 32),

        CheatEnabledColor = Color3.fromRGB(216, 121, 153),
        CheatDisabledColor = Color3.fromRGB(255, 255, 255),

        ToggleEnabledText = "YES",
        ToggleDisabledText = "NO",
        ToggleEnabledColor = Color3.fromRGB(94, 255, 35),
        ToggleDisabledColor = Color3.fromRGB(255, 41, 41),

        KeyCode = Enum.KeyCode.RightControl,
    }
    Library.Options = setmetatable({}, {__index = default})

    -- // UI Dismiss/Assemble

    game:GetService('UserInputService').InputBegan:connect(function(key, gpe)
        if (not gpe) then
            if key.KeyCode == Library.Options.KeyCode then
                Library.Toggled = not Library.Toggled;
                for i, data in next, Library.Queue do
                    local pos = (Library.Toggled and data.p or UDim2.new(-1, 0, -0.5,0))
                    if data.w then
                        data.w:TweenPosition(pos, (Library.Toggled and 'Out' or 'In'), 'Quad', 0.15, true)
                        wait();
                    end
                end
            end
        end
    end)

    -- // Library Creation

    local TweenService = game:GetService("TweenService")

    function CreateCheatTemplate(Text, HoverGlow)
        local Cheat = Instance.new("TextButton")
        local TitleButton = Instance.new("TextButton")
        local Expand = Instance.new("TextButton")
        local Options = Instance.new("Frame")
        local UIListLayout = Instance.new("UIListLayout")
        
        Cheat.Name = "Cheat"
        Cheat.AutoButtonColor = false
        Cheat.BackgroundColor3 = Library.Options.NormalBackgroundColor3
        Cheat.BackgroundTransparency = 0
        Cheat.Size = UDim2.new(1, 0, 0, 25)
        Cheat.Font = Library.Options.Font2
        Cheat.Text = ""
        Cheat.TextColor3 = Color3.fromRGB(0, 0, 0)
        Cheat.TextSize = 14
        
        TitleButton.Name = "TitleButton"
        TitleButton.AutoButtonColor = false
        TitleButton.Parent = Cheat
        TitleButton.BackgroundColor3 = Library.Options.ButtonBackgroundColor3
        TitleButton.BackgroundTransparency = 0
        TitleButton.Position = UDim2.new(0, 0, 0, 0)
        TitleButton.Size = UDim2.new(1, 0, 0, 25)
        TitleButton.Font = Library.Options.Font1
        TitleButton.Text = "  "..Text
        TitleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        TitleButton.TextStrokeColor3 = Color3.fromRGB(200, 200, 200)
        TitleButton.TextSize = 14
        TitleButton.TextXAlignment = Enum.TextXAlignment.Left
        
        Expand.Name = "Minimize"
        Expand.Parent = Cheat
        Expand.AnchorPoint = Vector2.new(1, 0)
        Expand.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Expand.BackgroundTransparency = 1
        Expand.Position = UDim2.new(1, 0, 0, 0)
        Expand.Size = UDim2.new(0, 25, 0, 25)
        Expand.Font = Library.Options.Font1
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
                TweenService:Create(TitleButton, TweenInfo.new(0.2), {TextStrokeTransparency = 0.8}):Play()
            end)
            
            Cheat.MouseLeave:Connect(function()
                TweenService:Create(TitleButton, TweenInfo.new(0.2), {TextStrokeTransparency = 1}):Play()
            end)
            
            Cheat.MouseButton1Down:Connect(function()
                TweenService:Create(TitleButton, TweenInfo.new(0.2), {TextStrokeTransparency = 0.5}):Play()
            end)
            
            Cheat.MouseButton1Up:Connect(function()
                TweenService:Create(TitleButton, TweenInfo.new(0.2), {TextStrokeTransparency = 1}):Play()
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
        Option.AutoButtonColor = false
        Option.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Option.BackgroundTransparency = 1.000
        Option.Size = UDim2.new(1, 0, 0, 25)
        Option.Font = Library.Options.Font2
        Option.Text = ""
        Option.TextColor3 = Color3.fromRGB(0, 0, 0)
        Option.TextSize = 14.000

        Title.Name = "Title"
        Title.Parent = Option
        Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Title.BackgroundTransparency = 1.000
        Title.Position = UDim2.new(0, 10, 0, 0)
        Title.Size = UDim2.new(0.5, -10, 0, 25)
        Title.Font = Library.Options.Font1
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
            LibraryClass.ScreenGui.Name = Library.Options.Name
            LibraryClass.ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
            LibraryClass.ScreenGui.ResetOnSpawn = false
            LibraryClass.ScreenGui.Parent = game.CoreGui
        end

        function LibraryClass.AddWindow(Name, Callback, Data)
            local LibraryCategory = {}

            Library.Count = Library.Count + 1 
            LibraryCategory.Enabled = Data and Data.Enabled or false
            LibraryCategory.Minimized = true
            LibraryCategory.Frame = Instance.new("Frame")
            
            local Minimize = Instance.new("TextButton")
            
            do
                local Title = Instance.new("TextLabel")
                local Line = Instance.new("Frame")
                local Content = Instance.new("Frame")
                local UIListLayout = Instance.new("UIListLayout")

                LibraryCategory.Frame.Name = Name
                LibraryCategory.Frame.Parent = LibraryClass.ScreenGui
                LibraryCategory.Frame.BackgroundColor3 = Library.Options.NormalBackgroundColor3
                LibraryCategory.Frame.BorderSizePixel = 0
                LibraryCategory.Frame.BorderColor3 = Library.Options.BorderColor3
                LibraryCategory.Frame.Position = UDim2.new(0, (5 + (300 * Library.Count) - 260), 0, 0)
                LibraryCategory.Frame.Size = Library.Options.CategorySize

                Title.Name = "Title"
                Title.Parent = LibraryCategory.Frame
                Title.BackgroundColor3 = Library.Options.NormalBackgroundColor3
                Title.BackgroundTransparency = 1
                Title.Size = UDim2.new(1, 0, 0, 30)
                Title.Font = Library.Options.Font1
                Title.Text = Name
                Title.BorderSizePixel = 0
                Title.TextColor3 = Color3.fromRGB(255, 255, 255)
                Title.TextStrokeColor3 = Color3.fromRGB(200, 200, 200)
                Title.TextSize = 14
                Title.TextStrokeColor3 = Color3.fromRGB(106, 106, 106)
                Title.TextStrokeTransparency = 1

                Minimize.Name = "Minimize"
                Minimize.Parent = Title
                Minimize.AnchorPoint = Vector2.new(1, 0)
                Minimize.BackgroundColor3 = Library.Options.NormalBackgroundColor3
                Minimize.BackgroundTransparency = 1
                Minimize.BorderSizePixel = 0
                Minimize.Position = UDim2.new(1, 0, 0, 0)
                Minimize.Size = UDim2.new(0, 30, 0, 30)
                Minimize.Font = Library.Options.Font1
                Minimize.Text = "-"
                Minimize.TextColor3 = Color3.fromRGB(255, 243, 243)
                Minimize.TextSize = 14

                Line.Name = "Line"
                Line.Parent = LibraryCategory.Frame
                Line.AnchorPoint = Vector2.new(0, 1)
                Line.BackgroundColor3 = (Library.Options.LineColor ~= "rainbow" and Library.Options.LineColor or Color3.new())
                Line.BorderSizePixel = 0
                Line.Position = Library.Options.LinePosition
                Line.Size = UDim2.new(1, 0, 0, 1)

                Content.Name = "Content"
                Content.Parent = LibraryCategory.Frame
                Content.BackgroundColor3 = Library.Options.NormalBackgroundColor3
                Content.BackgroundTransparency = 1
                Content.BorderColor3 = Library.Options.BorderColor3
                Content.BorderSizePixel = Library.Options.BorderSizePixel
                Content.BorderColor3 = Library.Options.BorderColor3
                Content.Position = UDim2.new(0, 0, 0, 32)
                Content.Size = UDim2.new(1, 0, 1, -32)
                Content.ClipsDescendants = true

                UIListLayout.Parent = Content
                UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                dragger.new(LibraryCategory.Frame)
                if Library.Options.LineColour == "rainbow" then
                    table.insert(Library.RainbowTable, Line)
                end
            end

            
            
            function LibraryCategory.AddButton(Name, Callback, Options)
                local LibraryCheat = {}

                LibraryCheat.Enabled = (Options and Options.Enabled) or false
                LibraryCheat.Minimized = (Options and Options.Minimized) or true
                LibraryCheat.Frame = CreateCheatTemplate(Name, true)

                local cheatoggle = false
                if Callback and type(Callback) == "function" then
                    LibraryCheat.Frame.TitleButton.MouseButton1Click:Connect(function()
                        local S, E = pcall(function()
                            cheatoggle = not cheatoggle
                            LibraryCheat.Frame.TitleButton.TextColor3 = (cheatoggle and Library.Options.CheatEnabledColor  or Library.Options.CheatDisabledColor)
                            Callback()
                        end)

                        if not S then warn(E) end
                    end)
                end

                function LibraryCheat.AddButtonOption(Type, Name, Callback, Options)
                    local LibraryOption = {}

                    if Type == "Label" then
                        local Option = CreateOptionTemplate(Name)

                        Option.CheatObjects:Destroy()
                        Option.Title.Size = UDim2.new(0, 250, 0, 25)
                        Option.Title.TextXAlignment = 2
                        Option.Size = UDim2.new(1, -10, 0, 25)
                        Option.Title.Position = UDim2.new(0, 0, 0, 0)
                        Option.Title.BackgroundColor3 = Library.Options.LabelBackgroundColor3
                        Option.Title.BackgroundTransparency = 0

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
                        Option.Title.Size = UDim2.new(1, -10, 0, 25)
                        Option.CheatObjects.Size = UDim2.new(0, 25, 0, 25)
                        Option.CheatObjects.Position = UDim2.new(1, -25, 0, 0)

                        local State = Instance.new("TextLabel")
                        State.Name = "State"
                        State.Parent = Option.CheatObjects
                        State.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        State.BackgroundTransparency = 1
                        State.Size = UDim2.new(1, 0, 1, 0)
                        State.Font = Library.Options.Font1
                        State.TextSize = 9
                        State.Text = (LibraryOption.Enabled and Library.Options.ToggleEnabledText or Library.Options.ToggleDisabledText)
                        State.TextColor3 = (LibraryOption.Enabled and Library.Options.ToggleEnabledColor or Library.Options.ToggleDisabledColor)

                        Option.MouseButton1Click:Connect(function()
                            LibraryOption.Enabled = not LibraryOption.Enabled

                            State.Text = LibraryOption.Enabled and Library.Options.ToggleEnabledText or Library.Options.ToggleDisabledText
                            State.TextColor3 = LibraryOption.Enabled and Library.Options.ToggleEnabledColor or Library.Options.ToggleDisabledColor

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
                        Field.BackgroundColor3 = Library.Options.NormalBackgroundColor3
                        Field.Size = UDim2.new(1, -10, 1, 0)
                        Field.TextXAlignment = Enum.TextXAlignment.Right
                        Field.Font = Library.Options.Font1
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
                    LibraryCheat.Frame.Minimize.Text = "v"

                    if LibraryCheat.Minimized then
                        local TweenService = game:GetService"TweenService"
                        local tween = TweenService:Create(
                            LibraryCheat.Frame.Minimize,
                            TweenInfo.new(0.2),
                            {
                                Rotation = 0
                            }
                        )
                        tween:Play()
                        LibraryCheat.Frame.Size = UDim2.new(0, 250, 0, 25)
                        LibraryCheat.Frame.Options.Size = UDim2.new(0, 250, 0, 0)
                    else
                        local TweenService = game:GetService"TweenService"
                        local tween = TweenService:Create(
                            LibraryCheat.Frame.Minimize,
                            TweenInfo.new(0.2),
                            {
                                Rotation = 180
                            }
                        )
                        tween:Play()
                        LibraryCheat.Frame.Size = UDim2.new(0, 250, 0, 25 + LibraryCheat.Frame.Options.UIListLayout.AbsoluteContentSize.Y)
                        LibraryCheat.Frame.Options.Size = UDim2.new(0, 250, 0, LibraryCheat.Frame.Options.UIListLayout.AbsoluteContentSize.Y)
                    end

                    LibraryCategory.Frame:TweenSize(LibraryCategory.Minimized and Library.Options.CategorySize or UDim2.new(0, 250, 0, 30 + 2 + LibraryCategory.Frame.Content.UIListLayout.AbsoluteContentSize.Y), "Out", "Sine", 0.2, true)
                end)

                LibraryCheat.Frame.Minimize.Text = "v"

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
                LibraryCategory.Frame:TweenSize(LibraryCategory.Minimized and Library.Options.CategorySize or UDim2.new(0, 250, 0, 30 + 2 + LibraryCategory.Frame.Content.UIListLayout.AbsoluteContentSize.Y) , "Out", "Sine", 0.2, true)
            end)

            LibraryCategory.Frame.Title.Minimize.Text = LibraryCategory.Minimized and "+" or "-"
            LibraryCategory.Frame.Size = LibraryCategory.Minimized and Library.Options.CategorySize or UDim2.new(0, 250, 0, 30 + 2 + LibraryCategory.Frame.Content.UIListLayout.AbsoluteContentSize.Y) 
            
            table.insert(Library.Queue, {
                w = LibraryCategory.Frame;
                p = LibraryCategory.Frame.Position;
            })

            return LibraryCategory
        end

        return LibraryClass
    end
end

--[[// Documentation

    local Library = Library.new()
    local Category = Library.AddWindow(Text)
    local Cheat = Category.AddButton(ButtonName, CallBack)
    local Option = Cheat.AddButtonOption(Type, Text)

    ButtonOptions Types = 
        - Label
        - Button
        - Toggle
        - Textbox
    
    Library.Options = 
        Name - Default: 'Valiant'

        Font1 - Default: Enum.Font.Arial
        Font2 - Default: Enum.Font.SourceSans
        LineColour - Default: Color3.fromRGB(255, 255, 255)
        BorderSizePixel - Default: 0

        NormalBackgroundColor3 - Default: Color3.fromRGB(35, 35, 35)
        ButtonBackgroundColor3 - Default: Color3.fromRGB(25, 25, 25)
        LabelBackgroundColor3 - Default: Color3.fromRGB(45, 45, 45)

        CategorySize - Default: UDim2.new(0, 250, 0, 32)
        LinePosition - Default: UDim2.new(0, 0, 0, 32)

        CheatEnabledColor - Default: Color3.fromRGB(216, 121, 153)
        CheatDisabledColor - Default: Color3.fromRGB(255, 255, 255)

        ToggleEnabledText - Default: "YES"
        ToggleDisabledText - Default: "NO"
        ToggleEnabledColor - Default: Color3.fromRGB(94, 255, 35)
        ToggleDisabledColor - Default: Color3.fromRGB(255, 41, 41)

        KeyCode - Default: Enum.KeyCode.RightControl

    Examples: 
        local Library = Library.new()
        local Category = Library.AddWindow("hi")
        local Cheat = Category.AddButton("> Epic hack", function() print("a") end )
        local Option = Cheat.AddButtonOption("Label", "Label")
        local Option = Cheat.AddButtonOption("Button", "Button", function() print("Button") end)
        local Option = Cheat.AddButtonOption("Toggle", "Toggle", function(State) print("Toggle", State) end)
        local Option = Cheat.AddButtonOption("Textbox", "Textbox", function(Text) print("Textbox", Text) end)

//--Documentation]]

Library.Options.LineColour = "rainbow"
local Library = Library.new()
local Category = Library.AddWindow("hi")
local Cheat = Category.AddButton("> Epic hack", function() print("a") end )
local Option = Cheat.AddButtonOption("Label", "Label")
local Option = Cheat.AddButtonOption("Button", "Button", function() print("Button") end)
local Option = Cheat.AddButtonOption("Toggle", "Toggle", function(State) print("Toggle", State) end)
local Option = Cheat.AddButtonOption("Textbox", "Textbox", function(Text) print("Textbox", Text) end)
local Cheat = Category.AddButton("> Epic hack", function() print("a") end )
local Option = Cheat.AddButtonOption("Label", "Label")
local Option = Cheat.AddButtonOption("Button", "Button", function() print("Button") end)
local Option = Cheat.AddButtonOption("Toggle", "Toggle", function(State) print("Toggle", State) end)
local Option = Cheat.AddButtonOption("Textbox", "Textbox", function(Text) print("Textbox", Text) end)