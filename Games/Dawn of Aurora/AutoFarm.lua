-- //
repeat
    wait()
until game:IsLoaded()

-- // Services
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Teams = game:GetService("Teams")

-- // Vars
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer.PlayerGui

-- // Wait until game is loaded
repeat
    wait(1)
until not (PlayerGui:FindFirstChild("LoadingScreen"))

local Modules = ReplicatedStorage.Modules

local PlayerData = require(Modules.ReplicatedData.PlayerData)

local JobBoards = Workspace.StaticEntity.JobBoards

local QuestManager = require(Modules.Quest.QuestManager)

local QuestIdTemplate = LocalPlayer.Name .. "_quest_"

local DataReplicator = require(Modules.Util.DataReplicator)
local Quests = debug.getupvalue(DataReplicator.constructor, 3)

local Entity = Modules.Entity
local EntityManager = require(Entity.EntityManager)
local EntityCar =  Entity.EntityCar
local RequireEntityCar = require(EntityCar)
local EntityCarC = EntityCar.C
local CPacketNextWaveInput = ReplicatedStorage.Networking.JobQuestUI.CPacketNextWaveInput
local CPacketTakeCollisionDamage = EntityCarC.CPacketTakeCollisionDamage
local CPacketReplicateCollision = EntityCarC.CPacketReplicateCollision

local JobQuestPizzaDeliveryC = require(Modules.Quest.JobQuest.JobQuestPizzaDelivery.C)

local CPacketStartJobQuest = ReplicatedStorage.Networking.CPacketStartJobQuest

local JobSummary = PlayerGui.GameGuiStatic.JobSummary
local WaveSummary = JobSummary.ScaledContent["Wave_Summary"]
local EndSummary = JobSummary.ScaledContent["End_Summary"]
local Summary = EndSummary.Summary

local FinishedTemplate = "Finished Round %d. Time: %s | Score: %s | VS$: %s | Wave %s"

local MainMenuStatic = PlayerGui.GameGuiStatic.MainMenuStatic
local SelectTeam = ReplicatedStorage.Networking.SelectTeam
local CitizensTeam = Teams.Citizen

-- // Configuration
local DawnAutoFarm = {
    Enabled = true,
    WaveTarget = 15,
    ScoreTarget = 240000,
    WaitTime = 0
}
getgenv().DawnAutoFarm = DawnAutoFarm

-- // Get TitleScreenObject and exitWithSelection
for _, v in ipairs(getgc(true)) do
    if (typeof(v) == "table") then
        if (rawget(v, "context") == "TitleScreen") then
            TitleScreenObject = v
            continue
        end

        if (rawget(v, "selectedTeamIndex")) then
            exitWithSelection = v.props.exitWithSelection
            continue
        end
    end
end

-- // Get a quest
local function GetQuest(QuestId)
    -- // Vars
    local Quest = Quests[QuestIdTemplate .. QuestId]

    -- // Return
    return Quest
end

-- // Get into a PizzaPlanetTruck
local function GetPizzaPlanetTruck(EntityId, GetInside)
    -- //
    local Truck

    -- // Find and get the Truck
    local EntityData = EntityManager.GetEntityByID(EntityId) or {}
    Truck = EntityData.instance

    -- //
    if (GetInside and Truck) then
        -- // Teleport to it
        LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = Truck.Body.CFrame

        -- // Wait
        wait(1)

        -- // Get inside
        EntityCarC.CPacketBeginEnterSeat:FireServer(Truck, os.clock() - 1)
        EntityCarC.CPacketEnterSeat:FireServer(Truck, Truck.Seats.Driver, os.clock())
    end

    -- // Return the truck
    return Truck
end

-- // Teleport a vehicle
local function TeleportVehicle(Vehicle, _CFrame)
    -- // Vars
    --local Pivot = Vehicle:GetPivot()

    -- // Teleport
    Vehicle:PivotTo(_CFrame)
end

-- // Start new wave if screen is there
local function StartWave()
    -- // Check if it is there
    if (JobSummary.Visible) then
        if (WaveSummary.Visible) then
            -- // Start
            CPacketNextWaveInput:FireServer()

            -- //
            return true
        end
    end

    -- // Return
    return false
end

-- // End the job
local function EndJob()
    -- // Check if it is there
    if (JobSummary.Visible) then
        if (EndSummary.Visible) then
            -- // End
            firesignal(EndSummary.ContinueButton.Capture.MouseButton1Click)

            -- //
            return true
        end
    end

    -- // Return
    return false
end

-- // Gets the cooldown for a job
local function GetJobCooldown(JobId)
    -- // Vars
    local QuestType = QuestManager.GetQuestType(JobId)
    local LocalPlayerData = PlayerData.Get(LocalPlayer)
    local Cooldown = QuestType:GetJobCooldown(LocalPlayerData)

    -- // Return
    return Cooldown
end

-- // Gets the pizza job
local function GetPizzaJob()
    -- // Vars
    local JobId = "JobQuestPizzaDelivery"

    -- // Check cooldown
    local Cooldown = GetJobCooldown(JobId)
    if not (Cooldown == 0) then
        return false, Cooldown
    end

    -- // Vars
    local JobBoard = JobBoards.Board012["2.0"]

    -- // Teleport to board
    LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = JobBoard:WaitForChild("Screen").CFrame

    -- // Get job
    CPacketStartJobQuest:FireServer(JobId)

    -- // Return
    return true, Cooldown
end

-- // Get Job Results
local function GetJobResults()
    -- // Vars
    local ScorePay = Summary.Score_Pay
    local Stats = Summary.Stats:GetChildren()

    -- //
    local ReturnValue = {
        Score = ScorePay.Score.Amount.Text,
        Pay = ScorePay.Pay.Amount.Text
    }

    -- // Loop through Stats
    for _, v in pairs(Stats) do
        -- // Ignore the UI List Layout
        if not (v:IsA("Frame")) then
            continue
        end

        -- // Parse description
        local Description = v.Description.Text:gsub(":", ""):gsub(" ", "")

        -- // Add to table
        ReturnValue[Description] = v.Amount.Text
    end

    -- //
    return ReturnValue
end

-- // Teleport to delivery target
local function TeleportToTarget(Truck, Location, Offset)
    -- // Vars
    local Height = 1200

    local LocationPosition = Location.Position
    local EmptyLocation = Location - Location.Position

    local HumanoidRootPart = LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame
    local HumanoidRootPartPosition = HumanoidRootPart.Position
    local EmptyHumanoidRootPart = HumanoidRootPart - HumanoidRootPartPosition

    local Magnitude = (LocationPosition - HumanoidRootPartPosition).Magnitude

    -- //
    if (Magnitude > 15) then
        -- // Go up to 200 height
        TeleportVehicle(Truck, EmptyHumanoidRootPart + Vector3.new(HumanoidRootPartPosition.X, Height, HumanoidRootPartPosition.Z))
        wait(0.1)

        -- // Go to location but with 200 height
        TeleportVehicle(Truck, EmptyLocation + Vector3.new(LocationPosition.X, Height, LocationPosition.Z))
        wait(0.1)

        -- // Go down
        TeleportVehicle(Truck, Location + Offset)
    end

    -- // Start new wave attempt
    StartWave()
end

-- // Join Team (if main menu)
do
    -- // Make sure the Main Menu is visible and auto farm is on
    if not (MainMenuStatic.Visible and DawnAutoFarm.Enabled) then
        return
    end

    -- //
    local ClickAnywhere = MainMenuStatic.GameNews.ClickAnywhere
    firesignal(ClickAnywhere.MouseButton1Click)

    -- //
    local Play = MainMenuStatic.TitleScreen["Main_Buttons"].Play
    firesignal(Play.MouseButton1Click)

    -- //
    for _, v in ipairs(getgc(true)) do
        if (typeof(v) == "table") then
            if (rawget(v, "selectedTeamIndex")) then
                rawset(v, "selectedTeamIndex", 4)
            end
        end
    end

    -- //
    local Join = MainMenuStatic:WaitForChild("TeamSelectionTemp").ScaledContent.TeamInfo.Buttons.Join
    firesignal(Join.MouseButton1Click)

    -- // Wait for character
    LocalPlayer.CharacterAdded:Wait()
end

-- // Deliver Pizza
local function DeliverPizza(Quest, Truck, DidCanCollide)
    -- // Get the quest
    Quest = Quest or GetQuest("JobQuestPizzaDelivery")

    -- // Check if we got it
    if not (Quest) then
        warn("Quest not found")
        return EndJob()
    end

    -- // Vars
    local deliveryStarted = Quest:Get("deliveryStarted")
    local Data = Quest.data
    local TotalTargets = JobQuestPizzaDeliveryC.WAVE_DATA[Data.currentWave].targets
    local GotTargets = Data.deliveriesCompletedInWave
    Truck = Truck or GetPizzaPlanetTruck(Data.spawnedVehicleID, not deliveryStarted)

    -- // Check score
    if (Data.score >= DawnAutoFarm.ScoreTarget) then
        -- // Getting out of the seat
        local Humanoid = LocalPlayer.Character.Humanoid
        Humanoid.Jump = true
        Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)

        -- // Wait until results have shown
        EndSummary:GetPropertyChangedSignal("Visible"):Wait()

        -- //
        warn("Force ending job, reached target score")
        return true
    end

    -- // Make sure we have a truck
    if not (Truck) then
        -- // Restart
        return DeliverPizza(Quest, Truck, DidCanCollide)
    end

    -- // Check Wave and Targets
    if (Data.currentWave >= DawnAutoFarm.WaveTarget and GotTargets >= TotalTargets) or (EndSummary.Visible and EndJob()) then
        warn("Job finished - " .. GotTargets .. "/" .. TotalTargets .. " targets")
        return true
    end

    -- // Wait until we have target
    repeat
        -- // Wait
        wait(DawnAutoFarm.WaitTime)

        -- // Workaround
        if (GotTargets + 1 >= TotalTargets and StartWave()) then
            break
        end
    until #Data.activeDeliveryTargets > 0 or Data.queuedDeliveryTarget or GotTargets >= TotalTargets

    -- // Teleport to targets
    local Offset = Vector3.new(0, 2, 0)
    for _, DeliveryTarget in ipairs(Data.activeDeliveryTargets) do
        TeleportToTarget(Truck, DeliveryTarget.location, Offset)
    end

    -- // Teleport to target
    local queuedDeliveryTarget = Data.queuedDeliveryTarget
    if (queuedDeliveryTarget) then
        TeleportToTarget(Truck, queuedDeliveryTarget.location, Offset)
    end

    -- // Restart
    return DeliverPizza(Quest, Truck, DidCanCollide)
end

-- //
task.spawn(function()
    -- // Vars
    local Round = 1
    local Debounce = false

    -- // Constant loop
    pcall(function()
        while (true) do wait()
            -- // Check if auto farm is on
            if (DawnAutoFarm.Enabled) then
                -- // Get the job
                local GotJob, Cooldown = GetPizzaJob()
                if not (GotJob) then
                    if not (Debounce) then
                        print("Waiting for cooldown (" .. Cooldown .. ")...")
                        Debounce = true
                    end

                    continue
                end

                -- //
                Debounce = false
                print("Starting Round " .. Round .. "...")

                -- // Wait
                wait(1)

                -- // Deliver pizza and complete the job
                local Success = DeliverPizza()
                if (Success) then
                    -- // Wait
                    wait(0.1)

                    -- // Remove screen
                    EndJob()

                    -- // Print
                    local Results = GetJobResults()
                    local PrintReuslt = FinishedTemplate:format(Round, Results.ElapsedTime, Results.Score, Results.Pay, Results.WavesCompleted)
                    print(PrintReuslt)

                    Round = Round + 1

                    -- // Disable noclip for truck
                end
            end
        end
    end)
end)

-- // Vehicle God Mode

-- // Hook
hookfunction(RequireEntityCar.TakeDamage, function()
    return wait(9e9)
end)

-- // Hook
local FireServer
FireServer = hookfunction(Instance.new("RemoteEvent").FireServer, function(...)
    -- // Vars
    local args = {...}
    local self = args[1]

    -- //
    if (self == CPacketReplicateCollision or self == CPacketTakeCollisionDamage) then
        return
    end

    -- //
    return FireServer(...)
end)

-- //
local function onCharacter(Character)
    local Humanoid = Character:WaitForChild("Humanoid")

    while (LocalPlayer.Team ~= CitizensTeam and DawnAutoFarm.Enabled) do
        SelectTeam:FireServer("team_citizen")

        wait(3)
    end
end
LocalPlayer.CharacterAdded:Connect(onCharacter)
print("Loaded! This original version is a co-op between Koriyuka#4800 & Stefanuk12#5820")
