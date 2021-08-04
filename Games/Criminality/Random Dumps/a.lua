1 -- Decompiled with the Synapse X Luau decompiler.

local l__UPVAL_0__1:WaitForChild("Events"):WaitForChild("TheUltimatePunishmentMyGuy").OnClientEvent:Connect(function()
	local l__CoolFolder__2 = l__UPVAL_0__1.Storage.CoolFolder;
	local l__okgw__3 = l__CoolFolder__2.okgw;
	l__okgw__3.Parent = game.Players.LocalPlayer.PlayerGui;
	l__okgw__3:Play();
	for v4, v5 in pairs(workspace:GetChildren()) do
		local l__UPVAL_1__6(function()
			v5:Destroy();
		end);
	end;
	l__UPVAL_0__1:ClearAllChildren();
	local l__yee__7 = l__CoolFolder__2.yee;
	l__yee__7.Parent = workspace;
	local l__UPVAL_2__8:BindToRenderStep("theepicbind", Enum.RenderPriority.First.Value, function()
		workspace.CurrentCamera.CameraSubject = nil;
		workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable;
		workspace.CurrentCamera.CFrame = l__yee__7.Attachment.WorldCFrame;
	end);
end);



10 -- Decompiled with the Synapse X Luau decompiler.

local v1 = local l__UPVAL_0__2();
while true do
	local l__UPVAL_1__3(0.1);
	if local l__UPVAL_2__4.Character ~= nil and l__UPVAL_2__4.Character and local l__UPVAL_3__5:FindFirstChild(l__UPVAL_2__4.Character.Name) and l__UPVAL_2__4.Character:FindFirstChild("Humanoid") and l__UPVAL_2__4.Character.Humanoid:FindFirstChild("Animator") and l__UPVAL_2__4:HasAppearanceLoaded() then
		break;
	end;
	if l__UPVAL_0__2() - v1 >= 5 then
		break;
	end;
end;
if l__UPVAL_0__2() - v1 < 5 then
	local l__UPVAL_4__6(0.2);
end;
l__UPVAL_4__6(#l__UPVAL_2__4.Backpack:GetChildren() / 20);
return true;



31 -- Decompiled with the Synapse X Luau decompiler.

local l__UPVAL_0__1 = {};
local l__UPVAL_1__2 = {};
for v3, v4 in pairs(local l__UPVAL_2__5:GetDescendants()) do
	if v4:IsA("BasePart") then
		if v4.Transparency <= 0.1 and v4.CanCollide then
			table.insert(l__UPVAL_0__1, v4);
		end;
		if v4.Transparency <= 0.95 and v4.CanCollide then
			table.insert(l__UPVAL_1__2, v4);
		end;
	end;
end;
_G.MXMLXL = l__UPVAL_1__2;



32 -- Decompiled with the Synapse X Luau decompiler.

local l__Character__1 = local l__UPVAL_0__2.Character;
local v3 = l__Character__1 and l__Character__1:FindFirstChildOfClass("Humanoid");
for v4, v5 in ipairs(local l__UPVAL_1__6) do
	if v3 then
		v5.MaxDistance = v3.NameDisplayDistance;
	end;
end;



33 -- Decompiled with the Synapse X Luau decompiler.

local function v1(p1)
	p1:WaitForChild("CLoaded", 30);
	local l__NameGUI__2 = p1:WaitForChild("Head"):WaitForChild("NameGUI");
	local l__UPVAL_0__3[l__NameGUI__2] = l__NameGUI__2;
	local l__UPVAL_1__4();
	local u1 = nil;
	u1 = l__NameGUI__2.AncestryChanged:Connect(function(p2, p3)
		if not p3 then
			u1:Disconnect();
			l__UPVAL_0__3[l__NameGUI__2] = nil;
		end;
	end);
end;
local l__UPVAL_2__5.ChildAdded:Connect(v1);
for v6, v7 in pairs(l__UPVAL_2__5:GetChildren()) do
	v1(v7);
end;



35 -- Decompiled with the Synapse X Luau decompiler.

return local l__UPVAL_0__1.S, local l__UPVAL_1__2.S;



36 -- Decompiled with the Synapse X Luau decompiler.

local v1, v2 = local l__UPVAL_0__3();
local l__UPVAL_1__4.StaminaChange:Fire(v1, v2);



42 -- Decompiled with the Synapse X Luau decompiler.

local l__UPVAL_0__1.CantStamina:Fire();



43 -- Decompiled with the Synapse X Luau decompiler.

local l__UPVAL_0__1(function()
	if not local l__UPVAL_1__2.Loaded.Value then
		l__UPVAL_1__2.Loaded:GetPropertyChangedSignal("Value"):Wait();
	end;
end);



60 -- Decompiled with the Synapse X Luau decompiler.

local l__UPVAL_1__1.BlindSounds:ClearAllChildren();
for v2, v3 in pairs(local l__UPVAL_4__4) do
	local l__UPVAL_5__5(v3);
end;
for v6, v7 in pairs(_G.EffectsList) do
	l__UPVAL_5__5(v7);
end;
l__UPVAL_4__4 = {};
_G.EffectsList = {};



62 -- Decompiled with the Synapse X Luau decompiler.

local l__UPVAL_0__1 = local l__UPVAL_1__2(local l__UPVAL_2__3);
if not local l__UPVAL_3__4.Parent or not local l__UPVAL_4__5:FindFirstChild(l__UPVAL_3__4.Name) then
	script:Destroy();
end;
local l__UPVAL_5__6.Event:Connect(function()
	if l__UPVAL_3__4.Character and l__UPVAL_3__4.Character:FindFirstChildOfClass("Humanoid") then
		l__UPVAL_3__4.Character:FindFirstChildOfClass("Humanoid").Health = -10;
	end;
end);
l__UPVAL_3__4.AncestryChanged:Connect(function(p1, p2)
	if not p2 then
		if workspace:FindFirstChild("Map") then
			local l__UPVAL_6__7:Destroy();
		end;
		if workspace:FindFirstChild("Filter") then
			local l__UPVAL_7__8:Destroy();
		end;
		if workspace:FindFirstChild("Characters") then
			local l__UPVAL_8__9:Destroy();
		end;
		if workspace:FindFirstChild("Debris") then
			local l__UPVAL_9__10:Destroy();
		end;
		local l__UPVAL_10__11:ClearAllChildren();
		script:Destroy();
	end;
end);
local l__UPVAL_11__12 = Instance.new("Folder", l__UPVAL_9__10);
l__UPVAL_11__12.Name = "ToClear";
_G.FolderToClear = l__UPVAL_11__12;
_G.S_Take = local l__UPVAL_12__13;
_G.S_Get = local l__UPVAL_13__14;
_G.S_Check = local l__UPVAL_14__15;
_G.DownedCheck = local l__UPVAL_15__16;
_G.RagdollCheck = local l__UPVAL_16__17;
_G.AffectChar = local l__UPVAL_17__18;
_G.CheckIfCan = local l__UPVAL_18__19;
_G.cTag = local l__UPVAL_19__20;
_G.gTag = local l__UPVAL_20__21;
_G.CheckIfFlinching = local l__UPVAL_21__22;
_G.TeamCheck = local l__UPVAL_22__23;
_G.WaitForChar = local l__UPVAL_23__24;
_G.GVF = local l__UPVAL_24__25;
_G.WalkAnimFunc = local l__UPVAL_25__26;
_G.GamepassCheck = local l__UPVAL_26__27;
_G.PromptGamepass = local l__UPVAL_27__28;
_G.PromptProductPurchase = local l__UPVAL_28__29;
_G.InCombatCheck = local l__UPVAL_29__30;
_G.LimbCheck = local l__UPVAL_30__31;
_G.RagdollChar = local l__UPVAL_31__32;
_G.ForceChar = local l__UPVAL_32__33;
_G.IsAlive = false;
function _G.DoBodyGyroFunc(p3)
	local l__Character__34 = l__UPVAL_3__4.Character;
	local l__UPVAL_33__35(l__Character__34, l__Character__34 and l__Character__34:FindFirstChild("HumanoidRootPart"), l__Character__34 and l__Character__34:FindFirstChild("Humanoid"), l__UPVAL_24__25(), p3);
end;
l__UPVAL_10__11:WaitForChild("Values", 5);
l__UPVAL_10__11.Values.ServerTick.Changed:Connect(function()
	l__UPVAL_10__11.Values.ClientServerTick.Value = local l__UPVAL_34__36();
end);
l__UPVAL_10__11.Values.ClientServerTick.Value = l__UPVAL_34__36();
local l__UPVAL_35__37();
local l__UPVAL_36__38:WaitForChild("ChangeState").OnClientEvent:Connect(function(p4, p5, p6)
	if l__UPVAL_3__4.Character then
		local v39 = l__UPVAL_3__4.Character:FindFirstChildOfClass("Humanoid");
		if v39 then
			for v40 = 1, p5 do
				v39:ChangeState(p4, true);
				local l__UPVAL_37__41.Heartbeat:Wait();
			end;
		end;
	end;
end);
l__UPVAL_36__38:WaitForChild("PurchaseFinished").OnClientEvent:Connect(function(p7, p8, p9)
	if p9 then
		local v42 = Instance.new("BoolValue");
		v42.Name = p8;
		v42.Parent = local l__UPVAL_38__43.Gamepasses;
	end;
end);
l__UPVAL_36__38:WaitForChild("GetGamepasses").OnClientEvent:Connect(function(p10)
	for v44, v45 in pairs(p10) do
		if not l__UPVAL_38__43.Gamepasses:FindFirstChild(v45) then
			local v46 = Instance.new("BoolValue");
			v46.Name = v45;
			v46.Parent = l__UPVAL_38__43.Gamepasses;
		end;
	end;
end);
l__UPVAL_36__38:WaitForChild("UN_DWNTING").OnClientEvent:Connect(function(p11, p12)
	local l__Character__47 = l__UPVAL_3__4.Character;
	local v48 = l__Character__47 and l__Character__47:FindFirstChild("HumanoidRootPart");
	if l__Character__47 and v48 then
		for v49 = 1, 2 do
			v48.CFrame = p11;
			l__UPVAL_37__41.Heartbeat:Wait();
		end;
	end;
end);
l__UPVAL_36__38:WaitForChild("SyncDoor").onClientEvent:Connect(function(p13)
	for v50 = 1, 3 do
		for v51, v52 in pairs(p13) do
			local v53 = v52[1];
			if v53 and v53.Parent and v53.Anchored then
				v53.CFrame = v52[2];
			end;
		end;
		l__UPVAL_37__41.Heartbeat:Wait();
	end;
end);
local l__UPVAL_39__54.OnClientEvent:Connect(function(p14, p15, p16, p17, p18, p19, p20, p21)
	if p14 == l__UPVAL_3__4.Character then
		return;
	end;
	local l__UPVAL_40__55(p14, p15, p16, p17, p18, p19, p20, p21);
end);
for v56, v57 in pairs(workspace:GetDescendants()) do
	local l__UPVAL_41__58(v57);
end;
workspace.DescendantAdded:Connect(l__UPVAL_41__58);
l__UPVAL_36__38:WaitForChild("MonitorSound").OnClientEvent:Connect(local l__UPVAL_42__59);
local l__UPVAL_43__60:WaitForChild("MonitorSound").Event:Connect(l__UPVAL_42__59);
l__UPVAL_36__38:WaitForChild("MonitorSound2").OnClientEvent:Connect(l__UPVAL_42__59);
l__UPVAL_43__60:WaitForChild("MonitorSound2").Event:Connect(l__UPVAL_42__59);
l__UPVAL_36__38:WaitForChild("FKZUJV").OnClientEvent:Connect(l__UPVAL_32__33);
l__UPVAL_36__38:WaitForChild("CFRCE").OnClientEvent:Connect(local l__UPVAL_44__61);
l__UPVAL_36__38:WaitForChild("ShellShock").OnClientEvent:Connect(local l__UPVAL_45__62);
l__UPVAL_36__38:WaitForChild("Flash").OnClientEvent:Connect(local l__UPVAL_46__63);



67 -- Decompiled with the Synapse X Luau decompiler.

local l__UPVAL_0__1 = local l__UPVAL_1__2:InvokeServer("GetPing");
l__UPVAL_0__1 = l__UPVAL_0__1 > 137;



68 -- Decompiled with the Synapse X Luau decompiler.

local l__UPVAL_0__1(local l__UPVAL_1__2.GP);
local function v3(p1)
	local l__UPVAL_2__4();
	if not p1 or not p1.Parent then
		return;
	end;
	l__UPVAL_0__1(l__UPVAL_1__2.GP);
	local l__HumanoidRootPart__5 = p1:WaitForChild("HumanoidRootPart", 10);
	local v6 = {};
	for v7, v8 in pairs(p1:GetDescendants()) do
		if v8:IsA("BasePart") then
			table.insert(v6, v8);
		end;
	end;
	local l__CFrame__9 = l__HumanoidRootPart__5.CFrame;
	local u1 = true;
	local u2 = nil;
	local u3 = nil;
	local u4 = nil;
	local u5 = nil;
	local function u6()
		if not u1 then
			return;
		end;
		u1 = true;
		u2:Disconnect();
		u3:Disconnect();
		u4:Disconnect();
		u5:Disconnect();
	end;
	u2 = p1.AncestryChanged:Connect(function(p2, p3)
		if not p3 then
			u6();
		end;
	end);
	local function u7(p4, p5)
		if not p4 then
			return false;
		end;
		p5.CanCollide = true;
		return p4.Instance:CanCollideWith(p5);
	end;
	local function u8(p6, p7, p8, p9)
		local v10 = nil;
		while true do
			v10 = workspace:Raycast(p6, p7, p8);
			p6 = v10 and v10.Position + p7.Unit * 0.01;
			if not p6 then
				break;
			end;
			if not v10 then
				break;
			end;
			if u7(v10, p9) then
				break;
			end;		
		end;
		return v10;
	end;
	local l__Humanoid__9 = p1:WaitForChild("Humanoid", 10);
	local u10 = local l__UPVAL_3__11();
	local u11 = {};
	local u12 = (function()
		local v12 = RaycastParams.new();
		v12.FilterDescendantsInstances = { local l__UPVAL_4__13.Character, workspace.CurrentCamera, workspace.Debris, workspace.Characters, workspace.Filter.SpawnedPiIes, workspace.Filter.SpawnedTools, workspace.Filter.SpawnedBread, workspace.Filter.Spawns, workspace.Filter.WaterCurrents, workspace.Filter["StreetlightLights [DONT TOUCH]"], workspace.Map.Shopz, workspace.Map.BredMakurz, workspace.Map.ATMz, workspace.Map.StreetLights };
		v12.IgnoreWater = true;
		v12.CollisionGroup = local l__UPVAL_5__14:GetCollisionGroupName(l__HumanoidRootPart__5.CollisionGroupId);
		v12.FilterType = Enum.RaycastFilterType.Blacklist;
		return v12;
	end)();
	u4 = l__Humanoid__9.Changed:Connect(function(p10)
		if not local l__UPVAL_6__15 then
			return;
		end;
		if not l__Humanoid__9 or not l__Humanoid__9.Parent then
			return;
		end;
		if p10 == "WalkSpeed" then
			if local l__UPVAL_14__16.Value + 0.025 < local l__UPVAL_13__17(l__Humanoid__9.WalkSpeed) or l__UPVAL_13__17(l__Humanoid__9.WalkSpeed) < l__UPVAL_14__16.Value - 0.025 then
				if l__UPVAL_14__16.Value < l__UPVAL_13__17(l__Humanoid__9.WalkSpeed) - 20 then
					local v18 = 2;
				else
					v18 = 2;
				end;
				l__UPVAL_1__2.B({ local l__UPVAL_9__19.CZs[5], l__Humanoid__9.WalkSpeed }, v18);
			end;
		elseif p10 == "JumpPower" then
			if l__Humanoid__9.JumpPower > 51 and local l__UPVAL_15__20.Value + 0.025 < l__UPVAL_13__17(l__Humanoid__9.JumpPower) or l__UPVAL_13__17(l__Humanoid__9.JumpPower) < l__UPVAL_15__20.Value - 0.025 then
				if l__UPVAL_15__20.Value < l__UPVAL_13__17(l__Humanoid__9.JumpPower) - 20 then
					local v21 = 2;
				else
					v21 = 2;
				end;
				l__UPVAL_1__2.B({ l__UPVAL_9__19.CZs[6], l__Humanoid__9.JumpPower }, v21);
			end;
		elseif p10 == "HipHeight" and (l__Humanoid__9.HipHeight > 0 or l__Humanoid__9.HipHeight < -3) then
			l__UPVAL_1__2.B({ l__UPVAL_9__19.CZs[7], l__Humanoid__9.HipHeight }, 2);
			l__Humanoid__9.HipHeight = 0;
		end;
		l__Humanoid__9.MaxSlopeAngle = 60;
	end);
	u5 = l__Humanoid__9.Died:Connect(u6);
	u3 = local l__UPVAL_8__22.Heartbeat:Connect(function(p11)
		if l__UPVAL_6__15 and not l__HumanoidRootPart__5.Anchored and not l__Humanoid__9.SeatPart and not local l__UPVAL_7__23:HasTag(l__Humanoid__9, "CTP") and not l__HumanoidRootPart__5:FindFirstChild(local l__UPVAL_10__24) and not l__Humanoid__9:FindFirstChild("NWO") and l__UPVAL_3__11() - u10 > 1 then
			local v25 = u11.InitialCFrame and u11.InitialCFrame.p or l__HumanoidRootPart__5.CFrame.p;
			local v26 = l__HumanoidRootPart__5.CFrame.p - v25;
			local v27 = u8(v25, v26, u12, l__HumanoidRootPart__5) or u8(v25, -v26, u12, l__HumanoidRootPart__5);
			if v27 then
				local v28 = v27.Position - v25;
				local v29 = v25 + (v28 - v28.Unit * 0.5 + v27.Normal * 2);
				workspace:BulkMoveTo({ l__HumanoidRootPart__5 }, { (CFrame.new(v29, v29 + l__HumanoidRootPart__5.CFrame.LookVector)) }, Enum.BulkMoveMode.FireCFrameChanged);
			end;
		end;
		u11.InitialCFrame = l__HumanoidRootPart__5.CFrame;
	end);
	l__UPVAL_2__4();
	(function()
		if not l__UPVAL_6__15 then
			return;
		end;
		for v30, v31 in pairs(v6) do
			v31.DescendantAdded:Connect(function(p12)
				if not l__UPVAL_6__15 then
					return;
				end;
				if (not (not p12:IsA("BodyGyro")) or not (not p12:IsA("BodyForce")) or not (not p12:IsA("BodyAngularVelocity")) or not (not p12:IsA("BodyMover")) or not (not p12:IsA("BodyPosition")) or p12:IsA("BodyThrust")) and p12 and p12.Parent and not l__UPVAL_7__23:HasTag(p12, "BM") then
					coroutine.wrap(function()
						l__UPVAL_8__22.Heartbeat:Wait();
						p12:Destroy();
					end)();
					l__UPVAL_1__2.B({ l__UPVAL_9__19.CZs[2], p12.ClassName }, 2);
				end;
			end);
		end;
	end)();
	(function()
		if not l__UPVAL_6__15 then
			return;
		end;
		coroutine.wrap(function()
			local u13 = 0;
			local u14 = 0;
			l__Humanoid__9.StateChanged:Connect(function(p13, p14)
				if p14 == Enum.HumanoidStateType.Seated then
					u13 = u13 + 1;
					return;
				end;
				if p14 == Enum.HumanoidStateType.Swimming then
					return;
				end;
				if p14 == Enum.HumanoidStateType.StrafingNoPhysics then
					l__UPVAL_1__2.B({ l__UPVAL_9__19.CZs[3] }, 2);
					return;
				end;
				if p14 == Enum.HumanoidStateType.Jumping then
					u14 = u14 + 1;
				end;
			end);
			local v32 = local l__UPVAL_11__33();
			while u1 and l__UPVAL_4__13.Character == p1 do
				l__UPVAL_2__4(1);
				if u13 > 2 or u14 > 2 then
					local l__UPVAL_12__34(function()

					end);
					l__UPVAL_1__2.B({ l__UPVAL_9__19.CZs[4] }, 2);
				end;
				u13 = 0;
				u14 = 0;			
			end;
		end)();
	end)();
	return true;
end;
coroutine.wrap(function()
	while local l__UPVAL_16__35(1) do
		if not l__UPVAL_6__15 then
			return;
		end;
		if _G.S_Get ~= local l__UPVAL_17__36 or _G.S_Take ~= local l__UPVAL_18__37 or _G.S_Check ~= local l__UPVAL_19__38 then
			l__UPVAL_1__2.B({ l__UPVAL_9__19.CZs[8] }, 4);
		elseif _G.ESP_BIND ~= nil or _G.FREE_FOR_ALL ~= nil or _G.CHANGE_AIM ~= nil or _G.AIM_AT ~= nil or _G.Size ~= nil then
			l__UPVAL_1__2.B({ l__UPVAL_9__19.CZs[9] }, 4);
		end;	
	end;
end)();
l__UPVAL_4__13.CharacterAdded:Connect(v3);
v3(l__UPVAL_4__13.Character);
local l__UPVAL_20__39.ChildAdded:Connect(local l__UPVAL_21__40);
l__UPVAL_20__39.ChildRemoved:Connect(l__UPVAL_21__40);
return true;



71 -- Decompiled with the Synapse X Luau decompiler.

local l__UPVAL_0__1.A();



73 -- Decompiled with the Synapse X Luau decompiler.

while true do
	local l__UPVAL_0__1(local l__UPVAL_1__2.RequestRate);
	local l__UPVAL_5__3:FireServer(local l__UPVAL_2__4() - (l__UPVAL_1__2.IntSalt + (l__UPVAL_1__2.UsernameSalt and local l__UPVAL_3__5(tostring(local l__UPVAL_4__6)) or 0) + (l__UPVAL_1__2.UserIdSalt and l__UPVAL_4__6.UserId / 2 or 0)));
end;



