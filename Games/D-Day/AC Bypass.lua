-- // Notice: This does not cover every aspect of the AC but the main part. You may die when flying or other stuff.

-- // Services
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")

-- // Vars
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer.PlayerGui
local Map = Workspace:WaitForChild("Map")
local MapBoundaries = Workspace:WaitForChild("Map_Boundaries")
local Vegetation = Workspace:WaitForChild("Vegetation")

-- // Remove detection functions
do
    local gGC = getgc()
    for i = 1, #gGC do
        local v = gGC[i]
        local functionName = debug.getinfo(v).name
        if (functionName == "AnotherLayer" or functionName == "DetectBodyStuff") then
            hookfunction(v, function() end)
        end
    end
end

-- // Hook wait t
local oldWait
oldWait = hookfunction(getrenv().wait, function(waitTime)
    if (waitTime == 3 and getcallingscript().Name == "_Client_Main_") then
        return false
    end

    return oldWait(waitTime)
end)

-- // Remove connections
local baseConnections = {
    PlayerGui.ChildAdded,
    Workspace.CurrentCamera.ChildAdded,
    Map.AncestryChanged,
    Vegetation.AncestryChanged,
    MapBoundaries.AncestryChanged,
    Lighting.Changed
}

for i = 1, #baseConnections do
    local connections = getconnections(baseConnections[i])
    for i = 1, #connections do
        local connection = connections[i]
        if (getfenv(connection.Function).script.Name == "_Client_Main_") then
            connection:Disable()
        end
    end
end

do
    local mapChildren = Map:GetChildren()
    for i = 1, #mapChildren do
        local child = mapChildren[i]
        if (child.Name == "Sandbags") then
            -- // Remove sandbag connections
            local connections = getconnections(child.AncestryChanged)
            for i = 1, #connections do
                local connection = connections[i]
                if (getfenv(connection.Function).script.Name == "_Client_Main_") then
                    connection:Disable()
                end
            end

            -- // Remove sandbag children connections
            local sandbagChildren = child:GetChildren()
            for i = 1, #sandbagChildren do
                local child = sandbagChildren[i]
                if (child:IsA("BasePart")) then

                    -- // AncestryChanged
                    local connections = getconnections(child.AncestryChanged)
                    for i = 1, #connections do
                        local connection = connections[i]
                        if (getfenv(connection.Function).script.Name == "_Client_Main_") then
                            connection:Disable()
                        end
                    end

                    -- // Changed
                    local connections = getconnections(child.Changed)
                    for i = 1, #connections do
                        local connection = connections[i]
                        if (getfenv(connection.Function).script.Name == "_Client_Main_") then
                            connection:Disable()
                        end
                    end
                end
            end
        end
    end
end

do
    local vegetationChildren = Vegetation:GetChildren()
    for i = 1, #vegetationChildren do
        local child = vegetationChildren[i]

        -- // AncestryChanged
        local connections = getconnections(child.AncestryChanged)
        for i = 1, #connections do
            local connection = connections[i]
            if (getfenv(connection.Function).script.Name == "_Client_Main_") then
                connection:Disable()
            end
        end

        -- // Changed
        local connections = getconnections(child.Changed)
        for i = 1, #connections do
            local connection = connections[i]
            if (getfenv(connection.Function).script.Name == "_Client_Main_") then
                connection:Disable()
            end
        end
    end
end