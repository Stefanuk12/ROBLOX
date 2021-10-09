-- // Configuration
if (not DecayHax) then
    getgenv().DecayHax = {}
end
local DecayHax = getgenv().DecayHax

-- // Dependencies
local Signal = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/Signal/main/Signal.lua"))()

-- // Services
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

-- // Vars
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local ask = Workspace.ServerStuff.ask

-- // Events
DecayHax.OnAsk = Signal.new("OnAsk")

-- // Hook
local __namecall
__namecall = hookmetamethod(game, "__namecall", function(...)
    -- // Vars
    local args = {...}
    local self = args[1]
    local method = getnamecallmethod()

    -- // See if is making new key
    if (method == "InvokeServer" and self == ask) then
        -- // Fire
        DecayHax.OnAsk:Fire()
    end

    -- //
    return __namecall(...)
end)

-- // Set the remote key
local function SetRemoteKeys()
    -- // Vars
    local Connections

    -- // Make sure we got the connection
    repeat wait()
        Connections = getconnections(Mouse.Button2Down)
    until #Connections > 0

    -- // To get the function we need
    for _, Connection in ipairs(Connections) do
        -- // Vars
        local ConnectionFunction = Connection.Function

        -- // Set
        DecayHax.RemoteKey = debug.getupvalue(ConnectionFunction, 8)
        DecayHax.RemoteKey2 = debug.getupvalue(ConnectionFunction, 9)

        -- //
        break
    end
end
SetRemoteKeys()

-- // See whenever game makes a new key
DecayHax.OnAsk:Connect(SetRemoteKeys)

-- // Return
return DecayHax