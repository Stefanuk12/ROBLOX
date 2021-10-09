--[[VARIABLE DEFINITION ANOMALY DETECTED, DECOMPILATION OUTPUT POTENTIALLY INCORRECT]]--
-- Decompiled with the Synapse X Luau decompiler.

while true do
	wait();
	if game.Players.LocalPlayer.Character then
		break;
	end;
end;
ply = game.Players.LocalPlayer;
if (ply.Backpack:FindFirstChild("mainHandler") or (ply.PlayerGui:FindFirstChild("mainHandler") or ply:FindFirstChild("mainHandler"))) and (ply.Backpack:FindFirstChild("mainHandler") or (ply.PlayerGui:FindFirstChild("mainHandler") or ply:FindFirstChild("mainHandler"))) ~= script then
	script:Destroy();
	return;
end;
local l__CurrentCamera__1 = workspace.CurrentCamera;
l__CurrentCamera__1.CameraSubject = ply.Character.Humanoid;
l__CurrentCamera__1.CameraType = "Custom";
for v2, v3 in ipairs(l__CurrentCamera__1:GetChildren()) do
	v3:Destroy();
end;
filth = nil;
if workspace.ServerStuff.Statistics:FindFirstChild("Filth") then
	filth = require(workspace.ServerStuff.Statistics:FindFirstChild("Filth"));
else
	filth = { "Praise the sun!" };
end;
teamfolder = nil;
character = ply.Character;
mouse = ply:GetMouse();
mouse.TargetFilter = character;
RS = game:GetService("RunService").RenderStepped;
UIS = game:GetService("UserInputService");
sharedm = require(workspace.ServerStuff.Statistics.G_SCRIPTS);
playerstats = workspace.ServerStuff.retrieveStats:InvokeServer();
startperk = ply:WaitForChild("start");
nametag = ply.Name;
local v4 = workspace.ServerStuff.say:InvokeServer();
if playerstats.Settings.EnableCC == true then
	game.ReplicatedStorage.effects.ccFX:Clone().Parent = l__CurrentCamera__1;
end;
local v5 = _G.seedk[_G.keylist[workspace.ServerStuff.ask:InvokeServer(script.Name, true)]];
hum = character.Humanoid;
maingui = ply.PlayerGui:WaitForChild("mainHUD");
if game.Players.LocalPlayer.Name ~= "Archeximus" and game.Players.LocalPlayer.Name ~= "Player1" and game.Players.LocalPlayer.Name ~= "Player2" and game.Players.LocalPlayer.Name ~= "Player3" then
	maingui.devbox:Destroy();
end;
UIS.MouseIconEnabled = false;
fparms = game.ReplicatedStorage.Rigs.FPArms:Clone();
camroot = fparms.camROOT;
fparms.Parent = l__CurrentCamera__1;
cpart = Instance.new("Part");
cpart.Transparency = 1;
cpart.CanCollide = false;
cpart.Anchored = true;
cpart.Locked = true;
cpart.Size = Vector3.new(0.2, 0.2, 0.2);
cpart.Parent = l__CurrentCamera__1;
local v6 = { { "Fist", true, nil }, { "Fist", false, nil }, { "Fist", false, nil }, { "Fist", false, nil } };
local v7 = require(workspace.ServerStuff.Statistics.P_STATISTICS);
playerperks = {};
perksactive = {};
for v8, v9 in ipairs(character:FindFirstChild("perks"):GetChildren()) do
	playerperks[v9.Name] = true;
end;
if playerstats.Settings.Anonymous == true then
	if character:FindFirstChild("playerID") then
		nametag = "Contestant #" .. character:FindFirstChild("playerID").Value;
	else
		nametag = "Contestant #" .. math.random(1000, 9000);
	end;
end;
dsdesignations = { "Alpha", "Bravo", "Delta", "Echo", "Foxtrot", "Kilo", "Lima", "Oscar", "Quebec", "Sierra", "Tango", "Zulu" };
risdesignations = { "Acey", "Butcher", "Black", "Zero", "Crow", "Dusty", "Eagle", "Falcon", "Chaos", "Wolf", "Phantom", "Ghost" };
chattertime = 30;
if startperk.Value == "commander" then
	local v10 = "CMMaul";
	v6[1] = { v10, true, nil };
	nametag = "The Commander";
elseif startperk.Value == "emperor" then
	v10 = "EMSword";
	v6[1] = { v10, true, nil };
	nametag = "The Emperor";
elseif startperk.Value == "hiddenB" then
	chattertime = 10;
	v10 = "GhostKnife";
	v6[1] = { v10, true, nil };
	v6[2] = { "GhostBomb", false, nil };
	v6[3] = { "GhostBomb", false, nil };
	v6[4] = { "GhostBomb", false, nil };
	nametag = "The Hidden";
	game.ReplicatedStorage.effects.hiddenlight:Clone().Parent = character.Head;
elseif startperk.Value == "turfwarA" then
	v10 = "MMachete";
	v6[1] = { v10, true, nil };
	nametag = "Agent " .. dsdesignations[math.random(1, #dsdesignations)];
elseif startperk.Value == "turfwarB" then
	v10 = "MilAxe";
	v6[1] = { v10, true, nil };
	nametag = "Operative '" .. risdesignations[math.random(1, #risdesignations)] .. "'";
elseif startperk.Value == "siegeA" then
	v10 = "SSword";
	v6[1] = { v10, true, nil };
	if math.random(1, 2) == 1 then
		local v11 = { "DStim", "DEFStim", "SStim", "SPDStim", "AdrStim" };
		v6[2] = { v11[math.random(1, #v11)], false, 1 };
	end;
	if math.random(1, 50) == 1 then
		v6[2] = { "MPistol", false, 7 };
	end;
elseif startperk.Value == "siegeB" then
	local v12 = { "TCaltrop", "PTrap", "SSnare", "RExplosive" };
	local v13 = v12[math.random(1, #v12)];
	local v14 = 2;
	if v13 == "RExplosive" then
		v14 = 1;
	end;
	if v13 == "TCaltrop" then
		v14 = nil;
	end;
	v10 = "CRSpear";
	v6[1] = { v10, true, nil };
	v6[2] = { v13, false, v14 };
elseif startperk.Value == "tElimA" or startperk.Value == "tElimB" or startperk.Value == "jElimA" or startperk.Value == "hiddenA" or startperk.Value == "shadowGame" or startperk.Value == "coopvsDS" then
	v10 = playerstats.SelectedWep;
	v6[1] = { v10, true, nil };
	if startperk.Value == "hiddenA" or startperk.Value == "shadowGame" or startperk.Value == "coopvsDS" then
		local v15 = { { "SubAK", 30 }, { "SPShotgun", 9 }, { "Glock", 17 }, { "Rifle", 4 }, { "SubMG", 21 }, { "MPistol", 7 }, { "Deagle", 7 }, { "EBR", 20 }, { "Mac", 28 }, { "SubLMG", 50 }, { "SubVector", 25 }, { "ASVal", 30 } };
		local v16 = v15[math.random(1, #v15)];
		v6[2] = { v16[1], false, v16[2] };
	end;
elseif startperk.Value == "jElimB" then
	v10 = playerstats.SelectedWep;
	v6[1] = { v10, true, nil };
	v6[2] = { "EFlare", false, nil };
end;
if playerperks.tracker then
	for v17 = 1, #v6 do
		if v6[v17][1] == "Fist" and v17 ~= 1 then
			v6[v17] = { "PScanner", false, nil };
			break;
		end;
	end;
end;
local v18 = require(workspace.ServerStuff.Statistics.W_STATISTICS);
local v19 = require(workspace.ServerStuff.Statistics.CLASS_STATISTICS);
local v20 = require(workspace.ServerStuff.Statistics.Q_STATISTICS);
primwepset = v18[v10];
primanimset = game.ReplicatedStorage.animationSets:FindFirstChild(primwepset.animset);
tpprimanimset = game.ReplicatedStorage.animationSets.TPanimSets:FindFirstChild(primwepset.animset);
curentanimset = {};
tpcurrentanimset = {};
tauntchose = {};
tauntanimset = {};
tptauntanimset = {};
for v21, v22 in ipairs(game.ReplicatedStorage.animationSets.taunts:GetChildren()) do
	if v22:IsA("Animation") then
		tauntanimset[v22.Name] = fparms.AC:LoadAnimation(v22);
	end;
end;
for v23, v24 in ipairs(game.ReplicatedStorage.animationSets.TPanimSets.taunts:GetChildren()) do
	if v24:IsA("Animation") then
		tptauntanimset[v24.Name] = hum:LoadAnimation(v24);
	end;
end;
blocksets = {};
for v25, v26 in ipairs(game.ReplicatedStorage.animationSets.TPanimSets:GetChildren()) do
	if v26:FindFirstChild("block") then
		blocksets[v26.block.AnimationId] = true;
	end;
end;
local l__Debris__27 = game:GetService("Debris");
globalanimsets = {};
for v28, v29 in pairs(game.ReplicatedStorage.animationSets.global:GetChildren()) do
	if v29:IsA("Animation") then
		globalanimsets[v29.Name] = fparms.AC:LoadAnimation(v29);
	end;
end;
tpglobalanimsets = {};
for v30, v31 in pairs(game.ReplicatedStorage.animationSets.TPanimSets.global:GetChildren()) do
	if v31:IsA("Animation") then
		local v32 = hum:LoadAnimation(v31);
		v32.Priority = Enum.AnimationPriority.Idle;
		tpglobalanimsets[v31.Name] = v32;
	end;
end;
tpglobalanimsets.run.Priority = Enum.AnimationPriority.Movement;
tpglobalanimsets.crouch_idle.Priority = Enum.AnimationPriority.Action;
tpglobalanimsets.crouch_walk.Priority = Enum.AnimationPriority.Action;
tpglobalanimsets.stagger.Priority = Enum.AnimationPriority.Action;
akimbosets = {};
for v33, v34 in pairs(game.ReplicatedStorage.animationSets.AKMB:GetChildren()) do
	if v34:IsA("Animation") then
		akimbosets[v34.Name] = fparms.AC:LoadAnimation(v34);
	end;
end;
tpakimbosets = {};
for v35, v36 in pairs(game.ReplicatedStorage.animationSets.TPanimSets.AKMB:GetChildren()) do
	if v36:IsA("Animation") then
		tpakimbosets[v36.Name] = hum:LoadAnimation(v36);
	end;
end;
akimbo_factors = {
	active = false, 
	weapon_slot = 1, 
	alternate = false, 
	alt_weapon = nil, 
	alt_weapon_stats = nil, 
	alt_tick = 0
};
local l__workspace__1 = workspace;
function remove_dual_wield()
	akimbosets.equip:Stop(0.1);
	tpakimbosets.equip:Stop(0.1);
	akimbo_factors.active = false;
	if akimbo_factors.alt_weapon then
		akimbo_factors.alt_weapon:Destroy();
	end;
	akimbo_factors.alternate = false;
	if maingui.Centre.crosshair:FindFirstChild("akimbocrosshair") then
		maingui.Centre.crosshair:FindFirstChild("akimbocrosshair"):Destroy();
	end;
	maingui.Centre.crosshair.A1.Visible = true;
	maingui.Centre.crosshair.A2.Visible = true;
	maingui.Centre.crosshair.B1.Visible = true;
	maingui.Centre.crosshair.B2.Visible = true;
	maingui.Centre.crosshair.dot.Visible = true;
	l__workspace__1.ServerStuff.quickDisplay:FireServer("deleteakimbo");
end;
craftlist = require(l__workspace__1.ServerStuff.Statistics.CRAFTING_LIST);
local v37 = 0;
local v38 = 1;
local v39 = 1;
local v40 = 0;
local v41 = 0;
local v42 = 0;
local v43 = 0;
local v44 = 5;
local v45 = 12;
local v46 = 1;
local v47 = 1;
local v48 = 0;
local v49 = false;
local v50 = 0;
local v51 = true;
local v52 = true;
local v53 = false;
local v54 = false;
local v55 = false;
local v56 = false;
local v57 = false;
baseadstime = 6;
baseadstick = tick();
baseadsmod = 0;
local v58 = game.ReplicatedStorage.soundLibrary.general_ui.storm_ambience:Clone();
v58.Parent = character;
v58:Play();
local v59 = {};
local v60 = { "nothing", {}, {} };
local v61 = false;
local v62 = 100;
can_player_sprint = true;
if v19[playerstats.Class] ~= nil then
	v60 = { playerstats.Class, v19[playerstats.Class].basestats, v19[playerstats.Class].activestats };
	maingui.PerkFrame.iconimage.Image = "rbxassetid://" .. v19[playerstats.Class].icon;
	local v63, v64, v65 = pairs(v60[2]);
	while true do
		local v66 = nil;
		local v67 = nil;
		v67, v66 = v63(v64, v65);
		if not v67 then
			break;
		end;
		v65 = v67;
		if v67 == "atkmod" then
			v38 = v38 + v66 / 100;
		elseif v67 == "defmod" then
			v39 = v39 + v66 / 100;
		elseif v67 == "mvtmod" then
			v37 = v37 + 10 * v66 / 100;
		elseif v67 == "stammod" then
			v62 = v62 + v66;
		elseif v67 == "craftcostmod" then
			v44 = v44 + v66;
		elseif v67 == "accmod" then
			v41 = v41 + v66 / 100;
		elseif v67 == "scavmod" then
			v43 = v43 + v66 / 100;
		elseif v67 == "grap" then
			v51 = false;
		elseif v67 == "lightatkspeed" then
			v46 = v46 + v66 / 100;
		elseif v67 == "heavyatkspeed" then
			v47 = v47 + v66 / 100;
		elseif v67 == "shovemod" then
			v42 = v42 + v66 / 100;
		elseif v67 == "aimmod" then
			baseadsmod = baseadsmod + v66 / 100;
		elseif v67 == "nomorale" then
			v61 = true;
		elseif v67 == "no_sprint" then
			can_player_sprint = false;
		elseif v67 == "burnimmune" then
			v57 = true;
		elseif v67 == "bleed_immune" then
			v53 = true;
		elseif v67 == "explosive_resist" then
			v56 = true;
		elseif v67 == "frac_immune" then
			v55 = true;
		elseif v67 == "cripple_immune" then
			v54 = true;
		elseif v67 == "recoilmod" then
			v40 = v40 + v66 / 100;
		elseif v67 == "harvestmod" then
			v45 = v45 - v66;
		elseif v67 == "falldamagemod" then
			v52 = false;
		elseif v67 == "reloadmod" then
			v50 = v50 + v66 / 100;
		elseif v67 == "trapmod" then
			v48 = v48 + v66 / 100;
		elseif v67 == "drop_ranged" then
			v49 = true;
		elseif v67 == "backpack" then
			l__workspace__1.ServerStuff.dealDamage:FireServer("putbackpack", nil, v5, v4);
			v6[6] = { "Fist", false, nil };
			maingui.InventoryFrame.slot6.Visible = true;
			v6[5] = { "Fist", false, nil };
			maingui.InventoryFrame.slot5.Visible = true;
		end;	
	end;
end;
if playerperks.reliab then
	v50 = v50 + v7.reliab.efx[1] / 100;
end;
if playerperks.boxer then
	v42 = v42 + v7.boxer.efx[2] / 100;
end;
if playerperks.recoil then
	v40 = v40 + v7.recoil.efx[1] / 100;
end;
if playerperks.manic then
	v47 = v47 + v7.manic.efx[1] / 100;
end;
if playerperks.violence then
	v46 = v46 + v7.violence.efx[1] / 100;
end;
if playerperks.paranoia then
	baseadsmod = baseadsmod + v7.paranoia.efx[1] / 100;
end;
fanning_levering = false;
fanning_firerate = 0.15;
levering_firerate = 0.3;
if playerperks.hip then
	v41 = v41 + v7.hip.efx[1] / 100;
	fanning_levering = true;
end;
if playerperks.rustic then
	v38 = v38 + v7.rustic.efx[1] / 100;
end;
if playerperks.tough then
	v39 = v39 + v7.tough.efx[1] / 100;
end;
if playerperks.leg then
	v37 = v37 + 10 * v7.leg.efx[1] / 100;
end;
emotelist = false;
cc = nil;
local v68 = 0;
if playerstats.Class == "sword" then
	local u2 = v37;
	local u3 = 10;
	function v59.losetags(p1, p2)
		if v59.dogtags and v59.dogtags > 0 then
			local v69 = math.ceil(v59.dogtags / (100 / v60[3].dogtagslostondamage));
			if p2 == true then
				v69 = math.ceil(math.clamp((hum.MaxHealth - hum.Health) / v60[3].healthperdogtag, 1, v59.dogtags));
				if v69 == 0 then
					v69 = 1;
				end;
			end;
			local v70 = v59.dogtags;
			if v60[3].dogtagmaxmovement < v70 then
				v70 = v60[3].dogtagmaxmovement;
			end;
			local v71 = math.clamp(v59.dogtags - v69 - v70, -1000, 0);
			v59.dogtags = v59.dogtags - v69;
			maingui.PerkFrame.numberstat.Text = v59.dogtags;
			if v71 < 0 then
				u2 = u2 - u3 * (v60[3].dogtagmovementbuff * -v71) / 100;
			end;
			if p2 == true then
				l__workspace__1.ServerStuff.dealDamage:FireServer("kiraheal", v69, v5, v4);
			end;
		end;
	end;
	v59.dogtag_lose_timer = 0;
	v59.dogtag_lose_damage = 0;
elseif playerstats.Class == "fire" then
	v59.overheat_danger_cd = 0;
	local u4 = v68;
	local u5 = nil;
	function v59.apply_overheat(p3, p4)
		if p4 == true then
			if tick() - v59.overheat_grace_period <= v60[3].overheat_graceperiod then
				return;
			end;
			v60[3].overheat_graceperiod = tick();
		end;
		if v60[3].cooldown <= tick() - u4 then
			u4 = tick() - v60[3].cooldown;
		end;
		u4 = u4 + p3;
		if tick() - u4 <= 8 and tick() - v59.overheat_danger_cd >= 3 then
			v59.overheat_danger_cd = tick();
			spawn(function()
				u5({ "perks" }, "flamer_danger", nil, nil, true, true);
				local v72 = tick();
				maingui.PerkFrame.numberstat.Visible = true;
				maingui.PerkFrame.numberstat.Text = "!";
				for v73 = 1, 15 do
					local v74 = tick();
					if maingui.PerkFrame.numberstat.Text == "!" then
						maingui.PerkFrame.numberstat.Text = "";
					else
						maingui.PerkFrame.numberstat.Text = "!";
					end;
					while true do
						RS:wait();
						if tick() - v74 >= 0.075 then
							break;
						end;					
					end;
				end;
				maingui.PerkFrame.numberstat.Visible = false;
				maingui.PerkFrame.numberstat.Text = "";
			end);
		end;
		if tick() - u4 <= 0 then
			l__workspace__1.ServerStuff.dealDamage:FireServer("immolate", character, v5, v4);
			l__workspace__1.ServerStuff.applyGore:FireServer("immolate_ability", character, ply, { character.Torso.CFrame - character.Torso.CFrame.upVector * 3 });
			l__workspace__1.ServerStuff.dealDamage:FireServer("immolator_overheated", {}, v5, v4);
		end;
		return u4;
	end;
	v59.overheat_grace_period = 0;
	local u6 = 0;
	function v59.overheat_damage()
		while true do
			u6 = (v60[3].overheat_damage_buff - v60[3].overheat_damage_buff * (math.clamp(tick() - u4, 1, v60[3].cooldown) / v60[3].cooldown)) / 100;
			RS:wait();
			if hum.Health <= 0 then
				break;
			end;		
		end;
	end;
	spawn(v59.overheat_damage);
end;
v59.buffer_f_key = true;
hum.WalkSpeed = (10 + v37) * 1;
local v75 = 0.025;
if playerperks.recovery then
	v75 = v75 - v75 * v7.recovery.efx[1] / 100;
end;
local l__game__7 = game;
function update_player_challenges()
	local v76, v77, v78 = pairs(playerstats.PinnedChallenge);
	while true do
		local v79, v80 = v76(v77, v78);
		if v79 then

		else
			break;
		end;
		v78 = v79;
		if maingui.ChallengesFrame:FindFirstChild(v79) then
			local v81 = l__game__7.ReplicatedStorage.challenges:FindFirstChild(v79);
			if v81 then
				local v82 = require(v81);
				local v83 = 0;
				if playerstats.Trackers[v82.req] then
					v83 = math.floor(playerstats.Trackers[v82.req]);
				end;
				if v82.reqamount <= v83 then
					maingui.ChallengesFrame:FindFirstChild(v79).progbar.bar.Size = UDim2.new(1, 0, 0, 4);
					maingui.ChallengesFrame:FindFirstChild(v79).progresstext.Text = "COMPLETE";
					maingui.ChallengesFrame:FindFirstChild(v79).progresstext.TextColor3 = Color3.fromRGB(145, 255, 61);
				else
					maingui.ChallengesFrame:FindFirstChild(v79).progbar.bar.Size = UDim2.new(math.clamp(v83 / v82.reqamount, 0, 1), 0, 0, 4);
					maingui.ChallengesFrame:FindFirstChild(v79).progresstext.Text = v83 .. "/" .. v82.reqamount;
				end;
			end;
		end;	
	end;
end;
challengecount = 1;
for v84, v85 in pairs(playerstats.PinnedChallenge) do
	if l__game__7.ReplicatedStorage.challenges:FindFirstChild(v84) then
		maingui.ChallengesFrame["challenge" .. challengecount].Text = require(l__game__7.ReplicatedStorage.challenges:FindFirstChild(v84)).name;
		maingui.ChallengesFrame["challenge" .. challengecount].Visible = true;
		maingui.ChallengesFrame["challenge" .. challengecount].Name = v84;
		challengecount = challengecount + 1;
	end;
end;
update_player_challenges();
baselayer = { character, l__workspace__1.NoTarget, l__workspace__1.GoreEffects, l__CurrentCamera__1, l__workspace__1.PlayerShootThroughs, l__workspace__1.activeFriendlies };
function raycastline(p5, p6, p7, p8)
	local v86 = nil;
	local v87 = nil;
	local v88 = nil;
	local v89 = {};
	local v90 = 1 - 1;
	while true do
		local v91, v92, v93 = l__workspace__1:FindPartOnRayWithIgnoreList(Ray.new(p5, p6.unit * (p7 and 999.999)), v89);
		v86 = v91;
		v87 = v92;
		v88 = v93;
		if v86 then

		else
			break;
		end;
		local v94 = true;
		local v95, v96, v97 = pairs(p8);
		while true do
			local v98, v99 = v95(v96, v97);
			if v98 then

			else
				break;
			end;
			v97 = v98;
			if v86:IsDescendantOf(v99) then
				table.insert(v89, v86);
				v94 = false;
			end;		
		end;
		if v86.Locked == true then
			table.insert(v89, v86);
			v94 = false;
		end;
		if v94 == true then
			return v86, v87, v88;
		end;
		if 0 <= 1 then
			if v90 < 100 then

			else
				return;
			end;
		elseif 100 < v90 then

		else
			return;
		end;
		v90 = v90 + 1;	
	end;
	return v86, v87, v88;
end;
function lerp(p9, p10, p11)
	return p9 * (1 - p11) + p10 * p11;
end;
local v100 = v62;
if playerperks.lungs then
	v62 = v62 + v7.lungs.efx[1];
	v100 = v62;
end;
deathactivated = false;
local u8 = v100;
local u9 = {
	action = false, 
	swinging = false, 
	cancombo = false, 
	comboing = false, 
	sprinting = false, 
	shoving = false, 
	sneaking = false, 
	air = false, 
	walking = false, 
	canjump = true, 
	charging = false, 
	blocking = false, 
	blockimpact = false, 
	blockrecoil = false, 
	staggering = false, 
	sliding = false, 
	swapping = false, 
	startswap = false, 
	throwing = false, 
	aiming = false, 
	firing = false, 
	turnable = true, 
	channel = false, 
	poking = false, 
	using_perk = false, 
	using_aux = false, 
	eating = false
};
local u10 = {};
local u11 = 10;
local u12 = 7;
local u13 = 10;
local u14 = {
	stamregen = 0, 
	regentick = 0, 
	jumptick = 0, 
	combotimer = 0.2
};
local u15 = v75;
invmanage = nil;
shakecamera = nil;
stagger = nil;
applygore = nil;
afflictstatus = nil;
createfxoutline = nil;
local function v101(p12, p13, p14, p15, p16, p17, p18)
	local v102 = l__game__7.ReplicatedStorage.soundLibrary;
	if p12 then
		for v103, v104 in ipairs(p12) do
			v102 = v102:FindFirstChild(v104);
		end;
	end;
	local v105 = v102:FindFirstChild(p13);
	if v105 then
		local v106 = v105:Clone();
		if p15 then
			v106.Pitch = v106.Pitch + math.random(-p15 * 100, p15 * 100) / 100;
		end;
		if p17 == false then
			v106.Parent = p14;
		else
			v106.Parent = ply.PlayerGui;
		end;
		v105.SoundGroup = l__game__7:GetService("SoundService").regular;
		if p18 == true then
			v105.RollOffMaxDistance = 50;
			v105.RollOffMinDistance = 25;
			v105.SoundGroup = l__game__7:GetService("SoundService").echo;
		end;
		v105:Play();
		if p16 == true then
			v105.Looped = false;
			v105.Ended:connect(function()
				spawn(function()
					v105:Destroy();
				end);
			end);
		end;
	end;
	return v105;
end;
l__workspace__1.ServerStuff.playAudio.OnClientEvent:Connect(v101);
local u16 = 0;
AGENT_sound = Instance.new("Sound");
AGENT_sound.Name = "AGENT";
AGENT_sound.Volume = 1;
AGENT_sound.Ended:connect(function()
	v101({ "AGENT" }, "bliptwo", nil, nil, true, true);
end);
AGENT_sound.Parent = l__CurrentCamera__1;
AGENT_timer = 0;
caption_timer = 0;
caption_max_timer = 5;
AGENT_debounces = {
	low_health = 0
};
function create_captions(p19, p20, p21)
	if startperk.Value == "hubbing" then
		return;
	end;
	maingui.Caption.Visible = true;
	maingui.Caption.captiontext.Text = p21;
	maingui.Caption.nameofcaption.Text = p19;
	maingui.Caption.nameofcaption.TextColor3 = p20;
	caption_max_timer = string.len(p21) / 10 + 0.5;
	if tick() - caption_timer < caption_max_timer then
		caption_timer = tick();
		return;
	end;
	caption_timer = tick();
	spawn(function()
		while true do
			RS:wait();
			if not (caption_max_timer <= tick() - caption_timer) then

			else
				break;
			end;		
		end;
		maingui.Caption.Visible = false;
	end);
end;
function agent_speak(p22, p23)
	if hum.Health <= 0 then
		return;
	end;
	if startperk.Value == "hubbing" then
		return;
	end;
	if p23 ~= true then
		if tick() - AGENT_timer <= 4 then
			return;
		end;
	end;
	AGENT_sound:Stop();
	AGENT_timer = tick();
	caption_timer = 0;
	if l__game__7.ReplicatedStorage.soundLibrary.AGENT:FindFirstChild(p22) then
		local v107 = l__game__7.ReplicatedStorage.soundLibrary.AGENT:FindFirstChild(p22);
		v101({ "AGENT" }, "blip", nil, nil, true, true);
		delay(0.7, function()
			local v108 = v107:GetChildren()[math.random(1, #v107:GetChildren())];
			AGENT_sound.SoundId = v108.SoundId;
			if playerstats.Settings.MuteAgent == false then
				AGENT_sound:Play();
			end;
			if v108:FindFirstChild("line") then
				create_captions("AGENT", Color3.fromRGB(255, 170, 20), v108:FindFirstChild("line").Value);
			end;
		end);
	end;
end;
l__workspace__1.ServerStuff.handleVoiceLine.OnClientEvent:Connect(function(p24, p25)
	if p24 == "AGENT" then
		agent_speak(p25[1], p25[2]);
	end;
end);
bloodtier = 0;
bloodsprayDealt = 0;
local v109 = {
	damage = 0, 
	damagetaken = 0, 
	kills = 0, 
	killer = nil, 
	placed = 16, 
	timealive = tick()
};
lastchatter = tick();
local u17 = nil;
harvestinghits = v45;
drawlockout = 0;
juggernaut = false;
primskin = nil;
function set_walk_anim(p26)
	if p26 == true then

	else
		tpglobalanimsets.low_walk:Stop(0);
		tpglobalanimsets.run:Stop(0);
		tpglobalanimsets.crouch_walk:Stop(0);
		tpglobalanimsets.crouch_idle:Stop(0);
		if not (hum.Health <= 20) then
			if u10.Cripple then
				tpglobalanimsets.low_idle:Play(0.2);
				return;
			else
				tpglobalanimsets.low_idle:Stop(0.4);
				return;
			end;
		else
			tpglobalanimsets.low_idle:Play(0.2);
			return;
		end;
	end;
	tpglobalanimsets.low_idle:Stop(0);
	tpglobalanimsets.crouch_walk:Stop(0);
	tpglobalanimsets.crouch_idle:Stop(0);
	if not (hum.Health <= 20) then
		if u10.Cripple then
			tpglobalanimsets.low_walk:Play(0.2);
			tpglobalanimsets.low_walk:AdjustWeight(0.6 + hum.WalkSpeed / 20);
			return;
		end;
	else
		tpglobalanimsets.low_walk:Play(0.2);
		tpglobalanimsets.low_walk:AdjustWeight(0.6 + hum.WalkSpeed / 20);
		return;
	end;
	tpglobalanimsets.low_walk:Stop(0.2);
	tpglobalanimsets.low_idle:Stop(0.2);
	tpglobalanimsets.run:Play(0.1, hum.WalkSpeed / 18, 0.6 + hum.WalkSpeed / 40);
	tpglobalanimsets.run:AdjustSpeed(0.6 + hum.WalkSpeed / 40);
	tpglobalanimsets.run:AdjustWeight(hum.WalkSpeed / 18);
end;
function check_walking_anim()
	delay(0.1, function()
		set_walk_anim(u9.walking);
	end);
end;
fist_speed_boost = false;
current_anim_set_use = "Fists";
local u18 = "Fist";
local u19 = nil;
local u20 = v39;
local u21 = v38;
local u22 = v37;
local u23 = nil;
local function u24()
	u9.action = true;
	u9.cancombo = false;
	curentanimset.bolt:Play(0);
	curentanimset.bolt:AdjustSpeed(1);
	tpcurrentanimset.bolt:Play(0);
	tpcurrentanimset.bolt:AdjustSpeed(1);
	while true do
		RS:wait();
		if curentanimset.bolt.IsPlaying == false then
			break;
		end;	
	end;
	curentanimset.bolt.KeyframeReached:connect(function(p27)
		if p27 == "BoltA" or p27 == "BoltB" then
			if p27 == "BoltA" then
				shakecamera("weapon", { "LSMG", "bolt" });
			end;
			l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", u17.animset }, p27, character.HumanoidRootPart);
			if p27 == "BoltB" then
				delay(0.1, function()
					v101({ "weapons", "LSMG" }, "move", nil, nil, true, true);
				end);
			end;
		end;
	end):Disconnect();
	curentanimset.equip.TimePosition = 0.5;
	curentanimset.equip:AdjustSpeed(0);
	tpcurrentanimset.equip:Play();
	tpcurrentanimset.equip.TimePosition = 0.5;
	tpcurrentanimset.equip:AdjustSpeed(0);
	u9.action = false;
	u9.cancombo = true;
end;
local function u25(p28, p29)
	if p29 == nil then
		u14.stamregen = tick();
		u14.regentick = tick();
	end;
	if p28 then
		u15 = p28;
	end;
end;
local function u26(p30)
	if p30 == "stamina" then
		if u8 < 0 then
			u8 = 0;
		elseif v62 < u8 then
			u8 = v62;
		end;
		maingui.StaminaFrame.TextLabel.Text = math.ceil(u8);
		return;
	end;
	if p30 == "sprint_stam" then
		if sprint_stam <= 0 then
			if cc == nil then
				cc = Instance.new("ColorCorrectionEffect");
				if deathactivated == false then
					cc.Parent = l__CurrentCamera__1;
				end;
				spawn(function()
					cc.Saturation = math.clamp(lerp(cc.Saturation, -1, 0.05), -0.5, 1);
					while RS:wait() do
						if sprint_stam > 15 then
							cc.Saturation = lerp(cc.Saturation, 1, 0.05);
							if cc.Saturation >= 0 then
								cc:Destroy();
								cc = nil;
								return;
							end;
						end;					
					end;
				end);
			end;
			if u9.staggering == false and u9.channel == false and not u10.Snared then
				u11 = u12;
				return;
			end;
		elseif u9.staggering == false and u9.channel == false and not u10.Snared then
			u11 = u13;
			return;
		end;
	elseif p30 == "health" then
		maingui.HealthFrame.TextLabel.Text = math.ceil(hum.Health);
	end;
end;
local v110 = hum.Changed:connect(function(p31)
	if p31 == "MoveDirection" then
		if hum.MoveDirection.magnitude > 0.5 then
			if tpglobalanimsets.run.IsPlaying then
				tpglobalanimsets.run:AdjustSpeed(hum.WalkSpeed / 18);
				tpglobalanimsets.run:AdjustWeight(0.6 + hum.WalkSpeed / 40);
			end;
			if tpglobalanimsets.low_walk.IsPlaying then
				tpglobalanimsets.low_walk:AdjustWeight(0.6 + hum.WalkSpeed / 20);
			end;
			if tpglobalanimsets.crouch_walk.IsPlaying then
				tpglobalanimsets.crouch_walk:AdjustSpeed(0.8 + hum.WalkSpeed / 40);
			end;
			if u9.walking == false then
				u9.walking = true;
				set_walk_anim(true);
				return;
			end;
		else
			set_walk_anim(false);
			if u9.walking == true then
				u9.walking = false;
				return;
			end;
		end;
	elseif p31 == "Jump" then
		if u9.canjump == false or tick() - u14.jumptick < 1 or u9.staggering == true or u9.air == true or u8 <= 30 then
			hum.Jump = false;
			return;
		elseif hum.Jump == false and u9.air == false and u9.canjump == true then
			shakecamera("jumpstart");
			l__workspace__1.ServerStuff.playAudio:FireServer({ "movement_sounds" }, "jump", character.HumanoidRootPart);
			fall_sfx_tick = tick();
			u14.jumptick = tick();
			u8 = u8 - 30;
			u25(nil);
			u26("stamina");
		end;
	end;
end);
hum.HealthChanged:connect(function()
	u26("health");
end);
local v111 = CFrame.new();
local v112 = CFrame.Angles(0, 0, 0);
local v113 = CFrame.new();
local u27 = {};
local function u28()
	local v114 = nil;
	while true do
		v114 = tostring(math.random(0, 500));
		if u27[v114] == nil then
			break;
		end;	
	end;
	u27[v114] = CFrame.Angles(0, 0, 0);
	return v114;
end;
local function u29(p32, p33)
	for v115 = 1, p33.loops do
		for v116 = 1, p33.tables[v115].frames do
			u27[p32] = u27[p32]:lerp(p33.tables[v115].value, p33.tables[v115].speed);
			RS:wait();
		end;
		RS:wait();
	end;
	for v117 = 1, p33.returnframes do
		u27[p32] = u27[p32]:lerp(CFrame.Angles(0, 0, 0), p33.returnspeed);
		RS:wait();
	end;
	u27[p32] = nil;
end;
function shakecamera(p34, p35)
	spawn(function()
		local v118 = u28();
		if p34 == "weapon" then
			if p35[1] ~= "Fists" then
				if p35[1] == "BK" then
					if p35[2] == "swingvar1" then
						u29(v118, {
							loops = 1, 
							tables = { {
									frames = 5, 
									value = CFrame.Angles(0, math.rad(-7), math.rad(-7)), 
									speed = 0.15
								} }, 
							returnframes = 30, 
							returnspeed = 0.1
						});
					elseif p35[2] == "swingvar2" then
						u29(v118, {
							loops = 2, 
							tables = { {
									frames = 5, 
									value = CFrame.Angles(math.rad(-3), math.rad(3), math.rad(5)), 
									speed = 0.15
								}, {
									frames = 10, 
									value = CFrame.Angles(math.rad(3), math.rad(-1.5), math.rad(-1)), 
									speed = 0.3
								} }, 
							returnframes = 30, 
							returnspeed = 0.1
						});
					elseif p35[2] == "swingvar3" then
						u29(v118, {
							loops = 2, 
							tables = { {
									frames = 5, 
									value = CFrame.Angles(0, math.rad(5), math.rad(3)), 
									speed = 0.15
								}, {
									frames = 8, 
									value = CFrame.Angles(0, math.rad(-3), math.rad(-0.5)), 
									speed = 0.4
								} }, 
							returnframes = 30, 
							returnspeed = 0.1
						});
					elseif p35[2] == "charge" then
						u29(v118, {
							loops = 2, 
							tables = { {
									frames = 5, 
									value = CFrame.Angles(0, math.rad(-8), math.rad(-3)), 
									speed = 0.125
								}, {
									frames = 10, 
									value = CFrame.Angles(0, math.rad(10), math.rad(0.5)), 
									speed = 0.4
								} }, 
							returnframes = 65, 
							returnspeed = 0.05
						});
					elseif p35[2] == "equip" then
						u29(v118, {
							loops = 1, 
							tables = { {
									frames = 12, 
									value = CFrame.Angles(math.rad(3), 0, 0), 
									speed = 0.5
								} }, 
							returnframes = 30, 
							returnspeed = 0.075
						});
					end;
				elseif p35[1] == "2H" then
					if p35[2] == "swingvar1" then
						u29(v118, {
							loops = 1, 
							tables = { {
									frames = 10, 
									value = CFrame.Angles(0, math.rad(8), math.rad(-8)), 
									speed = 0.15
								} }, 
							returnframes = 30, 
							returnspeed = 0.1
						});
					elseif p35[2] == "swingvar2" then
						u29(v118, {
							loops = 2, 
							tables = { {
									frames = 10, 
									value = CFrame.Angles(math.rad(-5), math.rad(-3), math.rad(3)), 
									speed = 0.15
								}, {
									frames = 10, 
									value = CFrame.Angles(0, math.rad(3), math.rad(2)), 
									speed = 0.3
								} }, 
							returnframes = 30, 
							returnspeed = 0.1
						});
					elseif p35[2] == "swingvar3" then
						u29(v118, {
							loops = 2, 
							tables = { {
									frames = 10, 
									value = CFrame.Angles(math.rad(-2), math.rad(3), math.rad(3)), 
									speed = 0.15
								}, {
									frames = 8, 
									value = CFrame.Angles(math.rad(2), math.rad(-5), math.rad(-1)), 
									speed = 0.4
								} }, 
							returnframes = 30, 
							returnspeed = 0.1
						});
					elseif p35[2] == "charge" then
						u29(v118, {
							loops = 2, 
							tables = { {
									frames = 5, 
									value = CFrame.Angles(math.rad(10), math.rad(-6), math.rad(0)), 
									speed = 0.1
								}, {
									frames = 8, 
									value = CFrame.Angles(math.rad(-10), math.rad(0), math.rad(0)), 
									speed = 0.3
								} }, 
							returnframes = 65, 
							returnspeed = 0.05
						});
					elseif p35[2] == "equip" then
						u29(v118, {
							loops = 2, 
							tables = { {
									frames = 10, 
									value = CFrame.Angles(math.rad(2), math.rad(-2), math.rad(2)), 
									speed = 0.15
								}, {
									frames = 12, 
									value = CFrame.Angles(math.rad(-5), 0, 0), 
									speed = 0.3
								} }, 
							returnframes = 30, 
							returnspeed = 0.075
						});
					end;
				elseif p35[1] ~= "1HB" then
					if p35[1] == "1BT" then
						if p35[2] == "swingvar1" then
							u29(v118, {
								loops = 2, 
								tables = { {
										frames = 8, 
										value = CFrame.Angles(math.rad(3), math.rad(1), math.rad(-3)), 
										speed = 0.15
									}, {
										frames = 10, 
										value = CFrame.Angles(math.rad(-3), math.rad(-1), math.rad(4)), 
										speed = 0.2
									} }, 
								returnframes = 30, 
								returnspeed = 0.075
							});
						elseif p35[2] == "swingvar2" then
							u29(v118, {
								loops = 2, 
								tables = { {
										frames = 8, 
										value = CFrame.Angles(math.rad(3), math.rad(5), math.rad(-3)), 
										speed = 0.15
									}, {
										frames = 10, 
										value = CFrame.Angles(math.rad(-3), math.rad(-4), math.rad(3)), 
										speed = 0.2
									} }, 
								returnframes = 30, 
								returnspeed = 0.1
							});
						elseif p35[2] == "swingvar3" then
							u29(v118, {
								loops = 2, 
								tables = { {
										frames = 8, 
										value = CFrame.Angles(math.rad(0), math.rad(5), math.rad(-4)), 
										speed = 0.1
									}, {
										frames = 10, 
										value = CFrame.Angles(math.rad(0), math.rad(-4), math.rad(5)), 
										speed = 0.2
									} }, 
								returnframes = 30, 
								returnspeed = 0.1
							});
						elseif p35[2] == "charge" then
							u29(v118, {
								loops = 2, 
								tables = { {
										frames = 8, 
										value = CFrame.Angles(math.rad(6), math.rad(1), math.rad(-3)), 
										speed = 0.2
									}, {
										frames = 8, 
										value = CFrame.Angles(math.rad(-1), math.rad(-1), math.rad(1)), 
										speed = 0.2
									} }, 
								returnframes = 65, 
								returnspeed = 0.05
							});
						elseif p35[2] == "equip" then
							if p35[1] == "1BT" then
								u29(v118, {
									loops = 2, 
									tables = { {
											frames = 10, 
											value = CFrame.Angles(math.rad(3), math.rad(-2), math.rad(3)), 
											speed = 0.15
										}, {
											frames = 12, 
											value = CFrame.Angles(math.rad(-2), math.rad(0), 0), 
											speed = 0.3
										} }, 
									returnframes = 30, 
									returnspeed = 0.075
								});
							else
								u29(v118, {
									loops = 2, 
									tables = { {
											frames = 10, 
											value = CFrame.Angles(math.rad(-3), math.rad(2), math.rad(-3)), 
											speed = 0.15
										}, {
											frames = 12, 
											value = CFrame.Angles(math.rad(2), math.rad(0), 0), 
											speed = 0.3
										} }, 
									returnframes = 30, 
									returnspeed = 0.075
								});
							end;
						end;
					elseif p35[1] == "2HB" then
						if p35[2] == "swingvar1" then
							u29(v118, {
								loops = 2, 
								tables = { {
										frames = 8, 
										value = CFrame.Angles(math.rad(4), math.rad(-3), math.rad(2)), 
										speed = 0.175
									}, {
										frames = 12, 
										value = CFrame.Angles(math.rad(-3), math.rad(2), math.rad(-3)), 
										speed = 0.2
									} }, 
								returnframes = 30, 
								returnspeed = 0.075
							});
						elseif p35[2] == "swingvar2" then
							u29(v118, {
								loops = 2, 
								tables = { {
										frames = 8, 
										value = CFrame.Angles(math.rad(3), math.rad(4), math.rad(-3)), 
										speed = 0.175
									}, {
										frames = 12, 
										value = CFrame.Angles(math.rad(-4), math.rad(-3), math.rad(4)), 
										speed = 0.2
									} }, 
								returnframes = 30, 
								returnspeed = 0.1
							});
						elseif p35[2] == "swingvar3" then
							u29(v118, {
								loops = 2, 
								tables = { {
										frames = 8, 
										value = CFrame.Angles(math.rad(5), math.rad(1), math.rad(-1)), 
										speed = 0.15
									}, {
										frames = 10, 
										value = CFrame.Angles(math.rad(-4), math.rad(-1), math.rad(1)), 
										speed = 0.2
									} }, 
								returnframes = 30, 
								returnspeed = 0.1
							});
						elseif p35[2] == "charge" then
							u29(v118, {
								loops = 2, 
								tables = { {
										frames = 6, 
										value = CFrame.Angles(math.rad(0), math.rad(4), math.rad(1)), 
										speed = 0.2
									}, {
										frames = 13, 
										value = CFrame.Angles(math.rad(-1), math.rad(-6), math.rad(-3)), 
										speed = 0.3
									} }, 
								returnframes = 65, 
								returnspeed = 0.05
							});
						elseif p35[2] == "equip" then
							u29(v118, {
								loops = 3, 
								tables = { {
										frames = 8, 
										value = CFrame.Angles(math.rad(2), math.rad(2), math.rad(-2)), 
										speed = 0.15
									}, {
										frames = 10, 
										value = CFrame.Angles(math.rad(0), math.rad(0), 0), 
										speed = 0.2
									}, {
										frames = 8, 
										value = CFrame.Angles(math.rad(-2), math.rad(0), math.rad(1)), 
										speed = 0.15
									} }, 
								returnframes = 30, 
								returnspeed = 0.075
							});
						end;
					elseif p35[1] ~= "1HBL" then
						if p35[1] == "1HT" then
							if p35[2] == "swingvar1" then
								u29(v118, {
									loops = 2, 
									tables = { {
											frames = 10, 
											value = CFrame.Angles(0, math.rad(5), math.rad(-2)), 
											speed = 0.15
										}, {
											frames = 10, 
											value = CFrame.Angles(0, math.rad(-5), math.rad(2)), 
											speed = 0.3
										} }, 
									returnframes = 30, 
									returnspeed = 0.075
								});
							elseif p35[2] == "swingvar2" then
								if p35[1] == "1HT" then
									u29(v118, {
										loops = 2, 
										tables = { {
												frames = 10, 
												value = CFrame.Angles(0, math.rad(-5), math.rad(2)), 
												speed = 0.15
											}, {
												frames = 10, 
												value = CFrame.Angles(0, math.rad(5), math.rad(-2)), 
												speed = 0.3
											} }, 
										returnframes = 30, 
										returnspeed = 0.075
									});
								else
									u29(v118, {
										loops = 2, 
										tables = { {
												frames = 10, 
												value = CFrame.Angles(math.rad(-5), math.rad(-3), math.rad(3)), 
												speed = 0.15
											}, {
												frames = 10, 
												value = CFrame.Angles(math.rad(3), math.rad(2), math.rad(-3)), 
												speed = 0.3
											} }, 
										returnframes = 30, 
										returnspeed = 0.1
									});
								end;
							elseif p35[2] == "swingvar3" then
								u29(v118, {
									loops = 1, 
									tables = { {
											frames = 10, 
											value = CFrame.Angles(0, math.rad(5), math.rad(4)), 
											speed = 0.175
										} }, 
									returnframes = 30, 
									returnspeed = 0.1
								});
							elseif p35[2] == "charge" then
								u29(v118, {
									loops = 2, 
									tables = { {
											frames = 5, 
											value = CFrame.Angles(math.rad(0), math.rad(-8), math.rad(3)), 
											speed = 0.1
										}, {
											frames = 8, 
											value = CFrame.Angles(math.rad(0), math.rad(5), math.rad(-5)), 
											speed = 0.3
										} }, 
									returnframes = 70, 
									returnspeed = 0.05
								});
							elseif p35[2] == "equip" then
								u29(v118, {
									loops = 2, 
									tables = { {
											frames = 10, 
											value = CFrame.Angles(math.rad(3), math.rad(2), math.rad(2)), 
											speed = 0.15
										}, {
											frames = 12, 
											value = CFrame.Angles(math.rad(-3), math.rad(-2), 0), 
											speed = 0.3
										} }, 
									returnframes = 30, 
									returnspeed = 0.075
								});
							end;
						elseif p35[1] == "1HS" then
							if p35[2] == "swingvar1" then
								u29(v118, {
									loops = 2, 
									tables = { {
											frames = 10, 
											value = CFrame.Angles(0, math.rad(5), math.rad(-2)), 
											speed = 0.15
										}, {
											frames = 7, 
											value = CFrame.Angles(0, math.rad(-5), math.rad(3)), 
											speed = 0.4
										} }, 
									returnframes = 45, 
									returnspeed = 0.075
								});
							elseif p35[2] == "swingvar2" then
								u29(v118, {
									loops = 2, 
									tables = { {
											frames = 10, 
											value = CFrame.Angles(math.rad(0), math.rad(-5), math.rad(3)), 
											speed = 0.15
										}, {
											frames = 7, 
											value = CFrame.Angles(math.rad(0), math.rad(4), math.rad(-5)), 
											speed = 0.4
										} }, 
									returnframes = 45, 
									returnspeed = 0.1
								});
							elseif p35[2] == "swingvar3" then
								u29(v118, {
									loops = 2, 
									tables = { {
											frames = 10, 
											value = CFrame.Angles(math.rad(6), math.rad(5), math.rad(-3)), 
											speed = 0.15
										}, {
											frames = 7, 
											value = CFrame.Angles(math.rad(-4), math.rad(-2), math.rad(3)), 
											speed = 0.4
										} }, 
									returnframes = 45, 
									returnspeed = 0.1
								});
							elseif p35[2] == "charge" then
								u29(v118, {
									loops = 2, 
									tables = { {
											frames = 5, 
											value = CFrame.Angles(math.rad(3), math.rad(5), math.rad(-5)), 
											speed = 0.1
										}, {
											frames = 8, 
											value = CFrame.Angles(math.rad(-2), math.rad(-7), math.rad(4)), 
											speed = 0.3
										} }, 
									returnframes = 70, 
									returnspeed = 0.05
								});
							elseif p35[2] == "equip" then
								u29(v118, {
									loops = 2, 
									tables = { {
											frames = 10, 
											value = CFrame.Angles(math.rad(5), math.rad(-3), math.rad(4)), 
											speed = 0.15
										}, {
											frames = 12, 
											value = CFrame.Angles(math.rad(-4), math.rad(3), math.rad(-5)), 
											speed = 0.3
										} }, 
									returnframes = 55, 
									returnspeed = 0.075
								});
							end;
						elseif p35[1] == "2HBOW" then
							if p35[2] == "equip" then
								u29(v118, {
									loops = 2, 
									tables = { {
											frames = 12, 
											value = CFrame.Angles(math.rad(3), math.rad(-3), math.rad(2)), 
											speed = 0.1
										}, {
											frames = 14, 
											value = CFrame.Angles(math.rad(-2), math.rad(3), math.rad(-3)), 
											speed = 0.2
										} }, 
									returnframes = 55, 
									returnspeed = 0.075
								});
							end;
						elseif p35[1] == "1PB" then
							if p35[2] == "swingvar1" then
								u29(v118, {
									loops = 2, 
									tables = { {
											frames = 10, 
											value = CFrame.Angles(0, math.rad(5), math.rad(-2)), 
											speed = 0.15
										}, {
											frames = 7, 
											value = CFrame.Angles(0, math.rad(-5), math.rad(3)), 
											speed = 0.4
										} }, 
									returnframes = 45, 
									returnspeed = 0.075
								});
							elseif p35[2] == "swingvar2" then
								u29(v118, {
									loops = 2, 
									tables = { {
											frames = 10, 
											value = CFrame.Angles(math.rad(0), math.rad(-5), math.rad(3)), 
											speed = 0.15
										}, {
											frames = 7, 
											value = CFrame.Angles(math.rad(0), math.rad(4), math.rad(-5)), 
											speed = 0.4
										} }, 
									returnframes = 45, 
									returnspeed = 0.1
								});
							elseif p35[2] == "swingvar3" then
								u29(v118, {
									loops = 2, 
									tables = { {
											frames = 10, 
											value = CFrame.Angles(math.rad(6), math.rad(5), math.rad(-3)), 
											speed = 0.15
										}, {
											frames = 7, 
											value = CFrame.Angles(math.rad(-4), math.rad(-2), math.rad(3)), 
											speed = 0.4
										} }, 
									returnframes = 45, 
									returnspeed = 0.1
								});
							elseif p35[2] == "charge" then
								u29(v118, {
									loops = 2, 
									tables = { {
											frames = 6, 
											value = CFrame.Angles(math.rad(0), math.rad(4), math.rad(1)), 
											speed = 0.2
										}, {
											frames = 13, 
											value = CFrame.Angles(math.rad(-1), math.rad(-6), math.rad(-3)), 
											speed = 0.3
										} }, 
									returnframes = 65, 
									returnspeed = 0.05
								});
							elseif p35[2] == "equip" then
								u29(v118, {
									loops = 2, 
									tables = { {
											frames = 10, 
											value = CFrame.Angles(math.rad(5), math.rad(-3), math.rad(4)), 
											speed = 0.15
										}, {
											frames = 12, 
											value = CFrame.Angles(math.rad(-4), math.rad(3), math.rad(-5)), 
											speed = 0.3
										} }, 
									returnframes = 55, 
									returnspeed = 0.075
								});
							end;
						elseif p35[1] == "1HAXE" then
							if p35[2] == "swingvar1" then
								u29(v118, {
									loops = 1, 
									tables = { {
											frames = 8, 
											value = CFrame.Angles(0, math.rad(10), math.rad(5)), 
											speed = 0.15
										} }, 
									returnframes = 30, 
									returnspeed = 0.15
								});
							elseif p35[2] == "swingvar2" then
								u29(v118, {
									loops = 1, 
									tables = { {
											frames = 8, 
											value = CFrame.Angles(math.rad(0), math.rad(-8), math.rad(-8)), 
											speed = 0.15
										} }, 
									returnframes = 30, 
									returnspeed = 0.15
								});
							elseif p35[2] == "swingvar3" then
								u29(v118, {
									loops = 1, 
									tables = { {
											frames = 8, 
											value = CFrame.Angles(math.rad(0), math.rad(8), math.rad(8)), 
											speed = 0.175
										} }, 
									returnframes = 30, 
									returnspeed = 0.15
								});
							elseif p35[2] == "charge" then
								u29(v118, {
									loops = 2, 
									tables = { {
											frames = 5, 
											value = CFrame.Angles(math.rad(3), math.rad(-5), math.rad(5)), 
											speed = 0.08
										}, {
											frames = 10, 
											value = CFrame.Angles(math.rad(-10), math.rad(5), math.rad(-5)), 
											speed = 0.4
										} }, 
									returnframes = 65, 
									returnspeed = 0.1
								});
							elseif p35[2] == "equip" then
								u29(v118, {
									loops = 2, 
									tables = { {
											frames = 10, 
											value = CFrame.Angles(math.rad(-3), math.rad(-3), math.rad(-3)), 
											speed = 0.15
										}, {
											frames = 12, 
											value = CFrame.Angles(math.rad(0), math.rad(3), math.rad(0)), 
											speed = 0.2
										} }, 
									returnframes = 30, 
									returnspeed = 0.075
								});
							end;
						elseif p35[1] == "2HSPR" then
							if p35[2] == "swingvar1" then
								u29(v118, {
									loops = 1, 
									tables = { {
											frames = 8, 
											value = CFrame.Angles(math.rad(-2), math.rad(-5), math.rad(3)), 
											speed = 0.15
										} }, 
									returnframes = 30, 
									returnspeed = 0.15
								});
							elseif p35[2] == "swingvar2" then
								u29(v118, {
									loops = 2, 
									tables = { {
											frames = 8, 
											value = CFrame.Angles(math.rad(3), math.rad(4), math.rad(-3)), 
											speed = 0.175
										}, {
											frames = 12, 
											value = CFrame.Angles(math.rad(-4), math.rad(-3), math.rad(4)), 
											speed = 0.2
										} }, 
									returnframes = 30, 
									returnspeed = 0.1
								});
							elseif p35[2] == "swingvar3" then
								u29(v118, {
									loops = 2, 
									tables = { {
											frames = 8, 
											value = CFrame.Angles(0, math.rad(6), math.rad(3)), 
											speed = 0.15
										}, {
											frames = 12, 
											value = CFrame.Angles(0, math.rad(-4), math.rad(-0.5)), 
											speed = 0.3
										} }, 
									returnframes = 30, 
									returnspeed = 0.1
								});
							elseif p35[2] == "charge" then
								u29(v118, {
									loops = 2, 
									tables = { {
											frames = 5, 
											value = CFrame.Angles(math.rad(-5), math.rad(-8), math.rad(8)), 
											speed = 0.1
										}, {
											frames = 8, 
											value = CFrame.Angles(math.rad(2), math.rad(3), math.rad(-5)), 
											speed = 0.3
										} }, 
									returnframes = 65, 
									returnspeed = 0.05
								});
							elseif p35[2] == "equip" then
								u29(v118, {
									loops = 2, 
									tables = { {
											frames = 8, 
											value = CFrame.Angles(math.rad(5), math.rad(-3), math.rad(3)), 
											speed = 0.1
										}, {
											frames = 12, 
											value = CFrame.Angles(math.rad(-3), 0, math.rad(-2)), 
											speed = 0.3
										} }, 
									returnframes = 40, 
									returnspeed = 0.075
								});
							end;
						elseif p35[1] == "LSMG" then
							if p35[2] == "swing" then
								u29(v118, {
									loops = 2, 
									tables = { {
											frames = 20, 
											value = CFrame.Angles(math.rad(-1), math.rad(-6), math.rad(-3)), 
											speed = 0.075
										}, {
											frames = 15, 
											value = CFrame.Angles(math.rad(0), math.rad(6), math.rad(2)), 
											speed = 0.2
										} }, 
									returnframes = 65, 
									returnspeed = 0.05
								});
							elseif p35[2] == "equip" then
								u29(v118, {
									loops = 2, 
									tables = { {
											frames = 13, 
											value = CFrame.Angles(math.rad(5), math.rad(-3), math.rad(4)), 
											speed = 0.15
										}, {
											frames = 17, 
											value = CFrame.Angles(math.rad(-4), math.rad(3), math.rad(-5)), 
											speed = 0.3
										} }, 
									returnframes = 55, 
									returnspeed = 0.075
								});
							elseif p35[2] == "bolt" then
								u29(v118, {
									loops = 2, 
									tables = { {
											frames = 13, 
											value = CFrame.Angles(math.rad(-2), math.rad(0), math.rad(0)), 
											speed = 0.15
										}, {
											frames = 13, 
											value = CFrame.Angles(math.rad(2), math.rad(0), math.rad(0)), 
											speed = 0.3
										} }, 
									returnframes = 55, 
									returnspeed = 0.075
								});
							end;
						elseif p35[1] == "RV" then
							if p35[2] == "equip" then
								u29(v118, {
									loops = 2, 
									tables = { {
											frames = 10, 
											value = CFrame.Angles(math.rad(-5), math.rad(0), math.rad(3)), 
											speed = 0.2
										}, {
											frames = 12, 
											value = CFrame.Angles(math.rad(3), math.rad(2), math.rad(-2)), 
											speed = 0.3
										} }, 
									returnframes = 45, 
									returnspeed = 0.075
								});
							end;
						elseif p35[1] == "MRV" then
							if p35[2] == "equip" then
								u29(v118, {
									loops = 2, 
									tables = { {
											frames = 10, 
											value = CFrame.Angles(math.rad(5), math.rad(0), math.rad(3)), 
											speed = 0.2
										}, {
											frames = 12, 
											value = CFrame.Angles(math.rad(-3), math.rad(2), math.rad(-2)), 
											speed = 0.3
										} }, 
									returnframes = 45, 
									returnspeed = 0.075
								});
							end;
						elseif p35[1] ~= "SMG" then
							if p35[1] == "ASMG" then
								if p35[2] == "equip" then
									u29(v118, {
										loops = 2, 
										tables = { {
												frames = 12, 
												value = CFrame.Angles(math.rad(-6), math.rad(2), math.rad(4)), 
												speed = 0.15
											}, {
												frames = 8, 
												value = CFrame.Angles(math.rad(4), math.rad(3), math.rad(-3)), 
												speed = 0.3
											} }, 
										returnframes = 50, 
										returnspeed = 0.075
									});
								end;
							elseif p35[1] == "RFL" then
								if p35[2] == "equip" then
									u29(v118, {
										loops = 2, 
										tables = { {
												frames = 10, 
												value = CFrame.Angles(math.rad(6), math.rad(-3), math.rad(-4)), 
												speed = 0.25
											}, {
												frames = 12, 
												value = CFrame.Angles(math.rad(-6), math.rad(3), math.rad(3)), 
												speed = 0.1
											} }, 
										returnframes = 50, 
										returnspeed = 0.075
									});
								end;
							elseif p35[1] == "PST" then
								if p35[2] == "equip" then
									u29(v118, {
										loops = 1, 
										tables = { {
												frames = 11, 
												value = CFrame.Angles(math.rad(-6), math.rad(-2), math.rad(3)), 
												speed = 0.12
											} }, 
										returnframes = 40, 
										returnspeed = 0.065
									});
								end;
							elseif p35[1] == "2HPST" then
								if p35[2] == "equip" then
									u29(v118, {
										loops = 1, 
										tables = { {
												frames = 11, 
												value = CFrame.Angles(math.rad(-7), math.rad(-3), math.rad(4)), 
												speed = 0.12
											} }, 
										returnframes = 40, 
										returnspeed = 0.065
									});
								end;
							elseif p35[1] == "DBB" then
								if p35[2] == "equip" then
									u29(v118, {
										loops = 2, 
										tables = { {
												frames = 8, 
												value = CFrame.Angles(math.rad(-4), math.rad(2), math.rad(1.5)), 
												speed = 0.25
											}, {
												frames = 10, 
												value = CFrame.Angles(math.rad(6), math.rad(0), math.rad(0)), 
												speed = 0.3
											} }, 
										returnframes = 30, 
										returnspeed = 0.08
									});
								end;
							elseif p35[1] == "Item" then
								if p35[2] == "equip" then
									u29(v118, {
										loops = 2, 
										tables = { {
												frames = 8, 
												value = CFrame.Angles(math.rad(-3.5), math.rad(2), math.rad(1.5)), 
												speed = 0.25
											}, {
												frames = 10, 
												value = CFrame.Angles(math.rad(4), math.rad(0), math.rad(0)), 
												speed = 0.3
											} }, 
										returnframes = 30, 
										returnspeed = 0.08
									});
								end;
							end;
						elseif p35[2] == "equip" then
							u29(v118, {
								loops = 2, 
								tables = { {
										frames = 12, 
										value = CFrame.Angles(math.rad(-6), math.rad(2), math.rad(4)), 
										speed = 0.15
									}, {
										frames = 8, 
										value = CFrame.Angles(math.rad(4), math.rad(3), math.rad(-3)), 
										speed = 0.3
									} }, 
								returnframes = 50, 
								returnspeed = 0.075
							});
						end;
					elseif p35[2] == "swingvar1" then
						u29(v118, {
							loops = 2, 
							tables = { {
									frames = 10, 
									value = CFrame.Angles(0, math.rad(5), math.rad(-2)), 
									speed = 0.15
								}, {
									frames = 10, 
									value = CFrame.Angles(0, math.rad(-5), math.rad(2)), 
									speed = 0.3
								} }, 
							returnframes = 30, 
							returnspeed = 0.075
						});
					elseif p35[2] == "swingvar2" then
						if p35[1] == "1HT" then
							u29(v118, {
								loops = 2, 
								tables = { {
										frames = 10, 
										value = CFrame.Angles(0, math.rad(-5), math.rad(2)), 
										speed = 0.15
									}, {
										frames = 10, 
										value = CFrame.Angles(0, math.rad(5), math.rad(-2)), 
										speed = 0.3
									} }, 
								returnframes = 30, 
								returnspeed = 0.075
							});
						else
							u29(v118, {
								loops = 2, 
								tables = { {
										frames = 10, 
										value = CFrame.Angles(math.rad(-5), math.rad(-3), math.rad(3)), 
										speed = 0.15
									}, {
										frames = 10, 
										value = CFrame.Angles(math.rad(3), math.rad(2), math.rad(-3)), 
										speed = 0.3
									} }, 
								returnframes = 30, 
								returnspeed = 0.1
							});
						end;
					elseif p35[2] == "swingvar3" then
						u29(v118, {
							loops = 1, 
							tables = { {
									frames = 10, 
									value = CFrame.Angles(0, math.rad(5), math.rad(4)), 
									speed = 0.175
								} }, 
							returnframes = 30, 
							returnspeed = 0.1
						});
					elseif p35[2] == "charge" then
						u29(v118, {
							loops = 2, 
							tables = { {
									frames = 5, 
									value = CFrame.Angles(math.rad(0), math.rad(-8), math.rad(3)), 
									speed = 0.1
								}, {
									frames = 8, 
									value = CFrame.Angles(math.rad(0), math.rad(5), math.rad(-5)), 
									speed = 0.3
								} }, 
							returnframes = 70, 
							returnspeed = 0.05
						});
					elseif p35[2] == "equip" then
						u29(v118, {
							loops = 2, 
							tables = { {
									frames = 10, 
									value = CFrame.Angles(math.rad(3), math.rad(2), math.rad(2)), 
									speed = 0.15
								}, {
									frames = 12, 
									value = CFrame.Angles(math.rad(-3), math.rad(-2), 0), 
									speed = 0.3
								} }, 
							returnframes = 30, 
							returnspeed = 0.075
						});
					end;
				elseif p35[2] == "swingvar1" then
					u29(v118, {
						loops = 2, 
						tables = { {
								frames = 8, 
								value = CFrame.Angles(math.rad(3), math.rad(1), math.rad(-3)), 
								speed = 0.15
							}, {
								frames = 10, 
								value = CFrame.Angles(math.rad(-3), math.rad(-1), math.rad(4)), 
								speed = 0.2
							} }, 
						returnframes = 30, 
						returnspeed = 0.075
					});
				elseif p35[2] == "swingvar2" then
					u29(v118, {
						loops = 2, 
						tables = { {
								frames = 8, 
								value = CFrame.Angles(math.rad(3), math.rad(5), math.rad(-3)), 
								speed = 0.15
							}, {
								frames = 10, 
								value = CFrame.Angles(math.rad(-3), math.rad(-4), math.rad(3)), 
								speed = 0.2
							} }, 
						returnframes = 30, 
						returnspeed = 0.1
					});
				elseif p35[2] == "swingvar3" then
					u29(v118, {
						loops = 2, 
						tables = { {
								frames = 8, 
								value = CFrame.Angles(math.rad(0), math.rad(5), math.rad(-4)), 
								speed = 0.1
							}, {
								frames = 10, 
								value = CFrame.Angles(math.rad(0), math.rad(-4), math.rad(5)), 
								speed = 0.2
							} }, 
						returnframes = 30, 
						returnspeed = 0.1
					});
				elseif p35[2] == "charge" then
					u29(v118, {
						loops = 2, 
						tables = { {
								frames = 8, 
								value = CFrame.Angles(math.rad(6), math.rad(1), math.rad(-3)), 
								speed = 0.2
							}, {
								frames = 8, 
								value = CFrame.Angles(math.rad(-1), math.rad(-1), math.rad(1)), 
								speed = 0.2
							} }, 
						returnframes = 65, 
						returnspeed = 0.05
					});
				elseif p35[2] == "equip" then
					if p35[1] == "1BT" then
						u29(v118, {
							loops = 2, 
							tables = { {
									frames = 10, 
									value = CFrame.Angles(math.rad(3), math.rad(-2), math.rad(3)), 
									speed = 0.15
								}, {
									frames = 12, 
									value = CFrame.Angles(math.rad(-2), math.rad(0), 0), 
									speed = 0.3
								} }, 
							returnframes = 30, 
							returnspeed = 0.075
						});
					else
						u29(v118, {
							loops = 2, 
							tables = { {
									frames = 10, 
									value = CFrame.Angles(math.rad(-3), math.rad(2), math.rad(-3)), 
									speed = 0.15
								}, {
									frames = 12, 
									value = CFrame.Angles(math.rad(2), math.rad(0), 0), 
									speed = 0.3
								} }, 
							returnframes = 30, 
							returnspeed = 0.075
						});
					end;
				end;
			elseif p35[2] == "swingvar1" then
				u29(v118, {
					loops = 1, 
					tables = { {
							frames = 5, 
							value = CFrame.Angles(0, math.rad(-7), math.rad(-7)), 
							speed = 0.15
						} }, 
					returnframes = 30, 
					returnspeed = 0.1
				});
			elseif p35[2] == "swingvar2" then
				u29(v118, {
					loops = 2, 
					tables = { {
							frames = 5, 
							value = CFrame.Angles(math.rad(-3), math.rad(3), math.rad(5)), 
							speed = 0.15
						}, {
							frames = 10, 
							value = CFrame.Angles(math.rad(3), math.rad(-1.5), math.rad(-1)), 
							speed = 0.3
						} }, 
					returnframes = 30, 
					returnspeed = 0.1
				});
			elseif p35[2] == "swingvar3" then
				u29(v118, {
					loops = 2, 
					tables = { {
							frames = 5, 
							value = CFrame.Angles(0, math.rad(5), math.rad(3)), 
							speed = 0.15
						}, {
							frames = 8, 
							value = CFrame.Angles(0, math.rad(-3), math.rad(-0.5)), 
							speed = 0.4
						} }, 
					returnframes = 30, 
					returnspeed = 0.1
				});
			elseif p35[2] == "charge" then
				u29(v118, {
					loops = 2, 
					tables = { {
							frames = 5, 
							value = CFrame.Angles(0, math.rad(-8), math.rad(-3)), 
							speed = 0.125
						}, {
							frames = 10, 
							value = CFrame.Angles(0, math.rad(10), math.rad(0.5)), 
							speed = 0.4
						} }, 
					returnframes = 65, 
					returnspeed = 0.05
				});
			elseif p35[2] == "equip" then
				u29(v118, {
					loops = 1, 
					tables = { {
							frames = 12, 
							value = CFrame.Angles(math.rad(3), 0, 0), 
							speed = 0.5
						} }, 
					returnframes = 30, 
					returnspeed = 0.075
				});
			end;
		elseif p34 == "shove" then
			u29(v118, {
				loops = 2, 
				tables = { {
						frames = 8, 
						value = CFrame.Angles(math.rad(5), 0, 0), 
						speed = 0.15
					}, {
						frames = 8, 
						value = CFrame.Angles(math.rad(-6), 0, 0), 
						speed = 0.3
					} }, 
				returnframes = 20, 
				returnspeed = 0.2
			});
		elseif p34 == "stagger" then
			u29(v118, {
				loops = 3, 
				tables = { {
						frames = 10, 
						value = CFrame.Angles(math.rad(15), math.rad(-15), math.rad(15)), 
						speed = 0.05
					}, {
						frames = 15, 
						value = CFrame.Angles(math.rad(-15), math.rad(-15), math.rad(-15)), 
						speed = 0.035
					}, {
						frames = 15, 
						value = CFrame.Angles(math.rad(-15), math.rad(8), math.rad(8)), 
						speed = 0.035
					} }, 
				returnframes = 70, 
				returnspeed = 0.05
			});
		elseif p34 == "tinnitus" then
			u29(v118, {
				loops = 6, 
				tables = { {
						frames = 20, 
						value = CFrame.Angles(math.rad(15), math.rad(-15), math.rad(15)), 
						speed = 0.025
					}, {
						frames = 25, 
						value = CFrame.Angles(math.rad(-15), math.rad(-15), math.rad(-15)), 
						speed = 0.015
					}, {
						frames = 20, 
						value = CFrame.Angles(math.rad(-15), math.rad(8), math.rad(8)), 
						speed = 0.015
					}, {
						frames = 20, 
						value = CFrame.Angles(math.rad(10), math.rad(-10), math.rad(10)), 
						speed = 0.025
					}, {
						frames = 25, 
						value = CFrame.Angles(math.rad(-15), math.rad(-25), math.rad(-15)), 
						speed = 0.015
					}, {
						frames = 25, 
						value = CFrame.Angles(math.rad(-5), math.rad(8), math.rad(5)), 
						speed = 0.015
					} }, 
				returnframes = 70, 
				returnspeed = 0.05
			});
		elseif p34 == "abilityshake" then
			u29(v118, {
				loops = 4, 
				tables = { {
						frames = 4, 
						value = CFrame.Angles(math.rad(0), math.rad(0), math.rad(6)), 
						speed = 0.2
					}, {
						frames = 4, 
						value = CFrame.Angles(math.rad(0), math.rad(0), math.rad(-5)), 
						speed = 0.2
					}, {
						frames = 4, 
						value = CFrame.Angles(math.rad(0), math.rad(0), math.rad(3)), 
						speed = 0.2
					}, {
						frames = 4, 
						value = CFrame.Angles(math.rad(0), math.rad(0), math.rad(-2)), 
						speed = 0.2
					} }, 
				returnframes = 70, 
				returnspeed = 0.05
			});
		elseif p34 == "tased" then
			u29(v118, {
				loops = 9, 
				tables = { {
						frames = 5, 
						value = CFrame.Angles(math.rad(math.random(-15, 15) / 4), math.rad(math.random(-15, 15) / 4), math.rad(math.random(-15, 15) / 4)), 
						speed = 0.3
					}, {
						frames = 5, 
						value = CFrame.Angles(math.rad(math.random(-15, 15) / 4), math.rad(math.random(-15, 15) / 4), math.rad(math.random(-15, 15) / 4)), 
						speed = 0.3
					}, {
						frames = 5, 
						value = CFrame.Angles(math.rad(math.random(-15, 15) / 4), math.rad(math.random(-15, 15) / 4), math.rad(math.random(-15, 15) / 4)), 
						speed = 0.3
					}, {
						frames = 5, 
						value = CFrame.Angles(math.rad(math.random(-15, 15) / 4), math.rad(math.random(-15, 15) / 4), math.rad(math.random(-15, 15) / 4)), 
						speed = 0.3
					}, {
						frames = 5, 
						value = CFrame.Angles(math.rad(math.random(-15, 15) / 4), math.rad(math.random(-15, 15) / 4), math.rad(math.random(-15, 15) / 4)), 
						speed = 0.3
					}, {
						frames = 5, 
						value = CFrame.Angles(math.rad(math.random(-15, 15) / 4), math.rad(math.random(-15, 15) / 4), math.rad(math.random(-15, 15) / 4)), 
						speed = 0.3
					}, {
						frames = 5, 
						value = CFrame.Angles(math.rad(math.random(-15, 15) / 4), math.rad(math.random(-15, 15) / 4), math.rad(math.random(-15, 15) / 4)), 
						speed = 0.3
					}, {
						frames = 5, 
						value = CFrame.Angles(math.rad(math.random(-15, 15) / 4), math.rad(math.random(-15, 15) / 4), math.rad(math.random(-15, 15) / 4)), 
						speed = 0.3
					}, {
						frames = 5, 
						value = CFrame.Angles(math.rad(math.random(-15, 15) / 4), math.rad(math.random(-15, 15) / 4), math.rad(math.random(-15, 15) / 4)), 
						speed = 0.3
					} }, 
				returnframes = 60, 
				returnspeed = 0.05
			});
		elseif p34 == "damage" then
			local v119 = math.clamp(p35[1] * 0.35, 2, 20);
			local v120 = { math.random(-v119 * 10, v119 * 10) / 10, math.random(-v119 * 10, v119 * 10) / 10, math.random(-v119 * 10, v119 * 10) / 10 };
			u29(v118, {
				loops = 1, 
				tables = { {
						frames = 10, 
						value = CFrame.Angles(math.rad(v120[1]), math.rad(v120[2]), math.rad(v120[3])), 
						speed = 0.6
					} }, 
				returnframes = 100 + v119, 
				returnspeed = math.clamp(0.2 - p35[1] / 70, 0.03, 0.2)
			});
		elseif p34 == "gunrecoil" then
			local v121 = p35[1];
			local v122 = { v121, math.random(-v121, v121) / 2 };
			u29(v118, {
				loops = 1, 
				tables = { {
						frames = 6, 
						value = CFrame.Angles(math.rad(v122[1]), math.rad(v122[2]), 0), 
						speed = 0.2 + v121 / 300
					} }, 
				returnframes = 150 + v121 * 5, 
				returnspeed = 0.2 - v121 / 200
			});
		elseif p34 == "jumpstart" then
			u29(v118, {
				loops = 2, 
				tables = { {
						frames = 3, 
						value = CFrame.Angles(math.rad(-5), 0, 0), 
						speed = 0.2
					}, {
						frames = 6, 
						value = CFrame.Angles(math.rad(5), 0, 0), 
						speed = 0.2
					} }, 
				returnframes = 30, 
				returnspeed = 0.1
			});
		elseif p34 == "jumpland" then
			u29(v118, {
				loops = 1, 
				tables = { {
						frames = 6, 
						value = CFrame.Angles(math.rad(-5), 0, 0), 
						speed = 0.2
					} }, 
				returnframes = 30, 
				returnspeed = 0.1
			});
		elseif p34 == "slide" then
			u29(v118, {
				loops = 1, 
				tables = { {
						frames = 30, 
						value = CFrame.Angles(0, 0, math.rad(8)), 
						speed = 0.05
					} }, 
				returnframes = 40, 
				returnspeed = 0.075
			});
		elseif p34 == "guntilt" then
			local v123 = p35[1] / 2;
			local v124 = v123;
			if math.random(1, 2) == 1 then
				v124 = -v124;
			end;
			u29(v118, {
				loops = 2, 
				tables = { {
						frames = 4, 
						value = CFrame.Angles(0, 0, math.rad(v124)), 
						speed = 0.2 + v123 / 300
					}, {
						frames = 4, 
						value = CFrame.Angles(0, 0, math.rad(-v124)), 
						speed = 0.2 + v123 / 300
					} }, 
				returnframes = 150 + v123 * 5, 
				returnspeed = 0.2 - v123 / 200
			});
		elseif p34 == "usestim" then
			u29(v118, {
				loops = 2, 
				tables = { {
						frames = 10, 
						value = CFrame.Angles(math.rad(2), math.rad(3), math.rad(2)), 
						speed = 0.1
					}, {
						frames = 8, 
						value = CFrame.Angles(math.rad(0), math.rad(0), math.rad(-4)), 
						speed = 0.2
					} }, 
				returnframes = 30, 
				returnspeed = 0.2
			});
		elseif p34 == "climb" then
			u29(v118, {
				loops = 2, 
				tables = { {
						frames = 11, 
						value = CFrame.Angles(math.rad(4), math.rad(6), math.rad(-7)), 
						speed = 0.1
					}, {
						frames = 8, 
						value = CFrame.Angles(math.rad(-4), math.rad(0), math.rad(6)), 
						speed = 0.2
					} }, 
				returnframes = 30, 
				returnspeed = 0.2
			});
		elseif p34 == "backpack" then
			u29(v118, {
				loops = 4, 
				tables = { {
						frames = 8, 
						value = CFrame.Angles(math.rad(3), math.rad(-4), math.rad(-4)), 
						speed = 0.1
					}, {
						frames = 6, 
						value = CFrame.Angles(math.rad(-3), math.rad(-4), math.rad(4)), 
						speed = 0.2
					}, {
						frames = 8, 
						value = CFrame.Angles(math.rad(3), math.rad(4), math.rad(4)), 
						speed = 0.1
					}, {
						frames = 6, 
						value = CFrame.Angles(math.rad(-3), math.rad(4), math.rad(-4)), 
						speed = 0.2
					} }, 
				returnframes = 30, 
				returnspeed = 0.2
			});
		end;
		u27[v118] = nil;
	end);
end;
sprint_stam = 100;
buff_sprint_stam = 0;
gun_holster_timer = tick();
sprint_lockout = 0;
local u30 = {
	w = false, 
	a = false, 
	s = false, 
	d = false
};
adjustcamto = Vector3.new(0, 0, 0);
crouch_wait = tick();
crouch_held = false;
ajustarmpos = CFrame.new(0, 0, 0);
ajustarmposto = CFrame.new(0, 0, 0);
local u31 = Vector3.new(0, 1.5, 0);
slide_wait = tick();
local function u32()
	if u9.air == true or u9.sprinting == true or u9.sliding == true then
		return;
	end;
	if u9.sneaking == true then
		u9.sneaking = false;
		return;
	end;
	if tick() - crouch_wait <= 0.5 then
		return;
	end;
	crouch_wait = tick();
	u9.sneaking = true;
	u22 = u22 - 6;
	u31 = Vector3.new(0, 0.75, 0);
	l__workspace__1.ServerStuff.movementAdjust:FireServer("sneak", true);
	ajustarmpos = CFrame.new(0, -0.2, 0);
	check_walking_anim();
	while true do
		RS:wait();
		if u9.sprinting == true then
			break;
		end;
		if u9.air == true then
			break;
		end;
		if u9.staggering == true then
			break;
		end;
		if u9.channel == true then
			break;
		end;
		if u9.sneaking == false then
			break;
		end;	
	end;
	ajustarmpos = CFrame.new(0, 0, 0);
	crouch_wait = tick();
	u31 = Vector3.new(0, 1.5, 0);
	l__workspace__1.ServerStuff.movementAdjust:FireServer("sneak", false);
	u9.sneaking = false;
	u22 = u22 + 6;
	check_walking_anim();
end;
function drop_slide()
	if u9.air ~= true then
		if u9.sneaking ~= true then
			if not u10.Exhaustion then
				if u11 < 1 then

				else
					slide_wait = tick();
					u9.sneaking = false;
					u9.sliding = true;
					u9.sprinting = false;
					u9.canjump = false;
					u31 = Vector3.new(0, 0.6, 0);
					sprint_stam = sprint_stam - 35;
					local v125 = Instance.new("BodyVelocity");
					v125.Name = "parkourPositionThing";
					v125.P = 100;
					v125.MaxForce = Vector3.new(math.huge, math.huge, math.huge);
					v125.Velocity = character.HumanoidRootPart.CFrame.lookVector * (8 + hum.WalkSpeed);
					v125.Parent = character.HumanoidRootPart;
					globalanimsets.slide:Play(0.1, 1, 1.5);
					gun_holster_timer = tick();
					u22 = u22 - 80;
					shakecamera("slide");
					tpglobalanimsets.slide:Play(0.1, 1, 1);
					l__workspace__1.ServerStuff.playAudio:FireServer({ "movement_sounds" }, "slide", character.HumanoidRootPart, 0.1);
					while true do
						if not raycastline(character.HumanoidRootPart.Position, character.HumanoidRootPart.CFrame.lookVector, 3, baselayer) then

						else
							break;
						end;
						if 0.2 <= tick() - slide_wait then
							tpglobalanimsets.slide:Play(0);
						end;
						v125.Velocity = character.HumanoidRootPart.CFrame.lookVector * 22;
						RS:wait();
						if not (0.7 <= tick() - slide_wait) then

						else
							break;
						end;
						if u9.staggering ~= true then

						else
							break;
						end;
						if u9.sliding ~= false then

						else
							break;
						end;
						if u9.air ~= true then

						else
							break;
						end;					
					end;
					tpglobalanimsets.slide:Stop(0.4);
					u22 = u22 + 80;
					globalanimsets.slide:Stop(0.5);
					v125:Destroy();
					u9.sliding = false;
					u9.canjump = true;
					slide_wait = tick();
					if crouch_held == true then
						if u9.staggering == false then
							u32();
							return;
						else
							u31 = Vector3.new(0, 1.5, 0);
							return;
						end;
					else
						u31 = Vector3.new(0, 1.5, 0);
						return;
					end;
				end;
			end;
		end;
	end;
end;
local u33 = 0;
local u34 = 0;
local u35 = 0;
local u36 = {
	ticktimers = {}, 
	tagged = {}, 
	suslevels = {}, 
	damagedealt = {}, 
	nowinshowdown = false
};
l__workspace__1.ServerStuff.eventTime.OnClientEvent:Connect(function(p36, p37)
	if p36 == "showdownbegin" then
		v101({ "events" }, "duel", nil, nil, true, true);
		v101({ "events" }, "thunder", nil, nil, true, true);
		l__game__7.ReplicatedStorage.misc.showdownFX:Clone().Parent = ply.PlayerGui;
		u36.nowinshowdown = true;
		afflictstatus(require(l__game__7.Workspace.ServerStuff.Statistics.S_STATISTICS).Shd);
		local v126 = l__workspace__1.NoTarget:WaitForChild(p37);
		while l__workspace__1.NoTarget:FindFirstChild(p37) do
			if (character.Torso.Position - l__workspace__1.NoTarget:FindFirstChild(p37).centre.Position).magnitude < 20 then
				afflictstatus(require(l__game__7.Workspace.ServerStuff.Statistics.S_STATISTICS).Shd);
			end;
			RS:wait();
			if l__workspace__1.NoTarget:FindFirstChild(p37) == nil then
				break;
			end;
			if hum.Health <= 0 then
				break;
			end;		
		end;
	elseif p36 == "showdownover" then
		u36.nowinshowdown = false;
	end;
end);
function trigger_map_item_func(p38, p39, p40)
	if p38 ~= nil then
		if p38.Parent == nil then
			return;
		end;
	else
		return;
	end;
	if p38 then
		if p38.Parent then
			if p38.Name ~= "CRBarrel" then
				if p38.Name == "SANCBarrel" then
					l__workspace__1.ServerStuff.detBarrel:FireServer(p38.Parent.Parent);
					return;
				end;
			else
				l__workspace__1.ServerStuff.detBarrel:FireServer(p38.Parent.Parent);
				return;
			end;
		end;
	end;
	if p38 then
		if p38.Parent then
			if p38.Parent.Parent then
				if p38.Parent.Parent.Name ~= "Barrel" then
					if p38.Parent.Parent.Name == "S.A.N.C Barrel" then
						l__workspace__1.ServerStuff.detBarrel:FireServer(p38.Parent.Parent);
						return;
					end;
				else
					l__workspace__1.ServerStuff.detBarrel:FireServer(p38.Parent.Parent);
					return;
				end;
			end;
		end;
	end;
	if p38 then
		if p38.Parent then
			if p38.Name == "CRPylon" then
				local v127 = 10;
				if p39 == "gundamage" then
					v127 = 1;
				end;
				if v127 <= p40 then
					l__workspace__1.ServerStuff.detBarrel:FireServer(p38.Parent.Parent, false);
				end;
			end;
		end;
	end;
end;
l__workspace__1.ServerStuff.getStatsBack.OnClientEvent:Connect(function(p41)
	if hum and hum.Health > 0 then
		playerstats = p41;
	end;
	update_player_challenges();
end);
local u37 = false;
local function u38(p42, p43)
	if startperk.Value == "hubbing" then
		return;
	end;
	handle_scrap_drop(0);
	v101({ "general" }, "funcadd", nil, nil, true, true);
	u16 = u16 + p42;
	local v128 = maingui.SponsorFrame.funcgains.funclabel:Clone();
	l__Debris__27:AddItem(v128, 5);
	local v129 = "+";
	if p42 < 0 then
		v129 = "";
	end;
	v128.Text = v129 .. p42 .. " " .. p43;
	v128.Visible = true;
	v128.Parent = maingui.SponsorFrame.funcgains;
	maingui.SponsorFrame.funclabel.Text = u16;
	spawn(function()
		local v130 = tick();
		while true do
			v128.TextColor3 = v128.TextColor3:Lerp(Color3.new(1, 1, 1), 0.2);
			RS:wait();
			if tick() - v130 >= 3 then
				break;
			end;		
		end;
		for v131 = 1, 20 do
			v128.TextTransparency = v128.TextTransparency + 0.05;
			RS:wait();
		end;
		v128:Destroy();
	end);
	if tonumber(maingui.SponsorFrame.funclabel.Text) >= 2000 then
		ply:Kick(filth[math.random(1, #filth)]);
	end;
	if u16 >= 2000 then
		ply:Kick(filth[math.random(1, #filth)]);
	end;
end;
local u39 = false;
local u40 = 0;
local function u41()
	if bloodsprayDealt > 35 or u33 > 35 then
		if bloodsprayDealt > 35 then
			if u34 < 5 then
				u34 = u34 + 1;
				if startperk.Value == "hiddenB" then
					return;
				end;
				l__workspace__1.ServerStuff.paintWeapon:FireServer(u34, "arms");
			end;
			bloodsprayDealt = 0;
			if v6[1][1] ~= "Fist" and v6[1][2] == true then
				bloodtier = bloodtier + 1;
				if bloodtier <= 6 then
					if startperk.Value == "hiddenB" then
						return;
					end;
					l__workspace__1.ServerStuff.paintWeapon:FireServer(bloodtier, "wep");
					sharedm.paintwep(u19.Model, bloodtier);
				end;
			end;
		elseif u33 > 35 then
			if u35 < 3 then
				u35 = u35 + 1;
				if startperk.Value == "hiddenB" then
					return;
				end;
				l__workspace__1.ServerStuff.paintWeapon:FireServer(u35, "body");
			end;
			u33 = 0;
		end;
		local v132 = { 283862058, 512386098, 401399563, 1381005589, 1187880846, 1051288252 };
		local v133 = Instance.new("ImageLabel");
		l__Debris__27:AddItem(v133, 5);
		local v134 = math.random(250, 300);
		v133.Size = UDim2.new(0.5, v134, 0.5, v134);
		v133.AnchorPoint = Vector2.new(0.5, 0.5);
		if math.random(1, 2) == 1 then
			local v135 = 0.9;
		else
			v135 = 0.1;
		end;
		v133.Position = UDim2.new(v135 + math.random(-5, 5) / 100, 0, math.random(0, 20) / 20, 0);
		v133.Rotation = math.random(0, 360);
		v133.ZIndex = 4;
		v133.BackgroundTransparency = 1;
		v133.BorderSizePixel = 0;
		v133.Image = "rbxassetid://" .. v132[math.random(1, #v132)];
		v133.Parent = maingui;
		delay(math.random(15, 25) / 10, function()
			for v136 = 1, 40 do
				v133.ImageTransparency = v136 / 40;
				RS:wait();
			end;
			v133:Destroy();
		end);
	end;
end;
local u42 = 0;
local function u43(p44, p45)
	if p45 == nil then
		return;
	end;
	local v137 = l__game__7.ReplicatedStorage.effects.damagenumber:Clone();
	l__Debris__27:AddItem(v137, 5);
	v137.bg.label.Text = math.ceil(p45);
	if p45 >= 70 then
		v137.bg.label.TextColor3 = Color3.new(0.9, 0, 0);
		v137.bg.label.TextSize = 30;
	end;
	v137.CFrame = CFrame.new(p44) * CFrame.new(math.random(-20, 20) / 10, 0, math.random(-20, 20) / 10);
	v137.Parent = l__workspace__1.Camera;
	local l__CFrame__44 = v137.CFrame;
	spawn(function()
		for v138 = 1, 20 do
			v137.CFrame = v137.CFrame:Lerp(l__CFrame__44 * CFrame.new(0, 2.5, 0), 0.1);
			RS:wait();
		end;
		delay(1, function()
			for v139 = 1, 20 do
				if v137.Parent == nil then
					return;
				end;
				v137.bg.label.TextTransparency = v137.bg.label.TextTransparency + 0.05;
				v137.bg.label.TextStrokeTransparency = v137.bg.label.TextTransparency;
				RS:wait();
			end;
			v137:Destroy();
		end);
	end);
end;
local function v140()
	v101({ "hitsound", "general" }, "throwhit", nil, nil, true, true);
	local v141 = maingui.Centre.ThrowHitmarker:Clone();
	v141.ImageTransparency = 0;
	v141.Parent = maingui.Centre;
	spawn(function()
		while true do
			v141.ImageTransparency = v141.ImageTransparency + 0.04;
			RS:wait();
			if v141.ImageTransparency == 1 then
				break;
			end;
			if v141.ImageTransparency > 1 then
				break;
			end;		
		end;
		v141:Destroy();
	end);
end;
l__workspace__1.ServerStuff.hitmarker.OnClientEvent:Connect(v140);
local u45 = 0;
local u46 = 1;
local u47 = v46;
local function u48(p46, p47, p48)
	local v142 = u17;
	if p48 == true then
		v142 = akimbo_factors.alt_weapon_stats;
	end;
	local l__CFrame__143 = l__CurrentCamera__1.CFrame;
	local v144 = 4 + 0.4 * v142.sizerating;
	if v142.sizerating == 4 then
		v144 = v144 + 0.45;
	end;
	local v145 = v144 - 1.65;
	local v146 = false;
	local v147 = false;
	local v148 = Vector3.new(0, 0, 0);
	local v149 = "meleedamage";
	if (v142.weapontype == "Gun" or v142.weapontype == "Bow") and typeof(p46) ~= "string" then
		local l__sizerating__150 = v142.sizerating;
		local v151 = v41;
		if u37 == true then
			v151 = 0;
		end;
		local v152 = math.clamp(l__sizerating__150 - l__sizerating__150 * v151, 0.01, 10000);
		if v142.weapontype == "Bow" then
			v149 = "gundamage";
			v146 = true;
			v147 = true;
			v144 = 80;
			v145 = 0;
			if u9.walking == true then
				v148 = Vector3.new(math.rad(math.random(-v152, v152)), math.rad(math.random(-v152, v152)), math.rad(math.random(-v152, v152)));
			end;
		else
			local v153 = false;
			if u9.aiming == false then
				v153 = true;
			end;
			if tick() - baseadstick <= baseadstime / (1 + baseadsmod) / 8 then
				v153 = true;
			end;
			if u37 == true then
				v153 = true;
			end;
			if v153 == true then
				v148 = Vector3.new(math.rad(math.random(-v152, v152)), math.rad(math.random(-v152, v152)), math.rad(math.random(-v152, v152)));
			end;
		end;
	end;
	local v154 = true;
	if typeof(p46) == "string" then
		v144 = 3.5;
		v145 = 3.5;
		if p46 == "pepperspray" then
			v144 = 6;
			v145 = 6;
			v154 = false;
		end;
	end;
	local v155, v156 = raycastline(l__CurrentCamera__1.CFrame.p, l__CurrentCamera__1.CFrame.LookVector + v148, v144, baselayer);
	if v154 == true then
		trigger_map_item_func(v155, v149, p46);
		if v155 and ((v155.Name == "HarvestWood" or v155.Name == "HarvestStone") and p46 ~= "shove" and p46 ~= "shovebleed" and v149 == "meleedamage" and v155.Name ~= "Interact") then
			local v157 = true;
			if v155.Parent and (v155.Name == "CRBarrel" or v155.Name == "CRPylon") then
				v157 = false;
			end;
			if v157 == true then
				local v158 = "wood";
				if v155.Name == "HarvestStone" then
					v158 = "stone";
				end;
				local v159 = 2;
				if v142.weapontype == "Fists" then
					v159 = 1;
				end;
				if v142.weapontype == "Bludgeon" and v158 == "stone" or v142.weapontype == "Axe" and v158 == "wood" then
					v159 = 3;
				end;
				l__workspace__1.ServerStuff.applyGore:FireServer("harvestmat", character, ply, { v158, v156 });
				l__workspace__1.ServerStuff.playAudio:FireServer({ "harvesting" }, v158 .. "hit", character.HumanoidRootPart, 0.2);
				harvestinghits = harvestinghits - v159;
				if harvestinghits <= 0 then
					u38(2, "SALVAGE");
					l__workspace__1.ServerStuff.applyGore:FireServer("harvestmat", character, ply, { "salvaged", v156 });
					harvestinghits = v45;
					l__workspace__1.ServerStuff.harvest:FireServer(v158, v155.Parent);
					l__workspace__1.ServerStuff.playAudio:FireServer({ "harvesting" }, v158 .. "break", character.HumanoidRootPart, 0.2);
				end;
			end;
		end;
	end;
	local v160 = nil;
	local v161 = v145;
	if v145 > 0 then
		local v162, v163, v164 = pairs(l__game__7.Players:GetChildren());
		while true do
			local v165, v166 = v162(v163, v164);
			if not v165 then
				break;
			end;
			local v167 = v166:FindFirstChild("npc") and v167.Value;
			if v167 == nil and v166:IsA("Player") then
				v167 = v166.Character;
			end;
			if v167 and v167:FindFirstChild("HumanoidRootPart") and (v156 - v167.HumanoidRootPart.CFrame.p).magnitude < v161 and v166 ~= ply and v167:FindFirstChild("Humanoid") and v167.Humanoid.Health > 0 then
				v161 = (v156 - v167.HumanoidRootPart.CFrame.p).magnitude;
				v160 = v167;
				if teamfolder and v167:IsDescendantOf(teamfolder) then
					v160 = nil;
				end;
				if v167:IsDescendantOf(l__workspace__1.activeFriendlies) then
					v160 = nil;
				end;
			end;		
		end;
	end;
	if v147 == true and v155 == nil then
		local v168 = v156;
		for v169 = 1, 200 do
			local v170, v171 = raycastline(v168, l__CurrentCamera__1.CFrame.LookVector + v148 + Vector3.new(0, -0.05, 0), 3, baselayer);
			trigger_map_item_func(v170, v149, p46);
			if v170 then
				v155 = v170;
				break;
			end;
			v168 = v171;
			RS:wait();
		end;
	end;
	if v155 and v155.Parent:FindFirstChild("Humanoid") and v155.Parent:FindFirstChild("HumanoidRootPart") and (v155.Parent:FindFirstChild("Humanoid").Health > 0 and not v160) then
		v160 = v155.Parent;
	end;
	if v146 == true then
		if v147 == true then
			l__workspace__1.ServerStuff.applyGore:FireServer("bowarrow", character, ply, { l__CurrentCamera__1.CFrame, v148 });
		else
			local v172 = false;
			if p47 == "suppressed" then
				v172 = true;
			end;
			local v173 = u19.muzzle.Position;
			if p48 == true then
				v173 = akimbo_factors.alt_weapon.muzzle.Position;
			end;
			if v142.animset == "LSMG" or v142.name == "A.J.M. 9" then
				l__workspace__1.ServerStuff.applyGore:FireServer("firelaser", character, ply, { v173, v156 });
			else
				l__workspace__1.ServerStuff.applyGore:FireServer("firegun", character, ply, { v173, v156, v172, v160, true });
			end;
			if u10["Immolator Buff"] then
				l__workspace__1.ServerStuff.applyGore:FireServer("incendiary_trail", character, ply, { v173, v156 });
			end;
		end;
	end;
	if v160 and v146 == false and v147 == false and not raycastline(v160.Head.CFrame.p, -(v160.Head.CFrame.p - character.Head.CFrame.p), 100, { l__workspace__1.GoreEffects, v160 }) then
		v160 = nil;
	end;
	local v174 = false;
	local v175 = p46;
	local v176 = false;
	if v160 then
		local v177 = CFrame.new(v160.HumanoidRootPart.CFrame.p, v160.HumanoidRootPart.CFrame.p + Vector3.new(v160.HumanoidRootPart.CFrame.lookVector.x, 0, v160.HumanoidRootPart.CFrame.lookVector.z).unit):inverse() * character.HumanoidRootPart.Position;
		local l__unit__178 = Vector3.new(v177.x, v177.z).unit;
		local v179 = math.deg(math.atan2(l__unit__178.y * 200, l__unit__178.x * 200)) + 90;
		if v146 == true then
			v149 = "gundamage";
			v174 = v155.Name == "Head";
		end;
		if v174 == true and typeof(p46) ~= "string" then
			if v146 == true then
				v175 = v142.damagerating[4];
				p46 = v142.damagerating[4];
			end;
			if v146 == false then
				l__workspace__1.ServerStuff.adjustStats:FireServer("tracker", { "Backstabs", 1 });
			end;
		end;
		if typeof(p46) ~= "string" and v146 == true and v160:FindFirstChild("perks") and v160:FindFirstChild("perks"):FindFirstChild("thick") then
			v175 = v175 - v175 * v7.thick.efx[1] / 100;
		end;
		if v160 then
			if typeof(v175) ~= "string" and v174 ~= true and v149 == "meleedamage" and u39 == false then
				v175 = math.ceil(v175 * (u21 + u40));
				if v160:FindFirstChild("activeBlock") and v160:FindFirstChild("activeBlock").Value == true then
					v176 = true;
				end;
			end;
			if v176 == true then
				l__workspace__1.ServerStuff.applyGore:FireServer("blocksmoke", v160, nil, nil);
				l__workspace__1.ServerStuff.playAudio:FireServer({ "hitsound", "general" }, "hitblocked", character.HumanoidRootPart, 0.15);
				l__workspace__1.ServerStuff.dealDamage:FireServer("registerblocked", v160, v5, v4);
				spawn(function()
					stagger("normal");
				end);
				return;
			end;
		end;
		local u49 = true;
		spawn(function()
			l__workspace__1.ServerStuff.dealDamage:FireServer({ v149, v160, p46, v174, u18, v176, false, playerperks, v155 }, nil, v5, v4);
			if u49 == true then
				if typeof(p46) ~= "string" then
					if v146 == false then
						if u36.damagedealt[v160.Name] == nil then
							u36.damagedealt[v160.Name] = v175;
						else
							u36.damagedealt[v160.Name] = u36.damagedealt[v160.Name] + v175;
						end;
						if u36.tagged[v160.Name] and v175 >= 12 then
							u36.tagged[v160.Name] = nil;
							u36.ticktimers[v160.Name] = tick();
							u36.suslevels[v160.Name] = tick();
						end;
						if u36.tagged[v160.Name] == nil and u36.damagedealt[v160.Name] and u36.damagedealt[v160.Name] >= 20 then
							local v180 = 10000;
							local v181 = nil;
							for v182, v183 in pairs(u36.tagged) do
								if l__workspace__1.activePlayers:FindFirstChild(v182) and v183 < v180 then
									v180 = v183;
									v181 = v182;
								end;
							end;
							if v180 <= 40 and v181 ~= nil and u36.nowinshowdown == false then
								l__workspace__1.ServerStuff.eventTime:FireServer(v181, v5);
							end;
						end;
						bloodsprayDealt = bloodsprayDealt + v175;
						u41();
						if v142.name == "Sledgehammer" and v175 >= 30 and math.random(1, 100) == 1 then
							l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "donk", character.HumanoidRootPart);
						end;
						if playerperks.slippery and v142.weapontype == "Spear" then
							u22 = u22 + u13 * v7.slippery.efx[1] / 100;
							delay(v7.slippery.efx[2], function()
								u22 = u22 - u13 * v7.slippery.efx[1] / 100;
							end);
						end;
						if p47 == "heavy" and (v142.weapontype == "Bludgeon" or v142.weapontype == "Spear" or v142.weapontype == "Axe" or v142.weapontype == "Blade" or v142.weapontype == "Fists") then
							l__workspace__1.ServerStuff.adjustStats:FireServer("tracker", { v142.weapontype .. "Heavies", 1 });
						end;
						if v142.name == "Fists" and v175 >= 14 then
							l__workspace__1.ServerStuff.adjustStats:FireServer("tracker", { "ChargedFists", 1 });
						end;
						if v142.weapontype == "Blade" then
							l__workspace__1.ServerStuff.adjustStats:FireServer("tracker", { "BleedProc", 1 });
						end;
						v109.damage = v109.damage + p46;
						l__workspace__1.ServerStuff.adjustStats:FireServer("tracker", { "DamageDealt", p46 });
					end;
					if tick() - u42 > 0.01 then
						v101({ "hitsound", "general" }, "hitdeal", nil, nil, true, true);
					end;
					if v160:FindFirstChild("Head") then
						u43(v160:FindFirstChild("Head").Position, v175);
					end;
					if v142.name == "Double Barrel" then
						l__workspace__1.ServerStuff.adjustStats:FireServer("tracker", { "DBPellets", 1 });
					end;
					if v142.name == "Submachine Gun" then
						l__workspace__1.ServerStuff.adjustStats:FireServer("tracker", { "LandedSMG", 1 });
					end;
					if v142.weapontype == "Bow" then
						l__workspace__1.ServerStuff.adjustStats:FireServer("tracker", { "BowsHit", 1 });
					end;
					if v146 == true and v174 == true then
						l__workspace__1.ServerStuff.adjustStats:FireServer("tracker", { "RangedDamageDealt", p46 });
						if v142.name == "Rifle" then
							l__workspace__1.ServerStuff.adjustStats:FireServer("tracker", { "RifleHeadshots", 1 });
						end;
						if v142.weapontype == "Bow" then
							l__workspace__1.ServerStuff.adjustStats:FireServer("tracker", { "bowHeadshots", 1 });
						end;
						l__workspace__1.ServerStuff.adjustStats:FireServer("tracker", { "Headshots", 1 });
						if tick() - u42 > 0.01 then
							v101({ "hitsound", "general" }, "hitheadshot", nil, nil, true, true);
						end;
					end;
					u42 = tick();
					l__workspace__1.ServerStuff.applyGore:FireServer("bloodhit", v160, l__game__7.Players:GetPlayerFromCharacter(v160), { v175, v156 });
				end;
				if maingui.Centre.Hitmarker.ImageTransparency < 1 then
					maingui.Centre.Hitmarker.ImageTransparency = 0;
					return;
				end;
				maingui.Centre.Hitmarker.ImageTransparency = 0;
				spawn(function()
					while true do
						maingui.Centre.Hitmarker.ImageTransparency = maingui.Centre.Hitmarker.ImageTransparency + 0.04;
						RS:wait();
						if maingui.Centre.Hitmarker.ImageTransparency == 1 then
							break;
						end;					
					end;
					maingui.Centre.Hitmarker.ImageTransparency = 1;
				end);
			end;
		end);
	end;
	return v160;
end;
local v184 = CFrame.new(0, 0, 0);
local u50 = tick();
local u51 = v47;
local function u52()
	l__workspace__1.ServerStuff.dealDamage:FireServer("raidbossshotgun", nil, v5, v4);
	local v185 = curentanimset.pump;
	local v186 = 1;
	local v187 = false;
	if primskin and primskin.name == "Merci-fall" then
		v187 = true;
		v185 = curentanimset.skinpump;
		v186 = 0.8;
		delay(0.65, function()
			v101({ "reloads" }, "shotgun_mid", nil, nil, true, true);
		end);
		delay(0.75, function()
			v101({ "general" }, "reloadpartial", nil, nil, true, true);
		end);
	end;
	v185:Play(0.2, 1, v186);
	if v187 == false then
		delay(0.4, function()
			l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", u17.animset }, "pump", character.HumanoidRootPart);
			u19.fx.shelleject.Enabled = true;
			u19.fx.shelleject:Emit(1);
			u19.fx.shelleject.Enabled = false;
		end);
	end;
end;
local u53 = tick();
local u54 = tick();
local u55 = nil;
local function u56(p49)
	if startperk.Value ~= "emperor" and startperk.Value ~= "commander" and startperk.Value ~= "hiddenB" then
		return;
	end;
	lastchatter = tick();
	l__workspace__1.ServerStuff.voiceline:FireServer(startperk, p49);
end;
local u57 = v113;
u55 = function()
	if v59.aegisshieldup ~= nil then
		v59.aegisshieldup(v60[3].aegisdamagetakenmelee);
		return;
	end;
	if v59.berzactive ~= nil then
		local v188 = v59.berzactive + v60[3].regenonparry;
		if tick() - v188 > 0 then
			v59.berzactive = v188;
		else
			v59.berzactive = tick();
		end;
	end;
	if u17.weapontype ~= "Spear" and u17.weapontype ~= "Bludgeon" and u17.weapontype ~= "Blade" and u17.weapontype ~= "Fists" and u17.weapontype ~= "Axe" then
		return;
	end;
	if u9.staggering == true then
		return;
	end;
	if u9.blockimpact == false and u9.blockrecoil == true then
		u9.blockimpact = true;
		return;
	end;
	u56("blocked");
	l__workspace__1.ServerStuff.initiateblock:FireServer(v5, true);
	u9.charging = false;
	u9.action = true;
	u9.blocking = false;
	u9.blockrecoil = true;
	u9.blockimpact = true;
	u9.cancombo = false;
	u9.shoving = false;
	u50 = 0;
	u53 = 0;
	local v189 = tick();
	if curentanimset.block then
		curentanimset.block:Play(0);
		curentanimset.block.TimePosition = 0.2;
		curentanimset.block:AdjustSpeed(0);
	end;
	if tpcurrentanimset.block then
		tpcurrentanimset.block:Play(0);
		tpcurrentanimset.block.TimePosition = 0.2;
		tpcurrentanimset.block:AdjustSpeed(0);
	end;
	u8 = u8 + 15;
	u26("stamina");
	while true do
		RS:wait();
		if u9.blockimpact == true then
			v189 = tick();
			u9.blockimpact = false;
			u57 = CFrame.new(0, 1, 0);
			delay(0.05, function()
				if u57 == CFrame.new(0, 1, 0) then
					u57 = CFrame.new(0, 0, 0);
				end;
			end);
		end;
		if tick() - v189 >= 0.35 then
			break;
		end;
		if u9.staggering == true then
			break;
		end;	
	end;
	if u9.staggering == false then
		u9.blockrecoil = false;
		if curentanimset.block then
			curentanimset.block:Stop(0.2);
			tpcurrentanimset.block:Stop(0.2);
		end;
		u25(0.025, true);
		l__workspace__1.ServerStuff.initiateblock:FireServer(v5, false);
		if curentanimset.equip then
			curentanimset.equip.TimePosition = 0.5;
			curentanimset.equip:AdjustSpeed(0);
		end;
		if tpcurrentanimset.equip then
			tpcurrentanimset.equip:Play();
			tpcurrentanimset.equip.TimePosition = 0.5;
			tpcurrentanimset.equip:AdjustSpeed(0);
			check_walking_anim();
		end;
		u9.action = false;
		u9.blocking = false;
		u9.cancombo = true;
	end;
	if u9.blockrecoil == true then
		spawn(function()
			local v190 = tick();
			local v191 = false;
			while true do
				if tick() - v190 >= 5 then
					v191 = true;
					break;
				end;
				if u9.blockrecoil == false then
					v191 = false;
					break;
				end;
				if v191 == true then
					break;
				end;			
			end;
			if v191 == true then
				u9.blockrecoil = false;
				curentanimset.block:Stop(0.2);
				tpcurrentanimset.block:Stop(0.2);
				u25(0.025, true);
				l__workspace__1.ServerStuff.initiateblock:FireServer(v5, false);
				curentanimset.equip.TimePosition = 0.5;
				curentanimset.equip:AdjustSpeed(0);
				tpcurrentanimset.equip:Play();
				tpcurrentanimset.equip.TimePosition = 0.5;
				tpcurrentanimset.equip:AdjustSpeed(0);
				check_walking_anim();
				u9.action = false;
				u9.blocking = false;
				u9.cancombo = true;
			end;
		end);
	end;
end;
l__workspace__1.ServerStuff.initiateblock.OnClientEvent:Connect(function()
	u55();
end);
l__workspace__1.ServerStuff.confirmBlock.OnClientInvoke = function()
	local v192 = false;
	if u9.blocking == true and u9.staggering == false then
		v192 = true;
	end;
	if u9.swapping == true then
		v192 = false;
	end;
	return v192;
end;
local u58 = v42;
local v193 = { 2, 1.7, 1.35, 0.6 };
cancel_throw = false;
local u59 = false;
local u60 = 0;
local function u61(p50, p51)
	if u9.startswap == true then
		return;
	end;
	if juggernaut == true then
		return;
	end;
	if u9.channel == true then
		return;
	end;
	if p50 ~= "JBox" and p50 ~= "LSMini" and p50 ~= "GMSword" and p50 ~= "EMSword" and p50 ~= "CMMaul" and p50 ~= "PLBlade" then
		remove_dual_wield();
		drawlockout = tick();
		local v194 = v18[p50];
		if v194 == nil then
			v194 = v18[v10];
		end;
		local v195 = v194.animset;
		current_anim_set_use = v194.animset;
		local v196 = p50;
		local v197 = false;
		if playerstats.Exotic ~= "none" and p50 == "Fist" and v20[playerstats.Exotic] then
			v195 = v20[playerstats.Exotic].param[2];
			current_anim_set_use = v20[playerstats.Exotic].param[2];
			v196 = playerstats.Exotic;
			v197 = true;
		end;
		if v194.weapontype == "Item" then
			shakecamera("weapon", { "Item", "equip" });
		else
			shakecamera("weapon", { v195, "equip" });
		end;
		u9.swapping = true;
		u9.blocking = false;
		l__workspace__1.ServerStuff.initiateblock:FireServer(v5, false);
		u9.action = true;
		u9.cancombo = false;
		u9.startswap = true;
		local v198 = false;
		if p51 and p51:FindFirstChild("trapped") then
			v198 = true;
		end;
		if p51 and p51:FindFirstChild("agentcode") then
			for v199, v200 in pairs(v6) do
				if v200[2] == true then
					v200[4] = p51:FindFirstChild("agentcode").Value;
				end;
			end;
		end;
		if curentanimset.equip then
			curentanimset.equip:Stop(0);
		end;
		if tpcurrentanimset.equip then
			tpcurrentanimset.equip:Stop(0);
		end;
		for v201, v202 in pairs(curentanimset) do
			v202:Stop();
			v202:Destroy();
		end;
		for v203, v204 in pairs(tpcurrentanimset) do
			v204:Stop();
			v204:Destroy();
		end;
		curentanimset = {};
		tpcurrentanimset = {};
		u17 = {};
		harvestinghits = v45;
		local v205 = false;
		if v194.weapontype == "Axe" or v194.weapontype == "Bludgeon" or v194.weapontype == "Blade" or v194.weapontype == "Spear" then
			v205 = true;
		end;
		if p50 == "Primary" then
			p50 = v10;
			local v206 = primanimset;
			local v207 = tpprimanimset;
			u17 = primwepset;
		else
			v206 = l__game__7.ReplicatedStorage.animationSets:FindFirstChild(v195);
			v207 = l__game__7.ReplicatedStorage.animationSets.TPanimSets:FindFirstChild(v195);
			u17 = v194;
			if v206 == nil then
				v206 = l__game__7.ReplicatedStorage.animationSets.global;
			end;
			if v207 == nil then
				v207 = l__game__7.ReplicatedStorage.animationSets.TPanimSets.global;
			end;
		end;
		if p51 then
			p51:Destroy();
		end;
		l__workspace__1.ServerStuff.getTPWeapon:FireServer(p50, v207, u18, p51, v205);
		if u19 then
			u19:Destroy();
			for v208, v209 in ipairs(fparms.Joints:GetChildren()) do
				if v209.Name == "WeaponJoint" then
					v209:Destroy();
				end;
			end;
		end;
		if p50 == "Fist" then
			local v210 = nil;
			local v211 = nil;
			local v212 = nil;
			local v213 = nil;
			local v214 = nil;
			local v215 = nil;
			local v216 = nil;
			local v217 = nil;
			local v218 = nil;
			local v219 = nil;
			local v220 = nil;
			local v221 = nil;
			local v222 = nil;
			local v223 = nil;
			local v224 = nil;
			local v225 = nil;
			local v226 = nil;
			local v227 = nil;
			local v228 = nil;
			local v229 = nil;
			local v230 = nil;
			local v231 = nil;
			local v232 = nil;
			local v233 = nil;
			local v234 = nil;
			local v235 = nil;
			local v236 = nil;
			local v237 = nil;
			local v238 = nil;
			local v239 = nil;
			local v240 = nil;
			local v241 = nil;
			local v242 = nil;
			local v243 = nil;
			local v244 = nil;
			local v245 = nil;
			local v246 = nil;
			local v247 = nil;
			local v248 = nil;
			local v249 = nil;
			local v250 = nil;
			local v251 = nil;
			local v252 = nil;
			if v197 == true then
				local v253 = nil;
				local v254 = nil;
				local v255 = nil;
				local v256 = nil;
				local v257 = nil;
				local v258 = nil;
				local v259 = nil;
				local v260 = nil;
				local v261 = nil;
				local v262 = nil;
				local v263 = nil;
				local v264 = nil;
				local v265 = nil;
				local v266 = nil;
				local v267 = nil;
				local v268 = nil;
				local v269 = nil;
				local v270 = nil;
				local v271 = nil;
				local v272 = nil;
				local v273 = nil;
				local v274 = nil;
				local v275 = nil;
				local v276 = nil;
				local v277 = nil;
				local v278 = nil;
				local v279 = nil;
				local v280 = nil;
				local v281 = nil;
				local v282 = nil;
				local v283 = nil;
				local v284 = nil;
				local v285 = nil;
				local v286 = nil;
				local v287 = nil;
				local v288 = nil;
				local v289 = nil;
				local v290 = nil;
				local v291 = nil;
				local v292 = nil;
				local v293 = nil;
				local v294 = nil;
				local v295 = nil;
				local v296 = nil;
				local v297 = nil;
				local v298 = nil;
				local v299 = nil;
				local v300 = nil;
				local v301 = nil;
				local v302 = nil;
				local v303 = nil;
				local v304 = nil;
				local v305 = nil;
				local v306 = nil;
				local v307 = nil;
				local v308 = nil;
				local v309 = nil;
				local v310 = nil;
				local v311 = nil;
				local v312 = nil;
				local v313 = nil;
				local v314 = nil;
				local v315 = nil;
				local v316 = nil;
				local v317 = nil;
				local v318 = nil;
				local v319 = nil;
				local v320 = nil;
				local v321 = nil;
				local v322 = nil;
				local v323 = nil;
				local v324 = nil;
				local v325 = nil;
				local v326 = nil;
				local v327 = nil;
				local v328 = nil;
				local v329 = nil;
				local v330 = nil;
				local v331 = nil;
				local v332 = nil;
				local v333 = nil;
				local v334 = nil;
				local v335 = nil;
				local v336 = nil;
				local v337 = nil;
				local v338 = nil;
				local v339 = nil;
				local v340 = nil;
				local v341 = nil;
				if v197 == true and v205 == true and p50 == "Fist" then
					v205 = false;
				end;
				if character:FindFirstChild("hasPrimary") then
					local v342 = tick();
					if v205 == true then
						while true do
							drawlockout = tick();
							RS:wait();
							if tick() - v342 >= 2 then
								break;
							end;
							if character:FindFirstChild("hasPrimary") == nil then
								break;
							end;
							if character:FindFirstChild("hasPrimary") and character:FindFirstChild("hasPrimary"):GetChildren()[1].JointGrip:FindFirstChild("HolsterJoint") == nil then
								break;
							end;						
						end;
					else
						while true do
							drawlockout = tick();
							RS:wait();
							if tick() - v342 >= 2 then
								break;
							end;
							if v197 == true then
								break;
							end;
							if character:FindFirstChild("hasPrimary") == nil then
								break;
							end;
							if character:FindFirstChild("hasPrimary") and character:FindFirstChild("hasPrimary"):GetChildren()[1].JointGrip:FindFirstChild("HolsterJoint") then
								break;
							end;						
						end;
					end;
				end;
				if v205 == true then
					u19 = character:WaitForChild("hasPrimary"):GetChildren()[1]:Clone();
					if u19:FindFirstChild("JointGrip") then
						if u19.JointGrip:FindFirstChild("HolsterJoint") then
							u19.JointGrip:FindFirstChild("HolsterJoint"):Destroy();
						end;
						bloodtier = 0;
						bloodsprayDealt = 0;
						if u19:FindFirstChild("bloodstage") then
							bloodtier = u19:FindFirstChild("bloodstage").Value;
						end;
						v253 = true;
						v254 = v198;
						v255 = v253;
						if v254 == v255 then
							local v343 = Instance.new("BoolValue");
							v343.Name = "trapped";
							v343.Parent = u19;
						end;
						v256 = u19;
						local v344 = "JointGrip";
						v257 = v256;
						v258 = v344;
						v268 = v257[v258];
						v259 = fparms;
						local v345 = "RightArm";
						v260 = v259;
						v261 = v345;
						v262 = v260[v261];
						local v346 = "RUpperArm";
						v263 = v262;
						v264 = v346;
						v265 = v263[v264];
						local v347 = "CFrame";
						v266 = v265;
						v267 = v347;
						local v348 = v266[v267];
						local v349 = "CFrame";
						v269 = v268;
						v270 = v349;
						v271 = v348;
						v269[v270] = v271;
						local v350 = u19;
						local v351 = "JointGrip";
						v272 = v350;
						v273 = v351;
						local v352 = v272[v273];
						local v353 = true;
						local v354 = "Locked";
						v274 = v352;
						v275 = v354;
						v276 = v353;
						v274[v275] = v276;
						local v355 = Instance.new;
						local v356 = "Motor6D";
						v277 = v355;
						v278 = v356;
						local v357 = v277(v278);
						local v358 = "WeaponJoint";
						local v359 = "Name";
						v279 = v357;
						v280 = v359;
						v281 = v358;
						v279[v280] = v281;
						local v360 = fparms;
						local v361 = "RightArm";
						v282 = v360;
						v283 = v361;
						local v362 = v282[v283];
						local v363 = "RUpperArm";
						v284 = v362;
						v285 = v363;
						local v364 = v284[v285];
						local v365 = "Part0";
						v286 = v357;
						v287 = v365;
						v288 = v364;
						v286[v287] = v288;
						local v366 = u19;
						local v367 = "JointGrip";
						v289 = v366;
						v290 = v367;
						local v368 = v289[v290];
						local v369 = "Part1";
						v291 = v357;
						v292 = v369;
						v293 = v368;
						v291[v292] = v293;
						local v370 = CFrame.new;
						local v371 = 0;
						local v372 = -1;
						local v373 = 0;
						v294 = 1;
						v295 = 0;
						v296 = 0;
						v297 = 0;
						v298 = 1;
						v299 = 0;
						v300 = 0;
						v301 = 0;
						v302 = 1;
						v303 = v370;
						v304 = v371;
						v305 = v372;
						v306 = v373;
						v307 = v294;
						v308 = v295;
						v309 = v296;
						v310 = v297;
						v311 = v298;
						v312 = v299;
						v313 = v300;
						v314 = v301;
						v315 = v302;
						local v374 = v303(v304, v305, v306, v307, v308, v309, v310, v311, v312, v313, v314, v315);
						local v375 = "C0";
						v316 = v357;
						v317 = v375;
						v318 = v374;
						v316[v317] = v318;
						local v376 = u19;
						local v377 = "Name";
						v319 = v376;
						v320 = v377;
						local v378 = v319[v320];
						local v379 = "LSMini";
						v321 = v378;
						v322 = v379;
						if v321 == v322 then
							v357.C0 = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1);
						end;
						local v380 = "weldval";
						local v381 = "FindFirstChild";
						v323 = v206;
						local v382 = v323;
						v324 = v206;
						v325 = v381;
						local v383 = v324[v325];
						v326 = v383;
						v327 = v382;
						v328 = v380;
						local v384 = v326(v327, v328);
						v329 = v384;
						if v329 then
							v357.C1 = v206.weldval.Value;
						else
							v357.C1 = l__game__7.ReplicatedStorage.animationSets.global.gweldval.Value;
						end;
						local v385 = u19;
						local v386 = "Name";
						v330 = v385;
						v331 = v386;
						local v387 = v330[v331];
						local v388 = "Tourni";
						v332 = v387;
						v333 = v388;
						if v332 == v333 then
							v357.C0 = CFrame.new(0.155029297, -1.00993419, 0.217743874, 0, 7.10542736E-15, 0.999999285, 0.999999285, 0, 0, 0, 0.999999285, -7.10542736E-15);
							v357.C1 = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1);
						end;
						local v389 = fparms;
						local v390 = "Joints";
						v334 = v389;
						v335 = v390;
						local v391 = v334[v335];
						local v392 = "Parent";
						v336 = v357;
						v337 = v392;
						v338 = v391;
						v336[v337] = v338;
						local v393 = u19;
						local v394 = fparms;
						local v395 = "Parent";
						v339 = v393;
						v340 = v395;
						v341 = v394;
						v339[v340] = v341;
						v210 = u9;
						v212 = false;
						v211 = "startswap";
						v213 = v210;
						v214 = v211;
						v215 = v212;
						v213[v214] = v215;
						local v396 = fparms;
						local v397 = l__CurrentCamera__1;
						local v398 = "Parent";
						v216 = v396;
						v217 = v398;
						v218 = v397;
						v216[v217] = v218;
						local v399 = pairs;
						local v400 = "GetChildren";
						v219 = v206;
						v222 = v219;
						v220 = v206;
						v221 = v400;
						local v401 = v220[v221];
						v223 = v401;
						v224 = v222;
						v226 = v223(v224);
						v225 = v399;
						for v402, v403 in v225(v226) do
							if v403:IsA("Animation") then
								local v404 = fparms.AC:LoadAnimation(v403);
								v404.Name = v403.Name;
								curentanimset[v403.Name] = v404;
							end;
						end;
						local v405 = pairs;
						local v406 = "GetChildren";
						v227 = v207;
						local v407 = v227;
						v228 = v207;
						v229 = v406;
						local v408 = v228[v229];
						v230 = v408;
						v231 = v407;
						v233 = v230(v231);
						v232 = v405;
						for v409, v410 in v232(v233) do
							if v410:IsA("Animation") then
								local v411 = hum:LoadAnimation(v410);
								v411.Name = v410.Name;
								tpcurrentanimset[v410.Name] = v411;
							end;
						end;
						local v412 = curentanimset;
						local v413 = "block";
						v234 = v412;
						v235 = v413;
						local v414 = v234[v235];
						v236 = v414;
						if v236 then
							curentanimset.block:Stop();
							tpcurrentanimset.block:Stop();
						end;
						local v415 = "weapontype";
						v237 = v194;
						v238 = v415;
						local v416 = v237[v238];
						local v417 = "Item";
						v239 = v416;
						v240 = v417;
						if v239 == v240 then
							if l__game__7.ReplicatedStorage.animationSets:FindFirstChild(v194.animset):FindFirstChild("equip") == nil then
								curentanimset.equip = globalanimsets.equip;
								tpcurrentanimset.equip = tpglobalanimsets.equip;
							end;
							l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", "Item" }, "draw", character.HumanoidRootPart);
						elseif l__game__7.ReplicatedStorage.soundLibrary.weapons:FindFirstChild(v194.weapontype) then
							if v197 == true then
								l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", v195 }, "draw", character.HumanoidRootPart);
							else
								l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", v194.weapontype }, "draw", character.HumanoidRootPart);
							end;
						else
							l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", v195 }, "draw", character.HumanoidRootPart);
							if v194.name == "FAMAS F1" and math.random(1, 3) == 1 then
								l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", v194.animset }, "aughfrench", character.HumanoidRootPart);
							end;
						end;
						local v418 = "animset";
						v241 = v194;
						v242 = v418;
						local v419 = v241[v242];
						local v420 = "1PB";
						v243 = v419;
						v244 = v420;
						if v243 == v244 then
							spawn(function()
								local v421 = tick();
								local v422 = true;
								while true do
									if u17.animset ~= "1PB" then
										v422 = false;
										break;
									end;
									RS:wait();
									if tick() - v421 >= 0.4 then
										break;
									end;								
								end;
								if character.HumanoidRootPart:FindFirstChild("playerdrones") then
									baselayer = { character, l__workspace__1.NoTarget, l__workspace__1.GoreEffects, l__CurrentCamera__1, character.HumanoidRootPart:FindFirstChild("playerdrones").Part0.Parent };
								end;
								if v422 == true then
									v101({ "weapons", u17.animset }, "flash", nil, nil, true, true);
									local l__plasmaEffect__423 = u19:WaitForChild("plasmaEffect");
									l__plasmaEffect__423:WaitForChild("flash").Enabled = true;
									l__plasmaEffect__423:WaitForChild("spark").Enabled = true;
									l__plasmaEffect__423:WaitForChild("lightglow").Enabled = true;
									l__plasmaEffect__423:WaitForChild("electric").Enabled = true;
									l__plasmaEffect__423.flash:Emit(20);
									l__plasmaEffect__423.spark:Emit(math.random(10, 20));
									l__plasmaEffect__423.flash.Enabled = false;
									l__plasmaEffect__423.spark.Enabled = false;
									if u19.Model:FindFirstChild("bladeglow") then
										u19.Model.bladeglow.Transparency = 0.1;
									end;
								end;
							end);
						end;
						local v424 = "weapontype";
						v245 = v194;
						v246 = v424;
						local v425 = v245[v246];
						local v426 = "Gun";
						v247 = v425;
						v248 = v426;
						if (v247 == v248 or v194.weapontype == "Bow") and v194.weapontype == "Bow" then
							local v427 = nil;
							for v428 = 1, 100 do
								if character:FindFirstChild("RBow") then
									v427 = character:FindFirstChild("RBow");
									if v427 == nil then
										v427 = character:FindFirstChild("CRBow");
										if v427 == nil then
											v427 = character:FindFirstChild("CPBow");
										end;
									end;
									break;
								end;
								if character:FindFirstChild("CRBow") then
									v427 = character:FindFirstChild("RBow");
									if v427 == nil then
										v427 = character:FindFirstChild("CRBow");
										if v427 == nil then
											v427 = character:FindFirstChild("CPBow");
										end;
									end;
									break;
								end;
								if character:FindFirstChild("CPBow") then
									v427 = character:FindFirstChild("RBow");
									if v427 == nil then
										v427 = character:FindFirstChild("CRBow");
										if v427 == nil then
											v427 = character:FindFirstChild("CPBow");
										end;
									end;
									break;
								end;
								RS:wait();
							end;
							if v427 then
								if u19:FindFirstChild("arrow") then
									for v429, v430 in ipairs(u19.arrow:GetChildren()) do
										if v430:IsA("BasePart") then
											v430.Transparency = 1;
										end;
									end;
								end;
								v427.bowString.stringA.Transparency = NumberSequence.new(1);
								v427.bowString.stringB.Transparency = NumberSequence.new(1);
							end;
						end;
						local v431 = curentanimset;
						local v432 = "equip";
						v249 = v431;
						v250 = v432;
						local v433 = v249[v250];
						v251 = v433;
						if v251 then
							if playerperks.leather then
								if v194.weapontype == "Bludgeon" then
									if perksactive.leather == nil then
										perksactive.leather = true;
										u20 = u20 + v7.leather.efx[1] / 100;
									end;
								elseif perksactive.leather == true then
									perksactive.leather = nil;
									u20 = u20 - v7.leather.efx[1] / 100;
								end;
							end;
							if playerperks.boxer then
								if v194.weapontype == "Fists" then
									if perksactive.boxer == nil then
										perksactive.boxer = true;
										u21 = u21 + v7.boxer.efx[1] / 100;
									end;
								elseif perksactive.boxer == true then
									perksactive.boxer = nil;
									u21 = u21 - v7.boxer.efx[1] / 100;
								end;
							end;
							if playerperks.honor then
								if v194.weapontype == "Fists" then
									if perksactive.honor == nil then
										perksactive.honor = true;
										u21 = u21 + v7.honor.efx[1] / 100;
									end;
								elseif perksactive.honor == true then
									perksactive.honor = nil;
									u21 = u21 - v7.honor.efx[1] / 100;
								end;
							end;
							if v194.weapontype == "Fists" then
								if fist_speed_boost == false then
									fist_speed_boost = true;
									u22 = u22 + u13 * 15 / 100;
								end;
							elseif fist_speed_boost == true then
								fist_speed_boost = false;
								u22 = u22 - u13 * 15 / 100;
							end;
							if playerperks.mcrafter then
								if v194.name == "Crafted Spear" or v194.name == "Crafted Hatchet" or v194.name == "Crafted Knife" or v194.name == "Crafted Cudgel" then
									if perksactive.mcrafter == nil then
										perksactive.mcrafter = true;
										u21 = u21 + v7.mcrafter.efx[1] / 100;
									end;
								elseif perksactive.mcrafter == true then
									perksactive.mcrafter = nil;
									u21 = u21 - v7.mcrafter.efx[1] / 100;
								end;
							end;
							if playerperks.spearsrun then
								if v194.weapontype == "Spear" then
									if perksactive.spearsrun == nil then
										perksactive.spearsrun = true;
										u22 = u22 + u13 * v7.spearsrun.efx[1] / 100;
									end;
								elseif perksactive.spearsrun == true then
									perksactive.spearsrun = nil;
									u22 = u22 - u13 * v7.spearsrun.efx[1] / 100;
								end;
							end;
							if playerperks.tracker then
								if v194.name == "Mantracker" then
									if perksactive.tracker == nil then
										perksactive.tracker = true;
										u22 = u22 + u13 * v7.tracker.efx[1] / 100;
									end;
								elseif perksactive.tracker == true then
									perksactive.tracker = nil;
									u22 = u22 - u13 * v7.tracker.efx[1] / 100;
								end;
							end;
							if v194.name == "'Polters Last Wish'" or v194.name == "'Polters Last Breath'" then
								for v434, v435 in ipairs(u19.Model:GetChildren()) do
									v435.Transparency = 0;
								end;
							end;
							local v436 = 0.6;
							if v194.name == "Fists" then
								v436 = 0.9;
							end;
							if v194.animset == "PST" or v194.animset == "2HPST" then
								v436 = 0.8;
							end;
							curentanimset.equip:AdjustSpeed(v436);
							curentanimset.equip:Play(0, 1, v436);
							tpcurrentanimset.equip:AdjustSpeed(v436);
							tpcurrentanimset.equip:Play(0.2, 1, v436);
							local u62 = nil;
							u62 = tpcurrentanimset.equip.KeyframeReached:connect(function(p52)
								if p52 == "Stop" then
									tpcurrentanimset.equip:AdjustSpeed(0);
									u62:Disconnect();
								end;
							end);
							local u63 = nil;
							u63 = curentanimset.equip.KeyframeReached:connect(function(p53)
								if p53 == "Stop" then
									u23 = nil;
									if u9.staggering == false then
										curentanimset.equip:AdjustSpeed(0);
										u9.action = false;
										u9.swapping = false;
										u9.cancombo = true;
										check_walking_anim();
										u63:Disconnect();
										if v194.animset == "LSMG" then
											u24();
										end;
									end;
								end;
							end);
							if u19 and u19:FindFirstChild("skinned") and v20[u19:FindFirstChild("skinned").Value] then
								primskin = v20[u19:FindFirstChild("skinned").Value];
							end;
							drawlockout = tick();
							invmanage("updatehud");
							check_walking_anim();
						end;
						v252 = p50;
						u18 = v252;
						return;
					else
						u9.action = false;
						u9.swapping = false;
						return;
					end;
				else
					u19 = l__game__7.ReplicatedStorage.Weapons:FindFirstChild(v196):Clone();
					if v197 == true and playerstats.Exotic == "Tanto" then
						u19.sheath.Transparency = 0;
					end;
					v253 = true;
					v254 = v198;
					v255 = v253;
					if v254 == v255 then
						v343 = Instance.new("BoolValue");
						v343.Name = "trapped";
						v343.Parent = u19;
					end;
					v256 = u19;
					v344 = "JointGrip";
					v257 = v256;
					v258 = v344;
					v268 = v257[v258];
					v259 = fparms;
					v345 = "RightArm";
					v260 = v259;
					v261 = v345;
					v262 = v260[v261];
					v346 = "RUpperArm";
					v263 = v262;
					v264 = v346;
					v265 = v263[v264];
					v347 = "CFrame";
					v266 = v265;
					v267 = v347;
					v348 = v266[v267];
					v349 = "CFrame";
					v269 = v268;
					v270 = v349;
					v271 = v348;
					v269[v270] = v271;
					v350 = u19;
					v351 = "JointGrip";
					v272 = v350;
					v273 = v351;
					v352 = v272[v273];
					v353 = true;
					v354 = "Locked";
					v274 = v352;
					v275 = v354;
					v276 = v353;
					v274[v275] = v276;
					v355 = Instance.new;
					v356 = "Motor6D";
					v277 = v355;
					v278 = v356;
					v357 = v277(v278);
					v358 = "WeaponJoint";
					v359 = "Name";
					v279 = v357;
					v280 = v359;
					v281 = v358;
					v279[v280] = v281;
					v360 = fparms;
					v361 = "RightArm";
					v282 = v360;
					v283 = v361;
					v362 = v282[v283];
					v363 = "RUpperArm";
					v284 = v362;
					v285 = v363;
					v364 = v284[v285];
					v365 = "Part0";
					v286 = v357;
					v287 = v365;
					v288 = v364;
					v286[v287] = v288;
					v366 = u19;
					v367 = "JointGrip";
					v289 = v366;
					v290 = v367;
					v368 = v289[v290];
					v369 = "Part1";
					v291 = v357;
					v292 = v369;
					v293 = v368;
					v291[v292] = v293;
					v370 = CFrame.new;
					v371 = 0;
					v372 = -1;
					v373 = 0;
					v294 = 1;
					v295 = 0;
					v296 = 0;
					v297 = 0;
					v298 = 1;
					v299 = 0;
					v300 = 0;
					v301 = 0;
					v302 = 1;
					v303 = v370;
					v304 = v371;
					v305 = v372;
					v306 = v373;
					v307 = v294;
					v308 = v295;
					v309 = v296;
					v310 = v297;
					v311 = v298;
					v312 = v299;
					v313 = v300;
					v314 = v301;
					v315 = v302;
					v374 = v303(v304, v305, v306, v307, v308, v309, v310, v311, v312, v313, v314, v315);
					v375 = "C0";
					v316 = v357;
					v317 = v375;
					v318 = v374;
					v316[v317] = v318;
					v376 = u19;
					v377 = "Name";
					v319 = v376;
					v320 = v377;
					v378 = v319[v320];
					v379 = "LSMini";
					v321 = v378;
					v322 = v379;
					if v321 == v322 then
						v357.C0 = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1);
					end;
					v380 = "weldval";
					v381 = "FindFirstChild";
					v323 = v206;
					v382 = v323;
					v324 = v206;
					v325 = v381;
					v383 = v324[v325];
					v326 = v383;
					v327 = v382;
					v328 = v380;
					v384 = v326(v327, v328);
					v329 = v384;
					if v329 then
						v357.C1 = v206.weldval.Value;
					else
						v357.C1 = l__game__7.ReplicatedStorage.animationSets.global.gweldval.Value;
					end;
					v385 = u19;
					v386 = "Name";
					v330 = v385;
					v331 = v386;
					v387 = v330[v331];
					v388 = "Tourni";
					v332 = v387;
					v333 = v388;
					if v332 == v333 then
						v357.C0 = CFrame.new(0.155029297, -1.00993419, 0.217743874, 0, 7.10542736E-15, 0.999999285, 0.999999285, 0, 0, 0, 0.999999285, -7.10542736E-15);
						v357.C1 = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1);
					end;
					v389 = fparms;
					v390 = "Joints";
					v334 = v389;
					v335 = v390;
					v391 = v334[v335];
					v392 = "Parent";
					v336 = v357;
					v337 = v392;
					v338 = v391;
					v336[v337] = v338;
					v393 = u19;
					v394 = fparms;
					v395 = "Parent";
					v339 = v393;
					v340 = v395;
					v341 = v394;
					v339[v340] = v341;
					v210 = u9;
					v212 = false;
					v211 = "startswap";
					v213 = v210;
					v214 = v211;
					v215 = v212;
					v213[v214] = v215;
					v396 = fparms;
					v397 = l__CurrentCamera__1;
					v398 = "Parent";
					v216 = v396;
					v217 = v398;
					v218 = v397;
					v216[v217] = v218;
					v399 = pairs;
					v400 = "GetChildren";
					v219 = v206;
					v222 = v219;
					v220 = v206;
					v221 = v400;
					v401 = v220[v221];
					v223 = v401;
					v224 = v222;
					v226 = v223(v224);
					v225 = v399;
					local v437, v438, v439 = v225(v226);
					while true do
						if v403:IsA("Animation") then
							v404 = fparms.AC:LoadAnimation(v403);
							v404.Name = v403.Name;
							curentanimset[v403.Name] = v404;
						end;					
					end;
					v405 = pairs;
					v406 = "GetChildren";
					v227 = v207;
					v407 = v227;
					v228 = v207;
					v229 = v406;
					v408 = v228[v229];
					v230 = v408;
					v231 = v407;
					v233 = v230(v231);
					v232 = v405;
					local v440, v441, v442 = v232(v233);
					while true do
						if v410:IsA("Animation") then
							v411 = hum:LoadAnimation(v410);
							v411.Name = v410.Name;
							tpcurrentanimset[v410.Name] = v411;
						end;					
					end;
					v412 = curentanimset;
					v413 = "block";
					v234 = v412;
					v235 = v413;
					v414 = v234[v235];
					v236 = v414;
					if v236 then
						curentanimset.block:Stop();
						tpcurrentanimset.block:Stop();
					end;
					v415 = "weapontype";
					v237 = v194;
					v238 = v415;
					v416 = v237[v238];
					v417 = "Item";
					v239 = v416;
					v240 = v417;
					if v239 == v240 then
						if l__game__7.ReplicatedStorage.animationSets:FindFirstChild(v194.animset):FindFirstChild("equip") == nil then
							curentanimset.equip = globalanimsets.equip;
							tpcurrentanimset.equip = tpglobalanimsets.equip;
						end;
						l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", "Item" }, "draw", character.HumanoidRootPart);
					elseif l__game__7.ReplicatedStorage.soundLibrary.weapons:FindFirstChild(v194.weapontype) then
						if v197 == true then
							l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", v195 }, "draw", character.HumanoidRootPart);
						else
							l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", v194.weapontype }, "draw", character.HumanoidRootPart);
						end;
					else
						l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", v195 }, "draw", character.HumanoidRootPart);
						if v194.name == "FAMAS F1" and math.random(1, 3) == 1 then
							l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", v194.animset }, "aughfrench", character.HumanoidRootPart);
						end;
					end;
					v418 = "animset";
					v241 = v194;
					v242 = v418;
					v419 = v241[v242];
					v420 = "1PB";
					v243 = v419;
					v244 = v420;
					if v243 == v244 then
						spawn(function()
							v421 = tick();
							v422 = true;
							while true do
								if u17.animset ~= "1PB" then
									v422 = false;
									break;
								end;
								RS:wait();
								if tick() - v421 >= 0.4 then
									break;
								end;							
							end;
							if character.HumanoidRootPart:FindFirstChild("playerdrones") then
								baselayer = { character, l__workspace__1.NoTarget, l__workspace__1.GoreEffects, l__CurrentCamera__1, character.HumanoidRootPart:FindFirstChild("playerdrones").Part0.Parent };
							end;
							if v422 == true then
								v101({ "weapons", u17.animset }, "flash", nil, nil, true, true);
								l__plasmaEffect__423 = u19:WaitForChild("plasmaEffect");
								l__plasmaEffect__423:WaitForChild("flash").Enabled = true;
								l__plasmaEffect__423:WaitForChild("spark").Enabled = true;
								l__plasmaEffect__423:WaitForChild("lightglow").Enabled = true;
								l__plasmaEffect__423:WaitForChild("electric").Enabled = true;
								l__plasmaEffect__423.flash:Emit(20);
								l__plasmaEffect__423.spark:Emit(math.random(10, 20));
								l__plasmaEffect__423.flash.Enabled = false;
								l__plasmaEffect__423.spark.Enabled = false;
								if u19.Model:FindFirstChild("bladeglow") then
									u19.Model.bladeglow.Transparency = 0.1;
								end;
							end;
						end);
					end;
					v424 = "weapontype";
					v245 = v194;
					v246 = v424;
					v425 = v245[v246];
					v426 = "Gun";
					v247 = v425;
					v248 = v426;
					if (v247 == v248 or v194.weapontype == "Bow") and v194.weapontype == "Bow" then
						v427 = nil;
						for v428 = 1, 100 do
							if character:FindFirstChild("RBow") then
								v427 = character:FindFirstChild("RBow");
								if v427 == nil then
									v427 = character:FindFirstChild("CRBow");
									if v427 == nil then
										v427 = character:FindFirstChild("CPBow");
									end;
								end;
								break;
							end;
							if character:FindFirstChild("CRBow") then
								v427 = character:FindFirstChild("RBow");
								if v427 == nil then
									v427 = character:FindFirstChild("CRBow");
									if v427 == nil then
										v427 = character:FindFirstChild("CPBow");
									end;
								end;
								break;
							end;
							if character:FindFirstChild("CPBow") then
								v427 = character:FindFirstChild("RBow");
								if v427 == nil then
									v427 = character:FindFirstChild("CRBow");
									if v427 == nil then
										v427 = character:FindFirstChild("CPBow");
									end;
								end;
								break;
							end;
							RS:wait();
						end;
						if v427 then
							if u19:FindFirstChild("arrow") then
								for v429, v430 in ipairs(u19.arrow:GetChildren()) do
									if v430:IsA("BasePart") then
										v430.Transparency = 1;
									end;
								end;
							end;
							v427.bowString.stringA.Transparency = NumberSequence.new(1);
							v427.bowString.stringB.Transparency = NumberSequence.new(1);
						end;
					end;
					v431 = curentanimset;
					v432 = "equip";
					v249 = v431;
					v250 = v432;
					v433 = v249[v250];
					v251 = v433;
					if v251 then
						if playerperks.leather then
							if v194.weapontype == "Bludgeon" then
								if perksactive.leather == nil then
									perksactive.leather = true;
									u20 = u20 + v7.leather.efx[1] / 100;
								end;
							elseif perksactive.leather == true then
								perksactive.leather = nil;
								u20 = u20 - v7.leather.efx[1] / 100;
							end;
						end;
						if playerperks.boxer then
							if v194.weapontype == "Fists" then
								if perksactive.boxer == nil then
									perksactive.boxer = true;
									u21 = u21 + v7.boxer.efx[1] / 100;
								end;
							elseif perksactive.boxer == true then
								perksactive.boxer = nil;
								u21 = u21 - v7.boxer.efx[1] / 100;
							end;
						end;
						if playerperks.honor then
							if v194.weapontype == "Fists" then
								if perksactive.honor == nil then
									perksactive.honor = true;
									u21 = u21 + v7.honor.efx[1] / 100;
								end;
							elseif perksactive.honor == true then
								perksactive.honor = nil;
								u21 = u21 - v7.honor.efx[1] / 100;
							end;
						end;
						if v194.weapontype == "Fists" then
							if fist_speed_boost == false then
								fist_speed_boost = true;
								u22 = u22 + u13 * 15 / 100;
							end;
						elseif fist_speed_boost == true then
							fist_speed_boost = false;
							u22 = u22 - u13 * 15 / 100;
						end;
						if playerperks.mcrafter then
							if v194.name == "Crafted Spear" or v194.name == "Crafted Hatchet" or v194.name == "Crafted Knife" or v194.name == "Crafted Cudgel" then
								if perksactive.mcrafter == nil then
									perksactive.mcrafter = true;
									u21 = u21 + v7.mcrafter.efx[1] / 100;
								end;
							elseif perksactive.mcrafter == true then
								perksactive.mcrafter = nil;
								u21 = u21 - v7.mcrafter.efx[1] / 100;
							end;
						end;
						if playerperks.spearsrun then
							if v194.weapontype == "Spear" then
								if perksactive.spearsrun == nil then
									perksactive.spearsrun = true;
									u22 = u22 + u13 * v7.spearsrun.efx[1] / 100;
								end;
							elseif perksactive.spearsrun == true then
								perksactive.spearsrun = nil;
								u22 = u22 - u13 * v7.spearsrun.efx[1] / 100;
							end;
						end;
						if playerperks.tracker then
							if v194.name == "Mantracker" then
								if perksactive.tracker == nil then
									perksactive.tracker = true;
									u22 = u22 + u13 * v7.tracker.efx[1] / 100;
								end;
							elseif perksactive.tracker == true then
								perksactive.tracker = nil;
								u22 = u22 - u13 * v7.tracker.efx[1] / 100;
							end;
						end;
						if v194.name == "'Polters Last Wish'" or v194.name == "'Polters Last Breath'" then
							for v434, v435 in ipairs(u19.Model:GetChildren()) do
								v435.Transparency = 0;
							end;
						end;
						v436 = 0.6;
						if v194.name == "Fists" then
							v436 = 0.9;
						end;
						if v194.animset == "PST" or v194.animset == "2HPST" then
							v436 = 0.8;
						end;
						curentanimset.equip:AdjustSpeed(v436);
						curentanimset.equip:Play(0, 1, v436);
						tpcurrentanimset.equip:AdjustSpeed(v436);
						tpcurrentanimset.equip:Play(0.2, 1, v436);
						u62 = nil;
						u62 = tpcurrentanimset.equip.KeyframeReached:connect(function(p52)
							if p52 == "Stop" then
								tpcurrentanimset.equip:AdjustSpeed(0);
								u62:Disconnect();
							end;
						end);
						u63 = nil;
						u63 = curentanimset.equip.KeyframeReached:connect(function(p53)
							if p53 == "Stop" then
								u23 = nil;
								if u9.staggering == false then
									curentanimset.equip:AdjustSpeed(0);
									u9.action = false;
									u9.swapping = false;
									u9.cancombo = true;
									check_walking_anim();
									u63:Disconnect();
									if v194.animset == "LSMG" then
										u24();
									end;
								end;
							end;
						end);
						if u19 and u19:FindFirstChild("skinned") and v20[u19:FindFirstChild("skinned").Value] then
							primskin = v20[u19:FindFirstChild("skinned").Value];
						end;
						drawlockout = tick();
						invmanage("updatehud");
						check_walking_anim();
					end;
					v252 = p50;
					u18 = v252;
					return;
				end;
			else
				v210 = u9;
				v212 = false;
				v211 = "startswap";
				v213 = v210;
				v214 = v211;
				v215 = v212;
				v213[v214] = v215;
				v396 = fparms;
				v397 = l__CurrentCamera__1;
				v398 = "Parent";
				v216 = v396;
				v217 = v398;
				v218 = v397;
				v216[v217] = v218;
				v399 = pairs;
				v400 = "GetChildren";
				v219 = v206;
				v222 = v219;
				v220 = v206;
				v221 = v400;
				v401 = v220[v221];
				v223 = v401;
				v224 = v222;
				v226 = v223(v224);
				v225 = v399;
				v437, v438, v439 = v225(v226);
				while true do
					if v403:IsA("Animation") then
						v404 = fparms.AC:LoadAnimation(v403);
						v404.Name = v403.Name;
						curentanimset[v403.Name] = v404;
					end;				
				end;
				v405 = pairs;
				v406 = "GetChildren";
				v227 = v207;
				v407 = v227;
				v228 = v207;
				v229 = v406;
				v408 = v228[v229];
				v230 = v408;
				v231 = v407;
				v233 = v230(v231);
				v232 = v405;
				v440, v441, v442 = v232(v233);
				while true do
					if v410:IsA("Animation") then
						v411 = hum:LoadAnimation(v410);
						v411.Name = v410.Name;
						tpcurrentanimset[v410.Name] = v411;
					end;				
				end;
				v412 = curentanimset;
				v413 = "block";
				v234 = v412;
				v235 = v413;
				v414 = v234[v235];
				v236 = v414;
				if v236 then
					curentanimset.block:Stop();
					tpcurrentanimset.block:Stop();
				end;
				v415 = "weapontype";
				v237 = v194;
				v238 = v415;
				v416 = v237[v238];
				v417 = "Item";
				v239 = v416;
				v240 = v417;
				if v239 == v240 then
					if l__game__7.ReplicatedStorage.animationSets:FindFirstChild(v194.animset):FindFirstChild("equip") == nil then
						curentanimset.equip = globalanimsets.equip;
						tpcurrentanimset.equip = tpglobalanimsets.equip;
					end;
					l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", "Item" }, "draw", character.HumanoidRootPart);
				elseif l__game__7.ReplicatedStorage.soundLibrary.weapons:FindFirstChild(v194.weapontype) then
					if v197 == true then
						l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", v195 }, "draw", character.HumanoidRootPart);
					else
						l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", v194.weapontype }, "draw", character.HumanoidRootPart);
					end;
				else
					l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", v195 }, "draw", character.HumanoidRootPart);
					if v194.name == "FAMAS F1" and math.random(1, 3) == 1 then
						l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", v194.animset }, "aughfrench", character.HumanoidRootPart);
					end;
				end;
				v418 = "animset";
				v241 = v194;
				v242 = v418;
				v419 = v241[v242];
				v420 = "1PB";
				v243 = v419;
				v244 = v420;
				if v243 == v244 then
					spawn(function()
						v421 = tick();
						v422 = true;
						while true do
							if u17.animset ~= "1PB" then
								v422 = false;
								break;
							end;
							RS:wait();
							if tick() - v421 >= 0.4 then
								break;
							end;						
						end;
						if character.HumanoidRootPart:FindFirstChild("playerdrones") then
							baselayer = { character, l__workspace__1.NoTarget, l__workspace__1.GoreEffects, l__CurrentCamera__1, character.HumanoidRootPart:FindFirstChild("playerdrones").Part0.Parent };
						end;
						if v422 == true then
							v101({ "weapons", u17.animset }, "flash", nil, nil, true, true);
							l__plasmaEffect__423 = u19:WaitForChild("plasmaEffect");
							l__plasmaEffect__423:WaitForChild("flash").Enabled = true;
							l__plasmaEffect__423:WaitForChild("spark").Enabled = true;
							l__plasmaEffect__423:WaitForChild("lightglow").Enabled = true;
							l__plasmaEffect__423:WaitForChild("electric").Enabled = true;
							l__plasmaEffect__423.flash:Emit(20);
							l__plasmaEffect__423.spark:Emit(math.random(10, 20));
							l__plasmaEffect__423.flash.Enabled = false;
							l__plasmaEffect__423.spark.Enabled = false;
							if u19.Model:FindFirstChild("bladeglow") then
								u19.Model.bladeglow.Transparency = 0.1;
							end;
						end;
					end);
				end;
				v424 = "weapontype";
				v245 = v194;
				v246 = v424;
				v425 = v245[v246];
				v426 = "Gun";
				v247 = v425;
				v248 = v426;
				if (v247 == v248 or v194.weapontype == "Bow") and v194.weapontype == "Bow" then
					v427 = nil;
					for v428 = 1, 100 do
						if character:FindFirstChild("RBow") then
							v427 = character:FindFirstChild("RBow");
							if v427 == nil then
								v427 = character:FindFirstChild("CRBow");
								if v427 == nil then
									v427 = character:FindFirstChild("CPBow");
								end;
							end;
							break;
						end;
						if character:FindFirstChild("CRBow") then
							v427 = character:FindFirstChild("RBow");
							if v427 == nil then
								v427 = character:FindFirstChild("CRBow");
								if v427 == nil then
									v427 = character:FindFirstChild("CPBow");
								end;
							end;
							break;
						end;
						if character:FindFirstChild("CPBow") then
							v427 = character:FindFirstChild("RBow");
							if v427 == nil then
								v427 = character:FindFirstChild("CRBow");
								if v427 == nil then
									v427 = character:FindFirstChild("CPBow");
								end;
							end;
							break;
						end;
						RS:wait();
					end;
					if v427 then
						if u19:FindFirstChild("arrow") then
							for v429, v430 in ipairs(u19.arrow:GetChildren()) do
								if v430:IsA("BasePart") then
									v430.Transparency = 1;
								end;
							end;
						end;
						v427.bowString.stringA.Transparency = NumberSequence.new(1);
						v427.bowString.stringB.Transparency = NumberSequence.new(1);
					end;
				end;
				v431 = curentanimset;
				v432 = "equip";
				v249 = v431;
				v250 = v432;
				v433 = v249[v250];
				v251 = v433;
				if v251 then
					if playerperks.leather then
						if v194.weapontype == "Bludgeon" then
							if perksactive.leather == nil then
								perksactive.leather = true;
								u20 = u20 + v7.leather.efx[1] / 100;
							end;
						elseif perksactive.leather == true then
							perksactive.leather = nil;
							u20 = u20 - v7.leather.efx[1] / 100;
						end;
					end;
					if playerperks.boxer then
						if v194.weapontype == "Fists" then
							if perksactive.boxer == nil then
								perksactive.boxer = true;
								u21 = u21 + v7.boxer.efx[1] / 100;
							end;
						elseif perksactive.boxer == true then
							perksactive.boxer = nil;
							u21 = u21 - v7.boxer.efx[1] / 100;
						end;
					end;
					if playerperks.honor then
						if v194.weapontype == "Fists" then
							if perksactive.honor == nil then
								perksactive.honor = true;
								u21 = u21 + v7.honor.efx[1] / 100;
							end;
						elseif perksactive.honor == true then
							perksactive.honor = nil;
							u21 = u21 - v7.honor.efx[1] / 100;
						end;
					end;
					if v194.weapontype == "Fists" then
						if fist_speed_boost == false then
							fist_speed_boost = true;
							u22 = u22 + u13 * 15 / 100;
						end;
					elseif fist_speed_boost == true then
						fist_speed_boost = false;
						u22 = u22 - u13 * 15 / 100;
					end;
					if playerperks.mcrafter then
						if v194.name == "Crafted Spear" or v194.name == "Crafted Hatchet" or v194.name == "Crafted Knife" or v194.name == "Crafted Cudgel" then
							if perksactive.mcrafter == nil then
								perksactive.mcrafter = true;
								u21 = u21 + v7.mcrafter.efx[1] / 100;
							end;
						elseif perksactive.mcrafter == true then
							perksactive.mcrafter = nil;
							u21 = u21 - v7.mcrafter.efx[1] / 100;
						end;
					end;
					if playerperks.spearsrun then
						if v194.weapontype == "Spear" then
							if perksactive.spearsrun == nil then
								perksactive.spearsrun = true;
								u22 = u22 + u13 * v7.spearsrun.efx[1] / 100;
							end;
						elseif perksactive.spearsrun == true then
							perksactive.spearsrun = nil;
							u22 = u22 - u13 * v7.spearsrun.efx[1] / 100;
						end;
					end;
					if playerperks.tracker then
						if v194.name == "Mantracker" then
							if perksactive.tracker == nil then
								perksactive.tracker = true;
								u22 = u22 + u13 * v7.tracker.efx[1] / 100;
							end;
						elseif perksactive.tracker == true then
							perksactive.tracker = nil;
							u22 = u22 - u13 * v7.tracker.efx[1] / 100;
						end;
					end;
					if v194.name == "'Polters Last Wish'" or v194.name == "'Polters Last Breath'" then
						for v434, v435 in ipairs(u19.Model:GetChildren()) do
							v435.Transparency = 0;
						end;
					end;
					v436 = 0.6;
					if v194.name == "Fists" then
						v436 = 0.9;
					end;
					if v194.animset == "PST" or v194.animset == "2HPST" then
						v436 = 0.8;
					end;
					curentanimset.equip:AdjustSpeed(v436);
					curentanimset.equip:Play(0, 1, v436);
					tpcurrentanimset.equip:AdjustSpeed(v436);
					tpcurrentanimset.equip:Play(0.2, 1, v436);
					u62 = nil;
					u62 = tpcurrentanimset.equip.KeyframeReached:connect(function(p52)
						if p52 == "Stop" then
							tpcurrentanimset.equip:AdjustSpeed(0);
							u62:Disconnect();
						end;
					end);
					u63 = nil;
					u63 = curentanimset.equip.KeyframeReached:connect(function(p53)
						if p53 == "Stop" then
							u23 = nil;
							if u9.staggering == false then
								curentanimset.equip:AdjustSpeed(0);
								u9.action = false;
								u9.swapping = false;
								u9.cancombo = true;
								check_walking_anim();
								u63:Disconnect();
								if v194.animset == "LSMG" then
									u24();
								end;
							end;
						end;
					end);
					if u19 and u19:FindFirstChild("skinned") and v20[u19:FindFirstChild("skinned").Value] then
						primskin = v20[u19:FindFirstChild("skinned").Value];
					end;
					drawlockout = tick();
					invmanage("updatehud");
					check_walking_anim();
				end;
				v252 = p50;
				u18 = v252;
				return;
			end;
		else
			v253 = nil;
			v254 = nil;
			v255 = nil;
			v256 = nil;
			v257 = nil;
			v258 = nil;
			v259 = nil;
			v260 = nil;
			v261 = nil;
			v262 = nil;
			v263 = nil;
			v264 = nil;
			v265 = nil;
			v266 = nil;
			v267 = nil;
			v268 = nil;
			v269 = nil;
			v270 = nil;
			v271 = nil;
			v272 = nil;
			v273 = nil;
			v274 = nil;
			v275 = nil;
			v276 = nil;
			v277 = nil;
			v278 = nil;
			v279 = nil;
			v280 = nil;
			v281 = nil;
			v282 = nil;
			v283 = nil;
			v284 = nil;
			v285 = nil;
			v286 = nil;
			v287 = nil;
			v288 = nil;
			v289 = nil;
			v290 = nil;
			v291 = nil;
			v292 = nil;
			v293 = nil;
			v294 = nil;
			v295 = nil;
			v296 = nil;
			v297 = nil;
			v298 = nil;
			v299 = nil;
			v300 = nil;
			v301 = nil;
			v302 = nil;
			v303 = nil;
			v304 = nil;
			v305 = nil;
			v306 = nil;
			v307 = nil;
			v308 = nil;
			v309 = nil;
			v310 = nil;
			v311 = nil;
			v312 = nil;
			v313 = nil;
			v314 = nil;
			v315 = nil;
			v316 = nil;
			v317 = nil;
			v318 = nil;
			v319 = nil;
			v320 = nil;
			v321 = nil;
			v322 = nil;
			v323 = nil;
			v324 = nil;
			v325 = nil;
			v326 = nil;
			v327 = nil;
			v328 = nil;
			v329 = nil;
			v330 = nil;
			v331 = nil;
			v332 = nil;
			v333 = nil;
			v334 = nil;
			v335 = nil;
			v336 = nil;
			v337 = nil;
			v338 = nil;
			v339 = nil;
			v340 = nil;
			v341 = nil;
			if v197 == true and v205 == true and p50 == "Fist" then
				v205 = false;
			end;
			if character:FindFirstChild("hasPrimary") then
				v342 = tick();
				if v205 == true then
					while true do
						drawlockout = tick();
						RS:wait();
						if tick() - v342 >= 2 then
							break;
						end;
						if character:FindFirstChild("hasPrimary") == nil then
							break;
						end;
						if character:FindFirstChild("hasPrimary") and character:FindFirstChild("hasPrimary"):GetChildren()[1].JointGrip:FindFirstChild("HolsterJoint") == nil then
							break;
						end;					
					end;
				else
					while true do
						drawlockout = tick();
						RS:wait();
						if tick() - v342 >= 2 then
							break;
						end;
						if v197 == true then
							break;
						end;
						if character:FindFirstChild("hasPrimary") == nil then
							break;
						end;
						if character:FindFirstChild("hasPrimary") and character:FindFirstChild("hasPrimary"):GetChildren()[1].JointGrip:FindFirstChild("HolsterJoint") then
							break;
						end;					
					end;
				end;
			end;
			if v205 == true then
				u19 = character:WaitForChild("hasPrimary"):GetChildren()[1]:Clone();
				if u19:FindFirstChild("JointGrip") then
					if u19.JointGrip:FindFirstChild("HolsterJoint") then
						u19.JointGrip:FindFirstChild("HolsterJoint"):Destroy();
					end;
					bloodtier = 0;
					bloodsprayDealt = 0;
					if u19:FindFirstChild("bloodstage") then
						bloodtier = u19:FindFirstChild("bloodstage").Value;
					end;
					v253 = true;
					v254 = v198;
					v255 = v253;
					if v254 == v255 then
						v343 = Instance.new("BoolValue");
						v343.Name = "trapped";
						v343.Parent = u19;
					end;
					v256 = u19;
					v344 = "JointGrip";
					v257 = v256;
					v258 = v344;
					v268 = v257[v258];
					v259 = fparms;
					v345 = "RightArm";
					v260 = v259;
					v261 = v345;
					v262 = v260[v261];
					v346 = "RUpperArm";
					v263 = v262;
					v264 = v346;
					v265 = v263[v264];
					v347 = "CFrame";
					v266 = v265;
					v267 = v347;
					v348 = v266[v267];
					v349 = "CFrame";
					v269 = v268;
					v270 = v349;
					v271 = v348;
					v269[v270] = v271;
					v350 = u19;
					v351 = "JointGrip";
					v272 = v350;
					v273 = v351;
					v352 = v272[v273];
					v353 = true;
					v354 = "Locked";
					v274 = v352;
					v275 = v354;
					v276 = v353;
					v274[v275] = v276;
					v355 = Instance.new;
					v356 = "Motor6D";
					v277 = v355;
					v278 = v356;
					v357 = v277(v278);
					v358 = "WeaponJoint";
					v359 = "Name";
					v279 = v357;
					v280 = v359;
					v281 = v358;
					v279[v280] = v281;
					v360 = fparms;
					v361 = "RightArm";
					v282 = v360;
					v283 = v361;
					v362 = v282[v283];
					v363 = "RUpperArm";
					v284 = v362;
					v285 = v363;
					v364 = v284[v285];
					v365 = "Part0";
					v286 = v357;
					v287 = v365;
					v288 = v364;
					v286[v287] = v288;
					v366 = u19;
					v367 = "JointGrip";
					v289 = v366;
					v290 = v367;
					v368 = v289[v290];
					v369 = "Part1";
					v291 = v357;
					v292 = v369;
					v293 = v368;
					v291[v292] = v293;
					v370 = CFrame.new;
					v371 = 0;
					v372 = -1;
					v373 = 0;
					v294 = 1;
					v295 = 0;
					v296 = 0;
					v297 = 0;
					v298 = 1;
					v299 = 0;
					v300 = 0;
					v301 = 0;
					v302 = 1;
					v303 = v370;
					v304 = v371;
					v305 = v372;
					v306 = v373;
					v307 = v294;
					v308 = v295;
					v309 = v296;
					v310 = v297;
					v311 = v298;
					v312 = v299;
					v313 = v300;
					v314 = v301;
					v315 = v302;
					v374 = v303(v304, v305, v306, v307, v308, v309, v310, v311, v312, v313, v314, v315);
					v375 = "C0";
					v316 = v357;
					v317 = v375;
					v318 = v374;
					v316[v317] = v318;
					v376 = u19;
					v377 = "Name";
					v319 = v376;
					v320 = v377;
					v378 = v319[v320];
					v379 = "LSMini";
					v321 = v378;
					v322 = v379;
					if v321 == v322 then
						v357.C0 = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1);
					end;
					v380 = "weldval";
					v381 = "FindFirstChild";
					v323 = v206;
					v382 = v323;
					v324 = v206;
					v325 = v381;
					v383 = v324[v325];
					v326 = v383;
					v327 = v382;
					v328 = v380;
					v384 = v326(v327, v328);
					v329 = v384;
					if v329 then
						v357.C1 = v206.weldval.Value;
					else
						v357.C1 = l__game__7.ReplicatedStorage.animationSets.global.gweldval.Value;
					end;
					v385 = u19;
					v386 = "Name";
					v330 = v385;
					v331 = v386;
					v387 = v330[v331];
					v388 = "Tourni";
					v332 = v387;
					v333 = v388;
					if v332 == v333 then
						v357.C0 = CFrame.new(0.155029297, -1.00993419, 0.217743874, 0, 7.10542736E-15, 0.999999285, 0.999999285, 0, 0, 0, 0.999999285, -7.10542736E-15);
						v357.C1 = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1);
					end;
					v389 = fparms;
					v390 = "Joints";
					v334 = v389;
					v335 = v390;
					v391 = v334[v335];
					v392 = "Parent";
					v336 = v357;
					v337 = v392;
					v338 = v391;
					v336[v337] = v338;
					v393 = u19;
					v394 = fparms;
					v395 = "Parent";
					v339 = v393;
					v340 = v395;
					v341 = v394;
					v339[v340] = v341;
					v210 = u9;
					v212 = false;
					v211 = "startswap";
					v213 = v210;
					v214 = v211;
					v215 = v212;
					v213[v214] = v215;
					v396 = fparms;
					v397 = l__CurrentCamera__1;
					v398 = "Parent";
					v216 = v396;
					v217 = v398;
					v218 = v397;
					v216[v217] = v218;
					v399 = pairs;
					v400 = "GetChildren";
					v219 = v206;
					v222 = v219;
					v220 = v206;
					v221 = v400;
					v401 = v220[v221];
					v223 = v401;
					v224 = v222;
					v226 = v223(v224);
					v225 = v399;
					for v402, v403 in v225(v226) do
						if v403:IsA("Animation") then
							v404 = fparms.AC:LoadAnimation(v403);
							v404.Name = v403.Name;
							curentanimset[v403.Name] = v404;
						end;
					end;
					v405 = pairs;
					v406 = "GetChildren";
					v227 = v207;
					v407 = v227;
					v228 = v207;
					v229 = v406;
					v408 = v228[v229];
					v230 = v408;
					v231 = v407;
					v233 = v230(v231);
					v232 = v405;
					for v409, v410 in v232(v233) do
						if v410:IsA("Animation") then
							v411 = hum:LoadAnimation(v410);
							v411.Name = v410.Name;
							tpcurrentanimset[v410.Name] = v411;
						end;
					end;
					v412 = curentanimset;
					v413 = "block";
					v234 = v412;
					v235 = v413;
					v414 = v234[v235];
					v236 = v414;
					if v236 then
						curentanimset.block:Stop();
						tpcurrentanimset.block:Stop();
					end;
					v415 = "weapontype";
					v237 = v194;
					v238 = v415;
					v416 = v237[v238];
					v417 = "Item";
					v239 = v416;
					v240 = v417;
					if v239 == v240 then
						if l__game__7.ReplicatedStorage.animationSets:FindFirstChild(v194.animset):FindFirstChild("equip") == nil then
							curentanimset.equip = globalanimsets.equip;
							tpcurrentanimset.equip = tpglobalanimsets.equip;
						end;
						l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", "Item" }, "draw", character.HumanoidRootPart);
					elseif l__game__7.ReplicatedStorage.soundLibrary.weapons:FindFirstChild(v194.weapontype) then
						if v197 == true then
							l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", v195 }, "draw", character.HumanoidRootPart);
						else
							l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", v194.weapontype }, "draw", character.HumanoidRootPart);
						end;
					else
						l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", v195 }, "draw", character.HumanoidRootPart);
						if v194.name == "FAMAS F1" and math.random(1, 3) == 1 then
							l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", v194.animset }, "aughfrench", character.HumanoidRootPart);
						end;
					end;
					v418 = "animset";
					v241 = v194;
					v242 = v418;
					v419 = v241[v242];
					v420 = "1PB";
					v243 = v419;
					v244 = v420;
					if v243 == v244 then
						spawn(function()
							v421 = tick();
							v422 = true;
							while true do
								if u17.animset ~= "1PB" then
									v422 = false;
									break;
								end;
								RS:wait();
								if tick() - v421 >= 0.4 then
									break;
								end;							
							end;
							if character.HumanoidRootPart:FindFirstChild("playerdrones") then
								baselayer = { character, l__workspace__1.NoTarget, l__workspace__1.GoreEffects, l__CurrentCamera__1, character.HumanoidRootPart:FindFirstChild("playerdrones").Part0.Parent };
							end;
							if v422 == true then
								v101({ "weapons", u17.animset }, "flash", nil, nil, true, true);
								l__plasmaEffect__423 = u19:WaitForChild("plasmaEffect");
								l__plasmaEffect__423:WaitForChild("flash").Enabled = true;
								l__plasmaEffect__423:WaitForChild("spark").Enabled = true;
								l__plasmaEffect__423:WaitForChild("lightglow").Enabled = true;
								l__plasmaEffect__423:WaitForChild("electric").Enabled = true;
								l__plasmaEffect__423.flash:Emit(20);
								l__plasmaEffect__423.spark:Emit(math.random(10, 20));
								l__plasmaEffect__423.flash.Enabled = false;
								l__plasmaEffect__423.spark.Enabled = false;
								if u19.Model:FindFirstChild("bladeglow") then
									u19.Model.bladeglow.Transparency = 0.1;
								end;
							end;
						end);
					end;
					v424 = "weapontype";
					v245 = v194;
					v246 = v424;
					v425 = v245[v246];
					v426 = "Gun";
					v247 = v425;
					v248 = v426;
					if (v247 == v248 or v194.weapontype == "Bow") and v194.weapontype == "Bow" then
						v427 = nil;
						for v428 = 1, 100 do
							if character:FindFirstChild("RBow") then
								v427 = character:FindFirstChild("RBow");
								if v427 == nil then
									v427 = character:FindFirstChild("CRBow");
									if v427 == nil then
										v427 = character:FindFirstChild("CPBow");
									end;
								end;
								break;
							end;
							if character:FindFirstChild("CRBow") then
								v427 = character:FindFirstChild("RBow");
								if v427 == nil then
									v427 = character:FindFirstChild("CRBow");
									if v427 == nil then
										v427 = character:FindFirstChild("CPBow");
									end;
								end;
								break;
							end;
							if character:FindFirstChild("CPBow") then
								v427 = character:FindFirstChild("RBow");
								if v427 == nil then
									v427 = character:FindFirstChild("CRBow");
									if v427 == nil then
										v427 = character:FindFirstChild("CPBow");
									end;
								end;
								break;
							end;
							RS:wait();
						end;
						if v427 then
							if u19:FindFirstChild("arrow") then
								for v429, v430 in ipairs(u19.arrow:GetChildren()) do
									if v430:IsA("BasePart") then
										v430.Transparency = 1;
									end;
								end;
							end;
							v427.bowString.stringA.Transparency = NumberSequence.new(1);
							v427.bowString.stringB.Transparency = NumberSequence.new(1);
						end;
					end;
					v431 = curentanimset;
					v432 = "equip";
					v249 = v431;
					v250 = v432;
					v433 = v249[v250];
					v251 = v433;
					if v251 then
						if playerperks.leather then
							if v194.weapontype == "Bludgeon" then
								if perksactive.leather == nil then
									perksactive.leather = true;
									u20 = u20 + v7.leather.efx[1] / 100;
								end;
							elseif perksactive.leather == true then
								perksactive.leather = nil;
								u20 = u20 - v7.leather.efx[1] / 100;
							end;
						end;
						if playerperks.boxer then
							if v194.weapontype == "Fists" then
								if perksactive.boxer == nil then
									perksactive.boxer = true;
									u21 = u21 + v7.boxer.efx[1] / 100;
								end;
							elseif perksactive.boxer == true then
								perksactive.boxer = nil;
								u21 = u21 - v7.boxer.efx[1] / 100;
							end;
						end;
						if playerperks.honor then
							if v194.weapontype == "Fists" then
								if perksactive.honor == nil then
									perksactive.honor = true;
									u21 = u21 + v7.honor.efx[1] / 100;
								end;
							elseif perksactive.honor == true then
								perksactive.honor = nil;
								u21 = u21 - v7.honor.efx[1] / 100;
							end;
						end;
						if v194.weapontype == "Fists" then
							if fist_speed_boost == false then
								fist_speed_boost = true;
								u22 = u22 + u13 * 15 / 100;
							end;
						elseif fist_speed_boost == true then
							fist_speed_boost = false;
							u22 = u22 - u13 * 15 / 100;
						end;
						if playerperks.mcrafter then
							if v194.name == "Crafted Spear" or v194.name == "Crafted Hatchet" or v194.name == "Crafted Knife" or v194.name == "Crafted Cudgel" then
								if perksactive.mcrafter == nil then
									perksactive.mcrafter = true;
									u21 = u21 + v7.mcrafter.efx[1] / 100;
								end;
							elseif perksactive.mcrafter == true then
								perksactive.mcrafter = nil;
								u21 = u21 - v7.mcrafter.efx[1] / 100;
							end;
						end;
						if playerperks.spearsrun then
							if v194.weapontype == "Spear" then
								if perksactive.spearsrun == nil then
									perksactive.spearsrun = true;
									u22 = u22 + u13 * v7.spearsrun.efx[1] / 100;
								end;
							elseif perksactive.spearsrun == true then
								perksactive.spearsrun = nil;
								u22 = u22 - u13 * v7.spearsrun.efx[1] / 100;
							end;
						end;
						if playerperks.tracker then
							if v194.name == "Mantracker" then
								if perksactive.tracker == nil then
									perksactive.tracker = true;
									u22 = u22 + u13 * v7.tracker.efx[1] / 100;
								end;
							elseif perksactive.tracker == true then
								perksactive.tracker = nil;
								u22 = u22 - u13 * v7.tracker.efx[1] / 100;
							end;
						end;
						if v194.name == "'Polters Last Wish'" or v194.name == "'Polters Last Breath'" then
							for v434, v435 in ipairs(u19.Model:GetChildren()) do
								v435.Transparency = 0;
							end;
						end;
						v436 = 0.6;
						if v194.name == "Fists" then
							v436 = 0.9;
						end;
						if v194.animset == "PST" or v194.animset == "2HPST" then
							v436 = 0.8;
						end;
						curentanimset.equip:AdjustSpeed(v436);
						curentanimset.equip:Play(0, 1, v436);
						tpcurrentanimset.equip:AdjustSpeed(v436);
						tpcurrentanimset.equip:Play(0.2, 1, v436);
						u62 = nil;
						u62 = tpcurrentanimset.equip.KeyframeReached:connect(function(p52)
							if p52 == "Stop" then
								tpcurrentanimset.equip:AdjustSpeed(0);
								u62:Disconnect();
							end;
						end);
						u63 = nil;
						u63 = curentanimset.equip.KeyframeReached:connect(function(p53)
							if p53 == "Stop" then
								u23 = nil;
								if u9.staggering == false then
									curentanimset.equip:AdjustSpeed(0);
									u9.action = false;
									u9.swapping = false;
									u9.cancombo = true;
									check_walking_anim();
									u63:Disconnect();
									if v194.animset == "LSMG" then
										u24();
									end;
								end;
							end;
						end);
						if u19 and u19:FindFirstChild("skinned") and v20[u19:FindFirstChild("skinned").Value] then
							primskin = v20[u19:FindFirstChild("skinned").Value];
						end;
						drawlockout = tick();
						invmanage("updatehud");
						check_walking_anim();
					end;
					v252 = p50;
					u18 = v252;
					return;
				else
					u9.action = false;
					u9.swapping = false;
					return;
				end;
			else
				u19 = l__game__7.ReplicatedStorage.Weapons:FindFirstChild(v196):Clone();
				if v197 == true and playerstats.Exotic == "Tanto" then
					u19.sheath.Transparency = 0;
				end;
				v253 = true;
				v254 = v198;
				v255 = v253;
				if v254 == v255 then
					v343 = Instance.new("BoolValue");
					v343.Name = "trapped";
					v343.Parent = u19;
				end;
				v256 = u19;
				v344 = "JointGrip";
				v257 = v256;
				v258 = v344;
				v268 = v257[v258];
				v259 = fparms;
				v345 = "RightArm";
				v260 = v259;
				v261 = v345;
				v262 = v260[v261];
				v346 = "RUpperArm";
				v263 = v262;
				v264 = v346;
				v265 = v263[v264];
				v347 = "CFrame";
				v266 = v265;
				v267 = v347;
				v348 = v266[v267];
				v349 = "CFrame";
				v269 = v268;
				v270 = v349;
				v271 = v348;
				v269[v270] = v271;
				v350 = u19;
				v351 = "JointGrip";
				v272 = v350;
				v273 = v351;
				v352 = v272[v273];
				v353 = true;
				v354 = "Locked";
				v274 = v352;
				v275 = v354;
				v276 = v353;
				v274[v275] = v276;
				v355 = Instance.new;
				v356 = "Motor6D";
				v277 = v355;
				v278 = v356;
				v357 = v277(v278);
				v358 = "WeaponJoint";
				v359 = "Name";
				v279 = v357;
				v280 = v359;
				v281 = v358;
				v279[v280] = v281;
				v360 = fparms;
				v361 = "RightArm";
				v282 = v360;
				v283 = v361;
				v362 = v282[v283];
				v363 = "RUpperArm";
				v284 = v362;
				v285 = v363;
				v364 = v284[v285];
				v365 = "Part0";
				v286 = v357;
				v287 = v365;
				v288 = v364;
				v286[v287] = v288;
				v366 = u19;
				v367 = "JointGrip";
				v289 = v366;
				v290 = v367;
				v368 = v289[v290];
				v369 = "Part1";
				v291 = v357;
				v292 = v369;
				v293 = v368;
				v291[v292] = v293;
				v370 = CFrame.new;
				v371 = 0;
				v372 = -1;
				v373 = 0;
				v294 = 1;
				v295 = 0;
				v296 = 0;
				v297 = 0;
				v298 = 1;
				v299 = 0;
				v300 = 0;
				v301 = 0;
				v302 = 1;
				v303 = v370;
				v304 = v371;
				v305 = v372;
				v306 = v373;
				v307 = v294;
				v308 = v295;
				v309 = v296;
				v310 = v297;
				v311 = v298;
				v312 = v299;
				v313 = v300;
				v314 = v301;
				v315 = v302;
				v374 = v303(v304, v305, v306, v307, v308, v309, v310, v311, v312, v313, v314, v315);
				v375 = "C0";
				v316 = v357;
				v317 = v375;
				v318 = v374;
				v316[v317] = v318;
				v376 = u19;
				v377 = "Name";
				v319 = v376;
				v320 = v377;
				v378 = v319[v320];
				v379 = "LSMini";
				v321 = v378;
				v322 = v379;
				if v321 == v322 then
					v357.C0 = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1);
				end;
				v380 = "weldval";
				v381 = "FindFirstChild";
				v323 = v206;
				v382 = v323;
				v324 = v206;
				v325 = v381;
				v383 = v324[v325];
				v326 = v383;
				v327 = v382;
				v328 = v380;
				v384 = v326(v327, v328);
				v329 = v384;
				if v329 then
					v357.C1 = v206.weldval.Value;
				else
					v357.C1 = l__game__7.ReplicatedStorage.animationSets.global.gweldval.Value;
				end;
				v385 = u19;
				v386 = "Name";
				v330 = v385;
				v331 = v386;
				v387 = v330[v331];
				v388 = "Tourni";
				v332 = v387;
				v333 = v388;
				if v332 == v333 then
					v357.C0 = CFrame.new(0.155029297, -1.00993419, 0.217743874, 0, 7.10542736E-15, 0.999999285, 0.999999285, 0, 0, 0, 0.999999285, -7.10542736E-15);
					v357.C1 = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1);
				end;
				v389 = fparms;
				v390 = "Joints";
				v334 = v389;
				v335 = v390;
				v391 = v334[v335];
				v392 = "Parent";
				v336 = v357;
				v337 = v392;
				v338 = v391;
				v336[v337] = v338;
				v393 = u19;
				v394 = fparms;
				v395 = "Parent";
				v339 = v393;
				v340 = v395;
				v341 = v394;
				v339[v340] = v341;
				v210 = u9;
				v212 = false;
				v211 = "startswap";
				v213 = v210;
				v214 = v211;
				v215 = v212;
				v213[v214] = v215;
				v396 = fparms;
				v397 = l__CurrentCamera__1;
				v398 = "Parent";
				v216 = v396;
				v217 = v398;
				v218 = v397;
				v216[v217] = v218;
				v399 = pairs;
				v400 = "GetChildren";
				v219 = v206;
				v222 = v219;
				v220 = v206;
				v221 = v400;
				v401 = v220[v221];
				v223 = v401;
				v224 = v222;
				v226 = v223(v224);
				v225 = v399;
				v437, v438, v439 = v225(v226);
				while true do
					if v403:IsA("Animation") then
						v404 = fparms.AC:LoadAnimation(v403);
						v404.Name = v403.Name;
						curentanimset[v403.Name] = v404;
					end;				
				end;
				v405 = pairs;
				v406 = "GetChildren";
				v227 = v207;
				v407 = v227;
				v228 = v207;
				v229 = v406;
				v408 = v228[v229];
				v230 = v408;
				v231 = v407;
				v233 = v230(v231);
				v232 = v405;
				v440, v441, v442 = v232(v233);
				while true do
					if v410:IsA("Animation") then
						v411 = hum:LoadAnimation(v410);
						v411.Name = v410.Name;
						tpcurrentanimset[v410.Name] = v411;
					end;				
				end;
				v412 = curentanimset;
				v413 = "block";
				v234 = v412;
				v235 = v413;
				v414 = v234[v235];
				v236 = v414;
				if v236 then
					curentanimset.block:Stop();
					tpcurrentanimset.block:Stop();
				end;
				v415 = "weapontype";
				v237 = v194;
				v238 = v415;
				v416 = v237[v238];
				v417 = "Item";
				v239 = v416;
				v240 = v417;
				if v239 == v240 then
					if l__game__7.ReplicatedStorage.animationSets:FindFirstChild(v194.animset):FindFirstChild("equip") == nil then
						curentanimset.equip = globalanimsets.equip;
						tpcurrentanimset.equip = tpglobalanimsets.equip;
					end;
					l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", "Item" }, "draw", character.HumanoidRootPart);
				elseif l__game__7.ReplicatedStorage.soundLibrary.weapons:FindFirstChild(v194.weapontype) then
					if v197 == true then
						l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", v195 }, "draw", character.HumanoidRootPart);
					else
						l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", v194.weapontype }, "draw", character.HumanoidRootPart);
					end;
				else
					l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", v195 }, "draw", character.HumanoidRootPart);
					if v194.name == "FAMAS F1" and math.random(1, 3) == 1 then
						l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", v194.animset }, "aughfrench", character.HumanoidRootPart);
					end;
				end;
				v418 = "animset";
				v241 = v194;
				v242 = v418;
				v419 = v241[v242];
				v420 = "1PB";
				v243 = v419;
				v244 = v420;
				if v243 == v244 then
					spawn(function()
						v421 = tick();
						v422 = true;
						while true do
							if u17.animset ~= "1PB" then
								v422 = false;
								break;
							end;
							RS:wait();
							if tick() - v421 >= 0.4 then
								break;
							end;						
						end;
						if character.HumanoidRootPart:FindFirstChild("playerdrones") then
							baselayer = { character, l__workspace__1.NoTarget, l__workspace__1.GoreEffects, l__CurrentCamera__1, character.HumanoidRootPart:FindFirstChild("playerdrones").Part0.Parent };
						end;
						if v422 == true then
							v101({ "weapons", u17.animset }, "flash", nil, nil, true, true);
							l__plasmaEffect__423 = u19:WaitForChild("plasmaEffect");
							l__plasmaEffect__423:WaitForChild("flash").Enabled = true;
							l__plasmaEffect__423:WaitForChild("spark").Enabled = true;
							l__plasmaEffect__423:WaitForChild("lightglow").Enabled = true;
							l__plasmaEffect__423:WaitForChild("electric").Enabled = true;
							l__plasmaEffect__423.flash:Emit(20);
							l__plasmaEffect__423.spark:Emit(math.random(10, 20));
							l__plasmaEffect__423.flash.Enabled = false;
							l__plasmaEffect__423.spark.Enabled = false;
							if u19.Model:FindFirstChild("bladeglow") then
								u19.Model.bladeglow.Transparency = 0.1;
							end;
						end;
					end);
				end;
				v424 = "weapontype";
				v245 = v194;
				v246 = v424;
				v425 = v245[v246];
				v426 = "Gun";
				v247 = v425;
				v248 = v426;
				if (v247 == v248 or v194.weapontype == "Bow") and v194.weapontype == "Bow" then
					v427 = nil;
					for v428 = 1, 100 do
						if character:FindFirstChild("RBow") then
							v427 = character:FindFirstChild("RBow");
							if v427 == nil then
								v427 = character:FindFirstChild("CRBow");
								if v427 == nil then
									v427 = character:FindFirstChild("CPBow");
								end;
							end;
							break;
						end;
						if character:FindFirstChild("CRBow") then
							v427 = character:FindFirstChild("RBow");
							if v427 == nil then
								v427 = character:FindFirstChild("CRBow");
								if v427 == nil then
									v427 = character:FindFirstChild("CPBow");
								end;
							end;
							break;
						end;
						if character:FindFirstChild("CPBow") then
							v427 = character:FindFirstChild("RBow");
							if v427 == nil then
								v427 = character:FindFirstChild("CRBow");
								if v427 == nil then
									v427 = character:FindFirstChild("CPBow");
								end;
							end;
							break;
						end;
						RS:wait();
					end;
					if v427 then
						if u19:FindFirstChild("arrow") then
							for v429, v430 in ipairs(u19.arrow:GetChildren()) do
								if v430:IsA("BasePart") then
									v430.Transparency = 1;
								end;
							end;
						end;
						v427.bowString.stringA.Transparency = NumberSequence.new(1);
						v427.bowString.stringB.Transparency = NumberSequence.new(1);
					end;
				end;
				v431 = curentanimset;
				v432 = "equip";
				v249 = v431;
				v250 = v432;
				v433 = v249[v250];
				v251 = v433;
				if v251 then
					if playerperks.leather then
						if v194.weapontype == "Bludgeon" then
							if perksactive.leather == nil then
								perksactive.leather = true;
								u20 = u20 + v7.leather.efx[1] / 100;
							end;
						elseif perksactive.leather == true then
							perksactive.leather = nil;
							u20 = u20 - v7.leather.efx[1] / 100;
						end;
					end;
					if playerperks.boxer then
						if v194.weapontype == "Fists" then
							if perksactive.boxer == nil then
								perksactive.boxer = true;
								u21 = u21 + v7.boxer.efx[1] / 100;
							end;
						elseif perksactive.boxer == true then
							perksactive.boxer = nil;
							u21 = u21 - v7.boxer.efx[1] / 100;
						end;
					end;
					if playerperks.honor then
						if v194.weapontype == "Fists" then
							if perksactive.honor == nil then
								perksactive.honor = true;
								u21 = u21 + v7.honor.efx[1] / 100;
							end;
						elseif perksactive.honor == true then
							perksactive.honor = nil;
							u21 = u21 - v7.honor.efx[1] / 100;
						end;
					end;
					if v194.weapontype == "Fists" then
						if fist_speed_boost == false then
							fist_speed_boost = true;
							u22 = u22 + u13 * 15 / 100;
						end;
					elseif fist_speed_boost == true then
						fist_speed_boost = false;
						u22 = u22 - u13 * 15 / 100;
					end;
					if playerperks.mcrafter then
						if v194.name == "Crafted Spear" or v194.name == "Crafted Hatchet" or v194.name == "Crafted Knife" or v194.name == "Crafted Cudgel" then
							if perksactive.mcrafter == nil then
								perksactive.mcrafter = true;
								u21 = u21 + v7.mcrafter.efx[1] / 100;
							end;
						elseif perksactive.mcrafter == true then
							perksactive.mcrafter = nil;
							u21 = u21 - v7.mcrafter.efx[1] / 100;
						end;
					end;
					if playerperks.spearsrun then
						if v194.weapontype == "Spear" then
							if perksactive.spearsrun == nil then
								perksactive.spearsrun = true;
								u22 = u22 + u13 * v7.spearsrun.efx[1] / 100;
							end;
						elseif perksactive.spearsrun == true then
							perksactive.spearsrun = nil;
							u22 = u22 - u13 * v7.spearsrun.efx[1] / 100;
						end;
					end;
					if playerperks.tracker then
						if v194.name == "Mantracker" then
							if perksactive.tracker == nil then
								perksactive.tracker = true;
								u22 = u22 + u13 * v7.tracker.efx[1] / 100;
							end;
						elseif perksactive.tracker == true then
							perksactive.tracker = nil;
							u22 = u22 - u13 * v7.tracker.efx[1] / 100;
						end;
					end;
					if v194.name == "'Polters Last Wish'" or v194.name == "'Polters Last Breath'" then
						for v434, v435 in ipairs(u19.Model:GetChildren()) do
							v435.Transparency = 0;
						end;
					end;
					v436 = 0.6;
					if v194.name == "Fists" then
						v436 = 0.9;
					end;
					if v194.animset == "PST" or v194.animset == "2HPST" then
						v436 = 0.8;
					end;
					curentanimset.equip:AdjustSpeed(v436);
					curentanimset.equip:Play(0, 1, v436);
					tpcurrentanimset.equip:AdjustSpeed(v436);
					tpcurrentanimset.equip:Play(0.2, 1, v436);
					u62 = nil;
					u62 = tpcurrentanimset.equip.KeyframeReached:connect(function(p52)
						if p52 == "Stop" then
							tpcurrentanimset.equip:AdjustSpeed(0);
							u62:Disconnect();
						end;
					end);
					u63 = nil;
					u63 = curentanimset.equip.KeyframeReached:connect(function(p53)
						if p53 == "Stop" then
							u23 = nil;
							if u9.staggering == false then
								curentanimset.equip:AdjustSpeed(0);
								u9.action = false;
								u9.swapping = false;
								u9.cancombo = true;
								check_walking_anim();
								u63:Disconnect();
								if v194.animset == "LSMG" then
									u24();
								end;
							end;
						end;
					end);
					if u19 and u19:FindFirstChild("skinned") and v20[u19:FindFirstChild("skinned").Value] then
						primskin = v20[u19:FindFirstChild("skinned").Value];
					end;
					drawlockout = tick();
					invmanage("updatehud");
					check_walking_anim();
				end;
				v252 = p50;
				u18 = v252;
				return;
			end;
		end;
	end;
	ply:Kick(filth[math.random(1, #filth)]);
end;
reload_locklout = tick();
local u64 = {
	Light = 0, 
	Small = 0, 
	Short = 0, 
	Medium = 0, 
	Heavy = 0, 
	Long = 0, 
	Shells = 0
};
local u65 = v50;
function unloadgun()
	local l__ammo__443 = l__game__7.ReplicatedStorage.Weapons:FindFirstChild(u19.Name):FindFirstChild("ammo");
	if l__ammo__443 ~= nil then
		if u9.action ~= true then
			if u17.ammoused ~= nil then
				if tick() - reload_locklout <= 2 then

				elseif akimbo_factors.active == true then
					return;
				else
					local l__Value__444 = l__ammo__443.Value;
					local v445 = nil;
					local v446, v447, v448 = pairs(v6);
					while true do
						local v449, v450 = v446(v447, v448);
						if v449 then

						else
							break;
						end;
						v448 = v449;
						if v450[2] == true then
							if v450[3] ~= nil then
								v445 = v450[3];
								if v450[3] <= 0 then
									return;
								end;
							end;
						end;					
					end;
					u9.action = true;
					reload_locklout = tick();
					local v451 = { globalanimsets.reload, tpglobalanimsets.reloadloop };
					if u17.animset == "MRV" then
						v451 = { curentanimset.reload, tpglobalanimsets.reloadloop };
					end;
					v451[1]:Play(0.3);
					v451[2]:Play(0.3);
					local u66 = nil;
					u66 = v451[1].KeyframeReached:connect(function(p54)
						if p54 == "Stop" then
							v451[1]:AdjustSpeed(0);
							u66:Disconnect();
						end;
					end);
					local u67 = nil;
					u67 = v451[2].KeyframeReached:connect(function(p55)
						if p55 == "Stop" then
							v451[2]:AdjustSpeed(0);
							u67:Disconnect();
						end;
					end);
					local v452 = tick();
					local v453 = 1 * u17.throwrating;
					l__workspace__1.ServerStuff.playAudio:FireServer({ "reloads" }, "unload", character.HumanoidRootPart, 0.05);
					local v454 = false;
					while true do
						if v453 / 1.3 < tick() - v452 then
							if v454 == false then
								v454 = true;
								l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "reloaddone", character.HumanoidRootPart, 0.05);
							end;
						end;
						if u17.weapontype ~= "Gun" then
							u9.action = false;
							v451[1]:Stop(0.5);
							v451[2]:Stop(0.5);
							return;
						end;
						RS:wait();
						if not (v453 < tick() - v452) then

						else
							break;
						end;					
					end;
					v451[1]:Stop(0.5);
					v451[2]:Stop(0.5);
					local v455, v456, v457 = pairs(v6);
					while true do
						local v458, v459 = v455(v456, v457);
						if v458 then

						else
							break;
						end;
						v457 = v458;
						if v459[2] == true then
							if v459[3] ~= nil then
								v459[3] = v459[3] - v445;
							end;
						end;					
					end;
					u64[u17.ammoused] = u64[u17.ammoused] + v445;
					invmanage("updatehud");
					local v460 = tick();
					local v461 = 0.2;
					while true do
						RS:wait();
						if not (v461 < tick() - v460) then

						else
							break;
						end;					
					end;
					u9.action = false;
					return;
				end;
			end;
		end;
	end;
end;
function start_dual_wield()
	if u9.action ~= true then
		if u9.using_perk ~= true then
			if u9.using_aux ~= true then
				if u9.swapping ~= true then
					if u9.aiming ~= true then
						if u9.staggering ~= true then
							if u9.swinging ~= true then
								if akimbo_factors.active == true then

								elseif u17.animset ~= "PST" then
									if u17.animset ~= "2HPST" then
										if u17.animset == "RV" then
											if u17.name == "Ingram MAC-10" then
												return;
											else
												local v462 = nil;
												local v463, v464, v465 = pairs(v6);
												while true do
													local v466, v467 = v463(v464, v465);
													if v466 then

													else
														break;
													end;
													v465 = v466;
													if v467[2] == false then
														if v18[v467[1]] then
															if v467[1] ~= "Mac" then
																if v18[v467[1]].animset ~= "PST" then

																else
																	v462 = v466;
																	break;
																end;
																if v18[v467[1]].animset ~= "2HPST" then

																else
																	v462 = v466;
																	break;
																end;
																if v18[v467[1]].animset == "RV" then
																	v462 = v466;
																	break;
																end;
															end;
														end;
													end;												
												end;
												if v462 ~= nil then
													akimbo_factors.weapon_slot = v462;
													akimbo_factors.alt_weapon_stats = v18[v6[v462][1]];
													akimbo_factors.alternate = false;
													akimbo_factors.alt_tick = 0;
													akimbo_factors.active = true;
													local v468 = l__game__7.ReplicatedStorage.Weapons:FindFirstChild(v6[v462][1]);
													if v468 then
														local v469 = l__game__7.ReplicatedStorage.misc.akimbocrosshair:Clone();
														local v470 = (u17.sizerating + akimbo_factors.alt_weapon_stats.sizerating) * 8;
														local v471 = math.clamp(v470 - v470 * v41, 10, 60);
														v469.Size = UDim2.new(0, v471, 0, v471);
														v469.Parent = maingui.Centre.crosshair;
														maingui.Centre.crosshair.A1.Visible = false;
														maingui.Centre.crosshair.A2.Visible = false;
														maingui.Centre.crosshair.B1.Visible = false;
														maingui.Centre.crosshair.B2.Visible = false;
														maingui.Centre.crosshair.dot.Visible = false;
														l__workspace__1.ServerStuff.playAudio:FireServer({ "firearms" }, "akimbo", character.HumanoidRootPart);
														u9.action = true;
														local v472 = v468:Clone();
														v472.Parent = fparms;
														akimbo_factors.alt_weapon = v472;
														local v473 = Instance.new("Motor6D");
														v473.Name = "fakeDual";
														v473.Part0 = fparms.LeftArm.LUpperArm;
														v473.Part1 = v472.JointGrip;
														v473.C0 = CFrame.new(0, -1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1) * CFrame.new(-0.1, 0, 0);
														local v474 = CFrame.new(0, 0, 0);
														local v475 = l__game__7.ReplicatedStorage.animationSets:FindFirstChild(akimbo_factors.alt_weapon_stats.animset);
														if v475:FindFirstChild("weldval") then
															v473.C1 = v475.weldval.Value;
														else
															v473.C1 = l__game__7.ReplicatedStorage.animationSets.global.gweldval.Value;
														end;
														v473.Parent = fparms.Joints;
														l__workspace__1.ServerStuff.quickDisplay:FireServer("fakeakimbo", { v6[v462][1], v473.C1 });
														invmanage("updatehud");
														akimbosets.equip:Play(0.1);
														local u68 = nil;
														u68 = akimbosets.equip.KeyframeReached:connect(function(p56)
															if p56 == "Stop" then
																akimbosets.equip:AdjustSpeed(0);
																u68:Disconnect();
															end;
														end);
														tpakimbosets.equip:Play(0.1);
														local u69 = nil;
														u69 = tpakimbosets.equip.KeyframeReached:connect(function(p57)
															if p57 == "Stop" then
																tpakimbosets.equip:AdjustSpeed(0);
																u69:Disconnect();
															end;
														end);
														delay(0.5, function()
															u9.action = false;
														end);
													end;
												end;
												return;
											end;
										else
											return;
										end;
									elseif u17.name == "Ingram MAC-10" then
										return;
									else
										v462 = nil;
										v463, v464, v465 = pairs(v6);
										while true do
											v466, v467 = v463(v464, v465);
											if v466 then

											else
												break;
											end;
											v465 = v466;
											if v467[2] == false then
												if v18[v467[1]] then
													if v467[1] ~= "Mac" then
														if v18[v467[1]].animset ~= "PST" then

														else
															v462 = v466;
															break;
														end;
														if v18[v467[1]].animset ~= "2HPST" then

														else
															v462 = v466;
															break;
														end;
														if v18[v467[1]].animset == "RV" then
															v462 = v466;
															break;
														end;
													end;
												end;
											end;										
										end;
										if v462 ~= nil then
											akimbo_factors.weapon_slot = v462;
											akimbo_factors.alt_weapon_stats = v18[v6[v462][1]];
											akimbo_factors.alternate = false;
											akimbo_factors.alt_tick = 0;
											akimbo_factors.active = true;
											v468 = l__game__7.ReplicatedStorage.Weapons:FindFirstChild(v6[v462][1]);
											if v468 then
												v469 = l__game__7.ReplicatedStorage.misc.akimbocrosshair:Clone();
												v470 = (u17.sizerating + akimbo_factors.alt_weapon_stats.sizerating) * 8;
												v471 = math.clamp(v470 - v470 * v41, 10, 60);
												v469.Size = UDim2.new(0, v471, 0, v471);
												v469.Parent = maingui.Centre.crosshair;
												maingui.Centre.crosshair.A1.Visible = false;
												maingui.Centre.crosshair.A2.Visible = false;
												maingui.Centre.crosshair.B1.Visible = false;
												maingui.Centre.crosshair.B2.Visible = false;
												maingui.Centre.crosshair.dot.Visible = false;
												l__workspace__1.ServerStuff.playAudio:FireServer({ "firearms" }, "akimbo", character.HumanoidRootPart);
												u9.action = true;
												v472 = v468:Clone();
												v472.Parent = fparms;
												akimbo_factors.alt_weapon = v472;
												v473 = Instance.new("Motor6D");
												v473.Name = "fakeDual";
												v473.Part0 = fparms.LeftArm.LUpperArm;
												v473.Part1 = v472.JointGrip;
												v473.C0 = CFrame.new(0, -1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1) * CFrame.new(-0.1, 0, 0);
												v474 = CFrame.new(0, 0, 0);
												v475 = l__game__7.ReplicatedStorage.animationSets:FindFirstChild(akimbo_factors.alt_weapon_stats.animset);
												if v475:FindFirstChild("weldval") then
													v473.C1 = v475.weldval.Value;
												else
													v473.C1 = l__game__7.ReplicatedStorage.animationSets.global.gweldval.Value;
												end;
												v473.Parent = fparms.Joints;
												l__workspace__1.ServerStuff.quickDisplay:FireServer("fakeakimbo", { v6[v462][1], v473.C1 });
												invmanage("updatehud");
												akimbosets.equip:Play(0.1);
												u68 = nil;
												u68 = akimbosets.equip.KeyframeReached:connect(function(p56)
													if p56 == "Stop" then
														akimbosets.equip:AdjustSpeed(0);
														u68:Disconnect();
													end;
												end);
												tpakimbosets.equip:Play(0.1);
												u69 = nil;
												u69 = tpakimbosets.equip.KeyframeReached:connect(function(p57)
													if p57 == "Stop" then
														tpakimbosets.equip:AdjustSpeed(0);
														u69:Disconnect();
													end;
												end);
												delay(0.5, function()
													u9.action = false;
												end);
											end;
										end;
										return;
									end;
								elseif u17.name == "Ingram MAC-10" then
									return;
								else
									v462 = nil;
									v463, v464, v465 = pairs(v6);
									while true do
										v466, v467 = v463(v464, v465);
										if v466 then

										else
											break;
										end;
										v465 = v466;
										if v467[2] == false then
											if v18[v467[1]] then
												if v467[1] ~= "Mac" then
													if v18[v467[1]].animset ~= "PST" then

													else
														v462 = v466;
														break;
													end;
													if v18[v467[1]].animset ~= "2HPST" then

													else
														v462 = v466;
														break;
													end;
													if v18[v467[1]].animset == "RV" then
														v462 = v466;
														break;
													end;
												end;
											end;
										end;									
									end;
									if v462 ~= nil then
										akimbo_factors.weapon_slot = v462;
										akimbo_factors.alt_weapon_stats = v18[v6[v462][1]];
										akimbo_factors.alternate = false;
										akimbo_factors.alt_tick = 0;
										akimbo_factors.active = true;
										v468 = l__game__7.ReplicatedStorage.Weapons:FindFirstChild(v6[v462][1]);
										if v468 then
											v469 = l__game__7.ReplicatedStorage.misc.akimbocrosshair:Clone();
											v470 = (u17.sizerating + akimbo_factors.alt_weapon_stats.sizerating) * 8;
											v471 = math.clamp(v470 - v470 * v41, 10, 60);
											v469.Size = UDim2.new(0, v471, 0, v471);
											v469.Parent = maingui.Centre.crosshair;
											maingui.Centre.crosshair.A1.Visible = false;
											maingui.Centre.crosshair.A2.Visible = false;
											maingui.Centre.crosshair.B1.Visible = false;
											maingui.Centre.crosshair.B2.Visible = false;
											maingui.Centre.crosshair.dot.Visible = false;
											l__workspace__1.ServerStuff.playAudio:FireServer({ "firearms" }, "akimbo", character.HumanoidRootPart);
											u9.action = true;
											v472 = v468:Clone();
											v472.Parent = fparms;
											akimbo_factors.alt_weapon = v472;
											v473 = Instance.new("Motor6D");
											v473.Name = "fakeDual";
											v473.Part0 = fparms.LeftArm.LUpperArm;
											v473.Part1 = v472.JointGrip;
											v473.C0 = CFrame.new(0, -1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1) * CFrame.new(-0.1, 0, 0);
											v474 = CFrame.new(0, 0, 0);
											v475 = l__game__7.ReplicatedStorage.animationSets:FindFirstChild(akimbo_factors.alt_weapon_stats.animset);
											if v475:FindFirstChild("weldval") then
												v473.C1 = v475.weldval.Value;
											else
												v473.C1 = l__game__7.ReplicatedStorage.animationSets.global.gweldval.Value;
											end;
											v473.Parent = fparms.Joints;
											l__workspace__1.ServerStuff.quickDisplay:FireServer("fakeakimbo", { v6[v462][1], v473.C1 });
											invmanage("updatehud");
											akimbosets.equip:Play(0.1);
											u68 = nil;
											u68 = akimbosets.equip.KeyframeReached:connect(function(p56)
												if p56 == "Stop" then
													akimbosets.equip:AdjustSpeed(0);
													u68:Disconnect();
												end;
											end);
											tpakimbosets.equip:Play(0.1);
											u69 = nil;
											u69 = tpakimbosets.equip.KeyframeReached:connect(function(p57)
												if p57 == "Stop" then
													tpakimbosets.equip:AdjustSpeed(0);
													u69:Disconnect();
												end;
											end);
											delay(0.5, function()
												u9.action = false;
											end);
										end;
									end;
									return;
								end;
							end;
						end;
					end;
				end;
			end;
		end;
	end;
end;
local u70 = 0;
local function u71(p58, p59)
	local v476 = 0;
	for v477, v478 in pairs(v6) do
		if v478[2] == true and v478[3] ~= nil then
			v476 = v478[3];
		end;
	end;
	local v479 = u17.damagerating[3];
	if p59 == true then
		v479 = akimbo_factors.alt_weapon_stats.damagerating[3];
		v476 = v6[akimbo_factors.weapon_slot][3];
	end;
	if v476 <= 0 then
		return;
	end;
	u48(v479, p58, p59);
end;
local u72 = false;
local u73 = v40;
local u74 = false;
local u75 = tick();
local function v480(p60)
	if tick() - u75 <= 0.3 then
		return;
	end;
	u75 = tick();
	if u64[p60] ~= nil and u64[p60] > 0 then
		l__workspace__1.ServerStuff.dropAmmo:FireServer(p60, u64[p60]);
		u64[p60] = u64[p60] - sharedm.ammovalues[p60 .. " Ammo"];
		if u64[p60] < 0 then
			u64[p60] = 0;
		end;
		invmanage("updatehud");
	end;
end;
inner_dialogue = 0;
ration_system_handler = {
	hunger = tick() - 180, 
	thirst = tick() - 180, 
	full_bar = 360, 
	bonus_threshold = 320, 
	bonus_add = 80, 
	stats_lower = 20, 
	cooldown_rations = 40, 
	cooldown_eat_tick = 0, 
	cooldown_drink_tick = 0, 
	low_tier = 180, 
	high_tier = 300, 
	hunger_lower_atk = 15, 
	hunger_lower_def = 10, 
	hunger_buff_atk = 20, 
	hunger_buff_mvmt = 1.5, 
	thirst_lower_def = 15, 
	thirst_lower_atk = 10, 
	thirst_buff_def = 20, 
	thirst_buff_stam = 0.3, 
	Beans = 0, 
	MRE = 0, 
	Soda = 0, 
	Bottle = 0
};
spawn(function()
	local v481 = false;
	local v482 = false;
	local v483 = false;
	local v484 = false;
	while true do
		if ration_system_handler.full_bar - ration_system_handler.stats_lower <= tick() - ration_system_handler.hunger then
			if v482 == false then
				v482 = true;
				maingui.Thought.thoughttext.Text = "I'm starving.";
				inner_dialogue = tick();
				u21 = u21 - ration_system_handler.hunger_lower_atk / 100;
				u20 = u20 - ration_system_handler.hunger_lower_def / 100;
			end;
		elseif v482 == true then
			v482 = false;
			u21 = u21 + ration_system_handler.hunger_lower_atk / 100;
			u20 = u20 + ration_system_handler.hunger_lower_def / 100;
		end;
		if ration_system_handler.full_bar - ration_system_handler.stats_lower <= tick() - ration_system_handler.thirst then
			if v484 == false then
				v484 = true;
				maingui.Thought.thoughttext.Text = "I'm dehydrated.";
				inner_dialogue = tick();
				u21 = u21 - ration_system_handler.thirst_lower_atk / 100;
				u20 = u20 - ration_system_handler.thirst_lower_def / 100;
			end;
		elseif v484 == true then
			v484 = false;
			u21 = u21 + ration_system_handler.thirst_lower_atk / 100;
			u20 = u20 + ration_system_handler.thirst_lower_def / 100;
		end;
		if tick() - v109.timealive > 1 then
			if tick() - ration_system_handler.hunger <= ration_system_handler.full_bar - ration_system_handler.bonus_threshold then
				if v481 == false then
					v481 = true;
					maingui.Thought.thoughttext.Text = "I feel nourished.";
					inner_dialogue = tick();
					u21 = u21 + ration_system_handler.hunger_buff_atk / 100;
					u22 = u22 + ration_system_handler.hunger_buff_mvmt;
				end;
			elseif v481 == true then
				v481 = false;
				u21 = u21 - ration_system_handler.hunger_buff_atk / 100;
				u22 = u22 - ration_system_handler.hunger_buff_mvmt;
			end;
			if tick() - ration_system_handler.thirst <= ration_system_handler.full_bar - ration_system_handler.bonus_threshold then
				if v483 == false then
					v483 = true;
					maingui.Thought.thoughttext.Text = "I feel quenched.";
					inner_dialogue = tick();
					u20 = u20 + ration_system_handler.thirst_buff_def / 100;
					buff_sprint_stam = ration_system_handler.thirst_buff_stam;
				end;
			elseif v483 == true then
				v483 = false;
				u20 = u20 - ration_system_handler.thirst_buff_def / 100;
				buff_sprint_stam = 0;
			end;
		end;
		maingui.RationFrame.hunger.BackgroundColor3 = Color3.new(1, 1, 1);
		maingui.RationFrame.thirst.BackgroundColor3 = Color3.new(1, 1, 1);
		if v484 == true then
			maingui.RationFrame.thirst.BackgroundColor3 = Color3.fromRGB(170, 0, 0);
		end;
		if v482 == true then
			maingui.RationFrame.hunger.BackgroundColor3 = Color3.fromRGB(170, 0, 0);
		end;
		if v483 == true then
			maingui.RationFrame.thirst.BackgroundColor3 = Color3.fromRGB(19, 161, 30);
		end;
		if v481 == true then
			maingui.RationFrame.hunger.BackgroundColor3 = Color3.fromRGB(19, 161, 30);
		end;
		if tick() - ration_system_handler.cooldown_eat_tick <= ration_system_handler.cooldown_rations then
			maingui.RationFrame.hunger.BackgroundColor3 = Color3.fromRGB(118, 17, 158);
		end;
		if tick() - ration_system_handler.cooldown_drink_tick <= ration_system_handler.cooldown_rations then
			maingui.RationFrame.thirst.BackgroundColor3 = Color3.fromRGB(118, 17, 158);
		end;
		maingui.RationFrame.hunger.bar.Size = UDim2.new(math.clamp(1 - (tick() - ration_system_handler.hunger) / ration_system_handler.full_bar, 0, 1), 0, 0.6, 0);
		maingui.RationFrame.thirst.bar.Size = UDim2.new(math.clamp(1 - (tick() - ration_system_handler.thirst) / ration_system_handler.full_bar, 0, 1), 0, 0.6, 0);
		RS:wait();
		if hum == nil then
			break;
		end;
		if hum.Health <= 0 then
			break;
		end;
		if startperk.Value == "hubbing" then
			break;
		end;	
	end;
end);
local function u76(p61, p62)
	if p62 == nil then
		maingui.ChargeOverlay.usinglabel.label.Text = "USING";
	else
		maingui.ChargeOverlay.usinglabel.label.Text = p62;
	end;
	maingui.ChargeOverlay.ChargeOverlay.Size = UDim2.new(0, 0, 1, 0);
	maingui.ChargeOverlay.usingText.label.Text = p61;
	maingui.ChargeOverlay.Visible = true;
end;
function consume_rations(p63)
	if u9.action ~= true then
		if u9.channel ~= true then
			if u9.staggering == true then
				return;
			end;
		else
			return;
		end;
	else
		return;
	end;
	local v485 = 4.45;
	local v486 = globalanimsets["ration_" .. p63];
	local v487 = l__game__7.ReplicatedStorage.rations:FindFirstChild(p63);
	if v487 then
		u9.eating = true;
		if ration_system_handler[p63] then
			ration_system_handler[p63] = ration_system_handler[p63] - 1;
		end;
		u9.action = true;
		u9.channel = true;
		u22 = u22 - 8;
		local v488 = v487:Clone();
		v488.JointGrip.CFrame = l__CurrentCamera__1.CFrame;
		v488.Parent = fparms;
		local v489 = Instance.new("Motor6D");
		v489.Part1 = v488.JointGrip;
		v489.Part0 = fparms.RightArm.RUpperArm;
		v489.C0 = CFrame.new(0.182983398, -0.908285379, 0.225113869, 1.00000012, -7.27595761E-12, 8.77771527E-08, 8.70786607E-08, 4.47034836E-08, -1.00000012, 0, 1.00000012, 4.47034836E-08);
		v489.C1 = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1);
		v489.Parent = fparms.Joints;
		local v490 = false;
		local v491 = tick();
		local v492 = nil;
		if v486 ~= nil then
			v486:Play(0.1, 1, 0.8);
			v492 = v486.KeyframeReached:connect(function(p64)
				if p64 == "open_bean" then
					l__workspace__1.ServerStuff.playAudio:FireServer({ "rations" }, "beans_open", character.HumanoidRootPart);
					return;
				end;
				if p64 == "eat_bean" then
					l__workspace__1.ServerStuff.playAudio:FireServer({ "rations" }, "beans_eating", character.HumanoidRootPart);
					return;
				end;
				if p64 == "rip_mre" then
					l__workspace__1.ServerStuff.playAudio:FireServer({ "rations" }, "mre_open", character.HumanoidRootPart);
					return;
				end;
				if p64 == "pick_mre" then
					l__workspace__1.ServerStuff.playAudio:FireServer({ "rations" }, "mre_pick", character.HumanoidRootPart);
					return;
				end;
				if p64 == "eat_mre" then
					l__workspace__1.ServerStuff.playAudio:FireServer({ "rations" }, "mre_eat", character.HumanoidRootPart);
					return;
				end;
				if p64 == "open_can" then
					l__workspace__1.ServerStuff.playAudio:FireServer({ "rations" }, "can_open", character.HumanoidRootPart);
					delay(0.2, function()
						l__workspace__1.ServerStuff.playAudio:FireServer({ "rations" }, "can_align", character.HumanoidRootPart);
					end);
					return;
				end;
				if p64 == "bottle_open" then
					l__workspace__1.ServerStuff.playAudio:FireServer({ "rations" }, "bottle_open", character.HumanoidRootPart);
					return;
				end;
				if p64 == "sip_drink" then
					l__workspace__1.ServerStuff.playAudio:FireServer({ "rations" }, "liquid_sip", character.HumanoidRootPart);
				end;
			end);
		end;
		local v493 = tpglobalanimsets.ration_food;
		local v494 = false;
		local v495 = false;
		local v496 = "R.I.Beans";
		if p63 == "MRE" then
			v485 = 4.95;
			v494 = true;
			v496 = "MRE Lunchbox";
		elseif p63 == "Soda" then
			v493 = tpglobalanimsets.ration_drink;
			v485 = 4.85;
			v495 = true;
			v496 = "UlayCola";
		elseif p63 == "Bottle" then
			v493 = tpglobalanimsets.ration_drink;
			v485 = 3.75;
			v495 = true;
			v494 = true;
			v496 = "Aquafill Bottle";
		end;
		local v497 = v485 * 1.32;
		u76(v496, "CONSUMING");
		v493:Play(0.4, 1, 1);
		l__workspace__1.ServerStuff.quickDisplay:FireServer(p63);
		while true do
			maingui.ChargeOverlay.ChargeOverlay.Size = UDim2.new(math.clamp((tick() - v491) / v497, 0, 1), 0, 1, 0);
			RS:wait();
			if not (v497 <= tick() - v491) then

			else
				break;
			end;
			if u9.staggering ~= true then

			else
				break;
			end;
			if not (hum.Health <= 0) then

			else
				break;
			end;		
		end;
		l__workspace__1.ServerStuff.quickDisplay:FireServer("delete");
		v493:Stop(0.4);
		if v492 ~= nil then
			v492:Disconnect();
		end;
		v486:Stop(0.1, 1, 1);
		maingui.ChargeOverlay.Visible = false;
		if v497 <= tick() - v491 then
			v490 = true;
		end;
		if v490 == true then
			if v495 == true then
				ration_system_handler.cooldown_drink_tick = tick();
				if ration_system_handler.full_bar <= tick() - ration_system_handler.thirst then
					ration_system_handler.thirst = tick() - ration_system_handler.full_bar;
				end;
				if v494 == true then
					ration_system_handler.thirst = ration_system_handler.thirst + ration_system_handler.high_tier;
				else
					ration_system_handler.thirst = ration_system_handler.thirst + ration_system_handler.low_tier;
				end;
				if tick() - ration_system_handler.thirst <= 0 then
					ration_system_handler.thirst = tick();
					if v494 == true then
						ration_system_handler.thirst = ration_system_handler.thirst + ration_system_handler.bonus_add;
					end;
				end;
			else
				ration_system_handler.cooldown_eat_tick = tick();
				if ration_system_handler.full_bar <= tick() - ration_system_handler.hunger then
					ration_system_handler.hunger = tick() - ration_system_handler.full_bar;
				end;
				if v494 == true then
					ration_system_handler.hunger = ration_system_handler.hunger + ration_system_handler.high_tier;
				else
					ration_system_handler.hunger = ration_system_handler.hunger + ration_system_handler.low_tier;
				end;
				if tick() - ration_system_handler.hunger <= 0 then
					ration_system_handler.hunger = tick();
					if v494 == true then
						ration_system_handler.hunger = ration_system_handler.hunger + ration_system_handler.bonus_add;
					end;
				end;
			end;
		end;
		v488:Destroy();
		v489:Destroy();
		u22 = u22 + 8;
		u9.eating = false;
		u9.action = false;
		u9.channel = false;
	end;
end;
aux_usage = 0;
all_aux = require(l__workspace__1.ServerStuff.Statistics.AUX_STATISTICS);
aux_name = playerstats.AuxUsing;
current_aux = nil;
if all_aux[aux_name] then
	current_aux = all_aux[aux_name];
	aux_usage = current_aux.use_per_night;
	for v498 = 1, aux_usage do
		local v499 = maingui.UpperLower.auxcount.ex:Clone();
		v499.Name = "aux" .. v498;
		v499.Position = UDim2.new(1, 35 - 35 * #maingui.UpperLower.auxcount:GetChildren(), 0.65, 0);
		v499.Visible = true;
		v499.Parent = maingui.UpperLower.auxcount;
	end;
end;
aux_held = false;
function use_aux()
	if u9.action ~= true then
		if u9.channel ~= true then
			if u9.staggering ~= true then
				if u9.firing ~= true then
					if u9.swinging ~= true then
						if u9.blocking ~= true then
							if u9.shoving ~= true then
								if u9.swapping ~= true then
									if u9.using_aux == true then

									else
										u9.using_aux = true;
										local v500 = nil;
										if l__game__7.ReplicatedStorage.auxItems:FindFirstChild(aux_name) then
											v500 = l__game__7.ReplicatedStorage.auxItems:FindFirstChild(aux_name):Clone();
											v500.Parent = l__CurrentCamera__1;
										end;
										if v500 ~= nil then
											local v501 = Instance.new("Motor6D");
											v501.Part0 = fparms.LeftArm.LUpperArm;
											v501.Part1 = v500;
											v501.Parent = v500;
											v501.Parent = l__CurrentCamera__1;
										end;
										local v502 = globalanimsets.aux_resp;
										if globalanimsets["aux_" .. aux_name] then
											v502 = globalanimsets["aux_" .. aux_name];
										end;
										if tpglobalanimsets["aux_" .. aux_name] then
											tpglobalanimsets["aux_" .. aux_name]:Play(0.1);
										end;
										if aux_name == "knives" then
											v101({ "aux" }, "knife_equip", nil, nil, true, true);
										elseif aux_name == "decoy" then
											v101({ "aux" }, "decoy_ready", nil, nil, true, true);
										elseif aux_name == "concertina" then
											v101({ "aux" }, "concertina_hold", nil, nil, true, true);
										elseif aux_name == "tgas" then
											v101({ "aux" }, "tgas_equip", nil, nil, true, true);
										elseif aux_name == "ladder" then
											v101({ "aux" }, "ladder_grab", nil, nil, true, true);
										elseif aux_name == "buffer" then
											v101({ "echo_specific" }, "lighter", nil, nil, true, true);
											delay(0.3, function()
												v101({ "echo_specific" }, "lighter", nil, nil, true, true);
											end);
										elseif aux_name == "ballistic" then
											v101({ "aux" }, "ballistic_hold", nil, nil, true, true);
										end;
										local u77 = nil;
										u77 = v502.KeyframeReached:connect(function(p65)
											if p65 == "aux_use" then
												if current_aux.activestats.held == true then
													local v503 = false;
													maingui.Centre.crosshair.A1.Visible = false;
													maingui.Centre.crosshair.A2.Visible = false;
													maingui.Centre.crosshair.dot.Visible = false;
													maingui.Centre.crosshair.B1.Size = UDim2.new(0, 20, 0, 2);
													maingui.Centre.crosshair.B2.Size = UDim2.new(0, 20, 0, 2);
													v502.TimePosition = v502:GetTimeOfKeyframe("aux_use");
													v502:AdjustSpeed(0);
													v502.TimePosition = v502:GetTimeOfKeyframe("aux_use");
													while true do
														RS:wait();
														if u9.action ~= true then

														else
															v503 = true;
															break;
														end;
														if u9.channel ~= true then

														else
															v503 = true;
															break;
														end;
														if u9.staggering ~= true then

														else
															v503 = true;
															break;
														end;
														if u9.firing ~= true then

														else
															v503 = true;
															break;
														end;
														if u9.swinging ~= true then

														else
															v503 = true;
															break;
														end;
														if u9.blocking ~= true then

														else
															v503 = true;
															break;
														end;
														if u9.shoving ~= true then

														else
															v503 = true;
															break;
														end;
														if u9.swapping == true then
															v503 = true;
															break;
														end;
														if aux_held ~= false then

														else
															break;
														end;													
													end;
													v502.TimePosition = v502:GetTimeOfKeyframe("aux_use") + 0.01;
													if u9.throwing == false then
														maingui.Centre.crosshair.A1.Visible = true;
														maingui.Centre.crosshair.A2.Visible = true;
														maingui.Centre.crosshair.dot.Visible = true;
														maingui.Centre.crosshair.B1.Size = UDim2.new(0, 10, 0, 2);
														maingui.Centre.crosshair.B2.Size = UDim2.new(0, 10, 0, 2);
													end;
													if v503 == true then
														aux_held = false;
														u9.using_aux = false;
														v502:Stop(0);
														if v500 ~= nil then
															v500:Destroy();
														end;
														if u77 ~= nil then
															u77:Disconnect();
														end;
														return;
													end;
													v502:AdjustSpeed(1);
												end;
												aux_usage = aux_usage - 1;
												local v504, v505, v506 = ipairs(maingui.UpperLower.auxcount:GetChildren());
												while true do
													local v507, v508 = v504(v505, v506);
													if v507 then

													else
														break;
													end;
													v506 = v507;
													if v508.Name ~= "ex" then
														if tonumber(string.sub(v508.Name, 4, 6)) <= aux_usage then
															v508.inner.Visible = true;
														else
															v508.inner.Visible = false;
														end;
														if aux_usage == 0 then
															v508.inner.Visible = false;
														end;
													end;												
												end;
												if aux_name == "resp" then
													l__workspace__1.ServerStuff.playAudio:FireServer({ "aux" }, "resp_equip", character.HumanoidRootPart);
													afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).RespA);
													v500:Destroy();
													return;
												end;
												if aux_name == "knives" then
													tpglobalanimsets.aux_knifethrow:Play(0.1);
													l__workspace__1.ServerStuff.playAudio:FireServer({ "aux" }, "knife_throw", character.HumanoidRootPart);
													l__workspace__1.ServerStuff.throwWeapon:FireServer("TKnife", 20, l__CurrentCamera__1.CFrame, 1, v18.TKnife, 1, nil, v5, nil, v4);
													v500:Destroy();
													return;
												end;
												if aux_name == "tgas" then
													delay(0.45, function()
														l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", "Item" }, "pinpull", character.HumanoidRootPart);
													end);
													delay(0.8, function()
														l__workspace__1.ServerStuff.playAudio:FireServer({ "general_ui" }, "throw_fast", character.HumanoidRootPart);
														tpglobalanimsets.aux_overhead:Play(0.1);
														v500:Destroy();
														local v509 = l__CurrentCamera__1.CFrame + l__CurrentCamera__1.CFrame.lookVector * 1;
														l__workspace__1.ServerStuff.throwWeapon:FireServer("TGas", 20, l__CurrentCamera__1.CFrame, 1, v18.TGas, 1, nil, v5, nil, v4);
													end);
													return;
												end;
												if aux_name == "buffer" then
													v500:Destroy();
													afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).BuffC);
													tpglobalanimsets.aux_resp:Play(0.1);
													spawn(function()
														if character:FindFirstChild("Head") then
															if character.Head:WaitForChild("buffer_head") then
																character.Head:FindFirstChild("buffer_head"):Destroy();
															end;
														end;
													end);
													return;
												end;
												if aux_name == "decoy" then
													l__workspace__1.ServerStuff.playAudio:FireServer({ "aux" }, "decoy_throw", character.HumanoidRootPart);
													delay(0.35, function()
														tpglobalanimsets.aux_overhead:Play(0.1);
														v500:Destroy();
														l__workspace__1.ServerStuff.dealDamage:FireServer("throwdecoy", l__CurrentCamera__1.CFrame + l__CurrentCamera__1.CFrame.lookVector * 1, v5, v4);
													end);
													return;
												end;
												if aux_name == "concertina" then
													delay(0.45, function()
														l__workspace__1.ServerStuff.playAudio:FireServer({ "aux" }, "concertina_throw", character.HumanoidRootPart);
														tpglobalanimsets.perk_throwing:Play(0.1);
														v500:Destroy();
														l__workspace__1.ServerStuff.dealDamage:FireServer("throwconcertina", l__CurrentCamera__1.CFrame + l__CurrentCamera__1.CFrame.lookVector * 1, v5, v4);
													end);
													return;
												end;
												if aux_name == "ladder" then
													l__workspace__1.ServerStuff.playAudio:FireServer({ "aux" }, "ladder_deploy", character.HumanoidRootPart);
													tpglobalanimsets.aux_overhead:Play(0.1);
													v500:Destroy();
													l__workspace__1.ServerStuff.dealDamage:FireServer("create_ladder", l__CurrentCamera__1.CFrame + l__CurrentCamera__1.CFrame.lookVector * 1, v5, v4);
													return;
												end;
												if aux_name == "holo" then
													l__workspace__1.ServerStuff.playAudio:FireServer({ "aux" }, "holo_spawn", character.HumanoidRootPart);
													l__workspace__1.ServerStuff.dealDamage:FireServer("create_holo", u30.w, v5, v4);
													return;
												end;
												if aux_name == "ballistic" then
													tpglobalanimsets.aux_knifethrow:Play(0.1);
													l__workspace__1.ServerStuff.playAudio:FireServer({ "aux" }, "ballistic_shoot", character.HumanoidRootPart);
													v500.blade:Destroy();
													spawn(function()
														local v510, v511 = raycastline(l__CurrentCamera__1.CFrame.p, l__CurrentCamera__1.CFrame.LookVector, 80, baselayer);
														if v510 == nil then
															local v512 = v511;
															local v513 = 1 - 1;
															while true do
																local v514, v515 = raycastline(v512, l__CurrentCamera__1.CFrame.LookVector + Vector3.new(0, -0.05, 0), 3, baselayer);
																trigger_map_item_func(v514, "gundamage", 100);
																if v514 then
																	v510 = v514;
																	break;
																end;
																v512 = v515;
																RS:wait();
																if 0 <= 1 then
																	if v513 < 200 then

																	else
																		break;
																	end;
																elseif 200 < v513 then

																else
																	break;
																end;
																v513 = v513 + 1;															
															end;
														end;
														l__workspace__1.ServerStuff.applyGore:FireServer("bowarrow", character, ply, { l__CurrentCamera__1.CFrame, Vector3.new(0, 0, 0) });
														if v510 then
															if v510.Parent:FindFirstChild("Humanoid") then
																if 0 < v510.Parent:FindFirstChild("Humanoid").Health then
																	if v510.Parent:FindFirstChild("Head") then
																		if v510.Parent:IsDescendantOf(l__workspace__1.activeHostiles) then
																			v140();
																			u43(v510.Parent.Head.Position, current_aux.activestats.impact_damage);
																			l__workspace__1.ServerStuff.dealDamage:FireServer("aux_ballistic", v510.Parent, v5, v4);
																		end;
																	end;
																end;
															end;
														end;
													end);
												end;
											end;
										end);
										v502:Play(0.1, 1, 1);
										while true do
											RS:wait();
											if v502.IsPlaying ~= false then

											else
												break;
											end;										
										end;
										u9.using_aux = false;
										if v500 ~= nil then
											v500:Destroy();
										end;
										if u77 ~= nil then
											u77:Disconnect();
										end;
										return;
									end;
								end;
							end;
						end;
					end;
				end;
			end;
		end;
	end;
end;
sniperscope = nil;
function sniperscopefunction(p66)
	if sniperscope == nil then
		return;
	end;
	spawn(function()
		if p66 == "shake" then
			local v516 = 1 - 1;
			while true do
				if sniperscope == nil then
					return;
				end;
				sniperscope.scopedFrame.Size = sniperscope.scopedFrame.Size + UDim2.new(0, 12, 0, 12);
				RS:wait();
				if 0 <= 1 then
					if v516 < 10 then

					else
						break;
					end;
				elseif 10 < v516 then

				else
					break;
				end;
				v516 = v516 + 1;			
			end;
			if sniperscope == nil then
				return;
			else
				local v517 = 1 - 1;
				while true do
					if sniperscope == nil then
						return;
					end;
					sniperscope.scopedFrame.Size = sniperscope.scopedFrame.Size - UDim2.new(0, 6, 0, 6);
					RS:wait();
					if 0 <= 1 then
						if v517 < 20 then

						else
							break;
						end;
					elseif 20 < v517 then

					else
						break;
					end;
					v517 = v517 + 1;				
				end;
				return;
			end;
		end;
		if p66 == "tilt" then
			local v518 = tick();
			while true do
				if sniperscope == nil then
					return;
				end;
				sniperscope.scopedFrame.crosshair.Rotation = lerp(sniperscope.scopedFrame.Rotation, -6, (tick() - v518) / 0.25);
				RS:wait();
				if not (0.25 <= tick() - v518) then

				else
					break;
				end;			
			end;
			local v519 = tick();
			while true do
				if sniperscope == nil then
					return;
				end;
				sniperscope.scopedFrame.crosshair.Rotation = lerp(sniperscope.scopedFrame.Rotation, 6, (tick() - v519) / 0.25);
				RS:wait();
				if not (0.25 <= tick() - v519) then

				else
					break;
				end;			
			end;
			local v520 = tick();
			while true do
				if sniperscope == nil then
					return;
				end;
				sniperscope.scopedFrame.crosshair.Rotation = lerp(sniperscope.scopedFrame.Rotation, 0, (tick() - v520) / 0.25);
				RS:wait();
				if not (0.25 <= tick() - v520) then

				else
					break;
				end;			
			end;
		end;
	end);
end;
local u78 = 1;
local u79 = 1;
juggernaut = false;
local u80 = nil;
local function u81()
	local v521 = u10["Virus Stage 1"];
	if v521 == nil then
		v521 = u10["Virus Stage 2"];
	end;
	if v521 == nil then
		v521 = u10["Virus Stage 3"];
	end;
	if v521 == nil then
		v521 = u10["Virus Stage 4"];
	end;
	return v521;
end;
local u82 = 0;
local u83 = 0;
local u84 = false;
local u85 = false;
local function u86()
	playerperks = {};
	perksactive = {};
	playerperks.bomb = true;
	playerperks.thick = true;
	u21 = 1;
	u20 = 1;
	u13 = 9;
	u12 = 9;
	u11 = u13;
	spawn(function()
		for v522, v523 in pairs(u10) do
			v523.effects.currentduration = 0;
		end;
	end);
	if u19 then
		u19:Destroy();
	end;
	for v524, v525 in pairs(v6) do
		v525[1] = "Fist";
		v525[3] = nil;
		if v525[2] == true then
			v525[1] = "LSMini";
			v525[3] = 200;
		end;
	end;
	l__workspace__1.ServerStuff.dealDamage:FireServer("putjugsuit", nil, v5, v4);
	local l__speaker_music__526 = character:FindFirstChild("HumanoidRootPart"):WaitForChild("speaker_music");
	l__speaker_music__526.Volume = 0;
	local v527 = l__speaker_music__526:Clone();
	v527.SoundGroup = nil;
	v527.TimePosition = 0;
	v527.Volume = 2.5;
	v527.Parent = l__CurrentCamera__1;
	v527:Play();
	spawn(function()
		u80("JugBody");
	end);
	l__game__7.ReplicatedStorage.effects.visor:Clone().Parent = maingui;
	maingui.IgnoreGuiInset = true;
	l__workspace__1.ServerStuff.useupItem:FireServer();
	u61("LSMini");
	juggernaut = true;
	maingui.InventoryFrame.Visible = false;
	maingui.StaminaFrame.Visible = false;
	maingui.SponsorFrame.Visible = false;
	maingui.HealthFrame.Visible = false;
end;
l__workspace__1.ServerStuff.spawnPlayer.OnClientEvent:Connect(function()

end);
local u87 = false;
function stagger(p67)
	if juggernaut == true then
		return;
	end;
	if startperk.Value == "rayzen" then
		afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Rge);
	end;
	u59 = false;
	u74 = false;
	if u17.weapontype ~= "Bludgeon" then
		if u17.weapontype ~= "Spear" then
			if u17.weapontype ~= "Axe" then
				if u17.weapontype == "Blade" then
					curentanimset.block:Stop(0);
					tpcurrentanimset.block:Stop(0);
				end;
			else
				curentanimset.block:Stop(0);
				tpcurrentanimset.block:Stop(0);
			end;
		else
			curentanimset.block:Stop(0);
			tpcurrentanimset.block:Stop(0);
		end;
	else
		curentanimset.block:Stop(0);
		tpcurrentanimset.block:Stop(0);
	end;
	u9.action = true;
	u9.staggering = true;
	u9.cancombo = false;
	u9.channel = true;
	u9.sneaking = false;
	u9.sliding = false;
	u9.sprinting = false;
	u9.blocking = false;
	l__workspace__1.ServerStuff.initiateblock:FireServer(v5, false);
	u9.turnable = true;
	u45 = tick();
	u46 = 1;
	u25(0.025);
	local v528 = { globalanimsets.stagger, tpglobalanimsets.stagger };
	if p67 == "vomit" then
		v528 = { globalanimsets.stun, tpglobalanimsets.sick };
		l__workspace__1.ServerStuff.applyGore:FireServer("vomit", character, nil, nil);
		local u88 = nil;
		u88 = v528[1].KeyframeReached:connect(function(p68)
			if p68 == "Stop" then
				v528[1]:AdjustSpeed(0);
				u88:Disconnect();
			end;
		end);
		u9.turnable = false;
	end;
	v528[1]:Play(0.1);
	v528[2]:Play(0.1);
	u11 = 0.001;
	local v529 = Instance.new("BlurEffect");
	v529.Size = 15;
	if p67 == "normal" then
		shakecamera("stagger");
		v529.Parent = l__CurrentCamera__1;
	end;
	local v530 = false;
	u87 = false;
	while true do
		v529.Size = v529.Size - 0.5;
		if u87 == true then
			if v530 == false then
				v530 = true;
				if v528[2].TimePosition < v528[2].Length - 0.4 then
					v528[1].TimePosition = v528[1].Length - 0.4;
					v528[2].TimePosition = v528[2].Length - 0.4;
				end;
			end;
		end;
		RS:wait();
		if v528[1].IsPlaying ~= false then

		else
			break;
		end;
		if v528[2].IsPlaying ~= false then

		else
			break;
		end;	
	end;
	if sprint_stam <= 0 then
		u11 = u12;
	else
		u11 = u13;
	end;
	u25(0.025);
	u87 = false;
	v529:Destroy();
	v528[1]:Stop(0.1);
	v528[2]:Stop();
	curentanimset.equip.TimePosition = 0.5;
	curentanimset.equip:AdjustSpeed(0);
	tpcurrentanimset.equip:Play();
	tpcurrentanimset.equip.TimePosition = 0.5;
	tpcurrentanimset.equip:AdjustSpeed(0);
	check_walking_anim();
	u9.action = false;
	u9.cancombo = true;
	u9.turnable = true;
	u9.staggering = false;
	u9.channel = false;
end;
function createfxoutline(p69, p70)
	local v531 = l__game__7.ReplicatedStorage.effects.outlineFx:Clone();
	local v532 = v531:FindFirstChild(p69);
	local v533, v534, v535 = ipairs(v531:GetChildren());
	while true do
		local v536, v537 = v533(v534, v535);
		if v536 then

		else
			break;
		end;
		v535 = v536;
		if v537:IsA("BasePart") then
			local v538 = v532:Clone();
			v538.Enabled = true;
			v538.Parent = v537;
		elseif v537 ~= v532 then
			if not v537:IsA("Folder") then
				v537:Destroy();
			end;
		end;	
	end;
	v531.CFrame = l__CurrentCamera__1.CFrame;
	v531.Parent = l__CurrentCamera__1;
	local v539 = Instance.new("Motor6D");
	v539.Part0 = v531;
	v539.Part1 = cpart;
	v539.C1 = CFrame.new(0, 0, -0.4) * CFrame.Angles(0, 0, 0);
	v539.Parent = v531;
	if p70 then
		delay(p70, function()
			local v540, v541, v542 = ipairs(v531:GetDescendants());
			while true do
				local v543, v544 = v540(v541, v542);
				if v543 then

				else
					break;
				end;
				v542 = v543;
				if v544:IsA("ParticleEmitter") then
					v544.Enabled = false;
				end;			
			end;
			l__Debris__27:AddItem(v531, v532.Lifetime.Min + 0.5);
		end);
	end;
	return v531;
end;
if startperk.Value == "hiddenB" then
	local v545 = l__game__7.ReplicatedStorage.effects.wraithFX:Clone();
	v545.CFrame = l__CurrentCamera__1.CFrame;
	v545.Parent = l__CurrentCamera__1;
	local v546 = Instance.new("Motor6D");
	v546.Part0 = v545;
	v546.Part1 = cpart;
	v546.C1 = CFrame.new(0, 0, -0.4) * CFrame.Angles(0, 0, 0);
	v546.Parent = v545;
end;
local u89 = 1;
local u90 = v184;
local function u91(p71)
	maingui.infectionalert.TextTransparency = 1;
	maingui.infectionalert.TextStrokeTransparency = maingui.infectionalert.TextTransparency;
	maingui.infectionalert.Text = "";
	local u92 = "Systemic Infection has reached Stage " .. p71 .. ".";
	spawn(function()
		local v547 = tick();
		local v548 = 0;
		local v549 = tick();
		while true do
			maingui.infectionalert.TextTransparency = 1 - (tick() - v547) / 2;
			maingui.infectionalert.TextStrokeTransparency = maingui.infectionalert.TextTransparency;
			if tick() - v549 > 0.1 then
				v549 = tick();
				v548 = v548 + 1;
				maingui.infectionalert.Text = string.sub(u92, 1, v548);
				if string.len(u92) <= v548 then
					maingui.infectionalert.Text = u92;
				end;
			end;
			RS:wait();
			if maingui.infectionalert.Text == u92 then
				break;
			end;		
		end;
		maingui.infectionalert.TextTransparency = 0;
		maingui.infectionalert.TextStrokeTransparency = maingui.infectionalert.TextTransparency;
		local v550 = tick();
		while true do
			RS:wait();
			if tick() - v550 >= 2 then
				break;
			end;		
		end;
		local v551 = tick();
		while true do
			maingui.infectionalert.TextTransparency = (tick() - v551) / 2;
			maingui.infectionalert.TextStrokeTransparency = maingui.infectionalert.TextTransparency;
			RS:wait();
			if tick() - v551 >= 2 then
				break;
			end;		
		end;
		maingui.infectionalert.TextTransparency = 1;
		maingui.infectionalert.TextStrokeTransparency = maingui.infectionalert.TextTransparency;
	end);
end;
local function u93()
	for v552, v553 in ipairs(maingui.HealthFrame.Statuses:GetChildren()) do
		if v553.Name ~= "Example" then
			v553.Position = UDim2.new(v552 - 0.7 + 0.1 * v552 - 2, 0, 0.5, 0);
		end;
	end;
end;
function afflictstatus(p72)
	if u10[p72.name] then
		u10[p72.name].effects.currentduration = tick();
		if p72.name ~= "Cripple" then
			if p72.name ~= "Bleed" then
				if p72.name ~= "Expose" then
					if p72.name == "Pierce" then
						if u10[p72.name].mainstats.intensity < p72.intensity then
							u10[p72.name].mainstats.intensity = p72.intensity;
							return;
						end;
					end;
				elseif u10[p72.name].mainstats.intensity < p72.intensity then
					u10[p72.name].mainstats.intensity = p72.intensity;
					return;
				end;
			elseif u10[p72.name].mainstats.intensity < p72.intensity then
				u10[p72.name].mainstats.intensity = p72.intensity;
				return;
			end;
		elseif u10[p72.name].mainstats.intensity < p72.intensity then
			u10[p72.name].mainstats.intensity = p72.intensity;
			return;
		end;
	else
		if playerperks.lead then
			if p72.name == "Vomit" then
				afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Rgn);
				return;
			end;
		end;
		local v554 = {
			effects = {
				corename = "", 
				currentloop = nil, 
				currentduration = tick(), 
				maxduration = 0, 
				currentgui = nil, 
				currentpos = 0, 
				ticks = {}, 
				colour = false
			}, 
			mainstats = {}
		};
		local v555, v556, v557 = pairs(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS));
		while true do
			local v558, v559 = v555(v556, v557);
			if v558 then

			else
				break;
			end;
			v557 = v558;
			if v559.name == p72.name then
				v554.effects.corename = v558;
				break;
			end;		
		end;
		v554.mainstats = p72;
		v554.effects.maxduration = v554.mainstats.dur;
		v554.effects.currentduration = tick();
		if p72.colour ~= nil then
			v554.effects.colour = p72.colour;
		end;
		local v560 = maingui.HealthFrame.Statuses.Example:Clone();
		v554.effects.currentgui = v560;
		v560.Name = v554.mainstats.name;
		local v561 = 0;
		v560.Icon.Image = "rbxassetid://" .. v554.mainstats.icon;
		v560.Visible = true;
		if v554.mainstats.name ~= "Death Morale 1" then
			if v554.mainstats.name ~= "Death Morale 2" then
				if v554.mainstats.name ~= "Death Morale 3" then
					if v554.mainstats.name ~= "Death Morale 4" then
						if v554.mainstats.name ~= "Arterial Bleed" then
							if v554.mainstats.name ~= "Toxins" then
								if v554.mainstats.name == "Artillerist Buff" then
									v560.EmptyBar.Visible = false;
									v560.textinsteadofbar.Visible = true;
									v560.textinsteadofbar.Text = "MORALE";
									if v554.mainstats.name == "Arterial Bleed" then
										v560.textinsteadofbar.Text = "ARTERY";
									elseif v554.mainstats.name == "Toxins" then
										v560.textinsteadofbar.Text = "TOXINS";
									elseif v554.mainstats.name == "Artillerist Buff" then
										v560.textinsteadofbar.Text = "DEADEYE";
									end;
								end;
							else
								v560.EmptyBar.Visible = false;
								v560.textinsteadofbar.Visible = true;
								v560.textinsteadofbar.Text = "MORALE";
								if v554.mainstats.name == "Arterial Bleed" then
									v560.textinsteadofbar.Text = "ARTERY";
								elseif v554.mainstats.name == "Toxins" then
									v560.textinsteadofbar.Text = "TOXINS";
								elseif v554.mainstats.name == "Artillerist Buff" then
									v560.textinsteadofbar.Text = "DEADEYE";
								end;
							end;
						else
							v560.EmptyBar.Visible = false;
							v560.textinsteadofbar.Visible = true;
							v560.textinsteadofbar.Text = "MORALE";
							if v554.mainstats.name == "Arterial Bleed" then
								v560.textinsteadofbar.Text = "ARTERY";
							elseif v554.mainstats.name == "Toxins" then
								v560.textinsteadofbar.Text = "TOXINS";
							elseif v554.mainstats.name == "Artillerist Buff" then
								v560.textinsteadofbar.Text = "DEADEYE";
							end;
						end;
					else
						v560.EmptyBar.Visible = false;
						v560.textinsteadofbar.Visible = true;
						v560.textinsteadofbar.Text = "MORALE";
						if v554.mainstats.name == "Arterial Bleed" then
							v560.textinsteadofbar.Text = "ARTERY";
						elseif v554.mainstats.name == "Toxins" then
							v560.textinsteadofbar.Text = "TOXINS";
						elseif v554.mainstats.name == "Artillerist Buff" then
							v560.textinsteadofbar.Text = "DEADEYE";
						end;
					end;
				else
					v560.EmptyBar.Visible = false;
					v560.textinsteadofbar.Visible = true;
					v560.textinsteadofbar.Text = "MORALE";
					if v554.mainstats.name == "Arterial Bleed" then
						v560.textinsteadofbar.Text = "ARTERY";
					elseif v554.mainstats.name == "Toxins" then
						v560.textinsteadofbar.Text = "TOXINS";
					elseif v554.mainstats.name == "Artillerist Buff" then
						v560.textinsteadofbar.Text = "DEADEYE";
					end;
				end;
			else
				v560.EmptyBar.Visible = false;
				v560.textinsteadofbar.Visible = true;
				v560.textinsteadofbar.Text = "MORALE";
				if v554.mainstats.name == "Arterial Bleed" then
					v560.textinsteadofbar.Text = "ARTERY";
				elseif v554.mainstats.name == "Toxins" then
					v560.textinsteadofbar.Text = "TOXINS";
				elseif v554.mainstats.name == "Artillerist Buff" then
					v560.textinsteadofbar.Text = "DEADEYE";
				end;
			end;
		else
			v560.EmptyBar.Visible = false;
			v560.textinsteadofbar.Visible = true;
			v560.textinsteadofbar.Text = "MORALE";
			if v554.mainstats.name == "Arterial Bleed" then
				v560.textinsteadofbar.Text = "ARTERY";
			elseif v554.mainstats.name == "Toxins" then
				v560.textinsteadofbar.Text = "TOXINS";
			elseif v554.mainstats.name == "Artillerist Buff" then
				v560.textinsteadofbar.Text = "DEADEYE";
			end;
		end;
		if v554.effects.colour ~= false then
			v560.EmptyBar.Bar.BackgroundColor3 = v554.effects.colour;
			v560.Icon.ImageColor3 = v554.effects.colour;
			v560.textinsteadofbar.TextColor3 = v554.effects.colour;
		end;
		v560.Parent = maingui.HealthFrame.Statuses;
		local v562, v563, v564 = pairs(u10);
		while true do
			local v565, v566 = v562(v563, v564);
			if v565 then

			else
				break;
			end;
			v564 = v565;
			v561 = v561 + 1;		
		end;
		v554.effects.currentpos = v561;
		if v554.mainstats.name ~= "Bleed" then
			if v554.mainstats.name ~= "Regeneration" then
				if v554.mainstats.name ~= "Arterial Bleed" then
					if v554.mainstats.name == "Fracture" then
						v554.effects.ticks[1] = 0;
					elseif v554.mainstats.name == "Vomit" then
						spawn(function()
							stagger("vomit");
						end);
					elseif v554.mainstats.name == "Blindness" then
						local v567 = l__game__7.ReplicatedStorage.effects.blackscreen:Clone();
						v567.Parent = maingui;
						v554.effects.ticks[1] = v567;
					elseif v554.mainstats.name ~= "Sickness" then
						if v554.mainstats.name == "Toxins" then
							if v554.mainstats.name == "Toxins" then
								local v568 = l__game__7.ReplicatedStorage.effects.sickcc:Clone();
							else
								v568 = l__game__7.ReplicatedStorage.effects.punjicc:Clone();
							end;
							v568.Parent = l__CurrentCamera__1;
							local v569 = Instance.new("BlurEffect");
							v569.Size = 0;
							v569.Parent = l__CurrentCamera__1;
							v554.effects.ticks[1] = { v568, v569, tick() };
							if v554.mainstats.name == "Sickness" then
								spawn(function()
									createfxoutline("sickParticle", v554.mainstats.dur);
								end);
							end;
							if v554.mainstats.name == "Toxins" then
								agent_speak("stormenter");
								local v570 = l__game__7.ReplicatedStorage.effects.stormfx_overlay:Clone();
								v570.CFrame = l__CurrentCamera__1.CFrame;
								v570.Parent = l__CurrentCamera__1;
								local v571 = Instance.new("Motor6D");
								v571.Part0 = v570;
								v571.Part1 = cpart;
								v571.C1 = CFrame.new(0, 0, -0.4) * CFrame.Angles(0, 0, 0);
								v571.Parent = v570;
								v554.effects.ticks[2] = v570;
								v554.effects.ticks[3] = tick();
							end;
						elseif v554.mainstats.name == "Tinnitus" then
							shakecamera("tinnitus");
							l__game__7:GetService("SoundService").regular.Volume = 0.3;
							local v572 = Instance.new("BlurEffect");
							v572.Size = 0;
							v572.Parent = l__CurrentCamera__1;
							local v573 = l__game__7.ReplicatedStorage.soundLibrary.general.earringing:Clone();
							v573.Looped = true;
							v573.Parent = l__CurrentCamera__1;
							v573:Play();
							v554.effects.ticks[1] = { v573, v572 };
						elseif v554.mainstats.name == "Berserk" then
							local v574 = l__game__7.ReplicatedStorage.effects.ragecc:Clone();
							v574.Parent = l__CurrentCamera__1;
							v554.effects.ticks[1] = { v574, v101({ "general" }, "doom", nil, nil, nil, true) };
							if playerstats.Settings.MuteMusic == true then
								v554.effects.ticks[1][2].Volume = 0;
							end;
						elseif v554.mainstats.name == "Snared" then
							local v575 = l__game__7.ReplicatedStorage.effects.snare:Clone();
							v575.Parent = maingui;
							u11 = 0.001;
							u9.turnable = false;
							v554.effects.ticks[1] = v575;
						elseif v554.mainstats.name == "Tracking Beacon" then
							v554.effects.ticks[1] = tick();
						elseif v554.mainstats.name ~= "Damage Buff" then
							if v554.mainstats.name == "Unwaivered" then
								u21 = u21 + v554.mainstats.ints[1] / 100;
								u58 = u58 + 1.2;
							elseif v554.mainstats.name == "Artillerist Buff" then
								u65 = u65 + v554.mainstats.ints[2] / 100;
								u73 = u73 + v554.mainstats.ints[1] / 100;
							elseif v554.mainstats.name == "Defense Buff" then
								u20 = u20 + v554.mainstats.ints[1] / 100;
							elseif v554.mainstats.name == "Susceptible" then
								u20 = u20 - v554.mainstats.ints[1] / 100;
							elseif v554.mainstats.name == "Armoured" then
								u20 = u20 + v554.mainstats.ints[1];
							elseif v554.mainstats.name ~= "Speed Buff" then
								if v554.mainstats.name == "Silencer" then
									v554.effects.ticks[1] = u13 * v554.mainstats.ints[1] / 100;
									u22 = u22 + v554.effects.ticks[1];
									u47 = u47 + 1;
									u51 = u51 + 1;
									u65 = u65 + 1.5;
								elseif v554.mainstats.name == "Exhausted" then
									u21 = u21 - v554.mainstats.ints[1];
								elseif v554.mainstats.name == "Respirator" then
									local v576 = l__game__7.ReplicatedStorage.misc.respOverlay:Clone();
									v576.Parent = maingui;
									v554.effects.ticks[1] = v576;
								elseif v554.mainstats.name == "Koldera Buff" then
									local v577 = l__game__7.ReplicatedStorage.auxItems.buffermodel:Clone();
									v577.CFrame = l__CurrentCamera__1.CFrame;
									v577.Parent = l__CurrentCamera__1;
									local v578 = Instance.new("Motor6D");
									v578.Part0 = v577;
									v578.Part1 = cpart;
									v578.C1 = CFrame.new(0, -0.8, -0.7) * CFrame.Angles(0, math.rad(90), 0);
									v578.Parent = v577;
									v554.effects.ticks[1] = v577;
									u21 = u21 + 0.1;
									u20 = u20 + 0.1;
									v554.effects.ticks[4] = u13 * 10 / 100;
									u22 = u22 + v554.effects.ticks[4];
									if not u10["Death Morale 1"] then
										if u10["Death Morale 2"] then
											u21 = u21 + 0.1;
											u20 = u20 + 0.1;
											v554.effects.ticks[3] = u13 * 10 / 100;
											u22 = u22 + v554.effects.ticks[3];
											v554.effects.ticks[2] = true;
										end;
									else
										u21 = u21 + 0.1;
										u20 = u20 + 0.1;
										v554.effects.ticks[3] = u13 * 10 / 100;
										u22 = u22 + v554.effects.ticks[3];
										v554.effects.ticks[2] = true;
									end;
									l__workspace__1.ServerStuff.quickDisplay:FireServer("add_buffer");
								elseif v554.mainstats.name == "Painkillers" then
									local v579 = l__game__7.ReplicatedStorage.effects.painkillers:Clone();
									v579.Parent = maingui;
									local v580 = l__game__7.ReplicatedStorage.misc.painkillersCC:Clone();
									v580.Parent = l__CurrentCamera__1;
									v554.effects.ticks[1] = v579;
									v554.effects.ticks[2] = v580;
									u20 = u20 + v554.mainstats.ints[1] / 100;
									maingui.HurtOverlay.Visible = false;
									maingui.HurtOverlayA.Visible = false;
									maingui.HurtOverlayB.Visible = false;
								elseif v554.mainstats.name == "Burning" then
									l__workspace__1.ServerStuff.playAudio:FireServer({ "status_fx" }, "burst", character.HumanoidRootPart);
									local v581 = l__game__7.ReplicatedStorage.effects.burnfx:Clone();
									v581.CFrame = l__CurrentCamera__1.CFrame;
									v581.Parent = l__CurrentCamera__1;
									local v582 = Instance.new("Motor6D");
									v582.Part0 = v581;
									v582.Part1 = cpart;
									v582.C1 = CFrame.new(0, 0, -0.6) * CFrame.Angles(0, 0, 0);
									v582.Parent = v581;
									local v583 = l__game__7.ReplicatedStorage.effects.fireCC:Clone();
									v583.Parent = l__CurrentCamera__1;
									v554.effects.ticks[1] = 0;
									v554.effects.ticks[2] = v581;
									v554.effects.ticks[3] = v583;
								elseif v554.mainstats.name == "Lazarus" then
									v101({ "perks" }, "laz_effect", nil, nil, true, true);
									local v584 = l__game__7.ReplicatedStorage.effects.lazarmfx:Clone();
									v584.Parent = fparms.RightArm.RLowerArm;
									local v585 = Instance.new("Weld");
									v585.Part0 = fparms.RightArm.RLowerArm;
									v585.Part1 = v584;
									v585.Parent = v584;
									local v586 = l__game__7.ReplicatedStorage.effects.lazarmfx:Clone();
									v586.Parent = fparms.RightArm.RUpperArm;
									local v587 = Instance.new("Weld");
									v587.Part0 = fparms.RightArm.RUpperArm;
									v587.Part1 = v586;
									v587.Parent = v586;
									local v588 = l__game__7.ReplicatedStorage.effects.lazarmfx:Clone();
									v588.Parent = fparms.LeftArm.LLowerArm;
									local v589 = Instance.new("Weld");
									v589.Part0 = fparms.LeftArm.LLowerArm;
									v589.Part1 = v588;
									v589.Parent = v588;
									local v590 = l__game__7.ReplicatedStorage.effects.lazarmfx:Clone();
									v590.Parent = fparms.LeftArm.LUpperArm;
									local v591 = Instance.new("Weld");
									v591.Part0 = fparms.LeftArm.LUpperArm;
									v591.Part1 = v590;
									v591.Parent = v590;
									v554.effects.ticks[1] = v584;
									v554.effects.ticks[2] = v586;
									v554.effects.ticks[3] = v588;
									v554.effects.ticks[4] = v590;
									v554.effects.ticks[5] = v101({ "perks" }, "laz_loop", nil, nil, nil, true);
									u21 = u21 + v554.mainstats.ints[1] / 100;
								elseif v554.mainstats.name == "Immolator Buff" then
									local v592 = l__game__7.ReplicatedStorage.effects.burnarm_fx:Clone();
									v592.Parent = fparms.RightArm.RLowerArm;
									local v593 = Instance.new("Weld");
									v593.Part0 = fparms.RightArm.RLowerArm;
									v593.Part1 = v592;
									v593.Parent = v592;
									local v594 = l__game__7.ReplicatedStorage.effects.burnarm_fx:Clone();
									v594.Parent = fparms.RightArm.RUpperArm;
									local v595 = Instance.new("Weld");
									v595.Part0 = fparms.RightArm.RUpperArm;
									v595.Part1 = v594;
									v595.Parent = v594;
									local v596 = l__game__7.ReplicatedStorage.effects.burnarm_fx:Clone();
									v596.Parent = fparms.LeftArm.LLowerArm;
									local v597 = Instance.new("Weld");
									v597.Part0 = fparms.LeftArm.LLowerArm;
									v597.Part1 = v596;
									v597.Parent = v596;
									local v598 = l__game__7.ReplicatedStorage.effects.burnarm_fx:Clone();
									v598.Parent = fparms.LeftArm.LUpperArm;
									local v599 = Instance.new("Weld");
									v599.Part0 = fparms.LeftArm.LUpperArm;
									v599.Part1 = v598;
									v599.Parent = v598;
									v554.effects.ticks[1] = v592;
									v554.effects.ticks[2] = v594;
									v554.effects.ticks[3] = v596;
									v554.effects.ticks[4] = v598;
								end;
							else
								v554.effects.ticks[1] = u13 * v554.mainstats.ints[1] / 100;
								u22 = u22 + v554.effects.ticks[1];
								u47 = u47 + 1;
								u51 = u51 + 1;
								u65 = u65 + 1.5;
							end;
						else
							u21 = u21 + v554.mainstats.ints[1] / 100;
							u58 = u58 + 1.2;
						end;
					else
						if v554.mainstats.name == "Toxins" then
							v568 = l__game__7.ReplicatedStorage.effects.sickcc:Clone();
						else
							v568 = l__game__7.ReplicatedStorage.effects.punjicc:Clone();
						end;
						v568.Parent = l__CurrentCamera__1;
						v569 = Instance.new("BlurEffect");
						v569.Size = 0;
						v569.Parent = l__CurrentCamera__1;
						v554.effects.ticks[1] = { v568, v569, tick() };
						if v554.mainstats.name == "Sickness" then
							spawn(function()
								createfxoutline("sickParticle", v554.mainstats.dur);
							end);
						end;
						if v554.mainstats.name == "Toxins" then
							agent_speak("stormenter");
							v570 = l__game__7.ReplicatedStorage.effects.stormfx_overlay:Clone();
							v570.CFrame = l__CurrentCamera__1.CFrame;
							v570.Parent = l__CurrentCamera__1;
							v571 = Instance.new("Motor6D");
							v571.Part0 = v570;
							v571.Part1 = cpart;
							v571.C1 = CFrame.new(0, 0, -0.4) * CFrame.Angles(0, 0, 0);
							v571.Parent = v570;
							v554.effects.ticks[2] = v570;
							v554.effects.ticks[3] = tick();
						end;
					end;
				else
					v554.effects.ticks[1] = 0;
				end;
			else
				v554.effects.ticks[1] = 0;
			end;
		else
			v554.effects.ticks[1] = 0;
		end;
		if v554.mainstats.name ~= "Virus Stage 2" then
			if v554.mainstats.name ~= "Virus Stage 3" then
				if v554.mainstats.name == "Virus Stage 4" then
					v554.effects.ticks[1] = u13 * v554.mainstats.ints[1] / 100;
					u22 = u22 - v554.effects.ticks[1];
					if v554.mainstats.name ~= "Virus Stage 2" then
						u20 = u20 - v554.mainstats.ints[2] / 100;
					end;
					l__workspace__1.ServerStuff.dealDamage:FireServer("virusmaxhealth", v554.mainstats.name, v5, v4);
					if v554.mainstats.name == "Virus Stage 4" then
						v554.effects.ticks[2] = tick();
					end;
				end;
			else
				v554.effects.ticks[1] = u13 * v554.mainstats.ints[1] / 100;
				u22 = u22 - v554.effects.ticks[1];
				if v554.mainstats.name ~= "Virus Stage 2" then
					u20 = u20 - v554.mainstats.ints[2] / 100;
				end;
				l__workspace__1.ServerStuff.dealDamage:FireServer("virusmaxhealth", v554.mainstats.name, v5, v4);
				if v554.mainstats.name == "Virus Stage 4" then
					v554.effects.ticks[2] = tick();
				end;
			end;
		else
			v554.effects.ticks[1] = u13 * v554.mainstats.ints[1] / 100;
			u22 = u22 - v554.effects.ticks[1];
			if v554.mainstats.name ~= "Virus Stage 2" then
				u20 = u20 - v554.mainstats.ints[2] / 100;
			end;
			l__workspace__1.ServerStuff.dealDamage:FireServer("virusmaxhealth", v554.mainstats.name, v5, v4);
			if v554.mainstats.name == "Virus Stage 4" then
				v554.effects.ticks[2] = tick();
			end;
		end;
		if v554.mainstats.name ~= "Death Morale 1" then
			if v554.mainstats.name ~= "Death Morale 2" then
				if v554.mainstats.name ~= "Death Morale 3" then
					if v554.mainstats.name == "Death Morale 4" then
						u21 = u21 - v554.mainstats.ints[1] / 100;
						u20 = u20 - v554.mainstats.ints[2] / 100;
						u22 = u22 - u13 * v554.mainstats.ints[3] / 100;
						local v600 = l__game__7.ReplicatedStorage.effects.moralevignette:Clone();
						v600.Parent = maingui;
						v554.effects.ticks[1] = v600;
					end;
				else
					u21 = u21 - v554.mainstats.ints[1] / 100;
					u20 = u20 - v554.mainstats.ints[2] / 100;
					u22 = u22 - u13 * v554.mainstats.ints[3] / 100;
					v600 = l__game__7.ReplicatedStorage.effects.moralevignette:Clone();
					v600.Parent = maingui;
					v554.effects.ticks[1] = v600;
				end;
			else
				u21 = u21 - v554.mainstats.ints[1] / 100;
				u20 = u20 - v554.mainstats.ints[2] / 100;
				u22 = u22 - u13 * v554.mainstats.ints[3] / 100;
				v600 = l__game__7.ReplicatedStorage.effects.moralevignette:Clone();
				v600.Parent = maingui;
				v554.effects.ticks[1] = v600;
			end;
		else
			u21 = u21 - v554.mainstats.ints[1] / 100;
			u20 = u20 - v554.mainstats.ints[2] / 100;
			u22 = u22 - u13 * v554.mainstats.ints[3] / 100;
			v600 = l__game__7.ReplicatedStorage.effects.moralevignette:Clone();
			v600.Parent = maingui;
			v554.effects.ticks[1] = v600;
		end;
		v554.effects.currentloop = RS:connect(function()
			if v554.mainstats.name == "Cripple" then
				u89 = 1 - 1 * v554.mainstats.ints[v554.mainstats.intensity] / 100;
			elseif v554.mainstats.name == "Bleed" then
				if v554.mainstats.ints[v554.mainstats.intensity] < tick() - v554.effects.ticks[1] then
					if l__workspace__1.ServerStuff.game.disableInteraction.Value == false then
						if 1 < hum.Health then
							v554.effects.ticks[1] = tick();
							l__workspace__1.ServerStuff.dealDamage:FireServer("bleed", nil, v5, v4);
							l__workspace__1.ServerStuff.applyGore:FireServer("bleed", character, nil, { 1, nil });
						end;
					end;
				end;
			elseif v554.mainstats.name == "Fracture" then
				if 0.1 < tick() - v554.effects.ticks[1] then
					v554.effects.ticks[1] = tick();
					u90 = CFrame.new(math.random(-10, 10) / 1000, math.random(-10, 10) / 1000, math.random(-10, 10) / 1000);
				end;
			elseif v554.mainstats.name == "Speed Buff" then
				sprint_stam = 100;
				if u10.Exhaustion then
					u10.Exhaustion.effects.currentduration = 0;
				end;
			elseif v554.mainstats.name == "Exhaustion" then
				if u10["Speed Buff"] == nil then
					sprint_stam = 0;
				end;
			elseif v554.mainstats.name == "Arterial Bleed" then
				if v554.mainstats.ints[1] < tick() - v554.effects.ticks[1] then
					if l__workspace__1.ServerStuff.game.disableInteraction.Value == false then
						v554.effects.ticks[1] = tick();
						l__workspace__1.ServerStuff.dealDamage:FireServer("bleed", nil, v5, v4);
						l__workspace__1.ServerStuff.applyGore:FireServer("bleed", character, nil, { 1, nil });
						local v601 = l__game__7.ReplicatedStorage.effects.blood_drop:Clone();
						v601.Position = UDim2.new(math.random(15, 95) / 100, 0, math.random(15, 95) / 100, 0);
						v601.Rotation = math.random(0, 360);
						v601.Parent = maingui;
						spawn(function()
							while true do
								v601.ImageTransparency = v601.ImageTransparency + 0.01;
								RS:wait();
								if not (1 <= v601.ImageTransparency) then

								else
									break;
								end;							
							end;
							v601:Destroy();
						end);
					end;
				end;
				if u10["Bleed Prevention"] == nil then
					local l__Bld__602 = require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Bld;
					l__Bld__602.intensity = 4;
					afflictstatus(l__Bld__602);
				end;
			elseif v554.mainstats.name == "Burning" then
				if u10["Immolator Buff"] == nil then
					if v57 == false then
						u14.regentick = tick();
						if v554.mainstats.ints[1] < tick() - v554.effects.ticks[1] then
							v554.effects.ticks[1] = tick();
							l__workspace__1.ServerStuff.dealDamage:FireServer("burning", nil, v5, v4);
						end;
					end;
				end;
			elseif v554.mainstats.name == "Immolator Buff" then
				afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Brn);
				if u10.Burning then
					u10.Burning.effects.ticks[1] = tick();
				end;
			elseif v554.mainstats.name == "Lazarus" then
				afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Pnk);
			elseif v554.mainstats.name == "Toxins" then
				if v554.mainstats.ints[2] < tick() - v554.effects.ticks[1][3] then
					if 0 < hum.Health then
						v554.effects.ticks[1][3] = tick();
						if u10.Respirator == nil then
							l__workspace__1.ServerStuff.dealDamage:FireServer("toxicated", nil, v5, v4);
						end;
						if 30 <= tick() - v554.effects.ticks[3] then
							l__workspace__1.ServerStuff.dealDamage:FireServer("toxicdead", nil, v5, v4);
						end;
					end;
				end;
			elseif v554.mainstats.name == "Regeneration" then
				if 1 < tick() - v554.effects.ticks[1] then
					if hum.Health < hum.MaxHealth then
						v554.effects.ticks[1] = tick();
						if u10.Toxins == nil then
							l__workspace__1.ServerStuff.dealDamage:FireServer(v554.mainstats.name, nil, v5, v4);
						end;
					end;
				end;
			elseif v554.mainstats.name == "Stamina Buff" then
				if 0.5 < tick() - u14.stamregen then
					u8 = v62;
					u26("stamina");
				end;
			elseif v554.mainstats.name == "Tracking Beacon" then
				if u9.walking == false then
					if v554.mainstats.ints[1] <= tick() - v554.effects.ticks[1] then
						v554.effects.currentduration = 0;
					end;
				else
					v554.effects.ticks[1] = tick();
				end;
			elseif v554.mainstats.name == "Blindness" then
				v554.effects.ticks[1].BackgroundTransparency = (tick() - v554.effects.currentduration) / 2 / v554.effects.maxduration;
			elseif v554.mainstats.name == "Bleed Prevention" then
				if u10.Bleed then
					u10.Bleed.effects.currentduration = 0;
				end;
			elseif v554.mainstats.name == "Cripple Prevention" then
				if u10.Cripple then
					u10.Cripple.effects.currentduration = 0;
				end;
				if u10.Fracture then
					u10.Fracture.effects.currentduration = 0;
				end;
			elseif v554.mainstats.name == "Virus Stage 4" then
				if v554.mainstats.ints[4] <= tick() - v554.effects.ticks[2] then
					v554.effects.ticks[2] = tick();
					afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Tnt);
				end;
			elseif v554.mainstats.name == "Painkillers" then
				v554.effects.ticks[1].ImageTransparency = v554.effects.ticks[1].ImageTransparency + (math.cos(time() * 2) * 0.5 - v554.effects.ticks[1].ImageTransparency) * 0.025 + 0.1;
			elseif v554.mainstats.name ~= "Sickness" then
				if v554.mainstats.name ~= "Toxins" then
					if v554.mainstats.name == "Tinnitus" then
						v554.effects.ticks[1][2].Size = math.sin(time() * 3) * 5 + 8;
					elseif v554.mainstats.name == "Silencer" then
						if u10.Cripple then
							u10.Cripple.effects.currentduration = 0;
						end;
						if u10.Bleed then
							u10.Bleed.effects.currentduration = 0;
						end;
					end;
				else
					v554.effects.ticks[1][2].Size = math.sin(time() * 3) * 5 + 8;
				end;
			else
				v554.effects.ticks[1][2].Size = math.sin(time() * 3) * 5 + 8;
			end;
			v554.effects.currentgui.EmptyBar.Bar.Size = UDim2.new((v554.effects.maxduration - (tick() - v554.effects.currentduration)) / v554.effects.maxduration, 0, 1, 0);
			if v554.effects.maxduration < tick() - v554.effects.currentduration then
				v554.effects.currentloop:Disconnect();
				v554.effects.currentgui:Destroy();
				if v554.mainstats.name == "Cripple" then
					u89 = 1;
				end;
				if v554.mainstats.name ~= "Damage Buff" then
					if v554.mainstats.name == "Unwaivered" then
						u21 = u21 - v554.mainstats.ints[1] / 100;
						afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Tnt);
						u58 = u58 - 1.2;
					elseif v554.mainstats.name == "Defense Buff" then
						u20 = u20 - v554.mainstats.ints[1] / 100;
						afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Tnt);
					elseif v554.mainstats.name == "Susceptible" then
						u20 = u20 + v554.mainstats.ints[1] / 100;
					elseif v554.mainstats.name == "Armoured" then
						u20 = u20 - v554.mainstats.ints[1];
						l__workspace__1.ServerStuff.dealDamage:FireServer("removearmour", nil, v5, v4);
					elseif v554.mainstats.name ~= "Speed Buff" then
						if v554.mainstats.name == "Silencer" then
							u22 = u22 - v554.effects.ticks[1];
							afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Tnt);
							u47 = u47 - 1;
							u51 = u51 - 1;
							u65 = u65 - 1.5;
						elseif v554.mainstats.name ~= "Death Morale 1" then
							if v554.mainstats.name ~= "Death Morale 2" then
								if v554.mainstats.name ~= "Death Morale 3" then
									if v554.mainstats.name == "Death Morale 4" then
										u21 = u21 + v554.mainstats.ints[1] / 100;
										u20 = u20 + v554.mainstats.ints[2] / 100;
										u22 = u22 + u13 * v554.mainstats.ints[3] / 100;
										v554.effects.ticks[1]:Destroy();
									elseif v554.mainstats.name == "Stamina Buff" then
										afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Tnt);
									elseif v554.mainstats.name == "Respirator" then
										tpglobalanimsets.aux_resp_off:Play(0.1);
										v101({ "aux" }, "resp_remove", nil, nil, true, true);
										v554.effects.ticks[1]:Destroy();
										globalanimsets.aux_resp_remove:Play(0.1, 1, 1);
									elseif v554.mainstats.name == "Koldera Buff" then
										l__workspace__1.ServerStuff.quickDisplay:FireServer("remove_buffer");
										tpglobalanimsets.aux_resp_off:Play(0.1);
										v554.effects.ticks[1]:Destroy();
										globalanimsets.aux_resp_remove:Play(0.1, 1, 1);
										u21 = u21 - 0.1;
										u20 = u20 - 0.1;
										u22 = u22 - v554.effects.ticks[4];
										if v554.effects.ticks[2] == true then
											u21 = u21 - 0.1;
											u20 = u20 - 0.1;
											u22 = u22 - v554.effects.ticks[3];
										end;
									elseif v554.mainstats.name == "Burning" then
										l__workspace__1.ServerStuff.playAudio:FireServer({ "status_fx" }, "extinguish", character.HumanoidRootPart);
										l__workspace__1.ServerStuff.dealDamage:FireServer("burningstop", nil, v5, v4);
										if v554.effects.ticks[2] then
											if v554.effects.ticks[2]:FindFirstChild("outline1") then
												l__Debris__27:AddItem(v554.effects.ticks[2], 5);
												local v603, v604, v605 = ipairs(v554.effects.ticks[2].outline1:GetChildren());
												while true do
													local v606, v607 = v603(v604, v605);
													if v606 then

													else
														break;
													end;
													v605 = v606;
													v607.Enabled = false;												
												end;
											end;
										end;
										v554.effects.ticks[3]:Destroy();
									elseif v554.mainstats.name == "Blindness" then
										v554.effects.ticks[1]:Destroy();
									elseif v554.mainstats.name == "Exhausted" then
										u21 = u21 + v554.mainstats.ints[1];
									elseif v554.mainstats.name == "Exhaustion" then
										sprint_stam = 10;
									elseif v554.mainstats.name == "Artillerist Buff" then
										u65 = u65 - v554.mainstats.ints[2] / 100;
										u73 = u73 - v554.mainstats.ints[1] / 100;
									elseif v554.mainstats.name ~= "Sickness" then
										if v554.mainstats.name == "Toxins" then
											v554.effects.ticks[1][1]:Destroy();
											v554.effects.ticks[1][2]:Destroy();
											if v554.mainstats.name == "Sickness" then
												afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Vcd);
											else
												v554.effects.ticks[2]:Destroy();
												agent_speak("stormleave");
											end;
										elseif v554.mainstats.name ~= "Berserk" then
											if v554.mainstats.name == "Tinnitus" then
												v554.effects.ticks[1][1]:Destroy();
												v554.effects.ticks[1][2]:Destroy();
												l__game__7:GetService("SoundService").regular.Volume = 1;
											elseif v554.mainstats.name == "Tracking Beacon" then
												l__workspace__1.ServerStuff.dealDamage:FireServer("removealarm", nil, v5, v4);
											elseif v554.mainstats.name == "Showdown" then
												if u36.nowinshowdown == true then
													l__workspace__1.ServerStuff.callEvent:FireServer();
												end;
											elseif v554.mainstats.name == "Fracture" then
												u90 = CFrame.new(0, 0, 0);
											elseif v554.mainstats.name == "Painkillers" then
												v554.effects.ticks[1]:Destroy();
												v554.effects.ticks[2]:Destroy();
												maingui.HurtOverlay.Visible = true;
												maingui.HurtOverlayA.Visible = true;
												maingui.HurtOverlayB.Visible = true;
												v101({ "weapons", "Item" }, "adrenal", nil, nil, true, true);
												u20 = u20 - v554.mainstats.ints[1] / 100;
											elseif v554.mainstats.name == "Lazarus" then
												v554.effects.ticks[1]:Destroy();
												v554.effects.ticks[2]:Destroy();
												v554.effects.ticks[3]:Destroy();
												v554.effects.ticks[4]:Destroy();
												v554.effects.ticks[5]:Destroy();
												u21 = u21 - v554.mainstats.ints[1] / 100;
												if u10.Painkillers then
													u10.Painkillers.effects.currentduration = 0;
												end;
											elseif v554.mainstats.name == "Immolator Buff" then
												if u10.Burning then
													u10.Burning.effects.currentduration = 0;
												end;
												v554.effects.ticks[1]:Destroy();
												v554.effects.ticks[2]:Destroy();
												v554.effects.ticks[3]:Destroy();
												v554.effects.ticks[4]:Destroy();
											elseif v554.mainstats.name == "Snared" then
												if u9.staggering == false then
													if u9.channel == false then
														if sprint_stam <= 0 then
															u11 = u12;
														else
															u11 = u13;
														end;
														u9.turnable = true;
														v554.effects.ticks[1]:Destroy();
													end;
												end;
											end;
										else
											v554.effects.ticks[1][1]:Destroy();
											v554.effects.ticks[1][2]:Destroy();
											l__game__7:GetService("SoundService").regular.Volume = 1;
										end;
									else
										v554.effects.ticks[1][1]:Destroy();
										v554.effects.ticks[1][2]:Destroy();
										if v554.mainstats.name == "Sickness" then
											afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Vcd);
										else
											v554.effects.ticks[2]:Destroy();
											agent_speak("stormleave");
										end;
									end;
								else
									u21 = u21 + v554.mainstats.ints[1] / 100;
									u20 = u20 + v554.mainstats.ints[2] / 100;
									u22 = u22 + u13 * v554.mainstats.ints[3] / 100;
									v554.effects.ticks[1]:Destroy();
								end;
							else
								u21 = u21 + v554.mainstats.ints[1] / 100;
								u20 = u20 + v554.mainstats.ints[2] / 100;
								u22 = u22 + u13 * v554.mainstats.ints[3] / 100;
								v554.effects.ticks[1]:Destroy();
							end;
						else
							u21 = u21 + v554.mainstats.ints[1] / 100;
							u20 = u20 + v554.mainstats.ints[2] / 100;
							u22 = u22 + u13 * v554.mainstats.ints[3] / 100;
							v554.effects.ticks[1]:Destroy();
						end;
					else
						u22 = u22 - v554.effects.ticks[1];
						afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Tnt);
						u47 = u47 - 1;
						u51 = u51 - 1;
						u65 = u65 - 1.5;
					end;
				else
					u21 = u21 - v554.mainstats.ints[1] / 100;
					afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Tnt);
					u58 = u58 - 1.2;
				end;
				if v554.mainstats.name == "Virus Stage 1" then
					afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).VirusB);
					u91(2);
				elseif v554.mainstats.name == "Virus Stage 2" then
					afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).VirusC);
					u91(3);
					u22 = u22 + v554.effects.ticks[1];
				elseif v554.mainstats.name == "Virus Stage 3" then
					afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).VirusD);
					u91(4);
					u22 = u22 + v554.effects.ticks[1];
					u20 = u20 + v554.mainstats.ints[2] / 100;
				elseif v554.mainstats.name == "Virus Stage 4" then
					l__workspace__1.ServerStuff.dealDamage:FireServer("sepsis", nil, v5, v4);
				end;
				u10[v554.mainstats.name] = nil;
				u93();
			end;
		end);
		u10[v554.mainstats.name] = v554;
		u93();
	end;
end;
l__workspace__1.ServerStuff.flinchTarget.OnClientEvent:Connect(function(p73, p74, p75, p76)
	if p73 == character.Torso or p73:FindFirstChild("RootJoint") == nil then
		return;
	end;
	local v608 = math.clamp(p76 * 2, 3, 35);
	if p75 > 80 then
		v608 = -v608;
	end;
	if p75 > 80 then
		p75 = 0;
	end;
	p75 = math.clamp(p75, -40, 40);
	for v609 = 1, 60 do
		if p73:FindFirstChild("Left Hip") == nil then
			break;
		end;
		if v609 < 5 then
			p74.RootJoint.C0 = p74.RootJoint.C0:lerp(CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0) * CFrame.Angles(math.rad(-v608), 0, 0) * CFrame.Angles(0, 0, math.rad(p75)), 0.5);
			p73["Right Hip"].C0 = p73["Right Hip"].C0:lerp(CFrame.new(1, -1, 0, -4.37113883E-08, 0, 1, -0, 0.99999994, 0, -1, 0, -4.37113883E-08) * CFrame.Angles(0, math.rad(-p75), 0) * CFrame.Angles(0, 0, math.rad(-v608)), 0.5);
			p73["Left Hip"].C0 = p73["Left Hip"].C0:lerp(CFrame.new(-1, -1, 0, -4.37113883E-08, 0, -1, 0, 0.99999994, 0, 1, 0, -4.37113883E-08) * CFrame.Angles(0, math.rad(p75), 0) * CFrame.Angles(0, 0, math.rad(v608)), 0.5);
		else
			p74.RootJoint.C0 = p74.RootJoint.C0:lerp(CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0) * CFrame.Angles(0, 0, 0), 0.075);
			p73["Right Hip"].C0 = p73["Right Hip"].C0:lerp(CFrame.new(1, -1, 0, -4.37113883E-08, 0, 1, -0, 0.99999994, 0, -1, 0, -4.37113883E-08) * CFrame.Angles(0, 0, 0), 0.075);
			p73["Left Hip"].C0 = p73["Left Hip"].C0:lerp(CFrame.new(-1, -1, 0, -4.37113883E-08, 0, -1, 0, 0.99999994, 0, 1, 0, -4.37113883E-08) * CFrame.Angles(0, 0, 0), 0.075);
		end;
		RS:wait();
	end;
end);
clotting = 0;
clottingwound = nil;
hiddeneyescooldown = tick();
shadowForm = false;
function shadowrespawnflash()
	if shadowForm == false then
		return;
	end;
	v101({ "gamemode" }, "shadowchosen", nil, nil, true, true);
	local v610 = Instance.new("Frame");
	v610.BorderSizePixel = 0;
	v610.BackgroundColor3 = Color3.new(0.9, 0, 0);
	v610.Size = UDim2.new(1, 0, 1, 0);
	v610.ZIndex = 100;
	v610.Parent = maingui;
	while true do
		v610.BackgroundTransparency = v610.BackgroundTransparency + 0.025;
		RS:wait();
		if not (1 <= v610.BackgroundTransparency) then

		else
			break;
		end;	
	end;
	v610:Destroy();
end;
local u94 = false;
local function u95(p77, p78, p79)
	local l__clientmusic__611 = l__workspace__1.clientmusic;
	while true do
		l__clientmusic__611.Volume = l__clientmusic__611.Volume - 0.05;
		RS:wait();
		if l__clientmusic__611.Volume <= 0 then
			break;
		end;	
	end;
	l__clientmusic__611:Stop();
	if playerstats.Settings.MuteMusic == true and p78 == nil then
		return;
	end;
	l__clientmusic__611.SoundId = p77;
	l__clientmusic__611:Play();
	local v612 = 0.5;
	if p79 then
		v612 = p79;
	end;
	while true do
		l__clientmusic__611.Volume = l__clientmusic__611.Volume + 0.05;
		RS:wait();
		if v612 <= l__clientmusic__611.Volume then
			break;
		end;	
	end;
	l__clientmusic__611.Volume = v612;
end;
l__workspace__1.ServerStuff.handleClientAudio.OnClientEvent:Connect(function(p80, p81, p82)
	if p80 == "music" then
		if p81 ~= "roam" then
			if p81 == "combat" then
				u95(l__game__7.ReplicatedStorage.soundLibrary.songs:FindFirstChild("fight" .. math.random(1, 4)).SoundId, nil, 0.8);
				return;
			elseif p81 == "boss" then
				u95(l__game__7.ReplicatedStorage.soundLibrary.songs.scavfinal.SoundId, nil, 2);
				return;
			elseif p81 == "ultima" then
				u95(l__game__7.ReplicatedStorage.soundLibrary.songs.final.SoundId, true, 1.5);
				return;
			else
				return;
			end;
		end;
	elseif p80 == "player_morale" then
		v101({ "general" }, "deathwhisper", nil, nil, true, true);
		agent_speak("down", true);
		if v61 == true then
			return;
		else
			u94 = true;
			if u10["Death Morale 4"] ~= nil then
				return;
			elseif u10["Death Morale 3"] ~= nil then
				afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).DMoraleD);
				return;
			elseif u10["Death Morale 2"] ~= nil then
				afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).DMoraleC);
				return;
			elseif u10["Death Morale 1"] ~= nil then
				afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).DMoraleB);
				return;
			else
				afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).DMoraleA);
				return;
			end;
		end;
	else
		return;
	end;
	if u10.Toxins then
		u10.Toxins.effects.currentduration = 0;
	end;
	if u94 == true then
		u94 = false;
	else
		if u10["Death Morale 1"] then
			u10["Death Morale 1"].effects.currentduration = 0;
		end;
		if u10["Death Morale 2"] then
			u10["Death Morale 2"].effects.currentduration = 0;
		end;
		if u10["Death Morale 3"] then
			u10["Death Morale 3"].effects.currentduration = 0;
		end;
		if u10["Death Morale 4"] then
			u10["Death Morale 4"].effects.currentduration = 0;
		end;
	end;
	if all_aux[aux_name] then
		current_aux = all_aux[aux_name];
		aux_usage = current_aux.use_per_night;
	end;
	for v613, v614 in ipairs(maingui.UpperLower.auxcount:GetChildren()) do
		if v614.Name ~= "ex" then
			if tonumber(string.sub(v614.Name, 4, 6)) <= aux_usage then
				v614.inner.Visible = true;
			else
				v614.inner.Visible = false;
			end;
			if aux_usage == 0 then
				v614.inner.Visible = false;
			end;
		end;
	end;
	commendedplayer = {};
	commendedcount = 2;
	if p82 and p82 == "scavwar" then
		u95(l__game__7.ReplicatedStorage.soundLibrary.songs.scavwar.SoundId, nil, 1.2);
		return;
	end;
	u95(l__game__7.ReplicatedStorage.soundLibrary.songs:FindFirstChild("roam" .. math.random(1, 4)).SoundId);
end);
alertplaytimer = 0;
alertplay = nil;
function convertToShadow()
	if shadowForm == true then
		return;
	end;
	teamfolder = character.Parent;
	spawn(shadowrespawnflash);
	playerperks = {};
	perksactive = {};
	u21 = u21 + 1.7;
	nametag = "Reikgon's Shadow";
	spawn(function()
		alertplay("YOUR SOUL BELONGS TO REIKGON");
		delay(3, function()
			alertplay("REAP THEIR SOULS FOR REIKGON");
		end);
	end);
	spawn(function()
		local v615, v616, v617 = pairs(u10);
		while true do
			local v618, v619 = v615(v616, v617);
			if v618 then

			else
				break;
			end;
			v617 = v618;
			v619.effects.currentduration = 0;		
		end;
	end);
	v101({ "gamemode" }, "shadowidle", nil, nil, nil, true).Looped = true;
	l__game__7.ReplicatedStorage.effects.hiddenlight:Clone().Parent = character.Head;
	if character:FindFirstChild("HumanoidRootPart") then
		if character.HumanoidRootPart:FindFirstChild("flashpoint") then
			if character.HumanoidRootPart:FindFirstChild("flashpoint").Enabled == true then
				l__workspace__1.ServerStuff.toggleFlashlight:FireServer();
			end;
		end;
	end;
	spawn(function()
		u80("ShadowArms");
	end);
	local v620 = l__game__7.ReplicatedStorage.effects.wraithFX:Clone();
	v620.CFrame = l__CurrentCamera__1.CFrame;
	v620.Parent = l__CurrentCamera__1;
	local v621 = Instance.new("Motor6D");
	v621.Part0 = v620;
	v621.Part1 = cpart;
	v621.C1 = CFrame.new(0, 0, -0.4) * CFrame.Angles(0, 0, 0);
	v621.Parent = v620;
	shadowForm = true;
	if u19 then
		u19:Destroy();
	end;
	local v622, v623, v624 = pairs(v6);
	while true do
		local v625, v626 = v622(v623, v624);
		if v625 then

		else
			break;
		end;
		v624 = v625;
		v626[1] = "Fist";
		v626[3] = nil;	
	end;
	l__workspace__1.ServerStuff.useupItem:FireServer();
	u61("Fist");
	maingui.InventoryFrame.Visible = false;
	maingui.StaminaFrame.Visible = false;
	maingui.HealthFrame.Visible = false;
	invmanage("updatehud");
end;
local function u96(p83)
	if juggernaut == true then
		return;
	end;
	if u17.name == u23 or u10.Unwaivered then
		return;
	end;
	if hum.Health <= 0 or u9.swinging == true then
		return;
	end;
	if u9.action == true or u9.swapping == true then
		return;
	end;
	if tick() - drawlockout <= 0.5 then
		return;
	end;
	local v627 = false;
	remove_dual_wield();
	u23 = u17.name;
	local v628 = nil;
	for v629, v630 in pairs(v6) do
		if v630[2] == true and v630[3] ~= nil then
			v628 = v630[3];
		end;
	end;
	if u19:FindFirstChild("trapped") then
		v628 = "trapped";
	end;
	u19:Destroy();
	invmanage("updatehud");
	local v631 = nil;
	for v632, v633 in pairs(v6) do
		if v633[2] == true and v633[4] ~= nil then
			v631 = v633[4];
			v633[4] = nil;
			break;
		end;
	end;
	if v631 ~= nil then
		v628 = "AGENT" .. v631;
	end;
	RS:wait();
	for v634, v635 in pairs(v6) do
		if v635[2] == true and v635[1] == "Fist" then
			v627 = true;
		end;
	end;
	if v627 == false then
		for v636, v637 in pairs(v6) do
			if v637[2] == true then
				v637[1] = "Fist";
				v637[3] = nil;
				if v636 == 1 then
					primskin = nil;
				end;
			end;
		end;
		l__workspace__1.ServerStuff.throwWeapon:FireServer(u18, nil, l__CurrentCamera__1.CFrame, "drop", u17, v628, v6[1][2], v5, p83, v4);
		u61("Fist");
	end;
end;
local u97 = false;
function getPstats(p84)
	return l__workspace__1.ServerStuff.relayStats:InvokeServer(p84);
end;
crackcd = 0;
specialcrackcd = 0;
ping_cooldown = tick();
ping_amt = 0;
ping_chill = tick();
ping_chill_timer = 3;
ping_chll_limit = 5;
current_in_echo = false;
l__workspace__1.ServerStuff.dealDamage.OnClientEvent:Connect(function(p85, p86, p87, p88, p89, p90)
	local v638 = nil;
	if p86 then
		local v639 = CFrame.new(l__CurrentCamera__1.Focus.p, l__CurrentCamera__1.Focus.p + Vector3.new(l__CurrentCamera__1.CoordinateFrame.lookVector.x, 0, l__CurrentCamera__1.CoordinateFrame.lookVector.z).unit):inverse() * p86.HumanoidRootPart.Position;
		local l__unit__640 = Vector3.new(v639.x, v639.z).unit;
		v638 = math.deg(math.atan2(l__unit__640.y * 200, l__unit__640.x * 200)) + 90;
	end;
	if typeof(p87) ~= "string" then
		local v641 = p87 / 35;
		local v642 = math.clamp(3 - v641 * 2, 0.75, 3);
		local v643 = math.clamp(v641, 0.05, 0.8);
		if p88 > 0 then
			if hum.Health <= 15 and tick() - AGENT_debounces.low_health >= 15 then
				AGENT_debounces.low_health = tick();
				agent_speak("lowhealth", true);
			end;
			if p86 ~= character and u9.blocking == false then
				tpglobalanimsets.damage:Play(0.1, v643, v642);
			end;
			u33 = u33 + p87;
			u41();
			if u10.Painkillers == nil then
				shakecamera("damage", { p87 });
			end;
		end;
		if playerstats.Class == "sword" then
			if v60[3].dogtagsdamagetimer <= tick() - v59.dogtag_lose_timer then
				v59.dogtag_lose_damage = p87;
			else
				v59.dogtag_lose_damage = v59.dogtag_lose_damage + p87;
			end;
			v59.dogtag_lose_timer = tick();
			if v60[3].dogtagsheavydamage <= v59.dogtag_lose_damage then
				v59.dogtag_lose_damage = 0;
				v59.losetags(p87, false);
			end;
		elseif playerstats.Class == "fire" then
			local v644 = p87 * v60[3].overheat_cooldown_multiplier;
			if p85.weapontype == "Gun" then
				v644 = v644 * v60[3].overheat_gun_multiplier;
			end;
			v59.apply_overheat(v644, true);
		end;
		if playerstats.Class == "goggles" and v59.goggletakedamage and p87 > 2 then
			v59.goggletakedamage(p87);
		end;
		if v49 == true and (u17.weapontype == "Gun" or u17.weapontype == "Bow") then
			u96();
		end;
		if u10.Lazarus or u10["Defense Buff"] then
			local v645 = 8;
			if u10.Lazarus then
				v645 = v19.lazarus.activestats.min_heal;
			end;
			if hum.Health <= v645 then
				l__workspace__1.ServerStuff.dealDamage:FireServer("lazarusheal", p87, v5, v4);
			end;
		end;
		v101({ "hitsound", "general" }, "hitreceive", nil, nil, true, true);
		local v646 = require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS);
		if p85.weapontype == "Bludgeon" or p85.weapontype == "Blade" or p85.weapontype == "Axe" or p85.weapontype == "Spear" or p85.weapontype == "Fists" then
			if p86 and u36.tagged[p86.Name] and p87 and p87 >= 12 then
				u36.tagged[p86.Name] = nil;
				u36.ticktimers[p86.Name] = tick();
				u36.suslevels[p86.Name] = tick();
			end;
			local v647 = nil;
			if p85.weapontype == "Bludgeon" then
				v647 = v646.Crp;
				if p90.sub then
					u8 = math.clamp(u8 - p87 * v7.sub.efx[1] / 100, 0, v62);
				end;
			elseif p85.weapontype == "Blade" then
				v647 = v646.Bld;
				if p90.clot then
					clottingwound = p85.woundrating;
					clotting = tick();
				end;
			elseif p85.weapontype == "Axe" then
				v647 = v646.Bld;
			elseif p85.weapontype == "Spear" then
				v647 = v646.Crp;
			end;
			if (p85.weapontype == "Bludgeon" or p85.weapontype == "Blade") and u10.Silencer then
				v647 = nil;
			end;
			if p85.name == "Hidden Knife" and p87 >= 40 then
				local l__Crp__648 = v646.Crp;
				l__Crp__648.intensity = 4;
				afflictstatus(l__Crp__648);
			end;
			if v647 then
				v647.intensity = p85.woundrating;
				if p90.maniac and p85.weapontype == "Axe" then
					v647.intensity = v7.maniac.efx[1];
				end;
				local v649 = math.random(1, 10);
				if p90 and p90.backstab == true then
					v649 = 1;
				end;
				if v649 == 1 then
					if u10.Bleed and v647 == v646.Bld and u10["Bleed Prevention"] == nil then
						afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).HeavBld);
					end;
					if v647 == v646.Crp and math.random(1, 2) == 1 then
						v647 = v646.Frac;
					end;
					afflictstatus(v647);
					if p90.clot and p85.weapontype == "Blade" and v7.clot.efx[1] < tick() - clotting then
						spawn(function()
							while true do
								v647.intensity = clottingwound;
								afflictstatus(v647);
								RS:wait();
								if v7.clot.efx[1] < tick() - clotting then
									break;
								end;							
							end;
						end);
					end;
				end;
			end;
			if u87 == false then
				u87 = true;
			end;
			if u10.Armoured then
				u10.Armoured.effects.currentduration = u10.Armoured.effects.currentduration - p88 * 4;
			end;
			if u10.Snared then
				u10.Snared.effects.currentduration = 0;
			end;
			if u9.charging == true and u10.Unwaivered == nil then
				u9.charging = false;
			end;
			if u85 == false then
				u85 = true;
			end;
		elseif p85.weapontype == "Gun" then
			if p85.damagerating[3] + p85.damagerating[3] * 0.5 <= p87 then
				v101({ "hitsound", "general" }, "hitheadshot", nil, nil, true, true);
			end;
			if v59.aegisshieldup ~= nil and p87 > 1 then
				v59.aegisshieldup(p87 * v60[3].aegisrangeddamagemultiplier);
				p87 = 0;
			end;
			if p87 >= 5 then
				if math.random(1, 10) == 1 then
					if u10.Bleed and u10["Bleed Prevention"] == nil then
						afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).HeavBld);
					end;
					afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Bld);
				end;
				if math.random(1, 15) == 1 then
					if math.random(1, 2) == 1 then
						afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Crp);
					else
						afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Frac);
					end;
				end;
			end;
			if p85.name == "Alarm Gun" and playerperks.inhuman == nil then
				afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Bcn);
				if p90 and p90.codered then
					local l__Bld__650 = require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Bld;
					l__Bld__650.intensity = v7.codered.efx[1];
					afflictstatus(l__Bld__650);
				end;
			end;
		end;
		if p85 == "grenade" or p85 == "grenadeairburst" or p85 == "grenadetinnitus" then
			globalanimsets.explosion_waiver:Play(0.05, 1, 0.5);
			if playerperks.bomb == nil and v56 == false then
				local l__Bld__651 = require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Bld;
				l__Bld__651.intensity = 1;
				afflictstatus(l__Bld__651);
				if p85 ~= "grenadeairburst" then
					local l__Crp__652 = require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Crp;
					l__Crp__652.intensity = 1;
					afflictstatus(l__Crp__652);
				end;
			end;
			if p85 == "grenadetinnitus" and v56 == false then
				v101({ "general" }, "tinnitus", nil, nil, true, true);
				afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Tnt);
			end;
		end;
		if p85 == "hanger_influence" then
			start_influence();
		end;
		if p85[1] == "thrown" then
			if p85[2].name == "Poisoned Knife" then
				afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Scs);
			elseif p85[2].name == "Hunting Axe" then
				if p88 == p85[2].damagerating[2] then
					local l__Bld__653 = require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Bld;
					l__Bld__653.intensity = v18.TAxe.sizerating;
					local l__Crp__654 = require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Crp;
					l__Crp__654.intensity = v18.TAxe.sizerating;
					afflictstatus(l__Bld__653);
					afflictstatus(l__Crp__654);
				end;
			elseif p85[2].name == "Throwing Javelin" then
				afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Prc);
			end;
		end;
		if p85 == "caltrop" then
			local l__Bld__655 = require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Bld;
			l__Bld__655.intensity = 3;
			local l__Crp__656 = require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Crp;
			l__Crp__656.intensity = 3;
			afflictstatus(l__Bld__655);
			afflictstatus(l__Crp__656);
			l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "caltropstep", character.HumanoidRootPart, 0.25);
		elseif p85 == "Steel Punjis" or p85 == "Crafted Punjis" then
			afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Scs);
			l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "caltropstep", character.HumanoidRootPart, 0.25);
			l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "punjistep", character.HumanoidRootPart, 0.25);
		elseif p85 == "snare" then
			l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "snarestep", character.HumanoidRootPart, 0.25);
			afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Snr);
		elseif p85 == "TGas" or p85 == "CRSBomb" then
			afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Bnd);
			if p85 == "TGas" then
				afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Psn);
			end;
		end;
		if p88 > 0 and p86 then
			v109.damagetaken = v109.damagetaken + p88;
			l__workspace__1.ServerStuff.adjustStats:FireServer("tracker", { "DamageTakenFrom", p88 });
			if tick() - hiddeneyescooldown > 2.5 and startperk.Value == "hiddenB" then
				hiddeneyescooldown = tick();
				l__workspace__1.ServerStuff.dealDamage:FireServer("hiddeneyes", nil, v5, v4);
			end;
			local v657 = maingui.Damage:Clone();
			v657.Rotation = v638;
			v657.Visible = true;
			spawn(function()
				for v658 = 1, 40 do
					v657.Indicator.ImageTransparency = v657.Indicator.ImageTransparency + 0.025;
					RS:wait();
				end;
				v657:Destroy();
			end);
			v657.Parent = maingui;
		end;
		if p85 == "minigunbash" and (u9.sprinting == true or u9.swinging == true or u9.charging == true or u9.blocking == true) then
			spawn(function()
				stagger("normal");
			end);
		end;
		if v638 and p86 then
			l__workspace__1.ServerStuff.flinchTarget:FireServer(character.Torso, character.HumanoidRootPart, v638, p87);
		end;
	elseif p87 == "shove" then
		if u9.blocking == true and u10.Unwaivered == nil and u9.blockrecoil == false then
			spawn(function()
				stagger("normal");
			end);
		else
			l__workspace__1.ServerStuff.flinchTarget:FireServer(character.Torso, character.HumanoidRootPart, v638, 3);
		end;
	elseif p87 == "clienthitblocked" then
		if u9.staggering == false then
			spawn(function()
				stagger("normal");
			end);
		end;
	elseif p87 == "ai_grapple" or p87 == "force_stagger" or p87 == "airburst_stagger" then
		if p87 == "airburst_stagger" and v56 == true then
			return;
		end;
		if v51 == true or p87 == "force_stagger" then
			spawn(function()
				stagger("normal");
			end);
		end;
	elseif p87 == "burning" then
		afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Brn);
	elseif p87 == "taser" then
		shakecamera("tased");
		applygore("tased");
		afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Vcd);
	elseif p87 == "dronetase" then
		shakecamera("tased");
		applygore("tased");
		afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Vcd);
	elseif p87 == "pepperspray" then
		afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Bnd);
	elseif p87 == "forcebleed" then
		local l__Bld__659 = require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Bld;
		l__Bld__659.intensity = 2;
		afflictstatus(l__Bld__659);
	elseif p87 == "disability" then
		local l__Crp__660 = require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Crp;
		l__Crp__660.intensity = v7.disab.efx[1];
		afflictstatus(l__Crp__660);
	elseif p87 == "ingas" then
		u97 = true;
		afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Psn);
	elseif p87 == "outgas" then
		u97 = false;
		if u10.Toxins then
			u10.Toxins.effects.currentduration = 0;
		end;
	elseif p87 == "shadowForm" then
		if shadowForm == true then
			shadowrespawnflash();
		else
			convertToShadow();
		end;
	end;
	return nil;
end);
local function u98(p91, p92, p93)
	local v661 = p93;
	local v662 = Color3.new(0, 0.8, 0.9);
	if p91.Parent.Name == "Heavy Ammo" or p91.Parent.Name == "Shells Ammo" or p91.Parent.Name == "Light Ammo" or p91.Parent.Name == "Long Ammo" or p91.Parent.Name == "Short Ammo" or p91.Parent.Name == "Medium Ammo" or p91.Parent.Name == "Small Ammo" then
		v662 = Color3.new(1, 0.8, 0);
	elseif p91.Name == "HarvestWood" or p91.Name == "HarvestStone" then
		v662 = Color3.new(0.8, 0, 0.8);
	elseif p91.Name == "JointGrip" then
		v662 = Color3.new(0.2, 0.9, 0);
	elseif p91.Name == "Head" then
		v662 = Color3.new(1, 0.1, 0);
	end;
	if p92 == true then
		v661 = 8;
	end;
	local v663 = l__game__7.ReplicatedStorage.misc.teammateindicator:Clone();
	l__Debris__27:AddItem(v663, v661);
	v663.AlwaysOnTop = true;
	v663.ImageLabel.ImageColor3 = v662;
	v663.Parent = p91;
	v663.Adornee = p91;
	if p92 == true then
		v663.ImageLabel.Rotation = 180;
		delay(p93 - 0.5, function()
			while true do
				v663.ImageLabel.ImageTransparency = v663.ImageLabel.ImageTransparency + 0.05;
				RS:wait();
				if v663 == nil then
					break;
				end;
				if v663.ImageLabel.ImageTransparency >= 1 then
					break;
				end;			
			end;
			v663:Destroy();
		end);
	end;
end;
function applygore(p94, p95, p96)
	if p94 ~= "bleed" then
		if p94 == "bloodhit" then
			if p95 ~= nil then
				if p95:FindFirstChild("Torso") == nil then
					return;
				end;
			else
				return;
			end;
			local v664 = l__game__7.ReplicatedStorage.effects.bloodSplatter:Clone();
			l__Debris__27:AddItem(v664, 2);
			v664.CFrame = CFrame.new(p95.Torso.Position);
			v664.Parent = l__workspace__1.NoTarget;
			local v665 = p96[1];
			if v665 == nil then
				v665 = 1;
			end;
			local v666 = v665 / 1.5;
			if v666 < 6 then
				v666 = 6;
			end;
			v664.fx1.Enabled = true;
			v664.fx1:Emit(math.random(v666, v666 + math.random(3, 5)));
			v664.fx1.Enabled = false;
			if p94 == "bloodhit" then
				local v667 = l__game__7.ReplicatedStorage.effects.bloodSplatter:Clone();
				l__Debris__27:AddItem(v667, 2);
				v667.CFrame = CFrame.new(p96[2]);
				v667.Parent = l__workspace__1.NoTarget;
				v667.fx2.Enabled = true;
				v667.fx2:Emit(math.random(1, 3));
				v667.fx2.Enabled = false;
				v667.fx3.Enabled = true;
				v667.fx3:Emit(math.random(5, 10));
				v667.fx3.Enabled = false;
				v667.fx4.Enabled = true;
				v667.fx4:Emit(math.random(5, 10));
				v667.fx4.Enabled = false;
			end;
		elseif p94 == "blocksmoke" then
			local v668 = l__game__7.ReplicatedStorage.effects.smokeBlock:Clone();
			l__Debris__27:AddItem(v668, 1);
			v668.Parent = p95.Torso;
			v668.Enabled = true;
			v668:Emit(math.random(3, 5));
			v668.Enabled = false;
		elseif p94 == "laz_shock" then
			local v669 = { "Left Arm", "Torso", "Right Arm" };
			if p96[2] ~= nil then
				v669 = { "Left Arm", "Torso", "Right Arm", "Left Leg", "Right Leg" };
			end;
			if p95 == character then
				v669 = { "Torso" };
				afflictstatus(require(l__game__7.Workspace.ServerStuff.Statistics.S_STATISTICS).Laz);
			end;
			local v670, v671, v672 = ipairs(v669);
			while true do
				local v673, v674 = v670(v671, v672);
				if v673 then

				else
					break;
				end;
				v672 = v673;
				if p95:FindFirstChild(v674) then
					local v675 = l__game__7.ReplicatedStorage.effects.electriclazarus:Clone();
					l__Debris__27:AddItem(v675, p96[1]);
					v675.Parent = p95:FindFirstChild(v674);
				end;			
			end;
		elseif p94 == "lazarus_fire" then
			local v676 = l__game__7.ReplicatedStorage.effects.lazarusfx:Clone();
			l__Debris__27:AddItem(v676, 10);
			v676.CFrame = CFrame.new(p96[1]);
			v676.Parent = l__workspace__1.NoTarget;
			v676.attach.ring1:Emit(1);
			v676.attach.ring2:Emit(1);
			v676.attach.spark3:Emit(1);
			v676.attach.spark2:Emit(1);
			v676.leftover:Emit(math.random(30, 60));
			v676.leftover.Enabled = false;
			v676.attach.ring1.Enabled = false;
			v676.attach.ring2.Enabled = false;
			v676.attach.spark3.Enabled = false;
			v676.attach.spark2.Enabled = false;
			delay(0.2, function()
				v676.attach.sparks.Enabled = false;
			end);
			delay(1, function()
				v676.residual.Enabled = false;
			end);
			RS:wait();
			v101({ "perks" }, "laz_explosion", v676, 0.05, true, false);
		elseif p94 == "immolate_ability" then
			local v677 = l__game__7.ReplicatedStorage.effects.immolatorEffect:Clone();
			l__Debris__27:AddItem(v677, 10);
			v677.CFrame = p96[1];
			v677.Parent = l__workspace__1.NoTarget;
			RS:wait();
			v677.ember:Emit(math.random(30, 40));
			v677.flame:Emit(math.random(30, 40));
			v677.small:Emit(math.random(30, 40));
			v677.smoke:Emit(math.random(30, 40));
			v677.flamespread:Emit(math.random(20, 30));
			v101({ "perks" }, "flamer_ignite", v677, 0.05, true, false);
		elseif p94 == "shotshell_blast" then
			local v678 = l__game__7.ReplicatedStorage.misc.shotshellFX:Clone();
			l__Debris__27:AddItem(v678, 5);
			v678.CFrame = CFrame.new(p96[1]);
			if p96[2] then
				v678.Beam.Enabled = true;
				v678.trail.CFrame = CFrame.new(p96[2]);
			end;
			v678.Parent = l__workspace__1.NoTarget;
			v678.fx:Emit(math.random(10, 15));
			v678.fx2:Emit(math.random(8, 10));
			v678.fx3:Emit(math.random(20, 30));
			v678.fx4:Emit(1);
			if p96[2] then
				v678.largefx1:Emit(math.random(10, 15));
				v678.largefx2:Emit(math.random(15, 20));
				v678.largefx3:Emit(1);
				delay(0.5, function()
					local v679 = 1 - 1;
					while true do
						v678.Beam.Transparency = NumberSequence.new(v679 / 30);
						RS:wait();
						if 0 <= 1 then
							if v679 < 30 then

							else
								break;
							end;
						elseif 30 < v679 then

						else
							break;
						end;
						v679 = v679 + 1;					
					end;
				end);
			end;
		elseif p94 == "lazarus_laser" then
			local v680 = l__game__7.ReplicatedStorage.effects.laztrail:Clone();
			l__Debris__27:AddItem(v680, 3);
			v680.trailA.CFrame = CFrame.new(p96[1]);
			v680.trailB.CFrame = CFrame.new(p96[2]);
			v680.Parent = l__workspace__1.NoTarget;
			v680.trailA.crystal:Emit(math.random(3, 8));
			v680.trailA.flare:Emit(1);
			v680.trailA.spark:Emit(math.random(5, 10));
			v680.trailA.crystal.Enabled = false;
			v680.trailA.flare.Enabled = false;
			v680.trailA.spark.Enabled = false;
			delay(0.3, function()
				local v681 = 1 - 1;
				while true do
					v680.Beam.Transparency = NumberSequence.new(v681 / 25);
					RS:wait();
					if 0 <= 1 then
						if v681 < 25 then

						else
							break;
						end;
					elseif 25 < v681 then

					else
						break;
					end;
					v681 = v681 + 1;				
				end;
				v680:Destroy();
			end);
		elseif p94 == "harvestmat" then
			if p96[2] == nil then
				return;
			end;
			local v682 = l__game__7.ReplicatedStorage.effects.harvest_fx:Clone();
			l__Debris__27:AddItem(v682, 2);
			v682.CFrame = CFrame.new(p96[2]);
			v682.Parent = l__workspace__1.NoTarget;
			if p96[1] == "salvaged" then
				v682.smokeharvest.Enabled = true;
				v682.smokeharvest:Emit(1);
				v682.smokeharvest.Enabled = false;
			else
				v682[p96[1] .. "fx1"].Enabled = true;
				v682[p96[1] .. "fx1"]:Emit(math.random(2, 4));
				v682[p96[1] .. "fx1"].Enabled = false;
				v682[p96[1] .. "fx2"].Enabled = true;
				v682[p96[1] .. "fx2"]:Emit(math.random(2, 4));
				v682[p96[1] .. "fx2"].Enabled = false;
			end;
		elseif p94 == "fall_nullified" then
			local v683 = l__game__7.ReplicatedStorage.effects.fall_fx:Clone();
			v683.CFrame = p95.Torso.CFrame;
			l__Debris__27:AddItem(v683, 3);
			local v684 = Instance.new("Weld");
			v684.Part0 = p95.Torso;
			v684.Part1 = v683;
			v683.Parent = p95.Torso;
			v684.Parent = v683;
			RS:wait();
			v683.attach.effect:Emit(math.random(20, 30));
			v683.attach.effect2:Emit(math.random(15, 20));
			v683.attach.effect.Enabled = false;
			v683.attach.effect2.Enabled = false;
		elseif p94 == "floorSplat" then
			if u9.air == false then
				local v685 = raycastline(p95.Torso.CFrame.p, -p95.Torso.CFrame.upVector, 8, { p95, character, l__workspace__1.NoTarget });
				if v685 then
					if v685.Name ~= "BLOODRoot" then
						local v686 = l__game__7.ReplicatedStorage.effects:FindFirstChild("floorblood" .. math.random(1, 4)):Clone();
						if p96 == nil then
							p96 = 20;
						end;
						local v687, v688, v689 = pairs(v686.BLOODRoot:GetChildren());
						while true do
							local v690, v691 = v687(v688, v689);
							if v690 then

							else
								break;
							end;
							v689 = v690;
							v691.Decal.Transparency = 0.5 - p96 / 65;						
						end;
						l__Debris__27:AddItem(v686, 23);
						v686:SetPrimaryPartCFrame(CFrame.new(p95.Torso.Position - Vector3.new(0, 2.9, 0)));
						delay(20, function()
							if v686:FindFirstChild("BLOODRoot") then
								local v692 = 1 - 1;
								while true do
									local v693, v694, v695 = pairs(v686.BLOODRoot:GetChildren());
									while true do
										local v696, v697 = v693(v694, v695);
										if v696 then

										else
											break;
										end;
										v695 = v696;
										v697.Decal.Transparency = v697.Decal.Transparency + 0.05;									
									end;
									RS:wait();
									if 0 <= 1 then
										if v692 < 20 then

										else
											break;
										end;
									elseif 20 < v692 then

									else
										break;
									end;
									v692 = v692 + 1;								
								end;
							end;
							v686:Destroy();
						end);
						v686.Parent = l__workspace__1.GoreEffects;
					end;
				end;
			elseif p94 == "firegun" then
				local v698 = l__game__7.ReplicatedStorage.effects.gunTrail:Clone();
				l__Debris__27:AddItem(v698, 3);
				v698.trailA.CFrame = CFrame.new(p96[1]);
				v698.trailB.CFrame = CFrame.new(p96[2]);
				v698.Parent = l__workspace__1.NoTarget;
				local v699 = l__game__7.ReplicatedStorage.effects.bullet_trail:Clone();
				l__Debris__27:AddItem(v699, 0.2);
				v699.CFrame = CFrame.new(p96[1], p96[2]);
				v699.CFrame = v699.CFrame + v699.CFrame.lookVector * math.random(15, 25);
				if p96[3] == false then
					v699.Parent = l__workspace__1.NoTarget;
					spawn(function()
						RS:wait();
						v699.Velocity = v699.Velocity + v699.CFrame.lookVector * 1000;
					end);
				end;
				if p96[4] == nil then
					if 0.02 < tick() - crackcd then
						v101({ "firearms" }, "crack", v698.trailB, 0.1, true, false);
					end;
					crackcd = tick();
					v698.trailB.debrisA.Enabled = true;
					v698.trailB.debrisB.Enabled = true;
					v698.trailB.smoke.Enabled = true;
					v698.trailB.spark.Enabled = true;
					v698.trailB.debrisA:Emit(math.random(3, 6));
					v698.trailB.debrisB:Emit(math.random(3, 6));
					v698.trailB.smoke:Emit(math.random(2, 4));
					v698.trailB.spark:Emit(math.random(8, 12));
					v698.trailB.debrisA.Enabled = false;
					v698.trailB.debrisB.Enabled = false;
					v698.trailB.smoke.Enabled = false;
					v698.trailB.spark.Enabled = false;
				else
					v101({ "hitsound", "guns" }, "bullet_impact" .. math.random(1, 3), v698.trailB, 0.1, true, false);
				end;
				if p96[5] == nil then
					local v700 = l__game__7.ReplicatedStorage.effects.gunFX:Clone();
					l__Debris__27:AddItem(v700, 1);
					v700.CFrame = CFrame.new(p96[1]);
					v700.Parent = l__workspace__1.NoTarget;
					spawn(function()
						if p96[3] == false then
							v700.flash.Enabled = true;
							v700.flash:Emit(1);
							v700.flash.Enabled = false;
							local v701 = l__game__7.ReplicatedStorage.misc.muzzleflash:Clone();
							l__Debris__27:AddItem(v701, 0.05);
							v701.Parent = v700;
						end;
						v700.smoke.Enabled = true;
						v700.smoke2.Enabled = true;
						v700.smoke:Emit(math.random(4, 6));
						v700.smoke:Emit(math.random(10, 15));
						v700.smoke.Enabled = false;
						v700.smoke2.Enabled = false;
					end);
				end;
			elseif p94 == "incendiary_trail" then
				local v702 = l__game__7.ReplicatedStorage.effects.incendiary_trail:Clone();
				l__Debris__27:AddItem(v702, 3);
				v702.trailA.CFrame = CFrame.new(p96[1]);
				v702.trailB.CFrame = CFrame.new(p96[2]);
				v702.Parent = l__workspace__1.NoTarget;
				if 0.02 < tick() - specialcrackcd then
					v101({ "firearms" }, "incendiary_crack", v702.trailB, 0.1, true, false);
				end;
				specialcrackcd = tick();
				v702.trailB.ember:Emit(math.random(8, 12));
				v702.trailB.flame:Emit(math.random(5, 10));
				v702.trailB.small:Emit(math.random(5, 10));
				spawn(function()
					local v703 = 1 - 1;
					while true do
						v702.Beam.Transparency = NumberSequence.new(v703 / 20);
						RS:wait();
						if 0 <= 1 then
							if v703 < 20 then

							else
								break;
							end;
						elseif 20 < v703 then

						else
							break;
						end;
						v703 = v703 + 1;					
					end;
				end);
			elseif p94 == "muzzle_flash" then
				local v704 = l__game__7.ReplicatedStorage.effects.gunFX:Clone();
				l__Debris__27:AddItem(v704, 1);
				v704.CFrame = CFrame.new(p96[1]);
				v704.Parent = l__workspace__1.NoTarget;
				spawn(function()
					if p96[2] == false then
						v704.flash.Enabled = true;
						v704.flash:Emit(1);
						v704.flash.Enabled = false;
						local v705 = l__game__7.ReplicatedStorage.misc.muzzleflash:Clone();
						l__Debris__27:AddItem(v705, 0.05);
						v705.Parent = v704;
					end;
					v704.smoke.Enabled = true;
					v704.smoke2.Enabled = true;
					v704.smoke:Emit(math.random(4, 6));
					v704.smoke:Emit(math.random(10, 15));
					v704.smoke.Enabled = false;
					v704.smoke2.Enabled = false;
				end);
			elseif p94 == "hangerPopup" then
				local function v706()
					local v707 = { "YOU ARE WORTHLESS", "USELESS", "YOU ARE HOPELESS", "HOPELESS", "DIE", "GIVE UP", "YOU ARE USELESS", "WORTHLESS", "MEANINGLESS", "YOU ARE MEANINGLESS" };
					local v708 = l__game__7.ReplicatedStorage.soundLibrary.general_ui.static:Clone();
					v708.TimePosition = math.random(1, 30);
					v708.Parent = l__CurrentCamera__1;
					local v709 = { "4452726587", "4452726886", "4452727160", "4452727454" };
					local v710 = math.random(1, 4);
					local v711 = l__game__7.ReplicatedStorage.misc.hangertext:Clone();
					v711.static.Image = "rbxassetid://" .. v709[v710];
					v711.popuptext.Text = v707[math.random(1, #v707)];
					local v712 = math.random(20, 80) / 100;
					local v713 = math.random(10, 90) / 100;
					v711.popuptext.Position = UDim2.new(v712, 0, v713, 0);
					local u99 = 0;
					local u100 = v710;
					spawn(function()
						v708:Play();
						v711.Parent = ply.PlayerGui;
						local v714 = tick();
						while true do
							v711.popuptext.Position = UDim2.new(v712, math.random(-10, 10), v713, math.random(-10, 10));
							if 0.05 <= tick() - u99 then
								u99 = tick();
								u100 = u100 + 1;
								if 4 < u100 then
									u100 = 1;
								end;
								v711.static.Image = "rbxassetid://" .. v709[u100];
							end;
							RS:wait();
							if not (0.3 <= tick() - v714) then

							else
								break;
							end;						
						end;
						v711:Destroy();
						v708:Destroy();
					end);
				end;
				if character:FindFirstChild("HumanoidRootPart") then
					if (character:FindFirstChild("HumanoidRootPart").Position - p95.Position).magnitude <= 30 then
						v706();
						if (character:FindFirstChild("HumanoidRootPart").Position - p95.Position).magnitude <= 15 then
							delay(1.5, function()
								v706();
							end);
						end;
					end;
				end;
			elseif p94 == "firelaser" then
				local v715 = l__game__7.ReplicatedStorage.effects.laserTrail:Clone();
				l__Debris__27:AddItem(v715, 3);
				v715.trailA.CFrame = CFrame.new(p96[1]);
				v715.trailB.CFrame = CFrame.new(p96[2]);
				v715.Parent = l__workspace__1.NoTarget;
				if p96[4] == nil then
					if 0.02 < tick() - crackcd then
						v101({ "hitsound", "general" }, "plasma", v715.trailB, 0.1, true, false);
					end;
					crackcd = tick();
					v715.trailB.debrisA.Enabled = true;
					v715.trailB.debrisB.Enabled = true;
					v715.trailB.smoke.Enabled = true;
					v715.trailB.spark.Enabled = true;
					v715.trailB.debrisA:Emit(math.random(3, 6));
					v715.trailB.debrisB:Emit(math.random(3, 6));
					v715.trailB.smoke:Emit(math.random(2, 4));
					v715.trailB.spark:Emit(math.random(8, 12));
					v715.trailB.debrisA.Enabled = false;
					v715.trailB.debrisB.Enabled = false;
					v715.trailB.smoke.Enabled = false;
					v715.trailB.spark.Enabled = false;
				end;
				if p96[3] ~= nil then
					v715.Beam.Color = ColorSequence.new(Color3.new(0.6392156862745098, 0.13333333333333333, 1));
				end;
				delay(0.3, function()
					local v716 = 1 - 1;
					while true do
						v715.Beam.Transparency = NumberSequence.new(v716 / 25);
						RS:wait();
						if 0 <= 1 then
							if v716 < 25 then

							else
								break;
							end;
						elseif 25 < v716 then

						else
							break;
						end;
						v716 = v716 + 1;					
					end;
					v715:Destroy();
				end);
				local v717 = l__game__7.ReplicatedStorage.effects.laserFX:Clone();
				if p96[3] ~= nil then
					local v718, v719, v720 = ipairs(v717:GetChildren());
					while true do
						local v721, v722 = v718(v719, v720);
						if v721 then

						else
							break;
						end;
						v720 = v721;
						if v722:IsA("ParticleEmitter") then
							v722.Color = ColorSequence.new(Color3.new(0.6392156862745098, 0.13333333333333333, 1));
						end;					
					end;
				end;
				l__Debris__27:AddItem(v717, 1);
				v717.CFrame = CFrame.new(p96[1]);
				v717.Parent = l__workspace__1.NoTarget;
				spawn(function()
					v717.flash.Enabled = true;
					v717.flash:Emit(1);
					v717.flash.Enabled = false;
					v717.crystal.Enabled = true;
					v717.crystal:Emit(math.random(2, 4));
					v717.crystal.Enabled = false;
					v717.spark.Enabled = true;
					v717.spark:Emit(math.random(4, 8));
					v717.spark.Enabled = false;
					v717.flare.Enabled = true;
					v717.flare:Emit(1);
					v717.flare.Enabled = false;
				end);
			elseif p94 == "bowarrow" then
				local v723 = l__game__7.ReplicatedStorage.effects.bowtrail:Clone();
				v723.CFrame = p96[1];
				v723.Parent = l__workspace__1.NoTarget;
				RS:wait();
				v723.CFrame = p96[1];
				local v724, v725 = raycastline(p96[1].p, p96[1].LookVector + p96[2], 80, { l__workspace__1.NoTarget, l__workspace__1.GoreEffects, l__CurrentCamera__1 });
				RS:wait();
				v723.CFrame = CFrame.new(v725);
				if v724 == nil then
					local v726 = v725;
					local v727 = 1 - 1;
					while true do
						local v728, v729 = raycastline(v726, p96[1].LookVector + p96[2] + Vector3.new(0, -0.05, 0), 3, baselayer);
						v723.CFrame = CFrame.new(v729);
						if v728 then
							break;
						end;
						v726 = v729;
						RS:wait();
						if 0 <= 1 then
							if v727 < 200 then

							else
								break;
							end;
						elseif 200 < v727 then

						else
							break;
						end;
						v727 = v727 + 1;					
					end;
				end;
				l__Debris__27:AddItem(v723, 5);
			elseif p94 == "vomit" then
				if p95:FindFirstChild("Head") == nil then
					return;
				end;
				local v730 = l__game__7.ReplicatedStorage.effects.vomitBlock:Clone();
				v730.CFrame = p95.Head.CFrame;
				l__Debris__27:AddItem(v730, 3);
				local v731 = Instance.new("Weld");
				v731.Part0 = p95.Head;
				v731.Part1 = v730;
				v730.Parent = p95.Head;
				v731.Parent = v730;
				delay(1, function()
					v730.sickParticle.Enabled = false;
				end);
			elseif p94 == "lostecho" then
				if current_in_echo == true then
					return;
				end;
				current_in_echo = true;
				agent_speak("echo_start");
				local v732 = l__game__7.ReplicatedStorage.misc.echo_bg:Clone();
				v732.Parent = p96[1].hoverpart;
				v732.Adornee = p96[1].hoverpart;
				local v733 = 0;
				local v734 = tick();
				local v735 = 0.03;
				local v736 = 11;
				local v737 = tick();
				while true do
					if v735 <= tick() - v734 then
						v734 = tick();
						v735 = math.random(20, 40) / 1000;
						v733 = v733 + 1;
						v732.loading.Text = tostring(v733) .. "%";
						v732.loadingbar.bar.Size = UDim2.new(v733 / 100, 0, 3, 0);
					end;
					if 0.05 <= tick() - v737 then
						if 0 < v736 then
							v737 = tick();
							v736 = v736 - 1;
							v732.loadingbar.Visible = not v732.loadingbar.Visible;
						end;
					end;
					v732.loading.TextTransparency = v732.loading.TextTransparency - 0.03;
					v732.ring.ImageTransparency = v732.ring.ImageTransparency - 0.03;
					v732.ring.Size = v732.ring.Size:Lerp(UDim2.new(1, 0, 1, 0), 0.1);
					RS:wait();
					if not (100 <= v733) then

					else
						break;
					end;
					if p96[1] ~= nil then

					else
						break;
					end;				
				end;
				v732:Destroy();
				if p96[1] then
					v101({ "general_ui" }, "echo_open", p96[1].hoverpart, 0.01, true, false);
					local v738 = l__game__7.ReplicatedStorage.effects.echoball:Clone();
					l__Debris__27:AddItem(v738, 20);
					v738.CFrame = p96[1].hoverpart.CFrame;
					v738.Parent = l__CurrentCamera__1;
					spawn(function()
						while true do
							v738.Size = v738.Size + Vector3.new(1, 1, 1);
							v738.Transparency = v738.Transparency + 0.05;
							RS:wait();
							if not (1 <= v738.Transparency) then

							else
								break;
							end;						
						end;
						delay(1.5, function()
							v738.fx.Enabled = false;
						end);
					end);
					if l__game__7.ReplicatedStorage.echo:FindFirstChild(p96[2]) then
						local v739 = l__game__7.ReplicatedStorage.echo:FindFirstChild(p96[2]):Clone();
						v739.Parent = l__CurrentCamera__1;
						local v740, v741, v742 = ipairs(v739:GetChildren());
						while true do
							local v743, v744 = v740(v741, v742);
							if v743 then

							else
								break;
							end;
							v742 = v743;
							if v744:FindFirstChild("torso") then
								spawn(function()
									local v745 = l__game__7.ReplicatedStorage.effects.echoball:Clone();
									l__Debris__27:AddItem(v745, 10);
									v745.Material = Enum.Material.Neon;
									v745.CFrame = v744.torso.CFrame;
									v745.fx.Enabled = false;
									v745.Parent = l__CurrentCamera__1;
									v745.flash:Emit(math.random(10, 20));
									while true do
										v745.Size = v745.Size + Vector3.new(0.5, 0.5, 0.5);
										v745.Transparency = v745.Transparency + 0.1;
										RS:wait();
										if not (1 <= v745.Transparency) then

										else
											break;
										end;									
									end;
								end);
							end;						
						end;
						if p96[2] == "mountain" then
							delay(1.5, function()
								v101({ "echo_specific" }, "seat", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(3.5, function()
								v101({ "firearms" }, "rack", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(1, function()
								v101({ "movement_sounds" }, "step1", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(2, function()
								v101({ "movement_sounds" }, "step2", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(3, function()
								v101({ "movement_sounds" }, "step4", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(4, function()
								v101({ "movement_sounds" }, "step2", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(4.2, function()
								v101({ "echo_specific" }, "seat", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(5.9, function()
								v101({ "weapons", "Fists" }, "swingvar2", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(6, function()
								v101({ "hitsound", "melee" }, "fists", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9, function()
								v101({ "general" }, "reloadpartial", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(12, function()
								v101({ "weapons", "RFL" }, "Model 870", p96[1].hoverpart, nil, true, false, true);
							end);
						elseif p96[2] == "ship" then
							delay(1, function()
								v101({ "echo_specific" }, "lighter", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(2, function()
								v101({ "echo_specific" }, "lighter", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(3, function()
								v101({ "echo_specific" }, "lighter", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(1.5, function()
								v101({ "movement_sounds" }, "step1", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(2.5, function()
								v101({ "movement_sounds" }, "step2", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(3.5, function()
								v101({ "movement_sounds" }, "step4", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(4.5, function()
								v101({ "movement_sounds" }, "step2", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(6, function()
								v101({ "world_item" }, "ration_pickup", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(7, function()
								v101({ "movement_sounds" }, "step1", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(8, function()
								v101({ "movement_sounds" }, "step2", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(8.5, function()
								v101({ "weapons", "1HBL" }, "draw", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9, function()
								v101({ "weapons", "1HBL" }, "chargeswing", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9.3, function()
								v101({ "deaths" }, "axe_hit", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9.3, function()
								v101({ "deaths" }, "slash", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9.4, function()
								v101({ "world_item" }, "ration_pickup", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9.4, function()
								v101({ "general" }, "reloaddone", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9.6, function()
								v101({ "echo_specific" }, "running", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(10, function()
								v101({ "weapons", "ASMG" }, "M60-E6", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(11, function()
								v101({ "firearms" }, "casing_heavy", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(10.11, function()
								v101({ "weapons", "ASMG" }, "M60-E6", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(11.11, function()
								v101({ "firearms" }, "casing_heavy", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(10.22, function()
								v101({ "weapons", "ASMG" }, "M60-E6", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(10.32, function()
								v101({ "firearms" }, "crack", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(11.22, function()
								v101({ "firearms" }, "casing_heavy", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(10.33, function()
								v101({ "weapons", "ASMG" }, "M60-E6", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(11.33, function()
								v101({ "firearms" }, "casing_heavy", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(10.44, function()
								v101({ "weapons", "ASMG" }, "M60-E6", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(10.54, function()
								v101({ "firearms" }, "crack", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(11.44, function()
								v101({ "firearms" }, "casing_heavy", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(11.1, function()
								v101({ "echo_specific" }, "running", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(13, function()
								v101({ "weapons", "Item" }, "medikitcap", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(13.5, function()
								v101({ "weapons", "Item" }, "medikitspit", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(14, function()
								v101({ "weapons", "Item" }, "medikitflick", p96[1].hoverpart, nil, true, false, true);
							end);
						elseif p96[2] == "valley" then
							delay(0.5, function()
								v101({ "weapons", "Item" }, "esmarch", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(1, function()
								v101({ "movement_sounds" }, "step1", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(2, function()
								v101({ "movement_sounds" }, "step2", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(3, function()
								v101({ "movement_sounds" }, "step1", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(3.5, function()
								v101({ "general" }, "reloadpartial", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(6.8, function()
								v101({ "weapons", "2HPST" }, "draw", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(6.4, function()
								v101({ "weapons", "PST" }, "Glock 17", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(6.5, function()
								v101({ "firearms" }, "crack", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(7.2, function()
								v101({ "firearms" }, "casing_light", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(6.6, function()
								v101({ "reloads" }, "single_start", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(7, function()
								v101({ "weapons", "PST" }, "Glock 17", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(7.1, function()
								v101({ "firearms" }, "crack", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(8, function()
								v101({ "firearms" }, "casing_light", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(8, function()
								v101({ "reloads" }, "pistol_mid", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(7.2, function()
								v101({ "weapons", "2HPST" }, "Mark VII", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(8.4, function()
								v101({ "firearms" }, "casing_medium", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(7.9, function()
								v101({ "hitsound", "extras" }, "grapple2", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(8.6, function()
								v101({ "weapons", "2HPST" }, "Mark VII", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9.6, function()
								v101({ "firearms" }, "casing_medium", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(8.7, function()
								v101({ "deaths" }, "headshot2", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9, function()
								v101({ "movement_sounds" }, "step2", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(10, function()
								v101({ "movement_sounds" }, "step1", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(11, function()
								v101({ "movement_sounds" }, "step4", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(12, function()
								v101({ "weapons", "2HPST" }, "Mark VII", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(13, function()
								v101({ "firearms" }, "casing_medium", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(12, function()
								v101({ "deaths" }, "headshot1", p96[1].hoverpart, nil, true, false, true);
							end);
						elseif p96[2] == "market" then
							delay(1, function()
								v101({ "rations" }, "liquid_sip", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(2, function()
								v101({ "rations" }, "liquid_sip", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(3, function()
								v101({ "rations" }, "liquid_sip", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(3.5, function()
								v101({ "movement_sounds" }, "movement", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(3.8, function()
								v101({ "echo_specific" }, "seat", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(4.5, function()
								v101({ "weapons", "2HPST" }, "draw", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(4.6, function()
								v101({ "weapons", "ASMG" }, "draw", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(4.7, function()
								v101({ "weapons", "SMG" }, "draw", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(4.8, function()
								v101({ "weapons", "PST" }, "draw", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(6, function()
								v101({ "movement_sounds" }, "step1", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(7, function()
								v101({ "movement_sounds" }, "step2", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(8, function()
								v101({ "general" }, "reloadpartial", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(8.5, function()
								v101({ "weapons", "ASMG" }, "Modded AKM", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(8.6, function()
								v101({ "weapons", "ASMG" }, "Modded AKM", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(8.7, function()
								v101({ "weapons", "ASMG" }, "Modded AKM", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(8.8, function()
								v101({ "weapons", "ASMG" }, "Modded AKM", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(8.9, function()
								v101({ "weapons", "ASMG" }, "Modded AKM", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9, function()
								v101({ "weapons", "ASMG" }, "Modded AKM", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9.5, function()
								v101({ "firearms" }, "casing_heavy", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9.7, function()
								v101({ "firearms" }, "casing_heavy", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9.8, function()
								v101({ "firearms" }, "casing_heavy", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9.9, function()
								v101({ "firearms" }, "casing_heavy", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(8.4, function()
								v101({ "weapons", "PST" }, "Glock 17", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9.4, function()
								v101({ "firearms" }, "casing_light", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(8.7, function()
								v101({ "weapons", "PST" }, "Glock 17", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9.7, function()
								v101({ "firearms" }, "casing_light", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9, function()
								v101({ "weapons", "PST" }, "Glock 17", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(10, function()
								v101({ "firearms" }, "casing_light", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(8.7, function()
								v101({ "weapons", "PST" }, "M1911A1", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9.7, function()
								v101({ "firearms" }, "casing_light", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9.2, function()
								v101({ "weapons", "PST" }, "M1911A1", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(10.2, function()
								v101({ "firearms" }, "casing_light", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(11, function()
								v101({ "movement_sounds" }, "step2", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(12, function()
								v101({ "movement_sounds" }, "step1", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(13, function()
								v101({ "movement_sounds" }, "step4", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(14, function()
								v101({ "world_item" }, "ration_pickup", p96[1].hoverpart, nil, true, false, true);
							end);
						elseif p96[2] == "base" then
							delay(0.5, function()
								v101({ "general" }, "writing", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(1, function()
								v101({ "movement_sounds" }, "step1", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(2, function()
								v101({ "movement_sounds" }, "step2", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(3, function()
								v101({ "movement_sounds" }, "step1", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(4, function()
								v101({ "movement_sounds" }, "step2", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(5, function()
								v101({ "movement_sounds" }, "step1", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(6, function()
								v101({ "movement_sounds" }, "step4", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(4, function()
								v101({ "AGENT" }, "blip", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(5, function()
								v101({ "AGENT" }, "bliptwo", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(7, function()
								v101({ "echo_specific" }, "glass", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(8, function()
								v101({ "weapons", "PST" }, "draw", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(8.5, function()
								v101({ "weapons", "PST" }, "M1911A1", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(8.7, function()
								v101({ "firearms" }, "crack", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9.5, function()
								v101({ "firearms" }, "casing_light", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9, function()
								v101({ "weapons", "SMG" }, "draw", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9.2, function()
								v101({ "weapons", "PST" }, "M1911A1", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9.4, function()
								v101({ "firearms" }, "crack", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(10.2, function()
								v101({ "firearms" }, "casing_light", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9.5, function()
								v101({ "weapons", "2HPST" }, "A.J.M. 9", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9.7, function()
								v101({ "hitsound", "guns" }, "bullet_impact1", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(10.5, function()
								v101({ "firearms" }, "casing_light", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9.554, function()
								v101({ "weapons", "2HPST" }, "A.J.M. 9", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9.754, function()
								v101({ "hitsound", "guns" }, "bullet_impact2", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(10.8, function()
								v101({ "firearms" }, "casing_light", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9.608, function()
								v101({ "weapons", "2HPST" }, "A.J.M. 9", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9.808, function()
								v101({ "hitsound", "guns" }, "bullet_impact3", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(11, function()
								v101({ "firearms" }, "casing_light", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(13, function()
								v101({ "world_item" }, "ration_pickup", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(13.5, function()
								v101({ "echo_specific" }, "running", p96[1].hoverpart, nil, true, false, true);
							end);
						elseif p96[2] == "tower" then
							delay(0.5, function()
								v101({ "weapons", "Fists" }, "swingvar2", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(0.6, function()
								v101({ "hitsound", "melee" }, "fists", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(1.1, function()
								v101({ "weapons", "Fists" }, "swingvar1", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(1.2, function()
								v101({ "hitsound", "melee" }, "fists", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(2, function()
								v101({ "general" }, "shove", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(2.1, function()
								v101({ "general" }, "shove_landed", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(2.4, function()
								v101({ "echo_specific" }, "fall", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(2.8, function()
								v101({ "general" }, "falldamage1", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(2.8, function()
								v101({ "echo_specific" }, "rope", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(2.8, function()
								v101({ "echo_specific" }, "bone", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(6, function()
								v101({ "movement_sounds" }, "step1", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(7, function()
								v101({ "movement_sounds" }, "step2", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(8, function()
								v101({ "movement_sounds" }, "step1", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9, function()
								v101({ "movement_sounds" }, "step4", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(10, function()
								v101({ "movement_sounds" }, "step2", p96[1].hoverpart, nil, true, false, true);
							end);
						elseif p96[2] == "castle" then
							delay(0.5, function()
								v101({ "harvesting" }, "stonebreak", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(1.5, function()
								v101({ "harvesting" }, "stonebreak", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(1, function()
								v101({ "movement_sounds" }, "step1", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(2, function()
								v101({ "movement_sounds" }, "step2", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(3, function()
								v101({ "movement_sounds" }, "step1", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(2.5, function()
								v101({ "harvesting" }, "stonebreak", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(2.6, function()
								v101({ "echo_specific" }, "wall2", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(2.7, function()
								v101({ "echo_specific" }, "wall", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(3, function()
								v101({ "ai" }, "ai_sprint", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(2.9, function()
								v101({ "shadow" }, "skinner_noise5", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(3.5, function()
								v101({ "weapons", "PST" }, "M1911A1", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(4, function()
								v101({ "weapons", "PST" }, "M1911A1", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(4.1, function()
								v101({ "firearms" }, "empty", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(4.4, function()
								v101({ "deaths" }, "cut_tear", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(4.45, function()
								v101({ "deaths" }, "flesh", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(3.5, function()
								v101({ "echo_specific" }, "running", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(4.8, function()
								v101({ "general" }, "blockraise", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(5.3, function()
								v101({ "hitsound", "general" }, "hitblocked", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(6.7, function()
								v101({ "hitsound", "general" }, "hitblocked", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(6.8, function()
								v101({ "weapons", "2H" }, "swingvar1", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(6.9, function()
								v101({ "deaths" }, "headbonk", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(4.5, function()
								v101({ "reloads" }, "rifle_mid", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(5, function()
								v101({ "general" }, "reloaddone", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(6.3, function()
								v101({ "weapons", "ASMG" }, "AK-74", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(6.392, function()
								v101({ "weapons", "ASMG" }, "AK-74", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(6.484, function()
								v101({ "weapons", "ASMG" }, "AK-74", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(6.576, function()
								v101({ "weapons", "ASMG" }, "AK-74", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(6.668, function()
								v101({ "weapons", "ASMG" }, "AK-74", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(6.76, function()
								v101({ "weapons", "ASMG" }, "AK-74", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(6.852, function()
								v101({ "weapons", "ASMG" }, "AK-74", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(6.944, function()
								v101({ "weapons", "ASMG" }, "AK-74", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(7.036, function()
								v101({ "weapons", "ASMG" }, "AK-74", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(7.1, function()
								v101({ "firearms" }, "empty", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(7.5, function()
								v101({ "firearms" }, "click", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(7.8, function()
								v101({ "firearms" }, "click", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(8.1, function()
								v101({ "firearms" }, "click", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(7.3, function()
								v101({ "shadow" }, "skinner_noise2", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9, function()
								v101({ "ai" }, "ai_sprint", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(8.8, function()
								v101({ "weapons", "1HBL" }, "chargeswing", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9, function()
								v101({ "deaths" }, "neck", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9, function()
								v101({ "hitsound", "general" }, "hitblocked", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9.5, function()
								v101({ "hitsound", "extras" }, "grapple2", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(10.3, function()
								v101({ "hitsound", "general" }, "hitbackstab", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(10.3, function()
								v101({ "deaths" }, "slash", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(11, function()
								v101({ "shadow" }, "skinner_noise4", p96[1].hoverpart, nil, true, false, true);
							end);
						end;
						local v746 = tick();
						while true do
							RS:wait();
							if not (15 <= tick() - v746) then

							else
								break;
							end;						
						end;
						agent_speak("echo_end");
						local v747, v748, v749 = ipairs(v739:GetChildren());
						while true do
							local v750, v751 = v747(v748, v749);
							if v750 then

							else
								break;
							end;
							v749 = v750;
							if v751:FindFirstChild("torso") then
								local v752 = l__game__7.ReplicatedStorage.effects.echoball:Clone();
								l__Debris__27:AddItem(v752, 10);
								v752.Material = Enum.Material.Neon;
								v752.CFrame = v751.torso.CFrame;
								v752.fx.Enabled = false;
								v752.Parent = l__CurrentCamera__1;
								v752.flash:Emit(math.random(10, 20));
								spawn(function()
									while true do
										v752.Size = v752.Size + Vector3.new(0.5, 0.5, 0.5);
										v752.Transparency = v752.Transparency + 0.1;
										RS:wait();
										if not (1 <= v752.Transparency) then

										else
											break;
										end;									
									end;
								end);
							end;						
						end;
						v739:Destroy();
						v101({ "general_ui" }, "echo_close", p96[1].hoverpart, 0.01, true, false);
						current_in_echo = false;
					end;
				end;
			elseif p94 == "scanarea" then
				if p96[1] ~= nil then
					local l__activestats__753 = v19.scan.activestats;
					local v754 = l__game__7.ReplicatedStorage.effects.scanball:Clone();
					l__Debris__27:AddItem(v754, 20);
					v754.CFrame = p96[1];
					v754.Parent = l__CurrentCamera__1;
					if p95 == character then
						spawn(function()
							local v755 = tick();
							maingui.PerkFrame.durationbar.Visible = true;
							maingui.PerkFrame.durationbar.fill.Size = UDim2.new(1, 0, 1, 0);
							while true do
								maingui.PerkFrame.durationbar.fill.Size = UDim2.new(1 - math.clamp((tick() - v755) / l__activestats__753.scanlast, 0, 1), 0, 1, 0);
								RS:wait();
								if not (l__activestats__753.scanlast <= tick() - v755) then

								else
									break;
								end;							
							end;
							maingui.PerkFrame.durationbar.Visible = false;
						end);
					end;
					spawn(function()
						local v756, v757, v758 = ipairs(l__workspace__1.Interactables:GetChildren());
						while true do
							local v759, v760 = v756(v757, v758);
							if v759 then

							else
								break;
							end;
							if v760:FindFirstChild("Interact") then
								if (v760.Interact.Position - p96[1].p).magnitude <= l__activestats__753.studsscan then
									if v760.Name ~= "Heavy Ammo" then
										if v760.Name ~= "Shells Ammo" then
											if v760.Name ~= "Light Ammo" then
												if v760.Name ~= "Long Ammo" then
													if v760.Name ~= "Short Ammo" then
														if v760.Name ~= "Medium Ammo" then
															if v760.Name == "Small Ammo" then
																u98(v760.Interact, false, l__activestats__753.scanlast);
															else
																u98(v760.Interact, false, l__activestats__753.scanlast);
															end;
														else
															u98(v760.Interact, false, l__activestats__753.scanlast);
														end;
													else
														u98(v760.Interact, false, l__activestats__753.scanlast);
													end;
												else
													u98(v760.Interact, false, l__activestats__753.scanlast);
												end;
											else
												u98(v760.Interact, false, l__activestats__753.scanlast);
											end;
										else
											u98(v760.Interact, false, l__activestats__753.scanlast);
										end;
									else
										u98(v760.Interact, false, l__activestats__753.scanlast);
									end;
								end;
							end;
							if v760:FindFirstChild("HarvestWood") then
								if (v760.HarvestWood.Position - p96[1].p).magnitude <= l__activestats__753.studsscan then
									u98(v760.HarvestWood, false, l__activestats__753.scanlast);
								end;
							end;
							if v760:FindFirstChild("HarvestStone") then
								if (v760.HarvestStone.Position - p96[1].p).magnitude <= l__activestats__753.studsscan then
									u98(v760.HarvestStone, false, l__activestats__753.scanlast);
								end;
							end;						
						end;
						local v761, v762, v763 = ipairs(l__workspace__1.WeaponDrops:GetChildren());
						while true do
							local v764, v765 = v761(v762, v763);
							if v764 then

							else
								break;
							end;
							v763 = v764;
							if v765:FindFirstChild("JointGrip") then
								if (v765.JointGrip.Position - p96[1].p).magnitude <= l__activestats__753.studsscan then
									u98(v765.JointGrip, false, l__activestats__753.scanlast);
								end;
							end;						
						end;
						local v766, v767, v768 = ipairs(l__workspace__1.activeHostiles:GetChildren());
						while true do
							local v769, v770 = v766(v767, v768);
							if v769 then

							else
								break;
							end;
							v768 = v769;
							if v770:FindFirstChild("Torso") then
								if v770:FindFirstChild("Head") then
									if v770:FindFirstChild("Humanoid") then
										if 0 <= v770.Humanoid.Health then
											if (v770.Torso.Position - p96[1].p).magnitude <= l__activestats__753.studsscan then
												local v771 = l__game__7.ReplicatedStorage.effects.health_scanned:Clone();
												l__Debris__27:AddItem(v771, l__activestats__753.scanlast);
												v771.Adornee = v770.Torso;
												v771.Parent = ply.PlayerGui;
												v771.update_health.Disabled = false;
											end;
										end;
									end;
								end;
							end;						
						end;
					end);
					spawn(function()
						while true do
							v754.Size = v754.Size + Vector3.new(2, 2, 2);
							v754.Transparency = v754.Transparency + 0.025;
							RS:wait();
							if not (1 <= v754.Transparency) then

							else
								break;
							end;						
						end;
						delay(3, function()
							v754.fx.Enabled = false;
						end);
					end);
				end;
			elseif p94 == "player_ping" then
				if p96[1] ~= nil then
					if l__workspace__1.NoTarget:FindFirstChild(p96[2] .. "PING_CAT" .. p96[3]) then
						l__workspace__1.NoTarget:FindFirstChild(p96[2] .. "PING_CAT" .. p96[3]):Destroy();
					end;
					local v772 = l__game__7.ReplicatedStorage.misc.ping_indicator:Clone();
					v772.Name = p96[2] .. "PING_CAT" .. p96[3];
					l__Debris__27:AddItem(v772, 20);
					v772.CFrame = CFrame.new(p96[1]);
					v772.bb.pinger.Text = p96[2];
					v772.Parent = l__workspace__1.NoTarget;
					local v773 = v772.bb:FindFirstChild("ping_cat" .. p96[3]);
					if v773 then
						v773.Visible = true;
						local v774 = v773:Clone();
						v774.Parent = v772.bb;
						spawn(function()
							while true do
								if v774 then
									if v773 then
										v774.Size = v774.Size + UDim2.new(0, 2, 0, 2);
										v774.ImageTransparency = v774.ImageTransparency + 0.05;
									end;
								end;
								RS:wait();
								if not (1 <= v774.ImageTransparency) then

								else
									break;
								end;
								if v773 ~= nil then

								else
									break;
								end;							
							end;
							v774:Destroy();
						end);
					end;
					local v775 = "ping_area";
					if p96[3] == 2 then
						v775 = "ping_enemy";
					elseif p96[3] == 3 then
						v775 = "ping_item";
					end;
					v101({ "general_ui" }, v775, nil, nil, true, true);
					local v776 = maingui.teammatesframe:FindFirstChild(p96[2]);
					if v776 then
						if v776:FindFirstChild("empty") then
							local v777 = "[Moving Here]";
							local v778 = Color3.fromRGB(255, 182, 122);
							if p96[3] == 3 then
								v778 = Color3.fromRGB(122, 232, 92);
								v777 = "[Marked " .. p96[4] .. "]";
							elseif p96[3] == 2 then
								v778 = Color3.fromRGB(216, 60, 60);
								v777 = "[Hostile]";
							elseif p96[3] == 4 then
								v778 = Color3.fromRGB(102, 137, 255);
								v777 = "[Located " .. p96[4] .. "]";
							elseif p96[3] == 5 then
								v778 = Color3.fromRGB(183, 89, 255);
								v777 = "[" .. p96[4] .. "]";
							end;
							local v779 = l__game__7.ReplicatedStorage.misc.ping_text:Clone();
							l__Debris__27:AddItem(v779, 6);
							v779.TextColor3 = v778;
							v779.Text = v777;
							v779.bg.ImageColor3 = v778;
							if v776:FindFirstChild("empty"):FindFirstChild("ping_text") then
								v776:FindFirstChild("empty"):FindFirstChild("ping_text"):Destroy();
							end;
							v779.Parent = v776:FindFirstChild("empty");
							spawn(function()
								while true do
									if v779 then
										if v779:FindFirstChild("bg") then
											v779.bg.ImageTransparency = v779.bg.ImageTransparency + 0.05;
											v779.bg.Size = v779.bg.Size + UDim2.new(0, 2, 0, 0);
										end;
									end;
									RS:wait();
									if v779 ~= nil then

									else
										break;
									end;
									if v779:FindFirstChild("bg") ~= nil then

									else
										break;
									end;
									if not (1 <= v779.bg.ImageTransparency) then

									else
										break;
									end;								
								end;
							end);
						end;
					end;
				end;
			elseif p94 == "selfscan" then
				local l__activestats__101 = v19.scan.activestats;
				spawn(function()
					local v780, v781, v782 = ipairs(l__workspace__1.Interactables:GetChildren());
					while true do
						local v783, v784 = v780(v781, v782);
						if v783 then

						else
							break;
						end;
						if v784:FindFirstChild("Interact") then
							if (v784.Interact.Position - character.HumanoidRootPart.Position).magnitude <= l__activestats__101.scan_around then
								if v784.Name ~= "Heavy Ammo" then
									if v784.Name ~= "Shells Ammo" then
										if v784.Name ~= "Light Ammo" then
											if v784.Name ~= "Long Ammo" then
												if v784.Name ~= "Short Ammo" then
													if v784.Name ~= "Medium Ammo" then
														if v784.Name == "Small Ammo" then
															u98(v784.Interact, true, l__activestats__101.scan_around_timer);
														else
															u98(v784.Interact, true, l__activestats__101.scan_around_timer);
														end;
													else
														u98(v784.Interact, true, l__activestats__101.scan_around_timer);
													end;
												else
													u98(v784.Interact, true, l__activestats__101.scan_around_timer);
												end;
											else
												u98(v784.Interact, true, l__activestats__101.scan_around_timer);
											end;
										else
											u98(v784.Interact, true, l__activestats__101.scan_around_timer);
										end;
									else
										u98(v784.Interact, true, l__activestats__101.scan_around_timer);
									end;
								else
									u98(v784.Interact, true, l__activestats__101.scan_around_timer);
								end;
							end;
						end;
						if v784:FindFirstChild("HarvestWood") then
							if (v784.HarvestWood.Position - character.HumanoidRootPart.Position).magnitude <= l__activestats__101.scan_around then
								u98(v784.HarvestWood, true, l__activestats__101.scan_around_timer);
							end;
						end;
						if v784:FindFirstChild("HarvestStone") then
							if (v784.HarvestStone.Position - character.HumanoidRootPart.Position).magnitude <= l__activestats__101.scan_around then
								u98(v784.HarvestStone, true, l__activestats__101.scan_around_timer);
							end;
						end;					
					end;
					local v785, v786, v787 = ipairs(l__workspace__1.WeaponDrops:GetChildren());
					while true do
						local v788, v789 = v785(v786, v787);
						if v788 then

						else
							break;
						end;
						v787 = v788;
						if v789:FindFirstChild("JointGrip") then
							if (v789.JointGrip.Position - character.HumanoidRootPart.Position).magnitude <= l__activestats__101.scan_around then
								u98(v789.JointGrip, true, l__activestats__101.scan_around_timer);
							end;
						end;					
					end;
				end);
			elseif p94 == "tased" then
				local v790 = createfxoutline("tasedParticle", 1.7);
			elseif p94 == "decap" then
				if p95:FindFirstChild("Head") == nil then
					return;
				end;
				local l__Head__791 = p95.Head;
				local v792 = l__game__7.ReplicatedStorage.effects.gFX.decap.decapstump:Clone();
				v792.CFrame = p95.Torso.CFrame;
				local v793 = Instance.new("Weld");
				v793.Part0 = v792;
				v793.Part1 = p95.Torso;
				v793.C1 = CFrame.new(0, 1, 0);
				v793.Parent = v792;
				v792.Parent = p95;
				local v794 = l__game__7.ReplicatedStorage.effects.gFX.decap.decapblock:Clone();
				local v795 = Instance.new("Weld");
				v795.Part0 = v794;
				v795.Part1 = l__Head__791;
				v795.Parent = v794;
				v795.Parent = p95;
				v794.Parent = p95;
				l__Head__791.CFrame = l__Head__791.CFrame * CFrame.new(0, 0.2, 0);
				RS:wait();
				l__Head__791.Velocity = l__Head__791.Velocity + Vector3.new(math.random(-3, 3), 20, math.random(-3, 3));
			elseif p94 == "crush" then
				local v796, v797, v798 = ipairs(p95:GetChildren());
				while true do
					local v799, v800 = v796(v797, v798);
					if v799 then

					else
						break;
					end;
					v798 = v799;
					if v800:IsA("Accessory") then
						v800:Destroy();
					end;				
				end;
				local v801, v802, v803 = ipairs(p95.Head:GetChildren());
				while true do
					local v804, v805 = v801(v802, v803);
					if v804 then

					else
						break;
					end;
					v803 = v804;
					if v805:IsA("Decal") then
						v805:Destroy();
					end;				
				end;
				if p95:FindFirstChild("Outfit") then
					if p95:FindFirstChild("Outfit"):FindFirstChild("Head") then
						local v806, v807, v808 = ipairs(p95:FindFirstChild("Outfit"):GetChildren());
						while true do
							local v809, v810 = v806(v807, v808);
							if v809 then

							else
								break;
							end;
							v808 = v809;
							if v810.Name == "Head" then
								v810:Destroy();
							end;						
						end;
					end;
				end;
				local l__Head__811 = p95.Head;
				local v812 = l__game__7.ReplicatedStorage.effects.gFX.crush.splat:Clone();
				l__Debris__27:AddItem(v812, 9);
				v812.CFrame = p95.Head.CFrame;
				v812.fx1:Emit(math.random(5, 10));
				v812.fx2:Emit(math.random(3, 5));
				v812.Parent = l__workspace__1.NoTarget;
				local v813 = l__game__7.ReplicatedStorage.effects.gFX.crush.bonestump:Clone();
				v813.CFrame = p95.Torso.CFrame;
				local v814 = Instance.new("Weld");
				v814.Part0 = v813;
				v814.Part1 = p95.Torso;
				v814.C1 = CFrame.new(0, 1, 0);
				v814.Parent = v813;
				v813.Parent = p95;
				p95.Head:Destroy();
				local v815 = { "gib", "bone" };
				local v816 = math.random(8, 15);
				local v817 = 1 - 1;
				while true do
					local v818 = l__game__7.ReplicatedStorage.effects.gFX.crush[v815[math.random(1, 2)]]:Clone();
					l__Debris__27:AddItem(v818, 7);
					v818.CFrame = l__Head__811.CFrame * CFrame.new(math.random(-15, 10) / 100, math.random(-15, 10) / 100, math.random(-15, 10) / 100);
					v818.Parent = l__workspace__1.NoTarget;
					v818.Velocity = v818.Velocity + Vector3.new(math.random(-6, 6), math.random(5, 15), math.random(-6, 6));
					if 0 <= 1 then
						if v817 < v816 then

						else
							break;
						end;
					elseif v816 < v817 then

					else
						break;
					end;
					v817 = v817 + 1;				
				end;
			elseif p94 == "arrowimpact" then
				local v819 = l__game__7.ReplicatedStorage.effects.gFX.arrowdeath.arrowimpact:Clone();
				v819.CFrame = p95.Head.CFrame;
				local v820 = Instance.new("Weld");
				v820.Part0 = v819;
				v820.Part1 = p95.Head;
				v820.Parent = v819;
				v819.Parent = p95;
				v819.gorepoint.bleedpoint1.splat.Enabled = true;
				v819.gorepoint.bleedpoint2.splat.Enabled = true;
				v819.gorepoint.bleedpoint1.splat:Emit(30, 50);
				v819.gorepoint.bleedpoint2.splat:Emit(30, 50);
				v819.gorepoint.bleedpoint1.splat.Enabled = false;
				v819.gorepoint.bleedpoint2.splat.Enabled = false;
			elseif p94 == "headshot_gun" then
				local v821 = l__game__7.ReplicatedStorage.effects.gFX.headshotdeath.headshotimpact:Clone();
				v821.CFrame = p95.Head.CFrame;
				local v822 = Instance.new("Weld");
				v822.Part0 = v821;
				v822.Part1 = p95.Head;
				v822.Parent = v821;
				v821.Parent = p95;
				v821.gorepoint.bleedpoint1.splat.Enabled = true;
				v821.gorepoint.bleedpoint1.cloud.Enabled = true;
				v821.gorepoint.bleedpoint2.splat.Enabled = true;
				v821.gorepoint.bleedpoint1.cloud:Emit(1, 3);
				v821.gorepoint.bleedpoint1.splat:Emit(30, 50);
				v821.gorepoint.bleedpoint2.splat:Emit(30, 50);
				v821.gorepoint.bleedpoint1.splat.Enabled = false;
				v821.gorepoint.bleedpoint1.cloud.Enabled = false;
				v821.gorepoint.bleedpoint2.splat.Enabled = false;
				v101({ "deaths" }, "headshot" .. math.random(1, 2), p95.Head, nil, true, false);
				v101({ "deaths" }, "decap", p95.Head, nil, true, false);
				if p96 ~= nil then
					if p96 == "self" then
						v821.gorepoint.Transparency = 1;
						v821.gorepoint.bleedpoint1.drip.Enabled = false;
						v821.gorepoint.bleedpoint2.drip.Enabled = false;
					end;
				end;
			elseif p94 ~= "head_bonk" then
				if p94 == "axe_embed" then
					local v823 = l__game__7.ReplicatedStorage.effects.gFX.blunthead.headbonk:Clone();
					v823.CFrame = p95.Head.CFrame;
					local v824 = Instance.new("Weld");
					v824.Part0 = v823;
					v824.Part1 = p95.Head;
					v824.Parent = v823;
					v823.Parent = p95;
					RS:wait();
					v823.gorepoint.bleedpoint1.splat.Enabled = true;
					v823.gorepoint.bleedpoint1.cloud.Enabled = true;
					v823.gorepoint.bleedpoint1.cloud:Emit(1, 3);
					v823.gorepoint.bleedpoint1.splat:Emit(15, 30);
					v823.gorepoint.bleedpoint1.splat.Enabled = false;
					v823.gorepoint.bleedpoint1.cloud.Enabled = false;
					if p94 == "head_bonk" then
						v101({ "deaths" }, "headbonk", p95.Head, nil, true, false);
					else
						local v825 = l__game__7.ReplicatedStorage.effects.gFX.axe_head.axed:Clone();
						v825.CFrame = p95.Head.CFrame;
						local v826 = Instance.new("Weld");
						v826.Part0 = v825;
						v826.Part1 = p95.Head;
						v826.Parent = v825;
						v825.Parent = p95;
						v101({ "deaths" }, "tear", p95.Head, nil, true, false);
						v101({ "deaths" }, "axe_hit", p95.Head, nil, true, false);
					end;
				elseif p94 ~= "take_limbs_arms" then
					if p94 == "take_limbs_legs" then
						local v827 = l__game__7.ReplicatedStorage.effects.gFX.limbremove.torsopart:Clone();
						v827.CFrame = p95.Torso.CFrame;
						local v828 = Instance.new("Weld");
						v828.Part0 = v827;
						v828.Part1 = p95.Torso;
						v828.Parent = v827;
						local v829 = "Left Arm";
						if math.random(1, 2) == 1 then
							v829 = "Right Arm";
						end;
						if p94 == "take_limbs_legs" then
							v829 = "Left Leg";
							if math.random(1, 2) == 1 then
								v829 = "Right Leg";
							end;
						end;
						local v830, v831, v832 = ipairs(v827:GetChildren());
						while true do
							local v833, v834 = v830(v831, v832);
							if v833 then

							else
								break;
							end;
							v832 = v833;
							if v834:IsA("BasePart") then
								if v834.Name ~= v829 then
									v834:Destroy();
								end;
							end;						
						end;
						v827.Parent = p95;
						if p95:FindFirstChild(v829) then
							p95:FindFirstChild(v829):Destroy();
						end;
						if p95:FindFirstChild("Outfit") then
							if p94 == "take_limbs_legs" then
								if p95.Outfit:FindFirstChild("Bottom") then
									if p95.Outfit.Bottom:FindFirstChild(v829) then
										p95.Outfit.Bottom:FindFirstChild(v829):Destroy();
									end;
								end;
							elseif p95.Outfit:FindFirstChild("Top") then
								if p95.Outfit.Top:FindFirstChild(v829) then
									p95.Outfit.Top:FindFirstChild(v829):Destroy();
								end;
							end;
						end;
						v101({ "deaths" }, "flesh", p95.Torso, nil, true, false);
						v101({ "deaths" }, "gurgle", p95.Torso, nil, true, false);
						v827:FindFirstChild(v829).attach.cloud.Enabled = true;
						v827:FindFirstChild(v829).attach.gib.Enabled = true;
						v827:FindFirstChild(v829).attach.cloud:Emit(math.random(1, 3));
						v827:FindFirstChild(v829).attach.gib:Emit(math.random(3, 7));
						v827:FindFirstChild(v829).attach.cloud.Enabled = false;
						v827:FindFirstChild(v829).attach.gib.Enabled = false;
					elseif p94 == "torso_cut" then
						local v835 = l__game__7.ReplicatedStorage.effects.gFX.torsocut.Torso:Clone();
						v835.CFrame = p95.Torso.CFrame;
						local v836 = Instance.new("Weld");
						v836.Part0 = v835;
						v836.Part1 = p95.Torso;
						v836.Parent = v835;
						v835.Parent = p95.Torso;
					elseif p94 == "pukedeath" then
						v101({ "deaths" }, "gurgle", p95.Head, nil, true, false);
						delay(0.5, function()
							v101({ "deaths" }, "puke", p95.Head, nil, true, false);
							local v837 = l__game__7.ReplicatedStorage.effects.gFX.pukedeath.puke:Clone();
							v837.CFrame = p95.Head.CFrame;
							local v838 = Instance.new("Weld");
							v838.Part0 = v837;
							v838.Part1 = p95.Head;
							v838.Parent = v837;
							v837.Parent = p95;
							v837.pukepoint.splat.Enabled = true;
							v837.pukepoint.splat2.Enabled = true;
							v837.pukepoint.splat:Emit(math.random(10, 20));
							v837.pukepoint.splat2:Emit(math.random(10, 20));
							RS:wait();
							v837.pukepoint.splat.Enabled = false;
							v837.pukepoint.splat2.Enabled = false;
						end);
					elseif p94 == "stomachrip" then
						local v839 = l__game__7.ReplicatedStorage.effects.gFX.spearstomach.torsoFX:Clone();
						v839.CFrame = p95.Torso.CFrame;
						local v840 = Instance.new("Weld");
						v840.Part0 = v839;
						v840.Part1 = p95.Torso;
						v840.Parent = v839;
						v839.Parent = p95;
						v839.fxpart.splat:Emit(30, 50);
						v839.fxpart.splat2:Emit(15, 30);
						local v841 = math.random(6, 10);
						local v842 = 1 - 1;
						while true do
							local v843 = l__game__7.ReplicatedStorage.effects.gFX.spearstomach.gib:Clone();
							l__Debris__27:AddItem(v843, 7);
							v843.CFrame = p95.Torso.CFrame * CFrame.new(math.random(-15, 10) / 100, math.random(-15, 10) / 100, math.random(-15, 10) / 100);
							v843.Parent = l__workspace__1.NoTarget;
							v843.Velocity = v843.Velocity + p95.Torso.CFrame.lookVector * 3;
							if 0 <= 1 then
								if v842 < v841 then

								else
									break;
								end;
							elseif v841 < v842 then

							else
								break;
							end;
							v842 = v842 + 1;						
						end;
					elseif p94 == "neckcut" then
						local v844 = l__game__7.ReplicatedStorage.effects.gFX.neckcut.fx:Clone();
						l__Debris__27:AddItem(v844, 9);
						v844.CFrame = p95.Torso.CFrame;
						local v845 = Instance.new("Weld");
						v845.Part0 = v844;
						v845.Part1 = p95.Torso;
						v845.Parent = v844;
						v845.Parent = p95;
						v844.Parent = p95;
						delay(2, function()
							v844.point.drip.Enabled = false;
							v844.point.fx1.Enabled = false;
						end);
						v844.point.fx2:Emit(1);
						v844.point.gib:Emit(math.random(2, 5));
						local v846 = l__game__7.ReplicatedStorage.effects.gFX.neckcut.neckpart:Clone();
						l__Debris__27:AddItem(v846, 7);
						v846.CFrame = p95.Head.CFrame + p95.Head.CFrame.lookVector * 1;
						v846.Parent = l__workspace__1.NoTarget;
						v846.Velocity = v846.Velocity + p95.Head.CFrame.lookVector * 3;
					elseif p94 == "explosive" then
						local l__HumanoidRootPart__847 = p95:FindFirstChild("HumanoidRootPart");
						if l__HumanoidRootPart__847 then

						else
							return;
						end;
						local v848, v849, v850 = ipairs(p95:GetChildren());
						while true do
							local v851, v852 = v848(v849, v850);
							if v851 then

							else
								break;
							end;
							v850 = v851;
							if v852.Name ~= "Torso" then
								if v852.Name ~= "Humanoid" then
									if v852.Name ~= "active" then
										v852:Destroy();
									elseif v852:IsA("BasePart") then
										v852.Transparency = 1;
										local v853, v854, v855 = ipairs(v852:GetChildren());
										while true do
											local v856, v857 = v853(v854, v855);
											if v856 then

											else
												break;
											end;
											v855 = v856;
											if v857:IsA("Decal") then
												v857:Destroy();
											end;										
										end;
									end;
								elseif v852:IsA("BasePart") then
									v852.Transparency = 1;
									v853, v854, v855 = ipairs(v852:GetChildren());
									while true do
										v856, v857 = v853(v854, v855);
										if v856 then

										else
											break;
										end;
										v855 = v856;
										if v857:IsA("Decal") then
											v857:Destroy();
										end;									
									end;
								end;
							elseif v852:IsA("BasePart") then
								v852.Transparency = 1;
								v853, v854, v855 = ipairs(v852:GetChildren());
								while true do
									v856, v857 = v853(v854, v855);
									if v856 then

									else
										break;
									end;
									v855 = v856;
									if v857:IsA("Decal") then
										v857:Destroy();
									end;								
								end;
							end;						
						end;
						if p95:FindFirstChild("Torso") then
							p95:FindFirstChild("Torso").Anchored = true;
							p95:FindFirstChild("Torso").Transparency = 1;
						end;
						local v858 = l__game__7.ReplicatedStorage.effects.gFX.explosion.explosiongib:Clone();
						l__Debris__27:AddItem(v858, 10);
						v858.CFrame = CFrame.new(l__HumanoidRootPart__847.Position) * CFrame.new(0, 1, 0);
						v858.Parent = l__workspace__1.NoTarget;
						v858.cloud:Emit(math.random(5, 8));
						v858.dust:Emit(math.random(5, 8));
						v858.expandcloud:Emit(math.random(5, 8));
						v858.gib:Emit(math.random(8, 12));
						local v859 = math.random(8, 12);
						local v860 = 1 - 1;
						while true do
							local v861 = l__game__7.ReplicatedStorage.effects.gFX.crush.gib:Clone();
							l__Debris__27:AddItem(v861, 7);
							v861.CFrame = v858.CFrame * CFrame.new(math.random(-15, 10) / 100, math.random(-15, 10) / 100, math.random(-15, 10) / 100);
							v861.Parent = l__workspace__1.NoTarget;
							v861.Velocity = v861.Velocity + Vector3.new(math.random(-12, 12), math.random(15, 20), math.random(-12, 12));
							if 0 <= 1 then
								if v860 < v859 then

								else
									break;
								end;
							elseif v859 < v860 then

							else
								break;
							end;
							v860 = v860 + 1;						
						end;
					elseif p94 == "armcut" then
						local v862 = l__game__7.ReplicatedStorage.effects.gFX.armcut.torsocopy:Clone();
						local v863 = l__game__7.ReplicatedStorage.effects.gFX.armcut.cutarm:Clone();
						v862.beam.Attachment0 = v862.a0;
						v862.beam.Attachment1 = v863.a1;
						local v864 = Instance.new("Weld");
						v864.Part0 = v862;
						v864.Part1 = p95.Torso;
						v864.Parent = v862;
						v862.Parent = p95;
						v863.CFrame = p95["Left Arm"].CFrame;
						local v865 = Instance.new("Weld");
						v865.Part0 = v863;
						v865.Part1 = p95["Left Arm"];
						v865.Parent = v863;
						v863.Parent = p95["Left Arm"];
						p95["Left Arm"].Velocity = p95["Left Arm"].Velocity + -p95.Torso.CFrame.rightVector * 5;
						delay(0.5, function()
							local v866 = 1 - 1;
							while true do
								local v867 = 1.5 * (1 - v866 / 15);
								v862.beam.Width0 = v867;
								v862.beam.Width1 = v867;
								RS:wait();
								if 0 <= 1 then
									if v866 < 15 then

									else
										break;
									end;
								elseif 15 < v866 then

								else
									break;
								end;
								v866 = v866 + 1;							
							end;
							v862.beam:Destroy();
						end);
					elseif p94 == "slice" then
						local v868, v869, v870 = ipairs(p95.Torso:GetChildren());
						while true do
							local v871, v872 = v868(v869, v870);
							if v871 then

							else
								break;
							end;
							v870 = v871;
							if v872:IsA("Decal") then
								v872:Destroy();
							end;						
						end;
						local l__Shirt__873 = p95:FindFirstChild("Shirt");
						if l__Shirt__873 == nil then
							local l__Pants__874 = p95:FindFirstChild("Pants");
							if l__Pants__874 == nil then
								local v875 = "";
							else
								v875 = l__Pants__874.PantsTemplate;
							end;
						else
							v875 = l__Shirt__873.ShirtTemplate;
						end;
						local v876 = l__game__7.ReplicatedStorage.effects.gFX.slice.slicehalf:Clone();
						v876.BrickColor = p95.Torso.BrickColor;
						v876.TextureID = v875;
						v876.CFrame = p95.Torso.CFrame;
						local v877 = Instance.new("Weld");
						v877.Part0 = v876;
						v877.Part1 = p95.Torso;
						v877.C1 = CFrame.new(0.6, 0, 0);
						v877.Parent = v876;
						v876.Parent = p95;
						p95.Torso.Transparency = 1;
						local v878 = l__game__7.ReplicatedStorage.effects.gFX.slice.otherslicehalf:Clone();
						local l__Shirt__879 = p95:FindFirstChild("Shirt");
						if l__Shirt__879 then
							l__Shirt__879:Clone().Parent = v878;
						end;
						local l__Pants__880 = p95:FindFirstChild("Pants");
						if l__Pants__880 then
							l__Pants__880:Clone().Parent = v878;
						end;
						local v881, v882, v883 = ipairs(v878:GetChildren());
						while true do
							local v884, v885 = v881(v882, v883);
							if v884 then

							else
								break;
							end;
							v883 = v884;
							if p95:FindFirstChild(v885.Name) then
								if v885:IsA("BasePart") then
									v885.BrickColor = p95:FindFirstChild(v885.Name).BrickColor;
								end;
							end;						
						end;
						v878.Torso.otherhalf.BrickColor = p95.Torso.BrickColor;
						v878.Torso.otherhalf.TextureID = v875;
						v878:SetPrimaryPartCFrame(p95.Torso.CFrame);
						v878.Parent = p95;
						v876.beam1.Attachment1 = v878.Torso.otherhalf.a1;
						v876.beam2.Attachment1 = v878.Torso.otherhalf.b1;
						v876.beam3.Attachment1 = v878.Torso.otherhalf.c1;
						p95["Left Arm"]:Destroy();
						p95["Left Leg"]:Destroy();
						RS:wait();
						v878.Humanoid.PlatformStand = true;
						v878.Torso.Velocity = v878.Torso.Velocity + v878.Torso.CFrame.rightVector * 6;
						if p95.Torso:FindFirstChild("Neck") then
							p95.Torso.Neck.C1 = CFrame.new(-0.341941595, -0.544243574, 0.0124545023, -0.951813221, 0, -0.306678385, -0.301639259, 0.180534005, 0.936173737, 0.0553658754, 0.983568728, -0.171834648);
							p95.Torso.Neck.C0 = CFrame.new(0, 1, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0);
						end;
						delay(0.5, function()
							local v886 = 1 - 1;
							while true do
								local v887 = 1.5 * (1 - v886 / 15);
								v876.beam1.Width0 = v887;
								v876.beam1.Width1 = v887;
								v876.beam2.Width0 = v887;
								v876.beam2.Width1 = v887;
								v876.beam3.Width0 = v887;
								v876.beam3.Width1 = v887;
								RS:wait();
								if 0 <= 1 then
									if v886 < 15 then

									else
										break;
									end;
								elseif 15 < v886 then

								else
									break;
								end;
								v886 = v886 + 1;							
							end;
							v876.beam1:Destroy();
							v876.beam2:Destroy();
							v876.beam3:Destroy();
						end);
					end;
				else
					v827 = l__game__7.ReplicatedStorage.effects.gFX.limbremove.torsopart:Clone();
					v827.CFrame = p95.Torso.CFrame;
					v828 = Instance.new("Weld");
					v828.Part0 = v827;
					v828.Part1 = p95.Torso;
					v828.Parent = v827;
					v829 = "Left Arm";
					if math.random(1, 2) == 1 then
						v829 = "Right Arm";
					end;
					if p94 == "take_limbs_legs" then
						v829 = "Left Leg";
						if math.random(1, 2) == 1 then
							v829 = "Right Leg";
						end;
					end;
					v830, v831, v832 = ipairs(v827:GetChildren());
					while true do
						v833, v834 = v830(v831, v832);
						if v833 then

						else
							break;
						end;
						v832 = v833;
						if v834:IsA("BasePart") then
							if v834.Name ~= v829 then
								v834:Destroy();
							end;
						end;					
					end;
					v827.Parent = p95;
					if p95:FindFirstChild(v829) then
						p95:FindFirstChild(v829):Destroy();
					end;
					if p95:FindFirstChild("Outfit") then
						if p94 == "take_limbs_legs" then
							if p95.Outfit:FindFirstChild("Bottom") then
								if p95.Outfit.Bottom:FindFirstChild(v829) then
									p95.Outfit.Bottom:FindFirstChild(v829):Destroy();
								end;
							end;
						elseif p95.Outfit:FindFirstChild("Top") then
							if p95.Outfit.Top:FindFirstChild(v829) then
								p95.Outfit.Top:FindFirstChild(v829):Destroy();
							end;
						end;
					end;
					v101({ "deaths" }, "flesh", p95.Torso, nil, true, false);
					v101({ "deaths" }, "gurgle", p95.Torso, nil, true, false);
					v827:FindFirstChild(v829).attach.cloud.Enabled = true;
					v827:FindFirstChild(v829).attach.gib.Enabled = true;
					v827:FindFirstChild(v829).attach.cloud:Emit(math.random(1, 3));
					v827:FindFirstChild(v829).attach.gib:Emit(math.random(3, 7));
					v827:FindFirstChild(v829).attach.cloud.Enabled = false;
					v827:FindFirstChild(v829).attach.gib.Enabled = false;
				end;
			else
				v823 = l__game__7.ReplicatedStorage.effects.gFX.blunthead.headbonk:Clone();
				v823.CFrame = p95.Head.CFrame;
				v824 = Instance.new("Weld");
				v824.Part0 = v823;
				v824.Part1 = p95.Head;
				v824.Parent = v823;
				v823.Parent = p95;
				RS:wait();
				v823.gorepoint.bleedpoint1.splat.Enabled = true;
				v823.gorepoint.bleedpoint1.cloud.Enabled = true;
				v823.gorepoint.bleedpoint1.cloud:Emit(1, 3);
				v823.gorepoint.bleedpoint1.splat:Emit(15, 30);
				v823.gorepoint.bleedpoint1.splat.Enabled = false;
				v823.gorepoint.bleedpoint1.cloud.Enabled = false;
				if p94 == "head_bonk" then
					v101({ "deaths" }, "headbonk", p95.Head, nil, true, false);
				else
					v825 = l__game__7.ReplicatedStorage.effects.gFX.axe_head.axed:Clone();
					v825.CFrame = p95.Head.CFrame;
					v826 = Instance.new("Weld");
					v826.Part0 = v825;
					v826.Part1 = p95.Head;
					v826.Parent = v825;
					v825.Parent = p95;
					v101({ "deaths" }, "tear", p95.Head, nil, true, false);
					v101({ "deaths" }, "axe_hit", p95.Head, nil, true, false);
				end;
			end;
		elseif p94 == "firegun" then
			v698 = l__game__7.ReplicatedStorage.effects.gunTrail:Clone();
			l__Debris__27:AddItem(v698, 3);
			v698.trailA.CFrame = CFrame.new(p96[1]);
			v698.trailB.CFrame = CFrame.new(p96[2]);
			v698.Parent = l__workspace__1.NoTarget;
			v699 = l__game__7.ReplicatedStorage.effects.bullet_trail:Clone();
			l__Debris__27:AddItem(v699, 0.2);
			v699.CFrame = CFrame.new(p96[1], p96[2]);
			v699.CFrame = v699.CFrame + v699.CFrame.lookVector * math.random(15, 25);
			if p96[3] == false then
				v699.Parent = l__workspace__1.NoTarget;
				spawn(function()
					RS:wait();
					v699.Velocity = v699.Velocity + v699.CFrame.lookVector * 1000;
				end);
			end;
			if p96[4] == nil then
				if 0.02 < tick() - crackcd then
					v101({ "firearms" }, "crack", v698.trailB, 0.1, true, false);
				end;
				crackcd = tick();
				v698.trailB.debrisA.Enabled = true;
				v698.trailB.debrisB.Enabled = true;
				v698.trailB.smoke.Enabled = true;
				v698.trailB.spark.Enabled = true;
				v698.trailB.debrisA:Emit(math.random(3, 6));
				v698.trailB.debrisB:Emit(math.random(3, 6));
				v698.trailB.smoke:Emit(math.random(2, 4));
				v698.trailB.spark:Emit(math.random(8, 12));
				v698.trailB.debrisA.Enabled = false;
				v698.trailB.debrisB.Enabled = false;
				v698.trailB.smoke.Enabled = false;
				v698.trailB.spark.Enabled = false;
			else
				v101({ "hitsound", "guns" }, "bullet_impact" .. math.random(1, 3), v698.trailB, 0.1, true, false);
			end;
			if p96[5] == nil then
				v700 = l__game__7.ReplicatedStorage.effects.gunFX:Clone();
				l__Debris__27:AddItem(v700, 1);
				v700.CFrame = CFrame.new(p96[1]);
				v700.Parent = l__workspace__1.NoTarget;
				spawn(function()
					if p96[3] == false then
						v700.flash.Enabled = true;
						v700.flash:Emit(1);
						v700.flash.Enabled = false;
						v701 = l__game__7.ReplicatedStorage.misc.muzzleflash:Clone();
						l__Debris__27:AddItem(v701, 0.05);
						v701.Parent = v700;
					end;
					v700.smoke.Enabled = true;
					v700.smoke2.Enabled = true;
					v700.smoke:Emit(math.random(4, 6));
					v700.smoke:Emit(math.random(10, 15));
					v700.smoke.Enabled = false;
					v700.smoke2.Enabled = false;
				end);
			end;
		elseif p94 == "incendiary_trail" then
			v702 = l__game__7.ReplicatedStorage.effects.incendiary_trail:Clone();
			l__Debris__27:AddItem(v702, 3);
			v702.trailA.CFrame = CFrame.new(p96[1]);
			v702.trailB.CFrame = CFrame.new(p96[2]);
			v702.Parent = l__workspace__1.NoTarget;
			if 0.02 < tick() - specialcrackcd then
				v101({ "firearms" }, "incendiary_crack", v702.trailB, 0.1, true, false);
			end;
			specialcrackcd = tick();
			v702.trailB.ember:Emit(math.random(8, 12));
			v702.trailB.flame:Emit(math.random(5, 10));
			v702.trailB.small:Emit(math.random(5, 10));
			spawn(function()
				v703 = 1 - 1;
				while true do
					v702.Beam.Transparency = NumberSequence.new(v703 / 20);
					RS:wait();
					if 0 <= 1 then
						if v703 < 20 then

						else
							break;
						end;
					elseif 20 < v703 then

					else
						break;
					end;
					v703 = v703 + 1;				
				end;
			end);
		elseif p94 == "muzzle_flash" then
			v704 = l__game__7.ReplicatedStorage.effects.gunFX:Clone();
			l__Debris__27:AddItem(v704, 1);
			v704.CFrame = CFrame.new(p96[1]);
			v704.Parent = l__workspace__1.NoTarget;
			spawn(function()
				if p96[2] == false then
					v704.flash.Enabled = true;
					v704.flash:Emit(1);
					v704.flash.Enabled = false;
					v705 = l__game__7.ReplicatedStorage.misc.muzzleflash:Clone();
					l__Debris__27:AddItem(v705, 0.05);
					v705.Parent = v704;
				end;
				v704.smoke.Enabled = true;
				v704.smoke2.Enabled = true;
				v704.smoke:Emit(math.random(4, 6));
				v704.smoke:Emit(math.random(10, 15));
				v704.smoke.Enabled = false;
				v704.smoke2.Enabled = false;
			end);
		elseif p94 == "hangerPopup" then
			local function v706()
				v707 = { "YOU ARE WORTHLESS", "USELESS", "YOU ARE HOPELESS", "HOPELESS", "DIE", "GIVE UP", "YOU ARE USELESS", "WORTHLESS", "MEANINGLESS", "YOU ARE MEANINGLESS" };
				v708 = l__game__7.ReplicatedStorage.soundLibrary.general_ui.static:Clone();
				v708.TimePosition = math.random(1, 30);
				v708.Parent = l__CurrentCamera__1;
				v709 = { "4452726587", "4452726886", "4452727160", "4452727454" };
				v710 = math.random(1, 4);
				v711 = l__game__7.ReplicatedStorage.misc.hangertext:Clone();
				v711.static.Image = "rbxassetid://" .. v709[v710];
				v711.popuptext.Text = v707[math.random(1, #v707)];
				v712 = math.random(20, 80) / 100;
				v713 = math.random(10, 90) / 100;
				v711.popuptext.Position = UDim2.new(v712, 0, v713, 0);
				u99 = 0;
				u100 = v710;
				spawn(function()
					v708:Play();
					v711.Parent = ply.PlayerGui;
					v714 = tick();
					while true do
						v711.popuptext.Position = UDim2.new(v712, math.random(-10, 10), v713, math.random(-10, 10));
						if 0.05 <= tick() - u99 then
							u99 = tick();
							u100 = u100 + 1;
							if 4 < u100 then
								u100 = 1;
							end;
							v711.static.Image = "rbxassetid://" .. v709[u100];
						end;
						RS:wait();
						if not (0.3 <= tick() - v714) then

						else
							break;
						end;					
					end;
					v711:Destroy();
					v708:Destroy();
				end);
			end;
			if character:FindFirstChild("HumanoidRootPart") then
				if (character:FindFirstChild("HumanoidRootPart").Position - p95.Position).magnitude <= 30 then
					v706();
					if (character:FindFirstChild("HumanoidRootPart").Position - p95.Position).magnitude <= 15 then
						delay(1.5, function()
							v706();
						end);
					end;
				end;
			end;
		elseif p94 == "firelaser" then
			v715 = l__game__7.ReplicatedStorage.effects.laserTrail:Clone();
			l__Debris__27:AddItem(v715, 3);
			v715.trailA.CFrame = CFrame.new(p96[1]);
			v715.trailB.CFrame = CFrame.new(p96[2]);
			v715.Parent = l__workspace__1.NoTarget;
			if p96[4] == nil then
				if 0.02 < tick() - crackcd then
					v101({ "hitsound", "general" }, "plasma", v715.trailB, 0.1, true, false);
				end;
				crackcd = tick();
				v715.trailB.debrisA.Enabled = true;
				v715.trailB.debrisB.Enabled = true;
				v715.trailB.smoke.Enabled = true;
				v715.trailB.spark.Enabled = true;
				v715.trailB.debrisA:Emit(math.random(3, 6));
				v715.trailB.debrisB:Emit(math.random(3, 6));
				v715.trailB.smoke:Emit(math.random(2, 4));
				v715.trailB.spark:Emit(math.random(8, 12));
				v715.trailB.debrisA.Enabled = false;
				v715.trailB.debrisB.Enabled = false;
				v715.trailB.smoke.Enabled = false;
				v715.trailB.spark.Enabled = false;
			end;
			if p96[3] ~= nil then
				v715.Beam.Color = ColorSequence.new(Color3.new(0.6392156862745098, 0.13333333333333333, 1));
			end;
			delay(0.3, function()
				v716 = 1 - 1;
				while true do
					v715.Beam.Transparency = NumberSequence.new(v716 / 25);
					RS:wait();
					if 0 <= 1 then
						if v716 < 25 then

						else
							break;
						end;
					elseif 25 < v716 then

					else
						break;
					end;
					v716 = v716 + 1;				
				end;
				v715:Destroy();
			end);
			v717 = l__game__7.ReplicatedStorage.effects.laserFX:Clone();
			if p96[3] ~= nil then
				v718, v719, v720 = ipairs(v717:GetChildren());
				while true do
					v721, v722 = v718(v719, v720);
					if v721 then

					else
						break;
					end;
					v720 = v721;
					if v722:IsA("ParticleEmitter") then
						v722.Color = ColorSequence.new(Color3.new(0.6392156862745098, 0.13333333333333333, 1));
					end;				
				end;
			end;
			l__Debris__27:AddItem(v717, 1);
			v717.CFrame = CFrame.new(p96[1]);
			v717.Parent = l__workspace__1.NoTarget;
			spawn(function()
				v717.flash.Enabled = true;
				v717.flash:Emit(1);
				v717.flash.Enabled = false;
				v717.crystal.Enabled = true;
				v717.crystal:Emit(math.random(2, 4));
				v717.crystal.Enabled = false;
				v717.spark.Enabled = true;
				v717.spark:Emit(math.random(4, 8));
				v717.spark.Enabled = false;
				v717.flare.Enabled = true;
				v717.flare:Emit(1);
				v717.flare.Enabled = false;
			end);
		elseif p94 == "bowarrow" then
			v723 = l__game__7.ReplicatedStorage.effects.bowtrail:Clone();
			v723.CFrame = p96[1];
			v723.Parent = l__workspace__1.NoTarget;
			RS:wait();
			v723.CFrame = p96[1];
			v724, v725 = raycastline(p96[1].p, p96[1].LookVector + p96[2], 80, { l__workspace__1.NoTarget, l__workspace__1.GoreEffects, l__CurrentCamera__1 });
			RS:wait();
			v723.CFrame = CFrame.new(v725);
			if v724 == nil then
				v726 = v725;
				v727 = 1 - 1;
				while true do
					v728, v729 = raycastline(v726, p96[1].LookVector + p96[2] + Vector3.new(0, -0.05, 0), 3, baselayer);
					v723.CFrame = CFrame.new(v729);
					if v728 then
						break;
					end;
					v726 = v729;
					RS:wait();
					if 0 <= 1 then
						if v727 < 200 then

						else
							break;
						end;
					elseif 200 < v727 then

					else
						break;
					end;
					v727 = v727 + 1;				
				end;
			end;
			l__Debris__27:AddItem(v723, 5);
		elseif p94 == "vomit" then
			if p95:FindFirstChild("Head") == nil then
				return;
			end;
			v730 = l__game__7.ReplicatedStorage.effects.vomitBlock:Clone();
			v730.CFrame = p95.Head.CFrame;
			l__Debris__27:AddItem(v730, 3);
			v731 = Instance.new("Weld");
			v731.Part0 = p95.Head;
			v731.Part1 = v730;
			v730.Parent = p95.Head;
			v731.Parent = v730;
			delay(1, function()
				v730.sickParticle.Enabled = false;
			end);
		elseif p94 == "lostecho" then
			if current_in_echo == true then
				return;
			end;
			current_in_echo = true;
			agent_speak("echo_start");
			v732 = l__game__7.ReplicatedStorage.misc.echo_bg:Clone();
			v732.Parent = p96[1].hoverpart;
			v732.Adornee = p96[1].hoverpart;
			v733 = 0;
			v734 = tick();
			v735 = 0.03;
			v736 = 11;
			v737 = tick();
			while true do
				if v735 <= tick() - v734 then
					v734 = tick();
					v735 = math.random(20, 40) / 1000;
					v733 = v733 + 1;
					v732.loading.Text = tostring(v733) .. "%";
					v732.loadingbar.bar.Size = UDim2.new(v733 / 100, 0, 3, 0);
				end;
				if 0.05 <= tick() - v737 then
					if 0 < v736 then
						v737 = tick();
						v736 = v736 - 1;
						v732.loadingbar.Visible = not v732.loadingbar.Visible;
					end;
				end;
				v732.loading.TextTransparency = v732.loading.TextTransparency - 0.03;
				v732.ring.ImageTransparency = v732.ring.ImageTransparency - 0.03;
				v732.ring.Size = v732.ring.Size:Lerp(UDim2.new(1, 0, 1, 0), 0.1);
				RS:wait();
				if not (100 <= v733) then

				else
					break;
				end;
				if p96[1] ~= nil then

				else
					break;
				end;			
			end;
			v732:Destroy();
			if p96[1] then
				v101({ "general_ui" }, "echo_open", p96[1].hoverpart, 0.01, true, false);
				v738 = l__game__7.ReplicatedStorage.effects.echoball:Clone();
				l__Debris__27:AddItem(v738, 20);
				v738.CFrame = p96[1].hoverpart.CFrame;
				v738.Parent = l__CurrentCamera__1;
				spawn(function()
					while true do
						v738.Size = v738.Size + Vector3.new(1, 1, 1);
						v738.Transparency = v738.Transparency + 0.05;
						RS:wait();
						if not (1 <= v738.Transparency) then

						else
							break;
						end;					
					end;
					delay(1.5, function()
						v738.fx.Enabled = false;
					end);
				end);
				if l__game__7.ReplicatedStorage.echo:FindFirstChild(p96[2]) then
					v739 = l__game__7.ReplicatedStorage.echo:FindFirstChild(p96[2]):Clone();
					v739.Parent = l__CurrentCamera__1;
					v740, v741, v742 = ipairs(v739:GetChildren());
					while true do
						v743, v744 = v740(v741, v742);
						if v743 then

						else
							break;
						end;
						v742 = v743;
						if v744:FindFirstChild("torso") then
							spawn(function()
								v745 = l__game__7.ReplicatedStorage.effects.echoball:Clone();
								l__Debris__27:AddItem(v745, 10);
								v745.Material = Enum.Material.Neon;
								v745.CFrame = v744.torso.CFrame;
								v745.fx.Enabled = false;
								v745.Parent = l__CurrentCamera__1;
								v745.flash:Emit(math.random(10, 20));
								while true do
									v745.Size = v745.Size + Vector3.new(0.5, 0.5, 0.5);
									v745.Transparency = v745.Transparency + 0.1;
									RS:wait();
									if not (1 <= v745.Transparency) then

									else
										break;
									end;								
								end;
							end);
						end;					
					end;
					if p96[2] == "mountain" then
						delay(1.5, function()
							v101({ "echo_specific" }, "seat", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(3.5, function()
							v101({ "firearms" }, "rack", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(1, function()
							v101({ "movement_sounds" }, "step1", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(2, function()
							v101({ "movement_sounds" }, "step2", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(3, function()
							v101({ "movement_sounds" }, "step4", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(4, function()
							v101({ "movement_sounds" }, "step2", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(4.2, function()
							v101({ "echo_specific" }, "seat", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(5.9, function()
							v101({ "weapons", "Fists" }, "swingvar2", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(6, function()
							v101({ "hitsound", "melee" }, "fists", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9, function()
							v101({ "general" }, "reloadpartial", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(12, function()
							v101({ "weapons", "RFL" }, "Model 870", p96[1].hoverpart, nil, true, false, true);
						end);
					elseif p96[2] == "ship" then
						delay(1, function()
							v101({ "echo_specific" }, "lighter", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(2, function()
							v101({ "echo_specific" }, "lighter", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(3, function()
							v101({ "echo_specific" }, "lighter", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(1.5, function()
							v101({ "movement_sounds" }, "step1", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(2.5, function()
							v101({ "movement_sounds" }, "step2", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(3.5, function()
							v101({ "movement_sounds" }, "step4", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(4.5, function()
							v101({ "movement_sounds" }, "step2", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(6, function()
							v101({ "world_item" }, "ration_pickup", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(7, function()
							v101({ "movement_sounds" }, "step1", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(8, function()
							v101({ "movement_sounds" }, "step2", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(8.5, function()
							v101({ "weapons", "1HBL" }, "draw", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9, function()
							v101({ "weapons", "1HBL" }, "chargeswing", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9.3, function()
							v101({ "deaths" }, "axe_hit", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9.3, function()
							v101({ "deaths" }, "slash", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9.4, function()
							v101({ "world_item" }, "ration_pickup", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9.4, function()
							v101({ "general" }, "reloaddone", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9.6, function()
							v101({ "echo_specific" }, "running", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(10, function()
							v101({ "weapons", "ASMG" }, "M60-E6", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(11, function()
							v101({ "firearms" }, "casing_heavy", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(10.11, function()
							v101({ "weapons", "ASMG" }, "M60-E6", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(11.11, function()
							v101({ "firearms" }, "casing_heavy", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(10.22, function()
							v101({ "weapons", "ASMG" }, "M60-E6", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(10.32, function()
							v101({ "firearms" }, "crack", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(11.22, function()
							v101({ "firearms" }, "casing_heavy", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(10.33, function()
							v101({ "weapons", "ASMG" }, "M60-E6", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(11.33, function()
							v101({ "firearms" }, "casing_heavy", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(10.44, function()
							v101({ "weapons", "ASMG" }, "M60-E6", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(10.54, function()
							v101({ "firearms" }, "crack", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(11.44, function()
							v101({ "firearms" }, "casing_heavy", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(11.1, function()
							v101({ "echo_specific" }, "running", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(13, function()
							v101({ "weapons", "Item" }, "medikitcap", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(13.5, function()
							v101({ "weapons", "Item" }, "medikitspit", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(14, function()
							v101({ "weapons", "Item" }, "medikitflick", p96[1].hoverpart, nil, true, false, true);
						end);
					elseif p96[2] == "valley" then
						delay(0.5, function()
							v101({ "weapons", "Item" }, "esmarch", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(1, function()
							v101({ "movement_sounds" }, "step1", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(2, function()
							v101({ "movement_sounds" }, "step2", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(3, function()
							v101({ "movement_sounds" }, "step1", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(3.5, function()
							v101({ "general" }, "reloadpartial", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(6.8, function()
							v101({ "weapons", "2HPST" }, "draw", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(6.4, function()
							v101({ "weapons", "PST" }, "Glock 17", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(6.5, function()
							v101({ "firearms" }, "crack", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(7.2, function()
							v101({ "firearms" }, "casing_light", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(6.6, function()
							v101({ "reloads" }, "single_start", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(7, function()
							v101({ "weapons", "PST" }, "Glock 17", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(7.1, function()
							v101({ "firearms" }, "crack", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(8, function()
							v101({ "firearms" }, "casing_light", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(8, function()
							v101({ "reloads" }, "pistol_mid", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(7.2, function()
							v101({ "weapons", "2HPST" }, "Mark VII", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(8.4, function()
							v101({ "firearms" }, "casing_medium", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(7.9, function()
							v101({ "hitsound", "extras" }, "grapple2", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(8.6, function()
							v101({ "weapons", "2HPST" }, "Mark VII", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9.6, function()
							v101({ "firearms" }, "casing_medium", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(8.7, function()
							v101({ "deaths" }, "headshot2", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9, function()
							v101({ "movement_sounds" }, "step2", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(10, function()
							v101({ "movement_sounds" }, "step1", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(11, function()
							v101({ "movement_sounds" }, "step4", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(12, function()
							v101({ "weapons", "2HPST" }, "Mark VII", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(13, function()
							v101({ "firearms" }, "casing_medium", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(12, function()
							v101({ "deaths" }, "headshot1", p96[1].hoverpart, nil, true, false, true);
						end);
					elseif p96[2] == "market" then
						delay(1, function()
							v101({ "rations" }, "liquid_sip", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(2, function()
							v101({ "rations" }, "liquid_sip", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(3, function()
							v101({ "rations" }, "liquid_sip", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(3.5, function()
							v101({ "movement_sounds" }, "movement", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(3.8, function()
							v101({ "echo_specific" }, "seat", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(4.5, function()
							v101({ "weapons", "2HPST" }, "draw", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(4.6, function()
							v101({ "weapons", "ASMG" }, "draw", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(4.7, function()
							v101({ "weapons", "SMG" }, "draw", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(4.8, function()
							v101({ "weapons", "PST" }, "draw", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(6, function()
							v101({ "movement_sounds" }, "step1", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(7, function()
							v101({ "movement_sounds" }, "step2", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(8, function()
							v101({ "general" }, "reloadpartial", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(8.5, function()
							v101({ "weapons", "ASMG" }, "Modded AKM", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(8.6, function()
							v101({ "weapons", "ASMG" }, "Modded AKM", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(8.7, function()
							v101({ "weapons", "ASMG" }, "Modded AKM", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(8.8, function()
							v101({ "weapons", "ASMG" }, "Modded AKM", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(8.9, function()
							v101({ "weapons", "ASMG" }, "Modded AKM", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9, function()
							v101({ "weapons", "ASMG" }, "Modded AKM", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9.5, function()
							v101({ "firearms" }, "casing_heavy", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9.7, function()
							v101({ "firearms" }, "casing_heavy", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9.8, function()
							v101({ "firearms" }, "casing_heavy", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9.9, function()
							v101({ "firearms" }, "casing_heavy", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(8.4, function()
							v101({ "weapons", "PST" }, "Glock 17", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9.4, function()
							v101({ "firearms" }, "casing_light", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(8.7, function()
							v101({ "weapons", "PST" }, "Glock 17", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9.7, function()
							v101({ "firearms" }, "casing_light", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9, function()
							v101({ "weapons", "PST" }, "Glock 17", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(10, function()
							v101({ "firearms" }, "casing_light", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(8.7, function()
							v101({ "weapons", "PST" }, "M1911A1", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9.7, function()
							v101({ "firearms" }, "casing_light", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9.2, function()
							v101({ "weapons", "PST" }, "M1911A1", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(10.2, function()
							v101({ "firearms" }, "casing_light", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(11, function()
							v101({ "movement_sounds" }, "step2", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(12, function()
							v101({ "movement_sounds" }, "step1", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(13, function()
							v101({ "movement_sounds" }, "step4", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(14, function()
							v101({ "world_item" }, "ration_pickup", p96[1].hoverpart, nil, true, false, true);
						end);
					elseif p96[2] == "base" then
						delay(0.5, function()
							v101({ "general" }, "writing", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(1, function()
							v101({ "movement_sounds" }, "step1", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(2, function()
							v101({ "movement_sounds" }, "step2", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(3, function()
							v101({ "movement_sounds" }, "step1", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(4, function()
							v101({ "movement_sounds" }, "step2", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(5, function()
							v101({ "movement_sounds" }, "step1", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(6, function()
							v101({ "movement_sounds" }, "step4", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(4, function()
							v101({ "AGENT" }, "blip", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(5, function()
							v101({ "AGENT" }, "bliptwo", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(7, function()
							v101({ "echo_specific" }, "glass", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(8, function()
							v101({ "weapons", "PST" }, "draw", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(8.5, function()
							v101({ "weapons", "PST" }, "M1911A1", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(8.7, function()
							v101({ "firearms" }, "crack", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9.5, function()
							v101({ "firearms" }, "casing_light", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9, function()
							v101({ "weapons", "SMG" }, "draw", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9.2, function()
							v101({ "weapons", "PST" }, "M1911A1", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9.4, function()
							v101({ "firearms" }, "crack", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(10.2, function()
							v101({ "firearms" }, "casing_light", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9.5, function()
							v101({ "weapons", "2HPST" }, "A.J.M. 9", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9.7, function()
							v101({ "hitsound", "guns" }, "bullet_impact1", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(10.5, function()
							v101({ "firearms" }, "casing_light", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9.554, function()
							v101({ "weapons", "2HPST" }, "A.J.M. 9", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9.754, function()
							v101({ "hitsound", "guns" }, "bullet_impact2", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(10.8, function()
							v101({ "firearms" }, "casing_light", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9.608, function()
							v101({ "weapons", "2HPST" }, "A.J.M. 9", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9.808, function()
							v101({ "hitsound", "guns" }, "bullet_impact3", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(11, function()
							v101({ "firearms" }, "casing_light", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(13, function()
							v101({ "world_item" }, "ration_pickup", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(13.5, function()
							v101({ "echo_specific" }, "running", p96[1].hoverpart, nil, true, false, true);
						end);
					elseif p96[2] == "tower" then
						delay(0.5, function()
							v101({ "weapons", "Fists" }, "swingvar2", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(0.6, function()
							v101({ "hitsound", "melee" }, "fists", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(1.1, function()
							v101({ "weapons", "Fists" }, "swingvar1", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(1.2, function()
							v101({ "hitsound", "melee" }, "fists", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(2, function()
							v101({ "general" }, "shove", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(2.1, function()
							v101({ "general" }, "shove_landed", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(2.4, function()
							v101({ "echo_specific" }, "fall", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(2.8, function()
							v101({ "general" }, "falldamage1", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(2.8, function()
							v101({ "echo_specific" }, "rope", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(2.8, function()
							v101({ "echo_specific" }, "bone", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(6, function()
							v101({ "movement_sounds" }, "step1", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(7, function()
							v101({ "movement_sounds" }, "step2", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(8, function()
							v101({ "movement_sounds" }, "step1", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9, function()
							v101({ "movement_sounds" }, "step4", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(10, function()
							v101({ "movement_sounds" }, "step2", p96[1].hoverpart, nil, true, false, true);
						end);
					elseif p96[2] == "castle" then
						delay(0.5, function()
							v101({ "harvesting" }, "stonebreak", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(1.5, function()
							v101({ "harvesting" }, "stonebreak", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(1, function()
							v101({ "movement_sounds" }, "step1", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(2, function()
							v101({ "movement_sounds" }, "step2", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(3, function()
							v101({ "movement_sounds" }, "step1", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(2.5, function()
							v101({ "harvesting" }, "stonebreak", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(2.6, function()
							v101({ "echo_specific" }, "wall2", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(2.7, function()
							v101({ "echo_specific" }, "wall", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(3, function()
							v101({ "ai" }, "ai_sprint", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(2.9, function()
							v101({ "shadow" }, "skinner_noise5", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(3.5, function()
							v101({ "weapons", "PST" }, "M1911A1", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(4, function()
							v101({ "weapons", "PST" }, "M1911A1", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(4.1, function()
							v101({ "firearms" }, "empty", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(4.4, function()
							v101({ "deaths" }, "cut_tear", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(4.45, function()
							v101({ "deaths" }, "flesh", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(3.5, function()
							v101({ "echo_specific" }, "running", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(4.8, function()
							v101({ "general" }, "blockraise", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(5.3, function()
							v101({ "hitsound", "general" }, "hitblocked", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(6.7, function()
							v101({ "hitsound", "general" }, "hitblocked", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(6.8, function()
							v101({ "weapons", "2H" }, "swingvar1", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(6.9, function()
							v101({ "deaths" }, "headbonk", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(4.5, function()
							v101({ "reloads" }, "rifle_mid", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(5, function()
							v101({ "general" }, "reloaddone", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(6.3, function()
							v101({ "weapons", "ASMG" }, "AK-74", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(6.392, function()
							v101({ "weapons", "ASMG" }, "AK-74", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(6.484, function()
							v101({ "weapons", "ASMG" }, "AK-74", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(6.576, function()
							v101({ "weapons", "ASMG" }, "AK-74", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(6.668, function()
							v101({ "weapons", "ASMG" }, "AK-74", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(6.76, function()
							v101({ "weapons", "ASMG" }, "AK-74", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(6.852, function()
							v101({ "weapons", "ASMG" }, "AK-74", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(6.944, function()
							v101({ "weapons", "ASMG" }, "AK-74", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(7.036, function()
							v101({ "weapons", "ASMG" }, "AK-74", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(7.1, function()
							v101({ "firearms" }, "empty", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(7.5, function()
							v101({ "firearms" }, "click", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(7.8, function()
							v101({ "firearms" }, "click", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(8.1, function()
							v101({ "firearms" }, "click", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(7.3, function()
							v101({ "shadow" }, "skinner_noise2", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9, function()
							v101({ "ai" }, "ai_sprint", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(8.8, function()
							v101({ "weapons", "1HBL" }, "chargeswing", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9, function()
							v101({ "deaths" }, "neck", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9, function()
							v101({ "hitsound", "general" }, "hitblocked", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9.5, function()
							v101({ "hitsound", "extras" }, "grapple2", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(10.3, function()
							v101({ "hitsound", "general" }, "hitbackstab", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(10.3, function()
							v101({ "deaths" }, "slash", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(11, function()
							v101({ "shadow" }, "skinner_noise4", p96[1].hoverpart, nil, true, false, true);
						end);
					end;
					v746 = tick();
					while true do
						RS:wait();
						if not (15 <= tick() - v746) then

						else
							break;
						end;					
					end;
					agent_speak("echo_end");
					v747, v748, v749 = ipairs(v739:GetChildren());
					while true do
						v750, v751 = v747(v748, v749);
						if v750 then

						else
							break;
						end;
						v749 = v750;
						if v751:FindFirstChild("torso") then
							v752 = l__game__7.ReplicatedStorage.effects.echoball:Clone();
							l__Debris__27:AddItem(v752, 10);
							v752.Material = Enum.Material.Neon;
							v752.CFrame = v751.torso.CFrame;
							v752.fx.Enabled = false;
							v752.Parent = l__CurrentCamera__1;
							v752.flash:Emit(math.random(10, 20));
							spawn(function()
								while true do
									v752.Size = v752.Size + Vector3.new(0.5, 0.5, 0.5);
									v752.Transparency = v752.Transparency + 0.1;
									RS:wait();
									if not (1 <= v752.Transparency) then

									else
										break;
									end;								
								end;
							end);
						end;					
					end;
					v739:Destroy();
					v101({ "general_ui" }, "echo_close", p96[1].hoverpart, 0.01, true, false);
					current_in_echo = false;
				end;
			end;
		elseif p94 == "scanarea" then
			if p96[1] ~= nil then
				l__activestats__753 = v19.scan.activestats;
				v754 = l__game__7.ReplicatedStorage.effects.scanball:Clone();
				l__Debris__27:AddItem(v754, 20);
				v754.CFrame = p96[1];
				v754.Parent = l__CurrentCamera__1;
				if p95 == character then
					spawn(function()
						v755 = tick();
						maingui.PerkFrame.durationbar.Visible = true;
						maingui.PerkFrame.durationbar.fill.Size = UDim2.new(1, 0, 1, 0);
						while true do
							maingui.PerkFrame.durationbar.fill.Size = UDim2.new(1 - math.clamp((tick() - v755) / l__activestats__753.scanlast, 0, 1), 0, 1, 0);
							RS:wait();
							if not (l__activestats__753.scanlast <= tick() - v755) then

							else
								break;
							end;						
						end;
						maingui.PerkFrame.durationbar.Visible = false;
					end);
				end;
				spawn(function()
					v756, v757, v758 = ipairs(l__workspace__1.Interactables:GetChildren());
					while true do
						v759, v760 = v756(v757, v758);
						if v759 then

						else
							break;
						end;
						if v760:FindFirstChild("Interact") then
							if (v760.Interact.Position - p96[1].p).magnitude <= l__activestats__753.studsscan then
								if v760.Name ~= "Heavy Ammo" then
									if v760.Name ~= "Shells Ammo" then
										if v760.Name ~= "Light Ammo" then
											if v760.Name ~= "Long Ammo" then
												if v760.Name ~= "Short Ammo" then
													if v760.Name ~= "Medium Ammo" then
														if v760.Name == "Small Ammo" then
															u98(v760.Interact, false, l__activestats__753.scanlast);
														else
															u98(v760.Interact, false, l__activestats__753.scanlast);
														end;
													else
														u98(v760.Interact, false, l__activestats__753.scanlast);
													end;
												else
													u98(v760.Interact, false, l__activestats__753.scanlast);
												end;
											else
												u98(v760.Interact, false, l__activestats__753.scanlast);
											end;
										else
											u98(v760.Interact, false, l__activestats__753.scanlast);
										end;
									else
										u98(v760.Interact, false, l__activestats__753.scanlast);
									end;
								else
									u98(v760.Interact, false, l__activestats__753.scanlast);
								end;
							end;
						end;
						if v760:FindFirstChild("HarvestWood") then
							if (v760.HarvestWood.Position - p96[1].p).magnitude <= l__activestats__753.studsscan then
								u98(v760.HarvestWood, false, l__activestats__753.scanlast);
							end;
						end;
						if v760:FindFirstChild("HarvestStone") then
							if (v760.HarvestStone.Position - p96[1].p).magnitude <= l__activestats__753.studsscan then
								u98(v760.HarvestStone, false, l__activestats__753.scanlast);
							end;
						end;					
					end;
					v761, v762, v763 = ipairs(l__workspace__1.WeaponDrops:GetChildren());
					while true do
						v764, v765 = v761(v762, v763);
						if v764 then

						else
							break;
						end;
						v763 = v764;
						if v765:FindFirstChild("JointGrip") then
							if (v765.JointGrip.Position - p96[1].p).magnitude <= l__activestats__753.studsscan then
								u98(v765.JointGrip, false, l__activestats__753.scanlast);
							end;
						end;					
					end;
					v766, v767, v768 = ipairs(l__workspace__1.activeHostiles:GetChildren());
					while true do
						v769, v770 = v766(v767, v768);
						if v769 then

						else
							break;
						end;
						v768 = v769;
						if v770:FindFirstChild("Torso") then
							if v770:FindFirstChild("Head") then
								if v770:FindFirstChild("Humanoid") then
									if 0 <= v770.Humanoid.Health then
										if (v770.Torso.Position - p96[1].p).magnitude <= l__activestats__753.studsscan then
											v771 = l__game__7.ReplicatedStorage.effects.health_scanned:Clone();
											l__Debris__27:AddItem(v771, l__activestats__753.scanlast);
											v771.Adornee = v770.Torso;
											v771.Parent = ply.PlayerGui;
											v771.update_health.Disabled = false;
										end;
									end;
								end;
							end;
						end;					
					end;
				end);
				spawn(function()
					while true do
						v754.Size = v754.Size + Vector3.new(2, 2, 2);
						v754.Transparency = v754.Transparency + 0.025;
						RS:wait();
						if not (1 <= v754.Transparency) then

						else
							break;
						end;					
					end;
					delay(3, function()
						v754.fx.Enabled = false;
					end);
				end);
			end;
		elseif p94 == "player_ping" then
			if p96[1] ~= nil then
				if l__workspace__1.NoTarget:FindFirstChild(p96[2] .. "PING_CAT" .. p96[3]) then
					l__workspace__1.NoTarget:FindFirstChild(p96[2] .. "PING_CAT" .. p96[3]):Destroy();
				end;
				v772 = l__game__7.ReplicatedStorage.misc.ping_indicator:Clone();
				v772.Name = p96[2] .. "PING_CAT" .. p96[3];
				l__Debris__27:AddItem(v772, 20);
				v772.CFrame = CFrame.new(p96[1]);
				v772.bb.pinger.Text = p96[2];
				v772.Parent = l__workspace__1.NoTarget;
				v773 = v772.bb:FindFirstChild("ping_cat" .. p96[3]);
				if v773 then
					v773.Visible = true;
					v774 = v773:Clone();
					v774.Parent = v772.bb;
					spawn(function()
						while true do
							if v774 then
								if v773 then
									v774.Size = v774.Size + UDim2.new(0, 2, 0, 2);
									v774.ImageTransparency = v774.ImageTransparency + 0.05;
								end;
							end;
							RS:wait();
							if not (1 <= v774.ImageTransparency) then

							else
								break;
							end;
							if v773 ~= nil then

							else
								break;
							end;						
						end;
						v774:Destroy();
					end);
				end;
				v775 = "ping_area";
				if p96[3] == 2 then
					v775 = "ping_enemy";
				elseif p96[3] == 3 then
					v775 = "ping_item";
				end;
				v101({ "general_ui" }, v775, nil, nil, true, true);
				v776 = maingui.teammatesframe:FindFirstChild(p96[2]);
				if v776 then
					if v776:FindFirstChild("empty") then
						v777 = "[Moving Here]";
						v778 = Color3.fromRGB(255, 182, 122);
						if p96[3] == 3 then
							v778 = Color3.fromRGB(122, 232, 92);
							v777 = "[Marked " .. p96[4] .. "]";
						elseif p96[3] == 2 then
							v778 = Color3.fromRGB(216, 60, 60);
							v777 = "[Hostile]";
						elseif p96[3] == 4 then
							v778 = Color3.fromRGB(102, 137, 255);
							v777 = "[Located " .. p96[4] .. "]";
						elseif p96[3] == 5 then
							v778 = Color3.fromRGB(183, 89, 255);
							v777 = "[" .. p96[4] .. "]";
						end;
						v779 = l__game__7.ReplicatedStorage.misc.ping_text:Clone();
						l__Debris__27:AddItem(v779, 6);
						v779.TextColor3 = v778;
						v779.Text = v777;
						v779.bg.ImageColor3 = v778;
						if v776:FindFirstChild("empty"):FindFirstChild("ping_text") then
							v776:FindFirstChild("empty"):FindFirstChild("ping_text"):Destroy();
						end;
						v779.Parent = v776:FindFirstChild("empty");
						spawn(function()
							while true do
								if v779 then
									if v779:FindFirstChild("bg") then
										v779.bg.ImageTransparency = v779.bg.ImageTransparency + 0.05;
										v779.bg.Size = v779.bg.Size + UDim2.new(0, 2, 0, 0);
									end;
								end;
								RS:wait();
								if v779 ~= nil then

								else
									break;
								end;
								if v779:FindFirstChild("bg") ~= nil then

								else
									break;
								end;
								if not (1 <= v779.bg.ImageTransparency) then

								else
									break;
								end;							
							end;
						end);
					end;
				end;
			end;
		elseif p94 == "selfscan" then
			l__activestats__101 = v19.scan.activestats;
			spawn(function()
				v780, v781, v782 = ipairs(l__workspace__1.Interactables:GetChildren());
				while true do
					v783, v784 = v780(v781, v782);
					if v783 then

					else
						break;
					end;
					if v784:FindFirstChild("Interact") then
						if (v784.Interact.Position - character.HumanoidRootPart.Position).magnitude <= l__activestats__101.scan_around then
							if v784.Name ~= "Heavy Ammo" then
								if v784.Name ~= "Shells Ammo" then
									if v784.Name ~= "Light Ammo" then
										if v784.Name ~= "Long Ammo" then
											if v784.Name ~= "Short Ammo" then
												if v784.Name ~= "Medium Ammo" then
													if v784.Name == "Small Ammo" then
														u98(v784.Interact, true, l__activestats__101.scan_around_timer);
													else
														u98(v784.Interact, true, l__activestats__101.scan_around_timer);
													end;
												else
													u98(v784.Interact, true, l__activestats__101.scan_around_timer);
												end;
											else
												u98(v784.Interact, true, l__activestats__101.scan_around_timer);
											end;
										else
											u98(v784.Interact, true, l__activestats__101.scan_around_timer);
										end;
									else
										u98(v784.Interact, true, l__activestats__101.scan_around_timer);
									end;
								else
									u98(v784.Interact, true, l__activestats__101.scan_around_timer);
								end;
							else
								u98(v784.Interact, true, l__activestats__101.scan_around_timer);
							end;
						end;
					end;
					if v784:FindFirstChild("HarvestWood") then
						if (v784.HarvestWood.Position - character.HumanoidRootPart.Position).magnitude <= l__activestats__101.scan_around then
							u98(v784.HarvestWood, true, l__activestats__101.scan_around_timer);
						end;
					end;
					if v784:FindFirstChild("HarvestStone") then
						if (v784.HarvestStone.Position - character.HumanoidRootPart.Position).magnitude <= l__activestats__101.scan_around then
							u98(v784.HarvestStone, true, l__activestats__101.scan_around_timer);
						end;
					end;				
				end;
				v785, v786, v787 = ipairs(l__workspace__1.WeaponDrops:GetChildren());
				while true do
					v788, v789 = v785(v786, v787);
					if v788 then

					else
						break;
					end;
					v787 = v788;
					if v789:FindFirstChild("JointGrip") then
						if (v789.JointGrip.Position - character.HumanoidRootPart.Position).magnitude <= l__activestats__101.scan_around then
							u98(v789.JointGrip, true, l__activestats__101.scan_around_timer);
						end;
					end;				
				end;
			end);
		elseif p94 == "tased" then
			v790 = createfxoutline("tasedParticle", 1.7);
		elseif p94 == "decap" then
			if p95:FindFirstChild("Head") == nil then
				return;
			end;
			l__Head__791 = p95.Head;
			v792 = l__game__7.ReplicatedStorage.effects.gFX.decap.decapstump:Clone();
			v792.CFrame = p95.Torso.CFrame;
			v793 = Instance.new("Weld");
			v793.Part0 = v792;
			v793.Part1 = p95.Torso;
			v793.C1 = CFrame.new(0, 1, 0);
			v793.Parent = v792;
			v792.Parent = p95;
			v794 = l__game__7.ReplicatedStorage.effects.gFX.decap.decapblock:Clone();
			v795 = Instance.new("Weld");
			v795.Part0 = v794;
			v795.Part1 = l__Head__791;
			v795.Parent = v794;
			v795.Parent = p95;
			v794.Parent = p95;
			l__Head__791.CFrame = l__Head__791.CFrame * CFrame.new(0, 0.2, 0);
			RS:wait();
			l__Head__791.Velocity = l__Head__791.Velocity + Vector3.new(math.random(-3, 3), 20, math.random(-3, 3));
		elseif p94 == "crush" then
			v796, v797, v798 = ipairs(p95:GetChildren());
			while true do
				v799, v800 = v796(v797, v798);
				if v799 then

				else
					break;
				end;
				v798 = v799;
				if v800:IsA("Accessory") then
					v800:Destroy();
				end;			
			end;
			v801, v802, v803 = ipairs(p95.Head:GetChildren());
			while true do
				v804, v805 = v801(v802, v803);
				if v804 then

				else
					break;
				end;
				v803 = v804;
				if v805:IsA("Decal") then
					v805:Destroy();
				end;			
			end;
			if p95:FindFirstChild("Outfit") then
				if p95:FindFirstChild("Outfit"):FindFirstChild("Head") then
					v806, v807, v808 = ipairs(p95:FindFirstChild("Outfit"):GetChildren());
					while true do
						v809, v810 = v806(v807, v808);
						if v809 then

						else
							break;
						end;
						v808 = v809;
						if v810.Name == "Head" then
							v810:Destroy();
						end;					
					end;
				end;
			end;
			l__Head__811 = p95.Head;
			v812 = l__game__7.ReplicatedStorage.effects.gFX.crush.splat:Clone();
			l__Debris__27:AddItem(v812, 9);
			v812.CFrame = p95.Head.CFrame;
			v812.fx1:Emit(math.random(5, 10));
			v812.fx2:Emit(math.random(3, 5));
			v812.Parent = l__workspace__1.NoTarget;
			v813 = l__game__7.ReplicatedStorage.effects.gFX.crush.bonestump:Clone();
			v813.CFrame = p95.Torso.CFrame;
			v814 = Instance.new("Weld");
			v814.Part0 = v813;
			v814.Part1 = p95.Torso;
			v814.C1 = CFrame.new(0, 1, 0);
			v814.Parent = v813;
			v813.Parent = p95;
			p95.Head:Destroy();
			v815 = { "gib", "bone" };
			v816 = math.random(8, 15);
			v817 = 1 - 1;
			while true do
				v818 = l__game__7.ReplicatedStorage.effects.gFX.crush[v815[math.random(1, 2)]]:Clone();
				l__Debris__27:AddItem(v818, 7);
				v818.CFrame = l__Head__811.CFrame * CFrame.new(math.random(-15, 10) / 100, math.random(-15, 10) / 100, math.random(-15, 10) / 100);
				v818.Parent = l__workspace__1.NoTarget;
				v818.Velocity = v818.Velocity + Vector3.new(math.random(-6, 6), math.random(5, 15), math.random(-6, 6));
				if 0 <= 1 then
					if v817 < v816 then

					else
						break;
					end;
				elseif v816 < v817 then

				else
					break;
				end;
				v817 = v817 + 1;			
			end;
		elseif p94 == "arrowimpact" then
			v819 = l__game__7.ReplicatedStorage.effects.gFX.arrowdeath.arrowimpact:Clone();
			v819.CFrame = p95.Head.CFrame;
			v820 = Instance.new("Weld");
			v820.Part0 = v819;
			v820.Part1 = p95.Head;
			v820.Parent = v819;
			v819.Parent = p95;
			v819.gorepoint.bleedpoint1.splat.Enabled = true;
			v819.gorepoint.bleedpoint2.splat.Enabled = true;
			v819.gorepoint.bleedpoint1.splat:Emit(30, 50);
			v819.gorepoint.bleedpoint2.splat:Emit(30, 50);
			v819.gorepoint.bleedpoint1.splat.Enabled = false;
			v819.gorepoint.bleedpoint2.splat.Enabled = false;
		elseif p94 == "headshot_gun" then
			v821 = l__game__7.ReplicatedStorage.effects.gFX.headshotdeath.headshotimpact:Clone();
			v821.CFrame = p95.Head.CFrame;
			v822 = Instance.new("Weld");
			v822.Part0 = v821;
			v822.Part1 = p95.Head;
			v822.Parent = v821;
			v821.Parent = p95;
			v821.gorepoint.bleedpoint1.splat.Enabled = true;
			v821.gorepoint.bleedpoint1.cloud.Enabled = true;
			v821.gorepoint.bleedpoint2.splat.Enabled = true;
			v821.gorepoint.bleedpoint1.cloud:Emit(1, 3);
			v821.gorepoint.bleedpoint1.splat:Emit(30, 50);
			v821.gorepoint.bleedpoint2.splat:Emit(30, 50);
			v821.gorepoint.bleedpoint1.splat.Enabled = false;
			v821.gorepoint.bleedpoint1.cloud.Enabled = false;
			v821.gorepoint.bleedpoint2.splat.Enabled = false;
			v101({ "deaths" }, "headshot" .. math.random(1, 2), p95.Head, nil, true, false);
			v101({ "deaths" }, "decap", p95.Head, nil, true, false);
			if p96 ~= nil then
				if p96 == "self" then
					v821.gorepoint.Transparency = 1;
					v821.gorepoint.bleedpoint1.drip.Enabled = false;
					v821.gorepoint.bleedpoint2.drip.Enabled = false;
				end;
			end;
		elseif p94 ~= "head_bonk" then
			if p94 == "axe_embed" then
				v823 = l__game__7.ReplicatedStorage.effects.gFX.blunthead.headbonk:Clone();
				v823.CFrame = p95.Head.CFrame;
				v824 = Instance.new("Weld");
				v824.Part0 = v823;
				v824.Part1 = p95.Head;
				v824.Parent = v823;
				v823.Parent = p95;
				RS:wait();
				v823.gorepoint.bleedpoint1.splat.Enabled = true;
				v823.gorepoint.bleedpoint1.cloud.Enabled = true;
				v823.gorepoint.bleedpoint1.cloud:Emit(1, 3);
				v823.gorepoint.bleedpoint1.splat:Emit(15, 30);
				v823.gorepoint.bleedpoint1.splat.Enabled = false;
				v823.gorepoint.bleedpoint1.cloud.Enabled = false;
				if p94 == "head_bonk" then
					v101({ "deaths" }, "headbonk", p95.Head, nil, true, false);
				else
					v825 = l__game__7.ReplicatedStorage.effects.gFX.axe_head.axed:Clone();
					v825.CFrame = p95.Head.CFrame;
					v826 = Instance.new("Weld");
					v826.Part0 = v825;
					v826.Part1 = p95.Head;
					v826.Parent = v825;
					v825.Parent = p95;
					v101({ "deaths" }, "tear", p95.Head, nil, true, false);
					v101({ "deaths" }, "axe_hit", p95.Head, nil, true, false);
				end;
			elseif p94 ~= "take_limbs_arms" then
				if p94 == "take_limbs_legs" then
					v827 = l__game__7.ReplicatedStorage.effects.gFX.limbremove.torsopart:Clone();
					v827.CFrame = p95.Torso.CFrame;
					v828 = Instance.new("Weld");
					v828.Part0 = v827;
					v828.Part1 = p95.Torso;
					v828.Parent = v827;
					v829 = "Left Arm";
					if math.random(1, 2) == 1 then
						v829 = "Right Arm";
					end;
					if p94 == "take_limbs_legs" then
						v829 = "Left Leg";
						if math.random(1, 2) == 1 then
							v829 = "Right Leg";
						end;
					end;
					v830, v831, v832 = ipairs(v827:GetChildren());
					while true do
						v833, v834 = v830(v831, v832);
						if v833 then

						else
							break;
						end;
						v832 = v833;
						if v834:IsA("BasePart") then
							if v834.Name ~= v829 then
								v834:Destroy();
							end;
						end;					
					end;
					v827.Parent = p95;
					if p95:FindFirstChild(v829) then
						p95:FindFirstChild(v829):Destroy();
					end;
					if p95:FindFirstChild("Outfit") then
						if p94 == "take_limbs_legs" then
							if p95.Outfit:FindFirstChild("Bottom") then
								if p95.Outfit.Bottom:FindFirstChild(v829) then
									p95.Outfit.Bottom:FindFirstChild(v829):Destroy();
								end;
							end;
						elseif p95.Outfit:FindFirstChild("Top") then
							if p95.Outfit.Top:FindFirstChild(v829) then
								p95.Outfit.Top:FindFirstChild(v829):Destroy();
							end;
						end;
					end;
					v101({ "deaths" }, "flesh", p95.Torso, nil, true, false);
					v101({ "deaths" }, "gurgle", p95.Torso, nil, true, false);
					v827:FindFirstChild(v829).attach.cloud.Enabled = true;
					v827:FindFirstChild(v829).attach.gib.Enabled = true;
					v827:FindFirstChild(v829).attach.cloud:Emit(math.random(1, 3));
					v827:FindFirstChild(v829).attach.gib:Emit(math.random(3, 7));
					v827:FindFirstChild(v829).attach.cloud.Enabled = false;
					v827:FindFirstChild(v829).attach.gib.Enabled = false;
				elseif p94 == "torso_cut" then
					v835 = l__game__7.ReplicatedStorage.effects.gFX.torsocut.Torso:Clone();
					v835.CFrame = p95.Torso.CFrame;
					v836 = Instance.new("Weld");
					v836.Part0 = v835;
					v836.Part1 = p95.Torso;
					v836.Parent = v835;
					v835.Parent = p95.Torso;
				elseif p94 == "pukedeath" then
					v101({ "deaths" }, "gurgle", p95.Head, nil, true, false);
					delay(0.5, function()
						v101({ "deaths" }, "puke", p95.Head, nil, true, false);
						v837 = l__game__7.ReplicatedStorage.effects.gFX.pukedeath.puke:Clone();
						v837.CFrame = p95.Head.CFrame;
						v838 = Instance.new("Weld");
						v838.Part0 = v837;
						v838.Part1 = p95.Head;
						v838.Parent = v837;
						v837.Parent = p95;
						v837.pukepoint.splat.Enabled = true;
						v837.pukepoint.splat2.Enabled = true;
						v837.pukepoint.splat:Emit(math.random(10, 20));
						v837.pukepoint.splat2:Emit(math.random(10, 20));
						RS:wait();
						v837.pukepoint.splat.Enabled = false;
						v837.pukepoint.splat2.Enabled = false;
					end);
				elseif p94 == "stomachrip" then
					v839 = l__game__7.ReplicatedStorage.effects.gFX.spearstomach.torsoFX:Clone();
					v839.CFrame = p95.Torso.CFrame;
					v840 = Instance.new("Weld");
					v840.Part0 = v839;
					v840.Part1 = p95.Torso;
					v840.Parent = v839;
					v839.Parent = p95;
					v839.fxpart.splat:Emit(30, 50);
					v839.fxpart.splat2:Emit(15, 30);
					v841 = math.random(6, 10);
					v842 = 1 - 1;
					while true do
						v843 = l__game__7.ReplicatedStorage.effects.gFX.spearstomach.gib:Clone();
						l__Debris__27:AddItem(v843, 7);
						v843.CFrame = p95.Torso.CFrame * CFrame.new(math.random(-15, 10) / 100, math.random(-15, 10) / 100, math.random(-15, 10) / 100);
						v843.Parent = l__workspace__1.NoTarget;
						v843.Velocity = v843.Velocity + p95.Torso.CFrame.lookVector * 3;
						if 0 <= 1 then
							if v842 < v841 then

							else
								break;
							end;
						elseif v841 < v842 then

						else
							break;
						end;
						v842 = v842 + 1;					
					end;
				elseif p94 == "neckcut" then
					v844 = l__game__7.ReplicatedStorage.effects.gFX.neckcut.fx:Clone();
					l__Debris__27:AddItem(v844, 9);
					v844.CFrame = p95.Torso.CFrame;
					v845 = Instance.new("Weld");
					v845.Part0 = v844;
					v845.Part1 = p95.Torso;
					v845.Parent = v844;
					v845.Parent = p95;
					v844.Parent = p95;
					delay(2, function()
						v844.point.drip.Enabled = false;
						v844.point.fx1.Enabled = false;
					end);
					v844.point.fx2:Emit(1);
					v844.point.gib:Emit(math.random(2, 5));
					v846 = l__game__7.ReplicatedStorage.effects.gFX.neckcut.neckpart:Clone();
					l__Debris__27:AddItem(v846, 7);
					v846.CFrame = p95.Head.CFrame + p95.Head.CFrame.lookVector * 1;
					v846.Parent = l__workspace__1.NoTarget;
					v846.Velocity = v846.Velocity + p95.Head.CFrame.lookVector * 3;
				elseif p94 == "explosive" then
					l__HumanoidRootPart__847 = p95:FindFirstChild("HumanoidRootPart");
					if l__HumanoidRootPart__847 then

					else
						return;
					end;
					v848, v849, v850 = ipairs(p95:GetChildren());
					while true do
						v851, v852 = v848(v849, v850);
						if v851 then

						else
							break;
						end;
						v850 = v851;
						if v852.Name ~= "Torso" then
							if v852.Name ~= "Humanoid" then
								if v852.Name ~= "active" then
									v852:Destroy();
								elseif v852:IsA("BasePart") then
									v852.Transparency = 1;
									v853, v854, v855 = ipairs(v852:GetChildren());
									while true do
										v856, v857 = v853(v854, v855);
										if v856 then

										else
											break;
										end;
										v855 = v856;
										if v857:IsA("Decal") then
											v857:Destroy();
										end;									
									end;
								end;
							elseif v852:IsA("BasePart") then
								v852.Transparency = 1;
								v853, v854, v855 = ipairs(v852:GetChildren());
								while true do
									v856, v857 = v853(v854, v855);
									if v856 then

									else
										break;
									end;
									v855 = v856;
									if v857:IsA("Decal") then
										v857:Destroy();
									end;								
								end;
							end;
						elseif v852:IsA("BasePart") then
							v852.Transparency = 1;
							v853, v854, v855 = ipairs(v852:GetChildren());
							while true do
								v856, v857 = v853(v854, v855);
								if v856 then

								else
									break;
								end;
								v855 = v856;
								if v857:IsA("Decal") then
									v857:Destroy();
								end;							
							end;
						end;					
					end;
					if p95:FindFirstChild("Torso") then
						p95:FindFirstChild("Torso").Anchored = true;
						p95:FindFirstChild("Torso").Transparency = 1;
					end;
					v858 = l__game__7.ReplicatedStorage.effects.gFX.explosion.explosiongib:Clone();
					l__Debris__27:AddItem(v858, 10);
					v858.CFrame = CFrame.new(l__HumanoidRootPart__847.Position) * CFrame.new(0, 1, 0);
					v858.Parent = l__workspace__1.NoTarget;
					v858.cloud:Emit(math.random(5, 8));
					v858.dust:Emit(math.random(5, 8));
					v858.expandcloud:Emit(math.random(5, 8));
					v858.gib:Emit(math.random(8, 12));
					v859 = math.random(8, 12);
					v860 = 1 - 1;
					while true do
						v861 = l__game__7.ReplicatedStorage.effects.gFX.crush.gib:Clone();
						l__Debris__27:AddItem(v861, 7);
						v861.CFrame = v858.CFrame * CFrame.new(math.random(-15, 10) / 100, math.random(-15, 10) / 100, math.random(-15, 10) / 100);
						v861.Parent = l__workspace__1.NoTarget;
						v861.Velocity = v861.Velocity + Vector3.new(math.random(-12, 12), math.random(15, 20), math.random(-12, 12));
						if 0 <= 1 then
							if v860 < v859 then

							else
								break;
							end;
						elseif v859 < v860 then

						else
							break;
						end;
						v860 = v860 + 1;					
					end;
				elseif p94 == "armcut" then
					v862 = l__game__7.ReplicatedStorage.effects.gFX.armcut.torsocopy:Clone();
					v863 = l__game__7.ReplicatedStorage.effects.gFX.armcut.cutarm:Clone();
					v862.beam.Attachment0 = v862.a0;
					v862.beam.Attachment1 = v863.a1;
					v864 = Instance.new("Weld");
					v864.Part0 = v862;
					v864.Part1 = p95.Torso;
					v864.Parent = v862;
					v862.Parent = p95;
					v863.CFrame = p95["Left Arm"].CFrame;
					v865 = Instance.new("Weld");
					v865.Part0 = v863;
					v865.Part1 = p95["Left Arm"];
					v865.Parent = v863;
					v863.Parent = p95["Left Arm"];
					p95["Left Arm"].Velocity = p95["Left Arm"].Velocity + -p95.Torso.CFrame.rightVector * 5;
					delay(0.5, function()
						v866 = 1 - 1;
						while true do
							v867 = 1.5 * (1 - v866 / 15);
							v862.beam.Width0 = v867;
							v862.beam.Width1 = v867;
							RS:wait();
							if 0 <= 1 then
								if v866 < 15 then

								else
									break;
								end;
							elseif 15 < v866 then

							else
								break;
							end;
							v866 = v866 + 1;						
						end;
						v862.beam:Destroy();
					end);
				elseif p94 == "slice" then
					v868, v869, v870 = ipairs(p95.Torso:GetChildren());
					while true do
						v871, v872 = v868(v869, v870);
						if v871 then

						else
							break;
						end;
						v870 = v871;
						if v872:IsA("Decal") then
							v872:Destroy();
						end;					
					end;
					l__Shirt__873 = p95:FindFirstChild("Shirt");
					if l__Shirt__873 == nil then
						l__Pants__874 = p95:FindFirstChild("Pants");
						if l__Pants__874 == nil then
							v875 = "";
						else
							v875 = l__Pants__874.PantsTemplate;
						end;
					else
						v875 = l__Shirt__873.ShirtTemplate;
					end;
					v876 = l__game__7.ReplicatedStorage.effects.gFX.slice.slicehalf:Clone();
					v876.BrickColor = p95.Torso.BrickColor;
					v876.TextureID = v875;
					v876.CFrame = p95.Torso.CFrame;
					v877 = Instance.new("Weld");
					v877.Part0 = v876;
					v877.Part1 = p95.Torso;
					v877.C1 = CFrame.new(0.6, 0, 0);
					v877.Parent = v876;
					v876.Parent = p95;
					p95.Torso.Transparency = 1;
					v878 = l__game__7.ReplicatedStorage.effects.gFX.slice.otherslicehalf:Clone();
					l__Shirt__879 = p95:FindFirstChild("Shirt");
					if l__Shirt__879 then
						l__Shirt__879:Clone().Parent = v878;
					end;
					l__Pants__880 = p95:FindFirstChild("Pants");
					if l__Pants__880 then
						l__Pants__880:Clone().Parent = v878;
					end;
					v881, v882, v883 = ipairs(v878:GetChildren());
					while true do
						v884, v885 = v881(v882, v883);
						if v884 then

						else
							break;
						end;
						v883 = v884;
						if p95:FindFirstChild(v885.Name) then
							if v885:IsA("BasePart") then
								v885.BrickColor = p95:FindFirstChild(v885.Name).BrickColor;
							end;
						end;					
					end;
					v878.Torso.otherhalf.BrickColor = p95.Torso.BrickColor;
					v878.Torso.otherhalf.TextureID = v875;
					v878:SetPrimaryPartCFrame(p95.Torso.CFrame);
					v878.Parent = p95;
					v876.beam1.Attachment1 = v878.Torso.otherhalf.a1;
					v876.beam2.Attachment1 = v878.Torso.otherhalf.b1;
					v876.beam3.Attachment1 = v878.Torso.otherhalf.c1;
					p95["Left Arm"]:Destroy();
					p95["Left Leg"]:Destroy();
					RS:wait();
					v878.Humanoid.PlatformStand = true;
					v878.Torso.Velocity = v878.Torso.Velocity + v878.Torso.CFrame.rightVector * 6;
					if p95.Torso:FindFirstChild("Neck") then
						p95.Torso.Neck.C1 = CFrame.new(-0.341941595, -0.544243574, 0.0124545023, -0.951813221, 0, -0.306678385, -0.301639259, 0.180534005, 0.936173737, 0.0553658754, 0.983568728, -0.171834648);
						p95.Torso.Neck.C0 = CFrame.new(0, 1, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0);
					end;
					delay(0.5, function()
						v886 = 1 - 1;
						while true do
							v887 = 1.5 * (1 - v886 / 15);
							v876.beam1.Width0 = v887;
							v876.beam1.Width1 = v887;
							v876.beam2.Width0 = v887;
							v876.beam2.Width1 = v887;
							v876.beam3.Width0 = v887;
							v876.beam3.Width1 = v887;
							RS:wait();
							if 0 <= 1 then
								if v886 < 15 then

								else
									break;
								end;
							elseif 15 < v886 then

							else
								break;
							end;
							v886 = v886 + 1;						
						end;
						v876.beam1:Destroy();
						v876.beam2:Destroy();
						v876.beam3:Destroy();
					end);
				end;
			else
				v827 = l__game__7.ReplicatedStorage.effects.gFX.limbremove.torsopart:Clone();
				v827.CFrame = p95.Torso.CFrame;
				v828 = Instance.new("Weld");
				v828.Part0 = v827;
				v828.Part1 = p95.Torso;
				v828.Parent = v827;
				v829 = "Left Arm";
				if math.random(1, 2) == 1 then
					v829 = "Right Arm";
				end;
				if p94 == "take_limbs_legs" then
					v829 = "Left Leg";
					if math.random(1, 2) == 1 then
						v829 = "Right Leg";
					end;
				end;
				v830, v831, v832 = ipairs(v827:GetChildren());
				while true do
					v833, v834 = v830(v831, v832);
					if v833 then

					else
						break;
					end;
					v832 = v833;
					if v834:IsA("BasePart") then
						if v834.Name ~= v829 then
							v834:Destroy();
						end;
					end;				
				end;
				v827.Parent = p95;
				if p95:FindFirstChild(v829) then
					p95:FindFirstChild(v829):Destroy();
				end;
				if p95:FindFirstChild("Outfit") then
					if p94 == "take_limbs_legs" then
						if p95.Outfit:FindFirstChild("Bottom") then
							if p95.Outfit.Bottom:FindFirstChild(v829) then
								p95.Outfit.Bottom:FindFirstChild(v829):Destroy();
							end;
						end;
					elseif p95.Outfit:FindFirstChild("Top") then
						if p95.Outfit.Top:FindFirstChild(v829) then
							p95.Outfit.Top:FindFirstChild(v829):Destroy();
						end;
					end;
				end;
				v101({ "deaths" }, "flesh", p95.Torso, nil, true, false);
				v101({ "deaths" }, "gurgle", p95.Torso, nil, true, false);
				v827:FindFirstChild(v829).attach.cloud.Enabled = true;
				v827:FindFirstChild(v829).attach.gib.Enabled = true;
				v827:FindFirstChild(v829).attach.cloud:Emit(math.random(1, 3));
				v827:FindFirstChild(v829).attach.gib:Emit(math.random(3, 7));
				v827:FindFirstChild(v829).attach.cloud.Enabled = false;
				v827:FindFirstChild(v829).attach.gib.Enabled = false;
			end;
		else
			v823 = l__game__7.ReplicatedStorage.effects.gFX.blunthead.headbonk:Clone();
			v823.CFrame = p95.Head.CFrame;
			v824 = Instance.new("Weld");
			v824.Part0 = v823;
			v824.Part1 = p95.Head;
			v824.Parent = v823;
			v823.Parent = p95;
			RS:wait();
			v823.gorepoint.bleedpoint1.splat.Enabled = true;
			v823.gorepoint.bleedpoint1.cloud.Enabled = true;
			v823.gorepoint.bleedpoint1.cloud:Emit(1, 3);
			v823.gorepoint.bleedpoint1.splat:Emit(15, 30);
			v823.gorepoint.bleedpoint1.splat.Enabled = false;
			v823.gorepoint.bleedpoint1.cloud.Enabled = false;
			if p94 == "head_bonk" then
				v101({ "deaths" }, "headbonk", p95.Head, nil, true, false);
			else
				v825 = l__game__7.ReplicatedStorage.effects.gFX.axe_head.axed:Clone();
				v825.CFrame = p95.Head.CFrame;
				v826 = Instance.new("Weld");
				v826.Part0 = v825;
				v826.Part1 = p95.Head;
				v826.Parent = v825;
				v825.Parent = p95;
				v101({ "deaths" }, "tear", p95.Head, nil, true, false);
				v101({ "deaths" }, "axe_hit", p95.Head, nil, true, false);
			end;
		end;
	else
		if p95 ~= nil then
			if p95:FindFirstChild("Torso") == nil then
				return;
			end;
		else
			return;
		end;
		v664 = l__game__7.ReplicatedStorage.effects.bloodSplatter:Clone();
		l__Debris__27:AddItem(v664, 2);
		v664.CFrame = CFrame.new(p95.Torso.Position);
		v664.Parent = l__workspace__1.NoTarget;
		v665 = p96[1];
		if v665 == nil then
			v665 = 1;
		end;
		v666 = v665 / 1.5;
		if v666 < 6 then
			v666 = 6;
		end;
		v664.fx1.Enabled = true;
		v664.fx1:Emit(math.random(v666, v666 + math.random(3, 5)));
		v664.fx1.Enabled = false;
		if p94 == "bloodhit" then
			v667 = l__game__7.ReplicatedStorage.effects.bloodSplatter:Clone();
			l__Debris__27:AddItem(v667, 2);
			v667.CFrame = CFrame.new(p96[2]);
			v667.Parent = l__workspace__1.NoTarget;
			v667.fx2.Enabled = true;
			v667.fx2:Emit(math.random(1, 3));
			v667.fx2.Enabled = false;
			v667.fx3.Enabled = true;
			v667.fx3:Emit(math.random(5, 10));
			v667.fx3.Enabled = false;
			v667.fx4.Enabled = true;
			v667.fx4:Emit(math.random(5, 10));
			v667.fx4.Enabled = false;
		end;
	end;
end;
l__workspace__1.ServerStuff.applyGore.OnClientEvent:Connect(applygore);
l__workspace__1.ServerStuff.relayStats.OnClientInvoke = function(p97)
	local v888 = {};
	for v889, v890 in pairs(u10) do
		v888[v890.effects.corename] = { v890.mainstats.intensity, (v890.effects.maxduration - (tick() - v890.effects.currentduration)) / v890.effects.maxduration };
	end;
	return { hum.Health, u8, v888, u9.blocking, { hum.WalkSpeed, u21 + u40, u20 }, hum.MaxHealth, nametag, v6, playerstats, v62 };
end;
local u102 = 0;
local u103 = nil;
function invmanage(p98, p99)
	if p98 == "swap" then
		if u9.action == true then
			if u9.swapping == false then
				return;
			end;
		end;
		local v891 = true;
		if p99[2] == true then
			p99 = tonumber(string.char(p99[1].Value));
		else
			v891 = false;
			p99 = p99[1];
		end;
		if v6[p99][2] ~= true then
			local v892, v893, v894 = pairs(v6);
			while true do
				local v895, v896 = v892(v893, v894);
				if v895 then

				else
					break;
				end;
				v894 = v895;
				v896[2] = false;			
			end;
			v6[p99][2] = true;
			if v891 == true then
				u61(v6[p99][1]);
				return;
			end;
		end;
	elseif p98 == "updatehud" then
		local v897, v898, v899 = pairs(v6);
		while true do
			local v900, v901 = v897(v898, v899);
			if v900 then

			else
				break;
			end;
			v899 = v900;
			local v902 = maingui.InventoryFrame:FindFirstChild(tostring("slot" .. v900));
			if v902 then
				local v903 = v18[v901[1]];
				local v904 = v903.name;
				local v905 = nil;
				local v906 = nil;
				if v904 == "Fists" then
					v904 = "EMPTY";
					if v901[2] == true then
						if playerstats.Exotic ~= "none" then
							if v20[playerstats.Exotic] then
								v904 = v20[playerstats.Exotic].name;
								v905 = v904;
								v906 = v20[playerstats.Exotic].param[3];
							end;
						end;
					end;
				end;
				if primskin then
					if v900 == 1 then
						v904 = primskin.name;
						v905 = primskin.name;
						v906 = primskin.param[3];
					end;
				end;
				v902.slotarea.slotname.Text = string.upper(v904);
				if v901[2] == true then
					if v901[3] ~= nil then
						maingui.LowerHudFrame.main.Visible = true;
						maingui.LowerHudFrame.reserve.Visible = true;
						if v903.ability ~= nil then
							maingui.LowerHudFrame.altitem.Visible = true;
							maingui.LowerHudFrame.altitem.Text = v903.ability;
						end;
						maingui.LowerHudFrame.itemusage.Visible = false;
						if v903.ammoused ~= nil then
							maingui.LowerHudFrame.altitem.Visible = true;
							maingui.LowerHudFrame.altitem.Text = "Uses " .. v903.ammoused .. " ammo.";
							maingui.LowerHudFrame.reserve.label.Text = u64[v903.ammoused];
						else
							maingui.LowerHudFrame.reserve.label.Text = "USES";
						end;
						maingui.LowerHudFrame.main.label.Text = tostring(v901[3]);
						if akimbo_factors.active == true then
							maingui.LowerHudFrame.altitem.Text = "RESERVE: " .. u64[akimbo_factors.alt_weapon_stats.ammoused];
							maingui.LowerHudFrame.main.label.Text = tostring(v6[akimbo_factors.weapon_slot][3]) .. "/" .. tostring(v901[3]);
						end;
					else
						maingui.LowerHudFrame.main.Visible = false;
						maingui.LowerHudFrame.reserve.Visible = false;
						maingui.LowerHudFrame.altitem.Visible = false;
						if v903.ability ~= nil then
							maingui.LowerHudFrame.itemusage.Visible = true;
							local v907 = "";
							if v903.rarity ~= nil then
								v907 = "Tier " .. v903.rarity .. " / ";
							end;
							maingui.LowerHudFrame.itemusage.Text = v907 .. v903.ability;
							if v906 then
								maingui.LowerHudFrame.itemusage.Text = v907 .. v906;
							end;
						end;
					end;
					v902.BackgroundColor3 = Color3.new(1, 1, 1);
					v902.slotarea.BackgroundColor3 = Color3.new(1, 1, 1);
					v902.highlight.Visible = true;
					v902.slotarea.Size = UDim2.new(0, 200, 0, 45);
					maingui.LowerHudFrame.itemname.Text = v903.name;
					if v905 then
						maingui.LowerHudFrame.itemname.Text = v905;
					end;
				else
					v902.highlight.Visible = false;
					v902.BackgroundColor3 = Color3.new(0, 0, 0);
					v902.slotarea.Size = UDim2.new(0, 200, 0, 25);
					v902.slotarea.BackgroundColor3 = Color3.new(0, 0, 0);
				end;
			end;		
		end;
	end;
end;
local u104 = {
	["come at me"] = 0.5, 
	facepalm = 0.5, 
	["raise weapon"] = 0.2
};
local u105 = false;
local function u106(p100, p101)
	p100.status.Visible = true;
	local v908 = tick();
	while true do
		p100.hunted.Position = p100.hunted.Position:Lerp(UDim2.new(0.5, 0, 0.2, 0), 0.1);
		p100.focus.Position = p100.focus.Position:Lerp(UDim2.new(1.5, 0, 0.6, 0), 0.3);
		p100.status.Position = p100.status.Position:Lerp(UDim2.new(0.5, 0, 1, 0), 0.1);
		RS:wait();
		if tick() - v908 >= 2 then
			break;
		end;	
	end;
	playerstats = l__workspace__1.ServerStuff.retrieveStats:InvokeServer();
	if p101 == "loss" then
		p100.status.spectate.Visible = false;
		p100.status.menu.Visible = true;
		local v909 = { "WHAT THE HELL WERE YOU DOING?", "I'M BEWILDERED", "THAT'S JUST SAD", "UNFORTUNATE", "YOU DISAPPOINT ME", "HOW DID YOU MANAGE THAT?", "IMPRESSIVE", "SMOOTH MOVES", "EVERYONE MAKES MISTAKES", "THE MISTAKE HERE IS YOU", "UNFORTUNATE ACCIDENT", "THAT'S RATHER SAD", "DAMN", "WELL YOU TRIED", "YOU GET POINTS FOR TRYING" };
		p100.status.reports.killedby.eliminatedlevel.Text = v909[math.random(1, #v909)];
		if v109.killer ~= nil and (l__game__7.Players:FindFirstChild(v109.killer) or v109.killer == "Contestant") then
			local v910 = l__workspace__1.ServerStuff.relaylobbystat:InvokeServer(v109.killer);
			if v910 then
				local v911 = v109.killer;
				local v912 = v910.Level;
				if v910.Settings.Anonymous == true then
					if l__game__7.Players:FindFirstChild(v109.killer).Character and l__game__7.Players:FindFirstChild(v109.killer).Character:FindFirstChild("playerID") then
						local v913 = "Contestant #" .. l__game__7.Players:FindFirstChild(v109.killer).Character:FindFirstChild("playerID").Value;
					end;
					v911 = "Contestant";
					v912 = 0;
				end;
				p100.status.reports.killedby.eliminated.Text = "ELIMINATED BY: " .. v911;
				p100.status.reports.killedby.eliminatedlevel.Text = "LEVEL " .. v912;
			else
				p100.status.reports.killedby.eliminated.Text = "ELIMINATED BY: Contestant";
				p100.status.reports.killedby.eliminatedlevel.Text = "LEVEL " .. 0;
			end;
		end;
	else
		p100.status.reports.killedby.eliminated.Text = "TOTAL WINS: " .. playerstats.MainStats.Wins;
		p100.status.reports.killedby.eliminatedlevel.Text = "WIN STREAK: " .. playerstats.MainStats.WinStreak;
	end;
	p100.status.reports.rankings.damage.Text = "MELEE DAMAGE DONE: " .. math.ceil(v109.damage);
	p100.status.reports.rankings.eliminations.Text = "ELIMINATIONS: " .. v109.kills;
	p100.status.reports.rankings.timealive.Text = "TIME ALIVE: " .. math.ceil((tick() - v109.timealive) / 60) .. "M";
	p100.status.reports.fansearned.amt.Text = "FANS EARNED: " .. playerstats.MatchXP;
	local v914 = "ST";
	if v109.placed == 2 then
		v914 = "ND";
	elseif v109.placed == 3 then
		v914 = "RD";
	elseif v109.placed > 3 then
		v914 = "TH";
	end;
	p100.status.reports.rankings.place.Text = "PLACED: " .. v109.placed .. v914;
	if p101 == "siege" then
		p100.status.reports.rankings.place.Visible = false;
	end;
	local function v915(p102)
		local v916 = 0;
		local v917 = tick();
		while true do
			p102.Visible = true;
			if tick() - v917 >= 0.075 then
				v917 = tick();
				v916 = v916 + 1;
				p102.Visible = false;
			end;
			RS:wait();
			if v916 >= 5 then
				break;
			end;		
		end;
		p102.Visible = true;
	end;
	v915(p100.status.reports.killedby);
	spawn(function()
		v915(p100.status.reports.rankings);
	end);
	spawn(function()
		v915(p100.status.reports.fansearned);
	end);
end;
local u107 = nil;
local u108 = nil;
local u109 = nil;
local u110 = nil;
function alertplay(p103, p104)
	if typeof(p103) == "table" then

	else
		local v918 = nil;
		local v919 = nil;
		local v920 = nil;
		local v921 = nil;
		local v922 = nil;
		local v923 = nil;
		local v924 = nil;
		local v925 = nil;
		local v926 = nil;
		local v927 = nil;
		local v928 = nil;
		local v929 = nil;
		local v930 = nil;
		local v931 = nil;
		local v932 = nil;
		local v933 = nil;
		local v934 = nil;
		local v935 = nil;
		local v936 = nil;
		local v937 = nil;
		local v938 = nil;
		local v939 = nil;
		local v940 = nil;
		local v941 = nil;
		local v942 = nil;
		local v943 = nil;
		local v944 = nil;
		local v945 = nil;
		local v946 = nil;
		local v947 = nil;
		local v948 = nil;
		if p103 == "THE SIEGE HAS BEGUN" then
			if startperk.Value == "hubbing" then
				return;
			else
				v101({ "gamemode" }, "horn", nil, nil, true, true);
				u56("begin");
				v918 = false;
				v919 = maingui;
				v920 = "alert";
				v921 = v919;
				v922 = v920;
				v923 = v921[v922];
				local v949 = "TextTransparency";
				v924 = v923;
				v925 = v949;
				v926 = v924[v925];
				local v950 = 1;
				v927 = v926;
				v928 = v950;
				if v927 == v928 then
					v918 = true;
				end;
				local v951 = tick;
				v929 = v951;
				local v952 = v929();
				v930 = v952;
				alertplaytimer = v930;
				local v953 = maingui;
				local v954 = "alert";
				v931 = v953;
				v932 = v954;
				local v955 = v931[v932];
				local v956 = "Text";
				v933 = v955;
				v934 = v956;
				v935 = p103;
				v933[v934] = v935;
				local v957 = maingui;
				local v958 = "alert";
				v936 = v957;
				v937 = v958;
				local v959 = v936[v937];
				local v960 = 0;
				local v961 = "TextTransparency";
				v938 = v959;
				v939 = v961;
				v940 = v960;
				v938[v939] = v940;
				local v962 = maingui;
				local v963 = "alert";
				v941 = v962;
				v942 = v963;
				local v964 = v941[v942];
				local v965 = 0;
				local v966 = "TextStrokeTransparency";
				v943 = v964;
				v944 = v966;
				v945 = v965;
				v943[v944] = v945;
				v946 = p104;
				if v946 then
					if p104 == "scavwar" then
						if maingui.NightEvent.Visible == false then
							maingui.NightEvent.Visible = true;
							maingui.NightEvent.lefticon.ImageTransparency = 0;
							maingui.NightEvent.righticon.ImageTransparency = 0;
							maingui.NightEvent.middletext.ImageTransparency = 0;
							maingui.NightEvent.lefticon.Position = UDim2.new(-0.2, 0, 0.5, 0);
							maingui.NightEvent.righticon.Position = UDim2.new(1.2, 0, 0.5, 0);
							maingui.NightEvent.lefticon.Visible = true;
							maingui.NightEvent.middletext.Visible = false;
							maingui.NightEvent.righticon.Visible = true;
							spawn(function()
								v101({ "general_ui" }, "nightevent_start", nil, nil, true, true);
								local v967 = 1 - 1;
								while true do
									maingui.NightEvent.lefticon.Position = maingui.NightEvent.lefticon.Position + UDim2.new(0.055, 0, 0, 0);
									maingui.NightEvent.righticon.Position = maingui.NightEvent.righticon.Position - UDim2.new(0.055, 0, 0, 0);
									RS:wait();
									if 0 <= 1 then
										if v967 < 10 then

										else
											break;
										end;
									elseif 10 < v967 then

									else
										break;
									end;
									v967 = v967 + 1;								
								end;
								maingui.NightEvent.lefticon.Position = UDim2.new(0.35, 0, 0.5, 0);
								maingui.NightEvent.righticon.Position = UDim2.new(0.65, 0, 0.5, 0);
								v101({ "general_ui" }, "nightevent_mid", nil, nil, true, true);
								v101({ "general_ui" }, "nightevent_scav", nil, nil, true, true);
								local v968 = Instance.new("Frame");
								v968.Name = "flashwhite";
								v968.BorderSizePixel = 0;
								v968.BackgroundColor3 = Color3.new(1, 1, 1);
								v968.Size = UDim2.new(1, 0, 1, 0);
								v968.ZIndex = 3;
								v968.Parent = maingui;
								maingui.NightEvent.middletext.Visible = true;
								local v969 = tick();
								while true do
									v968.BackgroundTransparency = v968.BackgroundTransparency + 0.05;
									RS:wait();
									if not (4 <= tick() - v969) then

									else
										break;
									end;								
								end;
								v968:Destroy();
								while true do
									maingui.NightEvent.middletext.ImageTransparency = maingui.NightEvent.middletext.ImageTransparency + 0.05;
									maingui.NightEvent.lefticon.ImageTransparency = maingui.NightEvent.middletext.ImageTransparency;
									maingui.NightEvent.righticon.ImageTransparency = maingui.NightEvent.middletext.ImageTransparency;
									RS:wait();
									if not (1 <= maingui.NightEvent.middletext.ImageTransparency) then

									else
										break;
									end;								
								end;
								maingui.NightEvent.lefticon.Visible = false;
								maingui.NightEvent.middletext.Visible = false;
								maingui.NightEvent.righticon.Visible = false;
								maingui.NightEvent.Visible = false;
							end);
						end;
					end;
				end;
				local v970 = true;
				v947 = v918;
				v948 = v970;
				if v947 == v948 then
					spawn(function()
						while true do
							if 7 < tick() - alertplaytimer then
								maingui.alert.TextTransparency = maingui.alert.TextTransparency + 0.05;
							else
								maingui.alert.TextTransparency = 0;
							end;
							maingui.alert.TextStrokeTransparency = maingui.alert.TextTransparency;
							RS:wait();
							if not (1 <= maingui.alert.TextTransparency) then

							else
								break;
							end;						
						end;
						maingui.alert.TextTransparency = 1;
						maingui.alert.TextStrokeTransparency = maingui.alert.TextTransparency;
					end);
				end;
				return;
			end;
		elseif p103 == "THE SIEGE IS ABOUT TO COMMENCE" then
			if startperk.Value == "hubbing" then
				return;
			else
				spawn(function()
					if playerstats.Settings.MuteMusic == false then
						while true do
							l__workspace__1.clientmusic.Volume = l__workspace__1.clientmusic.Volume - 0.035;
							RS:wait();
							if not (l__workspace__1.clientmusic.Volume <= 0) then

							else
								break;
							end;						
						end;
						l__workspace__1.clientmusic.Volume = 1;
						l__workspace__1.clientmusic.Looped = false;
						l__workspace__1.clientmusic.SoundId = l__game__7.ReplicatedStorage.soundLibrary.gamemode.siegebeginning.SoundId;
						l__workspace__1.clientmusic:Play();
					end;
				end);
				v918 = false;
				v919 = maingui;
				v920 = "alert";
				v921 = v919;
				v922 = v920;
				v923 = v921[v922];
				v949 = "TextTransparency";
				v924 = v923;
				v925 = v949;
				v926 = v924[v925];
				v950 = 1;
				v927 = v926;
				v928 = v950;
				if v927 == v928 then
					v918 = true;
				end;
				v951 = tick;
				v929 = v951;
				v952 = v929();
				v930 = v952;
				alertplaytimer = v930;
				v953 = maingui;
				v954 = "alert";
				v931 = v953;
				v932 = v954;
				v955 = v931[v932];
				v956 = "Text";
				v933 = v955;
				v934 = v956;
				v935 = p103;
				v933[v934] = v935;
				v957 = maingui;
				v958 = "alert";
				v936 = v957;
				v937 = v958;
				v959 = v936[v937];
				v960 = 0;
				v961 = "TextTransparency";
				v938 = v959;
				v939 = v961;
				v940 = v960;
				v938[v939] = v940;
				v962 = maingui;
				v963 = "alert";
				v941 = v962;
				v942 = v963;
				v964 = v941[v942];
				v965 = 0;
				v966 = "TextStrokeTransparency";
				v943 = v964;
				v944 = v966;
				v945 = v965;
				v943[v944] = v945;
				v946 = p104;
				if v946 then
					if p104 == "scavwar" then
						if maingui.NightEvent.Visible == false then
							maingui.NightEvent.Visible = true;
							maingui.NightEvent.lefticon.ImageTransparency = 0;
							maingui.NightEvent.righticon.ImageTransparency = 0;
							maingui.NightEvent.middletext.ImageTransparency = 0;
							maingui.NightEvent.lefticon.Position = UDim2.new(-0.2, 0, 0.5, 0);
							maingui.NightEvent.righticon.Position = UDim2.new(1.2, 0, 0.5, 0);
							maingui.NightEvent.lefticon.Visible = true;
							maingui.NightEvent.middletext.Visible = false;
							maingui.NightEvent.righticon.Visible = true;
							spawn(function()
								v101({ "general_ui" }, "nightevent_start", nil, nil, true, true);
								v967 = 1 - 1;
								while true do
									maingui.NightEvent.lefticon.Position = maingui.NightEvent.lefticon.Position + UDim2.new(0.055, 0, 0, 0);
									maingui.NightEvent.righticon.Position = maingui.NightEvent.righticon.Position - UDim2.new(0.055, 0, 0, 0);
									RS:wait();
									if 0 <= 1 then
										if v967 < 10 then

										else
											break;
										end;
									elseif 10 < v967 then

									else
										break;
									end;
									v967 = v967 + 1;								
								end;
								maingui.NightEvent.lefticon.Position = UDim2.new(0.35, 0, 0.5, 0);
								maingui.NightEvent.righticon.Position = UDim2.new(0.65, 0, 0.5, 0);
								v101({ "general_ui" }, "nightevent_mid", nil, nil, true, true);
								v101({ "general_ui" }, "nightevent_scav", nil, nil, true, true);
								v968 = Instance.new("Frame");
								v968.Name = "flashwhite";
								v968.BorderSizePixel = 0;
								v968.BackgroundColor3 = Color3.new(1, 1, 1);
								v968.Size = UDim2.new(1, 0, 1, 0);
								v968.ZIndex = 3;
								v968.Parent = maingui;
								maingui.NightEvent.middletext.Visible = true;
								v969 = tick();
								while true do
									v968.BackgroundTransparency = v968.BackgroundTransparency + 0.05;
									RS:wait();
									if not (4 <= tick() - v969) then

									else
										break;
									end;								
								end;
								v968:Destroy();
								while true do
									maingui.NightEvent.middletext.ImageTransparency = maingui.NightEvent.middletext.ImageTransparency + 0.05;
									maingui.NightEvent.lefticon.ImageTransparency = maingui.NightEvent.middletext.ImageTransparency;
									maingui.NightEvent.righticon.ImageTransparency = maingui.NightEvent.middletext.ImageTransparency;
									RS:wait();
									if not (1 <= maingui.NightEvent.middletext.ImageTransparency) then

									else
										break;
									end;								
								end;
								maingui.NightEvent.lefticon.Visible = false;
								maingui.NightEvent.middletext.Visible = false;
								maingui.NightEvent.righticon.Visible = false;
								maingui.NightEvent.Visible = false;
							end);
						end;
					end;
				end;
				v970 = true;
				v947 = v918;
				v948 = v970;
				if v947 == v948 then
					spawn(function()
						while true do
							if 7 < tick() - alertplaytimer then
								maingui.alert.TextTransparency = maingui.alert.TextTransparency + 0.05;
							else
								maingui.alert.TextTransparency = 0;
							end;
							maingui.alert.TextStrokeTransparency = maingui.alert.TextTransparency;
							RS:wait();
							if not (1 <= maingui.alert.TextTransparency) then

							else
								break;
							end;						
						end;
						maingui.alert.TextTransparency = 1;
						maingui.alert.TextStrokeTransparency = maingui.alert.TextTransparency;
					end);
				end;
				return;
			end;
		else
			if p103 == "TRANSPORT SHIP IS HERE - GOOD WORK OUT THERE, EVERYONE" then
				l__workspace__1.clientmusic.Volume = 1;
				l__workspace__1.clientmusic.Looped = false;
				l__workspace__1.clientmusic:Stop();
			elseif p103 == "DAMNIT! WE'RE HIT BY AN ORBITAL BOMBARDMENT!" then
				l__workspace__1.clientmusic.Volume = 1;
				l__workspace__1.clientmusic.Looped = false;
				l__workspace__1.clientmusic.SoundId = l__game__7.ReplicatedStorage.soundLibrary.gamemode.gamemodeA.SoundId;
				l__workspace__1.clientmusic:Play();
			elseif p103 == "ANOTHER WAVE INCOMING! WE'VE GOT SOME MORE SUPPLIES FOR YOU!" then
				l__workspace__1.clientmusic.Volume = 1;
				l__workspace__1.clientmusic.Looped = true;
				l__workspace__1.clientmusic.SoundId = l__game__7.ReplicatedStorage.soundLibrary.gamemode.gamemodeC.SoundId;
				l__workspace__1.clientmusic:Play();
			elseif p103 == "'You believe you can stand against Ulacylon? I'll personally sign your death report!'" then
				l__workspace__1.clientmusic.Volume = 1;
				l__workspace__1.clientmusic.Looped = false;
				l__workspace__1.clientmusic.SoundId = l__game__7.ReplicatedStorage.soundLibrary.gamemode.gamemodeB.SoundId;
				l__workspace__1.clientmusic:Play();
			elseif p103 == "DUEL BEGINNING" then
				l__game__7.ReplicatedStorage.effects.spawnFX:Clone().Parent = ply.PlayerGui;
				maingui.hubframe.hubdisp.Text = "PRESS K TO FORFEIT";
				maingui.HealthFrame.Visible = true;
				maingui.StaminaFrame.Visible = true;
				u107 = mouse.Button1Down:connect(u108);
				u109 = mouse.Button2Down:connect(u110);
				maingui.Centre.Visible = true;
			end;
			v918 = false;
			v919 = maingui;
			v920 = "alert";
			v921 = v919;
			v922 = v920;
			v923 = v921[v922];
			v949 = "TextTransparency";
			v924 = v923;
			v925 = v949;
			v926 = v924[v925];
			v950 = 1;
			v927 = v926;
			v928 = v950;
			if v927 == v928 then
				v918 = true;
			end;
			v951 = tick;
			v929 = v951;
			v952 = v929();
			v930 = v952;
			alertplaytimer = v930;
			v953 = maingui;
			v954 = "alert";
			v931 = v953;
			v932 = v954;
			v955 = v931[v932];
			v956 = "Text";
			v933 = v955;
			v934 = v956;
			v935 = p103;
			v933[v934] = v935;
			v957 = maingui;
			v958 = "alert";
			v936 = v957;
			v937 = v958;
			v959 = v936[v937];
			v960 = 0;
			v961 = "TextTransparency";
			v938 = v959;
			v939 = v961;
			v940 = v960;
			v938[v939] = v940;
			v962 = maingui;
			v963 = "alert";
			v941 = v962;
			v942 = v963;
			v964 = v941[v942];
			v965 = 0;
			v966 = "TextStrokeTransparency";
			v943 = v964;
			v944 = v966;
			v945 = v965;
			v943[v944] = v945;
			v946 = p104;
			if v946 then
				if p104 == "scavwar" then
					if maingui.NightEvent.Visible == false then
						maingui.NightEvent.Visible = true;
						maingui.NightEvent.lefticon.ImageTransparency = 0;
						maingui.NightEvent.righticon.ImageTransparency = 0;
						maingui.NightEvent.middletext.ImageTransparency = 0;
						maingui.NightEvent.lefticon.Position = UDim2.new(-0.2, 0, 0.5, 0);
						maingui.NightEvent.righticon.Position = UDim2.new(1.2, 0, 0.5, 0);
						maingui.NightEvent.lefticon.Visible = true;
						maingui.NightEvent.middletext.Visible = false;
						maingui.NightEvent.righticon.Visible = true;
						spawn(function()
							v101({ "general_ui" }, "nightevent_start", nil, nil, true, true);
							v967 = 1 - 1;
							while true do
								maingui.NightEvent.lefticon.Position = maingui.NightEvent.lefticon.Position + UDim2.new(0.055, 0, 0, 0);
								maingui.NightEvent.righticon.Position = maingui.NightEvent.righticon.Position - UDim2.new(0.055, 0, 0, 0);
								RS:wait();
								if 0 <= 1 then
									if v967 < 10 then

									else
										break;
									end;
								elseif 10 < v967 then

								else
									break;
								end;
								v967 = v967 + 1;							
							end;
							maingui.NightEvent.lefticon.Position = UDim2.new(0.35, 0, 0.5, 0);
							maingui.NightEvent.righticon.Position = UDim2.new(0.65, 0, 0.5, 0);
							v101({ "general_ui" }, "nightevent_mid", nil, nil, true, true);
							v101({ "general_ui" }, "nightevent_scav", nil, nil, true, true);
							v968 = Instance.new("Frame");
							v968.Name = "flashwhite";
							v968.BorderSizePixel = 0;
							v968.BackgroundColor3 = Color3.new(1, 1, 1);
							v968.Size = UDim2.new(1, 0, 1, 0);
							v968.ZIndex = 3;
							v968.Parent = maingui;
							maingui.NightEvent.middletext.Visible = true;
							v969 = tick();
							while true do
								v968.BackgroundTransparency = v968.BackgroundTransparency + 0.05;
								RS:wait();
								if not (4 <= tick() - v969) then

								else
									break;
								end;							
							end;
							v968:Destroy();
							while true do
								maingui.NightEvent.middletext.ImageTransparency = maingui.NightEvent.middletext.ImageTransparency + 0.05;
								maingui.NightEvent.lefticon.ImageTransparency = maingui.NightEvent.middletext.ImageTransparency;
								maingui.NightEvent.righticon.ImageTransparency = maingui.NightEvent.middletext.ImageTransparency;
								RS:wait();
								if not (1 <= maingui.NightEvent.middletext.ImageTransparency) then

								else
									break;
								end;							
							end;
							maingui.NightEvent.lefticon.Visible = false;
							maingui.NightEvent.middletext.Visible = false;
							maingui.NightEvent.righticon.Visible = false;
							maingui.NightEvent.Visible = false;
						end);
					end;
				end;
			end;
			v970 = true;
			v947 = v918;
			v948 = v970;
			if v947 == v948 then
				spawn(function()
					while true do
						if 7 < tick() - alertplaytimer then
							maingui.alert.TextTransparency = maingui.alert.TextTransparency + 0.05;
						else
							maingui.alert.TextTransparency = 0;
						end;
						maingui.alert.TextStrokeTransparency = maingui.alert.TextTransparency;
						RS:wait();
						if not (1 <= maingui.alert.TextTransparency) then

						else
							break;
						end;					
					end;
					maingui.alert.TextTransparency = 1;
					maingui.alert.TextStrokeTransparency = maingui.alert.TextTransparency;
				end);
			end;
			return;
		end;
	end;
	if startperk.Value == "hubbing" then
		return;
	end;
	if p103[1] == ply.Name then
		v109.placed = 1;
		if playerstats.Settings.MuteMusic == false then
			l__workspace__1.clientmusic:Stop();
			l__workspace__1.clientmusic.SoundId = l__game__7.ReplicatedStorage.soundLibrary.gamemode.matchwin.SoundId;
			l__workspace__1.clientmusic.Volume = 1.5;
			l__workspace__1.clientmusic:Play();
		end;
		local v971, v972, v973 = ipairs(maingui:GetChildren());
		while true do
			local v974, v975 = v971(v972, v973);
			if v974 then

			else
				break;
			end;
			v973 = v974;
			if v975:IsA("ScreenGui") ~= true then
				v975.Visible = false;
			end;		
		end;
		character.HumanoidRootPart.Anchored = true;
		delay(1.5, function()
			maingui.victoryframe.Visible = true;
		end);
		delay(5, function()
			while true do
				ply.PlayerGui.fadetoblack.frame.BackgroundTransparency = ply.PlayerGui.fadetoblack.frame.BackgroundTransparency - 0.05;
				RS:wait();
				if not (ply.PlayerGui.fadetoblack.frame.BackgroundTransparency <= 0) then

				else
					break;
				end;			
			end;
			delay(1, function()
				maingui.victoryframe.Visible = false;
				character.HumanoidRootPart.Anchored = false;
				character.HumanoidRootPart.CFrame = l__workspace__1.VictoryPodium.tpto.CFrame;
				l__game__7:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true);
				delay(0.5, function()
					v101({ "gamemode" }, "cheer", nil, nil, true, true);
					v101({ "gamemode" }, "fireworks", nil, nil, true, true);
					while true do
						ply.PlayerGui.fadetoblack.frame.BackgroundTransparency = ply.PlayerGui.fadetoblack.frame.BackgroundTransparency + 0.05;
						RS:wait();
						if not (1 <= ply.PlayerGui.fadetoblack.frame.BackgroundTransparency) then

						else
							break;
						end;					
					end;
					delay(2, function()
						local v976 = l__game__7.ReplicatedStorage.effects.endgamegui:Clone();
						v976.Parent = ply.PlayerGui;
						u106(v976, "win");
						delay(25, function()
							while true do
								ply.PlayerGui.fadetoblack.frame.BackgroundTransparency = ply.PlayerGui.fadetoblack.frame.BackgroundTransparency - 0.05;
								RS:wait();
								if not (ply.PlayerGui.fadetoblack.frame.BackgroundTransparency <= 0) then

								else
									break;
								end;							
							end;
						end);
					end);
				end);
			end);
		end);
		return;
	end;
	if p103[1] ~= "TeamA" then
		if p103[1] == "TeamB" then

		elseif p103[1] == "event" then
			if l__workspace__1.ServerStuff.game.stage.Value ~= "gameinprogress" then
				return;
			else
				if playerstats.Settings.MuteMusic == false then
					v101({ "events", "survevents" }, p103[2], nil, nil, true, true);
				end;
				delay(0.3, function()
					local v977 = maingui.eventframe.frameofevent:Clone();
					if p103[2] == "killswitch" then
						v977.eventname.Text = "The KillSwitch!";
						v977.desc.Text = "A master KillSwitch Panel has been placed in the center of the map!\nActivate it and see what happens!";
					elseif p103[2] == "monte" then
						v977.eventname.Text = "Three Crate Monte!";
						v977.desc.Text = "One Ulacylon Special airdrop have been delivered to the center arena!\nThe other two will go boom!";
					elseif p103[2] == "bloodrush" then
						v977.eventname.Text = "Blood Rush!";
						v977.desc.Text = "Soon, every contestant will be marked through walls with their health status!\nKills will grant a health bonus!";
						delay(7, function()
							local v978 = l__game__7.ReplicatedStorage.effects.bloodrushflash:Clone();
							l__Debris__27:AddItem(v978, 5);
							v101({ "events" }, "bloodrushsfx", nil, nil, true, true);
							afflictstatus(require(l__game__7.Workspace.ServerStuff.Statistics.S_STATISTICS)["Speedy Thrusts"]);
							v978.Parent = ply.PlayerGui;
							spawn(function()
								while true do
									v978.frame.BackgroundTransparency = v978.frame.BackgroundTransparency + 0.05;
									RS:wait();
									if not (1 <= v978.frame.BackgroundTransparency) then

									else
										break;
									end;								
								end;
							end);
							l__game__7.ReplicatedStorage.effects.bloodrush:Clone().Parent = l__game__7.Lighting;
							local v979, v980, v981 = ipairs(l__workspace__1.activePlayers:GetChildren());
							while true do
								local v982, v983 = v979(v980, v981);
								if v982 then

								else
									break;
								end;
								v981 = v982;
								if v983.Name ~= character.Name then
									if v983:FindFirstChild("Humanoid") then
										if 0 < v983:FindFirstChild("Humanoid").Health then
											if v983:FindFirstChild("Head") then
												local v984 = l__game__7.ReplicatedStorage.misc.teammateindicator:Clone();
												v984.Name = "BloodRushMarker";
												v984.AlwaysOnTop = true;
												local v985 = v983:FindFirstChild("Humanoid").Health / v983:FindFirstChild("Humanoid").MaxHealth;
												if v985 <= 0.5 then
													v985 = v985 - 0.1;
												end;
												v984.ImageLabel.ImageColor3 = Color3.new(1, v985, v985);
												v984.Adornee = v983.Head;
												v984.Parent = ply.PlayerGui;
												v983.Humanoid.Died:Connect(function()
													v984:Destroy();
												end);
											end;
										end;
									end;
								end;							
							end;
							delay(20, function()
								local v986 = l__game__7.ReplicatedStorage.effects.bloodrushflash:Clone();
								l__Debris__27:AddItem(v986, 5);
								v986.Parent = ply.PlayerGui;
								spawn(function()
									while true do
										v986.frame.BackgroundTransparency = v986.frame.BackgroundTransparency + 0.05;
										RS:wait();
										if not (1 <= v986.frame.BackgroundTransparency) then

										else
											break;
										end;									
									end;
								end);
								if l__game__7.Lighting:FindFirstChild("bloodrush") then
									l__game__7.Lighting:FindFirstChild("bloodrush"):Destroy();
								end;
								if u10["Speed Buff"] then
									u10["Speed Buff"].effects.currentduration = 0;
								end;
								local v987, v988, v989 = ipairs(ply.PlayerGui:GetChildren());
								while true do
									local v990, v991 = v987(v988, v989);
									if v990 then

									else
										break;
									end;
									v989 = v990;
									if v991.Name == "BloodRushMarker" then
										v991:Destroy();
									end;								
								end;
							end);
						end);
					elseif p103[2] == "flareraid" then
						v977.eventname.Text = "Flare Raid!";
						v977.desc.Text = "Three Drones will fly over the arena and drop a Flare Box!\nGrab them while it's hot!";
					elseif p103[2] == "exotic" then
						v977.eventname.Text = "Exotic Armoury!";
						v977.desc.Text = "A very slow drone carrying an Airdrop with an exceedingly dangerous weapon will arrive at the map centre!";
					elseif p103[2] == "thunder" then
						v977.eventname.Text = "Rolling Thunder!";
						v977.desc.Text = "Soon, missiles will embed across the arena before exploding!\nGet to a safe bunker!";
					end;
					v977.Parent = maingui.eventframe;
					spawn(function()
						local v992 = 1 - 1;
						while true do
							v977.Position = v977.Position:Lerp(UDim2.new(0, 0, 0, 0), 0.1);
							RS:wait();
							if 0 <= 1 then
								if v992 < 60 then

								else
									break;
								end;
							elseif 60 < v992 then

							else
								break;
							end;
							v992 = v992 + 1;						
						end;
						delay(8, function()
							local v993 = 1 - 1;
							while true do
								v977.Position = v977.Position:Lerp(UDim2.new(-1.5, 0, 0, 0), 0.1);
								RS:wait();
								if 0 <= 1 then
									if v993 < 60 then

									else
										break;
									end;
								elseif 60 < v993 then

								else
									break;
								end;
								v993 = v993 + 1;							
							end;
							v977:Destroy();
						end);
					end);
				end);
				return;
			end;
		else
			delay(5, function()
				while true do
					ply.PlayerGui.fadetoblack.frame.BackgroundTransparency = ply.PlayerGui.fadetoblack.frame.BackgroundTransparency - 0.05;
					RS:wait();
					if not (ply.PlayerGui.fadetoblack.frame.BackgroundTransparency <= 0) then

					else
						break;
					end;				
				end;
				l__CurrentCamera__1.CameraType = "Scriptable";
				l__CurrentCamera__1.CameraSubject = nil;
				l__CurrentCamera__1.FieldOfView = 40;
				l__CurrentCamera__1.CFrame = CFrame.new(-0.148798391, -353.016663, -454.323242, 0.999984622, -0.000636289711, -0.00550709572, -5.82076609E-11, 0.993391395, -0.114776433, 0.00554373208, 0.114774667, 0.993376136);
				delay(3, function()
					while true do
						ply.PlayerGui.fadetoblack.frame.BackgroundTransparency = ply.PlayerGui.fadetoblack.frame.BackgroundTransparency + 0.05;
						RS:wait();
						if not (1 <= ply.PlayerGui.fadetoblack.frame.BackgroundTransparency) then

						else
							break;
						end;					
					end;
					delay(30, function()
						while true do
							ply.PlayerGui.fadetoblack.frame.BackgroundTransparency = ply.PlayerGui.fadetoblack.frame.BackgroundTransparency - 0.05;
							RS:wait();
							if not (ply.PlayerGui.fadetoblack.frame.BackgroundTransparency <= 0) then

							else
								break;
							end;						
						end;
					end);
				end);
			end);
			return;
		end;
	end;
	local v994 = true;
	if p103[1] == "TeamA" then
		if startperk.Value ~= "siegeB" then
			if startperk.Value ~= "tElimB" then
				if startperk.Value ~= "hiddenB" then
					if startperk.Value ~= "turfwarB" then
						if startperk.Value ~= "jElimB" then
							if startperk.Value ~= "shadowForm" then
								if startperk.Value ~= "commander" then
									if p103[1] == "TeamB" then
										if startperk.Value ~= "siegeA" then
											if startperk.Value ~= "tElimA" then
												if startperk.Value ~= "hiddenA" then
													if startperk.Value ~= "shadowGame" then
														if startperk.Value ~= "coopvsDS" then
															if startperk.Value ~= "coopvsRIS" then
																if startperk.Value ~= "turfwarA" then
																	if startperk.Value ~= "jElimA" then
																		if startperk.Value == "emperor" then
																			v994 = false;
																		end;
																	else
																		v994 = false;
																	end;
																else
																	v994 = false;
																end;
															else
																v994 = false;
															end;
														else
															v994 = false;
														end;
													else
														v994 = false;
													end;
												else
													v994 = false;
												end;
											else
												v994 = false;
											end;
										else
											v994 = false;
										end;
									end;
								else
									v994 = false;
								end;
							else
								v994 = false;
							end;
						else
							v994 = false;
						end;
					else
						v994 = false;
					end;
				else
					v994 = false;
				end;
			else
				v994 = false;
			end;
		else
			v994 = false;
		end;
	elseif p103[1] == "TeamB" then
		if startperk.Value ~= "siegeA" then
			if startperk.Value ~= "tElimA" then
				if startperk.Value ~= "hiddenA" then
					if startperk.Value ~= "shadowGame" then
						if startperk.Value ~= "coopvsDS" then
							if startperk.Value ~= "coopvsRIS" then
								if startperk.Value ~= "turfwarA" then
									if startperk.Value ~= "jElimA" then
										if startperk.Value == "emperor" then
											v994 = false;
										end;
									else
										v994 = false;
									end;
								else
									v994 = false;
								end;
							else
								v994 = false;
							end;
						else
							v994 = false;
						end;
					else
						v994 = false;
					end;
				else
					v994 = false;
				end;
			else
				v994 = false;
			end;
		else
			v994 = false;
		end;
	end;
	local v995 = "teamvictory";
	delay(0.1, function()
		l__workspace__1.clientmusic.Volume = 0;
		if 0 < hum.Health then
			delay(4, function()
				local v996 = l__game__7.ReplicatedStorage.effects.endgamegui:Clone();
				v996.Parent = ply.PlayerGui;
				u106(v996, "siege");
			end);
		end;
	end);
	if v994 == false then
		maingui.TeamResults.bg.ImageColor3 = Color3.new(0.8705882352941177, 0, 0);
		maingui.TeamResults.definetext.Text = "D E F E A T";
		maingui.TeamResults.lowertext.Text = "TEAM LEADER ELIMINATED";
		v995 = "teamdefeat";
	end;
	if startperk.Value ~= "tElimB" then
		if startperk.Value == "tElimA" then
			maingui.TeamResults.lowertext.Text = "OPPOSING TEAM ELIMINATED";
			if v994 == false then
				maingui.TeamResults.lowertext.Text = "CURRENT TEAM ELIMINATED";
			end;
		end;
	else
		maingui.TeamResults.lowertext.Text = "OPPOSING TEAM ELIMINATED";
		if v994 == false then
			maingui.TeamResults.lowertext.Text = "CURRENT TEAM ELIMINATED";
		end;
	end;
	if startperk.Value ~= "hiddenA" then
		if startperk.Value == "hiddenB" then
			if startperk.Value == "hiddenA" then
				maingui.TeamResults.lowertext.Text = "HIDDEN ELIMINATED";
			else
				maingui.TeamResults.lowertext.Text = "ULACYLONS SOULS HAVE BEEN FREED";
			end;
			if v994 == false then
				if startperk.Value == "hiddenA" then
					maingui.TeamResults.lowertext.Text = "ULACYLON DEFEATED";
				else
					maingui.TeamResults.lowertext.Text = "THE HIDDEN HAS PERISHED";
				end;
			end;
		end;
	else
		if startperk.Value == "hiddenA" then
			maingui.TeamResults.lowertext.Text = "HIDDEN ELIMINATED";
		else
			maingui.TeamResults.lowertext.Text = "ULACYLONS SOULS HAVE BEEN FREED";
		end;
		if v994 == false then
			if startperk.Value == "hiddenA" then
				maingui.TeamResults.lowertext.Text = "ULACYLON DEFEATED";
			else
				maingui.TeamResults.lowertext.Text = "THE HIDDEN HAS PERISHED";
			end;
		end;
	end;
	if startperk.Value ~= "shadowForm" then
		if startperk.Value == "shadowGame" then
			if startperk.Value == "shadowGame" then
				maingui.TeamResults.lowertext.Text = "YOU HAVE SURVIVED AND EXTRACTED";
			else
				maingui.TeamResults.lowertext.Text = "ENOUGH SOULS HAVE BEEN REAPED FOR REIKGON";
			end;
			if v994 == false then
				if startperk.Value == "shadowGame" then
					maingui.TeamResults.lowertext.Text = "YOUR SOUL IS CONDEMNED TO REIKGON";
				else
					maingui.TeamResults.lowertext.Text = "INSUFFICIENT SOULS FOR REIKGON";
				end;
			end;
		end;
	else
		if startperk.Value == "shadowGame" then
			maingui.TeamResults.lowertext.Text = "YOU HAVE SURVIVED AND EXTRACTED";
		else
			maingui.TeamResults.lowertext.Text = "ENOUGH SOULS HAVE BEEN REAPED FOR REIKGON";
		end;
		if v994 == false then
			if startperk.Value == "shadowGame" then
				maingui.TeamResults.lowertext.Text = "YOUR SOUL IS CONDEMNED TO REIKGON";
			else
				maingui.TeamResults.lowertext.Text = "INSUFFICIENT SOULS FOR REIKGON";
			end;
		end;
	end;
	if startperk.Value ~= "turfwarA" then
		if startperk.Value == "turfwarB" then
			if startperk.Value == "turfwarA" then
				maingui.TeamResults.lowertext.Text = "RIS HAS BEEN ELIMINATED";
			else
				maingui.TeamResults.lowertext.Text = "UMG HAS BEEN FOUGHT BACK";
			end;
			if v994 == false then
				if startperk.Value == "turfwarA" then
					maingui.TeamResults.lowertext.Text = "SQUAD ELIMINATED";
				else
					maingui.TeamResults.lowertext.Text = "MISSION FAILURE";
				end;
			end;
		end;
	else
		if startperk.Value == "turfwarA" then
			maingui.TeamResults.lowertext.Text = "RIS HAS BEEN ELIMINATED";
		else
			maingui.TeamResults.lowertext.Text = "UMG HAS BEEN FOUGHT BACK";
		end;
		if v994 == false then
			if startperk.Value == "turfwarA" then
				maingui.TeamResults.lowertext.Text = "SQUAD ELIMINATED";
			else
				maingui.TeamResults.lowertext.Text = "MISSION FAILURE";
			end;
		end;
	end;
	if startperk.Value ~= "coopvsDS" then
		if startperk.Value == "coopvsRIS" then
			maingui.TeamResults.lowertext.Text = "MISSION SUCCESS";
			if v994 == false then
				maingui.TeamResults.lowertext.Text = "MISSION FAILURE";
			end;
		end;
	else
		maingui.TeamResults.lowertext.Text = "MISSION SUCCESS";
		if v994 == false then
			maingui.TeamResults.lowertext.Text = "MISSION FAILURE";
		end;
	end;
	if startperk.Value ~= "jElimA" then
		if startperk.Value == "jElimB" then
			if startperk.Value == "jElimA" then
				maingui.TeamResults.lowertext.Text = "JUGGERNAUT DEFEATED";
			else
				maingui.TeamResults.lowertext.Text = "JUGGERNAUT VICTORY";
			end;
			if v994 == false then
				if startperk.Value == "jElimA" then
					maingui.TeamResults.lowertext.Text = "TEAM WIPED OUT";
				else
					maingui.TeamResults.lowertext.Text = "JUGGERNAUT LOSS";
				end;
			end;
		end;
	else
		if startperk.Value == "jElimA" then
			maingui.TeamResults.lowertext.Text = "JUGGERNAUT DEFEATED";
		else
			maingui.TeamResults.lowertext.Text = "JUGGERNAUT VICTORY";
		end;
		if v994 == false then
			if startperk.Value == "jElimA" then
				maingui.TeamResults.lowertext.Text = "TEAM WIPED OUT";
			else
				maingui.TeamResults.lowertext.Text = "JUGGERNAUT LOSS";
			end;
		end;
	end;
	v101({ "gamemode" }, v995, nil, nil, true, true);
	maingui.TeamResults.Visible = true;
	spawn(function()
		local v997 = 1 - 1;
		while true do
			maingui.TeamResults.bg.ImageTransparency = maingui.TeamResults.bg.ImageTransparency - 0.075;
			maingui.TeamResults.bg.Size = maingui.TeamResults.bg.Size:Lerp(UDim2.new(1, 0, 1, 0), 0.1);
			RS:wait();
			if 0 <= 1 then
				if v997 < 60 then

				else
					break;
				end;
			elseif 60 < v997 then

			else
				break;
			end;
			v997 = v997 + 1;		
		end;
		delay(15, function()
			while true do
				ply.PlayerGui.fadetoblack.frame.BackgroundTransparency = ply.PlayerGui.fadetoblack.frame.BackgroundTransparency - 0.05;
				RS:wait();
				if not (ply.PlayerGui.fadetoblack.frame.BackgroundTransparency <= 0) then

				else
					break;
				end;			
			end;
		end);
	end);
end;
if playerstats.Class == "damn" or playerstats.Class == "survival" then
	maingui.PerkFrame.Visible = false;
	if playerstats.Class == "damn" then
		maingui.UpperLower.Visible = false;
		ration_system_handler.hunger = 0;
		ration_system_handler.thirst = 0;
	else
		ration_system_handler.hunger = tick();
		ration_system_handler.thirst = tick();
	end;
end;
if playerstats.Class == "hive" and character:FindFirstChild("playerSwarm") then
	character:FindFirstChild("playerSwarm").hive_loop.Volume = 0;
	character:FindFirstChild("playerSwarm").static.Enabled = false;
	character:FindFirstChild("playerSwarm").static2.Enabled = false;
end;
l__workspace__1.ServerStuff.alertPlay.OnClientEvent:Connect(alertplay);
spectating = false;
spectatesystem = nil;
kickoutspec = nil;
forcespecfolder = false;
if startperk.Value == "hubbing" then
	l__workspace__1.ServerStuff.game.stage.Changed:Connect(function(p105)
		if p105 ~= "gameinprogress" and spectating == true then
			kickoutspec();
		end;
		if p105 == "gamestartingnow" then
			alertplay("MAIN GAME IS ABOUT TO BEGIN");
			return;
		end;
		if p105 == "gameinprogress" then
			alertplay("MAIN GAME IS NOW IN PROGRESS");
			return;
		end;
		if p105 == "gameending" then
			alertplay("MAIN GAME IS ENDING");
			return;
		end;
		if p105 == "intermission" then
			alertplay("MAIN GAME IS NOW IN INTERMISSION");
		end;
	end);
end;
l__workspace__1.ServerStuff.killFeed.OnClientEvent:Connect(function(p106, p107)
	if startperk.Value == "hubbing" then
		return;
	end;
	if hum.Health <= 0 then
		return;
	end;
	if p106 == "aikill" and (u17.weapontype == "Bludgeon" or u17.weapontype == "Blade" or u17.weapontype == "Fists" or u17.weapontype == "Spear" or u17.weapontype == "Axe") then
		if v59.berzactive ~= nil then
			l__workspace__1.ServerStuff.dealDamage:FireServer("berzheal", nil, v5, v4);
			local v998 = v59.berzactive + v60[3].regenonkill;
			if tick() - v998 > 0 then
				v59.berzactive = v998;
				return;
			else
				v59.berzactive = tick();
				return;
			end;
		elseif v59.gogglesactive ~= nil and v59.gogglehandledamage ~= nil then
			v59.gogglehandledamage("add");
		end;
	end;
end);
if v60[3].start_empty == true then
	v68 = tick();
end;
local u111 = v68;
local u112 = false;
l__workspace__1.ServerStuff.givePlayerIndicator.OnClientEvent:Connect(function(p108, p109)
	if startperk.Value == "hubbing" or hum.Health <= 0 then
		return;
	end;
	if (p108 == "xpadded" or p108 == "addoden") and playerstats.Settings.HideGains == true then
		return;
	end;
	v101({ "general" }, "serverindicator", nil, nil, true, true);
	local v999 = maingui.Centre.xpandgold.ex:Clone();
	l__Debris__27:AddItem(v999, 5);
	v999.Name = "notex";
	v999.Visible = true;
	v999.Position = UDim2.new(0.5, 0, 0, -16 + 16 * #maingui.Centre.xpandgold:GetChildren());
	if p108 == "xpadded" then
		v999.Text = p109 .. " XP earned.";
	elseif p108 == "addoden" then
		v999.Text = p109 .. " Odens gained.";
	elseif p108 == "levelup" then
		v999.Text = "Levelled up to " .. p109 .. ".";
	elseif p108 == "prophetscan" then
		v999.Text = p109 .. " scanned.";
	elseif p108 == "lazarusbuff" then
		v999.Text = p109 .. " Lazarus buffed.";
	elseif p108 == "immolatebuff" then
		v999.Text = p109 .. " Immolator buffed.";
		afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).FireBuff);
	elseif p108 == "ticktriggered" then
		v999.Text = "Tick has been triggered.";
	elseif p108 == "commendgiven" then
		v999.Text = p109 .. " commended.";
	elseif p108 == "commended" then
		l__workspace__1.ServerStuff.adjustStats:FireServer("tracker", { "Commendments", 1 });
		v999.Text = "Commended by " .. p109 .. ".";
	elseif p108 == "dronelatched" then
		v999.Text = "Enemy has been Mindkilled.";
	elseif p108 == "dogtag" then
		v999.Text = p109 .. " Dogtag collected.";
		if playerstats.Class == "sword" then
			maingui.PerkFrame.numberstat.Visible = true;
			if v59.dogtags == nil then
				v59.dogtags = p109;
			else
				v59.dogtags = v59.dogtags + p109;
			end;
			maingui.PerkFrame.numberstat.Text = v59.dogtags;
			local v1000 = p109;
			if v60[3].dogtagmaxmovement < v59.dogtags then
				v1000 = v1000 - (v59.dogtags - v60[3].dogtagmaxmovement);
			end;
			if v1000 > 0 then
				u22 = u22 + u13 * (v60[3].dogtagmovementbuff * v1000) / 100;
			end;
		end;
	end;
	v999.Parent = maingui.Centre.xpandgold;
	spawn(function()
		while true do
			v999.gradient.ImageTransparency = v999.gradient.ImageTransparency + 0.1;
			v999.gradient.Size = v999.gradient.Size + UDim2.new(0, 2, 0, 0);
			RS:wait();
			if v999.gradient.ImageTransparency >= 1 then
				break;
			end;		
		end;
		v999.gradient.ImageTransparency = 1;
		local v1001 = tick();
		while true do
			RS:wait();
			if tick() - v1001 >= 2 then
				break;
			end;		
		end;
		while true do
			v999.TextTransparency = v999.TextTransparency + 0.1;
			v999.TextStrokeTransparency = v999.TextTransparency;
			RS:wait();
			if v999.TextTransparency >= 1 then
				break;
			end;		
		end;
		v999:Destroy();
		for v1002, v1003 in ipairs(maingui.Centre.xpandgold:GetChildren()) do
			if v1003.Name ~= "ex" and v1003.Position ~= UDim2.new(0.5, 0, 0, 0) then
				v1003.Position = v1003.Position - UDim2.new(0, 0, 0, 16);
			end;
		end;
	end);
end);
local function u113(p110, p111)
	local v1004 = p110;
	local v1005 = nil;
	for v1006, v1007 in ipairs(fparms:GetDescendants()) do
		if v1007.Name == v1004.Name and v1007:IsA("BasePart") then
			v1005 = v1007;
			v1004 = v1004:GetDescendants();
			break;
		end;
	end;
	if v1005 == nil then
		return;
	end;
	for v1008 = 1, #v1004 do
		if v1004[v1008]:IsA("BasePart") then
			v1004[v1008].Transparency = 0;
			local v1009 = Instance.new("Weld");
			v1009.Part0 = p110;
			v1009.Part1 = v1004[v1008];
			local v1010 = CFrame.new(p110.Position);
			v1009.C0 = p110.CFrame:inverse() * v1010;
			v1009.C1 = v1004[v1008].CFrame:inverse() * v1010;
			v1009.Parent = v1004[v1008];
			if p111 ~= nil then
				if v1004[v1008].Parent.Name == "primary" then
					if p111[1] ~= "original" then
						v1004[v1008].Color = Color3.new(p111[1][1], p111[1][2], p111[1][3]);
					end;
				elseif v1004[v1008].Parent.Name == "secondary" and p111[2] ~= "original" then
					v1004[v1008].Color = Color3.new(p111[2][1], p111[2][2], p111[2][3]);
				end;
			end;
			v1004[v1008].Locked = true;
			v1004[v1008].Anchored = false;
			v1004[v1008].CanCollide = false;
			v1004[v1008].Parent = p110;
		end;
	end;
	local v1011 = Instance.new("Weld");
	v1011.Part0 = v1005;
	v1011.Part1 = p110;
	v1011.C0 = CFrame.new(0, 0, 0);
	v1011.Parent = fparms.SkinParts;
	if p110.Parent.Name ~= "primary" and p110.Parent.Name ~= "secondary" then
		p110.Parent = fparms.SkinParts;
		return;
	end;
	p110.Parent.Parent = fparms.SkinParts;
end;
u80 = function(p112, p113)
	for v1012, v1013 in ipairs(fparms.SkinParts:GetChildren()) do
		v1013:Destroy();
	end;
	local v1014 = l__game__7.ReplicatedStorage.skins.firstperson:WaitForChild(p112):Clone();
	for v1015, v1016 in ipairs(fparms:GetDescendants()) do
		for v1017, v1018 in ipairs(v1014:GetChildren()) do
			if v1016.Name == v1018.Name and v1016:IsA("BasePart") then
				v1016.BrickColor = v1018.BrickColor;
			end;
		end;
	end;
	for v1019, v1020 in ipairs(v1014:GetChildren()) do
		if v1020:IsA("BasePart") then
			v1020.Transparency = 1;
			u113(v1020, p113);
		end;
	end;
	if l__CurrentCamera__1:FindFirstChild("Bottom") then
		l__CurrentCamera__1:FindFirstChild("Bottom"):Destroy();
		if character:FindFirstChild("Outfit") and character:FindFirstChild("Outfit"):FindFirstChild("Bottom") then
			character:FindFirstChild("Outfit"):FindFirstChild("Bottom"):Clone().Parent = l__workspace__1.Camera;
		end;
	end;
	if playerstats.Settings.AltSkin == true then
		for v1021, v1022 in ipairs(fparms:GetDescendants()) do
			if v1022:IsA("BasePart") and v1022.BrickColor == BrickColor.new("Pastel brown") then
				v1022.BrickColor = BrickColor.new("Dark taupe");
			end;
		end;
	end;
end;
if playerstats.Class == "damn" then
	local v1023 = l__game__7.ReplicatedStorage.misc.fpcuffs:Clone();
	v1023.cuffA.CFrame = fparms.LeftArm.LUpperArm.CFrame;
	local v1024 = Instance.new("Weld");
	v1024.Part0 = v1023.cuffA;
	v1024.Part1 = fparms.LeftArm.LUpperArm;
	v1024.C0 = CFrame.new(-85.2399902, -5.52000141, -0.500001013, 1, 0, 0, 0, 0, -1, 0, 1, 0);
	v1024.C1 = CFrame.new(-85.2399902, -5.14707661, -0.500001013, 1, 0, 0, 0, 0, -1, 0, 1, 0) * CFrame.new(0, 0, 0.6);
	v1024.Parent = v1023.cuffA;
	v1023.cuffB.CFrame = fparms.RightArm.RUpperArm.CFrame;
	local v1025 = Instance.new("Weld");
	v1025.Part0 = v1023.cuffB;
	v1025.Part1 = fparms.RightArm.RUpperArm;
	v1025.C0 = CFrame.new(-82.3999939, -5.52000141, -0.500001013, 1, 0, 0, 0, 0, -1, 0, 1, 0);
	v1025.C1 = CFrame.new(-82.3999939, -5.14707661, -0.500001013, 1, 0, 0, 0, 0, -1, 0, 1, 0) * CFrame.new(0, 0, 0.6);
	v1025.Parent = v1023.cuffB;
	v1023.Parent = fparms;
	spawn(function()
		local l__cuffs__1026 = character:WaitForChild("cuffs");
		if l__cuffs__1026 then
			l__cuffs__1026.beam.Enabled = false;
		end;
	end);
end;
function kickoutspec()
	v101({ "general" }, "keyboard", nil, nil, true, true);
	local v1027 = l__game__7.ReplicatedStorage.misc.staticflash:Clone();
	v1027.static.Disabled = false;
	v1027.Parent = ply.PlayerGui;
	u9.turnable = true;
	u9.action = false;
	u9.staggering = false;
	spectating = false;
	if ply.PlayerGui:FindFirstChild("endgamegui") then
		ply.PlayerGui:FindFirstChild("endgamegui"):Destroy();
	end;
	l__CurrentCamera__1.CameraSubject = ply.Character.Humanoid;
	l__CurrentCamera__1.CameraType = "Custom";
	u11 = u13;
	forcespecfolder = false;
	character.HumanoidRootPart.Anchored = false;
	ply.CameraMode = "LockFirstPerson";
	UIS.MouseIconEnabled = false;
	maingui.Enabled = true;
end;
local v1028 = tick();
local v1029 = tick();
l__workspace__1.ServerStuff.playerMatsHandler.OnClientEvent:Connect(function(p114, p115)
	if p114 ~= "ammo" then
		if p114 == "scrap" then
			l__workspace__1.ServerStuff.playAudio:FireServer({ "world_item" }, "scrap_pickup", character.HumanoidRootPart, 0.1);
			u38(p115[2], p115[1]);
			return;
		else
			if p114 == "rations" then
				l__workspace__1.ServerStuff.playAudio:FireServer({ "world_item" }, "ration_pickup", character.HumanoidRootPart, 0.1);
				ration_system_handler[p115[1]] = ration_system_handler[p115[1]] + 1;
			end;
			return;
		end;
	end;
	local v1030 = v43;
	if p115[3] ~= nil then
		v1030 = 0;
	elseif v60[3].ammo_cd_pickup ~= nil and tick() - u111 < v60[3].cooldown then
		u111 = u111 - v60[3].ammo_cd_pickup;
	end;
	if u64[string.sub(p115[1], 1, -6)] then
		u64[string.sub(p115[1], 1, -6)] = u64[string.sub(p115[1], 1, -6)] + p115[2] + math.ceil(p115[2] * v1030);
	end;
	l__workspace__1.ServerStuff.playAudio:FireServer({ "firearms" }, "ammo_pickup", character.HumanoidRootPart, 0.1);
	invmanage("updatehud");
end);
local function v1031()
	v101({ "AGENT" }, "menu", nil, nil, true, true);
	local v1032 = maingui.TabMenu.bg.bg:Clone();
	v1032.Parent = maingui.TabMenu.bg;
	spawn(function()
		while true do
			v1032.ImageTransparency = v1032.ImageTransparency + 0.05;
			RS:wait();
			if v1032.ImageTransparency >= 1 then
				break;
			end;		
		end;
		v1032:Destroy();
	end);
end;
scrap_drop_amount = 5;
scrap_tick = tick();
function handle_scrap_drop(p116)
	scrap_drop_amount = scrap_drop_amount + p116;
	scrap_drop_amount = math.clamp(scrap_drop_amount, 0, u16);
end;
for v1033, v1034 in ipairs(maingui.TabMenu.bg.scraptab:GetChildren()) do
	if v1034:IsA("TextButton") then
		local u114 = v1029;
		v1034.MouseButton1Click:connect(function()
			v1031();
			if v1034.Name == "lessbutton" then
				handle_scrap_drop(-5);
			elseif v1034.Name == "majorlessbutton" then
				handle_scrap_drop(-25);
			elseif v1034.Name == "morebutton" then
				handle_scrap_drop(5);
			elseif v1034.Name == "majormorebutton" then
				handle_scrap_drop(25);
			end;
			if v1034.Name == "dropbutton" and u16 > 0 and tick() - scrap_tick >= 0.5 and scrap_drop_amount ~= 0 then
				u114 = tick();
				scrap_tick = tick();
				l__workspace__1.ServerStuff.dropAmmo:FireServer("scrap", scrap_drop_amount);
				u38(-scrap_drop_amount, "SCRAP DROPPED");
				handle_scrap_drop(0);
			end;
		end);
	end;
end;
for v1035, v1036 in ipairs(maingui.TabMenu.bg.ammodroptab:GetChildren()) do
	if u64[v1036.Name] then
		local u115 = v1029;
		v1036.dropbutton.MouseButton1Click:connect(function()
			if tick() - u115 >= 0.2 then
				u115 = tick();
				v1031();
				v480(v1036.Name);
			end;
		end);
	end;
end;
for v1037, v1038 in ipairs(maingui.TabMenu.bg.rationstab:GetChildren()) do
	if ration_system_handler[v1038.Name] then
		local u116 = v1029;
		v1038.eat.MouseButton1Click:connect(function()
			if tick() - u116 >= 0.2 then
				u116 = tick();
				v1031();
				if ration_system_handler[v1038.Name] > 0 then
					local v1039 = false;
					local v1040 = ration_system_handler.cooldown_eat_tick;
					if v1038.Name == "Bottle" or v1038.Name == "Soda" then
						v1039 = true;
						v1040 = ration_system_handler.cooldown_drink_tick;
					end;
					if ration_system_handler.cooldown_rations < tick() - v1040 then
						if u17.weapontype == "Fists" then
							consume_rations(v1038.Name);
							return;
						else
							maingui.Thought.thoughttext.Text = "My hands are full right now.";
							inner_dialogue = tick();
							return;
						end;
					end;
					if v1039 == true then
						maingui.Thought.thoughttext.Text = "I can't drink any more right now.";
					else
						maingui.Thought.thoughttext.Text = "I can't eat any more right now.";
					end;
					inner_dialogue = tick();
				end;
			end;
		end);
		v1038.drop.MouseButton1Click:connect(function()
			if tick() - u116 >= 0.2 then
				u116 = tick();
				v1031();
				if tick() - u75 <= 0.3 then
					return;
				end;
				u75 = tick();
				if ration_system_handler[v1038.Name] > 0 then
					ration_system_handler[v1038.Name] = ration_system_handler[v1038.Name] - 1;
					l__workspace__1.ServerStuff.dropAmmo:FireServer("rations", v1038.Name);
				end;
			end;
		end);
	end;
end;
tabmenu_options = { maingui.TabMenu.bg.ammodrop, maingui.TabMenu.bg.scrap, maingui.TabMenu.bg.weaponinfo, maingui.TabMenu.bg.rations };
for v1041, v1042 in ipairs(tabmenu_options) do
	if maingui.TabMenu.bg:FindFirstChild(v1042.Name .. "tab") then
		v1042.MouseButton1Click:connect(function()
			v1031();
			for v1043, v1044 in ipairs(tabmenu_options) do
				if maingui.TabMenu.bg:FindFirstChild(v1044.Name .. "tab") then
					maingui.TabMenu.bg:FindFirstChild(v1044.Name .. "tab").Visible = false;
					v1044.BackgroundTransparency = 0.7;
				end;
			end;
			maingui.TabMenu.bg:FindFirstChild(v1042.Name .. "tab").Visible = true;
			v1042.BackgroundTransparency = 0.3;
		end);
	end;
end;
reset_arms_timer = 0;
local u117 = v112;
local u118 = v111;
function reset_arms()
	if tick() - reset_arms_timer <= 5 then
		return;
	end;
	if u9.using_perk == true then
		return;
	end;
	if u9.throwing == true then
		return;
	end;
	if u9.eating == true then
		return;
	end;
	if u9.poking == true then
		return;
	end;
	if u9.startswap == false then
		if u9.action == false then
			if u9.channel == false then
				if u9.staggering == false then
					if u9.shoving == false then
						if u9.cancombo == false then
							return;
						end;
					end;
				end;
			end;
		end;
	end;
	if u10.Snared then
		return;
	end;
	ply.PlayerGui.fadetoblack.frame.BackgroundTransparency = 1;
	reset_arms_timer = tick();
	u9.action = true;
	u9.sprinting = false;
	u9.channel = true;
	u9.staggering = true;
	u9.cancombo = false;
	u9.firing = true;
	u9.poking = true;
	u9.shoving = true;
	u9.startswap = true;
	u9.turnable = false;
	l__CurrentCamera__1.CameraType = "Scriptable";
	l__CurrentCamera__1.CameraSubject = nil;
	l__CurrentCamera__1.CFrame = CFrame.new(0, 0, 0);
	ply.CameraMode = "Classic";
	RS:wait();
	l__CurrentCamera__1.CameraType = "Custom";
	l__CurrentCamera__1.CameraSubject = hum;
	l__CurrentCamera__1.CFrame = CFrame.new(character.HumanoidRootPart.Position + u31) * CFrame.Angles(0, 0, 0) * CFrame.Angles(0, 0, 0) * u117;
	l__CurrentCamera__1.CameraType = "Custom";
	l__CurrentCamera__1.CameraSubject = hum;
	ply.CameraMode = "LockFirstPerson";
	cpart.CFrame = l__CurrentCamera__1.CFrame;
	camroot.CFrame = cpart.CFrame * CFrame.new(0, -1, 0.3) * CFrame.Angles(math.rad(-90), 0, math.rad(180)) * u118 * u90;
	spawn(function()
		local v1045 = 1 - 1;
		while true do
			l__CurrentCamera__1.CFrame = CFrame.new(character.HumanoidRootPart.Position + u31) * CFrame.Angles(0, 0, 0) * CFrame.Angles(0, 0, 0) * u117;
			camroot.CFrame = cpart.CFrame * CFrame.new(0, -1, 0.3) * CFrame.Angles(math.rad(-90), 0, math.rad(180)) * u118 * u90;
			l__CurrentCamera__1.CameraSubject = ply.Character.Humanoid;
			l__CurrentCamera__1.CameraType = "Custom";
			character.HumanoidRootPart.Anchored = false;
			ply.CameraMode = "LockFirstPerson";
			RS:wait();
			if 0 <= 1 then
				if v1045 < 10 then

				else
					break;
				end;
			elseif 10 < v1045 then

			else
				break;
			end;
			v1045 = v1045 + 1;		
		end;
	end);
	local v1046, v1047, v1048 = ipairs(maingui:GetChildren());
	while true do
		local v1049, v1050 = v1046(v1047, v1048);
		if v1049 then

		else
			break;
		end;
		v1048 = v1049;
		if v1050.Name == "snare" then
			v1050:Destroy();
		end;	
	end;
	u9.turnable = true;
	u9.startswap = false;
	u9.action = false;
	u9.sprinting = false;
	u9.channel = false;
	u9.staggering = false;
	u9.cancombo = false;
	u9.firing = false;
	u9.poking = false;
	u9.shoving = false;
	u61("Fist");
end;
function big_poke()
	l__workspace__1.ServerStuff.handlePerkVisibility:FireServer("switchB");
	v101({ "weapons", "1HBL" }, "draw", nil, nil, true, true);
	spawn(function()
		while true do
			if RS:wait() then

			else
				break;
			end;
			local v1051, v1052, v1053 = pairs(globalanimsets);
			while true do
				local v1054, v1055 = v1051(v1052, v1053);
				if v1054 then

				else
					break;
				end;
				v1053 = v1054;
				if v1054 ~= "self_poke" then
					v1055:Stop(0);
				end;			
			end;
			local v1056, v1057, v1058 = pairs(tpglobalanimsets);
			while true do
				local v1059, v1060 = v1056(v1057, v1058);
				if v1059 then

				else
					break;
				end;
				v1058 = v1059;
				if v1059 ~= "pokey" then
					v1060:Stop(0);
				end;			
			end;		
		end;
	end);
	if u19 then
		u19:Destroy();
	end;
	local v1061 = l__game__7.ReplicatedStorage.misc.SwitchB:Clone();
	local v1062 = Instance.new("Motor6D");
	v1062.Name = "WeaponJoint";
	v1062.Part0 = fparms.RightArm.RUpperArm;
	v1062.Part1 = v1061.JointGrip;
	v1062.C0 = CFrame.new(0, -1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1);
	v1062.C1 = l__game__7.ReplicatedStorage.animationSets["1HBL"].weldval.Value;
	v1062.Parent = fparms.Joints;
	v1061.Parent = fparms;
	globalanimsets.self_poke:Play(0.1, 1, 0.6);
	tpglobalanimsets.pokey:Play(0.1, 1, 0.6);
	delay(1.775, function()
		if hum.Health < 0 then
			return;
		end;
		l__workspace__1.ServerStuff.callEvent:FireServer("poke");
	end);
end;
function decider_reset()
	if u9.poking == true then
		return;
	end;
	if spectating == true then
		return;
	end;
	if character then
		if character:FindFirstChild("HumanoidRootPart") then
			character:FindFirstChild("HumanoidRootPart").Anchored = true;
		end;
	end;
	remove_dual_wield();
	reset_arms_timer = tick();
	l__game__7:GetService("StarterGui"):SetCore("ResetButtonCallback", false);
	u9.action = true;
	u9.sprinting = false;
	u9.channel = true;
	u9.turnable = false;
	u9.staggering = true;
	u9.cancombo = false;
	u9.canjump = false;
	u9.firing = true;
	u9.poking = true;
	u9.shoving = true;
	RS:wait();
	local v1063 = true;
	local v1064 = false;
	if u17.animset ~= "SMG" then
		if u17.animset ~= "ASMG" then
			if u17.animset ~= "RFL" then
				if u17.animset ~= "2HPST" then
					if u17.animset ~= "PST" then
						if u17.animset ~= "DBB" then
							if u17.animset == "RV" then
								local v1065 = 0;
								local v1066, v1067, v1068 = pairs(v6);
								while true do
									local v1069, v1070 = v1066(v1067, v1068);
									if v1069 then

									else
										break;
									end;
									v1068 = v1069;
									if v1070[2] == true then
										if v1070[3] ~= nil then
											v1065 = v1070[3];
										end;
									end;								
								end;
								if 0 < v1065 then
									if u17.animset ~= "DBB" then
										if u17.animset ~= "RV" then
											if u17.animset ~= "2HPST" then
												if u17.animset == "PST" then
													v1064 = true;
												end;
											else
												v1064 = true;
											end;
										else
											v1064 = true;
										end;
									else
										v1064 = true;
									end;
									v1063 = false;
								end;
							end;
						else
							v1065 = 0;
							v1066, v1067, v1068 = pairs(v6);
							while true do
								v1069, v1070 = v1066(v1067, v1068);
								if v1069 then

								else
									break;
								end;
								v1068 = v1069;
								if v1070[2] == true then
									if v1070[3] ~= nil then
										v1065 = v1070[3];
									end;
								end;							
							end;
							if 0 < v1065 then
								if u17.animset ~= "DBB" then
									if u17.animset ~= "RV" then
										if u17.animset ~= "2HPST" then
											if u17.animset == "PST" then
												v1064 = true;
											end;
										else
											v1064 = true;
										end;
									else
										v1064 = true;
									end;
								else
									v1064 = true;
								end;
								v1063 = false;
							end;
						end;
					else
						v1065 = 0;
						v1066, v1067, v1068 = pairs(v6);
						while true do
							v1069, v1070 = v1066(v1067, v1068);
							if v1069 then

							else
								break;
							end;
							v1068 = v1069;
							if v1070[2] == true then
								if v1070[3] ~= nil then
									v1065 = v1070[3];
								end;
							end;						
						end;
						if 0 < v1065 then
							if u17.animset ~= "DBB" then
								if u17.animset ~= "RV" then
									if u17.animset ~= "2HPST" then
										if u17.animset == "PST" then
											v1064 = true;
										end;
									else
										v1064 = true;
									end;
								else
									v1064 = true;
								end;
							else
								v1064 = true;
							end;
							v1063 = false;
						end;
					end;
				else
					v1065 = 0;
					v1066, v1067, v1068 = pairs(v6);
					while true do
						v1069, v1070 = v1066(v1067, v1068);
						if v1069 then

						else
							break;
						end;
						v1068 = v1069;
						if v1070[2] == true then
							if v1070[3] ~= nil then
								v1065 = v1070[3];
							end;
						end;					
					end;
					if 0 < v1065 then
						if u17.animset ~= "DBB" then
							if u17.animset ~= "RV" then
								if u17.animset ~= "2HPST" then
									if u17.animset == "PST" then
										v1064 = true;
									end;
								else
									v1064 = true;
								end;
							else
								v1064 = true;
							end;
						else
							v1064 = true;
						end;
						v1063 = false;
					end;
				end;
			else
				v1065 = 0;
				v1066, v1067, v1068 = pairs(v6);
				while true do
					v1069, v1070 = v1066(v1067, v1068);
					if v1069 then

					else
						break;
					end;
					v1068 = v1069;
					if v1070[2] == true then
						if v1070[3] ~= nil then
							v1065 = v1070[3];
						end;
					end;				
				end;
				if 0 < v1065 then
					if u17.animset ~= "DBB" then
						if u17.animset ~= "RV" then
							if u17.animset ~= "2HPST" then
								if u17.animset == "PST" then
									v1064 = true;
								end;
							else
								v1064 = true;
							end;
						else
							v1064 = true;
						end;
					else
						v1064 = true;
					end;
					v1063 = false;
				end;
			end;
		else
			v1065 = 0;
			v1066, v1067, v1068 = pairs(v6);
			while true do
				v1069, v1070 = v1066(v1067, v1068);
				if v1069 then

				else
					break;
				end;
				v1068 = v1069;
				if v1070[2] == true then
					if v1070[3] ~= nil then
						v1065 = v1070[3];
					end;
				end;			
			end;
			if 0 < v1065 then
				if u17.animset ~= "DBB" then
					if u17.animset ~= "RV" then
						if u17.animset ~= "2HPST" then
							if u17.animset == "PST" then
								v1064 = true;
							end;
						else
							v1064 = true;
						end;
					else
						v1064 = true;
					end;
				else
					v1064 = true;
				end;
				v1063 = false;
			end;
		end;
	else
		v1065 = 0;
		v1066, v1067, v1068 = pairs(v6);
		while true do
			v1069, v1070 = v1066(v1067, v1068);
			if v1069 then

			else
				break;
			end;
			v1068 = v1069;
			if v1070[2] == true then
				if v1070[3] ~= nil then
					v1065 = v1070[3];
				end;
			end;		
		end;
		if 0 < v1065 then
			if u17.animset ~= "DBB" then
				if u17.animset ~= "RV" then
					if u17.animset ~= "2HPST" then
						if u17.animset == "PST" then
							v1064 = true;
						end;
					else
						v1064 = true;
					end;
				else
					v1064 = true;
				end;
			else
				v1064 = true;
			end;
			v1063 = false;
		end;
	end;
	if v1063 == true then
		big_poke();
		return;
	end;
	v101({ "firearms" }, "ads_in", nil, nil, true, true);
	curentanimset.lower:Play(0.1, 1, 0.5);
	local u119 = nil;
	u119 = curentanimset.lower.KeyframeReached:connect(function(p117)
		if p117 == "Stop" then
			curentanimset.lower:AdjustSpeed(0);
			u119:Disconnect();
		end;
	end);
	local v1071 = tpglobalanimsets.influence_gun;
	if v1064 == true then
		v1071 = tpglobalanimsets.influence_pistol;
	end;
	v1071:Play(0.3, 1, 0.8);
	local u120 = nil;
	u120 = v1071.KeyframeReached:connect(function(p118)
		if p118 == "Stop" then
			v1071:AdjustSpeed(0);
			u120:Disconnect();
		end;
	end);
	local v1072 = tick();
	while true do
		RS:wait();
		if not (1.5 <= tick() - v1072) then

		else
			break;
		end;	
	end;
	if hum.Health < 0 then
		return;
	end;
	if curentanimset.lower then
		curentanimset.lower:Stop(0);
	end;
	v1071:Stop(0);
	local v1073, v1074, v1075 = pairs(v6);
	while true do
		local v1076, v1077 = v1073(v1074, v1075);
		if v1076 then

		else
			break;
		end;
		v1075 = v1076;
		if v1077[2] == true then
			if v1077[3] ~= nil then
				v1077[3] = v1077[3] - 1;
			end;
		end;	
	end;
	local l__Position__1078 = u19.muzzle.Position;
	l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", u17.animset }, u17.name, character.HumanoidRootPart, 0.05);
	if u17.animset ~= "LSMG" then
		if u17.name == "A.J.M. 9" then
			l__workspace__1.ServerStuff.applyGore:FireServer("firelaser", character, ply, { l__Position__1078, l__Position__1078 });
		else
			l__workspace__1.ServerStuff.applyGore:FireServer("firegun", character, ply, { l__Position__1078, l__Position__1078 });
		end;
	else
		l__workspace__1.ServerStuff.applyGore:FireServer("firelaser", character, ply, { l__Position__1078, l__Position__1078 });
	end;
	l__workspace__1.ServerStuff.playAudio:FireServer({ "firearms" }, "bass", character.HumanoidRootPart, 0.1);
	l__workspace__1.ServerStuff.callEvent:FireServer("self_gun");
end;
influence_taps = 0;
function start_influence()
	if u9.staggering == true then
		return;
	end;
	l__workspace__1.ServerStuff.handlePerkVisibility:FireServer("switchB");
	u22 = u22 - 14;
	u9.action = true;
	u9.channel = true;
	u9.staggering = true;
	u9.turnable = false;
	v101({ "shadow", "hang" }, "cast", nil, nil, true, true);
	local v1079 = "self_knife";
	local v1080 = false;
	if u17.weapontype == "Gun" then
		local v1081 = 0;
		local v1082, v1083, v1084 = pairs(v6);
		while true do
			local v1085, v1086 = v1082(v1083, v1084);
			if v1085 then

			else
				break;
			end;
			v1084 = v1085;
			if v1086[2] == true then
				if v1086[3] ~= nil then
					v1081 = v1086[3];
				end;
			end;		
		end;
		if 0 < v1081 then
			if u17.animset ~= "ASMG" then
				if u17.animset == "RFL" then
					v1079 = "self_gun";
				end;
			else
				v1079 = "self_gun";
			end;
			if u17.animset ~= "DBB" then
				if u17.animset ~= "RV" then
					if u17.animset ~= "2HPST" then
						if u17.animset == "PST" then
							v1079 = "self_gun";
							v1080 = true;
						end;
					else
						v1079 = "self_gun";
						v1080 = true;
					end;
				else
					v1079 = "self_gun";
					v1080 = true;
				end;
			else
				v1079 = "self_gun";
				v1080 = true;
			end;
			if v1079 == "self_gun" then
				curentanimset.lower:Play(0.1, 1, 0.4);
				local u121 = nil;
				u121 = curentanimset.lower.KeyframeReached:connect(function(p119)
					if p119 == "Stop" then
						curentanimset.lower:AdjustSpeed(0);
						u121:Disconnect();
					end;
				end);
			end;
		end;
	end;
	local v1087 = nil;
	if v1079 == "self_knife" then
		v1087 = l__game__7.ReplicatedStorage.misc.SwitchB:Clone();
		local v1088 = Instance.new("Motor6D");
		v1088.Name = "WeaponJoint";
		v1088.Part0 = fparms.LeftArm.LUpperArm;
		v1088.Part1 = v1087.JointGrip;
		v1088.C0 = CFrame.new(0, -1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1);
		v1088.C1 = l__game__7.ReplicatedStorage.animationSets["1HBL"].weldval.Value;
		v1088.Parent = fparms.Joints;
		v1087.Parent = fparms;
		globalanimsets.influence_knife:Play(0.1, 1, 0.4);
		local u122 = nil;
		u122 = globalanimsets.influence_knife.KeyframeReached:connect(function(p120)
			if p120 == "Stop" then
				globalanimsets.influence_knife:AdjustSpeed(0);
				u122:Disconnect();
			end;
		end);
	end;
	spawn(function()
		local v1089 = Instance.new("Frame");
		v1089.BackgroundColor3 = Color3.new(0, 0, 0);
		v1089.BackgroundTransparency = 0;
		v1089.Size = UDim2.new(1, 0, 1, 0);
		v1089.ZIndex = 10;
		v1089.Parent = maingui;
		while true do
			v1089.BackgroundTransparency = v1089.BackgroundTransparency + 0.03;
			RS:wait();
			if not (1 <= v1089.BackgroundTransparency) then

			else
				break;
			end;		
		end;
		v1089:Destroy();
	end);
	local v1090 = Instance.new("Frame");
	v1090.BackgroundColor3 = Color3.new(0, 0, 0);
	v1090.BackgroundTransparency = 0.3;
	v1090.Size = UDim2.new(1, 0, 1, 0);
	v1090.ZIndex = 10;
	v1090.Parent = maingui;
	influence_taps = 1;
	local v1091 = l__game__7.ReplicatedStorage.misc.warningtext:Clone();
	v1091.Text = "> E <\nRESIST THE INFLUENCE";
	v1091.Parent = maingui;
	local v1092 = tpglobalanimsets.influence_gun;
	if v1080 == true then
		v1092 = tpglobalanimsets.influence_pistol;
	end;
	if v1079 == "self_knife" then
		v1092 = tpglobalanimsets.influence_knife;
	end;
	v1092:Play(0.3, 1, 0.8);
	local u123 = nil;
	u123 = v1092.KeyframeReached:connect(function(p121)
		if p121 == "Stop" then
			v1092:AdjustSpeed(0);
			u123:Disconnect();
		end;
	end);
	local v1093 = tick();
	local v1094 = tick();
	local v1095 = 0;
	while true do
		if 1 <= tick() - v1095 then
			v1095 = tick();
			applygore("hangerPopup", character.Torso, nil);
		end;
		if 0.3 <= tick() - v1093 then
			v1093 = tick();
			if v1091.Text == "> E <\nRESIST THE INFLUENCE" then
				v1091.Text = "E\nRESIST THE INFLUENCE";
			else
				v1091.Text = "> E <\nRESIST THE INFLUENCE";
			end;
		end;
		v1091.Position = UDim2.new(0.5, math.random(-8, 8), 0.6, math.random(-8, 8));
		RS:wait();
		if not (3.8 <= tick() - v1094) then

		else
			break;
		end;	
	end;
	if v1087 then
		globalanimsets.influence_knife:Stop(0);
		v1087:Destroy();
	end;
	if curentanimset.lower then
		curentanimset.lower:Stop(0);
	end;
	v1092:Stop(0);
	v1091:Destroy();
	v1090:Destroy();
	if influence_taps < 18 then

	else
		u22 = u22 + 14;
		local v1096 = Instance.new("Frame");
		v1096.BackgroundColor3 = Color3.new(1, 1, 1);
		v1096.BackgroundTransparency = 0;
		v1096.Size = UDim2.new(1, 0, 1, 0);
		v1096.ZIndex = 10;
		v1096.Parent = maingui;
		spawn(function()
			while true do
				v1096.BackgroundTransparency = v1096.BackgroundTransparency + 0.02;
				RS:wait();
				if not (1 <= v1096.BackgroundTransparency) then

				else
					break;
				end;			
			end;
			v1096:Destroy();
		end);
		l__workspace__1.ServerStuff.handlePerkVisibility:FireServer("hide_perk");
		influence_taps = 0;
		u9.action = false;
		u9.channel = false;
		u9.staggering = false;
		u9.turnable = true;
		return;
	end;
	if v1079 == "self_gun" then
		local v1097, v1098, v1099 = pairs(v6);
		while true do
			local v1100, v1101 = v1097(v1098, v1099);
			if v1100 then

			else
				break;
			end;
			v1099 = v1100;
			if v1101[2] == true then
				if v1101[3] ~= nil then
					v1101[3] = v1101[3] - 1;
				end;
			end;		
		end;
		local l__Position__1102 = u19.muzzle.Position;
		l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", u17.animset }, u17.name, character.HumanoidRootPart, 0.05);
		if u17.animset ~= "LSMG" then
			if u17.name == "A.J.M. 9" then
				l__workspace__1.ServerStuff.applyGore:FireServer("firelaser", character, ply, { l__Position__1102, l__Position__1102 });
			else
				l__workspace__1.ServerStuff.applyGore:FireServer("firegun", character, ply, { l__Position__1102, l__Position__1102 });
			end;
		else
			l__workspace__1.ServerStuff.applyGore:FireServer("firelaser", character, ply, { l__Position__1102, l__Position__1102 });
		end;
		l__workspace__1.ServerStuff.playAudio:FireServer({ "firearms" }, "bass", character.HumanoidRootPart, 0.1);
	end;
	l__workspace__1.ServerStuff.callEvent:FireServer(v1079);
end;
commendedplayer = {};
commendedcount = 2;
commendedtick = tick();
function commend_player()
	if not (tick() - commendedtick <= 1) then
		if commendedcount <= 0 then
			return;
		end;
	else
		return;
	end;
	local v1103 = raycastline(l__CurrentCamera__1.CFrame.p, l__CurrentCamera__1.CFrame.LookVector, 50, { l__workspace__1.NoTarget, l__workspace__1.PlayerShootThroughs, character });
	if v1103 then
		if v1103.Parent:FindFirstChild("Humanoid") then
			local v1104 = l__game__7.Players:GetPlayerFromCharacter(v1103.Parent);
			if v1104 then
				if commendedplayer[v1104.Name] == nil then
					commendedtick = tick();
					commendedplayer[v1104.Name] = true;
					commendedcount = commendedcount - 1;
					l__workspace__1.ServerStuff.callEvent:FireServer("commend", v1104.Name);
				end;
			end;
		end;
	end;
end;
resetBindable = Instance.new("BindableEvent");
resetBindable.Event:connect(decider_reset);
l__game__7:GetService("StarterGui"):SetCore("ResetButtonCallback", resetBindable);
e_pickup_lockout = tick();
local function u124()
	for v1105, v1106 in pairs(v6) do
		if v1106[2] == true and v1106[3] <= 0 then
			return;
		end;
	end;
	for v1107, v1108 in ipairs(u19.arrow:GetChildren()) do
		if v1108:IsA("BasePart") then
			v1108.Transparency = 0;
		end;
	end;
	u9.action = true;
	curentanimset.arrow:Play(0.1);
	l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", u17.animset }, "reload", character.HumanoidRootPart);
	for v1109 = 1, 15 do
		RS:wait();
		if u9.staggering == true then
			break;
		end;
		if u17.weapontype ~= "Bow" then
			break;
		end;
	end;
	if u17.weapontype == "Bow" then
		curentanimset.equip.TimePosition = 0.5;
		curentanimset.equip:AdjustSpeed(0);
		tpcurrentanimset.equip:Play();
		tpcurrentanimset.equip.TimePosition = 0.5;
		tpcurrentanimset.equip:AdjustSpeed(0);
		check_walking_anim();
	end;
	if u9.staggering == false then
		u9.firing = false;
		u9.action = false;
	end;
end;
local function u125()
	if ping_chill_timer < tick() - ping_chill then
		ping_chill = tick();
		ping_amt = 0;
	end;
	ping_cooldown = tick();
	ping_amt = ping_amt + 1;
	local v1110, v1111 = raycastline(l__CurrentCamera__1.CFrame.p, l__CurrentCamera__1.CFrame.LookVector, 200, baselayer);
	local v1112 = 1;
	local v1113 = nil;
	if v1110 and v1110.Parent:FindFirstChild("Humanoid") and v1110.Parent:FindFirstChild("Humanoid").Health > 0 and v1110.Parent:FindFirstChild("HumanoidRootPart") and v1110.Parent:IsDescendantOf(l__workspace__1.activeHostiles) then
		v1111 = v1110.Parent:FindFirstChild("HumanoidRootPart").Position;
		v1112 = 2;
	end;
	if v1110 and v1110.Name == "JointGrip" then
		if v18[v1110.Parent.Name] then
			v1113 = v18[v1110.Parent.Name].name;
		end;
		v1111 = v1110.Position;
		v1112 = 3;
	end;
	if v1110 and v1110.Name == "Interact" and v1110.Parent:IsDescendantOf(l__workspace__1.Interactables) then
		v1113 = v1110.Parent.Name;
		v1111 = v1110.Position;
		v1112 = 4;
	end;
	if v1110 and (v1110.Name == "HarvestWood" or v1110.Name == "HarvestStone") and v1110.Parent:IsDescendantOf(l__workspace__1.Interactables) then
		v1113 = "Wood Pile";
		if v1110.Name == "HarvestStone" then
			v1113 = "Stone Pile";
		end;
		v1111 = v1110.Position;
		v1112 = 5;
	end;
	l__workspace__1.ServerStuff.applyGore:FireServer("player_ping", character, ply, { v1111, ply.Name, v1112, v1113 });
end;
local u126 = false;
local function u127()
	if can_player_sprint == false then
		return;
	end;
	if u30.w ~= false and u9.air ~= true and u9.channel ~= true and u9.sprinting ~= true then
		if u10.Cripple and u10.Painkillers == nil and v59.berzactive == nil then
			return;
		elseif tick() - sprint_lockout <= 0.2 then
			return;
		else
			u9.sprinting = false;
			RS:wait();
			sprint_lockout = tick();
			u9.sprinting = true;
			u9.sneaking = false;
			local v1114 = u11 * 1;
			u22 = u22 + v1114;
			if playerperks.stealth == nil and character:FindFirstChild("Head") and character.Head:FindFirstChild("Running") then
				character.Head.Running:Play();
			end;
			slide_wait = tick() - 0.5;
			l__workspace__1.ServerStuff.movementAdjust:FireServer("sprint", true, v1114 / 8);
			local v1115 = 0;
			while true do
				if character:FindFirstChild("Head") and character.Head:FindFirstChild("Running") then
					character.Head.Running.Volume = 1;
				end;
				if u9.action == false and u9.aiming == false and u9.swapping == false then
					gun_holster_timer = 0;
				end;
				RS:wait();
				u25(nil);
				if tick() - v1115 > 0.125 then
					v1115 = tick();
					if sprint_stam > 0 and u10["Speed Buff"] == nil then
						sprint_stam = sprint_stam - 1;
					end;
					u26("stamina");
				end;
				if sprint_stam <= 0 then
					afflictstatus(require(l__game__7.Workspace.ServerStuff.Statistics.S_STATISTICS).Exha);
				end;
				if u10.Cripple and u10.Painkillers == nil and v59.berzactive == nil then
					break;
				end;
				if u9.sprinting == false then
					break;
				end;
				if u9.walking == false then
					break;
				end;
				if u30.w == false then
					break;
				end;
				if u9.air == true then
					break;
				end;
				if u9.staggering == true then
					break;
				end;
				if u9.channel == true then
					break;
				end;			
			end;
			l__workspace__1.ServerStuff.movementAdjust:FireServer("sprint", false);
			if character:FindFirstChild("Head") and character.Head:FindFirstChild("Running") then
				character.Head.Running:Stop();
			end;
			u9.sprinting = false;
			u22 = u22 - v1114;
			return;
		end;
	end;
end;
local function u128()
	if (u9.action ~= true or u9.swapping ~= false) and u9.channel ~= true and u9.air ~= false then
		local v1116 = { "N", "N", "N" };
		local v1117, v1118 = raycastline(character.HumanoidRootPart.CFrame.p, character.HumanoidRootPart.CFrame.lookVector, 2, baselayer);
		if v1117 and not v1117.Parent:FindFirstChild("Humanoid") then
			v1116[1] = "Y";
		end;
		local v1119, v1120 = raycastline((character.HumanoidRootPart.CFrame + Vector3.new(0, 2.5, 0)).p, character.HumanoidRootPart.CFrame.lookVector, 2, baselayer);
		if not v1119 then
			v1116[2] = "Y";
		end;
		local v1121, v1122 = raycastline((character.HumanoidRootPart.CFrame + Vector3.new(0, 6, 0)).p, character.HumanoidRootPart.CFrame.lookVector, 2, baselayer);
		if not v1121 then
			v1116[3] = "Y";
		end;
		if table.concat(v1116) == "YYY" then
			l__workspace__1.ServerStuff.adjustStats:FireServer("tracker", { "Mantles", 1 });
			u9.canjump = false;
			shakecamera("climb");
			globalanimsets.climb:Play(0.1, 1, 1);
			tpglobalanimsets.climb:Play(0.1, 1, 1);
			l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "mantle", character.HumanoidRootPart);
			u9.action = true;
			local v1123 = Instance.new("BodyPosition");
			v1123.Name = "parkourPositionThing";
			v1123.MaxForce = Vector3.new(200000, 200000, 200000);
			v1123.P = 2000;
			v1123.D = 500;
			v1123.Position = character.HumanoidRootPart.Position + Vector3.new(0, 5, 0) + character.HumanoidRootPart.CFrame.lookVector * 5;
			v1123.Parent = character.HumanoidRootPart;
			u8 = u8 + 40;
			u26("stamina");
			delay(0.4, function()
				v1123:Destroy();
				u9.canjump = true;
				u9.action = false;
				u14.jumptick = 0;
			end);
		end;
		return;
	end;
end;
local u129 = false;
local function u130(p122)
	return string.format("%02i:%02i", p122 / 60 % 60, p122 % 60);
end;
local function u131()
	local l__ammo__1124 = l__game__7.ReplicatedStorage.Weapons:FindFirstChild(u19.Name):FindFirstChild("ammo");
	if l__ammo__1124 ~= nil and u9.action ~= true and u17.ammoused ~= nil and not (tick() - reload_locklout <= 2) then
		local l__Value__1125 = l__ammo__1124.Value;
		local v1126 = false;
		if u64[u17.ammoused] == nil or u64[u17.ammoused] <= 0 then
			v1126 = true;
		end;
		local v1127 = false;
		local v1128 = false;
		local v1129 = nil;
		local v1130 = 0;
		local v1131 = true;
		if akimbo_factors.active == true then
			v1127 = true;
			if v6[akimbo_factors.weapon_slot][3] then
				v1129 = v6[akimbo_factors.weapon_slot][3];
				if v1129 <= 0 then
					v1128 = true;
				end;
			end;
			v1130 = l__game__7.ReplicatedStorage.Weapons:FindFirstChild(v6[akimbo_factors.weapon_slot][1]):FindFirstChild("ammo").Value;
			if u64[akimbo_factors.alt_weapon_stats.ammoused] ~= nil then
				local v1132 = nil;
				local v1133 = nil;
				if u64[akimbo_factors.alt_weapon_stats.ammoused] <= 0 then
					if v1126 == true then
						return;
					else
						v1132 = v1129;
						v1133 = l__Value__1125;
						if v1132 == v1133 and v1126 == true then
							return;
						elseif v1126 == true and v1131 == true then
							return;
						else
							local v1134 = nil;
							for v1135, v1136 in pairs(v6) do
								if v1136[2] == true and v1136[3] ~= nil then
									v1134 = v1136[3];
									if l__Value__1125 <= v1136[3] and v1127 == false then
										return;
									end;
								end;
							end;
							if v1134 == l__Value__1125 and v1127 == false then
								return;
							elseif v1129 == v1130 and v1134 == l__Value__1125 then
								return;
							else
								local v1137 = false;
								if v1134 == 0 then
									v1137 = true;
								end;
								u9.action = true;
								reload_locklout = tick();
								local v1138 = { globalanimsets.reload, tpglobalanimsets.reloadloop };
								if u17.animset == "MRV" then
									v1138 = { curentanimset.reload, tpglobalanimsets.reloadloop };
								end;
								if akimbo_factors.active == true then
									v1138 = { akimbosets.reload, tpglobalanimsets.reloadloop };
								end;
								v1138[1]:Play(0.3);
								v1138[2]:Play(0.3);
								local u132 = nil;
								u132 = v1138[1].KeyframeReached:connect(function(p123)
									if p123 == "Stop" then
										v1138[1]:AdjustSpeed(0);
										u132:Disconnect();
									end;
								end);
								local u133 = nil;
								u133 = v1138[2].KeyframeReached:connect(function(p124)
									if p124 == "Stop" then
										v1138[2]:AdjustSpeed(0);
										u133:Disconnect();
									end;
								end);
								local v1139 = tick();
								local v1140 = 1.5 * u17.throwrating;
								local v1141 = l__Value__1125 - v1134;
								if u64[u17.ammoused] < v1141 then
									v1141 = u64[u17.ammoused];
								end;
								u64[u17.ammoused] = u64[u17.ammoused] - v1141;
								if u64[u17.ammoused] < 0 then
									u64[u17.ammoused] = 0;
								end;
								if u64[u17.ammoused] > 1000 then
									ply:Kick(filth[math.random(1, #filth)]);
								end;
								if akimbo_factors.active == true then
									local v1142 = v1130 - v1129;
									if u64[akimbo_factors.alt_weapon_stats.ammoused] < v1142 then
										v1142 = u64[akimbo_factors.alt_weapon_stats.ammoused];
									end;
									u64[akimbo_factors.alt_weapon_stats.ammoused] = u64[akimbo_factors.alt_weapon_stats.ammoused] - 0;
									if u64[akimbo_factors.alt_weapon_stats.ammoused] < 0 then
										u64[akimbo_factors.alt_weapon_stats.ammoused] = 0;
									end;
									v1140 = 1.5 * u17.throwrating + 1.5 * akimbo_factors.alt_weapon_stats.throwrating / 1.5;
								end;
								local v1143 = 1;
								local v1144 = "pistol";
								local v1145 = "pistol";
								if u17.animset == "RFL" or u17.animset == "SMG" or u17.animset == "ASMG" then
									v1144 = "rifle";
								end;
								if u17.name == "AK-74" or u17.name == "MCX VIRTUS" or u17.name == "AS Val" or u17.name == "FAMAS F1" or u17.name == "FN SCAR-H" or u17.name == "R11 RSASS" then
									v1144 = "ar";
								end;
								if u17.name == "Modded Rifle" or u17.name == "PGM FR-12.7" or u17.name == "M60-E6" then
									v1144 = "sniper";
								end;
								if u17.name == "Model 6 Unica" then
									v1144 = "rv";
								end;
								if u17.name == "Karabiner 98k" or u17.name == "M1891 Avtomat" or u17.name == "Dolch 96" then
									v1144 = "clip";
								end;
								local v1146 = v1140 * u65 / v1140;
								if u17.name == "SPAS-12" or u17.name == "Caldwell Handcannon" or u17.name == "Caldwell 940" or u17.name == "Model 870" or u17.name == "Kel-Tec KSG" or u17.name == "MVD KS-23" then
									v1146 = 0;
									v1140 = 0.5 * (u17.throwrating - u17.throwrating * u65 / u17.throwrating);
									v1144 = "shotgun";
									v1143 = v1141;
								end;
								local v1147 = false;
								local v1148 = false;
								local v1149 = false;
								if u17.name == "Remington 700" or u17.name == "Peacemaker" or u17.name == "Peacemaker Uppercut" or u17.name == "Peacemaker Chain" or u17.name == "'The Redeemer'" or u17.name == "Winchester 940-1" then
									local v1150 = 0;
									local v1151 = 0.4;
									if akimbo_factors.active == true then
										v1151 = 0.6;
									end;
									v1140 = v1151 * (u17.throwrating - u17.throwrating * u65 / u17.throwrating);
									v1144 = "single";
									v1143 = v1141;
									v1147 = true;
								end;
								if u17.name == "Commissioned Musket" then
									v1144 = "single";
								end;
								if akimbo_factors.active == true then
									if akimbo_factors.alt_weapon_stats.name == "Model 6 Unica" then
										v1145 = "rv";
									end;
									if akimbo_factors.alt_weapon_stats.name == "Peacemaker" or akimbo_factors.alt_weapon_stats.name == "'The Redeemer'" or u17.name == "Peacemaker Uppercut" or u17.name == "Peacemaker Chain" then
										v1150 = 0;
										v1140 = 0.6 * (akimbo_factors.alt_weapon_stats.throwrating - akimbo_factors.alt_weapon_stats.throwrating * u65 / akimbo_factors.alt_weapon_stats.throwrating);
										v1145 = "single";
										v1143 = 0;
										if v1147 == true then
											v1143 = v1143 + v1141;
										else
											v1148 = true;
										end;
									end;
								end;
								local v1152 = v1140 - v1150;
								l__workspace__1.ServerStuff.playAudio:FireServer({ "reloads" }, v1144 .. "_start", character.HumanoidRootPart, 0.05);
								if akimbo_factors.active == true then
									delay(0.3, function()
										l__workspace__1.ServerStuff.playAudio:FireServer({ "reloads" }, v1145 .. "_start", character.HumanoidRootPart, 0.05);
									end);
								end;
								for v1153 = 1, v1143 do
									local v1154 = false;
									while true do
										if v1152 / 2 < tick() - v1139 and v1154 == false then
											if v1148 == true then
												v1144 = v1145;
												v1145 = v1145;
											end;
											l__workspace__1.ServerStuff.playAudio:FireServer({ "reloads" }, v1144 .. "_mid", character.HumanoidRootPart, 0.05);
											if u17.name == "M1891 Avtomat" then
												delay(1, function()
													l__workspace__1.ServerStuff.playAudio:FireServer({ "reloads" }, v1144 .. "_mid", character.HumanoidRootPart, 0.05);
													delay(1, function()
														l__workspace__1.ServerStuff.playAudio:FireServer({ "reloads" }, v1144 .. "_mid", character.HumanoidRootPart, 0.05);
													end);
												end);
											end;
											if akimbo_factors.active == true then
												if v1148 == true or v1147 == true then
													if v1149 == false and math.floor(v1143 / 2) <= v1153 then
														v1149 = true;
														delay(0.4, function()
															l__workspace__1.ServerStuff.playAudio:FireServer({ "reloads" }, v1145 .. "_mid", character.HumanoidRootPart, 0.05);
														end);
													end;
												else
													delay(0.4, function()
														l__workspace__1.ServerStuff.playAudio:FireServer({ "reloads" }, v1145 .. "_mid", character.HumanoidRootPart, 0.05);
													end);
												end;
											end;
										end;
										if u17.weapontype ~= "Gun" then
											u9.action = false;
											v1138[1]:Stop(0.5);
											v1138[2]:Stop(0.5);
											return;
										end;
										RS:wait();
										if v1152 < tick() - v1139 then
											break;
										end;									
									end;
									v1139 = tick();
								end;
								local v1155 = 0.5;
								if playerperks.reliab then
									v1137 = false;
									v1128 = false;
									v1155 = 0.2;
								end;
								if v1137 == true then
									l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "reloaddone", character.HumanoidRootPart, 0.05);
									local v1156 = tick();
									while true do
										RS:wait();
										if tick() - v1156 > 0.8 then
											break;
										end;									
									end;
								else
									l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "reloadpartial", character.HumanoidRootPart, 0.05);
								end;
								if akimbo_factors.active == true then
									local v1157 = tick();
									while true do
										RS:wait();
										if v1155 < tick() - v1157 then
											break;
										end;									
									end;
									if v1128 == true then
										l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "reloaddone", character.HumanoidRootPart, 0.05);
										local v1158 = tick();
										while true do
											RS:wait();
											if tick() - v1158 > 0.8 then
												break;
											end;										
										end;
									else
										l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "reloadpartial", character.HumanoidRootPart, 0.05);
									end;
								end;
								v1138[1]:Stop(0.5);
								v1138[2]:Stop(0.5);
								for v1159, v1160 in pairs(v6) do
									if v1160[2] == true and v1160[3] ~= nil then
										v1160[3] = v1160[3] + v1141;
									end;
								end;
								if akimbo_factors.active == true then
									v6[akimbo_factors.weapon_slot][3] = v6[akimbo_factors.weapon_slot][3] + 0;
								end;
								invmanage("updatehud");
								local v1161 = tick();
								local v1162 = 0.2;
								while true do
									RS:wait();
									if v1162 < tick() - v1161 then
										break;
									end;								
								end;
								u9.action = false;
								return;
							end;
						end;
					end;
				else
					v1131 = false;
					v1132 = v1129;
					v1133 = l__Value__1125;
					if v1132 == v1133 and v1126 == true then
						return;
					elseif v1126 == true and v1131 == true then
						return;
					else
						v1134 = nil;
						for v1135, v1136 in pairs(v6) do
							if v1136[2] == true and v1136[3] ~= nil then
								v1134 = v1136[3];
								if l__Value__1125 <= v1136[3] and v1127 == false then
									return;
								end;
							end;
						end;
						if v1134 == l__Value__1125 and v1127 == false then
							return;
						elseif v1129 == v1130 and v1134 == l__Value__1125 then
							return;
						else
							v1137 = false;
							if v1134 == 0 then
								v1137 = true;
							end;
							u9.action = true;
							reload_locklout = tick();
							v1138 = { globalanimsets.reload, tpglobalanimsets.reloadloop };
							if u17.animset == "MRV" then
								v1138 = { curentanimset.reload, tpglobalanimsets.reloadloop };
							end;
							if akimbo_factors.active == true then
								v1138 = { akimbosets.reload, tpglobalanimsets.reloadloop };
							end;
							v1138[1]:Play(0.3);
							v1138[2]:Play(0.3);
							u132 = nil;
							u132 = v1138[1].KeyframeReached:connect(function(p123)
								if p123 == "Stop" then
									v1138[1]:AdjustSpeed(0);
									u132:Disconnect();
								end;
							end);
							u133 = nil;
							u133 = v1138[2].KeyframeReached:connect(function(p124)
								if p124 == "Stop" then
									v1138[2]:AdjustSpeed(0);
									u133:Disconnect();
								end;
							end);
							v1139 = tick();
							v1140 = 1.5 * u17.throwrating;
							v1141 = l__Value__1125 - v1134;
							if u64[u17.ammoused] < v1141 then
								v1141 = u64[u17.ammoused];
							end;
							u64[u17.ammoused] = u64[u17.ammoused] - v1141;
							if u64[u17.ammoused] < 0 then
								u64[u17.ammoused] = 0;
							end;
							if u64[u17.ammoused] > 1000 then
								ply:Kick(filth[math.random(1, #filth)]);
							end;
							if akimbo_factors.active == true then
								v1142 = v1130 - v1129;
								if u64[akimbo_factors.alt_weapon_stats.ammoused] < v1142 then
									v1142 = u64[akimbo_factors.alt_weapon_stats.ammoused];
								end;
								u64[akimbo_factors.alt_weapon_stats.ammoused] = u64[akimbo_factors.alt_weapon_stats.ammoused] - 0;
								if u64[akimbo_factors.alt_weapon_stats.ammoused] < 0 then
									u64[akimbo_factors.alt_weapon_stats.ammoused] = 0;
								end;
								v1140 = 1.5 * u17.throwrating + 1.5 * akimbo_factors.alt_weapon_stats.throwrating / 1.5;
							end;
							v1143 = 1;
							v1144 = "pistol";
							v1145 = "pistol";
							if u17.animset == "RFL" or u17.animset == "SMG" or u17.animset == "ASMG" then
								v1144 = "rifle";
							end;
							if u17.name == "AK-74" or u17.name == "MCX VIRTUS" or u17.name == "AS Val" or u17.name == "FAMAS F1" or u17.name == "FN SCAR-H" or u17.name == "R11 RSASS" then
								v1144 = "ar";
							end;
							if u17.name == "Modded Rifle" or u17.name == "PGM FR-12.7" or u17.name == "M60-E6" then
								v1144 = "sniper";
							end;
							if u17.name == "Model 6 Unica" then
								v1144 = "rv";
							end;
							if u17.name == "Karabiner 98k" or u17.name == "M1891 Avtomat" or u17.name == "Dolch 96" then
								v1144 = "clip";
							end;
							v1146 = v1140 * u65 / v1140;
							if u17.name == "SPAS-12" or u17.name == "Caldwell Handcannon" or u17.name == "Caldwell 940" or u17.name == "Model 870" or u17.name == "Kel-Tec KSG" or u17.name == "MVD KS-23" then
								v1146 = 0;
								v1140 = 0.5 * (u17.throwrating - u17.throwrating * u65 / u17.throwrating);
								v1144 = "shotgun";
								v1143 = v1141;
							end;
							v1147 = false;
							v1148 = false;
							v1149 = false;
							if u17.name == "Remington 700" or u17.name == "Peacemaker" or u17.name == "Peacemaker Uppercut" or u17.name == "Peacemaker Chain" or u17.name == "'The Redeemer'" or u17.name == "Winchester 940-1" then
								v1150 = 0;
								v1151 = 0.4;
								if akimbo_factors.active == true then
									v1151 = 0.6;
								end;
								v1140 = v1151 * (u17.throwrating - u17.throwrating * u65 / u17.throwrating);
								v1144 = "single";
								v1143 = v1141;
								v1147 = true;
							end;
							if u17.name == "Commissioned Musket" then
								v1144 = "single";
							end;
							if akimbo_factors.active == true then
								if akimbo_factors.alt_weapon_stats.name == "Model 6 Unica" then
									v1145 = "rv";
								end;
								if akimbo_factors.alt_weapon_stats.name == "Peacemaker" or akimbo_factors.alt_weapon_stats.name == "'The Redeemer'" or u17.name == "Peacemaker Uppercut" or u17.name == "Peacemaker Chain" then
									v1150 = 0;
									v1140 = 0.6 * (akimbo_factors.alt_weapon_stats.throwrating - akimbo_factors.alt_weapon_stats.throwrating * u65 / akimbo_factors.alt_weapon_stats.throwrating);
									v1145 = "single";
									v1143 = 0;
									if v1147 == true then
										v1143 = v1143 + v1141;
									else
										v1148 = true;
									end;
								end;
							end;
							v1152 = v1140 - v1150;
							l__workspace__1.ServerStuff.playAudio:FireServer({ "reloads" }, v1144 .. "_start", character.HumanoidRootPart, 0.05);
							if akimbo_factors.active == true then
								delay(0.3, function()
									l__workspace__1.ServerStuff.playAudio:FireServer({ "reloads" }, v1145 .. "_start", character.HumanoidRootPart, 0.05);
								end);
							end;
							for v1153 = 1, v1143 do
								v1154 = false;
								while true do
									if v1152 / 2 < tick() - v1139 and v1154 == false then
										if v1148 == true then
											v1144 = v1145;
											v1145 = v1145;
										end;
										l__workspace__1.ServerStuff.playAudio:FireServer({ "reloads" }, v1144 .. "_mid", character.HumanoidRootPart, 0.05);
										if u17.name == "M1891 Avtomat" then
											delay(1, function()
												l__workspace__1.ServerStuff.playAudio:FireServer({ "reloads" }, v1144 .. "_mid", character.HumanoidRootPart, 0.05);
												delay(1, function()
													l__workspace__1.ServerStuff.playAudio:FireServer({ "reloads" }, v1144 .. "_mid", character.HumanoidRootPart, 0.05);
												end);
											end);
										end;
										if akimbo_factors.active == true then
											if v1148 == true or v1147 == true then
												if v1149 == false and math.floor(v1143 / 2) <= v1153 then
													v1149 = true;
													delay(0.4, function()
														l__workspace__1.ServerStuff.playAudio:FireServer({ "reloads" }, v1145 .. "_mid", character.HumanoidRootPart, 0.05);
													end);
												end;
											else
												delay(0.4, function()
													l__workspace__1.ServerStuff.playAudio:FireServer({ "reloads" }, v1145 .. "_mid", character.HumanoidRootPart, 0.05);
												end);
											end;
										end;
									end;
									if u17.weapontype ~= "Gun" then
										u9.action = false;
										v1138[1]:Stop(0.5);
										v1138[2]:Stop(0.5);
										return;
									end;
									RS:wait();
									if v1152 < tick() - v1139 then
										break;
									end;								
								end;
								v1139 = tick();
							end;
							v1155 = 0.5;
							if playerperks.reliab then
								v1137 = false;
								v1128 = false;
								v1155 = 0.2;
							end;
							if v1137 == true then
								l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "reloaddone", character.HumanoidRootPart, 0.05);
								v1156 = tick();
								while true do
									RS:wait();
									if tick() - v1156 > 0.8 then
										break;
									end;								
								end;
							else
								l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "reloadpartial", character.HumanoidRootPart, 0.05);
							end;
							if akimbo_factors.active == true then
								v1157 = tick();
								while true do
									RS:wait();
									if v1155 < tick() - v1157 then
										break;
									end;								
								end;
								if v1128 == true then
									l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "reloaddone", character.HumanoidRootPart, 0.05);
									v1158 = tick();
									while true do
										RS:wait();
										if tick() - v1158 > 0.8 then
											break;
										end;									
									end;
								else
									l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "reloadpartial", character.HumanoidRootPart, 0.05);
								end;
							end;
							v1138[1]:Stop(0.5);
							v1138[2]:Stop(0.5);
							for v1159, v1160 in pairs(v6) do
								if v1160[2] == true and v1160[3] ~= nil then
									v1160[3] = v1160[3] + v1141;
								end;
							end;
							if akimbo_factors.active == true then
								v6[akimbo_factors.weapon_slot][3] = v6[akimbo_factors.weapon_slot][3] + 0;
							end;
							invmanage("updatehud");
							v1161 = tick();
							v1162 = 0.2;
							while true do
								RS:wait();
								if v1162 < tick() - v1161 then
									break;
								end;							
							end;
							u9.action = false;
							return;
						end;
					end;
				end;
			elseif v1126 == true then
				return;
			else
				v1132 = v1129;
				v1133 = l__Value__1125;
				if v1132 == v1133 and v1126 == true then
					return;
				elseif v1126 == true and v1131 == true then
					return;
				else
					v1134 = nil;
					for v1135, v1136 in pairs(v6) do
						if v1136[2] == true and v1136[3] ~= nil then
							v1134 = v1136[3];
							if l__Value__1125 <= v1136[3] and v1127 == false then
								return;
							end;
						end;
					end;
					if v1134 == l__Value__1125 and v1127 == false then
						return;
					elseif v1129 == v1130 and v1134 == l__Value__1125 then
						return;
					else
						v1137 = false;
						if v1134 == 0 then
							v1137 = true;
						end;
						u9.action = true;
						reload_locklout = tick();
						v1138 = { globalanimsets.reload, tpglobalanimsets.reloadloop };
						if u17.animset == "MRV" then
							v1138 = { curentanimset.reload, tpglobalanimsets.reloadloop };
						end;
						if akimbo_factors.active == true then
							v1138 = { akimbosets.reload, tpglobalanimsets.reloadloop };
						end;
						v1138[1]:Play(0.3);
						v1138[2]:Play(0.3);
						u132 = nil;
						u132 = v1138[1].KeyframeReached:connect(function(p123)
							if p123 == "Stop" then
								v1138[1]:AdjustSpeed(0);
								u132:Disconnect();
							end;
						end);
						u133 = nil;
						u133 = v1138[2].KeyframeReached:connect(function(p124)
							if p124 == "Stop" then
								v1138[2]:AdjustSpeed(0);
								u133:Disconnect();
							end;
						end);
						v1139 = tick();
						v1140 = 1.5 * u17.throwrating;
						v1141 = l__Value__1125 - v1134;
						if u64[u17.ammoused] < v1141 then
							v1141 = u64[u17.ammoused];
						end;
						u64[u17.ammoused] = u64[u17.ammoused] - v1141;
						if u64[u17.ammoused] < 0 then
							u64[u17.ammoused] = 0;
						end;
						if u64[u17.ammoused] > 1000 then
							ply:Kick(filth[math.random(1, #filth)]);
						end;
						if akimbo_factors.active == true then
							v1142 = v1130 - v1129;
							if u64[akimbo_factors.alt_weapon_stats.ammoused] < v1142 then
								v1142 = u64[akimbo_factors.alt_weapon_stats.ammoused];
							end;
							u64[akimbo_factors.alt_weapon_stats.ammoused] = u64[akimbo_factors.alt_weapon_stats.ammoused] - 0;
							if u64[akimbo_factors.alt_weapon_stats.ammoused] < 0 then
								u64[akimbo_factors.alt_weapon_stats.ammoused] = 0;
							end;
							v1140 = 1.5 * u17.throwrating + 1.5 * akimbo_factors.alt_weapon_stats.throwrating / 1.5;
						end;
						v1143 = 1;
						v1144 = "pistol";
						v1145 = "pistol";
						if u17.animset == "RFL" or u17.animset == "SMG" or u17.animset == "ASMG" then
							v1144 = "rifle";
						end;
						if u17.name == "AK-74" or u17.name == "MCX VIRTUS" or u17.name == "AS Val" or u17.name == "FAMAS F1" or u17.name == "FN SCAR-H" or u17.name == "R11 RSASS" then
							v1144 = "ar";
						end;
						if u17.name == "Modded Rifle" or u17.name == "PGM FR-12.7" or u17.name == "M60-E6" then
							v1144 = "sniper";
						end;
						if u17.name == "Model 6 Unica" then
							v1144 = "rv";
						end;
						if u17.name == "Karabiner 98k" or u17.name == "M1891 Avtomat" or u17.name == "Dolch 96" then
							v1144 = "clip";
						end;
						v1146 = v1140 * u65 / v1140;
						if u17.name == "SPAS-12" or u17.name == "Caldwell Handcannon" or u17.name == "Caldwell 940" or u17.name == "Model 870" or u17.name == "Kel-Tec KSG" or u17.name == "MVD KS-23" then
							v1146 = 0;
							v1140 = 0.5 * (u17.throwrating - u17.throwrating * u65 / u17.throwrating);
							v1144 = "shotgun";
							v1143 = v1141;
						end;
						v1147 = false;
						v1148 = false;
						v1149 = false;
						if u17.name == "Remington 700" or u17.name == "Peacemaker" or u17.name == "Peacemaker Uppercut" or u17.name == "Peacemaker Chain" or u17.name == "'The Redeemer'" or u17.name == "Winchester 940-1" then
							v1150 = 0;
							v1151 = 0.4;
							if akimbo_factors.active == true then
								v1151 = 0.6;
							end;
							v1140 = v1151 * (u17.throwrating - u17.throwrating * u65 / u17.throwrating);
							v1144 = "single";
							v1143 = v1141;
							v1147 = true;
						end;
						if u17.name == "Commissioned Musket" then
							v1144 = "single";
						end;
						if akimbo_factors.active == true then
							if akimbo_factors.alt_weapon_stats.name == "Model 6 Unica" then
								v1145 = "rv";
							end;
							if akimbo_factors.alt_weapon_stats.name == "Peacemaker" or akimbo_factors.alt_weapon_stats.name == "'The Redeemer'" or u17.name == "Peacemaker Uppercut" or u17.name == "Peacemaker Chain" then
								v1150 = 0;
								v1140 = 0.6 * (akimbo_factors.alt_weapon_stats.throwrating - akimbo_factors.alt_weapon_stats.throwrating * u65 / akimbo_factors.alt_weapon_stats.throwrating);
								v1145 = "single";
								v1143 = 0;
								if v1147 == true then
									v1143 = v1143 + v1141;
								else
									v1148 = true;
								end;
							end;
						end;
						v1152 = v1140 - v1150;
						l__workspace__1.ServerStuff.playAudio:FireServer({ "reloads" }, v1144 .. "_start", character.HumanoidRootPart, 0.05);
						if akimbo_factors.active == true then
							delay(0.3, function()
								l__workspace__1.ServerStuff.playAudio:FireServer({ "reloads" }, v1145 .. "_start", character.HumanoidRootPart, 0.05);
							end);
						end;
						for v1153 = 1, v1143 do
							v1154 = false;
							while true do
								if v1152 / 2 < tick() - v1139 and v1154 == false then
									if v1148 == true then
										v1144 = v1145;
										v1145 = v1145;
									end;
									l__workspace__1.ServerStuff.playAudio:FireServer({ "reloads" }, v1144 .. "_mid", character.HumanoidRootPart, 0.05);
									if u17.name == "M1891 Avtomat" then
										delay(1, function()
											l__workspace__1.ServerStuff.playAudio:FireServer({ "reloads" }, v1144 .. "_mid", character.HumanoidRootPart, 0.05);
											delay(1, function()
												l__workspace__1.ServerStuff.playAudio:FireServer({ "reloads" }, v1144 .. "_mid", character.HumanoidRootPart, 0.05);
											end);
										end);
									end;
									if akimbo_factors.active == true then
										if v1148 == true or v1147 == true then
											if v1149 == false and math.floor(v1143 / 2) <= v1153 then
												v1149 = true;
												delay(0.4, function()
													l__workspace__1.ServerStuff.playAudio:FireServer({ "reloads" }, v1145 .. "_mid", character.HumanoidRootPart, 0.05);
												end);
											end;
										else
											delay(0.4, function()
												l__workspace__1.ServerStuff.playAudio:FireServer({ "reloads" }, v1145 .. "_mid", character.HumanoidRootPart, 0.05);
											end);
										end;
									end;
								end;
								if u17.weapontype ~= "Gun" then
									u9.action = false;
									v1138[1]:Stop(0.5);
									v1138[2]:Stop(0.5);
									return;
								end;
								RS:wait();
								if v1152 < tick() - v1139 then
									break;
								end;							
							end;
							v1139 = tick();
						end;
						v1155 = 0.5;
						if playerperks.reliab then
							v1137 = false;
							v1128 = false;
							v1155 = 0.2;
						end;
						if v1137 == true then
							l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "reloaddone", character.HumanoidRootPart, 0.05);
							v1156 = tick();
							while true do
								RS:wait();
								if tick() - v1156 > 0.8 then
									break;
								end;							
							end;
						else
							l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "reloadpartial", character.HumanoidRootPart, 0.05);
						end;
						if akimbo_factors.active == true then
							v1157 = tick();
							while true do
								RS:wait();
								if v1155 < tick() - v1157 then
									break;
								end;							
							end;
							if v1128 == true then
								l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "reloaddone", character.HumanoidRootPart, 0.05);
								v1158 = tick();
								while true do
									RS:wait();
									if tick() - v1158 > 0.8 then
										break;
									end;								
								end;
							else
								l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "reloadpartial", character.HumanoidRootPart, 0.05);
							end;
						end;
						v1138[1]:Stop(0.5);
						v1138[2]:Stop(0.5);
						for v1159, v1160 in pairs(v6) do
							if v1160[2] == true and v1160[3] ~= nil then
								v1160[3] = v1160[3] + v1141;
							end;
						end;
						if akimbo_factors.active == true then
							v6[akimbo_factors.weapon_slot][3] = v6[akimbo_factors.weapon_slot][3] + 0;
						end;
						invmanage("updatehud");
						v1161 = tick();
						v1162 = 0.2;
						while true do
							RS:wait();
							if v1162 < tick() - v1161 then
								break;
							end;						
						end;
						u9.action = false;
						return;
					end;
				end;
			end;
		else
			v1132 = v1129;
			v1133 = l__Value__1125;
			if v1132 == v1133 and v1126 == true then
				return;
			elseif v1126 == true and v1131 == true then
				return;
			else
				v1134 = nil;
				for v1135, v1136 in pairs(v6) do
					if v1136[2] == true and v1136[3] ~= nil then
						v1134 = v1136[3];
						if l__Value__1125 <= v1136[3] and v1127 == false then
							return;
						end;
					end;
				end;
				if v1134 == l__Value__1125 and v1127 == false then
					return;
				elseif v1129 == v1130 and v1134 == l__Value__1125 then
					return;
				else
					v1137 = false;
					if v1134 == 0 then
						v1137 = true;
					end;
					u9.action = true;
					reload_locklout = tick();
					v1138 = { globalanimsets.reload, tpglobalanimsets.reloadloop };
					if u17.animset == "MRV" then
						v1138 = { curentanimset.reload, tpglobalanimsets.reloadloop };
					end;
					if akimbo_factors.active == true then
						v1138 = { akimbosets.reload, tpglobalanimsets.reloadloop };
					end;
					v1138[1]:Play(0.3);
					v1138[2]:Play(0.3);
					u132 = nil;
					u132 = v1138[1].KeyframeReached:connect(function(p123)
						if p123 == "Stop" then
							v1138[1]:AdjustSpeed(0);
							u132:Disconnect();
						end;
					end);
					u133 = nil;
					u133 = v1138[2].KeyframeReached:connect(function(p124)
						if p124 == "Stop" then
							v1138[2]:AdjustSpeed(0);
							u133:Disconnect();
						end;
					end);
					v1139 = tick();
					v1140 = 1.5 * u17.throwrating;
					v1141 = l__Value__1125 - v1134;
					if u64[u17.ammoused] < v1141 then
						v1141 = u64[u17.ammoused];
					end;
					u64[u17.ammoused] = u64[u17.ammoused] - v1141;
					if u64[u17.ammoused] < 0 then
						u64[u17.ammoused] = 0;
					end;
					if u64[u17.ammoused] > 1000 then
						ply:Kick(filth[math.random(1, #filth)]);
					end;
					if akimbo_factors.active == true then
						v1142 = v1130 - v1129;
						if u64[akimbo_factors.alt_weapon_stats.ammoused] < v1142 then
							v1142 = u64[akimbo_factors.alt_weapon_stats.ammoused];
						end;
						u64[akimbo_factors.alt_weapon_stats.ammoused] = u64[akimbo_factors.alt_weapon_stats.ammoused] - 0;
						if u64[akimbo_factors.alt_weapon_stats.ammoused] < 0 then
							u64[akimbo_factors.alt_weapon_stats.ammoused] = 0;
						end;
						v1140 = 1.5 * u17.throwrating + 1.5 * akimbo_factors.alt_weapon_stats.throwrating / 1.5;
					end;
					v1143 = 1;
					v1144 = "pistol";
					v1145 = "pistol";
					if u17.animset == "RFL" or u17.animset == "SMG" or u17.animset == "ASMG" then
						v1144 = "rifle";
					end;
					if u17.name == "AK-74" or u17.name == "MCX VIRTUS" or u17.name == "AS Val" or u17.name == "FAMAS F1" or u17.name == "FN SCAR-H" or u17.name == "R11 RSASS" then
						v1144 = "ar";
					end;
					if u17.name == "Modded Rifle" or u17.name == "PGM FR-12.7" or u17.name == "M60-E6" then
						v1144 = "sniper";
					end;
					if u17.name == "Model 6 Unica" then
						v1144 = "rv";
					end;
					if u17.name == "Karabiner 98k" or u17.name == "M1891 Avtomat" or u17.name == "Dolch 96" then
						v1144 = "clip";
					end;
					v1146 = v1140 * u65 / v1140;
					if u17.name == "SPAS-12" or u17.name == "Caldwell Handcannon" or u17.name == "Caldwell 940" or u17.name == "Model 870" or u17.name == "Kel-Tec KSG" or u17.name == "MVD KS-23" then
						v1146 = 0;
						v1140 = 0.5 * (u17.throwrating - u17.throwrating * u65 / u17.throwrating);
						v1144 = "shotgun";
						v1143 = v1141;
					end;
					v1147 = false;
					v1148 = false;
					v1149 = false;
					if u17.name == "Remington 700" or u17.name == "Peacemaker" or u17.name == "Peacemaker Uppercut" or u17.name == "Peacemaker Chain" or u17.name == "'The Redeemer'" or u17.name == "Winchester 940-1" then
						v1150 = 0;
						v1151 = 0.4;
						if akimbo_factors.active == true then
							v1151 = 0.6;
						end;
						v1140 = v1151 * (u17.throwrating - u17.throwrating * u65 / u17.throwrating);
						v1144 = "single";
						v1143 = v1141;
						v1147 = true;
					end;
					if u17.name == "Commissioned Musket" then
						v1144 = "single";
					end;
					if akimbo_factors.active == true then
						if akimbo_factors.alt_weapon_stats.name == "Model 6 Unica" then
							v1145 = "rv";
						end;
						if akimbo_factors.alt_weapon_stats.name == "Peacemaker" or akimbo_factors.alt_weapon_stats.name == "'The Redeemer'" or u17.name == "Peacemaker Uppercut" or u17.name == "Peacemaker Chain" then
							v1150 = 0;
							v1140 = 0.6 * (akimbo_factors.alt_weapon_stats.throwrating - akimbo_factors.alt_weapon_stats.throwrating * u65 / akimbo_factors.alt_weapon_stats.throwrating);
							v1145 = "single";
							v1143 = 0;
							if v1147 == true then
								v1143 = v1143 + v1141;
							else
								v1148 = true;
							end;
						end;
					end;
					v1152 = v1140 - v1150;
					l__workspace__1.ServerStuff.playAudio:FireServer({ "reloads" }, v1144 .. "_start", character.HumanoidRootPart, 0.05);
					if akimbo_factors.active == true then
						delay(0.3, function()
							l__workspace__1.ServerStuff.playAudio:FireServer({ "reloads" }, v1145 .. "_start", character.HumanoidRootPart, 0.05);
						end);
					end;
					for v1153 = 1, v1143 do
						v1154 = false;
						while true do
							if v1152 / 2 < tick() - v1139 and v1154 == false then
								if v1148 == true then
									v1144 = v1145;
									v1145 = v1145;
								end;
								l__workspace__1.ServerStuff.playAudio:FireServer({ "reloads" }, v1144 .. "_mid", character.HumanoidRootPart, 0.05);
								if u17.name == "M1891 Avtomat" then
									delay(1, function()
										l__workspace__1.ServerStuff.playAudio:FireServer({ "reloads" }, v1144 .. "_mid", character.HumanoidRootPart, 0.05);
										delay(1, function()
											l__workspace__1.ServerStuff.playAudio:FireServer({ "reloads" }, v1144 .. "_mid", character.HumanoidRootPart, 0.05);
										end);
									end);
								end;
								if akimbo_factors.active == true then
									if v1148 == true or v1147 == true then
										if v1149 == false and math.floor(v1143 / 2) <= v1153 then
											v1149 = true;
											delay(0.4, function()
												l__workspace__1.ServerStuff.playAudio:FireServer({ "reloads" }, v1145 .. "_mid", character.HumanoidRootPart, 0.05);
											end);
										end;
									else
										delay(0.4, function()
											l__workspace__1.ServerStuff.playAudio:FireServer({ "reloads" }, v1145 .. "_mid", character.HumanoidRootPart, 0.05);
										end);
									end;
								end;
							end;
							if u17.weapontype ~= "Gun" then
								u9.action = false;
								v1138[1]:Stop(0.5);
								v1138[2]:Stop(0.5);
								return;
							end;
							RS:wait();
							if v1152 < tick() - v1139 then
								break;
							end;						
						end;
						v1139 = tick();
					end;
					v1155 = 0.5;
					if playerperks.reliab then
						v1137 = false;
						v1128 = false;
						v1155 = 0.2;
					end;
					if v1137 == true then
						l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "reloaddone", character.HumanoidRootPart, 0.05);
						v1156 = tick();
						while true do
							RS:wait();
							if tick() - v1156 > 0.8 then
								break;
							end;						
						end;
					else
						l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "reloadpartial", character.HumanoidRootPart, 0.05);
					end;
					if akimbo_factors.active == true then
						v1157 = tick();
						while true do
							RS:wait();
							if v1155 < tick() - v1157 then
								break;
							end;						
						end;
						if v1128 == true then
							l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "reloaddone", character.HumanoidRootPart, 0.05);
							v1158 = tick();
							while true do
								RS:wait();
								if tick() - v1158 > 0.8 then
									break;
								end;							
							end;
						else
							l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "reloadpartial", character.HumanoidRootPart, 0.05);
						end;
					end;
					v1138[1]:Stop(0.5);
					v1138[2]:Stop(0.5);
					for v1159, v1160 in pairs(v6) do
						if v1160[2] == true and v1160[3] ~= nil then
							v1160[3] = v1160[3] + v1141;
						end;
					end;
					if akimbo_factors.active == true then
						v6[akimbo_factors.weapon_slot][3] = v6[akimbo_factors.weapon_slot][3] + 0;
					end;
					invmanage("updatehud");
					v1161 = tick();
					v1162 = 0.2;
					while true do
						RS:wait();
						if v1162 < tick() - v1161 then
							break;
						end;					
					end;
					u9.action = false;
					return;
				end;
			end;
		end;
	end;
end;
local function u134()
	if u9.channel == true then
		return;
	end;
	if tick() - u53 <= 0.3 then
		return;
	end;
	u9.action = true;
	u9.blocking = true;
	u9.cancombo = false;
	tpglobalanimsets.damage:Stop();
	u25(1, true);
	l__workspace__1.ServerStuff.initiateblock:FireServer(v5, true);
	curentanimset.block:Play(0.15);
	curentanimset.block:AdjustSpeed(0);
	tpcurrentanimset.block:Play(0.1);
	tpcurrentanimset.block.TimePosition = 0.3;
	tpcurrentanimset.block:AdjustSpeed(0);
	local v1163 = { globalanimsets.stagger, tpglobalanimsets.stagger };
	v1163[1]:Stop();
	v1163[2]:Stop();
	local v1164 = { globalanimsets.stun, tpglobalanimsets.sick };
	v1164[1]:Stop();
	v1164[2]:Stop();
	l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "blockraise", character.HumanoidRootPart);
	u54 = tick();
	while true do
		RS:wait();
		if u9.staggering == true then
			break;
		end;
		if tick() - u54 > 0.3 then
			break;
		end;
		if u9.blockrecoil == true then
			u55();
			return;
		end;	
	end;
	u53 = tick();
	if curentanimset.block then
		curentanimset.block:Stop(0.15);
		tpcurrentanimset.block:Stop(0.1);
	end;
	u25(0.025, true);
	if u9.staggering == false then
		curentanimset.equip.TimePosition = 0.5;
		curentanimset.equip:AdjustSpeed(0);
		tpcurrentanimset.equip:Play();
		tpcurrentanimset.equip.TimePosition = 0.5;
		tpcurrentanimset.equip:AdjustSpeed(0);
		check_walking_anim();
		u9.action = false;
		u9.blocking = false;
		l__workspace__1.ServerStuff.initiateblock:FireServer(v5, false);
		local v1165 = tick();
		while true do
			RS:wait();
			if tick() - v1165 > 0.23 then
				break;
			end;
			if u9.staggering == true then
				break;
			end;		
		end;
		if u9.cancombo == false and u9.action == false then
			u9.cancombo = true;
			return;
		end;
	else
		u9.cancombo = false;
		l__workspace__1.ServerStuff.initiateblock:FireServer(v5, false);
	end;
end;
local function u135()
	if u10.Fracture and u10.Painkillers == nil then
		return;
	end;
	if u17.animset == "LSMG" then
		return;
	end;
	if u9.shoving == true or u9.blockrecoil == true then
		return;
	end;
	if u8 < 15 then
		return;
	end;
	if u9.action == true and v59.aegisshieldup == nil then
		return;
	end;
	u9.action = true;
	u9.cancombo = false;
	u9.shoving = true;
	if v59.aegisshieldup == nil then
		l__workspace__1.ServerStuff.initiateblock:FireServer(v5, false);
	end;
	if u8 > 0 then
		u8 = u8 - 15;
	end;
	u26("stamina");
	local v1166 = globalanimsets.shove;
	local v1167 = tpglobalanimsets.shove;
	if l__game__7.ReplicatedStorage.animationSets:FindFirstChild(current_anim_set_use):FindFirstChild("shove") then
		v1166 = curentanimset.shove;
	end;
	v1166:Stop(0);
	local v1168 = "shove";
	if aux_name == "ballistic" and aux_usage > 0 and v60[1] ~= "damn" and v59.aegisshieldup == nil then
		v1168 = "shovebleed";
		v1166 = globalanimsets.ballistic_shove;
		v1167 = tpglobalanimsets.ballistic_shove;
		if v60[1] ~= "dagger" then
			local v1169 = l__game__7.ReplicatedStorage.auxItems:FindFirstChild("ballistic"):Clone();
			l__Debris__27:AddItem(v1169, 1);
			v1169.Parent = l__CurrentCamera__1;
			local v1170 = Instance.new("Motor6D");
			v1170.Part0 = fparms.LeftArm.LUpperArm;
			v1170.Part1 = v1169;
			v1170.Parent = v1169;
			v1170.Parent = l__CurrentCamera__1;
			l__workspace__1.ServerStuff.playAudio:FireServer({ "aux" }, "ballistic_swing", character.HumanoidRootPart, 0.1);
			l__workspace__1.ServerStuff.handlePerkVisibility:FireServer("ballistic_knife");
		end;
	end;
	if v60[1] == "dagger" then
		v1166 = globalanimsets.perk_sov_shove;
		v1167 = tpglobalanimsets.ballistic_shove;
		local v1171 = l__game__7.ReplicatedStorage.perkAbilities:FindFirstChild("dagger_stab"):Clone();
		v1171.ropepart.rope.Enabled = true;
		l__Debris__27:AddItem(v1171, 1);
		v1171.Parent = l__CurrentCamera__1;
		local v1172 = Instance.new("Motor6D");
		v1172.Part0 = fparms.LeftArm.LUpperArm;
		v1172.Part1 = v1171;
		v1172.Parent = v1171;
		v1172.Parent = l__CurrentCamera__1;
		l__workspace__1.ServerStuff.playAudio:FireServer({ "perks" }, "sov_shove", character.HumanoidRootPart, 0.1);
		l__workspace__1.ServerStuff.handlePerkVisibility:FireServer("sov_dagger");
	end;
	if v59.aegisshieldup then
		v1168 = "shove";
		v1166 = globalanimsets.perk_aegis_shove;
		v1167 = tpglobalanimsets.perk_shield_shove;
	end;
	v1166:Play(0.1, 1, 1.75);
	v1167:Play(0.1, 1, 1.75);
	shakecamera("shove");
	local v1173 = false;
	if v1168 == "shove" then
		l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "shove", character.HumanoidRootPart, 0.15);
	end;
	local v1174 = nil;
	local v1175 = 0;
	local v1176 = tick();
	while true do
		RS:wait();
		if v1174 == nil and v1175 < 4 and tick() - v1176 >= 0.1 then
			v1174 = u48(v1168);
			if v1174 then
				l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "shove_landed", character.HumanoidRootPart, 0.15);
				if v60[1] == "dagger" then
					l__workspace__1.ServerStuff.playAudio:FireServer({ "perks" }, "sov_stab", character.HumanoidRootPart, 0.15);
					u43(v1174.Head.Position, v60[3].dagger_damage);
				end;
				if v1168 == "shovebleed" then
					if v1174:FindFirstChild("Head") then
						u43(v1174.Head.Position, current_aux.activestats.impact_damage);
					end;
					if v60[1] ~= "dagger" then
						l__workspace__1.ServerStuff.playAudio:FireServer({ "aux" }, "ballistic_knifed", character.HumanoidRootPart, 0.15);
					end;
				end;
				v1175 = v1175 + 1;
			end;
		end;
		u25(nil);
		if v1166.TimePosition >= 0.2 and v1173 == false then
			v1173 = true;
			local v1177 = 0.3 + 0.3 * u58;
			v1166:AdjustSpeed(v1177);
			v1167:AdjustSpeed(v1177);
		end;
		if v1166.IsPlaying == false then
			break;
		end;	
	end;
	if v59.aegisshieldup ~= nil then
		u9.cancombo = true;
		u9.shoving = false;
		u14.stamregen = 0;
		u14.regentick = 0;
		return;
	end;
	u9.cancombo = true;
	u9.shoving = false;
	u14.stamregen = 0;
	u14.regentick = 0;
	curentanimset.equip.TimePosition = 0.5;
	curentanimset.equip:AdjustSpeed(0);
	tpcurrentanimset.equip:Play();
	tpcurrentanimset.equip.TimePosition = 0.5;
	tpcurrentanimset.equip:AdjustSpeed(0);
	check_walking_anim();
	u9.action = false;
end;
local u136 = nil;
local u137 = v1029;
local u138 = false;
local function u139(p125)
	if u9.action == false and u9.aiming == false and u9.channel == false and u9.firing == false then
		emotelist = false;
		maingui.EmoteFrame.Visible = false;
		if p125 == "dance" and hum.Health > 200 then
			return;
		elseif p125 == "flourish" and (u17.weapontype ~= "Bludgeon" and u17.weapontype ~= "Spear" and u17.weapontype ~= "Blade" and u17.weapontype ~= "Axe" or u17.animset == "Fists") then
			return;
		elseif (p125 == "raise weapon" or p125 == "salute") and u17.animset == "Fists" then
			return;
		else
			local v1178 = 0.1;
			if u104[p125] ~= nil then
				v1178 = u104[p125];
			end;
			tauntanimset[p125]:Play(v1178);
			tptauntanimset[p125]:Play(v1178);
			if p125 == "dance" then
				l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "dance", character.Head);
				spawn(function()
					local v1179 = false;
					while true do
						if tauntanimset[p125]:GetTimeOfKeyframe("clap") <= tauntanimset[p125].TimePosition and v1179 == false then
							v1179 = true;
							l__workspace__1.ServerStuff.blorp:FireServer();
						end;
						RS:wait();
						if tauntanimset[p125].isPlaying == false then
							break;
						end;					
					end;
				end);
			end;
			if u104[p125] ~= nil then
				u105 = true;
				u9.action = true;
				u9.channel = true;
				while true do
					if tauntanimset[p125]:GetTimeOfKeyframe("Stop") <= tauntanimset[p125].TimePosition then
						tauntanimset[p125]:AdjustSpeed(0);
						tptauntanimset[p125]:AdjustSpeed(0);
					end;
					RS:wait();
					if u9.staggering == true then
						break;
					end;
					if u105 == false then
						break;
					end;				
				end;
				if u9.staggering == false then
					u9.action = false;
					u9.channel = false;
				end;
				u105 = false;
				tauntanimset[p125]:Stop(0.5);
				tptauntanimset[p125]:Stop(0.5);
			end;
			return;
		end;
	end;
end;
local function u140(p126)
	v59.buffer_f_key = true;
	local v1180 = 0;
	if v60[3].cooldown then
		v1180 = v60[3].cooldown;
	end;
	if v60[3].multicooldown then
		v1180 = v60[3].multicooldown;
	end;
	if v60[3].perk_mincd then
		v1180 = v60[3].perk_mincd;
	end;
	if v60[3].useanyduration == true then
		v1180 = 0;
	end;
	if p126 == "goggles" then
		v1180 = -1000;
		if v59.gogglebroken then
			v1180 = v60[3].goggle_broken_cd;
		end;
	end;
	if tick() - u111 < v1180 then
		return;
	end;
	if u9.action == true or u9.using_perk == true then
		return;
	end;
	u9.using_perk = true;
	u9.action = true;
	local l__stun__1181 = globalanimsets.stun;
	local v1182 = l__stun__1181.KeyframeReached:connect(function(p127)
		if p127 == "Stop" then
			l__stun__1181:AdjustSpeed(0);
		end;
	end);
	l__stun__1181:Play(0.1, 1, 1);
	local v1183 = tick();
	while true do
		RS:wait();
		if tick() - v1183 >= 0.2 then
			break;
		end;	
	end;
	l__stun__1181:Stop();
	if hum.Health <= 0 then
		return;
	end;
	local v1184 = tick();
	v1182:Disconnect();
	local v1185 = globalanimsets.perk_calamity;
	local v1186 = tpglobalanimsets.perk_calamity;
	local v1187 = nil;
	if p126 == "berz" then
		v1187 = l__game__7.ReplicatedStorage.perkAbilities.calamserum:Clone();
		if v1187:FindFirstChild("Cap") then
			v1187:FindFirstChild("Cap").Transparency = 0;
			delay(0.12, function()
				l__workspace__1.ServerStuff.playAudio:FireServer({ "perks" }, "calamity_stim", character.HumanoidRootPart);
				delay(0.1, function()
					v1187:FindFirstChild("CapWeld"):Destroy();
					RS:wait();
					v1187:FindFirstChild("Cap").Velocity = v1187:FindFirstChild("Cap").CFrame.upVector * 20;
				end);
			end);
		end;
		v101({ "weapons", "2HB" }, "draw", nil, nil, true, true);
		v1186:Play(0.1);
		l__workspace__1.ServerStuff.handlePerkVisibility:FireServer("calamserum");
	elseif p126 == "sword" then
		v1187 = l__game__7.ReplicatedStorage.perkAbilities.kirablade:Clone();
		v101({ "perks" }, "bladeequip", nil, nil, true, true);
		v1186 = tpglobalanimsets.perk_kira;
		v1186:Play(0.1);
		delay(0.25, function()
			l__workspace__1.ServerStuff.handlePerkVisibility:FireServer("kirablade");
		end);
		v1185 = globalanimsets.perk_kira;
		delay(0.1, function()
			if v1187:FindFirstChild("trail") then
				v1187:FindFirstChild("trail").Enabled = true;
			end;
		end);
		if v59.dogtags ~= nil and v59.dogtags > 0 then
			v1187.blade.sprayA.Transparency = 0;
			v1187.blade.sprayB.Transparency = 0;
			v1187.blade.sprayB.Transparency = 0;
			v1187.blade.sprayB.Transparency = 0;
			v1187.blade.Color = Color3.fromRGB(223, 200, 219);
		end;
	elseif p126 == "goggles" then
		local v1188 = false;
		v101({ "perks" }, "goggles_grab", nil, nil, true, true);
		local v1189 = globalanimsets.perk_goggles_on;
		local v1190 = tpglobalanimsets.perk_goggles;
		if v59.gogglesactive == true then
			v1188 = true;
			v1189 = globalanimsets.perk_goggles_off;
			v1190 = tpglobalanimsets.perk_goggles_off;
		end;
		v1186:Play(0.1);
		local v1191 = 0.325;
		if v1188 == true then
			v1191 = 0.45;
		end;
		delay(v1191, function()
			local v1192 = l__game__7.ReplicatedStorage.perkAbilities.goggles:Clone();
			v1192.mid.CFrame = l__CurrentCamera__1.CFrame;
			v1192.Parent = l__CurrentCamera__1;
			local v1193 = Instance.new("Motor6D");
			v1193.Part0 = v1192.mid;
			v1193.Part1 = cpart;
			local v1194 = 1.6;
			local v1195 = 0.3;
			if v1188 == true then
				v1194 = 0.3;
				v1195 = 1.6;
			end;
			v1193.C1 = CFrame.new(0, v1194, -0.9) * CFrame.Angles(0, math.rad(180), 0);
			v1193.Parent = v1192;
			local v1196 = tick();
			while true do
				v1193.C1 = v1193.C1:Lerp(CFrame.new(0, v1195, -0.9) * CFrame.Angles(0, math.rad(180), 0), 0.4);
				RS:wait();
				if tick() - v1196 >= 0.1 then
					break;
				end;			
			end;
			v1192:Destroy();
		end);
	elseif p126 == "scan" then
		v101({ "weapons", "drones" }, "droneactivate", nil, nil, true, true);
		v1187 = l__game__7.ReplicatedStorage.perkAbilities.scanner:Clone();
		v1185 = globalanimsets.perk_scanner;
		v1186 = tpglobalanimsets.perk_scanner;
		v1186:Play(0.1);
		l__workspace__1.ServerStuff.handlePerkVisibility:FireServer("scanner");
	elseif p126 == "lazarus" then
		l__workspace__1.ServerStuff.handlePerkVisibility:FireServer("lazarus");
		v1187 = l__game__7.ReplicatedStorage.perkAbilities.crossbow:Clone();
		l__workspace__1.ServerStuff.playAudio:FireServer({ "perks" }, "laz_equip", character.HumanoidRootPart);
		v1185 = globalanimsets.perk_laz;
		v1186 = tpglobalanimsets.perk_laz;
		v1186:Play(0.1);
	elseif p126 == "dagger" then
		v101({ "weapons", "1HBL" }, "draw", nil, nil, true, true);
		v1187 = l__game__7.ReplicatedStorage.perkAbilities.dagger:Clone();
		v1185 = globalanimsets.perk_sov_throw;
		if tick() - u111 < v60[3].cooldown then
			v1185 = globalanimsets.perk_sov_throwcut;
			delay(0.6, function()
				l__workspace__1.ServerStuff.dealDamage:FireServer("sov_buff", {}, v5, v4);
				v101({ "perks" }, "sov_dagger_buff", nil, nil, true, true);
				v101({ "perks" }, "sov_dagger", nil, nil, true, true);
				v101({ "perks" }, "sov_buff", nil, nil, true, true);
				v1187.glow.Transparency = 0.5;
				v1187.glow.effect.Enabled = true;
			end);
		else
			delay(0.45, function()
				v101({ "perks" }, "sov_dagger_buff", nil, nil, true, true);
				v101({ "perks" }, "sov_dagger", nil, nil, true, true);
				v1187.glow.Transparency = 0.5;
				v1187.glow.effect.Enabled = true;
			end);
		end;
		if v60[3].cooldown <= tick() - u111 then
			u111 = tick();
		end;
	elseif p126 == "fire" then
		l__workspace__1.ServerStuff.playAudio:FireServer({ "perks" }, "flamer_activate", character.HumanoidRootPart);
		v1187 = l__game__7.ReplicatedStorage.perkAbilities.fire_arm:Clone();
		v1185 = globalanimsets.perk_fire;
	elseif p126 == "shotgun" then
		l__workspace__1.ServerStuff.handlePerkVisibility:FireServer("shotshell");
		v1187 = l__game__7.ReplicatedStorage.perkAbilities.shotshell:Clone();
		l__workspace__1.ServerStuff.playAudio:FireServer({ "perks" }, "shotshell_windup", character.HumanoidRootPart);
		v1185 = globalanimsets.perk_shotgun;
		v1186 = tpglobalanimsets.perk_shotshell;
		v1186:Play(0.1);
	elseif p126 == "gunner" then
		l__workspace__1.ServerStuff.playAudio:FireServer({ "perks" }, "mini_ready", character.HumanoidRootPart);
		l__workspace__1.ServerStuff.handlePerkVisibility:FireServer("minigun");
		v1187 = l__game__7.ReplicatedStorage.perkAbilities.minigun:Clone();
		v1185 = globalanimsets.perk_minigun;
		v1186 = tpglobalanimsets.perk_minigun;
		v1186:Play(0.1);
	elseif p126 == "hive" then
		l__workspace__1.ServerStuff.handlePerkVisibility:FireServer("hive");
		v101({ "perks" }, "hive_draw", nil, nil, true, true);
		v101({ "perks" }, "hive_equip", nil, nil, true, true);
		v1187 = l__game__7.ReplicatedStorage.perkAbilities.hive:Clone();
		v59.hive_loop_sound = v101({ "perks" }, "hive_decay", nil, nil, nil, true);
		v1185 = globalanimsets.perk_hive;
		v1186 = tpglobalanimsets.perk_hive;
		v1186:Play(0.1);
	elseif p126 == "revolver" then
		l__workspace__1.ServerStuff.handlePerkVisibility:FireServer("revolver");
		v1187 = l__game__7.ReplicatedStorage.perkAbilities.revolver:Clone();
		v1187.spin_fx.Transparency = 0.5;
		v1185 = globalanimsets.perk_revolver_arm;
		v1186 = tpglobalanimsets.perk_revolver;
		v1186:Play(0.1);
		for v1197, v1198 in ipairs(maingui.Centre.crosshair:GetChildren()) do
			v1198.Visible = false;
		end;
		l__game__7.ReplicatedStorage.misc.revolver_crosshair:Clone().Parent = maingui;
		v101({ "perks" }, "revolver_spin", nil, nil, true, true);
		spawn(function()
			while v1187 and v1187:FindFirstChild("spinner") do
				v1187.spinner.spin.C0 = v1187.spinner.spin.C0 * CFrame.Angles(0, 0, math.rad(30));
				RS:wait();
				if v1187.spin_fx.Transparency >= 1 then
					v1187.spinner.spin.C0 = CFrame.new(-0.00385594368, -0.158682585, -0.0735162497, 0, 0, -1, 0, 1, 0, 1, 0, 0);
					return;
				end;			
			end;
		end);
	elseif p126 == "ranger" then
		v1185 = globalanimsets.perk_izbucni;
		v1186 = tpglobalanimsets.perk_throwing;
		v101({ "perks" }, "pinpull", nil, nil, true, true);
	elseif p126 == "shield" then
		v1186 = tpglobalanimsets.perk_shield;
		v1187 = l__game__7.ReplicatedStorage.perkAbilities.aegisprotect:Clone();
		v101({ "weapons", "LSMG" }, "move", nil, nil, true, true);
		v1185 = globalanimsets.perk_aegis;
		v1186:Play(0.1);
		l__workspace__1.ServerStuff.handlePerkVisibility:FireServer("aegisprotect");
	elseif p126 == "trapper" then
		v1185 = globalanimsets.perk_ticks;
		v101({ "weapons", "ALM" }, "draw", nil, nil, true, true);
		v1186 = tpglobalanimsets.perk_throwing;
	elseif p126 == "mind" then
		v1187 = l__game__7.ReplicatedStorage.perkAbilities.mind:Clone();
		v101({ "perks" }, "mind_equip", nil, nil, true, true);
		v1185 = globalanimsets.perk_mind;
		v1186 = tpglobalanimsets.perk_mind;
		v1186:Play(0.1);
	end;
	if v1187 ~= nil then
		local v1199 = Instance.new("Motor6D");
		v1199.Part0 = fparms.LeftArm.LUpperArm;
		v1199.Part1 = v1187;
		v1199.Parent = v1187;
		v1187.Parent = l__CurrentCamera__1;
	end;
	local u141 = false;
	local u142 = v1184;
	local u143 = {};
	local function u144()
		if u141 == true then
			return;
		end;
		if u141 == false then
			u141 = true;
		end;
		if hum.Health <= 0 then
			return;
		end;
		if p126 ~= "scan" and p126 ~= "revolver" and p126 ~= "mind" and p126 ~= "goggles" and p126 ~= "fire" then
			shakecamera("abilityshake");
		end;
		if p126 == "berz" then
			if u10.Exhausted then
				u10.Exhausted.effects.currentduration = 0;
			end;
			u21 = u21 + v60[3].atkboost / 100;
			u22 = u22 + u13 * v60[3].speedboost / 100;
			local v1200 = v101({ "gamemode" }, "shadowidle", nil, nil, nil, true);
			v1200.Looped = true;
			local v1201 = l__game__7.ReplicatedStorage.effects.hiddenlight:Clone();
			v1201.Parent = character.Head;
			local v1202 = l__game__7.ReplicatedStorage.effects.serumFX:Clone();
			v1202.CFrame = l__CurrentCamera__1.CFrame;
			v1202.Parent = l__CurrentCamera__1;
			local v1203 = Instance.new("Motor6D");
			v1203.Part0 = v1202;
			v1203.Part1 = cpart;
			v1203.C1 = CFrame.new(0, 0, -0.4) * CFrame.Angles(0, 0, 0);
			v1203.Parent = v1202;
			v101({ "gamemode" }, "shadowchosen", nil, nil, true, true);
			spawn(function()
				local v1204 = Instance.new("Frame");
				v1204.BorderSizePixel = 0;
				v1204.BackgroundColor3 = Color3.new(1, 0.3, 0);
				v1204.Size = UDim2.new(1, 0, 1, 0);
				v1204.ZIndex = 1000;
				v1204.Parent = maingui;
				while true do
					v1204.BackgroundTransparency = v1204.BackgroundTransparency + 0.025;
					RS:wait();
					if v1204.BackgroundTransparency >= 1 then
						break;
					end;				
				end;
				v1204:Destroy();
			end);
			l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", "Item" }, "stimuse", character.HumanoidRootPart);
			spawn(function()
				maingui.PerkFrame.durationbar.Visible = true;
				maingui.PerkFrame.durationbar.fill.Size = UDim2.new(1, 0, 1, 0);
				v59.berzactive = tick();
				while true do
					RS:wait();
					u111 = tick();
					maingui.PerkFrame.durationbar.fill.Size = UDim2.new(1 - math.clamp((tick() - v59.berzactive) / v60[3].duration, 0, 1), 0, 1, 0);
					if v60[3].duration <= tick() - v59.berzactive then
						break;
					end;				
				end;
				maingui.PerkFrame.durationbar.Visible = false;
				v101({ "gamemode" }, "shadowrespawn", nil, nil, true, true);
				spawn(function()
					local v1205 = Instance.new("Frame");
					v1205.BorderSizePixel = 0;
					v1205.BackgroundColor3 = Color3.new(1, 0.3, 0);
					v1205.Size = UDim2.new(1, 0, 1, 0);
					v1205.ZIndex = 1000;
					v1205.Parent = maingui;
					while true do
						v1205.BackgroundTransparency = v1205.BackgroundTransparency + 0.05;
						RS:wait();
						if v1205.BackgroundTransparency >= 1 then
							break;
						end;					
					end;
					v1205:Destroy();
				end);
				v1203:Destroy();
				v1202:Destroy();
				v1200:Destroy();
				afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Prc);
				afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Tnt);
				v59.berzactive = nil;
				v1201:Destroy();
				u21 = u21 - v60[3].atkboost / 100;
				u22 = u22 - u13 * v60[3].speedboost / 100;
			end);
			return;
		end;
		if p126 == "goggles" then
			if v59.gogglesactive == true then
				v59.gogglesactive = nil;
				return;
			else
				l__workspace__1.ServerStuff.handlePerkVisibility:FireServer("put_goggles");
				l__workspace__1.ServerStuff.playAudio:FireServer({ "perks" }, "goggles_on", character.HumanoidRootPart);
				if v59.gogglebroken then
					v59.gogglebroken = nil;
				end;
				v59.gogglesactive = true;
				local v1206 = l__game__7.ReplicatedStorage.effects.goggleslight:Clone();
				v1206.Parent = character.Head;
				local v1207 = Instance.new("Frame");
				v1207.BorderSizePixel = 0;
				v1207.BackgroundColor3 = Color3.new(0.8, 0, 0);
				v1207.Size = UDim2.new(1, 0, 1, 0);
				v1207.ZIndex = 1000;
				v1207.Parent = maingui;
				spawn(function()
					while true do
						v1207.BackgroundTransparency = v1207.BackgroundTransparency + 0.025;
						RS:wait();
						if v1207.BackgroundTransparency >= 1 then
							break;
						end;					
					end;
					v1207:Destroy();
				end);
				if v59.gogglegui == nil then
					local v1208 = l__game__7.ReplicatedStorage.misc.goggles:Clone();
					v59.gogglegui = v1208;
				else
					v1208 = v59.gogglegui;
				end;
				v1208.Parent = ply.PlayerGui;
				spawn(function()
					local v1209 = l__game__7.ReplicatedStorage.effects.gogglesfx:Clone();
					for v1210, v1211 in ipairs(v1209:GetChildren()) do
						v1211.Parent = l__CurrentCamera__1;
					end;
					v1209:Destroy();
					if v60[3].cooldown <= tick() - u111 then
						local v1212 = tick() - v60[3].cooldown;
					else
						v1212 = u111;
					end;
					local u145 = v1212;
					function v59.goggletakedamage(p128)
						u145 = u145 + p128 * v60[3].damage_taken_multi;
						local v1213 = math.random(1, 6);
						if p128 >= 20 then
							v1213 = 1;
						elseif p128 >= 10 then
							v1213 = math.random(1, 3);
						end;
						if v1213 == 1 and v1208 then
							v101({ "perks" }, "goggles_glass", nil, nil, true, true);
							local v1214 = v1208.crackfx:Clone();
							v1214.Name = "cracked";
							v1214.Position = UDim2.new(math.random(0, 100) / 100, 0, math.random(0, 100) / 100, 0);
							v1214.Rotation = math.random(1, 360);
							v1214.Visible = true;
							v1214.Parent = v1208;
						end;
						if tick() - u111 <= 0 then
							v59.goggletakedamage = nil;
							if v1208 then
								v1208.destroyed.Visible = true;
								v1208.destroyedsub.Visible = true;
								v1208.destroyedtext.Visible = true;
							end;
						end;
					end;
					if v59.gogglebounties == nil then
						v59.gogglebounties = 0;
						function v59.gogglehandledamage(p129)
							if p129 == "del" or p129 == "removedamage" then
								u21 = u21 - v60[3].boostonkill * v59.gogglebounties / 100;
								if p129 == "del" then
									v59.gogglebounties = 0;
								end;
								maingui.PerkFrame.numberstat.Visible = false;
								return;
							end;
							if p129 ~= "add" then
								if p129 == "addatstart" then
									u21 = u21 + v60[3].boostonkill * v59.gogglebounties / 100;
								end;
								return;
							end;
							v59.gogglebounties = v59.gogglebounties + 1;
							u21 = u21 + v60[3].boostonkill / 100;
							maingui.PerkFrame.numberstat.Text = v59.gogglebounties;
						end;
					end;
					maingui.PerkFrame.numberstat.Visible = true;
					maingui.PerkFrame.numberstat.Text = v59.gogglebounties;
					v59.gogglehandledamage("addatstart");
					local v1215 = tick();
					local v1216 = { "4452726587", "4452726886", "4452727160", "4452727454" };
					local v1217 = 1;
					local v1218 = 0;
					while true do
						RS:wait();
						if v1208 and tick() - v1218 >= 0.1 then
							v1218 = tick();
							v1208.static.Image = "rbxassetid://" .. v1216[v1217];
							v1217 = v1217 + 1;
							if v1217 >= 5 then
								v1217 = 1;
							end;
						end;
						for v1219, v1220 in ipairs(l__workspace__1.activeHostiles:GetChildren()) do
							if v1220:FindFirstChild("Humanoid") and v1220:FindFirstChild("Torso") and v1220:FindFirstChild("Humanoid").Health > 0 and v1220:FindFirstChild("ai_type") then
								if v1220:FindFirstChild("gogglefx") then
									if tick() - u111 <= 0 then
										v1220:FindFirstChild("gogglefx").Enabled = false;
									else
										v1220:FindFirstChild("gogglefx").Enabled = true;
										v1220.gogglefx.integrityamount.Text = tostring(math.floor(v1220.Humanoid.Health / v1220.Humanoid.MaxHealth * 100)) .. "%";
									end;
								elseif tick() - u111 > 0 then
									local v1221 = l__game__7.ReplicatedStorage.misc.gogglefx:Clone();
									local v1222 = { "Assault", "Murder", "Theft", "Grand Theft", "Petty Theft", "Tresspassing", "Vandalism", "Pickpocketing", "Rioting", "Insubordination", "Indecent Exposure", "Resisting Arrest", "Manslaughter", "Sabotage", "Narcotics Use", "Narcotics Distribution" };
									local v1223 = 1;
									if math.random(1, 3) == 1 then
										v1223 = 2;
										if math.random(1, 3) == 1 then
											v1223 = 3;
										end;
									end;
									local v1224 = {};
									for v1225 = 1, v1223 do
										local v1226 = math.random(1, #v1222);
										table.remove(v1222, v1226);
										v1224[v1225] = v1222[v1226];
									end;
									if v1220:FindFirstChild("ai_type").Value == "BossScavGuard" then
										v1224[1] = "Dereliction of Agency";
										v1224[2] = "Murder";
									elseif v1220:FindFirstChild("ai_type").Value == "BossScav" then
										v1224[1] = "Betrayal of Agency";
										v1224[2] = "Dereliction of Agency";
										v1224[3] = "Murder";
									end;
									for v1227, v1228 in pairs(v1224) do
										v1221["wanted" .. v1227].Visible = true;
										v1221["wanted" .. v1227].Text = v1228;
									end;
									v1221.integrityamount.Text = tostring(math.floor(v1220.Humanoid.Health / v1220.Humanoid.MaxHealth)) .. "%";
									v1221.Parent = v1220;
									v1221.Adornee = v1220.Torso;
									v1220.Humanoid.Died:connect(function()
										if v1221 then
											v1221:Destroy();
										end;
									end);
								end;
							elseif v1220:FindFirstChild("gogglefx") then
								v1220:FindFirstChild("gogglefx"):Destroy();
							end;
						end;
						for v1229, v1230 in ipairs(l__workspace__1.activeFriendlies:GetChildren()) do
							if v1230:FindFirstChild("gogglefx") then
								v1230:FindFirstChild("gogglefx"):Destroy();
							end;
						end;
						u111 = u145 + tick() - v1215;
						if hum.Health <= 0 then
							break;
						end;
						if v59.gogglesactive == nil then
							break;
						end;					
					end;
					l__workspace__1.ServerStuff.handlePerkVisibility:FireServer("hide_perk");
					l__workspace__1.ServerStuff.playAudio:FireServer({ "perks" }, "goggles_off", character.HumanoidRootPart);
					if tick() - u111 <= 0 then
						u111 = tick();
						v59.gogglebroken = true;
						v59.gogglegui:Destroy();
						v59.gogglegui = nil;
					else
						v59.gogglegui.Parent = nil;
					end;
					if v59.gogglebounties > 0 then
						u38(math.ceil(v60[3].scrap_per_bounty * v59.gogglebounties), "CLAIMED BOUNTY");
					end;
					v59.gogglehandledamage("del");
					local v1231 = Instance.new("Frame");
					v1231.BorderSizePixel = 0;
					v1231.BackgroundColor3 = Color3.new(0, 0, 0);
					v1231.Size = UDim2.new(1, 0, 1, 0);
					v1231.ZIndex = 1000;
					v1231.Parent = maingui;
					spawn(function()
						while true do
							v1231.BackgroundTransparency = v1231.BackgroundTransparency + 0.025;
							RS:wait();
							if v1231.BackgroundTransparency >= 1 then
								break;
							end;						
						end;
						v1231:Destroy();
					end);
					for v1232, v1233 in ipairs(l__CurrentCamera__1:GetChildren()) do
						if v1233.Name == "gogglesFX" then
							v1233:Destroy();
						end;
					end;
					for v1234, v1235 in ipairs(l__workspace__1.activeHostiles:GetChildren()) do
						if v1235:FindFirstChild("gogglefx") then
							v1235:FindFirstChild("gogglefx").Enabled = false;
						end;
					end;
					v59.gogglesactive = nil;
					v59.goggletakedamage = nil;
					v1206:Destroy();
				end);
				return;
			end;
		end;
		if p126 == "scan" then
			local v1236 = nil;
			local v1237 = nil;
			local v1238 = nil;
			local v1239 = nil;
			local v1240 = nil;
			local v1241 = nil;
			local v1242 = nil;
			local v1243 = nil;
			local v1244 = nil;
			local v1245 = nil;
			local v1246 = nil;
			local v1247 = nil;
			local v1248 = nil;
			local v1249 = nil;
			local v1250 = nil;
			local v1251 = nil;
			local v1252 = nil;
			local v1253 = nil;
			local v1254 = nil;
			local v1255 = nil;
			local v1256 = nil;
			local v1257 = nil;
			local v1258 = nil;
			local v1259 = nil;
			local v1260 = nil;
			if v1187:FindFirstChild("neonfx") then
				v1187:FindFirstChild("neonfx").Material = Enum.Material.Neon;
				v1187:FindFirstChild("neonfx").BrickColor = BrickColor.new("Bright orange");
			end;
			local v1261 = false;
			local v1262 = 0;
			v1185:AdjustSpeed(0);
			v1186:AdjustSpeed(0);
			while true do
				u142 = tick();
				if v60[3].scan_around_timer <= tick() - v1262 then
					v1262 = tick();
					v101({ "perks" }, "scannerpulse", nil, nil, true, true);
					applygore("selfscan");
				end;
				if u59 == true and v60[3].cooldown <= tick() - u111 then
					v1261 = true;
				end;
				RS:wait();
				if u112 == false then
					break;
				end;
				if v1261 == true then
					break;
				end;			
			end;
			v1185:AdjustSpeed(1);
			v1186:AdjustSpeed(1);
			if v1261 == true then
				if v60[3].cooldown <= tick() - u111 then
					u111 = tick();
					l__workspace__1.ServerStuff.playAudio:FireServer({ "perks" }, "scannerstart", character.HumanoidRootPart);
					l__workspace__1.ServerStuff.playAudio:FireServer({ "perks" }, "scannerscan", character.HumanoidRootPart);
					if v1187:FindFirstChild("neonfx") then
						v1187:FindFirstChild("neonfx").Material = Enum.Material.Neon;
						v1187:FindFirstChild("neonfx").BrickColor = BrickColor.new("Bright blue");
					end;
					l__workspace__1.ServerStuff.handlePerkVisibility:FireServer("scan_fx");
					local v1263 = l__CurrentCamera__1.CFrame + l__CurrentCamera__1.CFrame.lookVector * v60[3].front;
					l__workspace__1.ServerStuff.dealDamage:FireServer("prophetscan", v1263, v5, v4);
					l__workspace__1.ServerStuff.applyGore:FireServer("scanarea", character, ply, { v1263 });
					return;
				end;
				v1241 = v101;
				v1237 = {};
				v1236 = "general";
				v1240 = v1236;
				v1239 = 1;
				v1238 = v1237;
				v1238[v1239] = v1240;
				local v1264 = "keyboard";
				v1242 = nil;
				v1243 = nil;
				v1244 = true;
				v1245 = true;
				v1246 = v1241;
				v1247 = v1237;
				v1248 = v1264;
				v1249 = v1242;
				v1250 = v1243;
				v1251 = v1244;
				v1252 = v1245;
				v1246(v1247, v1248, v1249, v1250, v1251, v1252);
				local v1265 = v1187;
				local v1266 = "neonfx";
				v1254 = "FindFirstChild";
				v1253 = v1265;
				local v1267 = v1253;
				v1255 = v1265;
				v1256 = v1254;
				local v1268 = v1255[v1256];
				v1257 = v1268;
				v1258 = v1267;
				v1259 = v1266;
				local v1269 = v1257(v1258, v1259);
				v1260 = v1269;
				if v1260 then
					v1187:FindFirstChild("neonfx").Material = Enum.Material.SmoothPlastic;
					v1187:FindFirstChild("neonfx").BrickColor = BrickColor.new("Black");
					return;
				end;
			else
				v1241 = v101;
				v1237 = {};
				v1236 = "general";
				v1240 = v1236;
				v1239 = 1;
				v1238 = v1237;
				v1238[v1239] = v1240;
				v1264 = "keyboard";
				v1242 = nil;
				v1243 = nil;
				v1244 = true;
				v1245 = true;
				v1246 = v1241;
				v1247 = v1237;
				v1248 = v1264;
				v1249 = v1242;
				v1250 = v1243;
				v1251 = v1244;
				v1252 = v1245;
				v1246(v1247, v1248, v1249, v1250, v1251, v1252);
				v1265 = v1187;
				v1266 = "neonfx";
				v1254 = "FindFirstChild";
				v1253 = v1265;
				v1267 = v1253;
				v1255 = v1265;
				v1256 = v1254;
				v1268 = v1255[v1256];
				v1257 = v1268;
				v1258 = v1267;
				v1259 = v1266;
				v1269 = v1257(v1258, v1259);
				v1260 = v1269;
				if v1260 then
					v1187:FindFirstChild("neonfx").Material = Enum.Material.SmoothPlastic;
					v1187:FindFirstChild("neonfx").BrickColor = BrickColor.new("Black");
					return;
				end;
			end;
		else
			if p126 == "lazarus" then
				l__workspace__1.ServerStuff.playAudio:FireServer({ "perks" }, "laz_dart", character.HumanoidRootPart);
				if v60[3].cooldown <= tick() - u111 then
					u111 = tick() - (v60[3].cooldown - v60[3].multicooldown);
				else
					u111 = u111 + v60[3].multicooldown;
				end;
				local v1270, v1271 = raycastline(l__CurrentCamera__1.CFrame.p, l__CurrentCamera__1.CFrame.LookVector, v60[3].lazarus_shoot_range, baselayer);
				l__workspace__1.ServerStuff.dealDamage:FireServer("lazarus_device", v1271, v5, v4);
				l__workspace__1.ServerStuff.applyGore:FireServer("lazarus_fire", character, ply, { v1271 });
				l__workspace__1.ServerStuff.applyGore:FireServer("lazarus_laser", character, ply, { v1187.bolt.Position, v1271 });
				return;
			end;
			if p126 == "fire" then
				v1187.neonpart1.Material = Enum.Material.Neon;
				v1187.neonpart1.BrickColor = BrickColor.new("Neon orange");
				v1187.neonpart2.BrickColor = BrickColor.new("Neon orange");
				v1187.neonpart3.BrickColor = BrickColor.new("Neon orange");
				v1187.neonpart1.FlameSpurt.Enabled = true;
				v1187.neonpart1.FlameSpurt:Emit(math.random(10, 20));
				v101({ "perks" }, "flamer_equip", nil, nil, true, true);
				u142 = tick();
				delay(0.3, function()
					u142 = tick();
					if u112 ~= true then
						globalanimsets.perk_fire_immolate:Play(0.3);
						tpglobalanimsets.perk_fire_immolate:Play(0.3);
						delay(0.3, function()
							u142 = tick();
							u22 = u22 - 50;
							globalanimsets.perk_fire_immolate:AdjustSpeed(0);
							tpglobalanimsets.perk_fire_immolate:AdjustSpeed(0);
							while true do
								u142 = tick();
								RS:wait();
								if u9.air == false then
									break;
								end;
								if hum.Health <= 0 then
									break;
								end;
								if u9.staggering == true then
									break;
								end;							
							end;
							u142 = tick() - 0.4;
							globalanimsets.perk_fire_immolate:AdjustSpeed(1.4);
							tpglobalanimsets.perk_fire_immolate:AdjustSpeed(1.2);
							u22 = u22 + 50;
							if hum.Health > 0 and u9.staggering == false then
								l__workspace__1.ServerStuff.playAudio:FireServer({ "perks" }, "flamer_punch", character.HumanoidRootPart);
								delay(0.2, function()
									shakecamera("abilityshake");
									l__workspace__1.ServerStuff.dealDamage:FireServer("immolate", character, v5, v4);
									v59.apply_overheat(v60[3].immolate_overheat, false);
									afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).FireBuff);
									l__workspace__1.ServerStuff.applyGore:FireServer("immolate_ability", character, ply, { character.Torso.CFrame - character.Torso.CFrame.upVector * 3 });
								end);
							end;
						end);
						return;
					end;
					v101({ "perks" }, "flamer_prep", nil, nil, true, true);
					globalanimsets.perk_fire_thrower:Play(0.3);
					tpglobalanimsets.perk_fire_flamer:Play(0.3);
					delay(0.35, function()
						u142 = tick();
						for v1272, v1273 in ipairs(v1187.neonpart1:GetChildren()) do
							if v1273:IsA("ParticleEmitter") and v1273.Name ~= "Steam" then
								v1273.Enabled = true;
							end;
						end;
						v1187.neonpart1.EmberSpark:Emit(math.random(10, 20));
						v1187.neonpart1.FlameSpark:Emit(math.random(10, 20));
						u22 = u22 - v60[3].flamer_slowdown;
						globalanimsets.perk_fire_thrower:AdjustSpeed(0);
						tpglobalanimsets.perk_fire_flamer:AdjustSpeed(0);
						local v1274 = 0;
						local v1275 = tick();
						if v60[3].cooldown <= tick() - u111 then
							local v1276 = tick() - v60[3].cooldown;
						else
							v1276 = u111;
						end;
						l__workspace__1.ServerStuff.playAudio:FireServer({ "perks" }, "flamer_fire", character.HumanoidRootPart);
						l__workspace__1.ServerStuff.dealDamage:FireServer("flamer_effect", nil, v5, v4);
						while true do
							u90 = CFrame.new(math.random(-10, 10) / 500, math.random(-10, 10) / 500, math.random(-10, 10) / 500);
							if v60[3].flamer_burn_tick <= tick() - v1274 then
								v1274 = tick();
								v1276 = v59.apply_overheat(v60[3].flamer_overheat, false);
								local v1277 = false;
								local v1278 = l__CurrentCamera__1.CFrame + l__CurrentCamera__1.CFrame.lookVector * (v60[3].flamer_range - 1);
								local v1279 = {};
								for v1280, v1281 in ipairs(l__workspace__1.activeHostiles:GetChildren()) do
									if v1281:FindFirstChild("Torso") and v1281:FindFirstChild("Head") and v1281:FindFirstChild("Humanoid") and v1281.Humanoid.Health > 0 and (v1281.Torso.Position - v1278.p).magnitude <= v60[3].flamer_range then
										table.insert(v1279, v1281);
										u43(v1281.Head.Position, v60[3].flamer_burn_damage);
										if v1277 == false then
											v1277 = true;
											v140();
										end;
									end;
								end;
								if #v1279 > 0 then
									l__workspace__1.ServerStuff.dealDamage:FireServer("flamer_ignite", v1279, v5, v4);
								end;
							end;
							if character:FindFirstChild("arm_flame") and (character:FindFirstChild("arm_flame"):FindFirstChild("Flame") and character:FindFirstChild("arm_flame").Flame.Enabled == true) then
								for v1282, v1283 in ipairs(character:FindFirstChild("arm_flame"):GetDescendants()) do
									if v1283:IsA("ParticleEmitter") then
										v1283:Clear();
										v1283.Enabled = false;
									end;
								end;
							end;
							u111 = v1276 + tick() - v1275;
							u142 = tick();
							RS:wait();
							if hum.Health <= 0 then
								break;
							end;
							if u9.staggering == true then
								break;
							end;
							if u112 == false and tick() - v1275 >= 0.5 then
								break;
							end;						
						end;
						l__workspace__1.ServerStuff.dealDamage:FireServer("flamer_off", nil, v5, v4);
						l__workspace__1.ServerStuff.playAudio:FireServer({ "perks" }, "flamer_disable", character.HumanoidRootPart);
						tpglobalanimsets.perk_fire_flamer:AdjustSpeed(1);
						if hum.Health > 0 then
							v1187.neonpart1.FlameSpurt:Emit(math.random(10, 20));
							for v1284, v1285 in ipairs(v1187.neonpart1:GetChildren()) do
								if v1285:IsA("ParticleEmitter") then
									v1285.Enabled = false;
								end;
							end;
							v1187.neonpart1.Steam.Enabled = true;
							u90 = CFrame.new(0, 0, 0);
							u142 = tick() - 0.4;
							globalanimsets.perk_fire_thrower:AdjustSpeed(1);
							u22 = u22 + v60[3].flamer_slowdown;
						end;
					end);
				end);
				return;
			end;
			if p126 == "gunner" then
				if v60[3].cooldown <= tick() - u111 then
					local v1286 = tick() - v60[3].cooldown;
				else
					v1286 = u111;
				end;
				l__workspace__1.ServerStuff.handlePerkVisibility:FireServer("minigun_spin");
				local v1287 = tick();
				local v1288 = tick();
				local v1289 = 0;
				local v1290 = tick();
				v1186:AdjustSpeed(0);
				v1185:AdjustSpeed(0);
				local v1291 = v101({ "perks" }, "mini_firing_loop", nil, nil, nil, true);
				u9.channel = true;
				u22 = u22 - v60[3].vulka_slowdown;
				local v1292 = 0;
				local v1293 = true;
				for v1294, v1295 in ipairs(maingui.Centre.crosshair:GetChildren()) do
					v1295.Visible = false;
				end;
				local v1296 = l__game__7.ReplicatedStorage.misc.minigun_crosshair:Clone();
				v1296.Parent = maingui;
				while not (hum.Health <= 0) do
					local v1297 = CFrame.new(v1187.minigun_base.Position);
					v1187.minigun_base.spin.C0 = CFrame.new(-2.90581346, -0.340348721, 0.0228784084, 0.999992788, -3.7252903E-08, -1.11758709E-07, 1.04308128E-07, 0.707102299, -0.707102299, -9.17007483E-08, 0.707107484, 0.707107484) * CFrame.Angles(v1292 + 1, 0, 0);
					u142 = tick();
					if u59 == true and v60[3].vulka_overheat_duration <= tick() - v1289 then
						v1291.Volume = 1.5;
						if 60 / v60[3].vulka_rpm <= tick() - v1288 then
							local v1298 = "light";
							if u72 == true then
								v1298 = "indoors";
							end;
							if v1293 == true then
								local v1299 = v101({ "perks" }, "mini_shoot", nil, nil, nil, true);
								v1299.Volume = 1.5;
								if u72 == true then
									v1299.Volume = 2;
								end;
								v1293 = false;
							end;
							v1187.ejection.casings:Emit(1);
							v101({ "firearms" }, "ballistic_" .. v1298, nil, nil, true, true);
							v101({ "firearms" }, "bass", nil, nil, true, true);
							l__workspace__1.ServerStuff.dealDamage:FireServer("gunsareloud", nil, v5, v4);
							delay(math.random(40, 80) / 100, function()
								l__workspace__1.ServerStuff.playAudio:FireServer({ "firearms" }, "casing_heavy", character.HumanoidRootPart, 0.15);
							end);
							l__workspace__1.ServerStuff.playAudio:FireServer({ "perks" }, "mini_shoot", character.HumanoidRootPart, 0.05);
							globalanimsets.perk_minigun_fire:Play(0);
							shakecamera("gunrecoil", { 2 });
							shakecamera("guntilt", { 2 });
							v1286 = v1286 + v60[3].vulka_ammo_usage;
							v1288 = tick();
							local v1300 = (v60[3].vulka_accuracy - (v60[3].vulka_accuracy - 1.5) * math.clamp((tick() - v1290) / v60[3].vulka_accuracy_timer, 0, 1)) * 10;
							local v1301 = Vector3.new(0, 0, 0);
							local u146 = l__CurrentCamera__1.CFrame.p;
							local u147 = Vector3.new(math.rad(math.random(-v1300, v1300)), math.rad(math.random(-v1300, v1300)), math.rad(math.random(-v1300, v1300))) / 10;
							local u148 = { character, l__workspace__1.NoTarget, l__workspace__1.GoreEffects, l__CurrentCamera__1, teamfolder, l__workspace__1.PlayerShootThroughs, l__workspace__1.activeFriendlies };
							local u149 = v1301;
							local u150 = false;
							local u151 = nil;
							spawn(function()
								for v1302 = 1, 5 do
									local v1303, v1304 = raycastline(u146, l__CurrentCamera__1.CFrame.LookVector + u147, v60[3].vulka_range, u148);
									local v1305 = v60[3].vulka_damage;
									trigger_map_item_func(v1303, "gundamage", v1305);
									u149 = v1304;
									l__workspace__1.ServerStuff.applyGore:FireServer("firegun", character, ply, { v1187.muzzle.Position, v1304, u150, nil, u151 });
									if not v1303 then
										break;
									end;
									if not v1303.Parent:FindFirstChild("Humanoid") then
										break;
									end;
									if not (v1303.Parent:FindFirstChild("Humanoid").Health > 0) then
										break;
									end;
									if not v1303.Parent:FindFirstChild("Head") then
										break;
									end;
									if not v1303.Parent:IsDescendantOf(l__workspace__1.activeHostiles) then
										break;
									end;
									if v1303.Parent:FindFirstChild("perks") and v1303.Parent:FindFirstChild("perks"):FindFirstChild("thick") then
										v1305 = v1305 - v1305 * v7.thick.efx[1] / 100;
									end;
									u43(v1303.Parent.Head.Position, v1305);
									v140();
									l__workspace__1.ServerStuff.dealDamage:FireServer("vulka_minigun", { v1303.Parent, v1305 }, v5, v4);
									l__workspace__1.ServerStuff.applyGore:FireServer("bloodhit", v1303.Parent, nil, { v1305, v1304 });
									u146 = v1304;
									table.insert(u148, v1303.Parent);
									u151 = true;
									u150 = true;
									RS:wait();
								end;
								if u10["Immolator Buff"] then
									l__workspace__1.ServerStuff.applyGore:FireServer("incendiary_trail", character, ply, { v1187.muzzle.Position, u149 });
								end;
							end);
							if tick() - u111 <= 30 then
								v101({ "firearms" }, "mech", nil, nil, true, true);
							end;
						end;
					else
						if v1293 == false then
							v1187.muzzle.vfx.Enabled = true;
							delay(1, function()
								v1187.muzzle.vfx.Enabled = false;
							end);
							globalanimsets.perk_minigun_overheat:Play(0.1);
							maingui.PerkFrame.durationbar.fill.Size = UDim2.new(1, 0, 1, 0);
							v1293 = true;
							v1289 = tick();
							l__workspace__1.ServerStuff.playAudio:FireServer({ "perks" }, "mini_overheat", character.HumanoidRootPart, 0.05);
						end;
						v1290 = tick();
						v1291.Volume = 0;
					end;
					if tick() - v1290 > 0 then
						local v1306 = 40 * math.clamp((tick() - v1290) / v60[3].vulka_accuracy_timer, 0, 1);
						v1296.CH.circle.Size = UDim2.new(0, 50 - v1306, 0, 50 - v1306);
					else
						v1296.CH.circle.Size = UDim2.new(0, 50, 0, 50);
					end;
					if tick() - v1289 <= v60[3].vulka_overheat_duration then
						maingui.PerkFrame.durationbar.Visible = true;
						maingui.PerkFrame.durationbar.fill.Size = UDim2.new(1 - math.clamp((tick() - v1289) / v60[3].vulka_overheat_duration, 0, 1), 0, 1, 0);
					else
						maingui.PerkFrame.durationbar.Visible = false;
					end;
					u111 = v1286 + tick() - v1287;
					RS:wait();
					if u112 == true and tick() - v1287 >= 0.5 then
						break;
					end;
					if tick() - u111 <= 0 then
						break;
					end;
					if u9.staggering == true then
						break;
					end;				
				end;
				l__workspace__1.ServerStuff.handlePerkVisibility:FireServer("minigun_spin");
				maingui.PerkFrame.durationbar.Visible = false;
				v1296:Destroy();
				v1291:Destroy();
				if hum.Health > 0 then
					for v1307, v1308 in ipairs(maingui.Centre.crosshair:GetChildren()) do
						v1308.Visible = true;
					end;
					l__workspace__1.ServerStuff.playAudio:FireServer({ "perks" }, "mini_end", character.HumanoidRootPart);
					if tick() - u111 <= 0 then
						v101({ "firearms" }, "empty", nil, nil, true, true);
						u111 = tick();
					end;
					globalanimsets.perk_minigun_overheat:Stop(0);
					globalanimsets.perk_minigun_fire:Stop(0);
					u22 = u22 + v60[3].vulka_slowdown;
					if u9.staggering == false then
						u9.channel = false;
						v1186:AdjustSpeed(1);
						v1185:AdjustSpeed(1);
						return;
					end;
				end;
			elseif p126 == "hive" then
				local v1309 = tick();
				local v1310 = 0;
				v1186:AdjustSpeed(0);
				v1185:AdjustSpeed(0);
				u9.channel = true;
				for v1311, v1312 in ipairs(maingui.Centre.crosshair:GetChildren()) do
					v1312.Visible = false;
				end;
				v101({ "perks" }, "hive_cancel", nil, nil, true, true);
				v1187.text.spark:Emit(math.random(10, 20));
				v1187.text.flash:Emit(1);
				v1187.spinner.Transparency = 0.3;
				v1187.text.billboard.Enabled = true;
				if v59.hive_mode == nil then
					v59.hive_mode = "Disperse";
					maingui.PerkFrame.numberstat.Visible = true;
					maingui.PerkFrame.numberstat.Text = string.upper(v59.hive_mode);
				end;
				v1187.text.billboard.directive.Text = string.upper(v59.hive_mode);
				local v1313 = false;
				while not (hum.Health <= 0) do
					v1187.spin.C0 = v1187.spin.C0 * CFrame.Angles(math.rad(3), 0, 0);
					u142 = tick();
					if u59 == true and v60[3].cooldown <= tick() - u111 then
						v1313 = true;
						if globalanimsets["perk_hive_" .. v59.hive_mode] then
							globalanimsets["perk_hive_" .. v59.hive_mode]:Play(0.1);
						end;
						tpglobalanimsets.perk_hive_cast:Play();
						l__workspace__1.ServerStuff.playAudio:FireServer({ "perks" }, "hive_cast", character.HumanoidRootPart);
						u142 = tick();
						u111 = tick();
						l__workspace__1.ServerStuff.dealDamage:FireServer("send_hive", v59.hive_mode, v5, v4);
						break;
					end;
					if u74 == true and tick() - v1310 >= 0.3 then
						v101({ "perks" }, "hive_snap", nil, nil, true, true);
						globalanimsets.perk_hive_snap:Play(0.1);
						v1310 = tick();
						if v59.hive_mode == "Disperse" then
							v59.hive_mode = "Divide";
						elseif v59.hive_mode == "Divide" then
							v59.hive_mode = "Direct";
						elseif v59.hive_mode == "Direct" then
							v59.hive_mode = "Disperse";
						end;
						maingui.PerkFrame.numberstat.Text = string.upper(v59.hive_mode);
						v1187.text.billboard.directive.Text = string.upper(v59.hive_mode);
					end;
					RS:wait();
					if u112 == true and tick() - v1309 >= 0.5 then
						break;
					end;
					if tick() - u111 <= 0 then
						break;
					end;
					if u9.staggering == true then
						break;
					end;				
				end;
				v1187.text.spark:Emit(math.random(10, 20));
				v1187.text.flash:Emit(1);
				v1187.spinner.Transparency = 1;
				v1187.text.billboard.Enabled = false;
				if v1313 == false then
					v101({ "perks" }, "hive_cancel", nil, nil, true, true);
				end;
				if v59.hive_loop_sound then
					v59.hive_loop_sound:Destroy();
				end;
				if hum.Health > 0 then
					for v1314, v1315 in ipairs(maingui.Centre.crosshair:GetChildren()) do
						v1315.Visible = true;
					end;
					globalanimsets.perk_minigun_overheat:Stop(0);
					globalanimsets.perk_minigun_fire:Stop(0);
					if u9.staggering == false then
						u9.channel = false;
						v1186:AdjustSpeed(1);
						v1185:AdjustSpeed(1);
						return;
					end;
				end;
			else
				if p126 == "revolver" then
					l__workspace__1.ServerStuff.playAudio:FireServer({ "perks" }, "revolver_armed", character.HumanoidRootPart, 0.05);
					v1187.spin_fx.Transparency = 1;
					local v1316 = tick();
					while true do
						RS:wait();
						if tick() - v1316 >= 0.6 then
							break;
						end;					
					end;
					delay(0.3, function()
						l__workspace__1.ServerStuff.handlePerkVisibility:FireServer("hide_perk");
						for v1317, v1318 in ipairs(maingui.Centre.crosshair:GetChildren()) do
							v1318.Visible = true;
						end;
						if maingui:FindFirstChild("revolver_crosshair") then
							maingui:FindFirstChild("revolver_crosshair"):Destroy();
						end;
					end);
					local v1319 = "medium";
					if u72 == true then
						v1319 = "indoors";
					end;
					v101({ "firearms" }, "ballistic_" .. v1319, nil, nil, true, true);
					v101({ "firearms" }, "bass", nil, nil, true, true);
					l__workspace__1.ServerStuff.dealDamage:FireServer("gunsareloud", nil, v5, v4);
					l__workspace__1.ServerStuff.playAudio:FireServer({ "perks" }, "revolver_shoot", character.HumanoidRootPart, 0.05);
					local v1320, v1321 = raycastline(l__CurrentCamera__1.CFrame.p, l__CurrentCamera__1.CFrame.LookVector, v60[3].revolver_range, baselayer);
					local v1322 = nil;
					local v1323 = false;
					if v1320 and v1320.Parent:FindFirstChild("Humanoid") and v1320.Parent:FindFirstChild("Humanoid").Health > 0 and v1320.Parent:FindFirstChild("Head") and v1320.Parent:IsDescendantOf(l__workspace__1.activeHostiles) then
						local v1324 = v60[3].revolver_damage;
						trigger_map_item_func(v1320, "gundamage", v1324);
						if v1320.Name == "Head" then
							v1324 = v60[3].revolver_damage * v60[3].revolver_headshot_multi;
							if v1320.Parent:FindFirstChild("Humanoid").Health - v1324 <= 0 then
								v1323 = true;
							end;
						end;
						u43(v1320.Parent.Head.Position, v1324);
						v140();
						v1322 = true;
						l__workspace__1.ServerStuff.dealDamage:FireServer("revolver_shot", { v1320.Parent, v1324 }, v5, v4);
						l__workspace__1.ServerStuff.applyGore:FireServer("bloodhit", v1320.Parent, nil, { v1324, v1321 });
					end;
					shakecamera("gunrecoil", { 7 });
					shakecamera("guntilt", { 7 });
					l__workspace__1.ServerStuff.applyGore:FireServer("firegun", character, ply, { v1187.muzzle.Position, v1321, false, v1322 });
					local v1325 = 0;
					if v1323 == true then
						v101({ "perks" }, "revolver_buff", nil, nil, true, true);
						afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).ArtiB);
						v1325 = v60[3].revolver_cooldown_reduce_on_kill;
						spawn(function()
							local v1326 = l__game__7.ReplicatedStorage.misc.StimFlash:Clone();
							v1326.ImageColor3 = Color3.new(0.5, 0, 0.7);
							v1326.Parent = maingui;
							while true do
								v1326.ImageTransparency = v1326.ImageTransparency + 0.05;
								v1326.Size = v1326.Size + UDim2.new(0, 1, 0, 1);
								RS:wait();
								if v1326.ImageTransparency >= 1 then
									break;
								end;							
							end;
							v1326:Destroy();
						end);
					end;
					u111 = tick() - v1325;
					return;
				end;
				if p126 == "shotgun" then
					u111 = tick();
					u142 = tick();
					u112 = false;
					local l__buffer_f_key__1327 = v59.buffer_f_key;
					local v1328 = false;
					l__workspace__1.ServerStuff.playAudio:FireServer({ "perks" }, "shotshell_fire", character.HumanoidRootPart);
					while true do
						if u112 == true and l__buffer_f_key__1327 == true then
							v1328 = true;
							break;
						end;
						RS:wait();
						if v60[3].blast_punch_window <= tick() - u142 then
							break;
						end;					
					end;
					local v1329 = (l__CurrentCamera__1.CFrame + l__CurrentCamera__1.CFrame.lookVector * (v60[3].blast_forward + 1)).p;
					local v1330 = nil;
					if v1328 == true then
						local v1331 = l__game__7.ReplicatedStorage.misc.shotshell_white_flash:Clone();
						v1331.Parent = maingui;
						l__Debris__27:AddItem(v1331, 5);
						v101({ "perks" }, "shotshell_punch_ding", nil, nil, true, true);
						globalanimsets.perk_shotgun_punch:Play(0);
						v1187.muzzle.flash.Enabled = true;
						local v1332 = tick();
						while true do
							u142 = tick();
							RS:wait();
							if tick() - v1332 >= 0.3 then
								break;
							end;						
						end;
						v1187.muzzle.flash.Enabled = false;
						spawn(function()
							while v1331 ~= nil do
								v1331.BackgroundTransparency = v1331.BackgroundTransparency + 0.1;
								RS:wait();
								if v1331 == nil then
									break;
								end;
								if v1331.BackgroundTransparency >= 1 then
									break;
								end;							
							end;
							v1331:Destroy();
						end);
						l__workspace__1.ServerStuff.playAudio:FireServer({ "perks" }, "shotshell_punch_hit", character.HumanoidRootPart);
						local v1333, v1334 = raycastline(l__CurrentCamera__1.CFrame.p, l__CurrentCamera__1.CFrame.LookVector, v60[3].blast_punch_range, baselayer);
						v1329 = v1334;
						if (character.HumanoidRootPart.Position - v1334).magnitude <= v60[3].blast_range * v60[3].blast_punch_multiplier * 0.8 then
							character.HumanoidRootPart.Velocity = character.HumanoidRootPart.Velocity - l__CurrentCamera__1.CFrame.LookVector * v60[3].blast_knockback;
						end;
						v1330 = v1187.muzzle.Position;
					end;
					character.HumanoidRootPart.Velocity = character.HumanoidRootPart.Velocity - l__CurrentCamera__1.CFrame.LookVector * v60[3].blast_knockback;
					l__workspace__1.ServerStuff.applyGore:FireServer("firegun", character, ply, { v1187.muzzle.Position, v1329, nil, nil });
					l__workspace__1.ServerStuff.dealDamage:FireServer("shotshell", { v1329, v1330 }, v5, v4);
					l__workspace__1.ServerStuff.applyGore:FireServer("shotshell_blast", character, ply, { v1329, v1330 });
					delay(0.6, function()
						v1187.shell_ejection.shell:Emit(1);
						v101({ "perks" }, "shotshell_pump", nil, nil, true, true);
					end);
					return;
				end;
				if p126 == "ranger" then
					if tick() - u111 < v60[3].multicooldown or u112 == true then
						tpglobalanimsets.perk_izbucni_det:Play(0.1, 1, 1);
						l__workspace__1.ServerStuff.playAudio:FireServer({ "perks" }, "giftdet", character.HumanoidRootPart);
						globalanimsets.perk_izbucni_det:Play(0.1, 1, 1);
						delay(0.1, function()
							l__workspace__1.ServerStuff.dealDamage:FireServer("izbucni_detonate", nil, v5, v4);
						end);
						return;
					else
						if v60[3].cooldown <= tick() - u111 then
							u111 = tick() - (v60[3].cooldown - v60[3].multicooldown);
						else
							u111 = u111 + v60[3].multicooldown;
						end;
						local v1335 = 0;
						if u143.fuse ~= nil then
							v1335 = u143.fuse;
						end;
						v1186:Play(0.1);
						l__workspace__1.ServerStuff.playAudio:FireServer({ "perks" }, "giftthrow", character.HumanoidRootPart);
						l__workspace__1.ServerStuff.dealDamage:FireServer("izbucni", { l__CurrentCamera__1.CFrame + l__CurrentCamera__1.CFrame.lookVector * 1, v1335 }, v5, v4);
						return;
					end;
				end;
				if p126 == "sword" then
					l__workspace__1.ServerStuff.playAudio:FireServer({ "perks" }, "bladeswing", character.HumanoidRootPart);
					delay(0.3, function()
						if v1187:FindFirstChild("trail") then
							v1187:FindFirstChild("trail").Enabled = false;
						end;
					end);
					delay(0.7, function()
						l__workspace__1.ServerStuff.handlePerkVisibility:FireServer("hide_perk");
						l__workspace__1.ServerStuff.playAudio:FireServer({ "perks" }, "bladesheath", character.HumanoidRootPart);
					end);
					local v1336 = math.ceil(v60[3].kiramindamage + (v60[3].kiramaxdamage - v60[3].kiramindamage) * (math.clamp(tick() - u111, 1, v60[3].cooldown) / v60[3].cooldown));
					local v1337 = l__CurrentCamera__1.CFrame + l__CurrentCamera__1.CFrame.lookVector * (v60[3].frontradius - 1);
					local v1338 = false;
					local v1339 = true;
					local v1340 = {};
					for v1341, v1342 in ipairs(l__workspace__1.activeHostiles:GetChildren()) do
						if v1342:FindFirstChild("Torso") and v1342:FindFirstChild("Head") and v1342:FindFirstChild("Humanoid") and v1342.Humanoid.Health > 0 and (v1342.Torso.Position - v1337.p).magnitude <= v60[3].frontradius then
							local v1343 = v1339;
							v1339 = false;
							if v1342:FindFirstChild("Humanoid").Health - v1336 <= 0 then
								v1343 = true;
								v1339 = true;
							end;
							if v1343 == true then
								table.insert(v1340, v1342);
								u43(v1342.Head.Position, v1336);
								if v1338 == false then
									v1338 = true;
									v140();
								end;
							end;
						end;
					end;
					if #v1340 > 0 then
						l__workspace__1.ServerStuff.dealDamage:FireServer("kirablade", { v1340, v1336 }, v5, v4);
					end;
					if u112 == true and v59.dogtags and v59.dogtags > 0 and hum.Health < hum.MaxHealth then
						delay(0.1, function()
							delay(0.1, function()
								v101({ "perks" }, "bladeclean", nil, nil, true, true);
							end);
							v59.losetags(v60[3].dogtagsheavydamage, true);
							delay(0.15, function()
								v1187.blade.dust:Emit(math.random(10, 20));
							end);
							if v59.dogtags <= 0 then
								v1187.blade.sprayA.Transparency = 1;
								v1187.blade.sprayB.Transparency = 1;
								v1187.blade.sprayB.Transparency = 1;
								v1187.blade.sprayB.Transparency = 1;
							end;
							globalanimsets.perk_kira_clean:Play(0.1, 1, 0.9);
						end);
					end;
					spawn(function()
						local v1344 = tick();
						while true do
							u111 = tick();
							RS:wait();
							if tick() - v1344 >= 0.2 then
								break;
							end;						
						end;
						local v1345 = 0;
						if v59.dogtags ~= nil and v59.dogtags > 0 then
							v1187.blade.sprayA.Transparency = 0;
							v1187.blade.sprayB.Transparency = 0;
							v1187.blade.sprayB.Transparency = 0;
							v1187.blade.sprayB.Transparency = 0;
							v1187.blade.Color = Color3.fromRGB(223, 200, 219);
							v1345 = math.clamp(v60[3].dogtagreduction * v59.dogtags, v60[3].dogtagreduction, v60[3].cooldown - v60[3].mincooldown);
						end;
						u111 = tick() - v1345;
					end);
					return;
				end;
				if p126 == "shield" then
					if u112 == true then
						v1186:AdjustSpeed(0);
						v1185:AdjustSpeed(0);
						local u152 = tick();
						function v59.aegisshieldup(p130)
							if v1187 == nil then
								return;
							end;
							v101({ "perks" }, "aegisstruck", nil, nil, true, true);
							v1187.barrier2.impactfx.Enabled = true;
							v1187.barrier2.impactfx:Emit(1);
							v1187.barrier2.impactfx.Enabled = false;
							globalanimsets.perk_aegisstruck:Play(0, 1, 1);
							u152 = u152 - p130;
						end;
						l__workspace__1.ServerStuff.handlePerkVisibility:FireServer("enable_aegis_shield");
						l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", "1PB" }, "flash", character.HumanoidRootPart);
						v1187.barrier2.flash.Enabled = true;
						v1187.barrier2.flash:Emit(20);
						v1187.barrier2.flash.Enabled = false;
						v1187.barrier1.flash.Enabled = true;
						v1187.barrier1.flash:Emit(20);
						v1187.barrier1.flash.Enabled = false;
						v1187.barrier1.electric.Enabled = true;
						v1187.barrier2.electric.Enabled = true;
						v1187.barrier1.Transparency = 0;
						v1187.barrier2.Transparency = 0;
						u20 = u20 + v60[3].aegisdefenseboost;
						l__workspace__1.ServerStuff.initiateblock:FireServer(v5, true);
						maingui.PerkFrame.durationbar.Visible = true;
						maingui.PerkFrame.durationbar.fill.Size = UDim2.new(1, 0, 1, 0);
						while true do
							u111 = tick();
							u142 = tick();
							maingui.PerkFrame.durationbar.fill.Size = UDim2.new(1 - math.clamp((tick() - u152) / v60[3].aegisduration, 0, 1), 0, 1, 0);
							RS:wait();
							if u112 == false then
								break;
							end;
							if v60[3].aegisduration <= tick() - u152 then
								break;
							end;						
						end;
						l__workspace__1.ServerStuff.handlePerkVisibility:FireServer("disable_aegis_shield");
						maingui.PerkFrame.durationbar.Visible = false;
						v1187.barrier1.electric:Clear();
						v1187.barrier2.electric:Clear();
						v1187.barrier1.electric.Enabled = false;
						v1187.barrier2.electric.Enabled = false;
						v1186:AdjustSpeed(1);
						v1185:AdjustSpeed(1);
						l__workspace__1.ServerStuff.initiateblock:FireServer(v5, false);
						u20 = u20 - v60[3].aegisdefenseboost;
						globalanimsets.perk_aegisstruck:Stop(0);
						l__workspace__1.ServerStuff.playAudio:FireServer({ "perks" }, "aegisbreak", character.HumanoidRootPart);
						v59.aegisshieldup = nil;
						v1187.barrier1.Transparency = 1;
						v1187.barrier2.Transparency = 1;
						v1187.barrier2.breakeffect.Enabled = true;
						v1187.barrier2.breakeffect:Emit(math.random(20, 30));
						v1187.barrier2.breakeffect.Enabled = false;
						v1187.barrier1.breakeffect.Enabled = true;
						v1187.barrier1.breakeffect:Emit(math.random(20, 30));
						v1187.barrier1.breakeffect.Enabled = false;
						return;
					else
						local v1346 = false;
						local v1347, v1348 = raycastline((character.HumanoidRootPart.CFrame + character.HumanoidRootPart.CFrame.lookVector * 3).p, -character.HumanoidRootPart.CFrame.upVector, 4, baselayer);
						if v1347 and u9.air == false then
							v1346 = true;
							if raycastline((character.HumanoidRootPart.CFrame - character.HumanoidRootPart.CFrame.upVector * 3).p, character.HumanoidRootPart.CFrame.lookVector, 4, baselayer) then
								v1346 = false;
							end;
						end;
						if v1346 == true then
							l__workspace__1.ServerStuff.handlePerkVisibility:FireServer("hide_perk");
							l__workspace__1.ServerStuff.dealDamage:FireServer("placeaegisturret", nil, v5, v4);
							spawn(function()
								local v1349 = tick();
								maingui.PerkFrame.durationbar.Visible = true;
								maingui.PerkFrame.durationbar.fill.Size = UDim2.new(1, 0, 1, 0);
								local v1350 = tick();
								while true do
									u111 = tick();
									maingui.PerkFrame.durationbar.fill.Size = UDim2.new(1 - math.clamp((tick() - v1349) / v60[3].turretduration, 0, 1), 0, 1, 0);
									if tick() - v1350 >= 0.5 and u112 == true then
										break;
									end;
									RS:wait();
									if v60[3].turretduration <= tick() - v1349 then
										break;
									end;								
								end;
								maingui.PerkFrame.durationbar.Visible = false;
								l__workspace__1.ServerStuff.dealDamage:FireServer("removeaegisturret", nil, v5, v4);
							end);
							return;
						end;
					end;
				elseif p126 == "trapper" then
					local v1351 = 0;
					for v1352, v1353 in ipairs(l__workspace__1.Interactables:GetChildren()) do
						if v1353.Name == "TICKS" .. ply.Name then
							v1351 = v1351 + 1;
						end;
					end;
					if v1351 < v60[3].maxticks then
						v1186:Play(0.1);
						if v60[3].cooldown <= tick() - u111 then
							u111 = tick() - (v60[3].cooldown - v60[3].multicooldown);
						else
							u111 = u111 + v60[3].multicooldown;
						end;
						l__workspace__1.ServerStuff.playAudio:FireServer({ "perks" }, "tickthrow", character.HumanoidRootPart);
						l__workspace__1.ServerStuff.dealDamage:FireServer("throwticks", { l__CurrentCamera__1.CFrame + l__CurrentCamera__1.CFrame.lookVector * 1, u112 }, v5, v4);
						return;
					end;
				elseif p126 == "mind" then
					v1187:Destroy();
					v1186:Play(0.1);
					if v60[3].cooldown <= tick() - u111 then
						u111 = tick() - (v60[3].cooldown - v60[3].reducecooldown);
					else
						u111 = u111 + v60[3].reducecooldown;
					end;
					l__workspace__1.ServerStuff.playAudio:FireServer({ "perks" }, "mind_hop", character.HumanoidRootPart);
					l__workspace__1.ServerStuff.dealDamage:FireServer("dropmkiller", l__CurrentCamera__1.CFrame + l__CurrentCamera__1.CFrame.lookVector * 1, v5, v4);
					return;
				elseif p126 == "dagger" then
					v1187:Destroy();
					tpglobalanimsets.throw:Play(0.1);
					l__workspace__1.ServerStuff.playAudio:FireServer({ "perks" }, "sov_target", character.HumanoidRootPart);
					spawn(function()
						local v1354, v1355 = raycastline(l__CurrentCamera__1.CFrame.p, l__CurrentCamera__1.CFrame.LookVector, 80, baselayer);
						l__workspace__1.ServerStuff.applyGore:FireServer("bowarrow", character, ply, { l__CurrentCamera__1.CFrame, Vector3.new(0, 0, 0) });
						if v1354 == nil then
							local v1356 = v1355;
							for v1357 = 1, 200 do
								local v1358 = nil;
								local v1359 = nil;
								v1359, v1358 = raycastline(v1356, l__CurrentCamera__1.CFrame.LookVector + Vector3.new(0, -0.05, 0), 3, baselayer);
								if v1359 then
									v1355 = v1358;
									v1354 = v1359;
									break;
								end;
								v1356 = v1358;
								RS:wait();
							end;
						end;
						local v1360 = nil;
						if v1354 and v1354.Parent:FindFirstChild("Humanoid") and v1354.Parent:FindFirstChild("Humanoid").Health > 0 and v1354.Parent:FindFirstChild("Head") and v1354.Parent:IsDescendantOf(l__workspace__1.activeHostiles) then
							v140();
							v1360 = v1354;
						end;
						if v1354 and v1355 then
							l__workspace__1.ServerStuff.dealDamage:FireServer("sov_dagger", { v1360, v1355 }, v5, v4);
						end;
					end);
				end;
			end;
		end;
	end;
	local u153 = nil;
	u153 = v1185.KeyframeReached:connect(function(p131)
		if p131 == "activate_Perk" then
			u144();
			u153:Disconnect();
		end;
	end);
	v1185:Play(0.03, 1, 1);
	while true do
		RS:wait();
		if v60[3].activeend <= tick() - u142 then
			break;
		end;	
	end;
	u9.using_perk = false;
	u153:Disconnect();
	v1185:Stop(0.3);
	if v1187 then
		l__workspace__1.ServerStuff.handlePerkVisibility:FireServer("hide_perk");
		v1187:Destroy();
	end;
	u9.action = false;
end;
local v1361 = UIS.InputBegan:connect(function(p132, p133)
	if p133 == true or spectating == true then
		return;
	end;
	local l__KeyCode__1362 = p132.KeyCode;
	if hum.Health <= 0 then
		return;
	end;
	if l__KeyCode__1362 == Enum.KeyCode.R and u17.weapontype == "Bow" and u9.action == false and u19.arrow.arrow1.Transparency == 1 then
		u124();
	end;
	if l__KeyCode__1362 == Enum.KeyCode.Z and hum.Health > 0 then
		if tick() - ping_cooldown <= 0.2 then
			return;
		end;
		if tick() - ping_chill <= ping_chill_timer and ping_chll_limit <= ping_amt then
			ping_chill = tick();
			return;
		end;
		u125();
	end;
	if l__KeyCode__1362 == Enum.KeyCode.LeftShift and u9.sprinting == false then
		u126 = true;
		while RS:wait() do
			if u9.sprinting == false and u9.walking == true and u9.staggering == false and u9.channel == false and juggernaut == false and u9.sliding == false then
				u127();
			end;
			if u126 == false then
				break;
			end;		
		end;
	end;
	if l__KeyCode__1362 == Enum.KeyCode.W and u30.w == false then
		u30.w = true;
	end;
	if l__KeyCode__1362 == Enum.KeyCode.Space then
		u128();
	end;
	if l__KeyCode__1362 == Enum.KeyCode.Zero then
		decider_reset();
		while true do
			RS:wait();		
		end;
	end;
	if l__KeyCode__1362 == Enum.KeyCode.H then
		reset_arms();
	end;
	if l__KeyCode__1362 == Enum.KeyCode.V and akimbo_factors.active == false and u9.action == false then
		start_dual_wield();
	end;
	if l__KeyCode__1362 == Enum.KeyCode.B then
		commend_player();
	end;
	if l__KeyCode__1362 == Enum.KeyCode.T and hum.Health > 0 then
		if u129 == false then
			u129 = true;
		end;
		UIS.MouseIconEnabled = true;
		maingui.TabMenu.Visible = true;
		maingui.TabMenu.Size = UDim2.new(1, 0, 0, 0);
		local v1363 = nil;
		local v1364 = nil;
		if u9.action == false and u9.aiming == false then
			v1364 = l__game__7.ReplicatedStorage.misc.agentdevice:Clone();
			local v1365 = Instance.new("Motor6D");
			v1365.Part0 = fparms.LeftArm.LUpperArm;
			v1365.Part1 = v1364;
			v1365.Parent = v1364;
			v1364.Parent = l__CurrentCamera__1;
			v101({ "weapons", "Item" }, "trackeractive", nil, nil, true, true);
			v1363 = globalanimsets.tabmenu;
			v1363:Play(0.1);
			local u154 = nil;
			u154 = v1363.KeyframeReached:connect(function(p134)
				if p134 == "Stop" then
					v1363:AdjustSpeed(0);
					u154:Disconnect();
				end;
			end);
		end;
		spawn(function()
			local v1366 = false;
			while true do
				if (u9.action == true or u9.aiming == true) and v1366 == false and v1363 ~= nil then
					v1366 = true;
					v1363:Stop(0);
					v1364:Destroy();
				end;
				maingui.TabMenu.Size = maingui.TabMenu.Size:Lerp(UDim2.new(1, 0, 1, 0), 0.1);
				maingui.TabMenu.bg.night_label.Text = "// NIGHT " .. l__workspace__1.ServerStuff.game.currentNight.Value .. " //";
				if l__workspace__1.ServerStuff.game.nightTimer.Value ~= 0 then
					maingui.TabMenu.bg.time_label.Text = "STORM.WATCH = " .. u130(math.clamp(l__workspace__1.ServerStuff.game.nightTimer.Value, 0, 1000));
				else
					maingui.TabMenu.bg.time_label.Text = "STORM.WATCH = ERROR";
				end;
				if character and character:FindFirstChild("Torso") and character:FindFirstChild("HumanoidRootPart") then
					local v1367 = (l__workspace__1.minimapcentre.Position - character.Torso.Position) / 1.5;
					maingui.TabMenu.bg.map.player_icon.spinicon.Rotation = -character.HumanoidRootPart.Orientation.y;
					maingui.TabMenu.bg.map.player_icon.Position = UDim2.new(0.5, v1367.x, 0.5, v1367.z);
				end;
				if maingui.TabMenu.bg.ammodroptab.Visible == true then
					for v1368, v1369 in ipairs(maingui.TabMenu.bg.ammodroptab:GetChildren()) do
						if u64[v1369.Name] then
							v1369.count.Text = u64[v1369.Name];
						end;
					end;
				end;
				if maingui.TabMenu.bg.rationstab.Visible == true then
					for v1370, v1371 in ipairs(maingui.TabMenu.bg.rationstab:GetChildren()) do
						if ration_system_handler[v1371.Name] then
							v1371.contents.Text = ">CONTENTS IN SATCHEL: " .. ration_system_handler[v1371.Name];
						end;
					end;
				end;
				if maingui.TabMenu.bg.scraptab.Visible == true then
					local v1372 = scrap_drop_amount;
					if scrap_drop_amount <= 0 then
						v1372 = "NONE";
					elseif u16 <= scrap_drop_amount then
						v1372 = "ALL";
					end;
					maingui.TabMenu.bg.scraptab.dropamt.Text = ">DROPPING: " .. v1372;
				end;
				if maingui.TabMenu.bg.weaponinfotab.Visible == true then
					local l__weaponinfotab__1373 = maingui.TabMenu.bg.weaponinfotab;
					l__weaponinfotab__1373.error_found.Visible = false;
					l__weaponinfotab__1373.founditem.Visible = true;
					local v1374 = { "ABUNDANT", "COMMON", "UNCOMMON", "RARE", "LIMITED" };
					if u17.weapontype == "Bludgeon" or u17.weapontype == "Blade" or u17.weapontype == "Axe" or u17.weapontype == "Spear" then
						l__weaponinfotab__1373.founditem.line1.Text = ">SPECIFICATION: " .. string.upper(u17.weapontype);
						l__weaponinfotab__1373.founditem.line2.Text = ">LETHALITY: " .. string.upper(u17.damagerating[1]) .. "%";
						l__weaponinfotab__1373.founditem.line3.Text = ">STRIKE_LETHALITY: " .. string.upper(u17.damagerating[2]) .. "%";
						l__weaponinfotab__1373.founditem.line4.Text = ">WEIGHT_LIGHT_SWING: " .. tostring(25 * u17.speedrating) .. "%";
						l__weaponinfotab__1373.founditem.line5.Text = ">WEIGHT_HEAVY_SWING: " .. tostring(25 * u17.chargerating) .. "%";
						l__weaponinfotab__1373.founditem.line6.Text = ">EFFECTIVE_RANGE: " .. tostring(25 * u17.sizerating + 100) .. "%";
						l__weaponinfotab__1373.founditem.line7.Text = ">WOUNDING_LEVEL: " .. tostring(25 * u17.woundrating + 100) .. "%";
						if u17.rarity ~= nil and v1374[u17.rarity] ~= nil then
							l__weaponinfotab__1373.founditem.line8.Text = ">WEAPON_RARITY: " .. v1374[u17.rarity];
						else
							l__weaponinfotab__1373.founditem.line8.Text = "";
						end;
					elseif u17.weapontype == "Gun" then
						l__weaponinfotab__1373.founditem.line1.Text = ">SPECIFICATION: FIREARM";
						l__weaponinfotab__1373.founditem.line2.Text = ">LIMB_LETHALITY: " .. string.upper(u17.damagerating[3]) .. "%";
						l__weaponinfotab__1373.founditem.line3.Text = ">HEADSHOT_LEHTALITY: " .. string.upper(u17.damagerating[4]) .. "%";
						l__weaponinfotab__1373.founditem.line4.Text = ">ROUNDS_PER_MINUTE: " .. tostring(math.ceil(60 / u17.speedrating));
						l__weaponinfotab__1373.founditem.line5.Text = ">EFFECTIVE_RECOIL: " .. tostring(u17.woundrating * 5) .. "%";
						l__weaponinfotab__1373.founditem.line6.Text = ">FIREARM_INACCURACY: " .. tostring(100 - u17.sizerating * 5) .. "%";
						if u17.auto ~= nil then
							l__weaponinfotab__1373.founditem.line7.Text = ">SEMI_AUTOMATIC: " .. string.upper(tostring(not u17.auto));
						else
							l__weaponinfotab__1373.founditem.line7.Text = ">SEMI_AUTOMATIC: ERROR";
						end;
						if u17.rarity then
							l__weaponinfotab__1373.founditem.line8.Text = ">FIREARM_RARITY: " .. v1374[u17.rarity];
						else
							l__weaponinfotab__1373.founditem.line8.Text = "";
						end;
					else
						l__weaponinfotab__1373.error_found.Visible = true;
						l__weaponinfotab__1373.founditem.Visible = false;
					end;
				end;
				RS:wait();
				if u129 == false then
					break;
				end;
				if hum.Health <= 0 then
					break;
				end;			
			end;
			UIS.MouseIconEnabled = false;
			if v1366 == false and v1363 ~= nil then
				v1363:Stop(0.1);
				v1364:Destroy();
			end;
			maingui.TabMenu.Size = UDim2.new(1, 0, 0, 0);
			maingui.TabMenu.Visible = false;
		end);
	end;
	if l__KeyCode__1362 == Enum.KeyCode.P then
		if maingui.Enabled == false then
			maingui.Enabled = true;
		else
			maingui.Enabled = false;
		end;
	end;
	if l__KeyCode__1362 == Enum.KeyCode.R and u9.action == false and u17.weapontype == "Gun" then
		u131();
	end;
	if l__KeyCode__1362 == Enum.KeyCode.G and u9.action == false and u17.weapontype == "Gun" then
		unloadgun();
	end;
	if l__KeyCode__1362 == Enum.KeyCode.C then
		if playerstats.Class == "damn" or akimbo_factors.active == true then
			return;
		end;
		aux_held = true;
		if aux_usage > 0 then
			use_aux();
		end;
	end;
	if l__KeyCode__1362 == Enum.KeyCode.LeftControl and u9.staggering == false then
		crouch_held = true;
		if u9.sprinting == true and tick() - slide_wait >= 1 then
			u9.sprinting = false;
			u9.sneaking = false;
			drop_slide();
		elseif u9.sneaking == false then
			u32();
		end;
	end;
	if l__KeyCode__1362 == Enum.KeyCode.R and u9.action == false and u9.blocking == false and (u17.weapontype == "Bludgeon" or u17.weapontype == "Blade" or u17.weapontype == "Axe" or u17.weapontype == "Spear" or u17.weapontype == "Fists") then
		if u17.weapontype == "Fists" and playerperks.honor == nil then
			return;
		end;
		u134();
	end;
	if l__KeyCode__1362 == Enum.KeyCode.Q then
		if u9.action ~= false then
			if (u9.action == true and u9.cancombo == true or u9.blockrecoil == true) and u9.blocking == false then
				u135();
			elseif v59.aegisshieldup ~= nil then
				u135();
			end;
		elseif u9.blocking == false then
			u135();
		elseif v59.aegisshieldup ~= nil then
			u135();
		end;
	end;
	if l__KeyCode__1362 == Enum.KeyCode.A and u30.a == false then
		u30.a = true;
	end;
	if l__KeyCode__1362 == Enum.KeyCode.S and u30.s == false then
		u30.s = true;
	end;
	if l__KeyCode__1362 == Enum.KeyCode.E and influence_taps ~= 0 then
		influence_taps = influence_taps + 1;
		v101({ "shadow", "hang" }, "resist", nil, nil, true, true);
	end;
	if l__KeyCode__1362 == Enum.KeyCode.E and u9.action == false and u9.channel == false and u9.throwing == false and u103 and u10.Silencer == nil and juggernaut ~= true and l__workspace__1.ServerStuff.game.disableInteraction.Value == false then
		if typeof(u103) ~= "table" then
			if u103 == u136 then
				return;
			end;
			if tick() - e_pickup_lockout <= 0.65 then
				return;
			end;
			e_pickup_lockout = tick();
			u136 = u103;
			local v1375 = v18[u103.Name];
			local v1376 = "Item";
			if v1375.weapontype == "Bludgeon" or v1375.weapontype == "Axe" or v1375.weapontype == "Spear" or v1375.weapontype == "Blade" then
				v1376 = "Primary";
			end;
			drawlockout = tick();
			local v1377 = l__workspace__1.ServerStuff.claimItem:InvokeServer(u103);
			while true do
				RS:wait();
				if v1377 == true then
					break;
				end;
				if v1377 == false then
					break;
				end;			
			end;
			if v1377 == false then
				return;
			end;
			if u17.name == v1375.name and u19:FindFirstChild("ammo") and u19.ammo:FindFirstChild("maxammo") then
				local v1378 = 0;
				for v1379, v1380 in pairs(v6) do
					if v1380[2] == true then
						v1378 = v1380[3];
					end;
				end;
				local l__Value__1381 = u103.ammo.Value;
				l__workspace__1.ServerStuff.refillAmmo:FireServer(u19.ammo.maxammo.Value - v1378, u103);
				if l__Value__1381 - (u19.ammo.maxammo.Value - v1378) <= 0 then
					u103:Destroy();
				end;
				for v1382 = 1, #v6 do
					if v6[v1382][2] == true then
						v6[v1382][3] = math.clamp(v6[v1382][3] + l__Value__1381, 0, u19.ammo.maxammo.Value);
					end;
				end;
				u19.ammo.Value = math.clamp(u19.ammo.Value + l__Value__1381, 0, u19.ammo.maxammo.Value);
				u61(u19.Name);
				invmanage("updatehud");
				return;
			end;
			local v1383 = nil;
			if v1376 == "Primary" then
				if v6[1][1] == "Fist" then
					v6[1][1] = u103.name;
					v1383 = 1;
				end;
			else
				for v1384, v1385 in pairs(v6) do
					if v1385[1] == "Fist" and v1384 ~= 1 then
						v1385[1] = u103.name;
						if u103:FindFirstChild("ammo") then
							v1385[3] = u103.ammo.Value;
						end;
						v1383 = v1384;
						break;
					end;
				end;
			end;
			invmanage("swap", { v1383, false });
			u61(u103.Name, u103);
		else
			if u16 < u102 then
				maingui.Thought.thoughttext.Text = "I need " .. u102 .. " salvage for that.";
				inner_dialogue = tick();
				return;
			end;
			if u103 == nil or u103[1] == nil then
				return;
			end;
			if tick() - u137 <= 0.2 then
				return;
			end;
			if u103[1] ~= "craft" then
				if u103[1].stats.interactable.Value == false then
					return;
				end;
				if u103[1].stats.instant.Value == true then
					local v1386 = nil;
					local v1387 = nil;
					local v1388 = nil;
					local v1389 = nil;
					local v1390 = nil;
					local v1391 = nil;
					local v1392 = nil;
					local v1393 = nil;
					local v1394 = nil;
					local v1395 = nil;
					local v1396 = nil;
					if u103[1].Name == "Locker" or u103[1].Name == "Double Locker" then
						l__workspace__1.ServerStuff.adjustStats:FireServer("tracker", { "Lockers", 1 });
					end;
					l__game__7.ReplicatedStorage.Interactables.interaction:FireServer(u103[1], u103[1].stats.execname.Value, v5);
					if string.match(u103[1].Name, "Ammo") or u103[1].Name == "Scrap Pack" then
						u137 = tick();
						if u103[1] then
							u103[1]:Destroy();
						end;
					end;
					if u103[1].Name == "Spectate" then
						if l__workspace__1.ServerStuff.game.stage.Value ~= "gameinprogress" then
							return;
						else
							v101({ "general" }, "keyboard", nil, nil, true, true);
							local v1397 = l__game__7.ReplicatedStorage.misc.staticflash:Clone();
							v1397.static.Disabled = false;
							v1397.Parent = ply.PlayerGui;
							u9.action = true;
							u9.staggering = true;
							u9.turnable = false;
							u11 = 0.001;
							local v1398 = l__game__7.ReplicatedStorage.effects.endgamegui:Clone();
							v1398.status.Position = UDim2.new(0.5, 0, 1, 0);
							v1398.status.menu.Visible = true;
							v1398.status.spectate.Visible = false;
							v1398.Parent = ply.PlayerGui;
							v1398.Enabled = true;
							character.HumanoidRootPart.Anchored = true;
							ply.CameraMode = "Classic";
							UIS.MouseIconEnabled = true;
							maingui.Enabled = false;
							if l__workspace__1.ServerStuff.game.currentGamemode.Value ~= "survival" then
								forcespecfolder = true;
							end;
							spectatesystem(v1398);
							v1398.status.spectate.MouseButton1Click:connect(function()
								if v1398.status.spectate.Text == "RETURN TO HUB" then
									kickoutspec();
								end;
							end);
							v1398.status.menu.MouseButton1Click:connect(function()
								if u138 == true then
									return;
								end;
								u138 = true;
								while true do
									ply.PlayerGui.fadetoblack.frame.BackgroundTransparency = ply.PlayerGui.fadetoblack.frame.BackgroundTransparency - 0.03;
									RS:wait();
									if ply.PlayerGui.fadetoblack.frame.BackgroundTransparency <= 0 then
										break;
									end;								
								end;
								l__workspace__1.ServerStuff.spawnPlayer:FireServer("respawncharacter");
							end);
							v1398.status.spectate.Text = "RETURN TO HUB";
							v1386 = u103;
							v1387 = 1;
							v1388 = v1386;
							v1389 = v1387;
							v1390 = v1388[v1389];
							local v1399 = "Name";
							v1391 = v1390;
							v1392 = v1399;
							v1393 = v1391[v1392];
							local v1400 = "Sign Up";
							v1394 = v1393;
							v1395 = v1400;
							if v1394 == v1395 then
								l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "writing", character.HumanoidRootPart);
							end;
							local v1401 = nil;
							v1396 = v1401;
							u103 = v1396;
							return;
						end;
					else
						v1386 = u103;
						v1387 = 1;
						v1388 = v1386;
						v1389 = v1387;
						v1390 = v1388[v1389];
						v1399 = "Name";
						v1391 = v1390;
						v1392 = v1399;
						v1393 = v1391[v1392];
						v1400 = "Sign Up";
						v1394 = v1393;
						v1395 = v1400;
						if v1394 == v1395 then
							l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "writing", character.HumanoidRootPart);
						end;
						v1401 = nil;
						v1396 = v1401;
						u103 = v1396;
						return;
					end;
				end;
			elseif u103[1] == "craft" and (startperk.Value == "hubbing" or u16 < v44) then
				return;
			end;
			local v1402 = u103[1];
			local v1403 = u103[2];
			if v1402 == "craft" then
				local v1404 = 3.5;
				if playerperks.scrafter then
					v1404 = v1404 - v1404 * v7.scrafter.efx[1] / 100;
				end;
			else
				v1404 = v1402.stats.instant.timer.Value;
				if v1402.Name == "Scrapper" and (u17.weapontype == "Fists" or v60[1] == "goggles") then
					return;
				end;
			end;
			u59 = false;
			u74 = false;
			u9.action = true;
			u9.channel = true;
			u9.blocking = false;
			l__workspace__1.ServerStuff.initiateblock:FireServer(v5, false);
			u25(0.025);
			local v1405 = { globalanimsets.interact, tpglobalanimsets.interact };
			if v1402 == "craft" then
				v1405 = { globalanimsets.craft, tpglobalanimsets.craft };
			end;
			v1405[1]:Play(0.3);
			v1405[2]:Play(0.3);
			local v1406 = v1405[1].KeyframeReached:connect(function(p135)
				if p135 == "Stop" then
					v1405[1]:AdjustSpeed(0);
				end;
			end);
			local v1407 = v1405[2].KeyframeReached:connect(function(p136)
				if p136 == "Stop" then
					v1405[2]:AdjustSpeed(0);
				end;
			end);
			if v1402 ~= "craft" then
				u76(v1402.Name);
				if v1402.Name == "Medstation" then
					local v1408 = v101({ "general" }, "starthealing", nil, nil, true, true);
					l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "starthealing", v1402.Interact, nil, true);
				elseif v1402.Name == "Arsenal Locker" then
					v1408 = v101({ "general" }, "arsenallocker", nil, nil, true, true);
					l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "arsenallocker", v1402.Interact, nil, true);
				elseif v1402.Name == "S.A.N.C Barrel" then
					v1408 = v101({ "machinery" }, "sancuse", nil, nil, true, true);
					l__workspace__1.ServerStuff.playAudio:FireServer({ "machinery" }, "sancuse", v1402.Interact, nil, true);
				elseif v1402.stats:FindFirstChild("itemdisplayed") or v1402.Name == "Workbench" then
					v1408 = v101({ "machinery" }, "fabricator", nil, nil, true, true);
					l__workspace__1.ServerStuff.playAudio:FireServer({ "machinery" }, "fabricator", v1402.Interact, nil, true);
				elseif v1402.Name == "Scrapper" then
					v1408 = v101({ "machinery" }, "recycling", nil, nil, true, true);
					l__workspace__1.ServerStuff.playAudio:FireServer({ "machinery" }, "recycling", v1402.Interact, nil, true);
				elseif v1402.Name == "Airdrop Pad" then
					v1408 = v101({ "machinery" }, "airdroppad", nil, nil, true, true);
					l__workspace__1.ServerStuff.playAudio:FireServer({ "machinery" }, "airdroppad", v1402.Interact, nil, true);
				else
					v1408 = v101({ "general" }, "interaction", nil, nil, true, true);
					l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "interaction", v1402.Interact, nil, true);
				end;
			else
				u76(u103[3], "CRAFTING");
				v1408 = v101({ "general" }, "craft", nil, nil, true, true);
				v1408.Looped = true;
				if playerperks.stealth == nil then
					l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "craft", character.Head, nil, true);
				end;
			end;
			local v1409 = tick();
			local v1410 = false;
			if v1402 == "craft" then
				maingui.Centre.Craft.Visible = true;
			end;
			if v1402 ~= "craft" then
				local v1411 = v1402:FindFirstChild("Interact").Position;
			else
				v1411 = (l__CurrentCamera__1.CFrame + l__CurrentCamera__1.CFrame.lookVector * 3).p;
			end;
			while true do
				maingui.Centre.Craft.Rotation = maingui.Centre.Craft.Rotation + 1;
				if v1402 ~= "craft" then
					if v1402.Parent == nil then
						v1410 = true;
						break;
					end;
					if v1402:FindFirstChild("Interact") == nil then
						v1410 = true;
						break;
					end;
				elseif v1403.Parent == nil then
					v1410 = true;
					break;
				end;
				if not v1411 then
					v1410 = true;
					break;
				end;
				if (v1411 - character.HumanoidRootPart.Position).magnitude > 6.5 then
					break;
				end;
				maingui.ChargeOverlay.ChargeOverlay.Size = UDim2.new((tick() - v1409) / v1404, 0, 1, 0);
				RS:wait();
				if u59 == true then
					break;
				end;
				if v1404 <= tick() - v1409 then
					break;
				end;			
			end;
			maingui.Centre.Craft.Visible = false;
			v1408:Destroy();
			if v1410 == false and v1404 <= tick() - v1409 then
				if v1402 == "craft" then
					u19:Destroy();
					for v1412, v1413 in pairs(v6) do
						if v1413[2] == true then
							v1413[1] = "Fist";
							v1413[3] = nil;
						end;
					end;
					invmanage("updatehud");
					if playerperks.stealth == nil then
						l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "craftdone", character.Head);
					end;
					u38(-v44, "CRAFTING");
					l__workspace__1.ServerStuff.craftItem:FireServer(u17.name, v1403, v6[1][2], v5);
					v1406:Disconnect();
					v1407:Disconnect();
					maingui.ChargeOverlay.Visible = false;
					u103 = nil;
					v1405[1]:Stop(0.3);
					v1405[2]:Stop(0.3);
					u9.channel = false;
					u61("Fist");
					return;
				end;
				local v1414 = v1402.stats.execname.Value;
				if v1402.Name == "Workbench" and u17.chargerating == "blueprint" then
					v1414 = v1414 .. "blueprint" .. u17.damagerating[3];
					if v1402:FindFirstChild("fakeItem") then
						v1414 = "workbench";
					end;
				end;
				l__game__7.ReplicatedStorage.Interactables.interaction:FireServer(v1402, v1414, v5);
				if u102 > 0 then
					u38(-u102, "SALVAGE USED");
				end;
				if v1402.Name == "S.A.N.C Barrel" then
					u38(15, "SALVAGE");
				elseif v1402.Name == "KillSwitch Panel" then
					u38(30, "THE CHOKENING");
				end;
				if v1402.Name == "Scrapper" then
					if u17.weapontype == "Fist" then
						return;
					else
						local v1415 = 5;
						if u17.weapontype == "Spear" or u17.weapontype == "Bludgeon" or u17.weapontype == "Blade" or u17.weapontype == "Axe" then
							local v1416 = 3;
							if u17.rarity ~= nil then
								v1416 = 3 * u17.rarity;
							end;
							v1415 = 5 + v1416;
							if string.sub(u17.name, 1, 7) == "Crafted" then
								v1415 = 2;
							end;
						end;
						local v1417 = u17.woundrating;
						if u17.weapontype == "Bow" or u17.weapontype == "Gun" then
							v1417 = u17.chargerating;
						end;
						if u17.weapontype == "Item" or u17.weapontype == "Bow" or u17.weapontype == "Gun" then
							if u19:FindFirstChild("ammo") == nil or u19:FindFirstChild("ammo") and u19:FindFirstChild("ammo"):FindFirstChild("maxammo") == nil then
								local v1418 = -5 + 5 * v1417;
								if v1418 <= 0 then
									v1415 = 5;
									if v1417 == 0 then
										v1415 = 2;
									end;
								else
									v1415 = v1418 + 8;
								end;
							else
								local v1419 = 1;
								for v1420, v1421 in pairs(v6) do
									if v1421[2] == true then
										v1419 = v1421[3];
									end;
								end;
								local v1422 = 4 * v1417;
								if v1422 <= 0 then
									v1422 = 1;
								end;
								v1415 = math.floor(v1422 * v1419);
							end;
						end;
						u19:Destroy();
						for v1423, v1424 in pairs(v6) do
							if v1424[2] == true then
								v1424[1] = "Fist";
								v1424[3] = nil;
							end;
						end;
						invmanage("updatehud");
						u38(v1415, "RECYCLED INTO SALVAGE");
						l__workspace__1.ServerStuff.craftItem:FireServer(nil, nil, v6[1][2], v5, true);
						v1406:Disconnect();
						v1407:Disconnect();
						maingui.ChargeOverlay.Visible = false;
						u103 = nil;
						v1405[1]:Stop(0.3);
						v1405[2]:Stop(0.3);
						u9.channel = false;
						u61("Fist");
						return;
					end;
				end;
			end;
			v1406:Disconnect();
			v1407:Disconnect();
			maingui.ChargeOverlay.Visible = false;
			u103 = nil;
			v1405[1]:Stop(0.3);
			v1405[2]:Stop(0.3);
			curentanimset.equip.TimePosition = 0.5;
			curentanimset.equip:AdjustSpeed(0);
			tpcurrentanimset.equip:Play();
			tpcurrentanimset.equip.TimePosition = 0.5;
			tpcurrentanimset.equip:AdjustSpeed(0);
			check_walking_anim();
			u9.action = false;
			u9.channel = false;
		end;
	end;
	if emotelist == false then
		if juggernaut == true then
			return;
		end;
		if l__KeyCode__1362 == Enum.KeyCode.One or l__KeyCode__1362 == Enum.KeyCode.Two or l__KeyCode__1362 == Enum.KeyCode.Three or l__KeyCode__1362 == Enum.KeyCode.Four or l__KeyCode__1362 == Enum.KeyCode.Five or l__KeyCode__1362 == Enum.KeyCode.Six then
			if l__KeyCode__1362 == Enum.KeyCode.Five and v6[5] == nil or l__KeyCode__1362 == Enum.KeyCode.Six and v6[6] == nil then
				return;
			end;
			if l__workspace__1.ServerStuff.game.disableInteraction.Value == true then
				return;
			end;
			if tick() - drawlockout >= 0.3 and tick() - u60 >= 0.3 then
				invmanage("swap", { l__KeyCode__1362, true });
			end;
		end;
	elseif tauntchose[l__KeyCode__1362.Value - 48] ~= nil then
		u139(tauntchose[l__KeyCode__1362.Value - 48]);
	end;
	if l__KeyCode__1362 == Enum.KeyCode.D and u30.d == false then
		u30.d = true;
	end;
	if l__KeyCode__1362 == Enum.KeyCode.F then
		if u112 == false then
			u112 = true;
		end;
		if v59.buffer_f_key and v59.buffer_f_key == true then
			v59.buffer_f_key = false;
		end;
		if u9.action == false and u9.swapping == false and akimbo_factors.active == false and v60 and v60[1] ~= "survival" and v60[1] ~= "damn" then
			u140(v60[1]);
		end;
	end;
	if l__KeyCode__1362 == Enum.KeyCode.X then
		u60 = tick();
		if u18 ~= "Fist" and u9.channel == false and startperk.Value ~= "hiddenB" and u9.throwing == false and u9.action == false and u9.swapping == false and u9.sprinting == false then
			if l__workspace__1.ServerStuff.game.disableInteraction.Value == true then
				return;
			end;
			u96();
		end;
	end;
end);
local u155 = false;
local v1425 = UIS.InputEnded:connect(function(p137, p138)
	if p138 == true or spectating == true then
		return;
	end;
	p137 = p137.KeyCode;
	if p137 == Enum.KeyCode.LeftShift then
		u126 = false;
		u9.sprinting = false;
	end;
	if p137 == Enum.KeyCode.L and u155 == true then
		u155 = false;
	end;
	if p137 == Enum.KeyCode.W and u30.w == true then
		u30.w = false;
	end;
	if p137 == Enum.KeyCode.A and u30.a == true then
		u30.a = false;
	end;
	if p137 == Enum.KeyCode.S and u30.s == true then
		u30.s = false;
	end;
	if p137 == Enum.KeyCode.D and u30.d == true then
		u30.d = false;
	end;
	if p137 == Enum.KeyCode.F then
		u112 = false;
	end;
	if p137 == Enum.KeyCode.T then
		u129 = false;
	end;
	if p137 == Enum.KeyCode.LeftControl then
		crouch_held = false;
		if u9.sneaking == true then
			u9.sneaking = false;
		end;
	end;
	if p137 == Enum.KeyCode.C and aux_held == true then
		aux_held = false;
	end;
end);
local l__BaseSens__156 = playerstats.Settings.BaseSens;
local u157 = Vector2.new(0, 0);
UIS.InputChanged:connect(function(p139, p140)
	if p140 == true then
		return;
	end;
	if p139.UserInputType == Enum.UserInputType.MouseMovement and u9.turnable == true then
		local l__Delta__1426 = p139.Delta;
		u157 = u157 - Vector2.new(math.rad(l__Delta__1426.X), math.rad(l__Delta__1426.Y)) * l__BaseSens__156 * 0.25 * u79;
		if u157.Y < math.rad(-80) or math.rad(80) < u157.Y then
			u157 = u157 + Vector2.new(0, math.rad(l__Delta__1426.Y) * l__BaseSens__156 * 0.25 * u79);
		end;
	end;
end);
local function u158()
	if u9.action == true then
		return;
	end;
	if tick() - u45 < 0.3 then
		return;
	end;
	if curentanimset["swingvar" .. tostring(u46)] == nil or tpcurrentanimset.swing == nil then
		return;
	end;
	u9.action = true;
	u9.swinging = true;
	u9.cancombo = false;
	if u8 > 0 then
		u8 = u8 - 2;
	end;
	u25(nil);
	u26("stamina");
	local v1427 = curentanimset["swingvar" .. tostring(u46)];
	local v1428 = 0.6 * u47;
	local v1429 = 0.075 * u17.speedrating;
	if u8 == 0 or u10.Fracture then
		v1429 = 0;
	end;
	if u46 == 3 then
		v1428 = v1428 - 0.1;
	end;
	v1427:Play(0.2, 1, v1428 + v1429);
	local v1430 = tpcurrentanimset.swing;
	if tpcurrentanimset.swing2 and math.random(1, 2) == 1 then
		v1430 = tpcurrentanimset.swing2;
	end;
	if v1430 == nil then
		u9.action = false;
		u9.swinging = false;
		u9.cancombo = false;
		return;
	end;
	v1430:Play(0.1);
	local v1431 = false;
	shakecamera("weapon", { current_anim_set_use, v1427.Name });
	l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", current_anim_set_use }, v1427.Name, character.HumanoidRootPart, v1429 / 10);
	if u17.animset == "1PB" then
		l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", current_anim_set_use }, "swinglaser", character.HumanoidRootPart, v1429 / 10);
	end;
	if u10["Immolator Buff"] then
		l__workspace__1.ServerStuff.playAudio:FireServer({ "perks" }, "flamer_swing", character.HumanoidRootPart, 0.05);
	end;
	while true do
		u25(nil);
		if v1427:GetTimeOfKeyframe("Hit") <= v1427.TimePosition and v1431 == false then
			v1431 = true;
			local v1432 = u17.damagerating[1];
			if u46 == 3 then
				v1432 = u17.damagerating[1] * 2;
			end;
			local v1433 = u48(v1432);
			local u159 = false;
			delay(0.1, function()
				if u9.staggering == false then
					u159 = true;
				end;
			end);
		end;
		RS:wait();
		if v1427.isPlaying == false then
			break;
		end;
		if u9.staggering == true then
			break;
		end;
		if false == true then
			break;
		end;	
	end;
	u9.swinging = false;
	u9.cancombo = true;
	u14.stamregen = 0;
	u14.regentick = 0;
	if tpcurrentanimset.swing then
		tpcurrentanimset.swing:Stop(0.45);
	end;
	if v1427 ~= nil then
		v1427:Stop(0.45);
	end;
	if u9.staggering == false then
		curentanimset.equip.TimePosition = 0.5;
		curentanimset.equip:AdjustSpeed(0);
		tpcurrentanimset.equip:Play();
		tpcurrentanimset.equip.TimePosition = 0.5;
		tpcurrentanimset.equip:AdjustSpeed(0);
		check_walking_anim();
		u9.action = false;
	end;
end;
local function u160()
	local v1434 = 0;
	for v1435, v1436 in pairs(v6) do
		if v1436[2] == true then
			v1434 = v1436[3];
		end;
	end;
	if akimbo_factors.active == true and akimbo_factors.alternate == true then
		v1434 = v6[akimbo_factors.weapon_slot][3];
	end;
	if v1434 <= 0 then
		if akimbo_factors.active == true then
			akimbo_factors.alternate = not akimbo_factors.alternate;
		end;
		v101({ "firearms" }, "click", nil, nil, true, true);
		return;
	end;
	local v1437 = false;
	u9.action = true;
	u9.firing = true;
	local v1438 = u17;
	if akimbo_factors.active == true and akimbo_factors.alternate == true then
		v1437 = true;
		v1438 = akimbo_factors.alt_weapon_stats;
	end;
	local v1439 = v1438.auto;
	local v1440 = false;
	local v1441 = 0;
	local v1442 = 1;
	local v1443 = 1;
	local v1444 = nil;
	u37 = false;
	local v1445 = "light";
	if v1438.name == "SPAS-12" or v1438.name == "Kel-Tec KSG" or v1438.name == "Caldwell 940" or v1438.name == "Caldwell Handcannon" or v1438.name == "Model 870" or v1438.name == "MVD KS-23" then
		v1443 = 12;
		v1444 = "shotgun";
		v1445 = "shotgun";
		u37 = true;
		if v1438.name == "MVD KS-23" then
			v1443 = 1;
			u37 = false;
			v1444 = nil;
		end;
	end;
	local v1446 = v1438.speedrating;
	local v1447 = false;
	if v1438.animset == "LSMG" then
		v1447 = true;
	end;
	local v1448 = true;
	if v1438.name == "Heath Beowulf" or v1438.name == "Remington 700" or v1438.name == "Modded Rifle" or v1438.name == "Karabiner 98k" or v1438.name == "M1891 Avtomat" then
		v1445 = "sniper";
	elseif v1438.animset == "ASMG" or v1438.name == "MCX VIRTUS" then
		v1445 = "medium";
	elseif v1438.name == "AK-74" or v1438.name == "M60-E6" or v1438.name == "M14 EBR" or v1438.name == "FN SCAR-H" or v1438.name == "R11 RSASS" then
		v1445 = "heavy";
	elseif v1438.name == "Caldwell 940" or v1438.animset == "RV" or v1438.animset == "DBB" then
		v1445 = nil;
	end;
	if v1447 == true then
		v1439 = true;
		local v1449 = tick();
		v1443 = 4;
		l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", v1438.animset }, "wind", character.HumanoidRootPart);
		curentanimset.wind:Play(0.2);
		tpcurrentanimset.wind:Play(0.2);
		u22 = u22 - 6;
		while true do
			RS:wait();
			if tick() - v1449 >= 0.6 then
				break;
			end;		
		end;
	end;
	local v1450 = 0.5;
	if u9.aiming == true then
		v1450 = 0.2;
		if v1445 == "sniper" or v1445 == "shotgun" then
			v1450 = 0.45;
		elseif v1445 == "heavy" or v1438.animset == "PST" or v1438.animset == "2HPST" then
			v1450 = 0.3;
		end;
	end;
	if v1438.name == "TYPE-22 LSR-MG" then
		v1450 = 1;
	end;
	if v1439 == false then
		v1448 = false;
	end;
	local v1451 = "med";
	if v1438.animset == "PST" then
		v1451 = "light";
	end;
	if v1438.name == "Dolch 96" then
		v1451 = "med";
	end;
	if v1438.name == "KRISS Vector" or v1438.name == "CBJ-MS PDW" or v1438.name == "H&K MP5A3" then
		v1451 = "light";
	end;
	if v1438.name == "AS Val" or v1438.name == "Modded Pistol" or v1438.name == "Modded AKM" or v1438.name == "Kel-Tec KSG" then
		v1451 = "suppressed";
		v1444 = "suppressed";
	end;
	if v1438.name == "A.J.M. 9" then
		v1451 = "light";
		v1442 = 3;
	end;
	if v1438.name == "FAMAS F1" then
		v1442 = 3;
	end;
	local v1452 = "rack";
	if playerperks.recoil and u9.aiming == true then
		v1452 = "lever";
	end;
	if v1438.name == "Model 870" or v1438.name == "Kel-Tec KSG" or v1438.name == "MVD KS-23" then
		local v1453 = 0.4;
		if v1438.name == "MVD KS-23" then
			v1453 = 0.6;
		end;
		local u161 = v1452;
		delay(v1453, function()
			curentanimset[u161]:Play(0.1);
			delay(0.2, function()
				l__workspace__1.ServerStuff.playAudio:FireServer({ "firearms" }, "rack", character.HumanoidRootPart);
			end);
		end);
	elseif v1438.name == "Remington 700" or v1438.name == "Karabiner 98k" or v1438.name == "PGM FR-12.7" or v1438.name == "Modded Rifle" then
		v1451 = "heavy";
		delay(0.4, function()
			curentanimset[v1452]:Play(0.1);
			delay(0.2, function()
				if u9.aiming == true then
					sniperscopefunction("tilt");
				end;
				l__workspace__1.ServerStuff.playAudio:FireServer({ "firearms" }, "sniper_bolt", character.HumanoidRootPart);
			end);
		end);
	end;
	if v1438.name == "'The Redeemer'" or v1438.name == "M1891 Avtomat" or v1438.name == "Commissioned Musket" then
		v1451 = "heavy";
	end;
	local v1454 = false;
	local v1455 = "fire";
	if v1438.name == "Winchester 940-1" then
		local v1456 = 0.4;
		if fanning_levering == true and u9.aiming == false then
			v1454 = true;
			u161 = "lever";
			v1446 = levering_firerate;
			v1456 = 0.05;
			v1455 = "fan";
		end;
		delay(v1456, function()
			curentanimset[u161]:Play(0.1);
			delay(0.2, function()
				l__workspace__1.ServerStuff.playAudio:FireServer({ "firearms" }, "lever_action", character.HumanoidRootPart);
			end);
		end);
	end;
	local v1457 = "fire";
	if fanning_levering == true and u9.aiming == false and akimbo_factors.active == false and (v1438.name == "'The Redeemer'" or v1438.name == "Peacemaker" or u17.name == "Peacemaker Uppercut" or u17.name == "Peacemaker Chain") then
		v1454 = true;
		v1457 = "fanning";
		v1446 = fanning_firerate;
		v1455 = "fan";
		v1450 = 1;
	end;
	local v1458 = true;
	if akimbo_factors.active == true and akimbo_factors.alternate == true then
		v1458 = false;
	end;
	if akimbo_factors.active == true then
		akimbo_factors.alternate = not akimbo_factors.alternate;
	end;
	if playerperks.paranoia and v1438.auto == false and v1442 == 1 and v1454 == false then
		v1446 = v1446 * v7.paranoia.efx[2] / 100;
	end;
	if u9.aiming == true then
		sniperscopefunction("shake");
	end;
	while true do
		local v1459 = u70;
		if v1437 == true then
			v1459 = akimbo_factors.alt_tick;
		end;
		if v1446 < tick() - v1459 and v1440 == false then
			local u162 = nil;
			local u163 = nil;
			if v1437 == true then
				akimbo_factors.alt_tick = tick();
			else
				u70 = tick();
			end;
			local v1460 = u19.muzzle.Position;
			if v1437 == true then
				v1460 = akimbo_factors.alt_weapon.muzzle.Position;
			end;
			local v1461 = false;
			if v1444 == "suppressor" then
				v1461 = true;
			end;
			l__workspace__1.ServerStuff.applyGore:FireServer("muzzle_flash", character, ply, { v1460, v1461 });
			for v1462 = 1, v1443 do
				u163 = v1444;
				u162 = v1437;
				spawn(function()
					u71(u163, u162);
				end);
			end;
			local u164 = v1451;
			local u165 = v1448;
			spawn(function()
				if u162 == true then
					v6[akimbo_factors.weapon_slot][3] = v6[akimbo_factors.weapon_slot][3] - 1;
					if v6[akimbo_factors.weapon_slot][3] < 0 then
						v6[akimbo_factors.weapon_slot][3] = 0;
					end;
				else
					for v1463, v1464 in pairs(v6) do
						if v1464[2] == true and juggernaut == false then
							v1464[3] = v1464[3] - 1;
							if v1464[3] < 0 then
								v1464[3] = 0;
							end;
						end;
					end;
				end;
				local v1465 = v1438.woundrating;
				if u9.aiming == true then
					v1465 = v1465 / 1.25;
				end;
				if v1454 == true then
					v1465 = v1465 / 1.25;
				end;
				u57 = CFrame.new(0, 0.1 + v1438.woundrating / 100, 0);
				delay(0.1, function()
					u57 = CFrame.new(0, 0, 0);
				end);
				if u72 == true and u163 ~= "suppressed" then
					u164 = "indoors";
				end;
				local v1466 = math.clamp(v1465 - v1465 * u73, 0, 38);
				shakecamera("gunrecoil", { v1466 });
				shakecamera("guntilt", { v1466 });
				l__workspace__1.ServerStuff.playAudio:FireServer({ "firearms" }, "bass", character.HumanoidRootPart, 0.1);
				if u164 ~= nil then
					l__workspace__1.ServerStuff.playAudio:FireServer({ "firearms" }, "ballistic_" .. u164, character.HumanoidRootPart, 0.1);
					if u164 ~= "suppressed" then
						l__workspace__1.ServerStuff.playAudio:FireServer({ "firearms" }, "close_" .. u164, character.HumanoidRootPart, 0.1);
					end;
				end;
				if u163 ~= "suppressed" then
					l__workspace__1.ServerStuff.dealDamage:FireServer("gunsareloud", nil, v5, v4);
				end;
				if v1445 ~= nil then
					delay(math.random(40, 80) / 100, function()
						l__workspace__1.ServerStuff.playAudio:FireServer({ "firearms" }, "casing_" .. v1445, character.HumanoidRootPart, 0.15);
					end);
				end;
				if l__game__7.ReplicatedStorage.soundLibrary.weapons[v1438.animset]:FindFirstChild(v1438.name) then
					local v1467 = v101({ "weapons", v1438.animset }, v1438.name, nil, nil, true, true, u164);
					if u165 == true then
						v1467.Volume = v1467.Volume + 0.5;
						u165 = false;
					end;
					if u72 == true then
						v1467.Volume = v1467.Volume + 0.6;
					end;
					local v1468 = v101({ "firearms" }, "mech", nil, nil, true, true);
					for v1469, v1470 in pairs(v6) do
						if v1470[2] == true and v1470[3] <= 5 then
							v1468.Volume = v1468.Volume + 1 + (5 - v1470[3]) / 6;
							v1468.Pitch = v1468.Pitch + (5 - v1470[3]) / 10;
						end;
					end;
					l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", v1438.animset }, v1438.name, character.HumanoidRootPart, 0.05, true);
				end;
				invmanage("updatehud");
				if akimbo_factors.active ~= true then
					curentanimset[v1457]:Play(0, v1450);
					tpcurrentanimset[v1455]:Play(0);
					return;
				end;
				if v1458 == true then
					akimbosets.fire_r:Play(0, v1450);
					tpakimbosets.fire_r:Play(0);
					return;
				end;
				akimbosets.fire_l:Play(0, v1450);
				tpakimbosets.fire_l:Play(0);
			end);
			v1441 = v1441 + 1;
			if v1442 == 1 and v1439 == false then
				v1440 = true;
			end;
		end;
		if v1442 <= v1441 and u59 == false then
			v1440 = true;
		end;
		if v1442 > 1 and v1442 <= v1441 then
			v1440 = true;
		end;
		local v1471 = 0;
		for v1472, v1473 in pairs(v6) do
			if v1473[2] == true then
				v1471 = v1473[3];
			end;
		end;
		if v1437 == true then
			v1471 = v6[akimbo_factors.weapon_slot][3];
		end;
		if v1471 <= 0 then
			break;
		end;
		RS:wait();
		if v1440 == true then
			break;
		end;
		if v1438.weapontype ~= "Gun" then
			break;
		end;
		if u9.staggering == true then
			break;
		end;
		if u9.sprinting == true then
			break;
		end;	
	end;
	if u64[u17.ammoused] ~= nil and u64[u17.ammoused] >= 1000 then
		l__workspace__1.ServerStuff.callEvent:FireServer("lel");
	end;
	local v1474 = 0;
	for v1475, v1476 in pairs(v6) do
		if v1476[2] == true then
			v1474 = v1476[3];
		end;
	end;
	if v1439 == false then
		v1474 = v1474 - 1;
	end;
	if v1437 == true then
		v1474 = v6[akimbo_factors.weapon_slot][3];
	end;
	if l__game__7.ReplicatedStorage.Weapons:FindFirstChild(u19.Name):FindFirstChild("ammo") and l__game__7.ReplicatedStorage.Weapons:FindFirstChild(u19.Name):FindFirstChild("ammo").Value + 1 <= v1474 then
		l__workspace__1.ServerStuff.callEvent:FireServer("lel");
	end;
	if v1474 <= 0 then
		l__workspace__1.ServerStuff.playAudio:FireServer({ "firearms" }, "empty", character.HumanoidRootPart, 0.05);
	end;
	local v1477 = u19;
	if v1437 == true then
		v1477 = akimbo_factors.alt_weapon;
	end;
	if v1477:FindFirstChild("muzzle") then
		if v1477:FindFirstChild("muzzle"):FindFirstChild("smokebarrel") then
			v1477:FindFirstChild("muzzle"):FindFirstChild("smokebarrel"):Destroy();
		end;
		local v1478 = l__game__7.ReplicatedStorage.effects.smokebarrel:Clone();
		l__Debris__27:AddItem(v1478, 4);
		v1478.Parent = v1477:FindFirstChild("muzzle");
		v1478:Emit(math.random(2, 4));
	end;
	if v1438.weapontype == "Gun" then
		if v1447 == true then
			u22 = u22 + 6;
		end;
		if v1447 == true and u9.staggering == false then
			l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", v1438.animset }, "down", character.HumanoidRootPart);
			local v1479 = tick();
			while true do
				RS:wait();
				if tick() - v1479 >= 0.5 then
					break;
				end;			
			end;
		end;
		if akimbo_factors.active == true then
			curentanimset.equip.TimePosition = 0.5;
			curentanimset.equip:AdjustSpeed(0);
			tpcurrentanimset.equip:Play();
			tpcurrentanimset.equip.TimePosition = 0.5;
			tpcurrentanimset.equip:AdjustSpeed(0);
			check_walking_anim();
		end;
	end;
	if u9.staggering == false then
		u9.firing = false;
		u9.action = false;
	end;
end;
local function u166()
	for v1480, v1481 in pairs(v6) do
		if v1481[2] == true and v1481[3] <= 0 then
			return;
		end;
	end;
	u9.action = true;
	u9.firing = true;
	local v1482 = false;
	local v1483 = tick();
	local v1484 = u17.speedrating;
	if playerperks.hunts then
		v1484 = math.clamp(v1484 - v1484 * v7.hunts.efx[1] / 100, 0.05, 100);
	end;
	local l__arrowdraw__1485 = curentanimset.arrowdraw;
	local l__arrowdraw__1486 = tpcurrentanimset.arrowdraw;
	l__arrowdraw__1485:Play(0.1);
	local u167 = nil;
	u167 = l__arrowdraw__1485.KeyframeReached:connect(function(p141)
		if p141 == "Stop" then
			if u59 == true then
				l__arrowdraw__1485:AdjustSpeed(0);
			else
				l__arrowdraw__1485:AdjustSpeed(1);
			end;
			u167:Disconnect();
		end;
	end);
	l__arrowdraw__1486:Play(0.1);
	local u168 = nil;
	u168 = l__arrowdraw__1486.KeyframeReached:connect(function(p142)
		if p142 == "Stop" then
			if u59 == true then
				l__arrowdraw__1486:AdjustSpeed(0);
			else
				l__arrowdraw__1486:AdjustSpeed(1);
			end;
			u168:Disconnect();
		end;
	end);
	local v1487 = l__game__7.ReplicatedStorage.soundLibrary.weapons["2HBOW"].arrowpull:Clone();
	v1487.Parent = character.HumanoidRootPart;
	v1487:Play();
	local v1488 = false;
	while true do
		if u59 == false and tick() - v1483 >= 0.3 then
			v1482 = false;
			break;
		end;
		if (tick() - v1483) / v1484 >= 1 and v1488 == false then
			v1488 = true;
			v101({ "weapons", "2HBOW" }, "notch", nil, nil, true, true);
		end;
		RS:wait();
		if v1482 == true then
			break;
		end;
		if u17.weapontype ~= "Bow" then
			break;
		end;
		if u9.staggering == true then
			break;
		end;	
	end;
	if u17.weapontype ~= "Bow" then
		v1482 = true;
	end;
	v1487:Destroy();
	maingui.ChargeOverlay.Visible = false;
	if v1482 == true then
		l__arrowdraw__1485:Stop(0.1);
		l__arrowdraw__1486:Stop(0.1);
	else
		shakecamera("gunrecoil", { 3 });
		local v1489 = u17.damagerating[1];
		if u17.speedrating <= tick() - v1483 then
			v1489 = u17.damagerating[3];
		end;
		spawn(function()
			u48(v1489);
		end);
		l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", u17.animset }, "fire", character.HumanoidRootPart, 0.1);
		l__arrowdraw__1485:Stop(0.4);
		l__arrowdraw__1486:Stop(0.4);
		if u17.weapontype == "Bow" then
			for v1490, v1491 in ipairs(u19.arrow:GetChildren()) do
				if v1491:IsA("BasePart") then
					v1491.Transparency = 1;
				end;
			end;
		end;
		u74 = false;
		u9.aiming = false;
		for v1492, v1493 in pairs(v6) do
			if v1493[2] == true then
				v1493[3] = v1493[3] - 1;
			end;
		end;
		invmanage("updatehud");
		for v1494 = 1, 30 do
			RS:wait();
			if u9.staggering == true then
				break;
			end;
			if u17.weapontype ~= "Bow" then
				break;
			end;
		end;
	end;
	if u17.weapontype == "Bow" then
		curentanimset.equip.TimePosition = 0.5;
		curentanimset.equip:AdjustSpeed(0);
		tpcurrentanimset.equip:Play();
		tpcurrentanimset.equip.TimePosition = 0.5;
		tpcurrentanimset.equip:AdjustSpeed(0);
		check_walking_anim();
	end;
	if u9.staggering == false then
		u9.firing = false;
		u9.action = false;
	end;
end;
local function u169()
	if u9.swapping == true then
		return;
	end;
	if u17.name == "Crafted Backpack" and v6[5] ~= nil then
		return;
	end;
	if u17.name == "Backpack" and v6[6] ~= nil then
		maingui.Thought.thoughttext.Text = "Surprisingly, I am already wearing one.";
		inner_dialogue = tick();
		return;
	end;
	if (u17.name == "Advanced IFAK" or u17.name == "Cocktail \"Perithesene\"") and u10.Toxins then
		maingui.Thought.thoughttext.Text = "I can't use this right now...";
		inner_dialogue = tick();
		return;
	end;
	for v1495, v1496 in pairs(v6) do
		if v1496[2] == true then
			if v1496[3] == nil then
				return;
			end;
			if v1496[3] == 0 then
				return;
			end;
		end;
	end;
	u9.action = true;
	u9.channel = true;
	u11 = 0.1;
	u9.turnable = false;
	local v1497 = curentanimset.new_stim;
	local v1498 = tpcurrentanimset.inject;
	if u17.name == "Hemostatic Zanustin" then
		v1497 = curentanimset.inject;
		v1498 = tpcurrentanimset.inject;
	end;
	if u17.name == "Backpack" or u17.name == "Crafted Backpack" or u17.name == "Tactical Armour" then
		v1497 = curentanimset.backpack;
		v1498 = tpcurrentanimset.equippack;
		l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", "Item" }, "backpack", character.HumanoidRootPart);
	elseif u17.name == "Advanced IFAK" or u17.name == "Crude Bandage" or u17.name == "Aseptic Bandage" or u17.name == "Crafted Splint" then
		v1497 = curentanimset.firstaid;
		v1498 = tpcurrentanimset.firstaid;
		if u17.name == "Crude Bandage" or u17.name == "Aseptic Bandage" or u17.name == "Crafted Splint" then
			v1497 = curentanimset.bandage;
			v1498 = tpcurrentanimset.bandage;
			if u17.name == "Crafted Splint" then
				v1498 = tpcurrentanimset.splint;
			end;
		end;
		l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", "Item" }, "firstaid", character.HumanoidRootPart);
	elseif u17.name == "Esmarch Tourniquet" then
		v1497 = curentanimset.tourniquet;
		v1498 = tpcurrentanimset.bandage;
		l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", "Item" }, "esmarch", character.HumanoidRootPart);
	elseif u17.name == "Smoke Launcher" then
		v1497 = curentanimset.fire;
		v1498 = tpcurrentanimset.fire;
		l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", "Item" }, "smokedraw", character.HumanoidRootPart);
	elseif u17.name == "First Aid Kit" then
		v1497 = curentanimset.medikit;
		v1498 = tpcurrentanimset.medikit;
	elseif u17.name == "Juggernaut Kit" then
		v1497 = curentanimset.use;
		v1498 = tpcurrentanimset.use;
	elseif u17.animset == "AGENTC" then
		v1497 = curentanimset.use;
		v1498 = tpcurrentanimset.use;
		l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", "Item" }, "opencontainer", character.HumanoidRootPart);
	elseif u17.name == "Immobilising Splint" then
		v1497 = curentanimset.splint;
		v1498 = tpcurrentanimset.splint;
	elseif u17.name == "Amoxicillin Tablets" then
		v1497 = curentanimset.painkillers;
		v1498 = tpcurrentanimset.takepill;
	elseif u17.name == "Augmentin Antibiotics" then
		v1497 = curentanimset.bottlepills;
		v1498 = tpcurrentanimset.takepill;
	end;
	v1497:Play(0.1);
	if v1497 == curentanimset.new_stim then
		delay(0.1, function()
			l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", "Item" }, "new_stim", character.HumanoidRootPart);
			if u19:FindFirstChild("Model") and u19:FindFirstChild("Model"):FindFirstChild("CAP") then
				u19:FindFirstChild("Model"):FindFirstChild("CAP").Transparency = 1;
			end;
		end);
	end;
	local v1499 = v1497.KeyframeReached:connect(function(p143)
		if p143 == "Stop" then
			v1497:AdjustSpeed(0);
			if v1497 == curentanimset.inject then
				l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", "Item" }, "stimuse", character.HumanoidRootPart);
				return;
			else
				return;
			end;
		else
			if p143 == "Load" then
				l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", "Item" }, "smokeload", character.HumanoidRootPart);
				return;
			end;
			if p143 == "OpenSplint" then
				l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", "Item" }, "splint", character.HumanoidRootPart);
				return;
			end;
			if p143 == "PillOut" then
				l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", "Item" }, "bottlepill", character.HumanoidRootPart);
				return;
			end;
			if p143 == "PushPill" then
				l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", "Item" }, "painkillerspill", character.HumanoidRootPart);
				return;
			end;
			if p143 ~= "Lid" then
				if p143 == "Spit" then
					v101({ "weapons", "Item" }, "medikitspit", nil, nil, true, true);
					return;
				elseif p143 == "Clip" then
					v101({ "weapons", "Item" }, "clipopen", nil, nil, true, true);
					return;
				elseif p143 == "Inject" then
					v101({ "weapons", "Item" }, "medikitinject", nil, nil, true, true);
					return;
				else
					if p143 == "Flick" then
						v101({ "weapons", "Item" }, "medikitflick", nil, nil, true, true);
					end;
					return;
				end;
			end;
		end;
		l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", "Item" }, "medikitcap", character.HumanoidRootPart);
	end);
	v1498:Play(0.1);
	local u170 = nil;
	u170 = v1498.KeyframeReached:connect(function(p144)
		if p144 == "Stop" then
			if u59 == true then
				v1498:AdjustSpeed(0);
			else
				v1498:AdjustSpeed(1);
			end;
			u170:Disconnect();
		end;
	end);
	u76(u17.name);
	if u17.name == "Backpack" or u17.name == "Crafted Backpack" or u17.name == "Tactical Armour" then
		shakecamera("backpack");
	elseif u17.name ~= "Advanced IFAK" and u17.name ~= "Crude Bandage" and u17.name ~= "Aseptic Bandage" and u17.name ~= "Medikit" then
		shakecamera("usestim");
	end;
	local v1500 = tick();
	local v1501 = tick();
	local v1502 = true;
	while true do
		maingui.ChargeOverlay.ChargeOverlay.Size = UDim2.new(math.clamp((tick() - v1501) / u17.speedrating, 0, 1), 0, 1, 0);
		if tick() - v1500 > 6 then
			v1502 = false;
			maingui.ChargeOverlay.Visible = false;
			break;
		end;
		if u59 == false then
			v1502 = false;
			break;
		end;
		RS:wait();
		if u17.speedrating <= tick() - v1501 then
			break;
		end;
		if u9.staggering == true then
			break;
		end;	
	end;
	v1497:Stop();
	v1498:Stop();
	if v1502 == true and u9.staggering == false then
		maingui.ChargeOverlay.Visible = false;
		invmanage("updatehud");
		if u17.name == "Cocktail \"Perithesene\"" then
			if v60[2].sickstimmod == true then
				afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Tnt);
				afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Psn);
			else
				l__workspace__1.ServerStuff.dealDamage:FireServer("stimheal", nil, v5, v4);
				if u10.Bleed then
					u10.Bleed.effects.currentduration = 0;
				end;
				afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Tnt);
			end;
		elseif u17.name == "Hemostatic Zanustin" then
			if v60[2].sickstimmod == true then
				afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Tnt);
				afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Psn);
			else
				l__workspace__1.ServerStuff.dealDamage:FireServer("regenheal", nil, v5, v4);
				v101({ "weapons", "Item" }, "adrenal", nil, nil, true, true);
				afflictstatus(require(l__game__7.Workspace.ServerStuff.Statistics.S_STATISTICS).Pnk);
				if u10.Cripple then
					u10.Cripple.effects.currentduration = 0;
				end;
			end;
		elseif u17.name == "Compound Z" then
			afflictstatus(require(l__game__7.Workspace.ServerStuff.Statistics.S_STATISTICS)["Speedy Thrusts"]);
			afflictstatus(require(l__game__7.Workspace.ServerStuff.Statistics.S_STATISTICS)["Muscle Milk"]);
			afflictstatus(require(l__game__7.Workspace.ServerStuff.Statistics.S_STATISTICS)["Lung Butter"]);
			afflictstatus(require(l__game__7.Workspace.ServerStuff.Statistics.S_STATISTICS)["Iron 4 Skin"]);
			createfxoutline("compoundParticle", 60);
		elseif u17.name == "Backpack" then
			v6[6] = { "Fist", false, nil };
			maingui.InventoryFrame.slot6.Visible = true;
			if v6[5] == nil then
				v6[5] = { "Fist", false, nil };
				maingui.InventoryFrame.slot5.Visible = true;
			end;
		elseif u17.name == "Crafted Backpack" then
			v6[5] = { "Fist", false, nil };
			maingui.InventoryFrame.slot5.Visible = true;
		elseif u17.name == "Tactical Armour" then
			l__workspace__1.ServerStuff.dealDamage:FireServer("putarmour", nil, v5, v4);
			afflictstatus(require(l__game__7.Workspace.ServerStuff.Statistics.S_STATISTICS).Arm);
		elseif u17.name == "Advanced IFAK" then
			l__workspace__1.ServerStuff.dealDamage:FireServer("faidheal", nil, v5, v4);
			if u10.Bleed then
				u10.Bleed.effects.currentduration = 0;
			end;
		elseif u17.name == "Crude Bandage" then
			local v1503 = true;
			if u10.Bleed and u10["Arterial Bleed"] == nil then
				v1503 = false;
				u10.Bleed.effects.currentduration = 0;
			end;
			if v1503 == true then
				l__workspace__1.ServerStuff.dealDamage:FireServer("regenheal", nil, v5, v4);
			end;
		elseif u17.name == "Aseptic Bandage" then
			if u10.Bleed then
				u10.Bleed.effects.currentduration = 0;
			end;
			afflictstatus(require(l__game__7.Workspace.ServerStuff.Statistics.S_STATISTICS).BldPrv);
		elseif u17.name == "Immobilising Splint" then
			local v1504 = 0;
			if u10.Cripple then
				v1504 = v1504 + 1;
				u10.Cripple.effects.currentduration = 0;
			end;
			if u10.Fracture then
				v1504 = v1504 + 1;
				u10.Fracture.effects.currentduration = 0;
			end;
			if v1504 < 4 then
				afflictstatus(require(l__game__7.Workspace.ServerStuff.Statistics.S_STATISTICS).CrpPrv);
			end;
		elseif u17.name == "Esmarch Tourniquet" then
			if u10["Arterial Bleed"] then
				u10["Arterial Bleed"].effects.currentduration = 0;
			end;
			RS:wait();
			if u10.Bleed then
				u10.Bleed.effects.currentduration = 0;
			end;
		elseif u17.name == "First Aid Kit" then
			l__workspace__1.ServerStuff.dealDamage:FireServer("ai2heal", nil, v5, v4);
		elseif u17.name == "Crafted Splint" then
			local v1505 = true;
			if u10.Fracture then
				v1505 = false;
				u10.Fracture.effects.currentduration = 0;
			end;
			if u10.Cripple and v1505 == true then
				u10.Cripple.effects.currentduration = 0;
			end;
		elseif u17.name == "Amoxicillin Tablets" then
			local v1506 = u81();
			if v1506 ~= nil then
				v1506.effects.currentduration = tick();
			end;
		elseif u17.name == "Augmentin Antibiotics" then
			u82 = u82 + 1;
			u83 = tick();
			local v1507 = u81();
			if v1507 ~= nil and u84 == false then
				spawn(function()
					u84 = true;
					local v1508 = 30 * u82;
					local v1509 = math.clamp(330 - v1508, 30, 180);
					while true do
						local v1510 = math.clamp(330 - v1508, 30, 180);
						v1507.effects.currentduration = tick();
						RS:wait();
						if v1510 <= tick() - u83 then
							break;
						end;					
					end;
					u84 = false;
				end);
			end;
		elseif u17.name == "Berserk Injector" then
			afflictstatus(require(l__game__7.Workspace.ServerStuff.Statistics.S_STATISTICS).Brz);
			afflictstatus(require(l__game__7.Workspace.ServerStuff.Statistics.S_STATISTICS).Bls);
			afflictstatus(require(l__game__7.Workspace.ServerStuff.Statistics.S_STATISTICS).Rgn);
		elseif u17.name == "Smoke Launcher" then
			l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", "Item" }, "smokefire", character.HumanoidRootPart);
			l__workspace__1.ServerStuff.dealDamage:FireServer("fireSmoke", l__CurrentCamera__1.CFrame, v5, v4);
		elseif u17.animset == "AGENTC" then
			for v1511, v1512 in pairs(v6) do
				if v1512[2] == true and v1512[4] ~= nil then
					l__workspace__1.ServerStuff.dropAmmo:FireServer("redeemcontainer", v1512[4]);
					v1512[4] = nil;
					break;
				end;
			end;
		else
			if u17.name == "Juggernaut Kit" then
				u85 = false;
				u9.channel = false;
				u9.turnable = true;
				u9.action = false;
				if sprint_stam <= 0 then
					u11 = u12;
				else
					u11 = u13;
				end;
				u86();
				return;
			end;
			if u19:FindFirstChild("trapped") then
				if playerperks.chemist then
					afflictstatus(require(l__game__7.Workspace.ServerStuff.Statistics.S_STATISTICS).Rgn);
				else
					afflictstatus(require(l__game__7.Workspace.ServerStuff.Statistics.S_STATISTICS).Scs);
					local l__Prc__1513 = require(l__game__7.Workspace.ServerStuff.Statistics.S_STATISTICS).Prc;
					l__Prc__1513.intensity = 4;
					local l__Crp__1514 = require(l__game__7.Workspace.ServerStuff.Statistics.S_STATISTICS).Crp;
					l__Crp__1514.intensity = 4;
					afflictstatus(l__Prc__1513);
					afflictstatus(l__Crp__1514);
				end;
			elseif v60[2].sickstimmod == true then
				afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Tnt);
				afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Psn);
			else
				afflictstatus(require(l__game__7.Workspace.ServerStuff.Statistics.S_STATISTICS)[u17.name]);
				local v1515 = Color3.fromRGB(107, 50, 124);
				if u17.name == "3-(cbSTM)" then
					u8 = v62;
					u26("stamina");
					if u10.Fracture then
						u10.Fracture.effects.currentduration = 0;
					end;
				elseif u17.name == "BL1 (Neloprephine)" then
					v1515 = Color3.fromRGB(213, 115, 61);
					if u10["Death Morale 1"] then
						u10["Death Morale 1"].effects.currentduration = 0;
					end;
				elseif u17.name == "I4S-DS" then
					v1515 = Color3.fromRGB(80, 109, 84);
					afflictstatus(require(l__game__7.Workspace.ServerStuff.Statistics.S_STATISTICS).Rgn);
				elseif u17.name == "S44-UL1" then
					v1515 = Color3.fromRGB(110, 153, 202);
				end;
				spawn(function()
					local v1516 = l__game__7.ReplicatedStorage.misc.StimFlash:Clone();
					v1516.ImageColor3 = v1515;
					v1516.Parent = maingui;
					while true do
						v1516.ImageTransparency = v1516.ImageTransparency + 0.05;
						v1516.Size = v1516.Size + UDim2.new(0, 1, 0, 1);
						RS:wait();
						if v1516.ImageTransparency >= 1 then
							break;
						end;					
					end;
					v1516:Destroy();
				end);
			end;
		end;
	end;
	maingui.ChargeOverlay.Visible = false;
	u85 = false;
	u9.channel = false;
	if u9.turnable == false then
		u9.turnable = true;
		if sprint_stam <= 0 then
			u11 = u12;
		else
			u11 = u13;
		end;
	end;
	v1498:Stop();
	v1497:Stop();
	v1499:Disconnect();
	if u9.staggering == false then
		curentanimset.equip.TimePosition = 0.5;
		curentanimset.equip:AdjustSpeed(0);
		tpcurrentanimset.equip:Play();
		tpcurrentanimset.equip.TimePosition = 0.5;
		tpcurrentanimset.equip:AdjustSpeed(0);
		check_walking_anim();
	end;
	if v1502 == true then
		for v1517, v1518 in pairs(v6) do
			if v1518[2] == true and v1518[3] then
				v1518[3] = v1518[3] - 1;
			end;
		end;
	end;
	local v1519 = false;
	for v1520, v1521 in pairs(v6) do
		if v1521[2] == true and v1521[3] <= 0 then
			v1519 = true;
		end;
	end;
	if v1519 == false or v1502 == false then
		if u9.staggering == false then
			u9.action = false;
		end;
	else
		u19:Destroy();
		for v1522, v1523 in pairs(v6) do
			if v1523[2] == true then
				v1523[1] = "Fist";
				v1523[3] = nil;
			end;
		end;
		l__workspace__1.ServerStuff.useupItem:FireServer();
		u61("Fist");
	end;
	invmanage("updatehud");
end;
local function u171(p145)
	if u17.animset == "LSMG" then
		return;
	end;
	if tick() - drawlockout < 0.3 then
		return;
	end;
	u9.throwing = true;
	u9.action = true;
	if u8 > 0 then
		u8 = u8 - 5;
	end;
	u25(1);
	u26("stamina");
	cancel_throw = false;
	if curentanimset.throw then
		local v1524 = curentanimset.throw;
	else
		v1524 = globalanimsets.throw;
	end;
	if u17.animset == "2HSPR" then
		local v1525 = tpcurrentanimset.throw;
	else
		v1525 = tpglobalanimsets.throw;
	end;
	v1524:Play(0.2);
	v1524:AdjustSpeed(0.65);
	v1525:Play(0.5);
	v1525:AdjustSpeed(0.75);
	local u172 = false;
	local v1526 = v1524.KeyframeReached:connect(function(p146)
		if p146 == "Stop" then
			v1524:AdjustSpeed(0);
			u172 = true;
		end;
	end);
	local v1527 = v1525.KeyframeReached:connect(function(p147)
		if p147 == "Stop" then
			v1525:AdjustSpeed(0);
		end;
	end);
	l__workspace__1.ServerStuff.playAudio:FireServer({ "general_ui" }, "equip_throw", character.HumanoidRootPart);
	if u17.animset == "THRW" then
		delay(0.4, function()
			if u17.name ~= "Crafted Explosive" and u17.name ~= "Dynamite" and u17.name ~= "Fire Bomb" then
				l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", "Item" }, "pinpull", character.HumanoidRootPart);
				return;
			end;
			l__workspace__1.ServerStuff.playAudio:FireServer({ "echo_specific" }, "lighter", character.HumanoidRootPart);
			delay(0.3, function()
				l__workspace__1.ServerStuff.playAudio:FireServer({ "echo_specific" }, "lighter", character.HumanoidRootPart);
			end);
		end);
	end;
	local v1528 = tick();
	maingui.Centre.crosshair.A1.Visible = false;
	maingui.Centre.crosshair.A2.Visible = false;
	maingui.Centre.crosshair.dot.Visible = false;
	maingui.Centre.crosshair.B1.Size = UDim2.new(0, 20, 0, 2);
	maingui.Centre.crosshair.B2.Size = UDim2.new(0, 20, 0, 2);
	while true do
		RS:wait();
		if u17.name == "Dynamite" or u17.name == "Crafted Explosive" or u17.name == "M67 Grenade" or u17.name == "Fire Bomb" then
			if u17.throwrating <= tick() - v1528 and u9.throwing == true then
				u59 = false;
			end;
		elseif cancel_throw == true then
			u172 = false;
			u9.throwing = false;
			break;
		end;
		if u59 == false and u172 == true then
			break;
		end;
		if u9.throwing == false then
			break;
		end;	
	end;
	if u17.throwrating == nil or u9.swapping == true then
		u9.throwing = false;
	end;
	if u9.throwing == false then
		maingui.Centre.crosshair.A1.Visible = true;
		maingui.Centre.crosshair.A2.Visible = true;
		maingui.Centre.crosshair.dot.Visible = true;
		maingui.Centre.crosshair.B1.Size = UDim2.new(0, 10, 0, 2);
		maingui.Centre.crosshair.B2.Size = UDim2.new(0, 10, 0, 2);
		u9.action = false;
		curentanimset.equip.TimePosition = 0.5;
		curentanimset.equip:AdjustSpeed(0);
		tpcurrentanimset.equip:Play();
		tpcurrentanimset.equip.TimePosition = 0.5;
		tpcurrentanimset.equip:AdjustSpeed(0);
		check_walking_anim();
	end;
	local v1529 = (tick() - v1528) / u17.throwrating;
	v1526:Disconnect();
	v1527:Disconnect();
	u60 = tick();
	if u9.throwing == true then
		local v1530 = u19:FindFirstChild("ammo");
		local v1531 = true;
		for v1532, v1533 in pairs(v6) do
			if v1533[2] == true and v1533[3] ~= nil then
				if v1530 and p145 == "mouse" then
					v1531 = false;
					v1533[3] = v1533[3] - 1;
				end;
				v1530 = v1533[3];
			end;
		end;
		if v1530 and p145 == "mouse" and v1531 == false and v1530 > 0 then
			v1530 = 1;
		else
			u19:Destroy();
			for v1534, v1535 in pairs(v6) do
				if v1535[2] == true then
					v1535[1] = "Fist";
					v1535[3] = nil;
				end;
			end;
		end;
		if u19:FindFirstChild("trapped") then
			v1530 = "trapped";
		end;
		local v1536 = nil;
		local v1537 = globalanimsets.toss;
		if u17.name == "M67 Grenade" or u17.name == "Dynamite" or u17.name == "Crafted Explosive" or u17.name == "Fire Bomb" then
			v1537 = globalanimsets.underhand;
			v1536 = "underhand";
		end;
		v1524:Stop(0.3);
		v1537:Play(0.2, 1, 1.2);
		v1525.TimePosition = 0.3;
		v1525:AdjustSpeed(1);
		u23 = u17.name;
		if v1536 == "underhand" then
			l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "toss", character.HumanoidRootPart);
		else
			l__workspace__1.ServerStuff.playAudio:FireServer({ "general_ui" }, "throw_fast", character.HumanoidRootPart);
		end;
		l__workspace__1.ServerStuff.throwWeapon:FireServer(u18, u17.damagerating[2], l__CurrentCamera__1.CFrame, v1529, u17, v1530, v6[1][2], v5, v1536, v4);
		while true do
			RS:wait();
			if v1537.IsPlaying == false then
				break;
			end;		
		end;
		maingui.Centre.crosshair.A1.Visible = true;
		maingui.Centre.crosshair.A2.Visible = true;
		maingui.Centre.crosshair.dot.Visible = true;
		maingui.Centre.crosshair.B1.Size = UDim2.new(0, 10, 0, 2);
		maingui.Centre.crosshair.B2.Size = UDim2.new(0, 10, 0, 2);
		u9.throwing = false;
		if v1530 and p145 == "mouse" and v1531 == false and v1530 > 0 then
			u9.action = false;
			curentanimset.equip.TimePosition = 0.5;
			curentanimset.equip:AdjustSpeed(0);
			tpcurrentanimset.equip:Play();
			tpcurrentanimset.equip.TimePosition = 0.5;
			tpcurrentanimset.equip:AdjustSpeed(0);
			check_walking_anim();
		else
			v1537:Stop(0.3);
			v1525:Stop(0.3);
			u61("Fist");
		end;
		invmanage("updatehud");
		u25(0.025);
	end;
end;
local function u173()
	for v1538, v1539 in pairs(v6) do
		if v1539[2] == true and v1539[3] <= 0 then
			return;
		end;
	end;
	local v1540, v1541 = raycastline((character.HumanoidRootPart.CFrame + character.HumanoidRootPart.CFrame.lookVector * 3).p, -character.HumanoidRootPart.CFrame.upVector, 4, baselayer);
	if v1540 and u9.air == false then
		local v1542 = nil;
		local v1543 = nil;
		local v1544 = nil;
		local v1545 = nil;
		local v1546 = nil;
		local v1547 = nil;
		local v1548 = nil;
		local v1549 = nil;
		local v1550 = nil;
		local v1551 = nil;
		if raycastline((character.HumanoidRootPart.CFrame - character.HumanoidRootPart.CFrame.upVector * 3).p, character.HumanoidRootPart.CFrame.lookVector, 4, baselayer) then
			return;
		end;
		if u17.name == "Steel Punjis" or u17.name == "Crafted Punjis" then
			local v1552 = math.huge;
			for v1553, v1554 in ipairs(l__workspace__1.PlayerTraps:GetChildren()) do
				if v1554.Name == "Punjis" and (v1541 - v1554.base.Position).magnitude < v1552 then
					v1552 = (v1541 - v1554.base.Position).magnitude;
				end;
			end;
			if v1552 <= 4 then
				return;
			end;
		end;
		if u17.name == "Crafted Pavise" then
			local v1555 = math.huge;
			for v1556, v1557 in ipairs(l__workspace__1.PlayerTraps:GetChildren()) do
				if v1557.Name == "Pavise" and (v1541 - v1557.base.Position).magnitude < v1555 then
					v1555 = (v1541 - v1557.base.Position).magnitude;
				end;
			end;
			if v1555 <= 3 then
				return;
			end;
		end;
		u9.action = true;
		u9.turnable = false;
		u9.walking = false;
		local v1558 = 1;
		u9.channel = true;
		u9.blocking = false;
		l__workspace__1.ServerStuff.initiateblock:FireServer(v5, false);
		u25(0.025);
		local v1559 = { globalanimsets.interact, tpglobalanimsets.interact };
		v1559[1]:Play(0.1);
		v1559[2]:Play(0.1);
		local v1560 = v1559[1].KeyframeReached:connect(function(p148)
			if p148 == "Stop" then
				v1559[1]:AdjustSpeed(0);
			end;
		end);
		local v1561 = v1559[2].KeyframeReached:connect(function(p149)
			if p149 == "Stop" then
				v1559[2]:AdjustSpeed(0);
			end;
		end);
		u76(u17.name);
		local v1562 = tick();
		local v1563 = false;
		local v1564 = nil;
		if u17.name == "Proximity Mine" then
			v1564 = l__game__7.ReplicatedStorage.misc.ProxMine:Clone();
		elseif u17.name == "Crafted Pavise" then
			v1564 = l__game__7.ReplicatedStorage.misc.Pavise:Clone();
		elseif u17.name == "Steel Punjis" or u17.name == "Crafted Punjis" then
			v1564 = l__game__7.ReplicatedStorage.misc.Punjis:Clone();
			v1564:FindFirstChild(u17.name):Destroy();
		elseif u17.name == "Remote Explosive" then
			v1564 = l__game__7.ReplicatedStorage.misc.RemoteEx:Clone();
			v1558 = 1.5;
		elseif u17.name == "Steel Snares" then
			v1558 = 2;
			v1564 = l__game__7.ReplicatedStorage.misc.Snare:Clone();
		end;
		v1564.Parent = l__CurrentCamera__1;
		v1564:SetPrimaryPartCFrame((ply.Character.HumanoidRootPart.CFrame + ply.Character.HumanoidRootPart.CFrame.lookVector * 3) * CFrame.new(0, -2.75, 0));
		if u17.name == "Steel Punjis" or u17.name == "Crafted Punjis" then
			v1564:SetPrimaryPartCFrame((ply.Character.HumanoidRootPart.CFrame + ply.Character.HumanoidRootPart.CFrame.lookVector * 3) * CFrame.new(0, -2.5, 0));
		elseif u17.name == "Steel Snares" then
			v1564:SetPrimaryPartCFrame((ply.Character.HumanoidRootPart.CFrame + ply.Character.HumanoidRootPart.CFrame.lookVector * 3) * CFrame.new(0, -2.25, 0));
		elseif u17.name == "Crafted Pavise" then
			v1564:SetPrimaryPartCFrame((ply.Character.HumanoidRootPart.CFrame + ply.Character.HumanoidRootPart.CFrame.lookVector * 3) * CFrame.new(0, -2, 0));
		end;
		for v1565, v1566 in ipairs(v1564:GetDescendants()) do
			if v1566:IsA("BasePart") and v1566.Transparency == 0 then
				v1566.BrickColor = BrickColor.new("Bright green");
				v1566.Material = "Neon";
				v1566.Transparency = 0.5;
				v1566.Anchored = true;
				v1566.CanCollide = false;
				v1566.Locked = true;
			elseif not v1566:IsA("Folder") then
				v1566:Destroy();
			end;
		end;
		if playerperks.trapper then
			v1558 = v1558 - v1558 * v7.trapper.efx[1] / 100;
		end;
		local v1567 = v1558 - v1558 * v48;
		while true do
			if u59 == false then
				v1563 = true;
				break;
			end;
			if u9.walking == true then
				v1563 = true;
				break;
			end;
			maingui.ChargeOverlay.ChargeOverlay.Size = UDim2.new((tick() - v1562) / v1567, 0, 1, 0);
			RS:wait();
			if v1567 <= tick() - v1562 then
				break;
			end;
			if u9.staggering == true then
				break;
			end;		
		end;
		v1564:Destroy();
		v1559[1]:Stop();
		v1559[2]:Stop();
		v1560:Disconnect();
		v1561:Disconnect();
		maingui.ChargeOverlay.Visible = false;
		u9.channel = false;
		u9.turnable = true;
		if v1563 == false then
			if u9.staggering == false then
				for v1568, v1569 in pairs(v6) do
					if v1569[2] == true then
						v1569[3] = v1569[3] - 1;
					end;
				end;
				l__workspace__1.ServerStuff.adjustStats:FireServer("tracker", { "DeployablesSet", 1 });
				invmanage("updatehud");
				if u17.name == "Proximity Mine" then
					l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "mineset", character.HumanoidRootPart);
				elseif u17.name == "Steel Punjis" or u17.name == "Crafted Punjis" then
					l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "punjiset", character.HumanoidRootPart);
				elseif u17.name == "Crafted Pavise" then
					l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "craftdone", character.HumanoidRootPart);
				elseif u17.name == "Remote Explosive" then
					l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "explosiveset", character.HumanoidRootPart);
				elseif u17.name == "Steel Snares" then
					l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "snareset", character.HumanoidRootPart);
					spawn(function()
						local v1570 = l__game__7.ReplicatedStorage.misc.snareindicators:Clone();
						l__Debris__27:AddItem(v1570, 10);
						v1570.CFrame = (character.HumanoidRootPart.CFrame + character.HumanoidRootPart.CFrame.lookVector * 3) * CFrame.new(0, -2.25, 0);
						v1570.Parent = l__workspace__1.NoTarget;
						delay(2, function()
							for v1571 = 1, 20 do
								v1570.Transparency = v1571 / 20;
								RS:wait();
							end;
							v1570:Destroy();
						end);
					end);
				end;
				l__workspace__1.ServerStuff.deployTrap:FireServer(u17.name, v5, v4);
				local l__throw__1572 = tpglobalanimsets.throw;
				globalanimsets.toss:Play(0.2);
				l__throw__1572.TimePosition = 0.3;
				l__throw__1572:AdjustSpeed(1);
				while true do
					RS:wait();
					if globalanimsets.toss.IsPlaying == false then
						break;
					end;				
				end;
				globalanimsets.toss:Stop(0.3);
				l__throw__1572:Stop(0.3);
				curentanimset.equip.TimePosition = 0.5;
				curentanimset.equip:AdjustSpeed(0);
				tpcurrentanimset.equip:Play();
				tpcurrentanimset.equip.TimePosition = 0.5;
				tpcurrentanimset.equip:AdjustSpeed(0);
				check_walking_anim();
				local v1573 = false;
				for v1574, v1575 in pairs(v6) do
					if v1575[2] == true and v1575[3] <= 0 then
						v1573 = true;
					end;
				end;
				if u17.name == "Remote Explosive" then
					v1573 = false;
				end;
				if v1573 == false then
					u9.action = false;
					return;
				else
					u19:Destroy();
					for v1576, v1577 in pairs(v6) do
						if v1577[2] == true then
							v1577[1] = "Fist";
							v1577[3] = nil;
						end;
					end;
					invmanage("updatehud");
					l__workspace__1.ServerStuff.useupItem:FireServer();
					u61("Fist");
					return;
				end;
			end;
			v1542 = u9;
			v1544 = false;
			v1543 = "action";
			v1545 = v1542;
			v1546 = v1543;
			v1547 = v1544;
			v1545[v1546] = v1547;
			local v1578 = u9;
			local v1579 = "staggering";
			v1548 = v1578;
			v1549 = v1579;
			local v1580 = v1548[v1549];
			local v1581 = false;
			v1550 = v1580;
			v1551 = v1581;
			if v1550 == v1551 then
				curentanimset.equip.TimePosition = 0.5;
				curentanimset.equip:AdjustSpeed(0);
				tpcurrentanimset.equip:Play();
				tpcurrentanimset.equip.TimePosition = 0.5;
				tpcurrentanimset.equip:AdjustSpeed(0);
				check_walking_anim();
			end;
		else
			v1542 = u9;
			v1544 = false;
			v1543 = "action";
			v1545 = v1542;
			v1546 = v1543;
			v1547 = v1544;
			v1545[v1546] = v1547;
			v1578 = u9;
			v1579 = "staggering";
			v1548 = v1578;
			v1549 = v1579;
			v1580 = v1548[v1549];
			v1581 = false;
			v1550 = v1580;
			v1551 = v1581;
			if v1550 == v1551 then
				curentanimset.equip.TimePosition = 0.5;
				curentanimset.equip:AdjustSpeed(0);
				tpcurrentanimset.equip:Play();
				tpcurrentanimset.equip.TimePosition = 0.5;
				tpcurrentanimset.equip:AdjustSpeed(0);
				check_walking_anim();
			end;
		end;
	end;
end;
u108 = function()
	if u59 == false then
		u59 = true;
	end;
	if u17.weapontype ~= "Bludgeon" and u17.weapontype ~= "Blade" and u17.weapontype ~= "Fists" and u17.weapontype ~= "Spear" and u17.weapontype ~= "Axe" then
		if u17.weapontype == "Gun" and u9.sprinting == false then
			if u9.action == false then
				local v1582 = u70;
				local v1583 = u17.speedrating;
				if akimbo_factors.active == true and akimbo_factors.alternate == true then
					v1582 = akimbo_factors.alt_tick;
					v1583 = akimbo_factors.alt_weapon_stats.speedrating;
				end;
				local v1584 = false;
				if fanning_levering == true and u9.aiming == false then
					v1584 = true;
					if u17.name == "Winchester 940-1" then
						v1583 = levering_firerate;
					end;
					if u17.name == "'The Redeemer'" or u17.name == "Peacemaker" or u17.name == "Peacemaker Uppercut" or u17.name == "Peacemaker Chain" then
						v1583 = fanning_firerate;
					end;
				end;
				if playerperks.paranoia and u17.auto == false and v1584 == false then
					v1583 = v1583 * v7.paranoia.efx[2] / 100;
				end;
				if v1583 < tick() - v1582 then
					u160();
					return;
				else
					return;
				end;
			else
				return;
			end;
		elseif u17.weapontype == "Bow" then
			if u9.action == false then
				if u19.arrow.arrow1.Transparency == 1 then
					u124();
					return;
				else
					u166();
					return;
				end;
			else
				return;
			end;
		elseif u17.weapontype == "Item" then
			if u9.action == true then
				return;
			elseif u17.animset == "STM" or u17.animset == "BOX" or u17.animset == "AGENTC" then
				u169();
				return;
			elseif u17.animset == "THRW" or u17.name == "Hunting Axe" or u17.name == "Crafted Javelin" or u17.name == "Bomb Spear" or u17.name == "Poisoned Knife" or u17.name == "Throwing Knife" or u17.name == "Crafted Caltrops" or u17.name == "Steel Caltrops" then
				u171("mouse");
				return;
			else
				if u17.name == "Proximity Mine" or u17.name == "Crafted Pavise" or u17.name == "Crafted Punjis" or u17.name == "Steel Punjis" or u17.name == "Remote Explosive" or u17.name == "Steel Snares" then
					u173();
				else
					return;
				end;
				return;
			end;
		else
			return;
		end;
	end;
	if tick() - u45 <= 0.3 then
		return;
	end;
	if u46 > 3 then
		u46 = 1;
	end;
	while true do
		u158();
		u46 = u46 + 1;
		if u46 > 3 then
			break;
		end;
		if u59 == false then
			break;
		end;
		if u9.staggering == true then
			break;
		end;	
	end;
	u45 = tick();
	u46 = 1;
end;
local function u174()
	if u9.action == true then
		return;
	end;
	if u9.swinging == true then
		return;
	end;
	if u9.cancombo == false then
		return;
	end;
	if u9.staggering == true then
		return;
	end;
	if tick() - u50 < 0.8 then
		return;
	end;
	if curentanimset.charge == nil then
		return;
	end;
	u9.action = true;
	u9.swinging = true;
	u9.cancombo = false;
	l__workspace__1.ServerStuff.initiateblock:FireServer(v5, false);
	u26("stamina");
	local v1585 = u51;
	local v1586 = ({ 0.6, 0.7, 0.75, 0.8 })[u17.chargerating];
	if u10.Fracture or u8 <= 0 then
		v1586 = 0.6;
	end;
	if u17.name == "Executioner Sword" then
		v1586 = 0.45;
		v1585 = 1;
	end;
	local v1587 = v1586 * v1585;
	curentanimset.charge:Play(0);
	curentanimset.charge:AdjustSpeed(v1587);
	tpcurrentanimset.charge:Play(0);
	tpcurrentanimset.charge:AdjustSpeed(math.clamp(v1587 * 1.25, 0.5, 1));
	local v1588 = tick();
	local u175 = false;
	local v1589 = tpcurrentanimset.charge.KeyframeReached:connect(function(p150)
		if p150 == "Stop" then
			tpcurrentanimset.charge:AdjustSpeed(0);
		end;
	end);
	while true do
		RS:wait();
		u25(nil);
		if u175 == true then
			break;
		end;	
	end;
	curentanimset.charge.KeyframeReached:connect(function(p151)
		if p151 == "Stop" then
			curentanimset.charge:AdjustSpeed(0);
			u175 = true;
			u8 = u8 - 15;
			u26("stamina");
		end;
	end):Disconnect();
	v1589:Disconnect();
	if u9.staggering == false and u175 == true then
		if u17.animset == "1PB" then
			if u9.sprinting == true then
				l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", u17.animset }, "heavychargeswing", character.HumanoidRootPart, 0.05);
				local v1590 = tick();
				local v1591 = Instance.new("BodyVelocity");
				v1591.Name = "parkourPositionThing";
				v1591.P = 3000;
				v1591.MaxForce = Vector3.new(math.huge, math.huge, math.huge);
				v1591.Velocity = character.HumanoidRootPart.Velocity + character.HumanoidRootPart.CFrame.lookVector * 40;
				v1591.Parent = character.HumanoidRootPart;
				u39 = true;
				while true do
					RS:wait();
					if tick() - v1590 >= 0.2 then
						break;
					end;				
				end;
				delay(0.1, function()
					v1591:Destroy();
				end);
			end;
			l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", current_anim_set_use }, "swingheavy", character.HumanoidRootPart, 0.05);
			local l__plasmaEffect__1592 = u19:WaitForChild("plasmaEffect");
			l__plasmaEffect__1592:WaitForChild("t1").Enabled = true;
			l__plasmaEffect__1592:WaitForChild("t2").Enabled = true;
			delay(0.3, function()
				l__plasmaEffect__1592.t1.Enabled = false;
				l__plasmaEffect__1592.t2.Enabled = false;
			end);
		end;
		shakecamera("weapon", { current_anim_set_use, "charge" });
		l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", current_anim_set_use }, "chargeswing", character.HumanoidRootPart);
		if u10["Immolator Buff"] then
			l__workspace__1.ServerStuff.playAudio:FireServer({ "perks" }, "flamer_swing", character.HumanoidRootPart, 0.01);
		end;
		if startperk.Value == "hiddenB" then
			l__workspace__1.ServerStuff.dealDamage:FireServer("hiddeneyes", nil, v5, v4);
			l__workspace__1.ServerStuff.playAudio:FireServer({ "events", "hiddenB" }, "attack", character.HumanoidRootPart);
		end;
		local v1593 = 0.55;
		if u8 <= 0 then
			v1593 = 0.45;
		end;
		curentanimset.charge.TimePosition = 0.4;
		curentanimset.charge:AdjustSpeed(v1593);
		tpcurrentanimset.charge.TimePosition = 0.4;
		tpcurrentanimset.charge:AdjustSpeed(v1593);
		local v1594 = false;
		local v1595 = u17.damagerating[2];
		u50 = tick();
		local v1596 = false;
		while true do
			if curentanimset.charge:GetTimeOfKeyframe("Hit") <= curentanimset.charge.TimePosition and v1594 == false then
				v1594 = true;
				if u48(v1595, "heavy") ~= nil then
					if v59.berzactive ~= nil then
						l__workspace__1.ServerStuff.dealDamage:FireServer("berzheal", nil, v5, v4);
					end;
					if v1596 == false and u17.name == "'The Decimator'" then
						v1596 = true;
						u52();
					end;
				end;
			end;
			if curentanimset.charge.TimePosition >= 0.7 then
				curentanimset.charge:AdjustSpeed(0.8);
				tpcurrentanimset.charge:AdjustSpeed(0.8);
			end;
			RS:wait();
			if curentanimset.charge.IsPlaying == false then
				break;
			end;
			if u9.staggering == true then
				break;
			end;		
		end;
		u39 = false;
		u9.swinging = false;
		u14.stamregen = 0;
		u14.regentick = 0;
		u9.cancombo = true;
		curentanimset.charge:Stop(0.3);
		tpcurrentanimset.charge:Stop(0.3);
		if u9.staggering == false then
			curentanimset.equip.TimePosition = 0.5;
			curentanimset.equip:AdjustSpeed(0);
			tpcurrentanimset.equip:Play(0.3);
			tpcurrentanimset.equip.TimePosition = 0.5;
			tpcurrentanimset.equip:AdjustSpeed(0);
			u9.action = false;
		end;
	end;
end;
local function u176()
	if tick() - u45 < 0.3 then
		return;
	end;
	u45 = tick();
	u9.action = true;
	u9.swinging = true;
	u9.cancombo = false;
	if u8 > 0 then
		u8 = u8 - 10;
	end;
	u25(nil);
	u26("stamina");
	v101({ "weapons", u17.animset }, "swingwindup", nil, nil, true, true);
	delay(0.4, function()
		l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", u17.animset }, "swing", character.HumanoidRootPart);
	end);
	curentanimset.swing:Play(0.2, 1, 1.2);
	tpcurrentanimset.swing:Play(0.2, 1, 1.2);
	local v1597 = false;
	shakecamera("weapon", { "LSMG", "swing" });
	local v1598 = nil;
	while true do
		u25(nil);
		if curentanimset.swing:GetTimeOfKeyframe("Strike") <= curentanimset.swing.TimePosition and v1597 == false then
			v1597 = true;
			v1598 = u48("minigunbash");
			if v1598 then
				u9.cancombo = true;
			end;
		end;
		RS:wait();
		if curentanimset.swing.isPlaying == false then
			break;
		end;
		if u9.staggering == true then
			break;
		end;
		if u9.cancombo == false and v1598 ~= nil then
			break;
		end;	
	end;
	u9.swinging = false;
	u14.stamregen = 0;
	u14.regentick = 0;
	u9.cancombo = true;
	curentanimset.swing:Stop(0.45);
	if u9.staggering == false then
		curentanimset.equip.TimePosition = 0.5;
		curentanimset.equip:AdjustSpeed(0);
		tpcurrentanimset.equip:Play();
		tpcurrentanimset.equip.TimePosition = 0.5;
		tpcurrentanimset.equip:AdjustSpeed(0);
		check_walking_anim();
		u9.action = false;
	end;
end;
local function u177()
	if v60[2].noaimmod == true then
		return;
	end;
	if u10.Fracture then
		return;
	end;
	if u9.action == true and u9.firing == false then
		return;
	end;
	if v59.gogglesactive == true then
		return;
	end;
	if tick() - baseadstick <= 0.5 then
		return;
	end;
	v101({ "firearms" }, "ads_in", nil, nil, true, true);
	baseadstick = tick();
	u9.aiming = true;
	local v1599 = 60;
	u78 = 0.2;
	if u17.weapontype == "Bow" then
		v1599 = 40;
	end;
	local v1600 = false;
	local v1601 = tick();
	local v1602 = nil;
	if u17.name == "Modded Rifle" or u17.name == "Remington 700" or u17.name == "R11 RSASS" then
		v1600 = true;
		v1599 = 50;
	end;
	if v1600 == true then
		v1602 = l__game__7.ReplicatedStorage.effects.sniperScope:Clone();
		v1602.Enabled = false;
		v1602.Parent = ply.PlayerGui;
		sniperscope = v1602;
	end;
	if playerperks.zoom then
		v1599 = v1599 - v1599 * v7.zoom.efx[1] / 100;
	end;
	if u17.weapontype == "Gun" then
		maingui.Centre.crosshair.Visible = playerstats.Settings.ADSCrosshair;
	end;
	u79 = playerstats.Settings.AimSens;
	while true do
		RS:wait();
		if v1600 == true then
			if tick() - v1601 < 0.5 then
				l__CurrentCamera__1.FieldOfView = lerp(l__CurrentCamera__1.FieldOfView, v1599, 0.05);
			elseif v1602.Enabled == false then
				v1602.Enabled = true;
				fparms.Parent = nil;
				l__CurrentCamera__1.FieldOfView = 10;
				maingui.Enabled = false;
			end;
		else
			l__CurrentCamera__1.FieldOfView = lerp(l__CurrentCamera__1.FieldOfView, v1599, 0.05);
		end;
		if u9.action == true and u9.firing == false then
			break;
		end;
		if u10.Fracture then
			break;
		end;
		if u9.aiming == false then
			break;
		end;
		if u9.staggering == true then
			break;
		end;
		if u9.sprinting == true then
			break;
		end;
		if u17.weapontype ~= "Gun" and u17.weapontype ~= "Bow" then
			break;
		end;	
	end;
	baseadstick = tick();
	v101({ "firearms" }, "ads_out", nil, nil, true, true);
	if v1600 == true then
		fparms.Parent = l__CurrentCamera__1;
		maingui.Enabled = true;
		if v1602 ~= nil then
			v1602:Destroy();
			sniperscope = nil;
		end;
		l__CurrentCamera__1.FieldOfView = v1599;
	end;
	maingui.Centre.crosshair.Visible = playerstats.Settings.Crosshair;
	u78 = 1;
	u79 = 1;
	u9.aiming = false;
	spawn(function()
		while true do
			l__CurrentCamera__1.FieldOfView = lerp(l__CurrentCamera__1.FieldOfView, 90, 0.05);
			if u9.aiming == true then
				break;
			end;
			RS:wait();
			if l__CurrentCamera__1.FieldOfView >= 90 then
				break;
			end;		
		end;
	end);
end;
u110 = function()
	if u74 == false then
		u74 = true;
	end;
	if u17.weapontype == "Bludgeon" or u17.weapontype == "Fists" or u17.weapontype == "Blade" or u17.weapontype == "Spear" or u17.weapontype == "Axe" then
		u174();
	elseif u17.weapontype == "Gun" or u17.weapontype == "Bow" then
		if u17.animset == "LSMG" then
			if u9.action == false and u9.shoving == false and u9.blockrecoil == false and u9.staggering == false then
				u176();
			end;
		elseif u9.sprinting == false and akimbo_factors.active == false then
			u177();
		end;
	end;
	if u9.throwing == true then
		cancel_throw = true;
	end;
	if (u17.name == "Remote Explosive" or u17.name == "Rigged Detonator") and u9.action == false and u9.staggering == false then
		l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "activateexplosive", character.HumanoidRootPart);
		delay(0.5, function()
			local v1603 = "detexplosives";
			if u17.name == "Rigged Detonator" then
				v1603 = "detrigged";
			end;
			l__workspace__1.ServerStuff.deployTrap:FireServer(v1603, v5, v4);
		end);
	end;
end;
u107 = mouse.Button1Down:connect(u108);
mouse.Button1Up:connect(function()
	if u59 == true then
		u59 = false;
	end;
end);
u109 = mouse.Button2Down:connect(u110);
mouse.Button2Up:connect(function()
	if u74 == true then
		u74 = false;
	end;
	if u9.aiming == true then
		u9.aiming = false;
	end;
end);
if startperk.Value == "hubbing" then
	maingui.SponsorFrame.Visible = false;
	maingui.Enabled = false;
	fparms.Parent = nil;
	u107:Disconnect();
	u109:Disconnect();
end;
l__workspace__1.ServerStuff.adjustArms.OnClientEvent:Connect(function(p152, p153)
	if p152 == nil then
		return;
	end;
	if p152:FindFirstChild("Left Shoulder") == nil then
		return;
	end;
	if p152:FindFirstChild("Right Shoulder") == nil then
		return;
	end;
	if p152:FindFirstChild("Neck") == nil then
		return;
	end;
	p152["Left Shoulder"].C0 = p152["Left Shoulder"].C0:lerp(CFrame.new(-1, 0.5, 0, -0, -0, -1, 0, 1, 0, 1, 0, 0) * CFrame.Angles(0, 0, -p153), 0.7);
	p152["Right Shoulder"].C0 = p152["Right Shoulder"].C0:lerp(CFrame.new(1, 0.5, 0, 0, 0, 1, 0, 1, 0, -1, -0, -0) * CFrame.Angles(0, 0, p153), 0.7);
	p152.Neck.C0 = p152.Neck.C0:lerp(CFrame.new(0, 1, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0) * CFrame.Angles(-p153 - math.rad(3), 0, 0), 0.9);
end);
local u178 = nil;
local u179 = tick();
local v1604 = mouse.Move:connect(function()
	if character:FindFirstChild("Torso") == nil then
		return;
	end;
	u178();
	local v1605 = math.asin((mouse.Hit.p - mouse.Origin.p).unit.y);
	if u9.staggering == true then
		v1605 = 0;
	end;
	if tick() - u179 >= 0.1 then
		u179 = tick();
		l__workspace__1.ServerStuff.adjustArms:FireServer(character.Torso, v1605);
	end;
end);
local u180 = nil;
local u181 = nil;
local function u182()
	local v1606 = getPstats(u180);
	if maingui:FindFirstChild("EnemyFrame") == nil then
		return;
	end;
	maingui.EnemyFrame.Visible = true;
	maingui.EnemyFrame.EnemyName.Text = v1606[7];
	maingui.EnemyFrame.HealthBar.Bar.Size = UDim2.new(v1606[1] / v1606[6], 0, 1, 0);
	maingui.EnemyFrame.StaminaBar.Bar.Size = UDim2.new(v1606[2] / v1606[10], 0, 1, 0);
	for v1607, v1608 in pairs(v1606[3]) do
		local v1609 = require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS)[v1607];
		if v1609 ~= nil then
			if not maingui.EnemyFrame.EnemyDebuffs:FindFirstChild(v1607) and not maingui.EnemyFrame.EnemyBuffs:FindFirstChild(v1607) then
				local v1610 = false;
				local v1611 = maingui.EnemyFrame.EnemyDebuffs;
				if v1609.colour ~= nil then
					v1610 = true;
					v1611 = maingui.EnemyFrame.EnemyBuffs;
				end;
				local v1612 = v1611.Example:Clone();
				v1612.Visible = true;
				v1612.Name = v1607;
				v1612.Icon.Image = "rbxassetid://" .. v1609.icon;
				v1612.Bar.Size = UDim2.new(1, 0, v1608[2], 0);
				if v1610 == true then
					v1612.Bar.BackgroundColor3 = v1609.colour;
				end;
				v1612.Parent = v1611;
				for v1613, v1614 in ipairs(v1611:GetChildren()) do
					if v1614.Name ~= "Example" then
						v1614.Position = UDim2.new(-0.2 + 0.1 * v1613, 0, 0.5, 0);
					end;
				end;
			else
				local v1615 = maingui.EnemyFrame.EnemyDebuffs:FindFirstChild(v1607);
				if v1615 == nil then
					v1615 = maingui.EnemyFrame.EnemyBuffs:FindFirstChild(v1607);
				end;
				if v1615 ~= nil then
					v1615.Bar.Size = UDim2.new(1, 0, v1608[2], 0);
				end;
			end;
		end;
	end;
	for v1616, v1617 in ipairs({ maingui.EnemyFrame.EnemyDebuffs, maingui.EnemyFrame.EnemyBuffs }) do
		local v1618, v1619, v1620 = ipairs(v1617:GetChildren());
		while true do
			local v1621, v1622 = v1618(v1619, v1620);
			if not v1621 then
				break;
			end;
			local v1623 = true;
			for v1624, v1625 in pairs(v1606[3]) do
				if v1622.Name == v1624 then
					v1623 = false;
				end;
			end;
			if v1623 == true and v1622.Name ~= "Example" then
				v1622:Destroy();
				for v1626, v1627 in ipairs(v1617:GetChildren()) do
					if v1627.Name ~= "Example" then
						v1627.Position = UDim2.new(-0.2 + 0.1 * v1626, 0, 0.5, 0);
					end;
				end;
			end;		
		end;
	end;
end;
local function u183()
	maingui.EnemyFrame.Visible = false;
	if u181 == true then
		pcall(function()
			l__game__7:GetService("RunService"):UnbindFromRenderStep("targlockstep");
		end);
		u181 = nil;
		u180 = nil;
		for v1628, v1629 in ipairs(maingui.EnemyFrame.EnemyDebuffs:GetChildren()) do
			if v1629.Name ~= "Example" then
				v1629:Destroy();
			end;
		end;
		for v1630, v1631 in ipairs(maingui.EnemyFrame.EnemyBuffs:GetChildren()) do
			if v1631.Name ~= "Example" then
				v1631:Destroy();
			end;
		end;
	end;
end;
u178 = function()
	local v1632 = raycastline(l__CurrentCamera__1.CFrame.p, l__CurrentCamera__1.CFrame.LookVector, 50, baselayer);
	if v1632 then
		if v1632.Parent:FindFirstChild("Humanoid") and l__game__7.Players:GetPlayerFromCharacter(v1632.Parent) and v1632.Parent:FindFirstChild("Humanoid").Health > 0 and v1632.Parent:FindFirstChild("Torso") and v1632.Parent:FindFirstChild("Torso").Transparency ~= 1 then
			if u180 == nil then
				u180 = l__game__7.Players:GetPlayerFromCharacter(v1632.Parent);
				l__game__7:GetService("RunService"):BindToRenderStep("targlockstep", 150, u182);
				u181 = true;
				return;
			elseif l__game__7.Players:GetPlayerFromCharacter(v1632.Parent) ~= u180 then
				u183();
				return;
			else
				return;
			end;
		end;
	else
		u183();
		return;
	end;
	u183();
end;
updateteamhealth = tick();
groundedtimer = tick();
idletimepassed = tick();
breathetimer = tick();
walkingtick = tick();
fall_sfx_tick = tick();
local u184 = 0;
if v60[3].multicooldown then
	maingui.PerkFrame.status.TextSize = 30;
	maingui.PerkFrame.status.TextYAlignment = "Top";
	maingui.PerkFrame.multiple.Visible = true;
end;
move_delta = CFrame.Angles(0, 0, 0);
cd_ping = false;
local u185 = 0;
local u186 = 8;
local u187 = 0;
local u188 = 0;
local u189 = true;
local function u190()
	local v1633 = maingui.teammatesframe:GetChildren();
	for v1634, v1635 in pairs(v1633) do
		if v1635.Name ~= "ex" then
			v1635.Parent = nil;
		end;
	end;
	for v1636, v1637 in pairs(v1633) do
		if v1637.Name ~= "ex" then
			v1637.Position = UDim2.new(0, 0, 1, 70 - 70 * #maingui.teammatesframe:GetChildren());
			v1637.Parent = maingui.teammatesframe;
		end;
	end;
end;
local function u191(p154)
	if tick() - u184 <= 1 then
		return;
	end;
	if p154 <= -43 then
		if v52 ~= false then
			u184 = tick();
			l__workspace__1.ServerStuff.dealDamage:FireServer("fall_damage", nil, v5, v4);
			l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "falldamage1", character.Head);
			l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "falldamage2", character.Head);
			local l__Crp__1638 = require(l__game__7.Workspace.ServerStuff.Statistics.S_STATISTICS).Crp;
			l__Crp__1638.intensity = 4;
			afflictstatus(l__Crp__1638);
			afflictstatus(require(l__game__7.Workspace.ServerStuff.Statistics.S_STATISTICS).Tnt);
			shakecamera("damage", { 10 });
			return;
		end;
	else
		return;
	end;
	l__workspace__1.ServerStuff.playAudio:FireServer({ "perks" }, "fallnullified", character.Head);
	l__workspace__1.ServerStuff.applyGore:FireServer("fall_nullified", character, ply, nil);
end;
local function u192()
	local v1639 = nil;
	local v1640, v1641 = raycastline(l__CurrentCamera__1.CFrame.p, l__CurrentCamera__1.CFrame.LookVector, 5, baselayer);
	u102 = 0;
	local v1642 = nil;
	if v1640 then
		if v1640.Name == "JointGrip" then
			v1642 = "Item";
		elseif v1640.Name == "Interact" then
			v1642 = "Interaction";
		end;
		v1639 = v1640.Parent;
	end;
	local v1643 = 4;
	if v1639 == nil and v1642 == nil then
		for v1644, v1645 in pairs(l__workspace__1.WeaponDrops:GetChildren()) do
			if v1645:FindFirstChild("JointGrip") and (v1645.JointGrip.CFrame.p - v1641).magnitude < v1643 and v1645:FindFirstChild("JointGrip").Locked == false then
				v1643 = (v1645.JointGrip.CFrame.p - v1641).magnitude;
				v1639 = v1645;
				if v1645:FindFirstChild("JointGrip") then
					v1642 = "Item";
				elseif v1645:FindFirstChild("Interact") then
					v1642 = "Interactable";
				end;
			end;
		end;
	end;
	if v1639 and craftlist[u17.name] then
		if craftlist[u17.name][v1639.Name] then
			v1642 = { craftlist[u17.name][v1639.Name], v18[craftlist[u17.name][v1639.Name]].name };
		elseif v1639.Name == "Model" and craftlist[u17.name][v1639.Parent.Name] then
			v1642 = { craftlist[u17.name][v1639.Parent.Name], v18[craftlist[u17.name][v1639.Parent.Name]].name };
		end;
	end;
	maingui.Centre.craftingmarker.Visible = false;
	maingui.Centre.interactmarker.Visible = false;
	maingui.Centre.pickupmarker.Visible = false;
	local v1646 = false;
	if v1639 and u9.action == false and v1642 then
		maingui.Centre.crosshair.Visible = false;
		if v1642 == "Item" then
			local v1647 = v18[v1639.Name];
			local v1648 = "Item";
			if v1647.weapontype == "Bludgeon" or v1647.weapontype == "Axe" or v1647.weapontype == "Spear" or v1647.weapontype == "Blade" then
				v1648 = "Primary";
			end;
			if v1648 == "Primary" then
				if v6[1][1] == "Fist" then
					v1646 = true;
				end;
			else
				for v1649, v1650 in pairs(v6) do
					if v1650[1] == "Fist" and v1649 ~= 1 then
						v1646 = true;
						break;
					end;
				end;
				if v1647.name == u17.name and u19:FindFirstChild("ammo") and u19.ammo:FindFirstChild("maxammo") then
					local v1651 = nil;
					for v1652, v1653 in pairs(v6) do
						if v1653[2] == true then
							v1651 = v1653[3];
						end;
					end;
					v1646 = v1651 < u19.ammo.maxammo.Value;
				end;
			end;
			maingui.Centre.pickupmarker.Visible = true;
			if v1646 == true then
				maingui.InteractFrame.dispText.Text = "TAKE";
				if v1647.name == u17.name and u19:FindFirstChild("ammo") and u19.ammo:FindFirstChild("maxammo") then
					maingui.InteractFrame.dispText.Text = "REFILL";
				end;
				maingui.InteractFrame.intText.Text = v1647.name;
				if v1639 and v1639:FindFirstChild("skinned") and v20[v1639:FindFirstChild("skinned").Value] then
					maingui.InteractFrame.intText.Text = v20[v1639:FindFirstChild("skinned").Value].name;
				end;
				maingui.InteractFrame.Visible = true;
				u103 = v1639;
				return;
			else
				maingui.InteractFrame.dispText.Text = "FULL";
				if v1647.name == u17.name and u19:FindFirstChild("ammo") and u19.ammo:FindFirstChild("maxammo") then
					maingui.InteractFrame.dispText.Text = "FULL";
				end;
				maingui.InteractFrame.intText.Text = v1647.name;
				maingui.InteractFrame.Visible = true;
				u103 = nil;
				return;
			end;
		elseif v1642 == "Interaction" then
			maingui.Centre.interactmarker.Visible = true;
			maingui.InteractFrame.dispText.Text = "INTERACT";
			maingui.InteractFrame.intText.Text = v1639.Name;
			maingui.InteractFrame.Visible = true;
			if v1639:FindFirstChild("stats") and v1639:FindFirstChild("stats"):FindFirstChild("cost") then
				u102 = v1639:FindFirstChild("stats"):FindFirstChild("cost").Value;
			end;
			u103 = { v1639 };
			return;
		elseif typeof(v1642) == "table" then
			maingui.Centre.craftingmarker.Visible = true;
			maingui.InteractFrame.dispText.Text = "CRAFT";
			maingui.InteractFrame.intText.Text = v1642[2];
			maingui.InteractFrame.Visible = true;
			u103 = { "craft", v1639, v1642[2] };
			return;
		end;
	else
		if u9.aiming == false and maingui.Centre.crosshair.Visible == false then
			maingui.Centre.crosshair.Visible = true;
		end;
		maingui.InteractFrame.Visible = false;
		u103 = nil;
	end;
end;
spectatenum = 1;
function beginspectate(p155)
	local v1654 = l__workspace__1.activePlayers:GetChildren();
	if teamfolder ~= nil then
		v1654 = teamfolder:GetChildren();
	end;
	if forcespecfolder == true then
		local v1655 = {};
		local v1656, v1657, v1658 = ipairs(l__workspace__1.GamemodeStuff:FindFirstChild("TeamA"):GetChildren());
		while true do
			local v1659, v1660 = v1656(v1657, v1658);
			if v1659 then

			else
				break;
			end;
			v1658 = v1659;
			table.insert(v1654, v1660);		
		end;
		local v1661, v1662, v1663 = ipairs(l__workspace__1.GamemodeStuff:FindFirstChild("TeamB"):GetChildren());
		while true do
			local v1664, v1665 = v1661(v1662, v1663);
			if v1664 then

			else
				break;
			end;
			v1663 = v1664;
			table.insert(v1654, v1665);		
		end;
	end;
	local v1666 = v1654[spectatenum];
	if spectatenum < 1 then
		v1666 = v1654[#v1654];
	end;
	if v1666 ~= nil then
		if v1666:FindFirstChild("HumanoidRootPart") then

		else
			spectatenum = 1;
			if 0 < #v1654 then
				beginspectate(p155);
			end;
			return;
		end;
	else
		spectatenum = 1;
		if 0 < #v1654 then
			beginspectate(p155);
		end;
		return;
	end;
	l__CurrentCamera__1.CameraType = "Follow";
	l__CurrentCamera__1.CameraSubject = v1666:FindFirstChild("HumanoidRootPart");
	p155.spectate.current.Text = v1666.Name;
end;
function spectatesystem(p156)
	spectating = true;
	l__CurrentCamera__1.CameraType = "Follow";
	l__CurrentCamera__1.CameraSubject = l__workspace__1.mapCentre;
	beginspectate(p156);
	p156.status.spectate.Visible = false;
	p156.status.spectate.Text = "VIEW AUTOPSY";
	p156.redScreen:Destroy();
	p156.hunted.Visible = false;
	p156.status.textabove.Position = UDim2.new(0.5, 0, 0.4, -165);
	p156.status.reports.Position = UDim2.new(0.5, 0, 0.4, 0);
	p156.status.textabove.Visible = false;
	p156.status.reports.Visible = false;
	p156.status.confirm.Visible = false;
	p156.status.menu.Text = "MAIN MENU";
	p156.spectate.Visible = true;
	local v1667 = tick();
	while true do
		p156.status.Position = p156.status.Position:Lerp(UDim2.new(0.5, 0, 1, 0), 0.05);
		p156.blackbar1.Position = p156.blackbar1.Position:Lerp(UDim2.new(0, 0, 0, -180), 0.1);
		p156.blackbar2.Position = p156.blackbar2.Position:Lerp(UDim2.new(0, 0, 1, 180), 0.1);
		RS:wait();
		if not (2 <= tick() - v1667) then

		else
			break;
		end;	
	end;
	p156.spectate.next.MouseButton1Click:connect(function()
		spectatenum = spectatenum + 1;
		beginspectate(p156);
	end);
	p156.spectate.prev.MouseButton1Click:connect(function()
		spectatenum = spectatenum - 1;
		beginspectate(p156);
	end);
end;
l__game__7:GetService("RunService"):BindToRenderStep("rsloop", 250, function()
	if u9.sprinting == true and u9.action == false and u9.air == false then
		u185 = lerp(u185, -0.4, 0.035);
	else
		u185 = lerp(u185, 0, 0.05);
	end;
	if u9.action == false and u9.swapping == false and u9.channel == false and u9.startswap == false and u9.staggering == false then
		if tick() - idletimepassed >= 1 then
			idletimepassed = tick();
			if tpcurrentanimset.block then
				tpcurrentanimset.block:Stop();
			end;
		end;
	else
		if u9.blocking == true then
			if tick() - idletimepassed >= 1 then
				idletimepassed = tick();
				if tpcurrentanimset.block then
					tpcurrentanimset.block:Play();
					tpcurrentanimset.block.TimePosition = 0.3;
					tpcurrentanimset.block:AdjustSpeed(0);
				end;
			end;
		elseif tpcurrentanimset.block then
			tpcurrentanimset.block:Stop();
		end;
		idletimepassed = tick();
	end;
	if character:FindFirstChild("Head") and (character.Head:FindFirstChild("breathingFX") and tick() - breathetimer >= 8) then
		breathetimer = tick() + math.random(1, 4);
		l__workspace__1.ServerStuff.BREATHE:FireServer();
	end;
	if playerperks.desp then
		if hum.Health < v7.desp.efx[1] then
			if perksactive.desp == nil then
				perksactive.desp = true;
				u21 = u21 + v7.desp.efx[2] / 100;
			end;
		elseif perksactive.desp == true then
			perksactive.desp = nil;
			u21 = u21 - v7.desp.efx[2] / 100;
		end;
	end;
	if playerperks.octopus and hum.Health < v7.octopus.efx[1] and perksactive.octopus == nil then
		perksactive.octopus = true;
		l__workspace__1.ServerStuff.dealDamage:FireServer("dropsmoke", nil, v5, v4);
	end;
	if playerperks.second and hum.Health < v7.second.efx[1] and perksactive.second == nil then
		perksactive.second = true;
		u8 = u8 + 100;
		delay(v7.second.efx[3], function()
			perksactive.second = nil;
		end);
	end;
	if v60[2].nothirstmod == true then
		ration_system_handler.thirst = tick();
	end;
	local v1668 = CFrame.new();
	if (u17.animset == "RV" or u17.animset == "PST" or u17.animset == "2HPST") and u9.aiming == false and playerstats.Class == "revolver" and u9.using_perk == false and akimbo_factors.active == false then
		v1668 = CFrame.new(0.5, 0, -1) * CFrame.Angles(0, math.rad(30), math.rad(-4));
	end;
	if u17.animset == "RV" or u17.animset == "PST" or u17.animset == "RFL" or u17.animset == "SMG" or u17.animset == "ASMG" or u17.animset == "2HPST" then
		if tick() - gun_holster_timer > 3 then
			local v1669 = globalanimsets.holster_rifle;
			if u17.animset == "RV" or u17.animset == "PST" or u17.animset == "2HPST" then
				v1669 = globalanimsets.holster_pistol;
				if playerstats.Class == "revolver" then
					v1669 = nil;
				end;
			elseif u17.animset == "SMG" then
				v1669 = globalanimsets.holster_smg;
			end;
			if akimbo_factors.active == true then
				v1669 = globalanimsets.holster_akimbo;
			end;
			if v1669 ~= nil and v1669.IsPlaying == false then
				v1669:Play(0.5, 1, 1);
			end;
		else
			globalanimsets.holster_pistol:Stop(0.1);
			globalanimsets.holster_rifle:Stop(0.1);
			globalanimsets.holster_smg:Stop(0.1);
			globalanimsets.holster_akimbo:Stop(0.1);
		end;
		if u9.action == true or u9.firing == true or u9.swapping == true or u9.staggering == true or u9.aiming == true or u9.shoving == true then
			gun_holster_timer = tick();
		end;
	else
		globalanimsets.holster_pistol:Stop(0);
		globalanimsets.holster_rifle:Stop(0);
		globalanimsets.holster_smg:Stop(0);
	end;
	local v1670 = u78;
	if not (not u10["Stamina Buff"]) or not (not u10["Artillerist Buff"]) or u10["Koldera Buff"] then
		v1670 = 0.02;
	end;
	local v1671 = UIS:GetMouseDelta();
	move_delta = move_delta:Lerp(CFrame.Angles(math.clamp(math.rad(v1671.y) / 6, -0.35, 0.35), math.clamp(math.rad(v1671.x) / 8, -0.35, 0.35), math.clamp(math.rad(v1671.x) / 6, -0.35, 0.35)), 0.2);
	if u9.walking == true and u11 > 0.1 then
		tpglobalanimsets.run:AdjustWeight(hum.WalkSpeed / 18);
		tpglobalanimsets.run:AdjustSpeed(0.6 + hum.WalkSpeed / 40);
		u186 = 8 * hum.WalkSpeed / 18;
		local v1672 = move_delta;
		if u9.aiming == true then
			v1672 = CFrame.Angles(0, 0, 0);
		end;
		u118 = u118:Lerp(CFrame.new(math.cos(time() * 6 * u186 / 8) * 0.2 / 2 * v1670, 0, math.sin(time() * 14 * u186 / 8) * 0.075 / 2 * v1670) * u57 * v1668 * v1672, 0.3);
		local v1673 = 0;
		if u10.Cripple and u10.Painkillers == nil then
			v1673 = math.clamp(math.cos(time() * 6) * 0.05, -10000, 0);
		end;
		u117 = u117:Lerp(CFrame.Angles(math.sin(time() * 8 * u186 / 8) * 0.075 / 6 * v1670, math.cos(time() * 4 * u186 / 8) * 0.2 / 6 * v1670, v1673), 0.3);
	else
		if u9.aiming == false then
			u118 = u118:Lerp(CFrame.new(0, 0, math.cos(time() * 1.5) * 0.05) * u57 * v1668 * move_delta, 0.3);
		else
			u118 = u118:Lerp(CFrame.new(0, 0, 0) * u57, 0.3);
		end;
		u117 = u117:Lerp(CFrame.Angles(0, 0, 0), 0.2);
	end;
	if chattertime <= tick() - lastchatter then
		if startperk.Value == "hiddenB" then
			u56("taunt");
		else
			u56("chatter");
		end;
	end;
	if u9.air == false then
		groundedtimer = tick();
	end;
	if playerperks.regen and hum.Health < hum.MaxHealth and v7.regen.efx[1] < tick() - u187 then
		u187 = tick();
		l__workspace__1.ServerStuff.dealDamage:FireServer("regenperk", nil, v5, v4);
	end;
	local v1674 = 300;
	local v1675 = true;
	local v1676 = true;
	if l__workspace__1.GamemodeStuff:FindFirstChild("outerGas") and startperk.Value ~= "hubbing" then
		local v1677 = math.clamp(l__workspace__1.GamemodeStuff:FindFirstChild("outerGas").Size.X / 2.1 - (character.HumanoidRootPart.Position - l__workspace__1.mapCentre.Position).magnitude, -300, 300);
		if (character.HumanoidRootPart.Position - l__workspace__1.mapCentre.Position).magnitude <= 150 and (character.HumanoidRootPart.Position - l__workspace__1.mapCentre.Position).magnitude <= 130 and (character.HumanoidRootPart.Position - l__workspace__1.mapCentre.Position).magnitude >= 70 then
			v1675 = false;
			u188 = lerp(u188, 30, 0.05);
		end;
		if v1674 <= 20 and u10.Toxins == nil then
			v1676 = false;
			v58.Volume = 1.2 - v1674 / 20;
		end;
		if l__workspace__1.GamemodeStuff:FindFirstChild("outerGas").Size.X / 2.1 <= (character.HumanoidRootPart.Position - l__workspace__1.mapCentre.Position).magnitude then
			afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Psn);
		elseif u97 == false and u10.Toxins then
			u10.Toxins.effects.currentduration = 0;
		end;
	end;
	if v1676 == true then
		if u10.Toxins == nil then
			if u72 == true then
				v58.Volume = 0.1;
			else
				v58.Volume = l__game__7.ReplicatedStorage.soundLibrary.general_ui.storm_ambience.Volume;
			end;
		else
			v58.Volume = 1.3;
		end;
	end;
	if v1675 == true then
		u188 = lerp(u188, 0, 0.1);
	end;
	if u21 >= 30 then
		ply:Kick(filth[math.random(1, #filth)]);
	end;
	if u20 >= 30 then
		ply:Kick(filth[math.random(1, #filth)]);
	end;
	if v1674 < 0 then
		v1674 = -v1674;
	end;
	l__game__7.Lighting.FogEnd = v1674 + u188;
	if startperk.Value ~= "hubbing" then
		if (character.HumanoidRootPart.Position - l__workspace__1.mapCentre.Position).magnitude >= 147.61904761904762 then
			if u189 == true then
				agent_speak("safeexit");
			end;
			u189 = false;
		else
			if u189 == false then
				agent_speak("safeenter");
			end;
			u189 = true;
		end;
	end;
	if u9.walking == true and u9.sprinting == false and u9.air == false and 7 / hum.WalkSpeed <= tick() - walkingtick then
		walkingtick = tick();
		v101({ "movement_sounds" }, "step" .. math.random(1, 4), nil, nil, true, true);
	end;
	if maingui.Centre.crosshair.Visible == true then
		maingui.Centre.crosshair.A1.Position = UDim2.new(0.5, 0, 0.5, -5);
		maingui.Centre.crosshair.A2.Position = UDim2.new(0.5, 0, 0.5, 5);
		maingui.Centre.crosshair.B1.Position = UDim2.new(0.5, -5, 0.5, 0);
		maingui.Centre.crosshair.B2.Position = UDim2.new(0.5, 5, 0.5, 0);
		if (u17.weapontype == "Bow" or u17.weapontype == "Gun") and (u17.weapontype == "Gun" and u9.aiming == false or u17.weapontype == "Bow" and u9.walking == true) then
			local v1678 = u17.sizerating * 3.5;
			local v1679 = math.clamp(v1678 - v1678 * v41, 1.5, 30);
			maingui.Centre.crosshair.A1.Position = UDim2.new(0.5, 0, 0.5, -5 - v1679);
			maingui.Centre.crosshair.A2.Position = UDim2.new(0.5, 0, 0.5, 5 + v1679);
			maingui.Centre.crosshair.B1.Position = UDim2.new(0.5, -5 - v1679, 0.5, 0);
			maingui.Centre.crosshair.B2.Position = UDim2.new(0.5, 5 + v1679, 0.5, 0);
		end;
		if u9.throwing == true then
			maingui.Centre.crosshair.B1.Position = UDim2.new(0.5, -10, 0.5, 0);
			maingui.Centre.crosshair.B2.Position = UDim2.new(0.5, 10, 0.5, 0);
		end;
	end;
	if teamfolder ~= nil and tick() - updateteamhealth >= 0.3 then
		updateteamhealth = tick();
		for v1680, v1681 in pairs(teamfolder:GetChildren()) do
			if maingui.teammatesframe:FindFirstChild(v1681.Name) and v1681:FindFirstChild("Humanoid") then
				maingui.teammatesframe:FindFirstChild(v1681.Name).empty.bar.Size = UDim2.new(v1681:FindFirstChild("Humanoid").Health / v1681:FindFirstChild("Humanoid").MaxHealth, 0, 1, 0);
				maingui.teammatesframe:FindFirstChild(v1681.Name).exact_health.Text = math.ceil(v1681:FindFirstChild("Humanoid").Health);
			elseif maingui.teammatesframe:FindFirstChild(v1681.Name) == nil and v1681:FindFirstChild("Humanoid") and v1681.Name ~= ply.Name then
				local v1682 = maingui.teammatesframe.ex:Clone();
				v1682.Name = v1681.Name;
				v1682.exact_health.Text = math.ceil(v1681:FindFirstChild("Humanoid").Health);
				v1682.empty.bar.Size = UDim2.new(v1681:FindFirstChild("Humanoid").Health / v1681:FindFirstChild("Humanoid").MaxHealth, 0, 1, 0);
				v1682.playername.Text = v1681.Name;
				v1682.Visible = true;
				v1682.Position = UDim2.new(0, 0, 1, 70 - 70 * #maingui.teammatesframe:GetChildren());
				v1682.Parent = maingui.teammatesframe;
			end;
		end;
		for v1683, v1684 in pairs(maingui.teammatesframe:GetChildren()) do
			if teamfolder:FindFirstChild(v1684.Name) == nil and v1684.Name ~= "ex" then
				v1684:Destroy();
				u190();
			end;
		end;
	end;
	if startperk.Value == "emperor" or startperk.Value == "commander" or startperk.Value == "jElimB" or startperk.Value == "hiddenB" then
		afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Rge);
	end;
	if startperk.Value == "hiddenB" or shadowForm == true then
		afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Slc);
		afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Rge);
		u8 = 100;
	end;
	if juggernaut == true then
		u8 = 100;
	end;
	if startperk.Value == "jElimB" then
		afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS)["Muscle Milk"]);
	end;
	if v53 == true then
		if u10.Bleed then
			u10.Bleed.effects.currentduration = 0;
		end;
		if u10["Arterial Bleed"] then
			u10["Arterial Bleed"].effects.currentduration = 0;
		end;
	end;
	if v55 == true and u10.Fracture then
		u10.Fracture.effects.currentduration = 0;
	end;
	if v54 == true and u10.Cripple then
		u10.Cripple.effects.currentduration = 0;
	end;
	if tick() - inner_dialogue <= 5 then
		maingui.Thought.thoughttext.TextTransparency = lerp(maingui.Thought.thoughttext.TextTransparency, 0.2, 0.05);
		maingui.Thought.thoughttext.TextStrokeTransparency = lerp(maingui.Thought.thoughttext.TextStrokeTransparency, 0, 0.05);
	else
		maingui.Thought.thoughttext.TextTransparency = lerp(maingui.Thought.thoughttext.TextTransparency, 1, 0.05);
		maingui.Thought.thoughttext.TextStrokeTransparency = lerp(maingui.Thought.thoughttext.TextStrokeTransparency, 1, 0.05);
	end;
	maingui.HurtOverlay.ImageTransparency = hum.Health / hum.MaxHealth * 1.7 + math.cos(time() * math.clamp(hum.MaxHealth / hum.Health, 0, 8)) * 0.075;
	maingui.HurtOverlayA.ImageTransparency = maingui.HurtOverlay.ImageTransparency + 0.1;
	maingui.HurtOverlayB.ImageTransparency = maingui.HurtOverlay.ImageTransparency + 0.1;
	if startperk.Value ~= "hubbing" and v60 and v60[3] and v60[3].cooldown then
		local v1685 = (tick() - u111) / v60[3].cooldown;
		maingui.PerkFrame.status.Text = math.round(math.clamp(v1685, 0, 1) * 100) .. "%";
		if v60[3].multicooldown then
			maingui.PerkFrame.multiple.Text = "x" .. math.floor(math.clamp(tick() - u111, 0, v60[3].cooldown) / v60[3].multicooldown);
		end;
		if v60[3].inverse_cd then
			maingui.PerkFrame.status.Text = 100 - math.round(math.clamp(v1685, 0, 1) * 100) .. "%";
		end;
		if v1685 >= 1 then
			if cd_ping == false then
				v101({ "perks" }, "perk_ping", nil, nil, true, true);
				cd_ping = true;
			end;
		else
			cd_ping = false;
		end;
	end;
	if u8 < v62 and tick() - u14.stamregen > 0.5 then
		local v1686 = u15;
		if u9.walking == true then
			v1686 = v1686 + 0.05;
		end;
		if v1686 < tick() - u14.regentick then
			u14.regentick = tick();
			u8 = u8 + 1;
			u26("stamina");
		end;
	end;
	if sprint_stam < 100 and u9.sprinting == false then
		if u10.Exhaustion == nil then
			sprint_stam = sprint_stam + 0.3 + buff_sprint_stam;
		end;
	elseif sprint_stam > 100 then
		sprint_stam = 100;
	end;
	u26("sprint_stam");
	if raycastline(character.HumanoidRootPart.Position, -character.HumanoidRootPart.CFrame.upVector, 4, baselayer) then
		u9.air = false;
	else
		if u9.air == false and tick() - fall_sfx_tick >= 0.6 then
			fall_sfx_tick = tick();
		end;
		u9.air = true;
		if raycastline(character.HumanoidRootPart.Position, -character.HumanoidRootPart.CFrame.upVector, 5.5, baselayer) then
			if tick() - fall_sfx_tick >= 0.6 then
				fall_sfx_tick = tick();
				l__workspace__1.ServerStuff.playAudio:FireServer({ "movement_sounds" }, "fall", character.Torso);
				shakecamera("jumpland");
			end;
			if tick() - groundedtimer >= 1 then
				u191(character.HumanoidRootPart.Velocity.y);
			end;
		end;
	end;
	if raycastline(character.HumanoidRootPart.Position + character.HumanoidRootPart.CFrame.lookVector * 7, character.HumanoidRootPart.CFrame.upVector, 60, baselayer) and raycastline(character.HumanoidRootPart.Position - character.HumanoidRootPart.CFrame.lookVector * 7, character.HumanoidRootPart.CFrame.upVector, 60, baselayer) and raycastline(character.HumanoidRootPart.Position + character.HumanoidRootPart.CFrame.rightVector * 7, character.HumanoidRootPart.CFrame.upVector, 60, baselayer) and raycastline(character.HumanoidRootPart.Position - character.HumanoidRootPart.CFrame.lookVector * 7, character.HumanoidRootPart.CFrame.upVector, 60, baselayer) then
		if l__game__7:GetService("SoundService").AmbientReverb ~= Enum.ReverbType.ParkingLot then
			u72 = true;
			l__game__7:GetService("SoundService").AmbientReverb = Enum.ReverbType.ParkingLot;
		end;
	elseif l__game__7:GetService("SoundService").AmbientReverb ~= Enum.ReverbType.Mountains then
		u72 = false;
		l__game__7:GetService("SoundService").AmbientReverb = Enum.ReverbType.Mountains;
	end;
	hum.WalkSpeed = math.clamp((u11 + u22) * u89, 1, 100);
	character.HumanoidRootPart.CFrame = CFrame.new(character.HumanoidRootPart.Position) * CFrame.Angles(0, -math.atan2(l__CurrentCamera__1.CFrame.lookVector.Z, l__CurrentCamera__1.CFrame.lookVector.X) + math.rad(-90), 0);
	local v1687 = CFrame.Angles(0, 0, 0);
	for v1688, v1689 in pairs(u27) do
		v1687 = v1687 * v1689;
	end;
	if spectating == false then
		adjustcamto = adjustcamto:Lerp(u31, 0.075);
		l__CurrentCamera__1.CFrame = CFrame.new(character.HumanoidRootPart.Position + adjustcamto) * CFrame.Angles(0, u157.X, 0) * CFrame.Angles(u157.Y, 0, 0) * u117 * v1687;
		l__CurrentCamera__1.CameraType = "Custom";
		l__CurrentCamera__1.CameraSubject = hum;
		ply.CameraMode = "LockFirstPerson";
		if u9.aiming == false then
			ajustarmposto = ajustarmposto:Lerp(ajustarmpos, 0.1);
		else
			ajustarmposto = ajustarmposto:Lerp(CFrame.new(0, 0, 0), 0.1);
		end;
		cpart.CFrame = l__CurrentCamera__1.CFrame;
		camroot.CFrame = cpart.CFrame * CFrame.new(0, -1 + u185, 0.3) * ajustarmposto * CFrame.Angles(math.rad(-90 + u185 * 20), 0, math.rad(180 - u185 * 20)) * u118 * u90;
		local v1690 = 1 + baseadsmod;
		if u17.animset == "PST" or u17.animset == "2HPST" or u17.animset == "RV" then
			v1690 = v1690 + 1;
		end;
		if u10["Speed Buff"] then
			v1690 = v1690 + 2;
		end;
		if u10["Artillerist Buff"] then
			v1690 = v1690 + 1;
		end;
		local v1691 = baseadstime / v1690;
		local v1692 = math.clamp(tick() - baseadstick, 0, v1691) / v1691;
		if u9.aiming == true and u17.weapontype == "Gun" then
			camroot.camRootWeld.C0 = camroot.camRootWeld.C0:Lerp(fparms.ROOT.CFrame:toObjectSpace(u19.ADS.CFrame * CFrame.new(0, -1, -1.75) * CFrame.Angles(math.rad(-90), 0, 0)):inverse(), v1692);
		else
			camroot.camRootWeld.C0 = camroot.camRootWeld.C0:Lerp(CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, 0), 0.05);
		end;
	end;
	u192();
	if maingui:FindFirstChild("devbox") and maingui:FindFirstChild("devbox").Visible == true then
		maingui.devbox.devlabel1.Text = "ATK : " .. u21 + u40;
		maingui.devbox.devlabel2.Text = "DEF : " .. u20;
		maingui.devbox.devlabel3.Text = "ADDED MVMT : " .. u22;
	end;
end);
hum.Died:connect(function()
	l__game__7:GetService("StarterGui"):SetCore("ResetButtonCallback", false);
	if resetBindable then
		resetBindable:Destroy();
	end;
	if deathactivated ~= false then
		return;
	end;
	deathactivated = true;
	if v109.damagetaken >= 200 then
		l__workspace__1.ServerStuff.adjustStats:FireServer("tracker", { "Tanked200", 1 });
	end;
	if v109.damage <= 50 then
		l__workspace__1.ServerStuff.adjustStats:FireServer("tracker", { "LowDamageMoment", 1 });
	end;
	u9.staggering = true;
	u9.aiming = false;
	l__game__7:GetService("SoundService").AmbientReverb = Enum.ReverbType.Mountains;
	l__game__7:GetService("SoundService").regular.Volume = 1;
	maingui.Enabled = false;
	if maingui:FindFirstChild("visor") then
		maingui:FindFirstChild("visor"):Destroy();
	end;
	if cc then
		cc.Parent = nil;
	end;
	if playerstats.Class == "damn" then
		spawn(function()
			local l__cuffs__1693 = character:WaitForChild("cuffs");
			if l__cuffs__1693 then
				l__cuffs__1693.beam.Enabled = true;
			end;
		end);
	end;
	v109.placed = #l__workspace__1.activePlayers:GetChildren();
	l__workspace__1.ServerStuff.adjustStats:FireServer("stats", { "MainStats", 1, nil, "Deaths" });
	character.HumanoidRootPart.Anchored = true;
	ply.CameraMode = "Classic";
	l__game__7:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true);
	UIS.MouseIconEnabled = true;
	u108 = function()

	end;
	u110 = function()

	end;
	u107:Disconnect();
	u109:Disconnect();
	v1425:Disconnect();
	v110:Disconnect();
	pcall(function()
		l__game__7:GetService("RunService"):UnbindFromRenderStep("rsloop");
	end);
	v1604:Disconnect();
	for v1694, v1695 in ipairs(l__workspace__1.NoTarget:GetChildren()) do
		if v1695.Name == "colBox" then
			v1695:Destroy();
		end;
	end;
	for v1696, v1697 in ipairs(l__CurrentCamera__1:GetChildren()) do
		v1697:Destroy();
	end;
	RS:wait();
	l__CurrentCamera__1.CameraType = Enum.CameraType.Scriptable;
	local l__Torso__1698 = character:FindFirstChild("Torso");
	if l__Torso__1698 ~= nil then
		l__CurrentCamera__1.FieldOfView = 40;
		l__CurrentCamera__1.CameraSubject = l__Torso__1698;
		local u193 = false;
		spawn(function()
			local v1699 = 6.3;
			local v1700, v1701 = raycastline(l__CurrentCamera__1.CFrame.p, -l__CurrentCamera__1.CFrame.lookVector, 6.3, baselayer);
			if v1700 then
				v1699 = (l__CurrentCamera__1.CFrame.p - v1701).magnitude;
			end;
			l__CurrentCamera__1.CFrame = l__Torso__1698.CFrame * CFrame.new(v1699, 1, -5) * CFrame.Angles(math.rad(-10), math.rad(110), 0);
			while true do
				fparms.Parent = nil;
				local v1702, v1703 = raycastline(l__CurrentCamera__1.CFrame.p, -l__CurrentCamera__1.CFrame.lookVector, 6.3, baselayer);
				if v1702 and (l__CurrentCamera__1.CFrame.p - v1703).magnitude <= v1699 then
					v1699 = (l__CurrentCamera__1.CFrame.p - v1703).magnitude;
				end;
				l__CurrentCamera__1.CFrame = CFrame.new(l__Torso__1698.CFrame.p) * CFrame.new(v1699, 1, -3) * CFrame.Angles(math.rad(-10), math.rad(110), 0);
				RS:wait();
				if u193 == true then
					break;
				end;			
			end;
		end);
	end;
	l__workspace__1.ServerStuff.dropAmmo:FireServer("agent_container", { u64, u16, { ration_system_handler.Beans, ration_system_handler.MRE, ration_system_handler.Soda, ration_system_handler.Bottle } });
	l__workspace__1.ServerStuff.deathPlay:FireServer();
	local u194 = false;
	delay(1.5, function()
		v101({ "deaths" }, "suspense", nil, nil, true, true);
		delay(1.05, function()
			l__game__7:GetService("SoundService").regular.Volume = 0;
			ply.PlayerGui.fadetoblack.frame.BackgroundTransparency = 0;
			u194 = true;
			delay(1, function()
				l__game__7:GetService("SoundService").regular.Volume = 1;
				l__game__7.Lighting.FogStart = 0;
				l__game__7.Lighting.FogEnd = 100;
				local v1704 = l__game__7.ReplicatedStorage.effects.endgamegui:Clone();
				v1704.status.Position = UDim2.new(0.5, 0, 1, 0);
				v1704.status.menu.Visible = true;
				v1704.status.spectate.Visible = false;
				v1704.Parent = ply.PlayerGui;
				v1704.Enabled = true;
				ply.CameraMode = "Classic";
				UIS.MouseIconEnabled = true;
				maingui.Enabled = false;
				spectatesystem(v1704);
				v1704.status.spectate.Visible = false;
				v1704.status.menu.MouseButton1Click:connect(function()
					if u138 == true then
						return;
					end;
					u138 = true;
					while true do
						ply.PlayerGui.fadetoblack.frame.BackgroundTransparency = ply.PlayerGui.fadetoblack.frame.BackgroundTransparency - 0.03;
						RS:wait();
						if ply.PlayerGui.fadetoblack.frame.BackgroundTransparency <= 0 then
							break;
						end;					
					end;
					l__workspace__1.ServerStuff.spawnPlayer:FireServer("respawncharacter");
				end);
				spawn(function()
					while true do
						ply.PlayerGui.fadetoblack.frame.BackgroundTransparency = ply.PlayerGui.fadetoblack.frame.BackgroundTransparency + 0.1;
						RS:wait();
						if ply.PlayerGui.fadetoblack.frame.BackgroundTransparency >= 1 then
							break;
						end;					
					end;
					ply.PlayerGui.fadetoblack.frame.BackgroundTransparency = 1;
				end);
			end);
		end);
	end);
end);
u61("Fist");
l__game__7.Lighting.FogEnd = 300;
l__game__7.Lighting.FogStart = 0;
ply:WaitForChild("PlayerGui"):SetTopbarTransparency(0);
if startperk.Value == "turfwarA" or startperk.Value == "turfwarB" then
	alertplay("DAY 82: THE RECKONING");
end;
if startperk.Value == "emperor" then
	alertplay("YOU ARE THE EMPEROR");
	u80("EmperorA");
elseif startperk.Value == "commander" then
	alertplay("YOU ARE THE COMMANDER");
	u80("CMBody");
elseif startperk.Value == "hiddenB" then
	u80("HiddenArms");
elseif startperk.Value == "turfwarA" then
	delay(5, function()
		alertplay("LAW 0: ELIMINATE YOUR ENEMY AT ALL COSTS");
	end);
	u80("DSquadShirt");
elseif startperk.Value == "turfwarB" then
	delay(5, function()
		alertplay("GEAR UP, WE'RE BRINGING THE FIGHT TO THEM");
	end);
	u80("RISBody");
else
	u80(playerstats.EquippedCosmetics.Shirt, playerstats.CustomColours.Tops);
end;
if startperk.Value == "siegeA" then
	alertplay("FOLLOW THE EMPEROR");
elseif startperk.Value == "siegeB" then
	alertplay("PROTECT THE COMMANDER");
end;
delay(5, function()
	if startperk.Value == "siegeA" then
		alertplay("ELIMINATE THE COMMANDER");
		return;
	end;
	if startperk.Value == "siegeB" then
		alertplay("HOLD OFF THE EMPEROR");
	end;
end);
u26("health");
l__CurrentCamera__1.FieldOfView = 90;
u26("stamina");
if playerstats.Settings.Crosshair == false then
	maingui.Centre.crosshair.Visible = false;
end;
if startperk.Value == "normal" then
	ply.PlayerGui.fadetoblack.frame.BackgroundTransparency = 0;
	spawn(function()
		while true do
			ply.PlayerGui.fadetoblack.frame.BackgroundTransparency = ply.PlayerGui.fadetoblack.frame.BackgroundTransparency + 0.1;
			RS:wait();
			if ply.PlayerGui.fadetoblack.frame.BackgroundTransparency >= 1 then
				break;
			end;		
		end;
		ply.PlayerGui.fadetoblack.frame.BackgroundTransparency = 1;
	end);
	v109.timealive = tick();
	maingui.Enabled = true;
	teamfolder = character.Parent;
	maingui.teammatesframe.Visible = true;
	baselayer = { character, l__workspace__1.NoTarget, l__workspace__1.GoreEffects, l__CurrentCamera__1, teamfolder, l__workspace__1.PlayerShootThroughs, l__workspace__1.activeFriendlies };
elseif startperk.Value == "hubbing" then
	ply.PlayerGui.fadetoblack.frame.BackgroundTransparency = 0;
	u9.action = true;
	u9.staggering = true;
	u9.turnable = false;
	u11 = 0.001;
	local v1705 = l__game__7.ReplicatedStorage.effects.endgamegui:Clone();
	v1705.status.Position = UDim2.new(0.5, 0, 1, 0);
	v1705.status.menu.Visible = true;
	v1705.status.spectate.Visible = false;
	v1705.Parent = ply.PlayerGui;
	v1705.Enabled = true;
	character.HumanoidRootPart.Anchored = true;
	ply.CameraMode = "Classic";
	UIS.MouseIconEnabled = true;
	maingui.Enabled = false;
	spectatesystem(v1705);
	v1705.status.spectate.Visible = false;
	v1705.status.menu.MouseButton1Click:connect(function()
		if u138 == true then
			return;
		end;
		u138 = true;
		while true do
			ply.PlayerGui.fadetoblack.frame.BackgroundTransparency = ply.PlayerGui.fadetoblack.frame.BackgroundTransparency - 0.03;
			RS:wait();
			if ply.PlayerGui.fadetoblack.frame.BackgroundTransparency <= 0 then
				break;
			end;		
		end;
		l__workspace__1.ServerStuff.spawnPlayer:FireServer("respawncharacter");
	end);
	spawn(function()
		while true do
			ply.PlayerGui.fadetoblack.frame.BackgroundTransparency = ply.PlayerGui.fadetoblack.frame.BackgroundTransparency + 0.1;
			RS:wait();
			if ply.PlayerGui.fadetoblack.frame.BackgroundTransparency >= 1 then
				break;
			end;		
		end;
		ply.PlayerGui.fadetoblack.frame.BackgroundTransparency = 1;
	end);
end;
if startperk.Value ~= "hubbing" then
	l__CurrentCamera__1.CameraSubject = ply.Character.Humanoid;
	l__CurrentCamera__1.CameraType = "Custom";
end;
RS:wait();
if spectating == false then
	afflictstatus(require(l__game__7.Workspace.ServerStuff.Statistics.S_STATISTICS).VirusA);
end;
for v1706 = 1, 10 do
	if startperk.Value ~= "hubbing" then
		l__CurrentCamera__1.CFrame = CFrame.new(character.HumanoidRootPart.Position + u31) * CFrame.Angles(0, u157.X, 0) * CFrame.Angles(u157.Y, 0, 0);
		l__CurrentCamera__1.CameraSubject = ply.Character.Humanoid;
		l__CurrentCamera__1.CameraType = "Custom";
		character.HumanoidRootPart.Anchored = false;
		ply.CameraMode = "LockFirstPerson";
	end;
	l__CurrentCamera__1.FieldOfView = 90;
	RS:wait();
end;
u38(10, "HOME SUPPLIES");
if character:FindFirstChild("Outfit") and character:FindFirstChild("Outfit"):FindFirstChild("Bottom") then
	character:FindFirstChild("Outfit"):FindFirstChild("Bottom"):Clone().Parent = l__workspace__1.Camera;
end;