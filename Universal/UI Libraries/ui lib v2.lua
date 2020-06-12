local ValiantUI = {Count = 0, Queue = {}, Callbacks = {}, RT = {}, Toggled = true, Binds = {}}
local Defaults
do
    local Dragger = {}
    do
        local mouse = game:GetService("Players").LocalPlayer:GetMouse()
        local inputService = game:GetService('UserInputService')
        local heartbeat = game:GetService("RunService").Heartbeat
        function Dragger.new(frame)
            local s, event = pcall(function()
                return frame.MouseEnter
            end)
            
            if s then
                frame.Active = true;
                        
                event:Connect(function()
                    local input = frame.InputBegan:Connect(function(key)
                        if key.UserInputType == Enum.UserInputType.MouseButton1 then
                            local objectPosition = Vector2.new(mouse.X - frame.AbsolutePosition.X, mouse.Y - frame.AbsolutePosition.Y);
                            while heartbeat:wait() and inputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
                                pcall(function()
                                    frame:TweenPosition(UDim2.new(0, mouse.X - objectPosition.X + (frame.Size.X.Offset * frame.AnchorPoint.X), 0, mouse.Y - objectPosition.Y + (frame.Size.Y.Offset * frame.AnchorPoint.Y)), 'Out', 'Linear', 0.1, true);
                                end)
                            end
                        end
                    end)
            
                    local leave;
                    leave = frame.MouseLeave:Connect(function()
                        input:Disconnect();
                        leave:Disconnect();
                    end)
                end)
            end
        end
        game:GetService('UserInputService').InputBegan:Connect(function(key, gpe)
            if (not gpe) then
                if key.KeyCode == Enum.KeyCode.RightControl then
                    ValiantUI.Toggled = not ValiantUI.Toggled;
                    for i, data in next, ValiantUI.Queue do
                        local pos = (ValiantUI.Toggled and data.P or UDim2.new(-1, 0, -0.5,0))
                        data.W:TweenPosition(pos, (ValiantUI.Toggled and 'Out' or 'In'), 'Quad', 0.15, true)
                        wait();
                    end
                end
            end
        end)
    end
    

    local classes = {}
    do
        classes.__index = classes
        function classes.AddWindow(Name, Options)
            ValiantUI.Count = ValiantUI.Count + 1
            -- local VCategory = {}

            local newWindow = ValiantUI:Create('Frame', {
                Name = Name,
                Parent = ValiantUI.Object,
                BackgroundColor3 = ValiantUI.Options.NormalBackgroundColor3,
                BorderSizePixel = ValiantUI.Options.BorderSizePixel,
                BorderColor3 = ValiantUI.Options.BorderColor3,
                Position = UDim2.new(0, (5 + (300 * ValiantUI.Count) - 260), 0, 0),
                Size = ValiantUI.Options.WindowSize,
                ValiantUI:Create('TextLabel', {
                    Name = "Title",
                    BackgroundColor3 = ValiantUI.Options.NormalBackgroundColor3,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, ValiantUI.Options.WindowSize.Y.Offset),
                    Font = ValiantUI.Options.Font1,
                    Text = Name,
                    BorderSizePixel = 0,
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                    TextSize = 14,
                    TextStrokeColor3 = Color3.fromRGB(106, 106, 106),
                    TextStrokeTransparency = 1,
                    ValiantUI:Create('TextButton', {
                        Name = "Minimise",
                        AnchorPoint = Vector2.new(1, 0),
                        BackgroundColor3 = ValiantUI.Options.NormalBackgroundColor3,
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        Position = UDim2.new(1, 0, 0, 0),
                        Size = UDim2.new(0, ValiantUI.Options.WindowSize.Y.Offset, 0, ValiantUI.Options.WindowSize.Y.Offset),
                        Font = ValiantUI.Options.Font1,
                        Text = "-",
                        TextColor3 = Color3.fromRGB(255, 243, 243),
                        TextSize = 14
                    }),
                }),   
                ValiantUI:Create('Frame', {
                    Name = "Line",
                    AnchorPoint = Vector2.new(0, 1),
                    BackgroundColor3 = (ValiantUI.Options.LineColour ~= "rainbow" and ValiantUI.Options.LineColour or Color3.new()),
                    BorderSizePixel = 0,
                    Position = ValiantUI.Options.LinePosition,
                    Size = UDim2.new(1, 0, 0, 1)
                }),
                ValiantUI:Create('Frame', {
                    Name = "Content",
                    BackgroundColor3 = ValiantUI.Options.NormalBackgroundColor3,
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0, 0, 0, ValiantUI.Options.WindowSize.Y.Offset),
                    Size = UDim2.new(1, 0, 1, -(ValiantUI.Options.WindowSize.Y.Offset)),
                    ClipsDescendants = true,
                    ValiantUI:Create('UIListLayout', {
                        SortOrder = Enum.SortOrder.LayoutOrder
                    })
                })          
            })
            if ValiantUI.Options.LineColour == "rainbow" then
                table.insert(ValiantUI.RT, newWindow:FindFirstChild('Line'))
            end

            local Window = setmetatable({
                Count = 0,
                Object = newWindow,
                Toggled = true,
                Flags = {},
            }, classes)

            local Content = setmetatable({
                Enabled = false,
                Minimised = true,
                Object = Window.Object:FindFirstChild("Content"),
            }, classes)

            table.insert(ValiantUI.Queue, {
                W = Window.Object,
                P = Window.Object.Position,
            })

            newWindow:FindFirstChild("Title").Minimise.MouseButton1Click:Connect(function()
                Window.Toggled = not Window.Toggled
                newWindow:FindFirstChild("Title").Minimise.Text = Window.Toggled and "+" or "-"
                newWindow:TweenSize(Window.Toggled and ValiantUI.Options.WindowSize or UDim2.new(0, 250, 0, ValiantUI.Options.WindowSize.Y.Offset + newWindow:FindFirstChild("Content").UIListLayout.AbsoluteContentSize.Y), "Out", "Sine", 0.2, true)
            end)
            return Window
        end
    end
    function classes.AddCheatButton(Name, Options)
        local CheatButton = ValiantUI:Create('TextButton', {
            Name = "Cheat",
            AutoButtonColor = false,
            BackgroundColor3 = ValiantUI.Options.NormalBackgroundColor3,
            BackgroundTransparency = 0,
            Size = UDim2.new(1, 0, 0, ValiantUI.Options.WindowSize.Y.Offset - 5),
            Font = ValiantUI.Options.Font2,
            Text = "",
            BorderSizePixel = 0,
            Parent = self.Object
            ValiantUI:Create('TextButton', {
                Name = "TitleButton",
                AutoButtonColor = false,
                BackgroundColor3 = ValiantUI.Options.ButtonBackgroundColor3,
                BackgroundTransparency = 0,
                BorderSizePixel = 0
                Postition = UDim2.new(0, 0, 0, 0),
                Size = UDim2.new(1, 0, 0, ValiantUI.Options.WindowSize.Y.Offset - 5),
                Font = ValiantUI.Options.Font1,
                Text = Text,
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextStrokeColor3 = Color3.fromRGB(200, 200, 200),
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left
            }),
            ValiantUI:Create('TextButton', {
                Name = "Minimise/Expand",
                AnchorPoint = Vector2.new(1, 0),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Position = UDim2.new(1, 0, 0, 0),
                Size = UDim2.new(1, 0, 0, ValiantUI.Options.WindowSize.Y.Offset - 5),
                Font = ValiantUI.Options.Font1,
                Text = "+",
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextSize = 14,
            }),
            ValiantUI:Create('Frame', {
                Name = "Options",
                BackgroundColor3 = ValiantUI.Options.NormalBackgroundColor3,
                BackgroundTransparency = 1,
                BorderSizePixel = 0
                Position = UDim2.new(0, 0, 0, ValiantUI.Options.WindowSize.Y.Offset - 5),
                Size = UDim2.new(1, 0, 0, 0),
                ClipsDescendants = true,
                ValiantUI:Create('UIListLayout', {
                    SortOrder = Enum.SortOrder.LayoutOrder,
                }),
            }),
        })

        if ValiantUI.Options.HoverGlow then
            AddCheat.MouseEnter:Connect(function()
                TweenService:Create(AddCheat:FindFirstChild("TitleButton"), TweenInfo.new(0.2), {TextStrokeTransparency = 0.8}):Play()
            end)
            
            AddCheat.MouseLeave:Connect(function()
                TweenService:Create(AddCheat:FindFirstChild("TitleButton"), TweenInfo.new(0.2), {TextStrokeTransparency = 1}):Play()
            end)
            
            AddCheat.MouseButton1Down:Connect(function()
                TweenService:Create(AddCheat:FindFirstChild("TitleButton"), TweenInfo.new(0.2), {TextStrokeTransparency = 0.5}):Play()
            end)
            
            AddCheat.MouseButton1Up:Connect(function()
                TweenService:Create(AddCheat:FindFirstChild("TitleButton"), TweenInfo.new(0.2), {TextStrokeTransparency = 1}):Play()
            end)
        end

        local CheatDirectory = setmetatable({
            Object = CheatButton
        }, classes)

        return AddCheat
    end
    
    function classes.AddCheat(Name, Options)
        local CheatOption = ValiantUI:Create('TextButton', {
            Name = Name,
            AutoButtonColor = false,
            BackgroundColor3 = ValiantUI.Options.NormalBackgroundColor3,
            BackgroundTransparency = 1,
            BorderSizePixel = 0
            Size = UDim2.new(1, 0, 0, ValiantUI.Options.WindowSize.Y.Offset - 5),
            Font = ValiantUI.Options.Font2,
            Text = "",
            ValiantUI:Create('TextLabel', {
                Name = "Title",
                BackgroundColor3 = ValiantUI.Options.NormalBackgroundColor3,
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 10, 0, 0),
                Size = UDim2.new(0.5, -10, 0, ValiantUI.Options.WindowSize.Y.Offset - 5),
                Font = ValiantUI.Options.Font1,
                Text = Name,
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextStrokeColor3 = Color3.fromRGB(200, 200, 200)
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left,
            }),
            ValiantUI:Create('Frame', {
                Name = "CheatObjects",
                BackgroundColor3 = ValiantUI.Options.NormalBackgroundColor3,
                BackgroundTransparency = 1,
                Position = UDim2.new(0.5, 0, 0, 0)
                Size = UDim2.new(0.5, 0, 0, ValiantUI.Options.WindowSize.Y.Offset - 5),
            }),
        })
        if ValiantUI.Options.HoverGlow then
            CheatOption.MouseEnter:Connect(function()
                TweenService:Create(CheatOption:FindFirstChild("Title"), TweenInfo.new(0.2), {TextStrokeTransparency = 0.8}):Play()
            end)
            
            CheatOption.MouseLeave:Connect(function()
                TweenService:Create(CheatOption:FindFirstChild("Title"), TweenInfo.new(0.2), {TextStrokeTransparency = 1}):Play()
            end)
            
            CheatOption.MouseButton1Down:Connect(function()
                TweenService:Create(CheatOption:FindFirstChild("Title"), TweenInfo.new(0.2), {TextStrokeTransparency = 0.5}):Play()
            end)
            
            CheatOption.MouseButton1Up:Connect(function()
                TweenService:Create(CheatOption:FindFirstChild("Title"), TweenInfo.new(0.2), {TextStrokeTransparency = 1}):Play()
            end)
        end

        return CheatOption
    end

    function classes.OptionTemplate(Name)
        local newLabel = ValiantUI:Create('TextButton', {
            Name = Name,
            AutoButtonColor = false,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 0, ValiantUI.Options.WindowSize.Y.Offset - 5),
            Font = ValiantUI.Font.Font2,
            Text = "",
            ValiantUI:Create('TextLabel', {
                Name = "Title",
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 10, 0, 0),
                Size = UDim2.new(0.5, -10, 0, ValiantUI.Options.WindowSize.Y.Offset - 5),
                Font = ValiantUI.Options.Font1,
                Text = Name,
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextStrokeColor3 = Color3.fromRGB(200, 200, 200),
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left
            }),
            ValiantUI:Create('Frame', {
                Name = "CheatObjects",
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Position = UDim2.new(0.5, 0, 0, 0),
                Size = UDim2.new(0.5, 0, 0, ValiantUI.Options.WindowSize.Y.Offset - 5)
            })
        })

        if ValiantUI.Options.HoverGlow then
            newLabel.MouseEnter:Connect(function()
                TweenService:Create(newLabel:FindFirstChild("Title"), TweenInfo.new(0.2), {TextStrokeTransparency = 0.8}):Play()
            end)
            
            newLabel.MouseLeave:Connect(function()
                TweenService:Create(newLabel:FindFirstChild("Title"), TweenInfo.new(0.2), {TextStrokeTransparency = 1}):Play()
            end)
            
            newLabel.MouseButton1Down:Connect(function()
                TweenService:Create(newLabel:FindFirstChild("Title"), TweenInfo.new(0.2), {TextStrokeTransparency = 0.5}):Play()
            end)
            
            newLabel.MouseButton1Up:Connect(function()
                TweenService:Create(newLabel:FindFirstChild("Title"), TweenInfo.new(0.2), {TextStrokeTransparency = 1}):Play()
            end)
        end

        return newLabel
    end

    function classes.AddSubCheat(CheatType, Name, Callback, Options)
        local Cheat = setmetatable({
            Enabled = (Options and Options.Enabled) or false,
            Minimised = (Options and Options.Minimized) or true,
            Toggled = false,
            Object = self.AddCheatButton(Name),
        }, classes)

        if Callback and type(Callback) == "function" then
            Cheat.Object.TitleButton.MouseButton1Click:Connect(function()
                local S, E = pcall(function()
                    Cheat.Toggled = not Cheat.Toggled
                    Cheat.Object.TitleButton.TextColor3 = (Cheat.Toggled and ValiantUI.Options.CheatEnabledColor  or ValiantUI.Options.CheatDisabledColor)
                    Callback()
                end)
                if not S then warn(E) end
            end)
        end

        function newSubCheat(CheatType, Name, Callback, Options)
            local SubCheat = setmetatable({
                Object = nil,
                CheatType = CheatType
            }, classes)

            if CheatType == "Label" then
                local Label = self.OptionTemplate(Name)
                Label = self.OptionTemplate(Name)
                Label.CheatObjects:Destroy()
                Label.Title.Size = UDim2.new(0, 250, 0, ValiantUI.Options.WindowSize.Y.Offset - 5)
                Label.Title.TextXAlignment = 2
                Label.Size = UDim2.new(1, -10, 0, ValiantUI.Options.WindowSize.Y.Offset - 5)
                Label.Title.Position = UDim2.new(0, 0, 0, 0)
                Label.Title.BackgroundColor3 = ValiantUI.Options.LabelBackgroundColor3
                Label.Title.BackgroundTransparency = 0
                SubCheat.Object = Label

            elseif CheatType == "Button" then
                local Callback = Callback or function() end
                local Button = self.OptionTemplate(Name)
                        
                Button.CheatObjects:Destroy()
                Button.Title.Size = UDim2.new(1, -10, 0, 25)

                if Callback and type(Callback) == "function" then
                    Button.MouseButton1Click:Connect(function()
                        local S, E = pcall(function()
                            Callback()
                        end)
                        if not S then warn(E) end
                    end)
                end

                SubCheat.Object = Button       
            elseif CheatType == "Toggle" then
                local Default = Options.Default or false
                local Location = Options.Location or self.Flags
                local Flag = Options.Flag or ""
                local Callback = Callback or function() end
                Location[Flag] = Default
                local Toggled = Location[Flag]

                local Toggle = self.OptionTemplate(Name)
                Toggle.Title.Size = UDim2.new(1, -10, 0, 25)
                Toggle.CheatObjects.Size = UDim2.new(0, 25, 0, 25)
                Toggle.CheatObjects.Position = UDim2.new(1, -25, 0, 0)      
                local State = ValiantUI:Create('TextLabel', {
                    Name = "State"
                    Parent = Toggle.CheatObjects,
                    BackgroundColor3 = Valiant.Options.NormalBackgroundColor3,
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 1, 0),
                    Font = ValiantUI.Options.Font1,
                    TextSize = 9,
                    Text = (Toggled and ValiantUI.Options.ToggleEnabledText or ValiantUI.Options.ToggleDisabledText) 
                    TextColor3 = (Toggled and ValiantUI.Options.ToggleEnabledColor or ValiantUI.Options.ToggleDisabledColor)
                })
                Toggle.MouseButton1Click:Connect(function()
                    Toggled = not Toggled
                    State.Text = (Toggled and ValiantUI.Options.ToggleEnabledText or ValiantUI.Options.ToggleDisabledText) 
                    State.TextColor3 = (Toggled and ValiantUI.Options.ToggleEnabledColor or ValiantUI.Options.ToggleDisabledColor)
                
                    if Callback and type(Callback) == "function" then
                        local S, E = pcall(function()
                            Callback(Toggled)
                        end)
                        if not S then warn(E) end
                    end
                end)

                SubCheat.Object = Toggle 
            elseif CheatType == "TextBox" then
                local Type = Options.Type or ""
                local Default = Options.Default or false
                local Data = Options.Data
                local Location = Options.Location or self.Flags
                local Flag = Options.Flag or ""
                local Callback = Callback or function() end
                local Min = Options.Min or 0
                local Max = Options.Max = 9e9
                if Type == 'number' and (not tonumber(Default)) then
                    Location[Flag] = Default
                else
                    Location[Flag] = ""
                    Default = ""
                end

                local TextBox = self.OptionTemplate(Name)
                local Field = ValiantUI:Create('TextBox', {
                    Name = "Field",
                    Parent = TextBox.CheatObjects,
                    BackgroundColor3 = ValiantUI.Options.NormalBackgroundColor3,
                    BorderSizePixel = 0
                    Size = UDim2.new(1, -10, 1, 0)
                    TextXAlignment = Enum.TextXAlignment.Right,
                    Font = ValiantUI.Options.Font1,
                    PlaceholderColor3 = Color3.fromRGB(147, 147, 147),
                    PlaceholderText = (Options and Options.Placeholder) or "String",
                    Text = "",
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                    TextSize = 14,
                    TextStrokeColor3 = Color3.fromRGB(150, 150, 150),
                    TextWrapped = true
                })
                TextBox.MouseButton1Click:Connect(function()
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
                SubCheat.Object = TextBox
            end
        end
        newSubCheat(CheatType, Name, Callback, Options)

        
        SubCheat.Object.Parent = Cheat.Object.Options
        return SubCheat.Object
    end

    function ValiantUI:Create(class, properties)
        local object = Instance.new(class);
        for i, v in next, properties do
            if i ~= 'Parent' then         
                if typeof(v) == "Instance" then
                    v.Parent = object;
                else
                    object[i] = v
                end
            end
        end    
        object.Parent = properties.Parent;
        return object
    end

    function ValiantUI:CreateWindow(Name, Options)
        if (not ValiantUI.Object) then
            ValiantUI.Object = self:Create('ScreenGui', {
                Name = ValiantUI.Options.Name,
                Parent = game:GetService("CoreGui"),
                ZIndexBehavour = Enum.ZIndexBehavour.Global,
                ResetOnSpawn = false,
            })
        end
        if (not ValiantUI.Options) then
            ValiantUI.Options = setmetatable(Options or {}, {__index = Defaults})
        end
        local Window = classes.AddWindow(Name, ValiantUI.Options)
        Dragger.new(Window.Object)
        return Window
    end

    DefaultTheme = {
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
        
        WindowSize = UDim2.new(0, 250, 0, 32),
        LinePosition = UDim2.new(0, 0, 0, 32),
        
        CheatEnabledColor = Color3.fromRGB(216, 121, 153),
        CheatDisabledColor = Color3.fromRGB(255, 255, 255),
        
        ToggleEnabledText = "YES",
        ToggleDisabledText = "NO",
        ToggleEnabledColor = Color3.fromRGB(94, 255, 35),
        ToggleDisabledColor = Color3.fromRGB(255, 41, 41),
        
        KeyCode = Enum.KeyCode.RightControl,
    }
    ValiantUI.Options = setmetatable({}, {__index = DefaultTheme})

    game:GetService("RunService"):BindToRenderStep("Rainbow", 1000, function()
        local Hue = tick() % ValiantUI.Options.LineSmoothness / ValiantUI.Options.LineSmoothness
        for _,object in pairs(ValiantUI.RT) do
            object.BackgroundColor3 = Color3.fromHSV(Hue, 1, 1)
        end
    end)
end

ValiantUI.Options.LineColour = "rainbow"
ValiantUI:CreateWindow("Hi")