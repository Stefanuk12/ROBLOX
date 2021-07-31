--[[
- Synapse, unlike ScriptWare, has not implemented a feature into syn.protect_gui where it protects from this type of attack; thus making it vulnerable. You can easily patch this though.

How does this work?

GetFocusedTextBox allows you to get the current focused textbox, so if you are modifying the Name attribute of a Remote, for example. This can detect that and see whether that is legitimate or not, and therefore detect Synapse-made GUIs
--]]

-- // Services
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- //
RunService:BindToRenderStep("DetectGUI", 0, function()
    -- // Vars
    local FocusedTextBox = UserInputService:GetFocusedTextBox()

    -- // Make sure there actually is one
    if not (FocusedTextBox) then
        return
    end

    -- // Get the descendant - e.g. CoreGui.DarkDex.Whatever -> {CoreGui, DarkDex, Whatever}
    local Path = FocusedTextBox:GetFullName():split(".")
    local Descendant = Path[1]

    -- // Check if descendant of CoreGui and if not a ROBLOX GUI
    if (Descendant == "CoreGui" and Path[2] ~= "RobloxGui") then
        print("Detected:", FocusedTextBox:GetFullName())
    end
end)