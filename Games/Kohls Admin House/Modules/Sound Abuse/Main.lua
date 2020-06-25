-- // Main Controller Script for the Sound Abuse Module

-- // Initialise
if not getgenv()["KAHHax"] then getgenv()["KAHHax"] = {} end
if not getgenv()["KAHHax"]["InitialisedModules"] then getgenv()["KAHHax"]["InitialisedModules"] = {} end

loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Kohls%20Admin%20House/CommonVariables.lua"))() -- // Common Vars
repeat wait() until KAHHax["vars"]

KAHHax.SoundAbuseController = {}
local SoundAbuseController = KAHHax.SoundAbuseController
local vars = KAHHax["vars"]

if not KAHHax.InitialisedModules.SoundAbuse then
    SoundAbuseController.EarRape = false

    function SoundAbuseController.playAllSounds()
        for i,v in pairs(game:GetService("Workspace"):GetDescendants()) do
            if v:IsA("Sound") then
                v:Play()
            end
        end
        vars.Notify('Played All Sounds.')
    end
    function SoundAbuseController.stopAllSounds()
        for i,v in pairs(game:GetService("Workspace"):GetDescendants()) do
            if v:IsA("Sound") then
                v:Stop()
            end
        end
        vars.Notify('Stopped All Sounds.')
    end
    function SoundAbuseController.playMusic()
        if vars.HolderFolder:FindFirstChildWhichIsA("Sound") then
            vars.HolderFolder:FindFirstChildWhichIsA("Sound"):Play()
        end
        vars.Notify('Played Music.')
    end
    function SoundAbuseController.stopMusic()
        if vars.HolderFolder:FindFirstChildWhichIsA("Sound") then
            vars.HolderFolder:FindFirstChildWhichIsA("Sound"):Stop()
        end
        vars.Notify('Stopped Music.')
    end
    SoundAbuseController.mainCoroutine = coroutine.wrap(function()
        while wait(0.25) do
            if SoundAbuseController.EarRape then
                SoundAbuseController.playAllSounds()
            end
        end
    end)()


    KAHHax.InitialisedModules.SoundAbuse = true
end