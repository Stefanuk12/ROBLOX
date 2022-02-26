-- // Dependencies
local DonateManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/PLS%20DONATE/Manager.lua"))()

-- // Vars
local Manager = DonateManager.new()

-- // Set messages
Manager.AutomatedMessages.Messages = {
    "Hello",
    "This is an automated message",
    "How are you today?",
    "Created by Stefanuk12"
}

-- // Create a task
Manager:AddTask(2, function(Tipper)
    Manager.SayMessage("/w " .. Tipper.Name .. " ez ty for the 2 bobux")
end)