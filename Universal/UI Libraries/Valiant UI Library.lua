local Library = {Count = 0, Queue = {}, Callbacks = {}, RainbowTable = {}, Toggled = true, Binds = {}}
local Defaults; do
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
                        if Key.UserInputType == Enum.UserInputService.MouseButton1 then
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
        UIS.InputBegan:Connect(function(Key, GPE)
            if (not GPE) then
                if Key.KeyCode == Enum.KeyCode.RightControl then
                    Library.Toggled = not Library.Toggled
                    for i, data in next, Library.Queue do
                        local Position = (Library.Toggled and data.P or UDim2.new(-1, 0, -0.5, 0))
                        data.W:TweenPosition(Position, (Library.Toggled and 'Out' or 'In'), 'Quad', 0.15, true)
                        wait()
                    end
                end
            end
        end)
    end

    local types = {}; do
        types.__index = types
        function types.window(name, options)
            Library.Count = Library.Count + 1
            local newWindow = Library:Create('Frame', {

            })

            if string.lower(Options.LineColor) == "rainbow" then
                table.insert(Library.RainbowTable, newWindow:FindFirstChild('Underline'))
            end

            local window = setmetatable({
                Count = 0,
                Object = newWindow,
                Container = newWindow.container,
                Toggled = true,
                Flags = {},
            }, types)

            table.insert(Library.Queue, {
                W = window.Object,
                P = window.Object.Position,
            })

            return window
        end

        function types:Resize()
            local y = 0
            for i,v in pairs(self.Container:GetChildren()) do
                if (not v:IsA('UIListLayout')) then
                    y = y + v.AbsoluteSize.Y
                end
            end
            self.Container.Size = UDim2.new(1, 0, 0, y + 5)
        end

        function types:GetOrder()
            local c = 0
            for i,v in pairs(self.Container:GetChildren()) do
                if (not v:IsA("UIListLayout")) then
                    c = c + 1
                end
            end
            return c
        end

    end
end