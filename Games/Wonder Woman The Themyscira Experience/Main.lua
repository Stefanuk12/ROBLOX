-- // Just uhh, don't mind the errors!
local Rat = workspace.InteractiveWorldElements.SpawnZones.SpawnZones_Rats
local killRatToggle = true
function intRatQuest()
    local v1 = "ArmoryAmazon01NPCInteractible"
    local v2 = game:GetService("Workspace").NPCs.QuestNPCs.Artemis.InteractionZone
    local rem = game:GetService("ReplicatedStorage").RemoteEvents.OnPlayerInteraction
    rem:FireServer(v1, v2); wait(0.1)
    local v1 = "CorruptedRatsQuestPrompt"
    local rem = game:GetService("ReplicatedStorage").RemoteEvents.OnAcceptedPromptRemoteEvent
    rem:FireServer(v1); wait(0.1)
    local v1 = "Corrupted Rats"
    local rem = game:GetService("ReplicatedStorage").RemoteFunctions.UnlockQuestRemoteFunction
    rem:InvokeServer(v1); wait(0.1)
    local v1 = "Corrupted Rats"
    local rem = game:GetService("ReplicatedStorage").RemoteFunctions.HideQuestNewIconRemoteFunction
    rem:InvokeServer(v1); wait(0.1)
    local v1 = "AmazonWarrior01NPCInteractible"
    local v2 = game:GetService("Workspace").NPCs.QuestNPCs.Aella.InteractionZone
    local rem = game:GetService("ReplicatedStorage").RemoteEvents.OnPlayerInteraction
    rem:FireServer(v1, v2); wait(0.1)
    local v1 = "AmazonWarrior01NPCInteractible"
    local rem = game:GetService("ReplicatedStorage").RemoteEvents.OnEndedDialogRemoteEvent
    rem:FireServer(v1); wait(0.1)
end
function killDeRats()
    pcall(function()
        if not killRatToggle then return end
        intRatQuest()
        for i,v in pairs(Rat:GetDescendants()) do
            if v and v.Name == "RatMesh" then
                if firetouchinterest then
                    firetouchinterest(game:GetService("Players").LocalPlayer.Character.PrimaryPart, v, 0); wait()
                    firetouchinterest(game:GetService("Players").LocalPlayer.Character.PrimaryPart, v, 1)
                else 
                    game:GetService("Players").LocalPlayer.Character.PrimaryPart.CFrame = v.CFrame
                end
                local v1 = "Corrupted Rats"
                local rem = game:GetService("ReplicatedStorage").RemoteFunctions.CollectQuestRewardRemoteFunction
                rem:InvokeServer(v1)
                wait(1)
            end
        end
    end)
end
killDeRats()
Rat.DescendantAdded:Connect(killDeRats)