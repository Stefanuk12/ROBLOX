-- Decompiled with the Synapse X Luau decompiler.

if collectgarbage ~= nil and collectgarbage("count") >= 30000 then
	local l__UPVAL_0__1.Parent = game;
	l__UPVAL_0__1:FireServer("Gamer", "Not Gamer", "High Memory Usage");
	l__UPVAL_0__1.Parent = nil;
end;

-- Decompiled with the Synapse X Luau decompiler.

if local l__UPVAL_0__1.Character and l__UPVAL_0__1.Character.Humanoid.Health > 0 then
	local function v2()
		local l__UPVAL_1__3.Parent = game;
		l__UPVAL_1__3:FireServer("Gamer", "Not Gamer", "Remote Event Removal");
		l__UPVAL_1__3.Parent = nil;
	end;
	if not l__UPVAL_0__1.Character.CharacterHandler.Events:FindFirstChild("Fall") then
		v2();
	end;
	if not l__UPVAL_0__1.Character.CharacterHandler.Events:FindFirstChild("Mouse") then
		v2();
	end;
	if not l__UPVAL_0__1.Character.CharacterHandler.Events:FindFirstChild("Mana") then
		v2();
	end;
	if not l__UPVAL_0__1.Character.CharacterHandler.Events:FindFirstChild("Sun") then
		v2();
	end;
	if not l__UPVAL_0__1.Character.CharacterHandler.Events:FindFirstChild("Input") then
		v2();
	end;
	if not l__UPVAL_0__1.Character.CharacterHandler.Events:FindFirstChild("Combat") then
		v2();
	end;
end;



-- Decompiled with the Synapse X Luau decompiler.

local l__UPVAL_0__1.Parent = game;
l__UPVAL_0__1:FireServer("Gamer", "Not Gamer", "Gravity Exploit");
l__UPVAL_0__1.Parent = nil;




-- Decompiled with the Synapse X Luau decompiler.

local l__UPVAL_0__1.Parent = game;
l__UPVAL_0__1:FireServer("Gamer", "Not Gamer", "Gravity Exploit");
l__UPVAL_0__1.Parent = nil;




-- Decompiled with the Synapse X Luau decompiler.

local l__UPVAL_0__1.Parent = game;
l__UPVAL_0__1:FireServer("Gamer", "Not Gamer", "Gravity Exploit");
l__UPVAL_0__1.Parent = nil;


-- Decompiled with the Synapse X Luau decompiler.

while true do
	for v1, v2 in pairs(local l__UPVAL_0__3) do
		v2:Disconnect();
	end;
	script.Parent = nil;
	local l__UPVAL_1__4.Name = local l__UPVAL_2__5(100);
	script.Name = l__UPVAL_2__5(140);
	if l__UPVAL_1__4 then
		l__UPVAL_1__4.Parent = game;
		l__UPVAL_1__4:FireServer(l__UPVAL_2__5(10) .. local l__UPVAL_3__6:GenerateGUID(false) .. "gamer" .. l__UPVAL_3__6:GenerateGUID(false) .. "YORU??!" .. math.random(1, 999) .. "jR" .. l__UPVAL_3__6:GenerateGUID(false) .. "d");
		l__UPVAL_1__4.Parent = nil;
	end;
	if local l__UPVAL_4__7.Character ~= nil then
		pcall(function()
			if l__UPVAL_4__7.Character:FindFirstChild("Torso") then
				local v8 = l__UPVAL_4__7.Character.Torso:GetPropertyChangedSignal("CanCollide"):Connect(function()
					l__UPVAL_1__4.Parent = game;
					l__UPVAL_1__4:FireServer("Gamer", "Not Gamer", "Noclip Exploit");
					l__UPVAL_1__4.Parent = nil;
				end);
				table.insert(l__UPVAL_0__3, v8);
				if not v8.Connected or typeof(v8) ~= "RBXScriptConnection" then
					l__UPVAL_1__4.Parent = game;
					l__UPVAL_1__4:FireServer("Gamer", "Not Gamer", "Noclip Exploit");
					l__UPVAL_1__4.Parent = nil;
				end;
			end;
			if not l__UPVAL_4__7.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Died") then
				l__UPVAL_1__4.Parent = game;
				l__UPVAL_1__4:FireServer("Gamer", "Not Gamer", "No 'Died' sound found");
				l__UPVAL_1__4.Parent = nil;
			end;
		end);
		local v9 = l__UPVAL_4__7.Character.DescendantAdded:Connect(function(p1)
			if p1:IsA("BodyMover") then
				for v10, v11 in pairs((local l__UPVAL_5__12:GetTags(p1))) do
					if v11:find("\195\177") then
						return;
					end;
				end;
				l__UPVAL_1__4.Parent = game;
				l__UPVAL_1__4:FireServer("Gamer", "Not Gamer", "Body Mover Exploit");
				l__UPVAL_1__4.Parent = nil;
			end;
		end);
		table.insert(l__UPVAL_0__3, v9);
		if not v9.Connected or typeof(v9) ~= "RBXScriptConnection" then
			l__UPVAL_1__4.Parent = game;
			l__UPVAL_1__4:FireServer("Gamer", "Not Gamer", "Body Mover Exploit");
			l__UPVAL_1__4.Parent = nil;
		end;
		if l__UPVAL_4__7.Character:FindFirstChild("Humanoid") ~= nil then
			if not (not rawequal(l__UPVAL_4__7.Character.Humanoid.WalkSpeed, nil)) or not (not rawequal(l__UPVAL_4__7.Character.Humanoid.JumpPower, nil)) or not (not rawequal(l__UPVAL_4__7.Character.Humanoid.HipHeight, nil)) or typeof(l__UPVAL_4__7.Character.Humanoid.WalkSpeed) ~= "number" or typeof(l__UPVAL_4__7.Character.Humanoid.JumpPower) ~= "number" or typeof(l__UPVAL_4__7.Character.Humanoid.HipHeight) ~= "number" then
				l__UPVAL_1__4.Parent = game;
				l__UPVAL_1__4:FireServer("Gamer", "Not Gamer", "Walkspeed Exploit");
				l__UPVAL_1__4.Parent = nil;
			end;
			local v13 = l__UPVAL_4__7.Character.Humanoid.StateChanged:Connect(function(p2)
				if typeof(p2) == "EnumItem" then
					if p2 ~= Enum.HumanoidStateType.StrafingNoPhysics then
						return;
					end;
				else
					l__UPVAL_1__4.Parent = game;
					l__UPVAL_1__4:FireServer("Gamer", "Not Gamer");
					l__UPVAL_1__4.Parent = nil;
					return;
				end;
				l__UPVAL_1__4.Parent = game;
				l__UPVAL_1__4:FireServer("Gamer", "Not Gamer");
				l__UPVAL_1__4.Parent = nil;
			end);
			table.insert(l__UPVAL_0__3, v13);
			if not v13.Connected or typeof(v13) ~= "RBXScriptConnection" then
				l__UPVAL_1__4.Parent = game;
				l__UPVAL_1__4:FireServer("Gamer", "Not Gamer", "Noclip Exploit");
				l__UPVAL_1__4.Parent = nil;
			end;
			if l__UPVAL_4__7.Character.Humanoid.JumpPower > 51 then
				l__UPVAL_1__4.Parent = game;
				l__UPVAL_1__4:FireServer("Gamer", "Not Gamer", "Jump Power Exploit");
				l__UPVAL_1__4.Parent = nil;
			end;
			if l__UPVAL_4__7.Character.Humanoid.HipHeight > 0 then
				l__UPVAL_1__4.Parent = game;
				l__UPVAL_1__4:FireServer("Gamer", "Not Gamer", "Hip Height Exploit");
				l__UPVAL_1__4.Parent = nil;
			end;
			local v14 = l__UPVAL_4__7.Character.Humanoid:GetPropertyChangedSignal("HipHeight"):Connect(function()
				if l__UPVAL_4__7.Character.Humanoid.HipHeight > 0 then
					l__UPVAL_1__4.Parent = game;
					l__UPVAL_1__4:FireServer("Gamer", "Not Gamer", "Hip Height Exploit");
					l__UPVAL_1__4.Parent = nil;
				end;
			end);
			table.insert(l__UPVAL_0__3, v14);
			if not v14.Connected or typeof(v14) ~= "RBXScriptConnection" then
				l__UPVAL_1__4.Parent = game;
				l__UPVAL_1__4:FireServer("Gamer", "Not Gamer", "Hip Height Exploit");
				l__UPVAL_1__4.Parent = nil;
			end;
			local v15 = l__UPVAL_4__7.Character.Humanoid:GetPropertyChangedSignal("JumpPower"):Connect(function()
				if l__UPVAL_4__7.Character.Humanoid.JumpPower > 51 then
					l__UPVAL_1__4.Parent = game;
					l__UPVAL_1__4:FireServer("Gamer", "Not Gamer", "Jump Power Exploit");
					l__UPVAL_1__4.Parent = nil;
				end;
			end);
			table.insert(l__UPVAL_0__3, v15);
			if not v15.Connected or typeof(v15) ~= "RBXScriptConnection" then
				l__UPVAL_1__4.Parent = game;
				l__UPVAL_1__4:FireServer("Gamer", "Not Gamer", "Jump Power Exploit");
				l__UPVAL_1__4.Parent = nil;
			end;
			if l__UPVAL_4__7.Character.Humanoid.WalkSpeed > 75 then
				l__UPVAL_1__4.Parent = game;
				l__UPVAL_1__4:FireServer("Gamer", "Not Gamer", "Walkspeed Exploit");
				l__UPVAL_1__4.Parent = nil;
			end;
			local v16 = l__UPVAL_4__7.Character.Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
				if l__UPVAL_4__7.Character.Humanoid.WalkSpeed > 75 then
					l__UPVAL_1__4.Parent = game;
					l__UPVAL_1__4:FireServer("Gamer", "Not Gamer", "Walkspeed Exploit");
					l__UPVAL_1__4.Parent = nil;
				end;
			end);
			table.insert(l__UPVAL_0__3, v16);
			if not v16.Connected or typeof(v16) ~= "RBXScriptConnection" then
				l__UPVAL_1__4.Parent = game;
				l__UPVAL_1__4:FireServer("Gamer", "Not Gamer", "Walkspeed Exploit");
				l__UPVAL_1__4.Parent = nil;
			end;
		end;
	end;
	local v17 = local l__UPVAL_6__18.MessageOut:Connect(function(p3)
		if p3 == "Reviz Admin V2 loaded!" then
			l__UPVAL_1__4.Parent = game;
			l__UPVAL_1__4:FireServer("Gamer", "Not Gamer", "Reviz Admin Exploit");
			l__UPVAL_1__4.Parent = nil;
			return;
		end;
		if string.find(p3, "RemoteEvent called!") then
			l__UPVAL_1__4.Parent = game;
			l__UPVAL_1__4:FireServer("Gamer", "Not Gamer", "Remote Spy Exploit");
			l__UPVAL_1__4.Parent = nil;
		end;
	end);
	table.insert(l__UPVAL_0__3, v17);
	if not v17.Connected or typeof(v17) ~= "RBXScriptConnection" then
		l__UPVAL_1__4.Parent = game;
		l__UPVAL_1__4:FireServer("Gamer", "Not Gamer", "LogService Exploit");
		l__UPVAL_1__4.Parent = nil;
	end;
	local v19 = workspace:GetPropertyChangedSignal("Gravity"):Connect(function()
		l__UPVAL_1__4.Parent = game;
		l__UPVAL_1__4:FireServer("Gamer", "Not Gamer", "Gravity Exploit");
		l__UPVAL_1__4.Parent = nil;
	end);
	table.insert(l__UPVAL_0__3, v19);
	if not v19.Connected or typeof(v19) ~= "RBXScriptConnection" then
		l__UPVAL_1__4.Parent = game;
		l__UPVAL_1__4:FireServer("Gamer", "Not Gamer", "Gravity Exploit");
		l__UPVAL_1__4.Parent = nil;
	end;
	local v20 = local l__UPVAL_7__21.ChildAdded:Connect(function(p4)
		if p4:IsA("Sound") then
			l__UPVAL_1__4.Parent = game;
			l__UPVAL_1__4:FireServer("Gamer", "Not Gamer", "Sound in Lightning");
			l__UPVAL_1__4.Parent = nil;
		end;
	end);
	table.insert(l__UPVAL_0__3, v20);
	if not v20.Connected or typeof(v20) ~= "RBXScriptConnection" then
		l__UPVAL_1__4.Parent = game;
		l__UPVAL_1__4:FireServer("Gamer", "Not Gamer", "Lighting Exploit");
		l__UPVAL_1__4.Parent = nil;
	end;
	local v22 = local l__UPVAL_8__23.ChildAdded:Connect(function(p5)
		if p5:IsA("Sound") then
			l__UPVAL_1__4.Parent = game;
			l__UPVAL_1__4:FireServer("Gamer", "Not Gamer", "PolicyService Exploit");
			l__UPVAL_1__4.Parent = nil;
		end;
	end);
	table.insert(l__UPVAL_0__3, v22);
	if not v22.Connected or typeof(v22) ~= "RBXScriptConnection" then
		l__UPVAL_1__4.Parent = game;
		l__UPVAL_1__4:FireServer("Gamer", "Not Gamer", "PolicyService Exploit");
		l__UPVAL_1__4.Parent = nil;
	end;
	pcall(function()
		if l__UPVAL_4__7.Character and l__UPVAL_4__7.Character.Humanoid.Health > 0 then
			local function v24()
				l__UPVAL_1__4.Parent = game;
				l__UPVAL_1__4:FireServer("Gamer", "Not Gamer", "Remote Event Removal");
				l__UPVAL_1__4.Parent = nil;
			end;
			if not l__UPVAL_4__7.Character.CharacterHandler.Events:FindFirstChild("Fall") then
				v24();
			end;
			if not l__UPVAL_4__7.Character.CharacterHandler.Events:FindFirstChild("Mouse") then
				v24();
			end;
			if not l__UPVAL_4__7.Character.CharacterHandler.Events:FindFirstChild("Mana") then
				v24();
			end;
			if not l__UPVAL_4__7.Character.CharacterHandler.Events:FindFirstChild("Sun") then
				v24();
			end;
			if not l__UPVAL_4__7.Character.CharacterHandler.Events:FindFirstChild("Input") then
				v24();
			end;
			if not l__UPVAL_4__7.Character.CharacterHandler.Events:FindFirstChild("Combat") then
				v24();
			end;
		end;
	end);
	spawn(function()
		if collectgarbage ~= nil and collectgarbage("count") >= 30000 then
			l__UPVAL_1__4.Parent = game;
			l__UPVAL_1__4:FireServer("Gamer", "Not Gamer", "High Memory Usage");
			l__UPVAL_1__4.Parent = nil;
		end;
	end);
	wait(0.5);
end;