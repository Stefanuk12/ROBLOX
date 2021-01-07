if game.GameId == 833423526 then print("magik"); print("uwu"); end
local library = {count = 0, queue = {}, callbacks = {}, rainbowtable = {}, toggled = true, binds = {}};
local defaults; do
    local dragger = {}; do
        local mouse        = game:GetService("Players").LocalPlayer:GetMouse();
        local inputService = game:GetService('UserInputService');
        local heartbeat    = game:GetService("RunService").Heartbeat;
        -- // credits to Ririchi / Inori for this cute drag function :)
        function dragger.new(frame)
            local s, event = pcall(function()
                return frame.MouseEnter
            end)
    
            if s then
                frame.Active = true;
                
                event:connect(function()
                    local input = frame.InputBegan:connect(function(key)
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
                    leave = frame.MouseLeave:connect(function()
                        input:disconnect();
                        leave:disconnect();
                    end)
                end)
            end
        end

        game:GetService('UserInputService').InputBegan:connect(function(key, gpe)
            if (not gpe) then
                if key.KeyCode == Enum.KeyCode.RightControl then
                    library.toggled = not library.toggled;
                    for i, data in next, library.queue do
                        local pos = (library.toggled and data.p or UDim2.new(-1, 0, -0.5,0))
                        data.w:TweenPosition(pos, (library.toggled and 'Out' or 'In'), 'Quad', 0.15, true)
                        wait();
                    end
                end
            end
        end)
    end
    
    local types = {}; do
        types.__index = types;
        function types.window(name, options)
            library.count = library.count + 1
            local newWindow = library:Create('Frame', {
                Name = name;
                Size = UDim2.new(0, 190, 0, 30);
                BackgroundColor3 = options.topcolor;
                BorderSizePixel = 0;
                Parent = library.container;
                Position = UDim2.new(0, (15 + (200 * library.count) - 200), 0, 0);
                ZIndex = 3;
                library:Create('TextLabel', {
                    Text = name;
                    Size = UDim2.new(1, -10, 1, 0);
                    Position = UDim2.new(0, 5, 0, 0);
                    BackgroundTransparency = 1;
                    Font = Enum.Font.Code;
                    TextSize = options.titlesize;
                    Font = options.titlefont;
                    TextColor3 = options.titletextcolor;
                    TextStrokeTransparency = library.options.titlestroke;
                    TextStrokeColor3 = library.options.titlestrokecolor;
                    ZIndex = 3;
                });
                library:Create("TextButton", {
                    Size = UDim2.new(0, 30, 0, 30);
                    Position = UDim2.new(1, -35, 0, 0);
                    BackgroundTransparency = 1;
                    Text = "-";
                    TextSize = options.titlesize;
                    Font = options.titlefont;--Enum.Font.Code;
                    Name = 'window_toggle';
                    TextColor3 = options.titletextcolor;
                    TextStrokeTransparency = library.options.titlestroke;
                    TextStrokeColor3 = library.options.titlestrokecolor;
                    ZIndex = 3;
                });
                library:Create("Frame", {
                    Name = 'Underline';
                    Size = UDim2.new(1, 0, 0, 2);
                    Position = UDim2.new(0, 0, 1, -2);
                    BackgroundColor3 = (options.underlinecolor ~= "rainbow" and options.underlinecolor or Color3.new());
                    BorderSizePixel = 0;
                    ZIndex = 3;
                });
                library:Create('Frame', {
                    Name = 'container';
                    Position = UDim2.new(0, 0, 1, 0);
                    Size = UDim2.new(1, 0, 0, 0);
                    BorderSizePixel = 0;
                    BackgroundColor3 = options.bgcolor;
                    ClipsDescendants = false;
                    library:Create('UIListLayout', {
                        Name = 'List';
                        SortOrder = Enum.SortOrder.LayoutOrder;
                    })
                });
            })
            
            if options.underlinecolor == "rainbow" then
                table.insert(library.rainbowtable, newWindow:FindFirstChild('Underline'))
            end

            local window = setmetatable({
                count = 0;
                object = newWindow;
                container = newWindow.container;
                toggled = true;
                flags   = {};

            }, types)

            table.insert(library.queue, {
                w = window.object;
                p = window.object.Position;
            })

            newWindow:FindFirstChild("window_toggle").MouseButton1Click:connect(function()
                window.toggled = not window.toggled;
                newWindow:FindFirstChild("window_toggle").Text = (window.toggled and "+" or "-")
                if (not window.toggled) then
                    window.container.ClipsDescendants = true;
                end
                wait();
                local y = 0;
                for i, v in next, window.container:GetChildren() do
                    if (not v:IsA('UIListLayout')) then
                        y = y + v.AbsoluteSize.Y;
                    end
                end 

                local targetSize = window.toggled and UDim2.new(1, 0, 0, y+5) or UDim2.new(1, 0, 0, 0);
                local targetDirection = window.toggled and "In" or "Out"

                window.container:TweenSize(targetSize, targetDirection, "Quad", 0.15, true)
                wait(.15)
                if window.toggled then
                    window.container.ClipsDescendants = false;
                end
            end)

            return window;
        end
        
        function types:Resize()
            local y = 0;
            for i, v in next, self.container:GetChildren() do
                if (not v:IsA('UIListLayout')) then
                    y = y + v.AbsoluteSize.Y;
                end
            end 
            self.container.Size = UDim2.new(1, 0, 0, y+5)
        end
        
        function types:GetOrder() 
            local c = 0;
            for i, v in next, self.container:GetChildren() do
                if (not v:IsA('UIListLayout')) then
                    c = c + 1
                end
            end
            return c
        end
        
        function types:Label(text)
            local v = game:GetService'TextService':GetTextSize(text, 18, Enum.Font.SourceSans, Vector2.new(math.huge, math.huge))
            local object = library:Create('Frame', {
                Size = UDim2.new(1, 0, 0, v.Y + 5);
                BackgroundTransparency  = 1;
                library:Create('TextLabel', {
                    Size = UDim2.new(1, 0, 1, 0);
                    Position = UDim2.new(0, 10, 0, 0);
                    LayoutOrder = self:GetOrder();

                    Text = text;
                    TextSize = 18;
                    Font = Enum.Font.SourceSans;
                    TextColor3 = Color3.fromRGB(255, 255, 255);
                    BackgroundTransparency = 1;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    TextWrapped = true;
                });
                Parent = self.container
            })
            self:Resize();
        end

        function types:Toggle(name, options, callback)
            local default  = options.default or false;
            local location = options.location or self.flags;
            local flag     = options.flag or "";
            local callback = callback or function() end;
            
            location[flag] = default;

            local check = library:Create('Frame', {
                BackgroundTransparency = 1;
                Size = UDim2.new(1, 0, 0, 25);
                LayoutOrder = self:GetOrder();
                library:Create('TextLabel', {
                    Name = name;
                    Text = "\r" .. name;
                    BackgroundTransparency = 1;
                    TextColor3 = library.options.textcolor;
                    Position = UDim2.new(0, 5, 0, 0);
                    Size     = UDim2.new(1, -5, 1, 0);
                    TextXAlignment = Enum.TextXAlignment.Left;
                    Font = library.options.font;
                    TextSize = library.options.fontsize;
                    TextStrokeTransparency = library.options.textstroke;
                    TextStrokeColor3 = library.options.strokecolor;
                    library:Create('TextButton', {
                        Text = (location[flag] and utf8.char(10003) or "");
                        Font = library.options.font;
                        TextSize = library.options.fontsize;
                        Name = 'Checkmark';
                        Size = UDim2.new(0, 20, 0, 20);
                        Position = UDim2.new(1, -25, 0, 4);
                        TextColor3 = library.options.textcolor;
                        BackgroundColor3 = library.options.bgcolor;
                        BorderColor3 = library.options.bordercolor;
                        TextStrokeTransparency = library.options.textstroke;
                        TextStrokeColor3 = library.options.strokecolor;
                    })
                });
                Parent = self.container;
            });
                
            local function click(t)
                location[flag] = not location[flag];
                callback(location[flag])
                check:FindFirstChild(name).Checkmark.Text = location[flag] and utf8.char(10003) or "";
            end

            check:FindFirstChild(name).Checkmark.MouseButton1Click:connect(click)
            library.callbacks[flag] = click;

            if location[flag] == true then
                callback(location[flag])
            end

            self:Resize();
            return {
                Set = function(self, b)
                    location[flag] = b;
                    callback(location[flag])
                    check:FindFirstChild(name).Checkmark.Text = location[flag] and utf8.char(10003) or "";
                end
            }
        end
        
        function types:Button(name, callback)
            callback = callback or function() end;
            
            local check = library:Create('Frame', {
                BackgroundTransparency = 1;
                Size = UDim2.new(1, 0, 0, 25);
                LayoutOrder = self:GetOrder();
                library:Create('TextButton', {
                    Name = name;
                    Text = name;
                    BackgroundColor3 = library.options.btncolor;
                    BorderColor3 = library.options.bordercolor;
                    TextStrokeTransparency = library.options.textstroke;
                    TextStrokeColor3 = library.options.strokecolor;
                    TextColor3 = library.options.textcolor;
                    Position = UDim2.new(0, 5, 0, 5);
                    Size     = UDim2.new(1, -10, 0, 20);
                    Font = library.options.font;
                    TextSize = library.options.fontsize;
                });
                Parent = self.container;
            });
            
            check:FindFirstChild(name).MouseButton1Click:connect(callback)
            self:Resize();

            return {
                Fire = function()
                    callback();
                end
            }
        end
        
        function types:Box(name, options, callback) --type, default, data, location, flag)
            local type   = options.type or "";
            local default = options.default or "";
            local data = options.data
            local location = options.location or self.flags;
            local flag     = options.flag or "";
            local callback = callback or function() end;
            local min      = options.min or 0;
            local max      = options.max or 9e9;

            if type == 'number' and (not tonumber(default)) then
                location[flag] = default;
            else
                location[flag] = "";
                default = "";
            end

            local check = library:Create('Frame', {
                BackgroundTransparency = 1;
                Size = UDim2.new(1, 0, 0, 25);
                LayoutOrder = self:GetOrder();
                library:Create('TextLabel', {
                    Name = name;
                    Text = "\r" .. name;
                    BackgroundTransparency = 1;
                    TextColor3 = library.options.textcolor;
                    TextStrokeTransparency = library.options.textstroke;
                    TextStrokeColor3 = library.options.strokecolor;
                    Position = UDim2.new(0, 5, 0, 0);
                    Size     = UDim2.new(1, -5, 1, 0);
                    TextXAlignment = Enum.TextXAlignment.Left;
                    Font = library.options.font;
                    TextSize = library.options.fontsize;
                    library:Create('TextBox', {
                        TextStrokeTransparency = library.options.textstroke;
                        TextStrokeColor3 = library.options.strokecolor;
                        Text = tostring(default);
                        Font = library.options.font;
                        TextSize = library.options.fontsize;
                        Name = 'Box';
                        Size = UDim2.new(0, 60, 0, 20);
                        Position = UDim2.new(1, -65, 0, 3);
                        TextColor3 = library.options.textcolor;
                        BackgroundColor3 = library.options.boxcolor;
                        BorderColor3 = library.options.bordercolor;
                        PlaceholderColor3 = library.options.placeholdercolor;
                    })
                });
                Parent = self.container;
            });
        
            local box = check:FindFirstChild(name):FindFirstChild('Box');
            box.FocusLost:connect(function(e)
                local old = location[flag];
                if type == "number" then
                    local num = tonumber(box.Text)
                    if (not num) then
                        box.Text = tonumber(location[flag])
                    else
                        location[flag] = math.clamp(num, min, max)
                        box.Text = tonumber(location[flag])
                    end
                else
                    location[flag] = tostring(box.Text)
                end

                callback(location[flag], old, e)
            end)
            
            if type == 'number' then
                box:GetPropertyChangedSignal('Text'):connect(function()
                    box.Text = string.gsub(box.Text, "[%a+]", "");
                end)
            end
            
            self:Resize();
            return box
        end
        
        function types:Bind(name, options, callback)
            local location     = options.location or self.flags;
            local keyboardOnly = options.kbonly or false
            local flag         = options.flag or "";
            local callback     = callback or function() end;
            local default      = options.default;

            local passed = true;
            if keyboardOnly and (tostring(default):find('MouseButton')) then 
                passed = false 
            end
            if passed then 
               location[flag] = default 
            end
           
            local banned = {
                Return = true;
                Space = true;
                Tab = true;
                Unknown = true;
            }
            
            local shortNames = {
                RightControl = 'RightCtrl';
                LeftControl = 'LeftCtrl';
                LeftShift = 'LShift';
                RightShift = 'RShift';
                MouseButton1 = "Mouse1";
                MouseButton2 = "Mouse2";
            }
            
            local allowed = {
                MouseButton1 = true;
                MouseButton2 = true;
            }      

            local nm = (default and (shortNames[default.Name] or default.Name) or "None");
            local check = library:Create('Frame', {
                BackgroundTransparency = 1;
                Size = UDim2.new(1, 0, 0, 30);
                LayoutOrder = self:GetOrder();
                library:Create('TextLabel', {
                    Name = name;
                    Text = "\r" .. name;
                    BackgroundTransparency = 1;
                    TextColor3 = library.options.textcolor;
                    Position = UDim2.new(0, 5, 0, 0);
                    Size     = UDim2.new(1, -5, 1, 0);
                    TextXAlignment = Enum.TextXAlignment.Left;
                    Font = library.options.font;
                    TextSize = library.options.fontsize;
                    TextStrokeTransparency = library.options.textstroke;
                    TextStrokeColor3 = library.options.strokecolor;
                    BorderColor3     = library.options.bordercolor;
                    BorderSizePixel  = 1;
                    library:Create('TextButton', {
                        Name = 'Keybind';
                        Text = nm;
                        TextStrokeTransparency = library.options.textstroke;
                        TextStrokeColor3 = library.options.strokecolor;
                        Font = library.options.font;
                        TextSize = library.options.fontsize;
                        Size = UDim2.new(0, 60, 0, 20);
                        Position = UDim2.new(1, -65, 0, 5);
                        TextColor3 = library.options.textcolor;
                        BackgroundColor3 = library.options.bgcolor;
                        BorderColor3     = library.options.bordercolor;
                        BorderSizePixel  = 1;
                    })
                });
                Parent = self.container;
            });
             
            local button = check:FindFirstChild(name).Keybind;
            button.MouseButton1Click:connect(function()
                library.binding = true

                button.Text = "..."
                local a, b = game:GetService('UserInputService').InputBegan:wait();
                local name = tostring(a.KeyCode.Name);
                local typeName = tostring(a.UserInputType.Name);

                if (a.UserInputType ~= Enum.UserInputType.Keyboard and (allowed[a.UserInputType.Name]) and (not keyboardOnly)) or (a.KeyCode and (not banned[a.KeyCode.Name])) then
                    local name = (a.UserInputType ~= Enum.UserInputType.Keyboard and a.UserInputType.Name or a.KeyCode.Name);
                    location[flag] = (a);
                    button.Text = shortNames[name] or name;
                    
                else
                    if (location[flag]) then
                        if (not pcall(function()
                            return location[flag].UserInputType
                        end)) then
                            local name = tostring(location[flag])
                            button.Text = shortNames[name] or name
                        else
                            local name = (location[flag].UserInputType ~= Enum.UserInputType.Keyboard and location[flag].UserInputType.Name or location[flag].KeyCode.Name);
                            button.Text = shortNames[name] or name;
                        end
                    end
                end

                wait(0.1)  
                library.binding = false;
            end)
            
            if location[flag] then
                button.Text = shortNames[tostring(location[flag].Name)] or tostring(location[flag].Name)
            end

            library.binds[flag] = {
                location = location;
                callback = callback;
            };

            self:Resize();
        end
    
        function types:Section(name)
            local order = self:GetOrder();
            local determinedSize = UDim2.new(1, 0, 0, 25)
            local determinedPos = UDim2.new(0, 0, 0, 4);
            local secondarySize = UDim2.new(1, 0, 0, 20);
                        
            if order == 0 then
                determinedSize = UDim2.new(1, 0, 0, 21)
                determinedPos = UDim2.new(0, 0, 0, -1);
                secondarySize = nil
            end
            
            local check = library:Create('Frame', {
                Name = 'Section';
                BackgroundTransparency = 1;
                Size = determinedSize;
                BackgroundColor3 = library.options.sectncolor;
                BorderSizePixel = 0;
                LayoutOrder = order;
                library:Create('TextLabel', {
                    Name = 'section_lbl';
                    Text = name;
                    BackgroundTransparency = 0;
                    BorderSizePixel = 0;
                    BackgroundColor3 = library.options.sectncolor;
                    TextColor3 = library.options.textcolor;
                    Position = determinedPos;
                    Size     = (secondarySize or UDim2.new(1, 0, 1, 0));
                    Font = library.options.font;
                    TextSize = library.options.fontsize;
                    TextStrokeTransparency = library.options.textstroke;
                    TextStrokeColor3 = library.options.strokecolor;
                });
                Parent = self.container;
            });
        
            self:Resize();
        end

        function types:Slider(name, options, callback)
            local default = options.default or options.min;
            local min     = options.min or 0;
            local max      = options.max or 1;
            local location = options.location or self.flags;
            local precise  = options.precise  or false -- e.g 0, 1 vs 0, 0.1, 0.2, ...
            local flag     = options.flag or "";
            local callback = callback or function() end

            location[flag] = default;

            local check = library:Create('Frame', {
                BackgroundTransparency = 1;
                Size = UDim2.new(1, 0, 0, 25);
                LayoutOrder = self:GetOrder();
                library:Create('TextLabel', {
                    Name = name;
                    TextStrokeTransparency = library.options.textstroke;
                    TextStrokeColor3 = library.options.strokecolor;
                    Text = "\r" .. name;
                    BackgroundTransparency = 1;
                    TextColor3 = library.options.textcolor;
                    Position = UDim2.new(0, 5, 0, 2);
                    Size     = UDim2.new(1, -5, 1, 0);
                    TextXAlignment = Enum.TextXAlignment.Left;
                    Font = library.options.font;
                    TextSize = library.options.fontsize;
                    library:Create('Frame', {
                        Name = 'Container';
                        Size = UDim2.new(0, 60, 0, 20);
                        Position = UDim2.new(1, -65, 0, 3);
                        BackgroundTransparency = 1;
                        --BorderColor3 = library.options.bordercolor;
                        BorderSizePixel = 0;
                        library:Create('TextLabel', {
                            Name = 'ValueLabel';
                            Text = default;
                            BackgroundTransparency = 1;
                            TextColor3 = library.options.textcolor;
                            Position = UDim2.new(0, -10, 0, 0);
                            Size     = UDim2.new(0, 1, 1, 0);
                            TextXAlignment = Enum.TextXAlignment.Right;
                            Font = library.options.font;
                            TextSize = library.options.fontsize;
                            TextStrokeTransparency = library.options.textstroke;
                            TextStrokeColor3 = library.options.strokecolor;
                        });
                        library:Create('TextButton', {
                            Name = 'Button';
                            Size = UDim2.new(0, 5, 1, -2);
                            Position = UDim2.new(0, 0, 0, 1);
                            AutoButtonColor = false;
                            Text = "";
                            BackgroundColor3 = Color3.fromRGB(20, 20, 20);
                            BorderSizePixel = 0;
                            ZIndex = 2;
                            TextStrokeTransparency = library.options.textstroke;
                            TextStrokeColor3 = library.options.strokecolor;
                        });
                        library:Create('Frame', {
                            Name = 'Line';
                            BackgroundTransparency = 0;
                            Position = UDim2.new(0, 0, 0.5, 0);
                            Size     = UDim2.new(1, 0, 0, 1);
                            BackgroundColor3 = Color3.fromRGB(255, 255, 255);
                            BorderSizePixel = 0;
                        });
                    })
                });
                Parent = self.container;
            });

            local overlay = check:FindFirstChild(name);

            local renderSteppedConnection;
            local inputBeganConnection;
            local inputEndedConnection;
            local mouseLeaveConnection;
            local mouseDownConnection;
            local mouseUpConnection;

            check:FindFirstChild(name).Container.MouseEnter:connect(function()
                local function update()
                    if renderSteppedConnection then renderSteppedConnection:disconnect() end 
                    

                    renderSteppedConnection = game:GetService('RunService').RenderStepped:connect(function()
                        local mouse = game:GetService("UserInputService"):GetMouseLocation()
                        local percent = (mouse.X - overlay.Container.AbsolutePosition.X) / (overlay.Container.AbsoluteSize.X)
                        percent = math.clamp(percent, 0, 1)
                        percent = tonumber(string.format("%.2f", percent))

                        overlay.Container.Button.Position = UDim2.new(math.clamp(percent, 0, 0.99), 0, 0, 1)
                        
                        local num = min + (max - min) * percent
                        local value = (precise and num or math.floor(num))

                        overlay.Container.ValueLabel.Text = value;
                        callback(tonumber(value))
                        location[flag] = tonumber(value)
                    end)
                end

                local function disconnect()
                    if renderSteppedConnection then renderSteppedConnection:disconnect() end
                    if inputBeganConnection then inputBeganConnection:disconnect() end
                    if inputEndedConnection then inputEndedConnection:disconnect() end
                    if mouseLeaveConnection then mouseLeaveConnection:disconnect() end
                    if mouseUpConnection then mouseUpConnection:disconnect() end
                end

                inputBeganConnection = check:FindFirstChild(name).Container.InputBegan:connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        update()
                    end
                end)

                inputEndedConnection = check:FindFirstChild(name).Container.InputEnded:connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        disconnect()
                    end
                end)

                mouseDownConnection = check:FindFirstChild(name).Container.Button.MouseButton1Down:connect(update)
                mouseUpConnection   = game:GetService("UserInputService").InputEnded:connect(function(a, b)
                    if a.UserInputType == Enum.UserInputType.MouseButton1 and (mouseDownConnection.Connected) then
                        disconnect()
                    end
                end)
            end)    

            if default ~= min then
                local percent = 1 - ((max - default) / (max - min))
                local number  = default 

                number = tonumber(string.format("%.2f", number))
                if (not precise) then
                    number = math.floor(number)
                end

                overlay.Container.Button.Position  = UDim2.new(math.clamp(percent, 0, 0.99), 0,  0, 1) 
                overlay.Container.ValueLabel.Text  = number
            end

            self:Resize();
            return {
                Set = function(self, value)
                    local percent = 1 - ((max - value) / (max - min))
                    local number  = value 

                    number = tonumber(string.format("%.2f", number))
                    if (not precise) then
                        number = math.floor(number)
                    end

                    overlay.Container.Button.Position  = UDim2.new(math.clamp(percent, 0, 0.99), 0,  0, 1) 
                    overlay.Container.ValueLabel.Text  = number
                    location[flag] = number
                    callback(number)
                end
            }
        end 

        function types:SearchBox(text, options, callback)
            local list = options.list or {};
            local flag = options.flag or "";
            local location = options.location or self.flags;
            local callback = callback or function() end;

            local busy = false;
            local box = library:Create('Frame', {
                BackgroundTransparency = 1;
                Size = UDim2.new(1, 0, 0, 25);
                LayoutOrder = self:GetOrder();
                library:Create('TextBox', {
                    Text = "";
                    PlaceholderText = text;
                    PlaceholderColor3 = Color3.fromRGB(60, 60, 60);
                    Font = library.options.font;
                    TextSize = library.options.fontsize;
                    Name = 'Box';
                    Size = UDim2.new(1, -10, 0, 20);
                    Position = UDim2.new(0, 5, 0, 4);
                    TextColor3 = library.options.textcolor;
                    BackgroundColor3 = library.options.dropcolor;
                    BorderColor3 = library.options.bordercolor;
                    TextStrokeTransparency = library.options.textstroke;
                    TextStrokeColor3 = library.options.strokecolor;
                    library:Create('ScrollingFrame', {
                        Position = UDim2.new(0, 0, 1, 1);
                        Name = 'Container';
                        BackgroundColor3 = library.options.btncolor;
                        ScrollBarThickness = 0;
                        BorderSizePixel = 0;
                        BorderColor3 = library.options.bordercolor;
                        Size = UDim2.new(1, 0, 0, 0);
                        library:Create('UIListLayout', {
                            Name = 'ListLayout';
                            SortOrder = Enum.SortOrder.LayoutOrder;
                        });
                        ZIndex = 2;
                    });
                });
                Parent = self.container;
            })

            local function rebuild(text)
                box:FindFirstChild('Box').Container.ScrollBarThickness = 0
                for i, child in next, box:FindFirstChild('Box').Container:GetChildren() do
                    if (not child:IsA('UIListLayout')) then
                        child:Destroy();
                    end
                end

                if #text > 0 then
                    for i, v in next, list do
                        if string.sub(string.lower(v), 1, string.len(text)) == string.lower(text) then
                            local button = library:Create('TextButton', {
                                Text = v;
                                Font = library.options.font;
                                TextSize = library.options.fontsize;
                                TextColor3 = library.options.textcolor;
                                BorderColor3 = library.options.bordercolor;
                                TextStrokeTransparency = library.options.textstroke;
                                TextStrokeColor3 = library.options.strokecolor;
                                Parent = box:FindFirstChild('Box').Container;
                                Size = UDim2.new(1, 0, 0, 20);
                                LayoutOrder = i;
                                BackgroundColor3 = library.options.btncolor;
                                ZIndex = 2;
                            })

                            button.MouseButton1Click:connect(function()
                                busy = true;
                                box:FindFirstChild('Box').Text = button.Text;
                                wait();
                                busy = false;

                                location[flag] = button.Text;
                                callback(location[flag])

                                box:FindFirstChild('Box').Container.ScrollBarThickness = 0
                                for i, child in next, box:FindFirstChild('Box').Container:GetChildren() do
                                    if (not child:IsA('UIListLayout')) then
                                        child:Destroy();
                                    end
                                end
                                box:FindFirstChild('Box').Container:TweenSize(UDim2.new(1, 0, 0, 0), 'Out', 'Quad', 0.25, true)
                            end)
                        end
                    end
                end

                local c = box:FindFirstChild('Box').Container:GetChildren()
                local ry = (20 * (#c)) - 20

                local y = math.clamp((20 * (#c)) - 20, 0, 100)
                if ry > 100 then
                    box:FindFirstChild('Box').Container.ScrollBarThickness = 5;
                end

                box:FindFirstChild('Box').Container:TweenSize(UDim2.new(1, 0, 0, y), 'Out', 'Quad', 0.25, true)
                box:FindFirstChild('Box').Container.CanvasSize = UDim2.new(1, 0, 0, (20 * (#c)) - 20)
            end

            box:FindFirstChild('Box'):GetPropertyChangedSignal('Text'):connect(function()
                if (not busy) then
                    rebuild(box:FindFirstChild('Box').Text)
                end
            end);

            local function reload(new_list)
                list = new_list;
                rebuild("")
            end
            self:Resize();
            return reload, box:FindFirstChild('Box');
        end
        
        function types:Dropdown(name, options, callback)
            local location = options.location or self.flags;
            local flag = options.flag or "";
            local callback = callback or function() end;
            local list = options.list or {};

            location[flag] = list[1]
            local check = library:Create('Frame', {
                BackgroundTransparency = 1;
                Size = UDim2.new(1, 0, 0, 25);
                BackgroundColor3 = Color3.fromRGB(25, 25, 25);
                BorderSizePixel = 0;
                LayoutOrder = self:GetOrder();
                library:Create('Frame', {
                    Name = 'dropdown_lbl';
                    BackgroundTransparency = 0;
                    BackgroundColor3 = library.options.dropcolor;
                    Position = UDim2.new(0, 5, 0, 4);
                    BorderColor3 = library.options.bordercolor;
                    Size     = UDim2.new(1, -10, 0, 20);
                    library:Create('TextLabel', {
                        Name = 'Selection';
                        Size = UDim2.new(1, 0, 1, 0);
                        Text = list[1];
                        TextColor3 = library.options.textcolor;
                        BackgroundTransparency = 1;
                        Font = library.options.font;
                        TextSize = library.options.fontsize;
                        TextStrokeTransparency = library.options.textstroke;
                        TextStrokeColor3 = library.options.strokecolor;
                    });
                    library:Create("TextButton", {
                        Name = 'drop';
                        BackgroundTransparency = 1;
                        Size = UDim2.new(0, 20, 1, 0);
                        Position = UDim2.new(1, -25, 0, 0);
                        Text = 'v';
                        TextColor3 = library.options.textcolor;
                        Font = library.options.font;
                        TextSize = library.options.fontsize;
                        TextStrokeTransparency = library.options.textstroke;
                        TextStrokeColor3 = library.options.strokecolor;
                    })
                });
                Parent = self.container;
            });
            
            local button = check:FindFirstChild('dropdown_lbl').drop;
            local input;
            
            button.MouseButton1Click:connect(function()
                if (input and input.Connected) then
                    return
                end 
                
                check:FindFirstChild('dropdown_lbl'):WaitForChild('Selection').TextColor3 = Color3.fromRGB(60, 60, 60);
                check:FindFirstChild('dropdown_lbl'):WaitForChild('Selection').Text = name;
                local c = 0;
                for i, v in next, list do
                    c = c + 20;
                end

                local size = UDim2.new(1, 0, 0, c)

                local clampedSize;
                local scrollSize = 0;
                if size.Y.Offset > 100 then
                    clampedSize = UDim2.new(1, 0, 0, 100)
                    scrollSize = 5;
                end
                
                local goSize = (clampedSize ~= nil and clampedSize) or size;    
                local container = library:Create('ScrollingFrame', {
                    TopImage = 'rbxasset://textures/ui/Scroll/scroll-middle.png';
                    BottomImage = 'rbxasset://textures/ui/Scroll/scroll-middle.png';
                    Name = 'DropContainer';
                    Parent = check:FindFirstChild('dropdown_lbl');
                    Size = UDim2.new(1, 0, 0, 0);
                    BackgroundColor3 = library.options.bgcolor;
                    BorderColor3 = library.options.bordercolor;
                    Position = UDim2.new(0, 0, 1, 0);
                    ScrollBarThickness = scrollSize;
                    CanvasSize = UDim2.new(0, 0, 0, size.Y.Offset);
                    ZIndex = 5;
                    ClipsDescendants = true;
                    library:Create('UIListLayout', {
                        Name = 'List';
                        SortOrder = Enum.SortOrder.LayoutOrder
                    })
                })

                for i, v in next, list do
                    local btn = library:Create('TextButton', {
                        Size = UDim2.new(1, 0, 0, 20);
                        BackgroundColor3 = library.options.btncolor;
                        BorderColor3 = library.options.bordercolor;
                        Text = v;
                        Font = library.options.font;
                        TextSize = library.options.fontsize;
                        LayoutOrder = i;
                        Parent = container;
                        ZIndex = 5;
                        TextColor3 = library.options.textcolor;
                        TextStrokeTransparency = library.options.textstroke;
                        TextStrokeColor3 = library.options.strokecolor;
                    })
                    
                    btn.MouseButton1Click:connect(function()
                        check:FindFirstChild('dropdown_lbl'):WaitForChild('Selection').TextColor3 = library.options.textcolor
                        check:FindFirstChild('dropdown_lbl'):WaitForChild('Selection').Text = btn.Text;

                        location[flag] = tostring(btn.Text);
                        callback(location[flag])

                        game:GetService('Debris'):AddItem(container, 0)
                        input:disconnect();
                    end)
                end
                
                container:TweenSize(goSize, 'Out', 'Quad', 0.15, true)
                
                local function isInGui(frame)
                    local mloc = game:GetService('UserInputService'):GetMouseLocation();
                    local mouse = Vector2.new(mloc.X, mloc.Y - 36);
                    
                    local x1, x2 = frame.AbsolutePosition.X, frame.AbsolutePosition.X + frame.AbsoluteSize.X;
                    local y1, y2 = frame.AbsolutePosition.Y, frame.AbsolutePosition.Y + frame.AbsoluteSize.Y;
                
                    return (mouse.X >= x1 and mouse.X <= x2) and (mouse.Y >= y1 and mouse.Y <= y2)
                end
                
                input = game:GetService('UserInputService').InputBegan:connect(function(a)
                    if a.UserInputType == Enum.UserInputType.MouseButton1 and (not isInGui(container)) then
                        check:FindFirstChild('dropdown_lbl'):WaitForChild('Selection').TextColor3 = library.options.textcolor
                        check:FindFirstChild('dropdown_lbl'):WaitForChild('Selection').Text       = location[flag];

                        container:TweenSize(UDim2.new(1, 0, 0, 0), 'In', 'Quad', 0.15, true)
                        wait(0.15)

                        game:GetService('Debris'):AddItem(container, 0)
                        input:disconnect();
                    end
                end)
            end)
            
            self:Resize();
            local function reload(self, array)
                options = array;
                location[flag] = array[1];
                pcall(function()
                    input:disconnect()
                end)
                check:WaitForChild('dropdown_lbl').Selection.Text = location[flag]
                check:FindFirstChild('dropdown_lbl'):WaitForChild('Selection').TextColor3 = library.options.textcolor
                game:GetService('Debris'):AddItem(container, 0)
            end

            return {
                Refresh = reload;
            }
        end
    end
    
    function library:Create(class, data)
        local obj = Instance.new(class);
        for i, v in next, data do
            if i ~= 'Parent' then
                
                if typeof(v) == "Instance" then
                    v.Parent = obj;
                else
                    obj[i] = v
                end
            end
        end
        
        obj.Parent = data.Parent;
        return obj
    end
    
    function library:CreateWindow(name, options)
        if (not library.container) then
            library.container = self:Create("ScreenGui", {
                self:Create('Frame', {
                    Name = 'Container';
                    Size = UDim2.new(1, -30, 1, 0);
                    Position = UDim2.new(0, 20, 0, 20);
                    BackgroundTransparency = 1;
                    Active = false;
                });
                Parent = game:GetService("CoreGui");
            }):FindFirstChild('Container');
        end
        
        if (not library.options) then
            library.options = setmetatable(options or {}, {__index = defaults})
        end
        
        local window = types.window(name, library.options);
        dragger.new(window.object);
        return window
    end
    
    default = {
        topcolor       = Color3.fromRGB(30, 30, 30);
        titlecolor     = Color3.fromRGB(255, 255, 255);
        
        underlinecolor = Color3.fromRGB(0, 255, 140);
        bgcolor        = Color3.fromRGB(35, 35, 35);
        boxcolor       = Color3.fromRGB(35, 35, 35);
        btncolor       = Color3.fromRGB(25, 25, 25);
        dropcolor      = Color3.fromRGB(25, 25, 25);
        sectncolor     = Color3.fromRGB(25, 25, 25);
        bordercolor    = Color3.fromRGB(60, 60, 60);

        font           = Enum.Font.SourceSans;
        titlefont      = Enum.Font.Code;

        fontsize       = 17;
        titlesize      = 18;

        textstroke     = 1;
        titlestroke    = 1;

        strokecolor    = Color3.fromRGB(0, 0, 0);

        textcolor      = Color3.fromRGB(255, 255, 255);
        titletextcolor = Color3.fromRGB(255, 255, 255);

        placeholdercolor = Color3.fromRGB(255, 255, 255);
        titlestrokecolor = Color3.fromRGB(0, 0, 0);
    }

    library.options = setmetatable({}, {__index = default})

    spawn(function()
        while true do
            for i=0, 1, 1 / 300 do              
                for _, obj in next, library.rainbowtable do
                    obj.BackgroundColor3 = Color3.fromHSV(i, 1, 1);
                end
                wait()
            end;
        end
    end)

    local function isreallypressed(bind, inp)
        local key = bind
        if typeof(key) == "Instance" then
            if key.UserInputType == Enum.UserInputType.Keyboard and inp.KeyCode == key.KeyCode then
                return true;
            elseif tostring(key.UserInputType):find('MouseButton') and inp.UserInputType == key.UserInputType then
                return true
            end
        end
        if tostring(key):find'MouseButton1' then
            return key == inp.UserInputType
        else
            return key == inp.KeyCode
        end
    end

    game:GetService("UserInputService").InputBegan:connect(function(input)
        if (not library.binding) then
            for idx, binds in next, library.binds do
                local real_binding = binds.location[idx];
                if real_binding and isreallypressed(real_binding, input) then
                    binds.callback()
                end
            end
        end
    end)
end

return library