-- // Information
--[[
    This is a modified version of the Synapse Script Dumper
]]

-- // Services
local RobloxReplicatedStorage = game:GetService("RobloxReplicatedStorage")
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local Chat = game:GetService("Chat")

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")

-- // Configuration
local Configuration = {
    Scripts = {"LocalScript", "ModuleScript"},
	Remotes = {"RemoteEvent", "RemoteFunction", "BindableEvent", "BindableFunction"},
	Services = {"StarterPlayerScripts", "StarterCharacterScripts"},
	Replace = {["'"] = "&apos;", ["\""] = "&quot;", ["<"] = "&lt;", [">"] = "&gt;", ["&"] = "&amp;"},
	Threads = 5,
	Version = 4,

    Ignored = {
        RobloxReplicatedStorage,
        CoreGui,
        CorePackages,
        Chat
    },

    StringFormats = {
        Welcome = "Welcome to savescirpts vee%d!",
        DecompilingScripts = "Decompiling %d scripts...",
        DecompilingScriptsProgress = "Decompiling scripts... (%d / %d)",
        FileSave = "Scripts for %s (%d) [%d].rbxlx",
        FinalOutput = "Scripts have been saved to file %q, took %d seconds for %d scripts"
    },

    Strings = {
        Credits = "stefanu1k2 hub when?",
        CollectingScripts = "Collecting scripts...",
        CreatingXMLLayout = "Creating XML Layout...",
        DecompileFail = "-- Failed to decompile script, or script is empty",
        DecompileFailTimeout = "-- Failed to decompile script (timed out)"
    }
}

-- // Vars
local CurrentCamera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local GameInfo = MarketplaceService:GetProductInfo(game.PlaceId)
local GameName = GameInfo.Name:gsub("[^%w%s]", "")
local Viewport = CurrentCamera.ViewportSize

-- // Forward decleration
local Output
local Hierarchy
local ScriptCount
local DoneScripts
local NeedsDecompile
local LoadedIds

-- // Ignore others
for _, Player in ipairs(Players:GetPlayers()) do
    if (Player ~= LocalPlayer) then
        table.insert(Configuration.Ignored, Player)
        table.insert(Configuration.Ignored, Player.Character)
    end
end

-- // Drawings
local CompleteBar = Drawing.new("Square")
CompleteBar.Filled = true
CompleteBar.Size = Vector2.new(500, 25)
CompleteBar.Position = Vector2.new(Viewport.X / 2 - CompleteBar.Size.X / 2, Viewport.Y - 100)
CompleteBar.Color = Color3.new(0, 0, 0)

local ProgressBar = Drawing.new("Square")
ProgressBar.Color = Color3.new(1, 1, 1)
ProgressBar.Filled = true
ProgressBar.Position = CompleteBar.Position
ProgressBar.Size = Vector2.new(0, 25)
ProgressBar.Color = Color3.new(1, 1, 1)

local ProgressText = Drawing.new("Text")
ProgressText.Color = Color3.new(1, 1, 1)
ProgressText.Center = true
ProgressText.Size = ProgressBar.Size.Y
ProgressText.Position = ProgressBar.Position + Vector2.new(CompleteBar.Size.X / 2, 35)
ProgressText.Color = Color3.new(1, 1, 1)

local Credits = Drawing.new("Text")
Credits.Color = Color3.new(1, 1, 1)
Credits.Position = Vector2.new(Viewport.X - 100, Viewport.Y - 25)
Credits.Size = 15
Credits.Color = Color3.new(1, 1, 1)

-- // Check if an object is allowed
local function IsAllowed(Item)
-- // Loop through Ignored things
    for _, Object in ipairs(Configuration.Ignored) do
        -- // See if Ignored
        if (Item == Object or Item:IsDescendantOf(Object)) then
            -- // Return
            return false
        end
    end

    -- // Return
	return true
end

-- // Get the parents of object
local function GetParentTree(Object)
    -- // Vars
    local trees = {}

    -- // Make sure have a parent to go to
    while (Object.Parent ~= nil and Object.Parent ~= game) do
        -- //
        Object = Object.Parent

        -- // Add
        table.insert(trees, 1, Object)
    end

    -- // Return
	return trees
end

-- // Get a script and add it to the Hierarchy
function GetScripts(Objects, CheckLoaded)
    -- // Loop through objects
    for _, Object in ipairs(Objects) do
        -- // Make sure is an instance and is allowed
        if (typeof(Object) == "Instance" and IsAllowed(Object)) then
            -- // Vars
            local ObjectClassName = Object.ClassName

            -- // Make sure is something we want to save
            if (table.find(Configuration.Remotes, ObjectClassName) or table.find(Configuration.Scripts, ObjectClassName)) then
                -- // Vars
                local ObjectDebugId = Object:GetDebugId()

                -- //
                if (Object.Parent == nil) then
                    Hierarchy["NIL"].Children[ObjectDebugId] = {Class = ObjectClassName, Ref = Object, Children = {}}
                else
                    -- // Vars
                    local Start = Hierarchy

                    -- // Loop through parents of object
                    for _, Branch in ipairs(GetParentTree(Object)) do
                        -- // Vars
                        local BranchDebugId = Branch:GetDebugId()
                        local BranchClassName = Branch.ClassName

                        -- //
                        if (Start[BranchDebugId] == nil) then
                            -- // Make sure service exists
                            if (game:FindService(BranchClassName) or table.find(Configuration.Services, BranchClassName)) then
                                Start[BranchDebugId] = {Class = BranchClassName, Ref = Branch, Children = {}}
                            else
                                Start[BranchDebugId] = {Class = "Folder", Ref = Branch, Children = {}}
                            end
                        end

                        -- //
                        Start = Start[BranchDebugId].Children
                    end

                    -- //
                    Start[ObjectDebugId] = {Class = ObjectClassName, Ref = Object, Children = {}}
                end

                -- // Check if loaded
                if (CheckLoaded) then
                    if (table.find(Configuration.Scripts, ObjectClassName) and not table.find(LoadedIds, ObjectDebugId)) then
                        Hierarchy["LOADED MODULES"].Children[ObjectDebugId] = {Class = ObjectClassName, Ref = Object, Children = {}}
                    end
                else
                    table.insert(LoadedIds, ObjectDebugId)
                end
            end
        end
    end

    -- // Return
    return Hierarchy
end

-- //
local function MakeInstance(ClassName, Name, Object)
    -- //
    table.insert(Output, '<Item class="' .. ClassName .. '" referent="RBX' .. #Output .. '"><Properties>')
    table.insert(Output, '<string name="Name">' .. Name:gsub("['\"<>&]", Configuration.Replace) .. '</string>')

    -- //
    if (Object and table.find(Configuration.Scripts, Object.ClassName)) then
        -- //
        if (Object.ClassName == "LocalScript") then
            table.insert(Output, '<bool name="Disabled">' .. tostring(Object.Disabled) .. '</bool>')
        end

        -- //
        table.insert(Output, '<ProtectedString name="Source"><![CDATA[')
        table.insert(Output, "") -- // haha funny stole from moon
        table.insert(Output, ']]></ProtectedString>')

        -- //
        table.insert(NeedsDecompile, {Script = Object, Index = #Output - 1})
    end

    -- //
    table.insert(Output, "</Properties>")
end

-- //
local function SaveHierarchy(Tree)
    -- // Loop through tree
    for Name, Object in pairs(Tree) do
        -- // Vars
        local ObjectRef = Object.Ref
        local ObjectName = ObjectRef and ObjectRef.Name or Name

        -- // Make instance, save it and add to Output
        MakeInstance(Object.Class, ObjectName, ObjectRef)
        SaveHierarchy(Object.Children)
        table.insert(Output, "</Item>")
    end
end

-- // Main function
local function Main(_Configuration)
    -- // Start Timer
    local StartTime = tick()

    -- // Default values
    Configuration = _Configuration or Configuration

    Output = {'<roblox xmlns:xmime="http://www.w3.org/2005/05/xmlmime" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.roblox.com/roblox.xsd" version="4">'}
    Hierarchy = {["NIL"] = {Class = "Folder", Children = {}}, ["LOADED MODULES"] = {Class = "Folder", Children = {}}}

    ScriptCount = 0
    DoneScripts = 0
    NeedsDecompile = {}
    LoadedIds = {}

    -- // Set drawings stuff
    ProgressText.Text = Configuration.StringFormats.Welcome:format(Configuration.Version)
    Credits.Text = Configuration.Strings.Credits

    ProgressBar.Visible = true
    CompleteBar.Visible = true
    Credits.Visible = true
    ProgressText.Visible = true
    wait(1)

    -- // Collect all the scripts
    ProgressText.Text = Configuration.Strings.CollectingScripts
    GetScripts(game:GetDescendants())
    GetScripts(getnilinstances())
    GetScripts(getloadedmodules(), true)
    LoadedIds = nil
    wait(1)

    -- // Create XML Layout
    ProgressText.Text = Configuration.Strings.CreatingXMLLayout
    SaveHierarchy(Hierarchy)
    ScriptCount = #NeedsDecompile
    table.insert(Output, "</roblox>")
    wait(0.5)

    -- // Start Decompiling
    ProgressText.Text = Configuration.StringFormats.DecompilingScripts:format(ScriptCount)
    local RunningCount = Configuration.Threads

    -- // Start Threads
    for i = 1, Configuration.Threads do
        task.spawn(function()
            -- //
            while (#NeedsDecompile > 0) do
                -- // Vars
                local Data = table.remove(NeedsDecompile)
                local DecompileStartTime = tick()
                local result

                -- // Decompile
                task.spawn(function()
                    result = decompile(Data.Script, false, 30)
                end)

                -- // Wait until we have a decompiled script or not (default decompiler timeout isn't reliable)
                repeat
                    wait()
                until result ~= nil or tick() - DecompileStartTime >= 30

                -- // Script decompile failsure
                if (result ~= nil) then
                    Output[Data.Index] = (result == "" and Configuration.Strings.DecompileFail or result)
                else
                    Output[Data.Index] = Configuration.Strings.DecompileFailTimeout
                end
                wait()

                -- // Update
                DoneScripts = DoneScripts + 1
                ProgressBar.Size = Vector2.new(500 * DoneScripts / ScriptCount, ProgressBar.Size.Y)
                ProgressText.Text = Configuration.StringFormats.DecompilingScriptsProgress:format(DoneScripts, ScriptCount)
            end

            -- //
            RunningCount = RunningCount - 1
        end)
    end

    -- // Wait for decompiling to finish
    while (RunningCount > 0) do
        wait(0.5)
    end
    wait(1)

    -- //
    ProgressBar.Visible = false
    CompleteBar.Visible = false

    -- // Vars
    local saveName = Configuration.StringFormats.FileSave:format(GameName, game.PlaceId, os.time())

    -- // Save file
    writefile(saveName, table.concat(Output, "\n"))

    -- // Output
    ProgressText.Text = Configuration.StringFormats.FinalOutput:format(saveName, tick() - StartTime, ScriptCount)
    wait(5)

    -- // Remove all
    Credits.Visible = false
    ProgressText.Visible = false
end

-- // Return
return Main