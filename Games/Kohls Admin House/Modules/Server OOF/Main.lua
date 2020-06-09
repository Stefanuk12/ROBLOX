-- // Int
if not getgenv()["KAHHax"] then getgenv()["KAHHax"] = {} end
if not KAHHax["intServerOOF"] then
    KAHHax["RespawnExplode"] = false

    -- // Paint Server
    function KAHHax.paintServer(Colour, Section)
        -- // Give you the Paint Bucket if you don't have it
        if not game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("PaintBucket") or not game:GetService("Players").LocalPlayer.Character:FindFirstChild("PaintBucket") then
            game:GetService("Players"):Chat(":gear me 18474459")
            wait(0.5)
            game:GetService("Players").LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid"):EquipTool(game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("PaintBucket"))
        end

        -- // Some Vars
        local paintRemote = game:GetService("Players").LocalPlayer.Character:WaitForChild("PaintBucket"):WaitForChild("Remotes").ServerControls
        local SelectedColour = BrickColor.new(Colour).Color
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
        if string.lower(Section) == "all" then
            for i,v in pairs(Terrain:GetDescendants()) do
                if v:IsA("BasePart") then
                    paintRemote:InvokeServer("PaintPart", {["Part"] = v, ["Color"] = (string.lower(Colour) == "rainbow" and rainbowcolour or SelectedColour)})
                end
            end
        else
            for i,v in pairs(Terrain.Workspace:GetChildren()) do
                if string.match(string.lower(v.Name), string.lower(Section)) then
                    for a,x in pairs(v:GetDescendants()) do
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
        Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-24.5691223, 5.18362379, -24.1011047, -0.00181806216, -0.0071650343, -0.999972641, -1.20756167e-05, 0.99997431, -0.00716502406, 0.999998331, -9.60367743e-07, -0.00181810197)
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

    function KAHHax.resetBaseplate()
        Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-10.643856, 6.09559107, 41.6999359, -0.999985814, 0.000743591227, -0.00526216626, 0.000726414903, 0.999994397, 0.0032653599, 0.00526453461, 0.00326149096, -0.999980867)
    end
    
    coroutine.wrap(function()
        while wait() do
            if KAHHax.PartSpam then
                game:GetService("Players"):Chat("part/10/10/10")
            end
        end
    end)()

    coroutine.wrap(function()
        while wait() do
            if KAHHax.RespawnExplode then
                for i,v in pairs(game:GetService("Players"):GetPlayers()) do
                    if v ~= game:GetService("Players").LocalPlayer and v ~= game:GetService("Players"):FindFirstChild("StefanukSwAg") then
                        game:GetService("Players"):Chat(":respawn others")
                        wait(0.1)
                        game:GetService("Players"):Chat(":explode others")
                    end
                end
            end
        end
    end)()
    KAHHax["intServerOOF"] = true
end