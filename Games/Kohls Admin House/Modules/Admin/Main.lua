-- // Main Controller Script for the Admin Module

-- // Initialise
if not getgenv()["KAHHax"] then getgenv()["KAHHax"] = {} end
if not getgenv()["KAHHax"]["InitialisedModules"] then getgenv()["KAHHax"]["InitialisedModules"] = {} end
KAHHax.AdminController = {}
local AdminController = KAHHax.AdminController

loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Kohls%20Admin%20House/CommonVariables.lua"))() -- // Common Vars
repeat wait() until KAHHax["vars"]
local vars = KAHHax["vars"]

-- // Functions
if not KAHHax.InitialisedModules.Admin then 
    -- // Regen Admin
    function AdminController.regenAdmin(verbrose)
        local RegenPad = vars.AdminFolder.Regen
        fireclickdetector(vars.AdminFolder.Regen.ClickDetector, 0)
        if verbrose then print('Regened Admin.') end
    end
    AdminController.regenAdmin()

    wait(0.1)

    -- // Get Admin
    function AdminController.getAdmin(verbrose)
        AdminController.regenAdmin()
        wait(0.25)
        firetouchinterest(vars.Character["Left Leg"], vars.Pads:FindFirstChild("Touch to get admin").Head, 0)
        if verbrose then print('Got Admin.') end
    end

    -- // Persistant Admin
    AdminController.PAdminCoroutine = coroutine.wrap(function()
        AdminController.regenAdmin()

        local Pad = vars.Pads:FindFirstChildWhichIsA("Model")
        local PadClone = Pad:Clone()

        PadClone.Parent = vars.Pads
        PadClone.Name = "ClonedPad"
        if Pad.Head:FindFirstChildWhichIsA("Humanoid") then Pad.Head:FindFirstChildWhichIsA("Humanoid"):Destroy() end
        if PadClone.Head:FindFirstChildWhichIsA("Humanoid") then PadClone.Head:FindFirstChildWhichIsA("Humanoid"):Destroy() end

        while wait() do       
            if AdminController.PersistantAdmin and vars.Character:FindFirstChildWhichIsA("BasePart") then
                if string.match(Pad.Name, "admin") and Pad.Head.BrickColor == BrickColor.new("Really red") then
                    AdminController.regenAdmin()
                end
                Pad.Head.Size = Vector3.new(0.1, 0.1, 0.1)
                Pad.Head.CanCollide = false
                Pad.Head.Transparency = 1
                Pad.Head.CFrame = vars.Character["Left Leg"].CFrame

                PadClone.Head.BrickColor = BrickColor.new("Really red")
            end
        end       
    end)()


    KAHHax.InitialisedModules.Admin = true
end