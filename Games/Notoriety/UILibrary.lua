--[[

   __    ____  __  __  ____  ____ 
  /__\  (_   )(  )(  )(  _ \( ___)
 /(__)\  / /_  )(__)(  )   / )__) 
(__)(__)(____)(______)(_)\_)(____) 

- I forked azure: Stefanuk12

]]--

--light theme
local theme = {
    Tab_Color = Color3.fromRGB(255, 255, 255),
    Tab_Text_Color = Color3.fromRGB(0, 0, 0),
    Description_Color = Color3.fromRGB(255, 255, 255),
    Description_Text_Color = Color3.fromRGB(0, 0, 0),
    Container_Color = Color3.fromRGB(255, 255, 255),
    Container_Text_Color = Color3.fromRGB(0, 0, 0),
    Button_Text_Color = Color3.fromRGB(0, 0, 0),
    Toggle_Box_Color = Color3.fromRGB(243, 243, 243),
    Toggle_Inner_Color = Color3.fromRGB(94, 255, 180),
    Toggle_Text_Color = Color3.fromRGB(0, 0, 0),
    Toggle_Border_Color = Color3.fromRGB(225, 225, 225),
    Slider_Bar_Color = Color3.fromRGB(243, 243, 243),
    Slider_Inner_Color = Color3.fromRGB(94, 255, 180),
    Slider_Text_Color = Color3.fromRGB(0, 0, 0),
    Slider_Border_Color = Color3.fromRGB(255, 255, 255),
    Dropdown_Text_Color = Color3.fromRGB(0, 0, 0),
    Dropdown_Option_BorderSize = 1,
    Dropdown_Option_BorderColor = Color3.fromRGB(235, 235, 235),
    Dropdown_Option_Color = Color3.fromRGB(255, 255, 255),
    Dropdown_Option_Text_Color = Color3.fromRGB(0, 0, 0),
    TextBox_Text_Color = Color3.fromRGB(0, 0, 0),
    TextBox_Color = Color3.fromRGB(255, 255, 255),
    TextBox_Underline_Color = Color3.fromRGB(94, 255, 180)
}

--dark theme
local dark_theme = {
    Tab_Color = Color3.fromRGB(31, 32, 33),
    Tab_Text_Color = Color3.fromRGB(255, 255, 255),
    Description_Color = Color3.fromRGB(31, 32, 33),
    Description_Text_Color = Color3.fromRGB(255, 255, 255),
    Container_Color = Color3.fromRGB(31, 32, 33),
    Container_Text_Color = Color3.fromRGB(255, 255, 255),
    Button_Text_Color = Color3.fromRGB(255, 255, 255),
    Toggle_Box_Color = Color3.fromRGB(31, 32, 33),
    Toggle_Inner_Color = Color3.fromRGB(255, 92, 92),
    Toggle_Text_Color = Color3.fromRGB(255, 255, 255),
    Toggle_Border_Color = Color3.fromRGB(50, 49, 50),
    Slider_Bar_Color = Color3.fromRGB(31, 32, 33),
    Slider_Inner_Color = Color3.fromRGB(255, 92, 92),
    Slider_Text_Color = Color3.fromRGB(255, 255, 255),
    Slider_Border_Color = Color3.fromRGB(50, 49, 50),
    Dropdown_Text_Color = Color3.fromRGB(255, 255, 255),
    Dropdown_Option_BorderSize = 1,
    Dropdown_Option_BorderColor = Color3.fromRGB(49, 50, 51),
    Dropdown_Option_Color = Color3.fromRGB(31, 32, 33),
    Dropdown_Option_Text_Color = Color3.fromRGB(255, 255, 255),
    TextBox_Text_Color = Color3.fromRGB(255, 255, 255),
    TextBox_Color = Color3.fromRGB(31, 32, 33),
    TextBox_Underline_Color = Color3.fromRGB(255, 92, 92)
}

if game:GetService("CoreGui"):FindFirstChild("uiui") then game:GetService("CoreGui"):FindFirstChild("uiui"):Destroy() end

local library = {}
local uiui = Instance.new("ScreenGui")
local background = Instance.new("Frame")
local UIListLayout = Instance.new("UIListLayout")
local UIPadding = Instance.new("UIPadding")

local TweenService = game:GetService("TweenService")

uiui.Name = "uiui"
uiui.Parent = game:GetService("CoreGui")
uiui.DisplayOrder = 1

background.Name = "background"
background.Parent = uiui
background.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
background.BackgroundTransparency = 1.000
background.Size = UDim2.new(0, 1234, 0, 664)

UIListLayout.Parent = background
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 10)

UIPadding.Parent = background
UIPadding.PaddingLeft = UDim.new(0, 10)
UIPadding.PaddingTop = UDim.new(0, 10)

function library:CreateTab(text, desc, mode)
    text = text or ""
    desc = desc or ""
    mode = mode or false
	
    if mode then
        theme = dark_theme
    elseif mode == nil then
        theme = _G.CustomTheme
    end
    local Tab = Instance.new("ImageButton")
    local tabtext = Instance.new("TextLabel")
    local description = Instance.new("ImageLabel")
    local descriptionText = Instance.new("TextLabel")
    local container = Instance.new("ImageLabel")
    local MainPadder = Instance.new("UIListLayout")
    local MainLiser = Instance.new("UIListLayout")

    MainPadder.Name = "MainPadder"
    MainPadder.Parent = container
    MainPadder.SortOrder = Enum.SortOrder.LayoutOrder

    MainLiser.Name = "MainLiser"
    MainLiser.Parent = container
    MainLiser.SortOrder = Enum.SortOrder.LayoutOrder

    local TextBounds =
        game:GetService("TextService"):GetTextSize(
        desc,
        14,
        Enum.Font.SourceSansLight,
        Vector2.new(math.huge, math.huge)
    )

    Tab.Name = math.random(1, 15) .. text .. " Tab"
    Tab.Parent = background
    Tab.ImageColor3 = theme.Tab_Color
    Tab.BackgroundTransparency = 1.000
    Tab.Size = UDim2.new(0, 155, 0, 30)
    Tab.Image = "rbxassetid://3570695787"
    Tab.ScaleType = Enum.ScaleType.Slice
    Tab.SliceCenter = Rect.new(100, 100, 100, 100)
    Tab.SliceScale = 0.030
    local HoverEffect = true
    local IsOpen = false
    Tab.MouseEnter:Connect(
        function()
            if HoverEffect and IsOpen == false then
                TweenService:Create(
                    description,
                    TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {Size = UDim2.new(0, TextBounds.X + 20, 0, 30)}
                ):Play()
			else
				TweenService:Create(
                    description,
                    TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {Size = UDim2.new(0, 0, 0, 30)}
                ):Play()
            end
        end
    )
    Tab.MouseLeave:Connect(
        function()
            TweenService:Create(
                description,
                TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {Size = UDim2.new(0, 0, 0, 30)}
            ):Play()
        end
    )
    tabtext.Name = "tabtext"
    tabtext.Parent = Tab
    tabtext.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    tabtext.BackgroundTransparency = 1.000
    tabtext.Size = UDim2.new(0, 155, 0, 30)
    tabtext.Font = Enum.Font.SourceSansLight
    tabtext.Text = text
    tabtext.TextColor3 = theme.Tab_Text_Color
    tabtext.TextSize = 16.000

    description.Name = "description"
    description.Parent = Tab
    description.ImageColor3 = theme.Description_Color
    description.BackgroundTransparency = 1.000
    description.BorderSizePixel = 0
    description.ClipsDescendants = true
    description.Position = UDim2.new(1.04969442, 0, -0.022590382, 0)
    description.Size = UDim2.new(0, 0, 0, 30)
    description.Image = "rbxassetid://3570695787"
    description.ScaleType = Enum.ScaleType.Slice
    description.SliceCenter = Rect.new(100, 100, 100, 100)
    description.SliceScale = 0.030

    descriptionText.Name = "descriptionText"
    descriptionText.Parent = description
    descriptionText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    descriptionText.BackgroundTransparency = 1.000
    descriptionText.Position = UDim2.new(0, 0, 0.022590382, 0)
    descriptionText.Size = UDim2.new(0, TextBounds.X + 20, 0, 30)
    descriptionText.Font = Enum.Font.SourceSansLight
    descriptionText.Text = desc
    descriptionText.TextColor3 = theme.Description_Text_Color
    descriptionText.TextSize = 14.000

    local BodyYSize = 0

    container.Name = "container"
    container.Parent = Tab
    container.ImageColor3 = theme.Container_Color
    container.BackgroundTransparency = 1.000
    container.BorderSizePixel = 0
    container.ClipsDescendants = true
    container.Position = UDim2.new(1.04969442, 0, -0.022590382, 0)
    container.Size = UDim2.new(0, 185, 0, 0)
    container.Image = "rbxassetid://3570695787"
    container.ScaleType = Enum.ScaleType.Slice
    container.SliceCenter = Rect.new(100, 100, 100, 100)
    container.SliceScale = 0.030
    local HoverEffect = true
    Tab.MouseButton1Click:Connect(
        function()
            for i, v in next, background:GetChildren() do
                for i, v in next, v:GetChildren() do
                    if v.Name == "container" and v.Name ~= Tab.Name then
						IsOpen = false
                        TweenService:Create(
                            v,
                            TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
                            {Size = UDim2.new(0, 185, 0, 0)}
                        ):Play()
                        HoverEffect = false
                    end
					IsOpen = true
                    TweenService:Create(
                        container,
                        TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
                        {Size = UDim2.new(0, 185, 0, BodyYSize)}
                    ):Play()
					HoverEffect = true
                end
            end
            if container.Size == UDim2.new(0, 185, 0, BodyYSize) then
				IsOpen = false
                TweenService:Create(
                    container,
                    TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
                    {Size = UDim2.new(0, 185, 0, 0)}
                ):Play()
                
                TweenService:Create(
                    description,
                    TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {Size = UDim2.new(0, TextBounds.X + 20, 0, 30)}
                ):Play()
                HoverEffect = true
            elseif container.Size == UDim2.new(0, 185, 0, 0) then
				IsOpen = true
                TweenService:Create(
                    container,
                    TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
                    {Size = UDim2.new(0, 185, 0, BodyYSize)}
                ):Play()
                
                TweenService:Create(
                    description,
                    TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {Size = UDim2.new(0, 0, 0, 30)}
                ):Play()
                HoverEffect = false
            end
        end
    )

    local function resize(value)
        BodyYSize = BodyYSize + value
    end

    local s = {}

    function s:CreateToggle(text, options, callback)
        text = text or ""
        options = options or {Enabled = false}
        callback = callback or function() end

        local Toggle = Instance.new("TextButton")
        local ToggleBox = Instance.new("Frame")
        local ToggleInner = Instance.new("Frame")
        local ToggleText = Instance.new("TextLabel")

        Toggle.Name = "Toggle"
        Toggle.Parent = container
        Toggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Toggle.BackgroundTransparency = 1.000
        Toggle.Size = UDim2.new(0, 185, 0, 30)
        Toggle.Font = Enum.Font.SourceSans
        Toggle.Text = ""
        Toggle.TextColor3 = Color3.fromRGB(0, 0, 0)
        Toggle.TextSize = 14.000

        ToggleBox.Name = "ToggleBox"
        ToggleBox.Parent = Toggle
        ToggleBox.BackgroundColor3 = theme.Toggle_Box_Color
        ToggleBox.BorderColor3 = theme.Toggle_Border_Color
        ToggleBox.Position = UDim2.new(0.0416216031, 0, 0.166666672, 0)
        ToggleBox.Size = UDim2.new(0, 20, 0, 20)

        ToggleInner.Name = "ToggleInner"
        ToggleInner.Parent = Toggle
        ToggleInner.AnchorPoint = Vector2.new(0.5, 0.5)
        ToggleInner.BackgroundColor3 = theme.Toggle_Inner_Color
        ToggleInner.BorderSizePixel = 0
        ToggleInner.Position = UDim2.new(0.096, 0, 0.5, 0)

        ToggleText.Name = "ToggleText"
        ToggleText.Parent = Toggle
        ToggleText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ToggleText.BackgroundTransparency = 1.000
        ToggleText.Position = UDim2.new(0.149729788, 0, 0, 0)
        ToggleText.Size = UDim2.new(0, 157, 0, 30)
        ToggleText.Font = Enum.Font.SourceSansLight
        ToggleText.Text = "   " .. text
        ToggleText.TextColor3 = theme.Toggle_Text_Color
        ToggleText.TextSize = 16.000
        ToggleText.TextXAlignment = Enum.TextXAlignment.Left

        local Toggled = false

        Toggle.MouseButton1Click:Connect(
            function()
                Toggled = not Toggled

                if Toggled then
                    TweenService:Create(
                        ToggleInner,
                        TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                        {Size = UDim2.new(0, 20, 0, 20)}
                    ):Play()
                elseif not Toggled then
                    TweenService:Create(
                        ToggleInner,
                        TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                        {Size = UDim2.new(0, 0, 0, 0)}
                    ):Play()
                end

                callback(Toggled)
            end
        )

			
		local aa = {}

		function aa:Set(bool)
			if bool then
				Toggled = true
				TweenService:Create(
                    ToggleInner,
                    TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                    {Size = UDim2.new(0, 20, 0, 20)}
                ):Play()
			else
				Toggled = false
				TweenService:Create(
                    ToggleInner,
                    TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                    {Size = UDim2.new(0, 0, 0, 0)}
                ):Play()
			end
		end

        function aa:Get()
            return Toggled
        end

        resize(30)

        aa:Set(options.Enabled)
        callback(Toggled)

		return aa;
    end
    function s:CreateSlider(text, minvalue, maxvalue, callback)
        text = text or ""
        callback = callback or function()
            end
        minvalue = minvalue or 0
        maxvalue = maxvalue or 0
        local Slider = Instance.new("TextButton")
        local SliderText = Instance.new("TextLabel")
        local Slider_2 = Instance.new("Frame")
        local SliderInner = Instance.new("Frame")

        Slider.Name = "Slider"
        Slider.Parent = container
        Slider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Slider.BackgroundTransparency = 1.000
        Slider.Position = UDim2.new(0, 0, 0.410958916, 0)
        Slider.Size = UDim2.new(0, 185, 0, 45)
        Slider.Font = Enum.Font.SourceSans
        Slider.Text = ""
        Slider.TextColor3 = Color3.fromRGB(0, 0, 0)
        Slider.TextSize = 14.000

        SliderText.Name = "SliderText"
        SliderText.Parent = Slider
        SliderText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        SliderText.BackgroundTransparency = 1.000
        SliderText.Position = UDim2.new(0.0362162739, 0, -0.0666666701, 0)
        SliderText.Size = UDim2.new(0, 157, 0, 30)
        SliderText.Font = Enum.Font.SourceSansLight
        SliderText.Text = text .. " / " .. minvalue
        SliderText.TextColor3 = theme.Slider_Text_Color
        SliderText.TextSize = 16.000
        SliderText.TextXAlignment = Enum.TextXAlignment.Left

        Slider_2.Name = "Slider"
        Slider_2.Parent = Slider
        Slider_2.BackgroundColor3 = theme.Slider_Bar_Color
        Slider_2.BorderColor3 = theme.Slider_Border_Color
        Slider_2.Position = UDim2.new(0.0319999084, 0, 0.588888884, 0)
        Slider_2.Size = UDim2.new(0, 172, 0, 9)
        SliderInner.Name = "SliderInner"
        SliderInner.Parent = Slider_2
        SliderInner.BackgroundColor3 = theme.Slider_Inner_Color
        SliderInner.BorderSizePixel = 0
        SliderInner.Position = UDim2.new(0, 0, 0.055555556, 0)
        SliderInner.Size = UDim2.new(0, 0, 0, 9)

        local mouse = game.Players.LocalPlayer:GetMouse()
        local uis = game:GetService("UserInputService")
        local Value
        local down = false

        Slider.MouseButton1Down:Connect(function()
            down = true
            Value = math.floor((((tonumber(maxvalue) - tonumber(minvalue)) / 172) * SliderInner.AbsoluteSize.X) +tonumber(minvalue)) or 0
            SliderText.Text = text .. " / " .. Value
			pcall(callback, Value)
            SliderInner:TweenSize(UDim2.new(0, math.clamp(mouse.X - SliderInner.AbsolutePosition.X, 0, 172), 0, 9), Enum.EasingDirection.InOut, Enum.EasingStyle.Linear, .07)
            while game:GetService("RunService").RenderStepped:wait() and down do
                Value = math.floor((((tonumber(maxvalue) - tonumber(minvalue)) / 172) * SliderInner.AbsoluteSize.X) +tonumber(minvalue)) or 0
				SliderText.Text = text .. " / " .. Value                
				pcall(callback, Value)
                SliderInner:TweenSize(UDim2.new(0, math.clamp(mouse.X - SliderInner.AbsolutePosition.X, 0, 172), 0, 9), Enum.EasingDirection.InOut, Enum.EasingStyle.Linear, .07)
            end
        end)

        uis.InputEnded:connect(function(key)
			if key.UserInputType == Enum.UserInputType.MouseButton1 and down then
	            down = false
	            Value = math.floor((((tonumber(maxvalue) - tonumber(minvalue)) / 172) * SliderInner.AbsoluteSize.X) +tonumber(minvalue)) or 0
	            SliderText.Text = text .. " / " .. Value
				pcall(callback, Value)
	            SliderInner:TweenSize(UDim2.new(0, math.clamp(mouse.X - SliderInner.AbsolutePosition.X, 0, 172), 0, 9), Enum.EasingDirection.InOut, Enum.EasingStyle.Linear, 0.1)
			end        
		end)
	
		local ss = {}

		function ss:Set(SliderAmount)
			SliderAmount = tonumber(SliderAmount) or 0
			SliderAmount = (((SliderAmount >= 0 and SliderAmount <= 100) and SliderAmount) / 100)
			TweenService:Create(
                SliderInner,
                TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                {Size = UDim2.new(SliderAmount or 0, 0, 0, 9)}
            ):Play()
			local p = math.floor((SliderAmount or 0) * 100)
			
			local difference = maxvalue - minvalue
			
			local Value = math.floor(((difference / 100) * p) + minvalue)

			SliderText.Text = text .. " / " .. Value
			pcall(callback, Value)
		end


        resize(45)

		return ss
    end
    function s:CreateDropDown(text, list, callback)
		callback = callback or function() end
        text = text or ""
		list = list or {}
        resize(30)
        local IsDropped = false
        local DropYSize = 0

        local DropdownButton = Instance.new("TextButton")
        local DropdownText = Instance.new("TextLabel")
        local DropdownOpen = Instance.new("TextButton")
        local UIListLayout_2 = Instance.new("UIListLayout")
        local Dropdown = Instance.new("Frame")

        Dropdown.Name = "Dropdown"
        Dropdown.Parent = container
        Dropdown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Dropdown.BackgroundTransparency = 1.000
        Dropdown.ClipsDescendants = true
        Dropdown.Position = UDim2.new(0, 0, 0.205479458, 0)
        Dropdown.Size = UDim2.new(0, 184, 0, 30)

        DropdownButton.Name = "DropdownButton"
        DropdownButton.Parent = Dropdown
        DropdownButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        DropdownButton.BackgroundTransparency = 1.000
        DropdownButton.Size = UDim2.new(0, 185, 0, 30)
        DropdownButton.Font = Enum.Font.SourceSans
        DropdownButton.Text = ""
        DropdownButton.TextColor3 = Color3.fromRGB(0, 0, 0)
        DropdownButton.TextSize = 17.000

        DropdownText.Name = "DropdownText"
        DropdownText.Parent = DropdownButton
        DropdownText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        DropdownText.BackgroundTransparency = 1.000
        DropdownText.Size = UDim2.new(0, 155, 0, 30)
        DropdownText.Font = Enum.Font.SourceSansLight
        DropdownText.Text = "  " .. text .. " / " .. ""
        DropdownText.TextColor3 = theme.Dropdown_Text_Color
        DropdownText.TextSize = 16.000
        DropdownText.TextXAlignment = Enum.TextXAlignment.Left

        DropdownOpen.Name = "DropdownOpen"
        DropdownOpen.Parent = DropdownButton
        DropdownOpen.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        DropdownOpen.BackgroundTransparency = 1.000
        DropdownOpen.Position = UDim2.new(0.838, 0, 0, 0)
        DropdownOpen.Size = UDim2.new(0, 30, 0, 30)
        DropdownOpen.Font = Enum.Font.SourceSans
        DropdownOpen.Text = "+"
        DropdownOpen.TextColor3 = theme.Dropdown_Text_Color
        DropdownOpen.TextSize = 14.000

        UIListLayout_2.Parent = Dropdown
        UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder

        for i, v in next, list do
            local Option1 = Instance.new("TextButton")
            Option1.Name = "Option1"
            Option1.Parent = Dropdown
            Option1.BackgroundColor3 = theme.Dropdown_Option_Color
            Option1.BorderColor3 = theme.Dropdown_Option_BorderColor
            Option1.BorderSizePixel = theme.Dropdown_Option_BorderSize
            Option1.BackgroundTransparency = 0
            Option1.Position = UDim2.new(0, 0, 0.5, 0)
            Option1.Size = UDim2.new(0, 184, 0, 30)
            Option1.Font = Enum.Font.SourceSansLight
            Option1.Text = v
            Option1.TextColor3 = theme.Dropdown_Option_Text_Color
            Option1.TextSize = 16.000
            Option1.AutoButtonColor = false
            DropYSize = DropYSize + 30

            Option1.MouseButton1Click:Connect(
                function()
                    callback(v)
                    DropdownText.Text = "  " .. text .. " / " .. v
                    TweenService:Create(
                        Dropdown,
                        TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                        {Size = UDim2.new(0, 184, 0, 30)}
                    ):Play()
                    TweenService:Create(
                        container,
                        TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                        {Size = UDim2.new(0, 185, 0, BodyYSize)}
                    ):Play()
                    IsDropped = false
                    DropdownOpen.Text = "+"
                end
            )
        end
        DropdownButton.MouseButton1Click:Connect(
            function()
                if IsDropped then
                    IsDropped = false
                    DropdownOpen.Text = "+"
                    TweenService:Create(
                        Dropdown,
                        TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                        {Size = UDim2.new(0, 184, 0, 30)}
                    ):Play()
					
                    TweenService:Create(
                        container,
                        TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                        {Size = UDim2.new(0, 185, 0, BodyYSize)}
                    ):Play()
                else
                    IsDropped = true
                    DropdownOpen.Text = "-"
                    DropdownText.Text = "  " .. text .. " / "
                    TweenService:Create(
                        Dropdown,
                        TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                        {Size = UDim2.new(0, 184, 0, DropYSize + 30)}
                    ):Play()
                    TweenService:Create(
                        container,
                        TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                        {Size = UDim2.new(0, 185, 0, BodyYSize + DropYSize + 1)}
                    ):Play()
                end
            end
        )

        Tab.MouseButton1Click:Connect(
            function()
                IsDropped = false
                DropdownOpen.Text = "+"
                TweenService:Create(
                    Dropdown,
                    TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                    {Size = UDim2.new(0, 184, 0, 30)}
                ):Play()
                TweenService:Create(
                    container,
                    TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                    {Size = UDim2.new(0, 185, 0, 0)}
                ):Play()
            end
        )

		--[[local ssss = {}

		function ssss:Add(name)
	            local Option1 = Dropdown:FindFirstChild("Option1"):Clone()
	            Option1.Name = "Option1"
	            Option1.Parent = Dropdown
	            Option1.BackgroundColor3 = theme.Dropdown_Option_Color
	            Option1.BorderColor3 = theme.Dropdown_Option_BorderColor
	            Option1.BorderSizePixel = theme.Dropdown_Option_BorderSize
	            Option1.BackgroundTransparency = 0
	            Option1.Position = UDim2.new(0, 0, 0.5, 0)
	            Option1.Size = UDim2.new(0, 184, 0, 30)
	            Option1.Font = Enum.Font.SourceSansLight
	            Option1.Text = name
	            Option1.TextColor3 = theme.Dropdown_Option_Text_Color
	            Option1.TextSize = 16.000
	            Option1.AutoButtonColor = false
	            DropYSize = DropYSize + 30
	
	            Option1.MouseButton1Click:Connect(
	                function()
	                    callback(name)
	                    DropdownText.Text = "  " .. text .. " / " .. name
	                    TweenService:Create(
	                        Dropdown,
	                        TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
	                        {Size = UDim2.new(0, 184, 0, 30)}
	                    ):Play()
	                    TweenService:Create(
	                        container,
	                        TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
	                        {Size = UDim2.new(0, 185, 0, BodyYSize)}
	                    ):Play()
	                    IsDropped = false
	                    DropdownOpen.Text = "+"
	                end
	            )
			if IsDropped then
                    TweenService:Create(
                        Dropdown,
                        TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                        {Size = UDim2.new(0, 184, 0, DropYSize + 30)}
                    ):Play()
					TweenService:Create(
                        container,
                        TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                        {Size = UDim2.new(0, 184, 0, BodyYSize + DropYSize)}
                    ):Play()
                end
			local s2 = {}

			function s2:Remove()
				Option1:Destroy()
			end
		end

		return ssss;]]
    end
    function s:CreateButton(text, callback)
		text = text or ""
        callback = callback or function()
            end
        local Button = Instance.new("TextButton")
        Button.Name = text
        Button.Parent = container
        Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Button.BackgroundTransparency = 1.000
        Button.Position = UDim2.new(0, 0, 0.777777851, 0)
        Button.Size = UDim2.new(0, 185, 0, 30)
        Button.Font = Enum.Font.SourceSansLight
        Button.Text = text
        Button.TextColor3 = theme.Button_Text_Color
        Button.TextSize = 16.000
        Button.MouseButton1Down:Connect(
            function()
                Button.TextSize = 14
            end
        )
        Button.MouseButton1Up:Connect(
            function()
                pcall(callback)
                Button.TextSize = 16
            end
        )
        resize(30)
    end

	function s:CreateTextBox(string, callback)
		resize(30)
		string = string or ""
		callback = callback or function() end
		local TextBox = Instance.new("TextBox")
		local TextboxUnderline = Instance.new("Frame")
		
		TextBox.Parent = container
		TextBox.BackgroundColor3 = theme.TextBox_Color
		TextBox.BorderSizePixel = 0
		TextBox.Position = UDim2.new(0, 0, 0.818181813, 0)
		TextBox.Size = UDim2.new(0, 185, 0, 30)
		TextBox.ClearTextOnFocus = false
		TextBox.Font = Enum.Font.SourceSansLight
		TextBox.PlaceholderColor3 = theme.TextBox_Text_Color
		TextBox.PlaceholderText = string
		TextBox.Text = ""
		TextBox.TextColor3 = theme.TextBox_Text_Color
		TextBox.TextSize = 15.000
		TextBox.Focused:Connect(function()
			TextboxUnderline:TweenSize(UDim2.new(0,185,0,2), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.1)
		end)
		TextBox.FocusLost:Connect(function(enterpressed)
			if enterpressed then
				TextboxUnderline:TweenSize(UDim2.new(0,0,0,2), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.1)
				callback(TextBox.Text)
				TextBox.Text = ""
			else
				TextboxUnderline:TweenSize(UDim2.new(0,0,0,2), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.1)
			end
		end)
		
		TextboxUnderline.Name = "TextboxUnderline"
		TextboxUnderline.Parent = TextBox
		TextboxUnderline.AnchorPoint = Vector2.new(0.5, 0.5)
		TextboxUnderline.BackgroundColor3 = theme.TextBox_Underline_Color
		TextboxUnderline.BorderSizePixel = 0
		TextboxUnderline.Position = UDim2.new(0.50075686, 0, 0.966666639, 0)
		TextboxUnderline.Size = UDim2.new(0, 0, 0, 2)

		local TextBoxInfo = {}

		function TextBoxInfo:Edit(text)
			TextBox.Text = text
		end

		return TextBoxInfo
	end
    return s
end
return library