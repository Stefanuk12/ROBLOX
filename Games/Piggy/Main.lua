
-- // Game: https://www.roblox.com/games/4623386862

-- don't bully me for code ok, i made a while ago and isnt updated btw

if game.PlaceId == 4623386862 then
    local PiggyItemList = {
        ["BlueKey"] = {
            ["SpecialMesh"] = {
                ["MeshId"] = "rbxassetid://456878024",
                ["Scale"] = Vector3.new(5, 5, 5),
                ["VertexColor"] = Vector3.new(1, 1, 1)
            },
            ["ParticleEmitter"] = {
                ["Color"] = "0 0 1 1 0 1 0 1 1 0 ",
            },
            ["Category"] = 'Keys',
        },
        ["OrangeKey"] = {
            ["SpecialMesh"] = {
                ["MeshId"] = "rbxassetid://456878024",
                ["Scale"] = Vector3.new(5, 5, 5),
                ["VertexColor"] = Vector3.new(1, 1, 1)
            },
            ["ParticleEmitter"] = {
                ["Color"] = "0 1 0.333333 0 0 1 1 0.333333 0 0 ",
            },
            ["Category"] = 'Keys',
        },
        ["GreenKey"] = {
            ["SpecialMesh"] = {
                ["MeshId"] = "rbxassetid://456878024",
                ["Scale"] = Vector3.new(5, 5, 5),
                ["VertexColor"] = Vector3.new(1, 1, 1)
            },
            ["ParticleEmitter"] = {
                ["Color"] = "0 0 1 0 0 1 0 1 0 0 ",
            },
            ["Category"] = 'Keys',
        },
        ["RedKey"] = {
            ["SpecialMesh"] = {
                ["MeshId"] = "rbxassetid://456878024",
                ["Scale"] = Vector3.new(5, 5, 5),
                ["VertexColor"] = Vector3.new(1, 1, 1)
            },
            ["ParticleEmitter"] = {
                ["Color"] = "0 1 0 0 0 1 1 0 0 0 ",
            },
            ["Category"] = 'Keys',
        },
        ["YellowKey"] = {
            ["SpecialMesh"] = {
                ["MeshId"] = "rbxassetid://456878024",
                ["Scale"] = Vector3.new(5, 5, 5),
                ["VertexColor"] = Vector3.new(1, 1, 1)
            },
            ["ParticleEmitter"] = {
                ["Color"] = "0 1 1 0 0 1 1 1 0 0 ",
            },
            ["Category"] = 'Keys',
        },
        ["WhiteKey"] = {
            ["SpecialMesh"] = {
                ["MeshId"] = "rbxassetid://456878024",
                ["Scale"] = Vector3.new(5, 5, 5),
                ["VertexColor"] = Vector3.new(1, 1, 1)
            },
            ["ParticleEmitter"] = {
                ["Color"] = "0 1 1 1 0 1 1 1 1 0 ",
            },
            ["Category"] = 'Keys',
        },
        ["PurpleKey"] = {
            ["SpecialMesh"] = {
                ["MeshId"] = "rbxassetid://456878024",
                ["Scale"] = Vector3.new(5, 5, 5),
                ["VertexColor"] = Vector3.new(1, 1, 1)
            },
            ["ParticleEmitter"] = {
                ["Color"] = "0 0.666667 0.333333 1 0 1 0.666667 0.333333 1 0 ",
            },
            ["Category"] = 'Keys',
        },
        ["Hammer"] = {
            ["SpecialMesh"] = {
                ["MeshId"] = "http://www.roblox.com/asset/?id=16198309",
                ["Scale"] = Vector3.new(1.2, 1.2, 1.2),
                ["VertexColor"] = Vector3.new(1, 1, 1)
            },
            ["ParticleEmitter"] = {
                ["Color"] = "0 1 1 1 0 1 1 1 1 0 ",
            },
            ["Category"] = 'Others',
        },
        ["Wrench"] = {
            ["SpecialMesh"] = {
                ["MeshId"] = "http://www.roblox.com/asset/?id=16884681",
                ["Scale"] = Vector3.new(0.6, 0.6, 0.6),
                ["VertexColor"] = Vector3.new(1, 1, 1)
            },
            ["ParticleEmitter"] = {
                ["Color"] = "0 1 1 1 0 1 1 1 1 0 ",
            },
            ["Category"] = 'Others',
        },
        ["Gun"] = {
            ["SpecialMesh"] = {
                ["MeshId"] = "http://www.roblox.com/asset/?id=72012879",
                ["Scale"] = Vector3.new(1.25, 1.25, 1.25),
                ["VertexColor"] = Vector3.new(2, 2, 2)
            },
            ["ParticleEmitter"] = {
                ["Color"] = "0 1 1 1 0 1 1 1 1 0 ",
            },
            ["Category"] = 'Weapons',
        },
        ["RedGear"] = {
            ["SpecialMesh"] = {
                ["MeshId"] = "rbxassetid://524706126",
                ["Scale"] = Vector3.new(0.025, 0.025, 0.025),
                ["VertexColor"] = Vector3.new(1, 1, 1)
            },
            ["ParticleEmitter"] = {
                ["Color"] = "0 1 1 1 0 1 1 1 1 0 ",
                ["Category"] = 'Gears',
            },
        },
        ["GreenGear"] = {
            ["SpecialMesh"] = {
                ["MeshId"] = "rbxassetid://524706126",
                ["Scale"] = Vector3.new(0.025, 0.025, 0.025),
                ["VertexColor"] = Vector3.new(1, 1, 1)
            },
            ["ParticleEmitter"] = {
                ["Color"] = "0 0.333333 0.666667 0 0 1 0.333333 0.666667 0 0 ",
                ["Category"] = 'Gears',
            },
        },
        ["WaterGun"] = {
            ["SpecialMesh"] = {
                ["MeshId"] = "rbxassetid://1771168429",
                ["Scale"] = Vector3.new(0.5, 0.5, 0.4),
                ["VertexColor"] = Vector3.new(1, 1, 1)
            },
            ["ParticleEmitter"] = {
                ["Color"] = "0 1 1 1 0 1 1 1 1 0 ",
            },
            ["Category"] = 'Weapons',
        },
        ["Mallet"] = {
            ["SpecialMesh"] = {
                ["MeshId"] = "http://www.roblox.com/asset/?id=120607730",
                ["Scale"] = Vector3.new(1, 1, 1),
                ["VertexColor"] = Vector3.new(1, 1, 1)
            },
            ["ParticleEmitter"] = {
                ["Color"] = "0 1 1 1 0 1 1 1 1 0 ",
            },
            ["Category"] = 'Weapons',
        },
        ["Gas"] = {
            ["ParticleEmitter"] = {
                ["Color"] = "0 1 0 0 0 1 1 0 0 0 "
            },
        },
        ["BlueKeycard"] = {
            ["ParticleEmitter"] = {
                ["Color"] = "0 0 1 1 0 1 0 1 1 0 "
            },
            ["Category"] = 'Others',
        },
        ["RedKeycard"] = {
            ["ParticleEmitter"] = {
                ["Color"] = "0 1 0 0 0 1 1 0 0 0 "
            },
            ["Category"] = 'Others',
        },
        ["OrangeKeycard"] = {
            ["ParticleEmitter"] = {
                ["Color"] = "0 1 0.333333 0 0 1 1 0.333333 0 0 "
            },
            ["Category"] = 'Others',
        },
        ["KeyCode"] = {
            ["ParticleEmitter"] = {
                ["Color"] = "0 1 1 1 0 1 1 1 1 0 "
            },
            ["Category"] = 'Others',
        },
        ["Crossbow"] = {
            ["SpecialMesh"] = {
                ["MeshId"] = "http://www.roblox.com/asset/?id=15886761",
                ["Scale"] = Vector3.new(0.4, 0.4, 0.4),
                ["VertexColor"] = Vector3.new(1, 1, 1)
            },
            ["ParticleEmitter"] = {
                ["Color"] = "0 1 1 1 0 1 1 1 1 0 ",
            },
            ["Category"] = 'Weapons',
        },
        ["TNT"] = {
            ["SpecialMesh"] = {
                ["MeshId"] = "http://www.roblox.com/asset/?id=27787143",
                ["Scale"] = Vector3.new(0.3, 0.3, 0.3),
                ["VertexColor"] = Vector3.new(1, 1, 1)
            },
            ["ParticleEmitter"] = {
                ["Color"] = "0 0.666667 0 0 0 1 0.666667 0 0 0 ",
            },
            ["Category"] = 'Weapons',
        },
        ["FireExtinguisher"] = {
            ["SpecialMesh"] = {
                ["MeshId"] = "http://www.roblox.com/asset/?id=27787143",
                ["Scale"] = Vector3.new(1, 1, 1),
                ["VertexColor"] = Vector3.new(1, 1, 1)
            },
            ["ParticleEmitter"] = {
                ["Color"] = "0 0.666667 0 0 0 1 0.666667 0 0 0 ",
            },
            ["Category"] = 'Others',
        },
    }
    piggyItems = {}
    WSSAPES = 30
    local PiggyItemCatagories = {
        ["Keys"] = true,
        ["Gears"] = true,
        ["Weapons"] = true,
        ["Others"] = true
    }
   
    local piggyMaps = {
        ["House"] = {
            ["MapName"] = "House",
        },
        ["Station"] = {
            ["MapName"] = "Station",
        },
        ["Gallery"] = {
            ["MapName"] = "Gallery",
        },
        ["Forest"] = {
            ["MapName"] = "Forest",
        },
        ["School"] = {
            ["MapName"] = "School",
        },
        ["Hospital"] = {
            ["MapName"] = "Hospital",
        },
        ["Metro"] = {
            ["MapName"] = "Metro",
        },
        ["Carnival"] = {
            ["MapName"] = "Carnival",
        },
        ["City"] = {
            ["MapName"] = "City",
        },
    }
    piggyEventList = {
        ["BlueDoor"] = {
            ["Color"] = Color3.fromRGB(0, 255, 255),
            ["Unlock"] = {
                ["SoundId"] = "rbxassetid://4381793351",
            },
            ["ToolRequired"] = "BlueKey",
        },
        ["GreenDoor"] = {
            ["Color"] = Color3.fromRGB(0, 255, 0),
            ["Unlock"] = {
                ["SoundId"] = "rbxassetid://4381793351",
            },
            ["ToolRequired"] = "GreenKey",
        },
        ["RedDoor"] = {
            ["Color"] = Color3.fromRGB(255, 0, 0),
            ["Unlock"] = {
                ["SoundId"] = "rbxassetid://4381793351",
            },
            ["ToolRequired"] = "RedKey",
        },
        ["OrangeDoor"] = {
            ["Color"] = Color3.fromRGB(213, 115, 61),
            ["Unlock"] = {
                ["SoundId"] = "rbxassetid://4381793351",
            },
            ["ToolRequired"] = "OrangeKey",
        },
        ["FrontDoor"] = {
            ["Color"] = Color3.fromRGB(108, 88, 75),
            ["Unlock"] = {
                ["SoundId"] = "rbxassetid://4381793351",
            },
            ["ToolRequired"] = "WhiteKey",
        },
        ["EscapeTrigger"] = {
            ["Color"] = Color3.fromRGB(248, 248, 248),
            ["Unlock"] = {
                ["SoundId"] = "rbxassetid://4381793351",
            },
            ["ToolRequired"] = "None",
        },
        ["EscapeDoor"] = {
            ["Color"] = Color3.fromRGB(255, 0, 0),
            ["Unlock"] = {
                ["SoundId"] = "rbxassetid://4381793351",
            },
            ["ToolRequired"] = "None",
        },
    }
    piggyEvents = {}

    noclip = true
    game:GetService("RunService").Stepped:Connect(function()
        if game:GetService("Players").LocalPlayer.Character ~= nil and game:GetService("Players").LocalPlayer.Character:FindFirstChild("Torso") then 
            for i,v in pairs(game:GetService("Players").LocalPlayer.Character:GetDescendants()) do 
                if v:IsA("Part") then
                    v.CanCollide = (not noclip)
                end
            end
        end
    end)

    function bypassAC()
        if game:GetService("Workspace").GameFolder.Phase.Value == "GameInProgress" then
            if workspace.CurrentCamera.CameraSubject == game:GetService("Players").LocalPlayer.Character.Humanoid then 
                for i,v in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do 
                    if v.Name ~= "Health" and v:IsA("Script") then 
                        local scriptname = v.Name
                        if string.match(scriptname, "%d+") then 
                            v:Destroy()
                            return true
                        end
                    end
                end
            end
        else
            print('Game has not started yet!')
            return false
        end
    end
    bypassAC()
    game:GetService("Players").LocalPlayer.Character.ChildAdded:Connect(bypassAC)
    
    function checkGameProgressPiggy() -- Checks if the game is in progress
        if game:GetService("Workspace").GameFolder.Phase.Value == "GameInProgress" and workspace.CurrentCamera.CameraSubject == game:GetService("Players").LocalPlayer.Character.Humanoid then
            return true
        else
            print('Game has not started yet!')
            return false
        end
    end

	function getMapPiggy() -- Gets the Map
        map = nil
        if checkGameProgressPiggy() then
            for i,v in pairs(piggyMaps) do
                for a,x in pairs(game:GetService("Workspace"):GetChildren()) do
                    if piggyMaps[x.Name] ~= nil then
                        return x
                    end
                end
            end
        end
	end

    function getItemFolderPiggy()
        for i,v in pairs(workspace:GetDescendants()) do
            if v.Name == 'ItemPickupScript' and v.Parent.Parent:IsA("Folder") then
                return v.Parent.Parent
			end
        end
    end

	function getEventsFolder()
		if checkGameProgressPiggy() then 
			for i,v in pairs(getMapPiggy():GetDescendants()) do 
				if v:IsA("SpecialMesh") and v.Parent:IsA("Part") then
					return v.Parent.Parent.Parent.Parent
				end 
			end
		end
    end
    
    function removeTraps()
        if checkGameProgressPiggy() then
            pcall(function()
                getEventsFolder().ChildAdded:Connect(function()
                    for i,v in pairs(getEventsFolder():GetDescendants()) do
                        if v:IsA("Sound") and v.SoundId == 'rbxassetid://3763440389' then
                            if v.Parent.Parent:IsA("Model") then
                                v:Destroy()
                            end
                        end
                        if v:IsA("Part") and v.Color == Color3.new(163, 162, 165) then
                            if v.Parent:IsA("Folder") and v:FindFirstChildWhichIsA("Script") then
                                v:Destroy()
                            end
                        end
                    end
                end)
                getItemFolderPiggy().ChildAdded:Connect(function()
                    for i,v in pairs(getItemFolderPiggy():GetDescendants()) do
                        if v:IsA("SpecialMesh") and v.MeshId == 'rbxassetid://470962113' and v.Scale == Vector3.new(0.009, 0.009, 0.009) then
                            v.Parent:Destroy()
                        end
                    end
                end)
            end)
        end
    end

    function indexEventsPiggy()
        if checkGameProgressPiggy() then
            local eventsfolder = getEventsFolder()
            for i,v in pairs(eventsfolder:GetDescendants()) do
                if v:IsA("SpecialMesh") then
                    if v.MeshId == 'rbxassetid://524497312' and v.Scale == Vector3.new(0.75, 0.5, 0.75) and v.VertexColor == Vector3.new(1, 1, 1) then
                        for a,x in pairs(piggyEventList) do
                            if v.Parent.Parent:FindFirstChildWhichIsA("StringValue").Value == piggyEventList[a]["ToolRequired"] then
								piggyEvents[a] = {
                                    ["Part"] = v.Parent.Parent
                                }
                            end
                        end
                    end
                end
                if v:IsA("Part") and v.DataCost == 25 then
                    if v:FindFirstChildWhichIsA("Script") then
                        piggyEvents["EscapeTrigger"] = {
                            ["Part"] = v
                        }
                    end
                end
            end
        end
    end

    function indexItemPiggy(item)
        for i,v in pairs(PiggyItemList) do
            for a,x in pairs(item:GetDescendants()) do
                if x:IsA('SpecialMesh') and PiggyItemList[i]["SpecialMesh"] then
                    if tostring(x.MeshId) == PiggyItemList[i]["SpecialMesh"]["MeshId"] and x.Scale == PiggyItemList[i]["SpecialMesh"]["Scale"] and x.VertexColor == PiggyItemList[i]["SpecialMesh"]["VertexColor"] then 
						if x.Parent:FindFirstChildWhichIsA("ParticleEmitter") then
                            x = x.Parent:FindFirstChildWhichIsA("ParticleEmitter")
							if tostring(x.Color) == PiggyItemList[i]["ParticleEmitter"]["Color"] then
								piggyItems[i] = {
                                    ["Part"] = x.Parent,
                                    ["Category"] = PiggyItemList[i]["Category"]
                                }
                            end
                        end
                    end
                elseif x:IsA('SurfaceGui') then
                    piggyItems["KeyCode"] = {
                        ["Part"] = x.Parent,
                        ["Category"] = "Others"
                    }
                elseif x:IsA("UnionOperation") then
                    if tostring(x.ParticleEmitter.Color) == PiggyItemList["Gas"]["ParticleEmitter"]["Color"] then
                        piggyItems["Gas"] = {
                            ["Part"] = x.Parent,
                            ["Category"] = 'Others'
                        }
                    elseif tostring(x.ParticleEmitter.Color) == PiggyItemList["BlueKeycard"]["ParticleEmitter"]["Color"] then
                        piggyItems["BlueKeycard"] = {
                            ["Part"] = x.Parent,
                            ["Category"] = 'Others'
                        }
                    end
                end
            end
        end
    end

    function updatePiggyTables()
        if getItemFolderPiggy() == nil then
            piggyItems = nil
        else
            for i,v in pairs(getItemFolderPiggy():GetDescendants()) do
                indexItemPiggy(v)
            end
        end
        if getEventsFolder() == nil then
            piggyEvents = nil
        else
            indexEventsPiggy()
            if piggyEvents["FrontDoor"] then
                local x = piggyEvents["FrontDoor"]["Part"]
                for i,v in pairs(x:GetDescendants()) do
                    if v:IsA("StringValue") then
                        if v.Value == "Wrench" then
                            piggyEvents["PowerPanel"] = {
                                ["Part"] = v.Parent
                            }
						end
						if v.Value == "KeyCode" then
                            piggyEvents["NumberLock"] = {
                                ["Part"] = v.Parent
                            }
                        end
                    end
                end
            end
        end
    end

    function gameCheckPiggy(typeplayer)
        if typeplayer == 'Survivor' then
            if checkGameProgressPiggy() and not game:GetService("Players").LocalPlayer.Character:FindFirstChild("IsStunned") then
                return true
            else
                return false
            end
        elseif typeplayer == 'Piggy' then
            if checkGameProgressPiggy() and game:GetService("Players").LocalPlayer.Character:FindFirstChild("IsStunned") then
                return true
            else
                return false
            end
        end
    end

    local hum = game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid")
    game:GetService("RunService"):BindToRenderStep("WSSAPES", 0, function()
        hum.WalkSpeed = WSSAPES
    end)

    function clickItem(item)
        fireclickdetector = fireclickdetector or click_detector
        if item ~= nil and item:FindFirstChild("ClickDetector") then 
            item.ClickDetector.MaxActivationDistance = math.huge
            fireclickdetector(item.ClickDetector, 0)
        end
    end

    function tpToItemPlacePiggy(place)
        if checkGameProgressPiggy() then
            local hrp = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
            local map = getMapPiggy().Name
            noclip = true
            hrp.CFrame = piggyMaps[map][place]
            noclip = false
        end
    end

    function itemToPlace(itemname)
		if itemname == 'Hammer' then
            return "FrontDoor"
		elseif itemname == 'WhiteKey' then 
			return "FrontDoor"
        elseif itemname == 'Wrench' then
            return "PowerPanel"
        elseif itemname == 'KeyCode' then
            return "NumberLock"
        end
        local colour = string.match(itemname, "Red") or string.match(itemname, "Blue") or string.match(itemname, "Orange") or string.match(itemname, "Green")
        if colour ~= nil then
			return tostring(colour.."Door")
        end
    end

    function tpToItemPiggy(itemname, clickitem, tpback, gotoplace, waittime)
        updatePiggyTables()
		local hrp = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
        local humanoid = game:GetService("Players").LocalPlayer.Character.Humanoid
        local backpack = game:GetService("Players").LocalPlayer.Backpack
        humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
        local savedpos = hrp.CFrame
        if checkGameProgressPiggy() then
			updatePiggyTables()
            wait(0.25)
            WSSAPES = 500
            noclip = true
			if piggyItems[itemname] then
				hrp.CFrame = piggyItems[itemname]["Part"].CFrame
				if clickitem then 
					wait(0.25)
                    clickItem(piggyItems[itemname]["Part"])
                    wait(0.25)
                    humanoid:EquipTool(backpack[itemname])
				end
                wait(0.3)
                if tpback and not gotoplace then
                    wait(waittime)
                    hrp.CFrame = savedpos
                end
                wait(0.3)
                if gotoplace and not tpback then
                    wait(waittime)
                    updatePiggyTables()
                    if piggyEvents[itemToPlace(itemname)] then
                        hrp.CFrame = piggyEvents[itemToPlace(itemname)]["Part"].CFrame + Vector3.new(1, 0, 1)
                        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                    end
                end
			else
				warn('TP Failed!')
            end
            WSSAPES = 30
            noclip = false
        end
    end

    function piggyAIGodmode()
        if gameCheckPiggy("Survivor") then
            for i,v in pairs(game:GetService("Workspace"):GetDescendants()) do
                if v:IsA("BoolValue") and v.Name == "Enemy" and v.Value == true and not game:GetService("Players"):FindFirstChild(v.Parent.Name) then 
                    local v = v.Parent
                    local savedparent = v.Parent
                    for a,x in pairs(v:GetDescendants()) do 
                        if x:IsA("TouchTransmitter") then 
                            x:Destroy()
                            v.Parent = nil
                            v.Parent = savedparent
                            print("rip", v.Parent.Name)
                        end
                    end
                end
            end
        end
    end

    function tableContains(tbl, element) -- Checks if a table has a certain thing
        for _, v in ipairs(tbl) do
            if (rawequal(v, element)) then
                return true
            end
        end
        return false
    end

    nonkilledplayers = {}
    plrarray = game:GetService("Players"):GetPlayers()

    function autoFarmPiggy()
        if checkGameProgressPiggy() then
            if gameCheckPiggy("Piggy") then
                for i=1,#plrarray do
                    table.insert(nonkilledplayers, plrarray[i].Name)
                end
                for i,v in pairs(plrarray) do
                    if tableContains(nonkilledplayers, v.Name) then
                        WSSAPES = 500
                        noclip = true
                        if game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Character") and v.Character:FindFirstChild("HumanoidRootPart") then
                            game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
                            wait(3)
                            for i = 1, #nonkilledplayers do
                                if nonkilledplayers[i] == v then
                                    table.remove(plrs, i)
                                end
                            end
                        end
                        WSSAPES = 30
                        noclip = false
                    end
                end
            else
                removeTraps()
                if getMapPiggy() and getMapPiggy().Name ~= "Forest" then
                    tpToItemPiggy("Wrench", true, false, true, 1)
                    wait(1)
                    tpToItemPiggy("WhiteKey", true, false, true, 1)
                    wait(1)
                    tpToItemPiggy("Hammer", true, false, true, 1)
                    wait(1)
                    tpToItemPiggy("KeyCode", true, false, true, 1)
                end
            end
        end
    end

	autoFarmPiggy()
	--tpToItemPiggy("WhiteKey", true, false, true, 1)
	--tpToItemPiggy("KeyCode", true, false, true, 1)
	--tpToItemPiggy("Hammer", true, false, true, 1)
    --print(WSSAPES)
	--updatePiggyTables()
	--print(piggyEvents[itemToPlace("KeyCode")])
end