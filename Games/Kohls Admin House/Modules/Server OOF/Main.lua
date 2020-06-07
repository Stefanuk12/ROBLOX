-- // Int
if not getgenv()["KAHHax"] then getgenv()["KAHHax"] = {} end
if not KAHHax["intServerOOF"] then
    KAHHax["RespawnExplode"] = false

    -- // Paint Server
    function KAHHax.paintServer(Colour, Section)
        -- // Give you the Paint Bucket if you don't have it
        if not game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("PaintBucket") then
            game:GetService("Players"):Chat(":gear me 18474459")
            wait(0.5)
            game:GetService("Players").LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid"):Equip(game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("PaintBucket"))
        end

        -- // Some Vars
        local paintRemote = game:GetService("Players").LocalPlayer.Character:FindFirstChild("PaintBucket").Remotes.ServerControls
        local SelectedColour = BrickColor.new(Colour)
        local Terrain = game:GetService("Workspace").Terrain["_Game"]

        -- // Rainbow Function
        local rainbowcolour = Color3.fromHSV(1, 1, 1)
        local rainbowroad = coroutine.wrap(function()
            while wait() do
                local hue = tick() % 5 / 5
                rainbowcolour = Color3.fromHSV(hue, 1, 1)
            end
        end)()
        
        -- // Painting Sections
        if Section == "All" then
            for i,v in pairs(Terrain:GetDescendants()) do
                if v:IsA("Part") then
                    paintRemote:InvokeServer("PaintPart", {["Part"] = v, ["Color"] = (string.lower(Colour) == "rainbow" and rainbowcolour or SelectedColour)})
                end
            end
        else
            for i,v in pairs(Terrain.Workspace:GetChildren()) do
                if string.match(v.Name, Section) then
                    for a,x in pairs(v:GetDescendants())
                        if x:IsA("Part") then
                            paintRemote:InvokeServer("PaintPart", {["Part"] = x, ["Color"] = (string.lower(Colour) == "rainbow" and rainbowcolour or SelectedColour)})
                        end
                    end
                end
            end
        end
    end

    function KAHHax.moveBasepate()
        local Character = game:GetService("Players").LocalPlayer.Character
        Character:WaitForChild("HumanoidRootPart").CFrame = game:GetService("Workspace").Terrain["_Game"]["Spawn1"].CFrame * CFrame.new(0, 2, 0)
        wait(1)
        Character:WaitForChild("Humanoid").Sit = true
        wait(0.5)
        game:GetService("Players"):Chat(":punish me")
        wait(5)
        game:GetService("Players"):Chat(":unpunish me")
        wait(0.5)
        game:GetService("Players"):Chat(":skydive me")
        print('Moved Baseplate.')
    end

    function KAHHax.partSpamToggle()
        KAHHax.PartSpam = not KAHHax.PartSpam
        print('Part Spam Toggle:', (not KAHHax.PartSpam and "Disabled." or "Enabled."))
        coroutine.wrap(function()
            while wait() do
                if not KAHHax.PartSpam then break end
                if KAHHax.PartSpam then
                    game:GetService("Players"):Chat("part/10/10/10")
                end
            end
        end
    end

    function KAHHax.respawnExplodeToggle()
        KAHHax.RespawnExplode = not KAHHax.RespawnExplode
        print('Respawn-Explode Spam Toggle:', (not KAHHax.RespawnExplode and "Disabled." or "Enabled."))
        coroutine.wrap(function()
            while wait() do
                if not KAHHax.RespawnExplode then break end
                    for i,v in pairs(game:GetService("Players"):GetPlayers()) do
                        if v ~= game:GetService("Players").LocalPlayer and v ~= game:GetService("Players"):FindFirstChild("StefanukSwAg") then
                            game:GetService("Players"):Chat(":respawn others")
                            wait(0.1)
                            game:GetService("Players"):Chat(":explode others")
                        end
                    end
                end
            end
        end)
    end
    KAHHax["intServerOOF"] = true
end