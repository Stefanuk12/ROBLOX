-- // Services
local Players = game:GetService("Players")

-- // Vars
local ChatFrame = Players.LocalPlayer.PlayerGui.Chat.Frame

-- //
ChatFrame.ChatChannelParentFrame.Visible = true
ChatFrame.ChatBarParentFrame.Position = UDim2.new(0, 0, 1, -42)