-- Game: https://roblox.com/games/21532277

-- // Valiant ENV
loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/ValiantENV.lua"))()

-- // Vars
local RenderStepped = RunService.RenderStepped
local Heartbeat = RunService.Heartbeat
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded.Wait(LocalPlayer.CharacterAdded)
local Humanoid = Character.WaitForChild(Character, "Humanoid")
local CurrentCamera = Workspace.CurrentCamera
local Mouse = LocalPlayer.GetMouse(LocalPlayer)
local NotorietyHax = {
    ByeByeBags = false,
    UnlimitedStamina = false,
}

-- // Functions

-- // MT
local mt = getrawmetatable(game)
local backupnamecall = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(...)
    local args = {...}
    local method = getnamecallmethod()
    local argschanged = false
    if method == "FireServer" then
        if tostring(args[1]) == "ThrowBag" and NotorietyHax.ByeByeBags then
            args[2] = Vector3.new(math.huge, math.huge, math.huge)
            argschanged = true
        end
    end

    if argschanged then return backupnamecall(unpack(args)) end
    return backupnamecall(...)
end)
