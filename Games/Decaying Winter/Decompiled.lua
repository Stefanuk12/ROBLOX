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
if playerstats.Settings.EnableCC == true then
	game.ReplicatedStorage.effects.ccFX:Clone().Parent = l__CurrentCamera__1;
end;
local v4 = _G.keyseed[_G.list[workspace.ServerStuff.ask:InvokeServer(script.Name, true)]];
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
local v5 = { { "Fist", true, nil }, { "Fist", false, nil }, { "Fist", false, nil }, { "Fist", false, nil } };
local v6 = require(workspace.ServerStuff.Statistics.P_STATISTICS);
playerperks = {};
perksactive = {};
for v7, v8 in ipairs(character:FindFirstChild("perks"):GetChildren()) do
	playerperks[v8.Name] = true;
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
	local v9 = "CMMaul";
	v5[1] = { v9, true, nil };
	nametag = "The Commander";
elseif startperk.Value == "emperor" then
	v9 = "EMSword";
	v5[1] = { v9, true, nil };
	nametag = "The Emperor";
elseif startperk.Value == "hiddenB" then
	chattertime = 10;
	v9 = "GhostKnife";
	v5[1] = { v9, true, nil };
	v5[2] = { "GhostBomb", false, nil };
	v5[3] = { "GhostBomb", false, nil };
	v5[4] = { "GhostBomb", false, nil };
	nametag = "The Hidden";
	game.ReplicatedStorage.effects.hiddenlight:Clone().Parent = character.Head;
elseif startperk.Value == "turfwarA" then
	v9 = "MMachete";
	v5[1] = { v9, true, nil };
	nametag = "Agent " .. dsdesignations[math.random(1, #dsdesignations)];
elseif startperk.Value == "turfwarB" then
	v9 = "MilAxe";
	v5[1] = { v9, true, nil };
	nametag = "Operative '" .. risdesignations[math.random(1, #risdesignations)] .. "'";
elseif startperk.Value == "siegeA" then
	v9 = "SSword";
	v5[1] = { v9, true, nil };
	if math.random(1, 2) == 1 then
		local v10 = { "DStim", "DEFStim", "SStim", "SPDStim", "AdrStim" };
		v5[2] = { v10[math.random(1, #v10)], false, 1 };
	end;
	if math.random(1, 50) == 1 then
		v5[2] = { "MPistol", false, 7 };
	end;
elseif startperk.Value == "siegeB" then
	local v11 = { "TCaltrop", "PTrap", "SSnare", "RExplosive" };
	local v12 = v11[math.random(1, #v11)];
	local v13 = 2;
	if v12 == "RExplosive" then
		v13 = 1;
	end;
	if v12 == "TCaltrop" then
		v13 = nil;
	end;
	v9 = "CRSpear";
	v5[1] = { v9, true, nil };
	v5[2] = { v12, false, v13 };
elseif startperk.Value == "tElimA" or startperk.Value == "tElimB" or startperk.Value == "jElimA" or startperk.Value == "hiddenA" or startperk.Value == "shadowGame" or startperk.Value == "coopvsDS" then
	v9 = playerstats.SelectedWep;
	v5[1] = { v9, true, nil };
	if startperk.Value == "hiddenA" or startperk.Value == "shadowGame" or startperk.Value == "coopvsDS" then
		local v14 = { { "SubAK", 30 }, { "SPShotgun", 9 }, { "Glock", 17 }, { "Rifle", 4 }, { "SubMG", 21 }, { "MPistol", 7 }, { "Deagle", 7 }, { "EBR", 20 }, { "Mac", 28 }, { "SubLMG", 50 }, { "SubVector", 25 }, { "ASVal", 30 } };
		local v15 = v14[math.random(1, #v14)];
		v5[2] = { v15[1], false, v15[2] };
	end;
elseif startperk.Value == "jElimB" then
	v9 = playerstats.SelectedWep;
	v5[1] = { v9, true, nil };
	v5[2] = { "EFlare", false, nil };
end;
if playerperks.tracker then
	for v16 = 1, #v5 do
		if v5[v16][1] == "Fist" and v16 ~= 1 then
			v5[v16] = { "PScanner", false, nil };
			break;
		end;
	end;
end;
local v17 = require(workspace.ServerStuff.Statistics.W_STATISTICS);
local v18 = require(workspace.ServerStuff.Statistics.CLASS_STATISTICS);
local v19 = require(workspace.ServerStuff.Statistics.Q_STATISTICS);
primwepset = v17[v9];
primanimset = game.ReplicatedStorage.animationSets:FindFirstChild(primwepset.animset);
tpprimanimset = game.ReplicatedStorage.animationSets.TPanimSets:FindFirstChild(primwepset.animset);
curentanimset = {};
tpcurrentanimset = {};
tauntchose = {};
tauntanimset = {};
tptauntanimset = {};
for v20, v21 in ipairs(game.ReplicatedStorage.animationSets.taunts:GetChildren()) do
	if v21:IsA("Animation") then
		tauntanimset[v21.Name] = fparms.AC:LoadAnimation(v21);
	end;
end;
for v22, v23 in ipairs(game.ReplicatedStorage.animationSets.TPanimSets.taunts:GetChildren()) do
	if v23:IsA("Animation") then
		tptauntanimset[v23.Name] = hum:LoadAnimation(v23);
	end;
end;
blocksets = {};
for v24, v25 in ipairs(game.ReplicatedStorage.animationSets.TPanimSets:GetChildren()) do
	if v25:FindFirstChild("block") then
		blocksets[v25.block.AnimationId] = true;
	end;
end;
local l__Debris__26 = game:GetService("Debris");
globalanimsets = {};
for v27, v28 in pairs(game.ReplicatedStorage.animationSets.global:GetChildren()) do
	if v28:IsA("Animation") then
		globalanimsets[v28.Name] = fparms.AC:LoadAnimation(v28);
	end;
end;
tpglobalanimsets = {};
for v29, v30 in pairs(game.ReplicatedStorage.animationSets.TPanimSets.global:GetChildren()) do
	if v30:IsA("Animation") then
		local v31 = hum:LoadAnimation(v30);
		v31.Priority = Enum.AnimationPriority.Idle;
		tpglobalanimsets[v30.Name] = v31;
	end;
end;
tpglobalanimsets.run.Priority = Enum.AnimationPriority.Movement;
tpglobalanimsets.crouch_idle.Priority = Enum.AnimationPriority.Action;
tpglobalanimsets.crouch_walk.Priority = Enum.AnimationPriority.Action;
tpglobalanimsets.stagger.Priority = Enum.AnimationPriority.Action;
akimbosets = {};
for v32, v33 in pairs(game.ReplicatedStorage.animationSets.AKMB:GetChildren()) do
	if v33:IsA("Animation") then
		akimbosets[v33.Name] = fparms.AC:LoadAnimation(v33);
	end;
end;
tpakimbosets = {};
for v34, v35 in pairs(game.ReplicatedStorage.animationSets.TPanimSets.AKMB:GetChildren()) do
	if v35:IsA("Animation") then
		tpakimbosets[v35.Name] = hum:LoadAnimation(v35);
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
local v36 = 0;
local v37 = 1;
local v38 = 1;
local v39 = 0;
local v40 = 0;
local v41 = 0;
local v42 = 0;
local v43 = 5;
local v44 = 12;
local v45 = 1;
local v46 = 1;
local v47 = 0;
local v48 = false;
local v49 = 0;
local v50 = true;
local v51 = true;
local v52 = false;
local v53 = false;
local v54 = false;
local v55 = false;
local v56 = false;
baseadstime = 6;
baseadstick = tick();
baseadsmod = 0;
local v57 = game.ReplicatedStorage.soundLibrary.general_ui.storm_ambience:Clone();
v57.Parent = character;
v57:Play();
local v58 = {};
local v59 = { "nothing", {}, {} };
local v60 = false;
local v61 = 100;
can_player_sprint = true;
if v18[playerstats.Class] ~= nil then
	v59 = { playerstats.Class, v18[playerstats.Class].basestats, v18[playerstats.Class].activestats };
	maingui.PerkFrame.iconimage.Image = "rbxassetid://" .. v18[playerstats.Class].icon;
	local v62, v63, v64 = pairs(v59[2]);
	while true do
		local v65 = nil;
		local v66 = nil;
		v66, v65 = v62(v63, v64);
		if not v66 then
			break;
		end;
		v64 = v66;
		if v66 == "atkmod" then
			v37 = v37 + v65 / 100;
		elseif v66 == "defmod" then
			v38 = v38 + v65 / 100;
		elseif v66 == "mvtmod" then
			v36 = v36 + 10 * v65 / 100;
		elseif v66 == "stammod" then
			v61 = v61 + v65;
		elseif v66 == "craftcostmod" then
			v43 = v43 + v65;
		elseif v66 == "accmod" then
			v40 = v40 + v65 / 100;
		elseif v66 == "scavmod" then
			v42 = v42 + v65 / 100;
		elseif v66 == "grap" then
			v50 = false;
		elseif v66 == "lightatkspeed" then
			v45 = v45 + v65 / 100;
		elseif v66 == "heavyatkspeed" then
			v46 = v46 + v65 / 100;
		elseif v66 == "shovemod" then
			v41 = v41 + v65 / 100;
		elseif v66 == "aimmod" then
			baseadsmod = baseadsmod + v65 / 100;
		elseif v66 == "nomorale" then
			v60 = true;
		elseif v66 == "no_sprint" then
			can_player_sprint = false;
		elseif v66 == "burnimmune" then
			v56 = true;
		elseif v66 == "bleed_immune" then
			v52 = true;
		elseif v66 == "explosive_resist" then
			v55 = true;
		elseif v66 == "frac_immune" then
			v54 = true;
		elseif v66 == "cripple_immune" then
			v53 = true;
		elseif v66 == "recoilmod" then
			v39 = v39 + v65 / 100;
		elseif v66 == "harvestmod" then
			v44 = v44 - v65;
		elseif v66 == "falldamagemod" then
			v51 = false;
		elseif v66 == "reloadmod" then
			v49 = v49 + v65 / 100;
		elseif v66 == "trapmod" then
			v47 = v47 + v65 / 100;
		elseif v66 == "drop_ranged" then
			v48 = true;
		elseif v66 == "backpack" then
			l__workspace__1.ServerStuff.dealDamage:FireServer("putbackpack", nil, v4);
			v5[6] = { "Fist", false, nil };
			maingui.InventoryFrame.slot6.Visible = true;
			v5[5] = { "Fist", false, nil };
			maingui.InventoryFrame.slot5.Visible = true;
		end;	
	end;
end;
if playerperks.reliab then
	v49 = v49 + v6.reliab.efx[1] / 100;
end;
if playerperks.boxer then
	v41 = v41 + v6.boxer.efx[2] / 100;
end;
if playerperks.recoil then
	v39 = v39 + v6.recoil.efx[1] / 100;
end;
if playerperks.manic then
	v46 = v46 + v6.manic.efx[1] / 100;
end;
if playerperks.violence then
	v45 = v45 + v6.violence.efx[1] / 100;
end;
if playerperks.paranoia then
	baseadsmod = baseadsmod + v6.paranoia.efx[1] / 100;
end;
fanning_levering = false;
fanning_firerate = 0.15;
levering_firerate = 0.3;
if playerperks.hip then
	v40 = v40 + v6.hip.efx[1] / 100;
	fanning_levering = true;
end;
if playerperks.rustic then
	v37 = v37 + v6.rustic.efx[1] / 100;
end;
if playerperks.tough then
	v38 = v38 + v6.tough.efx[1] / 100;
end;
if playerperks.leg then
	v36 = v36 + 10 * v6.leg.efx[1] / 100;
end;
emotelist = false;
cc = nil;
local v67 = 0;
if playerstats.Class == "sword" then
	local u2 = v36;
	local u3 = 10;
	function v58.losetags(p1, p2)
		if v58.dogtags and v58.dogtags > 0 then
			local v68 = math.ceil(v58.dogtags / (100 / v59[3].dogtagslostondamage));
			if p2 == true then
				v68 = math.ceil(math.clamp((hum.MaxHealth - hum.Health) / v59[3].healthperdogtag, 1, v58.dogtags));
				if v68 == 0 then
					v68 = 1;
				end;
			end;
			local v69 = v58.dogtags;
			if v59[3].dogtagmaxmovement < v69 then
				v69 = v59[3].dogtagmaxmovement;
			end;
			local v70 = math.clamp(v58.dogtags - v68 - v69, -1000, 0);
			v58.dogtags = v58.dogtags - v68;
			maingui.PerkFrame.numberstat.Text = v58.dogtags;
			if v70 < 0 then
				u2 = u2 - u3 * (v59[3].dogtagmovementbuff * -v70) / 100;
			end;
			if p2 == true then
				l__workspace__1.ServerStuff.dealDamage:FireServer("kiraheal", v68, v4);
			end;
		end;
	end;
	v58.dogtag_lose_timer = 0;
	v58.dogtag_lose_damage = 0;
elseif playerstats.Class == "fire" then
	v58.overheat_danger_cd = 0;
	local u4 = v67;
	local u5 = nil;
	function v58.apply_overheat(p3, p4)
		if p4 == true then
			if tick() - v58.overheat_grace_period <= v59[3].overheat_graceperiod then
				return;
			end;
			v59[3].overheat_graceperiod = tick();
		end;
		if v59[3].cooldown <= tick() - u4 then
			u4 = tick() - v59[3].cooldown;
		end;
		u4 = u4 + p3;
		if tick() - u4 <= 8 and tick() - v58.overheat_danger_cd >= 3 then
			v58.overheat_danger_cd = tick();
			spawn(function()
				u5({ "perks" }, "flamer_danger", nil, nil, true, true);
				local v71 = tick();
				maingui.PerkFrame.numberstat.Visible = true;
				maingui.PerkFrame.numberstat.Text = "!";
				for v72 = 1, 15 do
					local v73 = tick();
					if maingui.PerkFrame.numberstat.Text == "!" then
						maingui.PerkFrame.numberstat.Text = "";
					else
						maingui.PerkFrame.numberstat.Text = "!";
					end;
					while true do
						RS:wait();
						if tick() - v73 >= 0.075 then
							break;
						end;					
					end;
				end;
				maingui.PerkFrame.numberstat.Visible = false;
				maingui.PerkFrame.numberstat.Text = "";
			end);
		end;
		if tick() - u4 <= 0 then
			l__workspace__1.ServerStuff.dealDamage:FireServer("immolate", character, v4);
			l__workspace__1.ServerStuff.applyGore:FireServer("immolate_ability", character, ply, { character.Torso.CFrame - character.Torso.CFrame.upVector * 3 });
			l__workspace__1.ServerStuff.dealDamage:FireServer("immolator_overheated", {}, v4);
		end;
		return u4;
	end;
	v58.overheat_grace_period = 0;
	local u6 = 0;
	function v58.overheat_damage()
		while true do
			u6 = (v59[3].overheat_damage_buff - v59[3].overheat_damage_buff * (math.clamp(tick() - u4, 1, v59[3].cooldown) / v59[3].cooldown)) / 100;
			RS:wait();
			if hum.Health <= 0 then
				break;
			end;		
		end;
	end;
	spawn(v58.overheat_damage);
end;
v58.buffer_f_key = true;
hum.WalkSpeed = (10 + v36) * 1;
local v74 = 0.025;
if playerperks.recovery then
	v74 = v74 - v74 * v6.recovery.efx[1] / 100;
end;
local l__game__7 = game;
function update_player_challenges()
	local v75, v76, v77 = pairs(playerstats.PinnedChallenge);
	while true do
		local v78, v79 = v75(v76, v77);
		if v78 then

		else
			break;
		end;
		v77 = v78;
		if maingui.ChallengesFrame:FindFirstChild(v78) then
			local v80 = l__game__7.ReplicatedStorage.challenges:FindFirstChild(v78);
			if v80 then
				local v81 = require(v80);
				local v82 = 0;
				if playerstats.Trackers[v81.req] then
					v82 = math.floor(playerstats.Trackers[v81.req]);
				end;
				if v81.reqamount <= v82 then
					maingui.ChallengesFrame:FindFirstChild(v78).progbar.bar.Size = UDim2.new(1, 0, 0, 4);
					maingui.ChallengesFrame:FindFirstChild(v78).progresstext.Text = "COMPLETE";
					maingui.ChallengesFrame:FindFirstChild(v78).progresstext.TextColor3 = Color3.fromRGB(145, 255, 61);
				else
					maingui.ChallengesFrame:FindFirstChild(v78).progbar.bar.Size = UDim2.new(math.clamp(v82 / v81.reqamount, 0, 1), 0, 0, 4);
					maingui.ChallengesFrame:FindFirstChild(v78).progresstext.Text = v82 .. "/" .. v81.reqamount;
				end;
			end;
		end;	
	end;
end;
challengecount = 1;
for v83, v84 in pairs(playerstats.PinnedChallenge) do
	if l__game__7.ReplicatedStorage.challenges:FindFirstChild(v83) then
		maingui.ChallengesFrame["challenge" .. challengecount].Text = require(l__game__7.ReplicatedStorage.challenges:FindFirstChild(v83)).name;
		maingui.ChallengesFrame["challenge" .. challengecount].Visible = true;
		maingui.ChallengesFrame["challenge" .. challengecount].Name = v83;
		challengecount = challengecount + 1;
	end;
end;
update_player_challenges();
baselayer = { character, l__workspace__1.NoTarget, l__workspace__1.GoreEffects, l__CurrentCamera__1, l__workspace__1.PlayerShootThroughs, l__workspace__1.activeFriendlies };
function raycastline(p5, p6, p7, p8)
	local v85 = nil;
	local v86 = nil;
	local v87 = nil;
	local v88 = {};
	local v89 = 1 - 1;
	while true do
		local v90, v91, v92 = l__workspace__1:FindPartOnRayWithIgnoreList(Ray.new(p5, p6.unit * (p7 and 999.999)), v88);
		v85 = v90;
		v86 = v91;
		v87 = v92;
		if v85 then

		else
			break;
		end;
		local v93 = true;
		local v94, v95, v96 = pairs(p8);
		while true do
			local v97, v98 = v94(v95, v96);
			if v97 then

			else
				break;
			end;
			v96 = v97;
			if v85:IsDescendantOf(v98) then
				table.insert(v88, v85);
				v93 = false;
			end;		
		end;
		if v85.Locked == true then
			table.insert(v88, v85);
			v93 = false;
		end;
		if v93 == true then
			return v85, v86, v87;
		end;
		if 0 <= 1 then
			if v89 < 100 then

			else
				return;
			end;
		elseif 100 < v89 then

		else
			return;
		end;
		v89 = v89 + 1;	
	end;
	return v85, v86, v87;
end;
function lerp(p9, p10, p11)
	return p9 * (1 - p11) + p10 * p11;
end;
local v99 = v61;
if playerperks.lungs then
	v61 = v61 + v6.lungs.efx[1];
	v99 = v61;
end;
deathactivated = false;
local u8 = v99;
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
local u15 = v74;
invmanage = nil;
shakecamera = nil;
stagger = nil;
applygore = nil;
afflictstatus = nil;
createfxoutline = nil;
local function v100(p12, p13, p14, p15, p16, p17, p18)
	local v101 = l__game__7.ReplicatedStorage.soundLibrary;
	if p12 then
		for v102, v103 in ipairs(p12) do
			v101 = v101:FindFirstChild(v103);
		end;
	end;
	local v104 = v101:FindFirstChild(p13);
	if v104 then
		local v105 = v104:Clone();
		if p15 then
			v105.Pitch = v105.Pitch + math.random(-p15 * 100, p15 * 100) / 100;
		end;
		if p17 == false then
			v105.Parent = p14;
		else
			v105.Parent = ply.PlayerGui;
		end;
		v104.SoundGroup = l__game__7:GetService("SoundService").regular;
		if p18 == true then
			v104.RollOffMaxDistance = 50;
			v104.RollOffMinDistance = 25;
			v104.SoundGroup = l__game__7:GetService("SoundService").echo;
		end;
		v104:Play();
		if p16 == true then
			v104.Looped = false;
			v104.Ended:connect(function()
				spawn(function()
					v104:Destroy();
				end);
			end);
		end;
	end;
	return v104;
end;
l__workspace__1.ServerStuff.playAudio.OnClientEvent:Connect(v100);
local u16 = 0;
AGENT_sound = Instance.new("Sound");
AGENT_sound.Name = "AGENT";
AGENT_sound.Volume = 1;
AGENT_sound.Ended:connect(function()
	v100({ "AGENT" }, "bliptwo", nil, nil, true, true);
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
		local v106 = l__game__7.ReplicatedStorage.soundLibrary.AGENT:FindFirstChild(p22);
		v100({ "AGENT" }, "blip", nil, nil, true, true);
		delay(0.7, function()
			local v107 = v106:GetChildren()[math.random(1, #v106:GetChildren())];
			AGENT_sound.SoundId = v107.SoundId;
			if playerstats.Settings.MuteAgent == false then
				AGENT_sound:Play();
			end;
			if v107:FindFirstChild("line") then
				create_captions("AGENT", Color3.fromRGB(255, 170, 20), v107:FindFirstChild("line").Value);
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
local v108 = {
	damage = 0, 
	damagetaken = 0, 
	kills = 0, 
	killer = nil, 
	placed = 16, 
	timealive = tick()
};
lastchatter = tick();
local u17 = nil;
harvestinghits = v44;
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
local u20 = v38;
local u21 = v37;
local u22 = v36;
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
					v100({ "weapons", "LSMG" }, "move", nil, nil, true, true);
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
		elseif v61 < u8 then
			u8 = v61;
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
local v109 = hum.Changed:connect(function(p31)
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
local v110 = CFrame.new();
local v111 = CFrame.Angles(0, 0, 0);
local v112 = CFrame.new();
local u27 = {};
local function u28()
	local v113 = nil;
	while true do
		v113 = tostring(math.random(0, 500));
		if u27[v113] == nil then
			break;
		end;	
	end;
	u27[v113] = CFrame.Angles(0, 0, 0);
	return v113;
end;
local function u29(p32, p33)
	for v114 = 1, p33.loops do
		for v115 = 1, p33.tables[v114].frames do
			u27[p32] = u27[p32]:lerp(p33.tables[v114].value, p33.tables[v114].speed);
			RS:wait();
		end;
		RS:wait();
	end;
	for v116 = 1, p33.returnframes do
		u27[p32] = u27[p32]:lerp(CFrame.Angles(0, 0, 0), p33.returnspeed);
		RS:wait();
	end;
	u27[p32] = nil;
end;
function shakecamera(p34, p35)
	spawn(function()
		local v117 = u28();
		if p34 == "weapon" then
			if p35[1] ~= "Fists" then
				if p35[1] == "BK" then
					if p35[2] == "swingvar1" then
						u29(v117, {
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
						u29(v117, {
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
						u29(v117, {
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
						u29(v117, {
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
						u29(v117, {
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
						u29(v117, {
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
						u29(v117, {
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
						u29(v117, {
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
						u29(v117, {
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
						u29(v117, {
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
							u29(v117, {
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
							u29(v117, {
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
							u29(v117, {
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
							u29(v117, {
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
								u29(v117, {
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
								u29(v117, {
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
							u29(v117, {
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
							u29(v117, {
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
							u29(v117, {
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
							u29(v117, {
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
							u29(v117, {
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
								u29(v117, {
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
									u29(v117, {
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
									u29(v117, {
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
								u29(v117, {
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
								u29(v117, {
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
								u29(v117, {
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
								u29(v117, {
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
								u29(v117, {
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
								u29(v117, {
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
								u29(v117, {
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
								u29(v117, {
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
								u29(v117, {
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
								u29(v117, {
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
								u29(v117, {
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
								u29(v117, {
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
								u29(v117, {
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
								u29(v117, {
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
								u29(v117, {
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
								u29(v117, {
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
								u29(v117, {
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
								u29(v117, {
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
								u29(v117, {
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
								u29(v117, {
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
								u29(v117, {
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
								u29(v117, {
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
								u29(v117, {
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
								u29(v117, {
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
								u29(v117, {
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
								u29(v117, {
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
								u29(v117, {
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
								u29(v117, {
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
								u29(v117, {
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
									u29(v117, {
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
									u29(v117, {
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
									u29(v117, {
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
									u29(v117, {
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
									u29(v117, {
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
									u29(v117, {
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
							u29(v117, {
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
						u29(v117, {
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
							u29(v117, {
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
							u29(v117, {
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
						u29(v117, {
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
						u29(v117, {
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
						u29(v117, {
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
					u29(v117, {
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
					u29(v117, {
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
					u29(v117, {
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
					u29(v117, {
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
						u29(v117, {
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
						u29(v117, {
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
				u29(v117, {
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
				u29(v117, {
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
				u29(v117, {
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
				u29(v117, {
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
				u29(v117, {
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
			u29(v117, {
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
			u29(v117, {
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
			u29(v117, {
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
			u29(v117, {
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
			u29(v117, {
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
			local v118 = math.clamp(p35[1] * 0.35, 2, 20);
			local v119 = { math.random(-v118 * 10, v118 * 10) / 10, math.random(-v118 * 10, v118 * 10) / 10, math.random(-v118 * 10, v118 * 10) / 10 };
			u29(v117, {
				loops = 1, 
				tables = { {
						frames = 10, 
						value = CFrame.Angles(math.rad(v119[1]), math.rad(v119[2]), math.rad(v119[3])), 
						speed = 0.6
					} }, 
				returnframes = 100 + v118, 
				returnspeed = math.clamp(0.2 - p35[1] / 70, 0.03, 0.2)
			});
		elseif p34 == "gunrecoil" then
			local v120 = p35[1];
			local v121 = { v120, math.random(-v120, v120) / 2 };
			u29(v117, {
				loops = 1, 
				tables = { {
						frames = 6, 
						value = CFrame.Angles(math.rad(v121[1]), math.rad(v121[2]), 0), 
						speed = 0.2 + v120 / 300
					} }, 
				returnframes = 150 + v120 * 5, 
				returnspeed = 0.2 - v120 / 200
			});
		elseif p34 == "jumpstart" then
			u29(v117, {
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
			u29(v117, {
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
			u29(v117, {
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
			local v122 = p35[1] / 2;
			local v123 = v122;
			if math.random(1, 2) == 1 then
				v123 = -v123;
			end;
			u29(v117, {
				loops = 2, 
				tables = { {
						frames = 4, 
						value = CFrame.Angles(0, 0, math.rad(v123)), 
						speed = 0.2 + v122 / 300
					}, {
						frames = 4, 
						value = CFrame.Angles(0, 0, math.rad(-v123)), 
						speed = 0.2 + v122 / 300
					} }, 
				returnframes = 150 + v122 * 5, 
				returnspeed = 0.2 - v122 / 200
			});
		elseif p34 == "usestim" then
			u29(v117, {
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
			u29(v117, {
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
			u29(v117, {
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
		u27[v117] = nil;
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
					local v124 = Instance.new("BodyVelocity");
					v124.Name = "parkourPositionThing";
					v124.P = 100;
					v124.MaxForce = Vector3.new(math.huge, math.huge, math.huge);
					v124.Velocity = character.HumanoidRootPart.CFrame.lookVector * (8 + hum.WalkSpeed);
					v124.Parent = character.HumanoidRootPart;
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
						v124.Velocity = character.HumanoidRootPart.CFrame.lookVector * 22;
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
					v124:Destroy();
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
		v100({ "events" }, "duel", nil, nil, true, true);
		v100({ "events" }, "thunder", nil, nil, true, true);
		l__game__7.ReplicatedStorage.misc.showdownFX:Clone().Parent = ply.PlayerGui;
		u36.nowinshowdown = true;
		afflictstatus(require(l__game__7.Workspace.ServerStuff.Statistics.S_STATISTICS).Shd);
		local v125 = l__workspace__1.NoTarget:WaitForChild(p37);
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
				local v126 = 10;
				if p39 == "gundamage" then
					v126 = 1;
				end;
				if v126 <= p40 then
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
	v100({ "general" }, "funcadd", nil, nil, true, true);
	u16 = u16 + p42;
	local v127 = maingui.SponsorFrame.funcgains.funclabel:Clone();
	l__Debris__26:AddItem(v127, 5);
	local v128 = "+";
	if p42 < 0 then
		v128 = "";
	end;
	v127.Text = v128 .. p42 .. " " .. p43;
	v127.Visible = true;
	v127.Parent = maingui.SponsorFrame.funcgains;
	maingui.SponsorFrame.funclabel.Text = u16;
	spawn(function()
		local v129 = tick();
		while true do
			v127.TextColor3 = v127.TextColor3:Lerp(Color3.new(1, 1, 1), 0.2);
			RS:wait();
			if tick() - v129 >= 3 then
				break;
			end;		
		end;
		for v130 = 1, 20 do
			v127.TextTransparency = v127.TextTransparency + 0.05;
			RS:wait();
		end;
		v127:Destroy();
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
			if v5[1][1] ~= "Fist" and v5[1][2] == true then
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
		local v131 = { 283862058, 512386098, 401399563, 1381005589, 1187880846, 1051288252 };
		local v132 = Instance.new("ImageLabel");
		l__Debris__26:AddItem(v132, 5);
		local v133 = math.random(250, 300);
		v132.Size = UDim2.new(0.5, v133, 0.5, v133);
		v132.AnchorPoint = Vector2.new(0.5, 0.5);
		if math.random(1, 2) == 1 then
			local v134 = 0.9;
		else
			v134 = 0.1;
		end;
		v132.Position = UDim2.new(v134 + math.random(-5, 5) / 100, 0, math.random(0, 20) / 20, 0);
		v132.Rotation = math.random(0, 360);
		v132.ZIndex = 4;
		v132.BackgroundTransparency = 1;
		v132.BorderSizePixel = 0;
		v132.Image = "rbxassetid://" .. v131[math.random(1, #v131)];
		v132.Parent = maingui;
		delay(math.random(15, 25) / 10, function()
			for v135 = 1, 40 do
				v132.ImageTransparency = v135 / 40;
				RS:wait();
			end;
			v132:Destroy();
		end);
	end;
end;
local u42 = 0;
local function u43(p44, p45)
	if p45 == nil then
		return;
	end;
	local v136 = l__game__7.ReplicatedStorage.effects.damagenumber:Clone();
	l__Debris__26:AddItem(v136, 5);
	v136.bg.label.Text = math.ceil(p45);
	if p45 >= 70 then
		v136.bg.label.TextColor3 = Color3.new(0.9, 0, 0);
		v136.bg.label.TextSize = 30;
	end;
	v136.CFrame = CFrame.new(p44) * CFrame.new(math.random(-20, 20) / 10, 0, math.random(-20, 20) / 10);
	v136.Parent = l__workspace__1.Camera;
	local l__CFrame__44 = v136.CFrame;
	spawn(function()
		for v137 = 1, 20 do
			v136.CFrame = v136.CFrame:Lerp(l__CFrame__44 * CFrame.new(0, 2.5, 0), 0.1);
			RS:wait();
		end;
		delay(1, function()
			for v138 = 1, 20 do
				if v136.Parent == nil then
					return;
				end;
				v136.bg.label.TextTransparency = v136.bg.label.TextTransparency + 0.05;
				v136.bg.label.TextStrokeTransparency = v136.bg.label.TextTransparency;
				RS:wait();
			end;
			v136:Destroy();
		end);
	end);
end;
local function v139()
	v100({ "hitsound", "general" }, "throwhit", nil, nil, true, true);
	local v140 = maingui.Centre.ThrowHitmarker:Clone();
	v140.ImageTransparency = 0;
	v140.Parent = maingui.Centre;
	spawn(function()
		while true do
			v140.ImageTransparency = v140.ImageTransparency + 0.04;
			RS:wait();
			if v140.ImageTransparency == 1 then
				break;
			end;
			if v140.ImageTransparency > 1 then
				break;
			end;		
		end;
		v140:Destroy();
	end);
end;
l__workspace__1.ServerStuff.hitmarker.OnClientEvent:Connect(v139);
local u45 = 0;
local u46 = 1;
local u47 = v45;
local function u48(p46, p47, p48)
	local v141 = u17;
	if p48 == true then
		v141 = akimbo_factors.alt_weapon_stats;
	end;
	local l__CFrame__142 = l__CurrentCamera__1.CFrame;
	local v143 = 4 + 0.4 * v141.sizerating;
	if v141.sizerating == 4 then
		v143 = v143 + 0.45;
	end;
	local v144 = v143 - 1.65;
	local v145 = false;
	local v146 = false;
	local v147 = Vector3.new(0, 0, 0);
	local v148 = "meleedamage";
	if (v141.weapontype == "Gun" or v141.weapontype == "Bow") and typeof(p46) ~= "string" then
		local l__sizerating__149 = v141.sizerating;
		local v150 = v40;
		if u37 == true then
			v150 = 0;
		end;
		local v151 = math.clamp(l__sizerating__149 - l__sizerating__149 * v150, 0.01, 10000);
		if v141.weapontype == "Bow" then
			v148 = "gundamage";
			v145 = true;
			v146 = true;
			v143 = 80;
			v144 = 0;
			if u9.walking == true then
				v147 = Vector3.new(math.rad(math.random(-v151, v151)), math.rad(math.random(-v151, v151)), math.rad(math.random(-v151, v151)));
			end;
		else
			local v152 = false;
			if u9.aiming == false then
				v152 = true;
			end;
			if tick() - baseadstick <= baseadstime / (1 + baseadsmod) / 8 then
				v152 = true;
			end;
			if u37 == true then
				v152 = true;
			end;
			if v152 == true then
				v147 = Vector3.new(math.rad(math.random(-v151, v151)), math.rad(math.random(-v151, v151)), math.rad(math.random(-v151, v151)));
			end;
		end;
	end;
	local v153 = true;
	if typeof(p46) == "string" then
		v143 = 3.5;
		v144 = 3.5;
		if p46 == "pepperspray" then
			v143 = 6;
			v144 = 6;
			v153 = false;
		end;
	end;
	local v154, v155 = raycastline(l__CurrentCamera__1.CFrame.p, l__CurrentCamera__1.CFrame.LookVector + v147, v143, baselayer);
	if v153 == true then
		trigger_map_item_func(v154, v148, p46);
		if v154 and ((v154.Name == "HarvestWood" or v154.Name == "HarvestStone") and p46 ~= "shove" and p46 ~= "shovebleed" and v148 == "meleedamage" and v154.Name ~= "Interact") then
			local v156 = true;
			if v154.Parent and (v154.Name == "CRBarrel" or v154.Name == "CRPylon") then
				v156 = false;
			end;
			if v156 == true then
				local v157 = "wood";
				if v154.Name == "HarvestStone" then
					v157 = "stone";
				end;
				local v158 = 2;
				if v141.weapontype == "Fists" then
					v158 = 1;
				end;
				if v141.weapontype == "Bludgeon" and v157 == "stone" or v141.weapontype == "Axe" and v157 == "wood" then
					v158 = 3;
				end;
				l__workspace__1.ServerStuff.applyGore:FireServer("harvestmat", character, ply, { v157, v155 });
				l__workspace__1.ServerStuff.playAudio:FireServer({ "harvesting" }, v157 .. "hit", character.HumanoidRootPart, 0.2);
				harvestinghits = harvestinghits - v158;
				if harvestinghits <= 0 then
					u38(2, "SALVAGE");
					l__workspace__1.ServerStuff.applyGore:FireServer("harvestmat", character, ply, { "salvaged", v155 });
					harvestinghits = v44;
					l__workspace__1.ServerStuff.harvest:FireServer(v157, v154.Parent);
					l__workspace__1.ServerStuff.playAudio:FireServer({ "harvesting" }, v157 .. "break", character.HumanoidRootPart, 0.2);
				end;
			end;
		end;
	end;
	local v159 = nil;
	local v160 = v144;
	if v144 > 0 then
		local v161, v162, v163 = pairs(l__game__7.Players:GetChildren());
		while true do
			local v164, v165 = v161(v162, v163);
			if not v164 then
				break;
			end;
			local v166 = v165:FindFirstChild("npc") and v166.Value;
			if v166 == nil and v165:IsA("Player") then
				v166 = v165.Character;
			end;
			if v166 and v166:FindFirstChild("HumanoidRootPart") and (v155 - v166.HumanoidRootPart.CFrame.p).magnitude < v160 and v165 ~= ply and v166:FindFirstChild("Humanoid") and v166.Humanoid.Health > 0 then
				v160 = (v155 - v166.HumanoidRootPart.CFrame.p).magnitude;
				v159 = v166;
				if teamfolder and v166:IsDescendantOf(teamfolder) then
					v159 = nil;
				end;
				if v166:IsDescendantOf(l__workspace__1.activeFriendlies) then
					v159 = nil;
				end;
			end;		
		end;
	end;
	if v146 == true and v154 == nil then
		local v167 = v155;
		for v168 = 1, 200 do
			local v169, v170 = raycastline(v167, l__CurrentCamera__1.CFrame.LookVector + v147 + Vector3.new(0, -0.05, 0), 3, baselayer);
			trigger_map_item_func(v169, v148, p46);
			if v169 then
				v154 = v169;
				break;
			end;
			v167 = v170;
			RS:wait();
		end;
	end;
	if v154 and v154.Parent:FindFirstChild("Humanoid") and v154.Parent:FindFirstChild("HumanoidRootPart") and (v154.Parent:FindFirstChild("Humanoid").Health > 0 and not v159) then
		v159 = v154.Parent;
	end;
	if v145 == true then
		if v146 == true then
			l__workspace__1.ServerStuff.applyGore:FireServer("bowarrow", character, ply, { l__CurrentCamera__1.CFrame, v147 });
		else
			local v171 = false;
			if p47 == "suppressed" then
				v171 = true;
			end;
			local v172 = u19.muzzle.Position;
			if p48 == true then
				v172 = akimbo_factors.alt_weapon.muzzle.Position;
			end;
			if v141.animset == "LSMG" or v141.name == "A.J.M. 9" then
				l__workspace__1.ServerStuff.applyGore:FireServer("firelaser", character, ply, { v172, v155 });
			else
				l__workspace__1.ServerStuff.applyGore:FireServer("firegun", character, ply, { v172, v155, v171, v159, true });
			end;
			if u10["Immolator Buff"] then
				l__workspace__1.ServerStuff.applyGore:FireServer("incendiary_trail", character, ply, { v172, v155 });
			end;
		end;
	end;
	if v159 and v145 == false and v146 == false and not raycastline(v159.Head.CFrame.p, -(v159.Head.CFrame.p - character.Head.CFrame.p), 100, { l__workspace__1.GoreEffects, v159 }) then
		v159 = nil;
	end;
	local v173 = false;
	local v174 = p46;
	local v175 = false;
	if v159 then
		local v176 = CFrame.new(v159.HumanoidRootPart.CFrame.p, v159.HumanoidRootPart.CFrame.p + Vector3.new(v159.HumanoidRootPart.CFrame.lookVector.x, 0, v159.HumanoidRootPart.CFrame.lookVector.z).unit):inverse() * character.HumanoidRootPart.Position;
		local l__unit__177 = Vector3.new(v176.x, v176.z).unit;
		local v178 = math.deg(math.atan2(l__unit__177.y * 200, l__unit__177.x * 200)) + 90;
		if v145 == true then
			v148 = "gundamage";
			v173 = v154.Name == "Head";
		end;
		if v173 == true and typeof(p46) ~= "string" then
			if v145 == true then
				v174 = v141.damagerating[4];
				p46 = v141.damagerating[4];
			end;
			if v145 == false then
				l__workspace__1.ServerStuff.adjustStats:FireServer("tracker", { "Backstabs", 1 });
			end;
		end;
		if typeof(p46) ~= "string" and v145 == true and v159:FindFirstChild("perks") and v159:FindFirstChild("perks"):FindFirstChild("thick") then
			v174 = v174 - v174 * v6.thick.efx[1] / 100;
		end;
		if v159 then
			if typeof(v174) ~= "string" and v173 ~= true and v148 == "meleedamage" and u39 == false then
				v174 = math.ceil(v174 * (u21 + u40));
				if v159:FindFirstChild("activeBlock") and v159:FindFirstChild("activeBlock").Value == true then
					v175 = true;
				end;
			end;
			if v175 == true then
				l__workspace__1.ServerStuff.applyGore:FireServer("blocksmoke", v159, nil, nil);
				l__workspace__1.ServerStuff.playAudio:FireServer({ "hitsound", "general" }, "hitblocked", character.HumanoidRootPart, 0.15);
				l__workspace__1.ServerStuff.dealDamage:FireServer("registerblocked", v159, v4);
				spawn(function()
					stagger("normal");
				end);
				return;
			end;
		end;
		local u49 = true;
		spawn(function()
			l__workspace__1.ServerStuff.dealDamage:FireServer({ v148, v159, p46, v173, u18, v175, false, playerperks, v154 }, nil, v4);
			if u49 == true then
				if typeof(p46) ~= "string" then
					if v145 == false then
						if u36.damagedealt[v159.Name] == nil then
							u36.damagedealt[v159.Name] = v174;
						else
							u36.damagedealt[v159.Name] = u36.damagedealt[v159.Name] + v174;
						end;
						if u36.tagged[v159.Name] and v174 >= 12 then
							u36.tagged[v159.Name] = nil;
							u36.ticktimers[v159.Name] = tick();
							u36.suslevels[v159.Name] = tick();
						end;
						if u36.tagged[v159.Name] == nil and u36.damagedealt[v159.Name] and u36.damagedealt[v159.Name] >= 20 then
							local v179 = 10000;
							local v180 = nil;
							for v181, v182 in pairs(u36.tagged) do
								if l__workspace__1.activePlayers:FindFirstChild(v181) and v182 < v179 then
									v179 = v182;
									v180 = v181;
								end;
							end;
							if v179 <= 40 and v180 ~= nil and u36.nowinshowdown == false then
								l__workspace__1.ServerStuff.eventTime:FireServer(v180, v4);
							end;
						end;
						bloodsprayDealt = bloodsprayDealt + v174;
						u41();
						if v141.name == "Sledgehammer" and v174 >= 30 and math.random(1, 100) == 1 then
							l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "donk", character.HumanoidRootPart);
						end;
						if playerperks.slippery and v141.weapontype == "Spear" then
							u22 = u22 + u13 * v6.slippery.efx[1] / 100;
							delay(v6.slippery.efx[2], function()
								u22 = u22 - u13 * v6.slippery.efx[1] / 100;
							end);
						end;
						if p47 == "heavy" and (v141.weapontype == "Bludgeon" or v141.weapontype == "Spear" or v141.weapontype == "Axe" or v141.weapontype == "Blade" or v141.weapontype == "Fists") then
							l__workspace__1.ServerStuff.adjustStats:FireServer("tracker", { v141.weapontype .. "Heavies", 1 });
						end;
						if v141.name == "Fists" and v174 >= 14 then
							l__workspace__1.ServerStuff.adjustStats:FireServer("tracker", { "ChargedFists", 1 });
						end;
						if v141.weapontype == "Blade" then
							l__workspace__1.ServerStuff.adjustStats:FireServer("tracker", { "BleedProc", 1 });
						end;
						v108.damage = v108.damage + p46;
						l__workspace__1.ServerStuff.adjustStats:FireServer("tracker", { "DamageDealt", p46 });
					end;
					if tick() - u42 > 0.01 then
						v100({ "hitsound", "general" }, "hitdeal", nil, nil, true, true);
					end;
					if v159:FindFirstChild("Head") then
						u43(v159:FindFirstChild("Head").Position, v174);
					end;
					if v141.name == "Double Barrel" then
						l__workspace__1.ServerStuff.adjustStats:FireServer("tracker", { "DBPellets", 1 });
					end;
					if v141.name == "Submachine Gun" then
						l__workspace__1.ServerStuff.adjustStats:FireServer("tracker", { "LandedSMG", 1 });
					end;
					if v141.weapontype == "Bow" then
						l__workspace__1.ServerStuff.adjustStats:FireServer("tracker", { "BowsHit", 1 });
					end;
					if v145 == true and v173 == true then
						l__workspace__1.ServerStuff.adjustStats:FireServer("tracker", { "RangedDamageDealt", p46 });
						if v141.name == "Rifle" then
							l__workspace__1.ServerStuff.adjustStats:FireServer("tracker", { "RifleHeadshots", 1 });
						end;
						if v141.weapontype == "Bow" then
							l__workspace__1.ServerStuff.adjustStats:FireServer("tracker", { "bowHeadshots", 1 });
						end;
						l__workspace__1.ServerStuff.adjustStats:FireServer("tracker", { "Headshots", 1 });
						if tick() - u42 > 0.01 then
							v100({ "hitsound", "general" }, "hitheadshot", nil, nil, true, true);
						end;
					end;
					u42 = tick();
					l__workspace__1.ServerStuff.applyGore:FireServer("bloodhit", v159, l__game__7.Players:GetPlayerFromCharacter(v159), { v174, v155 });
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
	return v159;
end;
local v183 = CFrame.new(0, 0, 0);
local u50 = tick();
local u51 = v46;
local function u52()
	l__workspace__1.ServerStuff.dealDamage:FireServer("raidbossshotgun", nil, v4);
	local v184 = curentanimset.pump;
	local v185 = 1;
	local v186 = false;
	if primskin and primskin.name == "Merci-fall" then
		v186 = true;
		v184 = curentanimset.skinpump;
		v185 = 0.8;
		delay(0.65, function()
			v100({ "reloads" }, "shotgun_mid", nil, nil, true, true);
		end);
		delay(0.75, function()
			v100({ "general" }, "reloadpartial", nil, nil, true, true);
		end);
	end;
	v184:Play(0.2, 1, v185);
	if v186 == false then
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
local u57 = v112;
u55 = function()
	if v58.aegisshieldup ~= nil then
		v58.aegisshieldup(v59[3].aegisdamagetakenmelee);
		return;
	end;
	if v58.berzactive ~= nil then
		local v187 = v58.berzactive + v59[3].regenonparry;
		if tick() - v187 > 0 then
			v58.berzactive = v187;
		else
			v58.berzactive = tick();
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
	l__workspace__1.ServerStuff.initiateblock:FireServer(v4, true);
	u9.charging = false;
	u9.action = true;
	u9.blocking = false;
	u9.blockrecoil = true;
	u9.blockimpact = true;
	u9.cancombo = false;
	u9.shoving = false;
	u50 = 0;
	u53 = 0;
	local v188 = tick();
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
			v188 = tick();
			u9.blockimpact = false;
			u57 = CFrame.new(0, 1, 0);
			delay(0.05, function()
				if u57 == CFrame.new(0, 1, 0) then
					u57 = CFrame.new(0, 0, 0);
				end;
			end);
		end;
		if tick() - v188 >= 0.35 then
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
		l__workspace__1.ServerStuff.initiateblock:FireServer(v4, false);
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
			local v189 = tick();
			local v190 = false;
			while true do
				if tick() - v189 >= 5 then
					v190 = true;
					break;
				end;
				if u9.blockrecoil == false then
					v190 = false;
					break;
				end;
				if v190 == true then
					break;
				end;			
			end;
			if v190 == true then
				u9.blockrecoil = false;
				curentanimset.block:Stop(0.2);
				tpcurrentanimset.block:Stop(0.2);
				u25(0.025, true);
				l__workspace__1.ServerStuff.initiateblock:FireServer(v4, false);
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
	local v191 = false;
	if u9.blocking == true and u9.staggering == false then
		v191 = true;
	end;
	if u9.swapping == true then
		v191 = false;
	end;
	return v191;
end;
local u58 = v41;
local v192 = { 2, 1.7, 1.35, 0.6 };
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
		local v193 = v17[p50];
		if v193 == nil then
			v193 = v17[v9];
		end;
		local v194 = v193.animset;
		current_anim_set_use = v193.animset;
		local v195 = p50;
		local v196 = false;
		if playerstats.Exotic ~= "none" and p50 == "Fist" and v19[playerstats.Exotic] then
			v194 = v19[playerstats.Exotic].param[2];
			current_anim_set_use = v19[playerstats.Exotic].param[2];
			v195 = playerstats.Exotic;
			v196 = true;
		end;
		if v193.weapontype == "Item" then
			shakecamera("weapon", { "Item", "equip" });
		else
			shakecamera("weapon", { v194, "equip" });
		end;
		u9.swapping = true;
		u9.blocking = false;
		l__workspace__1.ServerStuff.initiateblock:FireServer(v4, false);
		u9.action = true;
		u9.cancombo = false;
		u9.startswap = true;
		local v197 = false;
		if p51 and p51:FindFirstChild("trapped") then
			v197 = true;
		end;
		if p51 and p51:FindFirstChild("agentcode") then
			for v198, v199 in pairs(v5) do
				if v199[2] == true then
					v199[4] = p51:FindFirstChild("agentcode").Value;
				end;
			end;
		end;
		if curentanimset.equip then
			curentanimset.equip:Stop(0);
		end;
		if tpcurrentanimset.equip then
			tpcurrentanimset.equip:Stop(0);
		end;
		for v200, v201 in pairs(curentanimset) do
			v201:Stop();
			v201:Destroy();
		end;
		for v202, v203 in pairs(tpcurrentanimset) do
			v203:Stop();
			v203:Destroy();
		end;
		curentanimset = {};
		tpcurrentanimset = {};
		u17 = {};
		harvestinghits = v44;
		local v204 = false;
		if v193.weapontype == "Axe" or v193.weapontype == "Bludgeon" or v193.weapontype == "Blade" or v193.weapontype == "Spear" then
			v204 = true;
		end;
		if p50 == "Primary" then
			p50 = v9;
			local v205 = primanimset;
			local v206 = tpprimanimset;
			u17 = primwepset;
		else
			v205 = l__game__7.ReplicatedStorage.animationSets:FindFirstChild(v194);
			v206 = l__game__7.ReplicatedStorage.animationSets.TPanimSets:FindFirstChild(v194);
			u17 = v193;
			if v205 == nil then
				v205 = l__game__7.ReplicatedStorage.animationSets.global;
			end;
			if v206 == nil then
				v206 = l__game__7.ReplicatedStorage.animationSets.TPanimSets.global;
			end;
		end;
		if p51 then
			p51:Destroy();
		end;
		l__workspace__1.ServerStuff.getTPWeapon:FireServer(p50, v206, u18, p51, v204);
		if u19 then
			u19:Destroy();
			for v207, v208 in ipairs(fparms.Joints:GetChildren()) do
				if v208.Name == "WeaponJoint" then
					v208:Destroy();
				end;
			end;
		end;
		if p50 == "Fist" then
			local v209 = nil;
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
			if v196 == true then
				local v252 = nil;
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
				if v196 == true and v204 == true and p50 == "Fist" then
					v204 = false;
				end;
				if character:FindFirstChild("hasPrimary") then
					local v341 = tick();
					if v204 == true then
						while true do
							drawlockout = tick();
							RS:wait();
							if tick() - v341 >= 2 then
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
							if tick() - v341 >= 2 then
								break;
							end;
							if v196 == true then
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
				if v204 == true then
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
						v252 = true;
						v253 = v197;
						v254 = v252;
						if v253 == v254 then
							local v342 = Instance.new("BoolValue");
							v342.Name = "trapped";
							v342.Parent = u19;
						end;
						v255 = u19;
						local v343 = "JointGrip";
						v256 = v255;
						v257 = v343;
						v267 = v256[v257];
						v258 = fparms;
						local v344 = "RightArm";
						v259 = v258;
						v260 = v344;
						v261 = v259[v260];
						local v345 = "RUpperArm";
						v262 = v261;
						v263 = v345;
						v264 = v262[v263];
						local v346 = "CFrame";
						v265 = v264;
						v266 = v346;
						local v347 = v265[v266];
						local v348 = "CFrame";
						v268 = v267;
						v269 = v348;
						v270 = v347;
						v268[v269] = v270;
						local v349 = u19;
						local v350 = "JointGrip";
						v271 = v349;
						v272 = v350;
						local v351 = v271[v272];
						local v352 = true;
						local v353 = "Locked";
						v273 = v351;
						v274 = v353;
						v275 = v352;
						v273[v274] = v275;
						local v354 = Instance.new;
						local v355 = "Motor6D";
						v276 = v354;
						v277 = v355;
						local v356 = v276(v277);
						local v357 = "WeaponJoint";
						local v358 = "Name";
						v278 = v356;
						v279 = v358;
						v280 = v357;
						v278[v279] = v280;
						local v359 = fparms;
						local v360 = "RightArm";
						v281 = v359;
						v282 = v360;
						local v361 = v281[v282];
						local v362 = "RUpperArm";
						v283 = v361;
						v284 = v362;
						local v363 = v283[v284];
						local v364 = "Part0";
						v285 = v356;
						v286 = v364;
						v287 = v363;
						v285[v286] = v287;
						local v365 = u19;
						local v366 = "JointGrip";
						v288 = v365;
						v289 = v366;
						local v367 = v288[v289];
						local v368 = "Part1";
						v290 = v356;
						v291 = v368;
						v292 = v367;
						v290[v291] = v292;
						local v369 = CFrame.new;
						local v370 = 0;
						local v371 = -1;
						local v372 = 0;
						v293 = 1;
						v294 = 0;
						v295 = 0;
						v296 = 0;
						v297 = 1;
						v298 = 0;
						v299 = 0;
						v300 = 0;
						v301 = 1;
						v302 = v369;
						v303 = v370;
						v304 = v371;
						v305 = v372;
						v306 = v293;
						v307 = v294;
						v308 = v295;
						v309 = v296;
						v310 = v297;
						v311 = v298;
						v312 = v299;
						v313 = v300;
						v314 = v301;
						local v373 = v302(v303, v304, v305, v306, v307, v308, v309, v310, v311, v312, v313, v314);
						local v374 = "C0";
						v315 = v356;
						v316 = v374;
						v317 = v373;
						v315[v316] = v317;
						local v375 = u19;
						local v376 = "Name";
						v318 = v375;
						v319 = v376;
						local v377 = v318[v319];
						local v378 = "LSMini";
						v320 = v377;
						v321 = v378;
						if v320 == v321 then
							v356.C0 = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1);
						end;
						local v379 = "weldval";
						local v380 = "FindFirstChild";
						v322 = v205;
						local v381 = v322;
						v323 = v205;
						v324 = v380;
						local v382 = v323[v324];
						v325 = v382;
						v326 = v381;
						v327 = v379;
						local v383 = v325(v326, v327);
						v328 = v383;
						if v328 then
							v356.C1 = v205.weldval.Value;
						else
							v356.C1 = l__game__7.ReplicatedStorage.animationSets.global.gweldval.Value;
						end;
						local v384 = u19;
						local v385 = "Name";
						v329 = v384;
						v330 = v385;
						local v386 = v329[v330];
						local v387 = "Tourni";
						v331 = v386;
						v332 = v387;
						if v331 == v332 then
							v356.C0 = CFrame.new(0.155029297, -1.00993419, 0.217743874, 0, 7.10542736E-15, 0.999999285, 0.999999285, 0, 0, 0, 0.999999285, -7.10542736E-15);
							v356.C1 = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1);
						end;
						local v388 = fparms;
						local v389 = "Joints";
						v333 = v388;
						v334 = v389;
						local v390 = v333[v334];
						local v391 = "Parent";
						v335 = v356;
						v336 = v391;
						v337 = v390;
						v335[v336] = v337;
						local v392 = u19;
						local v393 = fparms;
						local v394 = "Parent";
						v338 = v392;
						v339 = v394;
						v340 = v393;
						v338[v339] = v340;
						v209 = u9;
						v211 = false;
						v210 = "startswap";
						v212 = v209;
						v213 = v210;
						v214 = v211;
						v212[v213] = v214;
						local v395 = fparms;
						local v396 = l__CurrentCamera__1;
						local v397 = "Parent";
						v215 = v395;
						v216 = v397;
						v217 = v396;
						v215[v216] = v217;
						local v398 = pairs;
						local v399 = "GetChildren";
						v218 = v205;
						v221 = v218;
						v219 = v205;
						v220 = v399;
						local v400 = v219[v220];
						v222 = v400;
						v223 = v221;
						v225 = v222(v223);
						v224 = v398;
						for v401, v402 in v224(v225) do
							if v402:IsA("Animation") then
								local v403 = fparms.AC:LoadAnimation(v402);
								v403.Name = v402.Name;
								curentanimset[v402.Name] = v403;
							end;
						end;
						local v404 = pairs;
						local v405 = "GetChildren";
						v226 = v206;
						local v406 = v226;
						v227 = v206;
						v228 = v405;
						local v407 = v227[v228];
						v229 = v407;
						v230 = v406;
						v232 = v229(v230);
						v231 = v404;
						for v408, v409 in v231(v232) do
							if v409:IsA("Animation") then
								local v410 = hum:LoadAnimation(v409);
								v410.Name = v409.Name;
								tpcurrentanimset[v409.Name] = v410;
							end;
						end;
						local v411 = curentanimset;
						local v412 = "block";
						v233 = v411;
						v234 = v412;
						local v413 = v233[v234];
						v235 = v413;
						if v235 then
							curentanimset.block:Stop();
							tpcurrentanimset.block:Stop();
						end;
						local v414 = "weapontype";
						v236 = v193;
						v237 = v414;
						local v415 = v236[v237];
						local v416 = "Item";
						v238 = v415;
						v239 = v416;
						if v238 == v239 then
							if l__game__7.ReplicatedStorage.animationSets:FindFirstChild(v193.animset):FindFirstChild("equip") == nil then
								curentanimset.equip = globalanimsets.equip;
								tpcurrentanimset.equip = tpglobalanimsets.equip;
							end;
							l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", "Item" }, "draw", character.HumanoidRootPart);
						elseif l__game__7.ReplicatedStorage.soundLibrary.weapons:FindFirstChild(v193.weapontype) then
							if v196 == true then
								l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", v194 }, "draw", character.HumanoidRootPart);
							else
								l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", v193.weapontype }, "draw", character.HumanoidRootPart);
							end;
						else
							l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", v194 }, "draw", character.HumanoidRootPart);
							if v193.name == "FAMAS F1" and math.random(1, 3) == 1 then
								l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", v193.animset }, "aughfrench", character.HumanoidRootPart);
							end;
						end;
						local v417 = "animset";
						v240 = v193;
						v241 = v417;
						local v418 = v240[v241];
						local v419 = "1PB";
						v242 = v418;
						v243 = v419;
						if v242 == v243 then
							spawn(function()
								local v420 = tick();
								local v421 = true;
								while true do
									if u17.animset ~= "1PB" then
										v421 = false;
										break;
									end;
									RS:wait();
									if tick() - v420 >= 0.4 then
										break;
									end;								
								end;
								if character.HumanoidRootPart:FindFirstChild("playerdrones") then
									baselayer = { character, l__workspace__1.NoTarget, l__workspace__1.GoreEffects, l__CurrentCamera__1, character.HumanoidRootPart:FindFirstChild("playerdrones").Part0.Parent };
								end;
								if v421 == true then
									v100({ "weapons", u17.animset }, "flash", nil, nil, true, true);
									local l__plasmaEffect__422 = u19:WaitForChild("plasmaEffect");
									l__plasmaEffect__422:WaitForChild("flash").Enabled = true;
									l__plasmaEffect__422:WaitForChild("spark").Enabled = true;
									l__plasmaEffect__422:WaitForChild("lightglow").Enabled = true;
									l__plasmaEffect__422:WaitForChild("electric").Enabled = true;
									l__plasmaEffect__422.flash:Emit(20);
									l__plasmaEffect__422.spark:Emit(math.random(10, 20));
									l__plasmaEffect__422.flash.Enabled = false;
									l__plasmaEffect__422.spark.Enabled = false;
									if u19.Model:FindFirstChild("bladeglow") then
										u19.Model.bladeglow.Transparency = 0.1;
									end;
								end;
							end);
						end;
						local v423 = "weapontype";
						v244 = v193;
						v245 = v423;
						local v424 = v244[v245];
						local v425 = "Gun";
						v246 = v424;
						v247 = v425;
						if (v246 == v247 or v193.weapontype == "Bow") and v193.weapontype == "Bow" then
							local v426 = nil;
							for v427 = 1, 100 do
								if character:FindFirstChild("RBow") then
									v426 = character:FindFirstChild("RBow");
									if v426 == nil then
										v426 = character:FindFirstChild("CRBow");
										if v426 == nil then
											v426 = character:FindFirstChild("CPBow");
										end;
									end;
									break;
								end;
								if character:FindFirstChild("CRBow") then
									v426 = character:FindFirstChild("RBow");
									if v426 == nil then
										v426 = character:FindFirstChild("CRBow");
										if v426 == nil then
											v426 = character:FindFirstChild("CPBow");
										end;
									end;
									break;
								end;
								if character:FindFirstChild("CPBow") then
									v426 = character:FindFirstChild("RBow");
									if v426 == nil then
										v426 = character:FindFirstChild("CRBow");
										if v426 == nil then
											v426 = character:FindFirstChild("CPBow");
										end;
									end;
									break;
								end;
								RS:wait();
							end;
							if v426 then
								if u19:FindFirstChild("arrow") then
									for v428, v429 in ipairs(u19.arrow:GetChildren()) do
										if v429:IsA("BasePart") then
											v429.Transparency = 1;
										end;
									end;
								end;
								v426.bowString.stringA.Transparency = NumberSequence.new(1);
								v426.bowString.stringB.Transparency = NumberSequence.new(1);
							end;
						end;
						local v430 = curentanimset;
						local v431 = "equip";
						v248 = v430;
						v249 = v431;
						local v432 = v248[v249];
						v250 = v432;
						if v250 then
							if playerperks.leather then
								if v193.weapontype == "Bludgeon" then
									if perksactive.leather == nil then
										perksactive.leather = true;
										u20 = u20 + v6.leather.efx[1] / 100;
									end;
								elseif perksactive.leather == true then
									perksactive.leather = nil;
									u20 = u20 - v6.leather.efx[1] / 100;
								end;
							end;
							if playerperks.boxer then
								if v193.weapontype == "Fists" then
									if perksactive.boxer == nil then
										perksactive.boxer = true;
										u21 = u21 + v6.boxer.efx[1] / 100;
									end;
								elseif perksactive.boxer == true then
									perksactive.boxer = nil;
									u21 = u21 - v6.boxer.efx[1] / 100;
								end;
							end;
							if playerperks.honor then
								if v193.weapontype == "Fists" then
									if perksactive.honor == nil then
										perksactive.honor = true;
										u21 = u21 + v6.honor.efx[1] / 100;
									end;
								elseif perksactive.honor == true then
									perksactive.honor = nil;
									u21 = u21 - v6.honor.efx[1] / 100;
								end;
							end;
							if v193.weapontype == "Fists" then
								if fist_speed_boost == false then
									fist_speed_boost = true;
									u22 = u22 + u13 * 15 / 100;
								end;
							elseif fist_speed_boost == true then
								fist_speed_boost = false;
								u22 = u22 - u13 * 15 / 100;
							end;
							if playerperks.mcrafter then
								if v193.name == "Crafted Spear" or v193.name == "Crafted Hatchet" or v193.name == "Crafted Knife" or v193.name == "Crafted Cudgel" then
									if perksactive.mcrafter == nil then
										perksactive.mcrafter = true;
										u21 = u21 + v6.mcrafter.efx[1] / 100;
									end;
								elseif perksactive.mcrafter == true then
									perksactive.mcrafter = nil;
									u21 = u21 - v6.mcrafter.efx[1] / 100;
								end;
							end;
							if playerperks.spearsrun then
								if v193.weapontype == "Spear" then
									if perksactive.spearsrun == nil then
										perksactive.spearsrun = true;
										u22 = u22 + u13 * v6.spearsrun.efx[1] / 100;
									end;
								elseif perksactive.spearsrun == true then
									perksactive.spearsrun = nil;
									u22 = u22 - u13 * v6.spearsrun.efx[1] / 100;
								end;
							end;
							if playerperks.tracker then
								if v193.name == "Mantracker" then
									if perksactive.tracker == nil then
										perksactive.tracker = true;
										u22 = u22 + u13 * v6.tracker.efx[1] / 100;
									end;
								elseif perksactive.tracker == true then
									perksactive.tracker = nil;
									u22 = u22 - u13 * v6.tracker.efx[1] / 100;
								end;
							end;
							if v193.name == "'Polters Last Wish'" or v193.name == "'Polters Last Breath'" then
								for v433, v434 in ipairs(u19.Model:GetChildren()) do
									v434.Transparency = 0;
								end;
							end;
							local v435 = 0.6;
							if v193.name == "Fists" then
								v435 = 0.9;
							end;
							if v193.animset == "PST" or v193.animset == "2HPST" then
								v435 = 0.8;
							end;
							curentanimset.equip:AdjustSpeed(v435);
							curentanimset.equip:Play(0, 1, v435);
							tpcurrentanimset.equip:AdjustSpeed(v435);
							tpcurrentanimset.equip:Play(0.2, 1, v435);
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
										if v193.animset == "LSMG" then
											u24();
										end;
									end;
								end;
							end);
							if u19 and u19:FindFirstChild("skinned") and v19[u19:FindFirstChild("skinned").Value] then
								primskin = v19[u19:FindFirstChild("skinned").Value];
							end;
							drawlockout = tick();
							invmanage("updatehud");
							check_walking_anim();
						end;
						v251 = p50;
						u18 = v251;
						return;
					else
						u9.action = false;
						u9.swapping = false;
						return;
					end;
				else
					u19 = l__game__7.ReplicatedStorage.Weapons:FindFirstChild(v195):Clone();
					if v196 == true and playerstats.Exotic == "Tanto" then
						u19.sheath.Transparency = 0;
					end;
					v252 = true;
					v253 = v197;
					v254 = v252;
					if v253 == v254 then
						v342 = Instance.new("BoolValue");
						v342.Name = "trapped";
						v342.Parent = u19;
					end;
					v255 = u19;
					v343 = "JointGrip";
					v256 = v255;
					v257 = v343;
					v267 = v256[v257];
					v258 = fparms;
					v344 = "RightArm";
					v259 = v258;
					v260 = v344;
					v261 = v259[v260];
					v345 = "RUpperArm";
					v262 = v261;
					v263 = v345;
					v264 = v262[v263];
					v346 = "CFrame";
					v265 = v264;
					v266 = v346;
					v347 = v265[v266];
					v348 = "CFrame";
					v268 = v267;
					v269 = v348;
					v270 = v347;
					v268[v269] = v270;
					v349 = u19;
					v350 = "JointGrip";
					v271 = v349;
					v272 = v350;
					v351 = v271[v272];
					v352 = true;
					v353 = "Locked";
					v273 = v351;
					v274 = v353;
					v275 = v352;
					v273[v274] = v275;
					v354 = Instance.new;
					v355 = "Motor6D";
					v276 = v354;
					v277 = v355;
					v356 = v276(v277);
					v357 = "WeaponJoint";
					v358 = "Name";
					v278 = v356;
					v279 = v358;
					v280 = v357;
					v278[v279] = v280;
					v359 = fparms;
					v360 = "RightArm";
					v281 = v359;
					v282 = v360;
					v361 = v281[v282];
					v362 = "RUpperArm";
					v283 = v361;
					v284 = v362;
					v363 = v283[v284];
					v364 = "Part0";
					v285 = v356;
					v286 = v364;
					v287 = v363;
					v285[v286] = v287;
					v365 = u19;
					v366 = "JointGrip";
					v288 = v365;
					v289 = v366;
					v367 = v288[v289];
					v368 = "Part1";
					v290 = v356;
					v291 = v368;
					v292 = v367;
					v290[v291] = v292;
					v369 = CFrame.new;
					v370 = 0;
					v371 = -1;
					v372 = 0;
					v293 = 1;
					v294 = 0;
					v295 = 0;
					v296 = 0;
					v297 = 1;
					v298 = 0;
					v299 = 0;
					v300 = 0;
					v301 = 1;
					v302 = v369;
					v303 = v370;
					v304 = v371;
					v305 = v372;
					v306 = v293;
					v307 = v294;
					v308 = v295;
					v309 = v296;
					v310 = v297;
					v311 = v298;
					v312 = v299;
					v313 = v300;
					v314 = v301;
					v373 = v302(v303, v304, v305, v306, v307, v308, v309, v310, v311, v312, v313, v314);
					v374 = "C0";
					v315 = v356;
					v316 = v374;
					v317 = v373;
					v315[v316] = v317;
					v375 = u19;
					v376 = "Name";
					v318 = v375;
					v319 = v376;
					v377 = v318[v319];
					v378 = "LSMini";
					v320 = v377;
					v321 = v378;
					if v320 == v321 then
						v356.C0 = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1);
					end;
					v379 = "weldval";
					v380 = "FindFirstChild";
					v322 = v205;
					v381 = v322;
					v323 = v205;
					v324 = v380;
					v382 = v323[v324];
					v325 = v382;
					v326 = v381;
					v327 = v379;
					v383 = v325(v326, v327);
					v328 = v383;
					if v328 then
						v356.C1 = v205.weldval.Value;
					else
						v356.C1 = l__game__7.ReplicatedStorage.animationSets.global.gweldval.Value;
					end;
					v384 = u19;
					v385 = "Name";
					v329 = v384;
					v330 = v385;
					v386 = v329[v330];
					v387 = "Tourni";
					v331 = v386;
					v332 = v387;
					if v331 == v332 then
						v356.C0 = CFrame.new(0.155029297, -1.00993419, 0.217743874, 0, 7.10542736E-15, 0.999999285, 0.999999285, 0, 0, 0, 0.999999285, -7.10542736E-15);
						v356.C1 = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1);
					end;
					v388 = fparms;
					v389 = "Joints";
					v333 = v388;
					v334 = v389;
					v390 = v333[v334];
					v391 = "Parent";
					v335 = v356;
					v336 = v391;
					v337 = v390;
					v335[v336] = v337;
					v392 = u19;
					v393 = fparms;
					v394 = "Parent";
					v338 = v392;
					v339 = v394;
					v340 = v393;
					v338[v339] = v340;
					v209 = u9;
					v211 = false;
					v210 = "startswap";
					v212 = v209;
					v213 = v210;
					v214 = v211;
					v212[v213] = v214;
					v395 = fparms;
					v396 = l__CurrentCamera__1;
					v397 = "Parent";
					v215 = v395;
					v216 = v397;
					v217 = v396;
					v215[v216] = v217;
					v398 = pairs;
					v399 = "GetChildren";
					v218 = v205;
					v221 = v218;
					v219 = v205;
					v220 = v399;
					v400 = v219[v220];
					v222 = v400;
					v223 = v221;
					v225 = v222(v223);
					v224 = v398;
					local v436, v437, v438 = v224(v225);
					while true do
						if v402:IsA("Animation") then
							v403 = fparms.AC:LoadAnimation(v402);
							v403.Name = v402.Name;
							curentanimset[v402.Name] = v403;
						end;					
					end;
					v404 = pairs;
					v405 = "GetChildren";
					v226 = v206;
					v406 = v226;
					v227 = v206;
					v228 = v405;
					v407 = v227[v228];
					v229 = v407;
					v230 = v406;
					v232 = v229(v230);
					v231 = v404;
					local v439, v440, v441 = v231(v232);
					while true do
						if v409:IsA("Animation") then
							v410 = hum:LoadAnimation(v409);
							v410.Name = v409.Name;
							tpcurrentanimset[v409.Name] = v410;
						end;					
					end;
					v411 = curentanimset;
					v412 = "block";
					v233 = v411;
					v234 = v412;
					v413 = v233[v234];
					v235 = v413;
					if v235 then
						curentanimset.block:Stop();
						tpcurrentanimset.block:Stop();
					end;
					v414 = "weapontype";
					v236 = v193;
					v237 = v414;
					v415 = v236[v237];
					v416 = "Item";
					v238 = v415;
					v239 = v416;
					if v238 == v239 then
						if l__game__7.ReplicatedStorage.animationSets:FindFirstChild(v193.animset):FindFirstChild("equip") == nil then
							curentanimset.equip = globalanimsets.equip;
							tpcurrentanimset.equip = tpglobalanimsets.equip;
						end;
						l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", "Item" }, "draw", character.HumanoidRootPart);
					elseif l__game__7.ReplicatedStorage.soundLibrary.weapons:FindFirstChild(v193.weapontype) then
						if v196 == true then
							l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", v194 }, "draw", character.HumanoidRootPart);
						else
							l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", v193.weapontype }, "draw", character.HumanoidRootPart);
						end;
					else
						l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", v194 }, "draw", character.HumanoidRootPart);
						if v193.name == "FAMAS F1" and math.random(1, 3) == 1 then
							l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", v193.animset }, "aughfrench", character.HumanoidRootPart);
						end;
					end;
					v417 = "animset";
					v240 = v193;
					v241 = v417;
					v418 = v240[v241];
					v419 = "1PB";
					v242 = v418;
					v243 = v419;
					if v242 == v243 then
						spawn(function()
							v420 = tick();
							v421 = true;
							while true do
								if u17.animset ~= "1PB" then
									v421 = false;
									break;
								end;
								RS:wait();
								if tick() - v420 >= 0.4 then
									break;
								end;							
							end;
							if character.HumanoidRootPart:FindFirstChild("playerdrones") then
								baselayer = { character, l__workspace__1.NoTarget, l__workspace__1.GoreEffects, l__CurrentCamera__1, character.HumanoidRootPart:FindFirstChild("playerdrones").Part0.Parent };
							end;
							if v421 == true then
								v100({ "weapons", u17.animset }, "flash", nil, nil, true, true);
								l__plasmaEffect__422 = u19:WaitForChild("plasmaEffect");
								l__plasmaEffect__422:WaitForChild("flash").Enabled = true;
								l__plasmaEffect__422:WaitForChild("spark").Enabled = true;
								l__plasmaEffect__422:WaitForChild("lightglow").Enabled = true;
								l__plasmaEffect__422:WaitForChild("electric").Enabled = true;
								l__plasmaEffect__422.flash:Emit(20);
								l__plasmaEffect__422.spark:Emit(math.random(10, 20));
								l__plasmaEffect__422.flash.Enabled = false;
								l__plasmaEffect__422.spark.Enabled = false;
								if u19.Model:FindFirstChild("bladeglow") then
									u19.Model.bladeglow.Transparency = 0.1;
								end;
							end;
						end);
					end;
					v423 = "weapontype";
					v244 = v193;
					v245 = v423;
					v424 = v244[v245];
					v425 = "Gun";
					v246 = v424;
					v247 = v425;
					if (v246 == v247 or v193.weapontype == "Bow") and v193.weapontype == "Bow" then
						v426 = nil;
						for v427 = 1, 100 do
							if character:FindFirstChild("RBow") then
								v426 = character:FindFirstChild("RBow");
								if v426 == nil then
									v426 = character:FindFirstChild("CRBow");
									if v426 == nil then
										v426 = character:FindFirstChild("CPBow");
									end;
								end;
								break;
							end;
							if character:FindFirstChild("CRBow") then
								v426 = character:FindFirstChild("RBow");
								if v426 == nil then
									v426 = character:FindFirstChild("CRBow");
									if v426 == nil then
										v426 = character:FindFirstChild("CPBow");
									end;
								end;
								break;
							end;
							if character:FindFirstChild("CPBow") then
								v426 = character:FindFirstChild("RBow");
								if v426 == nil then
									v426 = character:FindFirstChild("CRBow");
									if v426 == nil then
										v426 = character:FindFirstChild("CPBow");
									end;
								end;
								break;
							end;
							RS:wait();
						end;
						if v426 then
							if u19:FindFirstChild("arrow") then
								for v428, v429 in ipairs(u19.arrow:GetChildren()) do
									if v429:IsA("BasePart") then
										v429.Transparency = 1;
									end;
								end;
							end;
							v426.bowString.stringA.Transparency = NumberSequence.new(1);
							v426.bowString.stringB.Transparency = NumberSequence.new(1);
						end;
					end;
					v430 = curentanimset;
					v431 = "equip";
					v248 = v430;
					v249 = v431;
					v432 = v248[v249];
					v250 = v432;
					if v250 then
						if playerperks.leather then
							if v193.weapontype == "Bludgeon" then
								if perksactive.leather == nil then
									perksactive.leather = true;
									u20 = u20 + v6.leather.efx[1] / 100;
								end;
							elseif perksactive.leather == true then
								perksactive.leather = nil;
								u20 = u20 - v6.leather.efx[1] / 100;
							end;
						end;
						if playerperks.boxer then
							if v193.weapontype == "Fists" then
								if perksactive.boxer == nil then
									perksactive.boxer = true;
									u21 = u21 + v6.boxer.efx[1] / 100;
								end;
							elseif perksactive.boxer == true then
								perksactive.boxer = nil;
								u21 = u21 - v6.boxer.efx[1] / 100;
							end;
						end;
						if playerperks.honor then
							if v193.weapontype == "Fists" then
								if perksactive.honor == nil then
									perksactive.honor = true;
									u21 = u21 + v6.honor.efx[1] / 100;
								end;
							elseif perksactive.honor == true then
								perksactive.honor = nil;
								u21 = u21 - v6.honor.efx[1] / 100;
							end;
						end;
						if v193.weapontype == "Fists" then
							if fist_speed_boost == false then
								fist_speed_boost = true;
								u22 = u22 + u13 * 15 / 100;
							end;
						elseif fist_speed_boost == true then
							fist_speed_boost = false;
							u22 = u22 - u13 * 15 / 100;
						end;
						if playerperks.mcrafter then
							if v193.name == "Crafted Spear" or v193.name == "Crafted Hatchet" or v193.name == "Crafted Knife" or v193.name == "Crafted Cudgel" then
								if perksactive.mcrafter == nil then
									perksactive.mcrafter = true;
									u21 = u21 + v6.mcrafter.efx[1] / 100;
								end;
							elseif perksactive.mcrafter == true then
								perksactive.mcrafter = nil;
								u21 = u21 - v6.mcrafter.efx[1] / 100;
							end;
						end;
						if playerperks.spearsrun then
							if v193.weapontype == "Spear" then
								if perksactive.spearsrun == nil then
									perksactive.spearsrun = true;
									u22 = u22 + u13 * v6.spearsrun.efx[1] / 100;
								end;
							elseif perksactive.spearsrun == true then
								perksactive.spearsrun = nil;
								u22 = u22 - u13 * v6.spearsrun.efx[1] / 100;
							end;
						end;
						if playerperks.tracker then
							if v193.name == "Mantracker" then
								if perksactive.tracker == nil then
									perksactive.tracker = true;
									u22 = u22 + u13 * v6.tracker.efx[1] / 100;
								end;
							elseif perksactive.tracker == true then
								perksactive.tracker = nil;
								u22 = u22 - u13 * v6.tracker.efx[1] / 100;
							end;
						end;
						if v193.name == "'Polters Last Wish'" or v193.name == "'Polters Last Breath'" then
							for v433, v434 in ipairs(u19.Model:GetChildren()) do
								v434.Transparency = 0;
							end;
						end;
						v435 = 0.6;
						if v193.name == "Fists" then
							v435 = 0.9;
						end;
						if v193.animset == "PST" or v193.animset == "2HPST" then
							v435 = 0.8;
						end;
						curentanimset.equip:AdjustSpeed(v435);
						curentanimset.equip:Play(0, 1, v435);
						tpcurrentanimset.equip:AdjustSpeed(v435);
						tpcurrentanimset.equip:Play(0.2, 1, v435);
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
									if v193.animset == "LSMG" then
										u24();
									end;
								end;
							end;
						end);
						if u19 and u19:FindFirstChild("skinned") and v19[u19:FindFirstChild("skinned").Value] then
							primskin = v19[u19:FindFirstChild("skinned").Value];
						end;
						drawlockout = tick();
						invmanage("updatehud");
						check_walking_anim();
					end;
					v251 = p50;
					u18 = v251;
					return;
				end;
			else
				v209 = u9;
				v211 = false;
				v210 = "startswap";
				v212 = v209;
				v213 = v210;
				v214 = v211;
				v212[v213] = v214;
				v395 = fparms;
				v396 = l__CurrentCamera__1;
				v397 = "Parent";
				v215 = v395;
				v216 = v397;
				v217 = v396;
				v215[v216] = v217;
				v398 = pairs;
				v399 = "GetChildren";
				v218 = v205;
				v221 = v218;
				v219 = v205;
				v220 = v399;
				v400 = v219[v220];
				v222 = v400;
				v223 = v221;
				v225 = v222(v223);
				v224 = v398;
				v436, v437, v438 = v224(v225);
				while true do
					if v402:IsA("Animation") then
						v403 = fparms.AC:LoadAnimation(v402);
						v403.Name = v402.Name;
						curentanimset[v402.Name] = v403;
					end;				
				end;
				v404 = pairs;
				v405 = "GetChildren";
				v226 = v206;
				v406 = v226;
				v227 = v206;
				v228 = v405;
				v407 = v227[v228];
				v229 = v407;
				v230 = v406;
				v232 = v229(v230);
				v231 = v404;
				v439, v440, v441 = v231(v232);
				while true do
					if v409:IsA("Animation") then
						v410 = hum:LoadAnimation(v409);
						v410.Name = v409.Name;
						tpcurrentanimset[v409.Name] = v410;
					end;				
				end;
				v411 = curentanimset;
				v412 = "block";
				v233 = v411;
				v234 = v412;
				v413 = v233[v234];
				v235 = v413;
				if v235 then
					curentanimset.block:Stop();
					tpcurrentanimset.block:Stop();
				end;
				v414 = "weapontype";
				v236 = v193;
				v237 = v414;
				v415 = v236[v237];
				v416 = "Item";
				v238 = v415;
				v239 = v416;
				if v238 == v239 then
					if l__game__7.ReplicatedStorage.animationSets:FindFirstChild(v193.animset):FindFirstChild("equip") == nil then
						curentanimset.equip = globalanimsets.equip;
						tpcurrentanimset.equip = tpglobalanimsets.equip;
					end;
					l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", "Item" }, "draw", character.HumanoidRootPart);
				elseif l__game__7.ReplicatedStorage.soundLibrary.weapons:FindFirstChild(v193.weapontype) then
					if v196 == true then
						l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", v194 }, "draw", character.HumanoidRootPart);
					else
						l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", v193.weapontype }, "draw", character.HumanoidRootPart);
					end;
				else
					l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", v194 }, "draw", character.HumanoidRootPart);
					if v193.name == "FAMAS F1" and math.random(1, 3) == 1 then
						l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", v193.animset }, "aughfrench", character.HumanoidRootPart);
					end;
				end;
				v417 = "animset";
				v240 = v193;
				v241 = v417;
				v418 = v240[v241];
				v419 = "1PB";
				v242 = v418;
				v243 = v419;
				if v242 == v243 then
					spawn(function()
						v420 = tick();
						v421 = true;
						while true do
							if u17.animset ~= "1PB" then
								v421 = false;
								break;
							end;
							RS:wait();
							if tick() - v420 >= 0.4 then
								break;
							end;						
						end;
						if character.HumanoidRootPart:FindFirstChild("playerdrones") then
							baselayer = { character, l__workspace__1.NoTarget, l__workspace__1.GoreEffects, l__CurrentCamera__1, character.HumanoidRootPart:FindFirstChild("playerdrones").Part0.Parent };
						end;
						if v421 == true then
							v100({ "weapons", u17.animset }, "flash", nil, nil, true, true);
							l__plasmaEffect__422 = u19:WaitForChild("plasmaEffect");
							l__plasmaEffect__422:WaitForChild("flash").Enabled = true;
							l__plasmaEffect__422:WaitForChild("spark").Enabled = true;
							l__plasmaEffect__422:WaitForChild("lightglow").Enabled = true;
							l__plasmaEffect__422:WaitForChild("electric").Enabled = true;
							l__plasmaEffect__422.flash:Emit(20);
							l__plasmaEffect__422.spark:Emit(math.random(10, 20));
							l__plasmaEffect__422.flash.Enabled = false;
							l__plasmaEffect__422.spark.Enabled = false;
							if u19.Model:FindFirstChild("bladeglow") then
								u19.Model.bladeglow.Transparency = 0.1;
							end;
						end;
					end);
				end;
				v423 = "weapontype";
				v244 = v193;
				v245 = v423;
				v424 = v244[v245];
				v425 = "Gun";
				v246 = v424;
				v247 = v425;
				if (v246 == v247 or v193.weapontype == "Bow") and v193.weapontype == "Bow" then
					v426 = nil;
					for v427 = 1, 100 do
						if character:FindFirstChild("RBow") then
							v426 = character:FindFirstChild("RBow");
							if v426 == nil then
								v426 = character:FindFirstChild("CRBow");
								if v426 == nil then
									v426 = character:FindFirstChild("CPBow");
								end;
							end;
							break;
						end;
						if character:FindFirstChild("CRBow") then
							v426 = character:FindFirstChild("RBow");
							if v426 == nil then
								v426 = character:FindFirstChild("CRBow");
								if v426 == nil then
									v426 = character:FindFirstChild("CPBow");
								end;
							end;
							break;
						end;
						if character:FindFirstChild("CPBow") then
							v426 = character:FindFirstChild("RBow");
							if v426 == nil then
								v426 = character:FindFirstChild("CRBow");
								if v426 == nil then
									v426 = character:FindFirstChild("CPBow");
								end;
							end;
							break;
						end;
						RS:wait();
					end;
					if v426 then
						if u19:FindFirstChild("arrow") then
							for v428, v429 in ipairs(u19.arrow:GetChildren()) do
								if v429:IsA("BasePart") then
									v429.Transparency = 1;
								end;
							end;
						end;
						v426.bowString.stringA.Transparency = NumberSequence.new(1);
						v426.bowString.stringB.Transparency = NumberSequence.new(1);
					end;
				end;
				v430 = curentanimset;
				v431 = "equip";
				v248 = v430;
				v249 = v431;
				v432 = v248[v249];
				v250 = v432;
				if v250 then
					if playerperks.leather then
						if v193.weapontype == "Bludgeon" then
							if perksactive.leather == nil then
								perksactive.leather = true;
								u20 = u20 + v6.leather.efx[1] / 100;
							end;
						elseif perksactive.leather == true then
							perksactive.leather = nil;
							u20 = u20 - v6.leather.efx[1] / 100;
						end;
					end;
					if playerperks.boxer then
						if v193.weapontype == "Fists" then
							if perksactive.boxer == nil then
								perksactive.boxer = true;
								u21 = u21 + v6.boxer.efx[1] / 100;
							end;
						elseif perksactive.boxer == true then
							perksactive.boxer = nil;
							u21 = u21 - v6.boxer.efx[1] / 100;
						end;
					end;
					if playerperks.honor then
						if v193.weapontype == "Fists" then
							if perksactive.honor == nil then
								perksactive.honor = true;
								u21 = u21 + v6.honor.efx[1] / 100;
							end;
						elseif perksactive.honor == true then
							perksactive.honor = nil;
							u21 = u21 - v6.honor.efx[1] / 100;
						end;
					end;
					if v193.weapontype == "Fists" then
						if fist_speed_boost == false then
							fist_speed_boost = true;
							u22 = u22 + u13 * 15 / 100;
						end;
					elseif fist_speed_boost == true then
						fist_speed_boost = false;
						u22 = u22 - u13 * 15 / 100;
					end;
					if playerperks.mcrafter then
						if v193.name == "Crafted Spear" or v193.name == "Crafted Hatchet" or v193.name == "Crafted Knife" or v193.name == "Crafted Cudgel" then
							if perksactive.mcrafter == nil then
								perksactive.mcrafter = true;
								u21 = u21 + v6.mcrafter.efx[1] / 100;
							end;
						elseif perksactive.mcrafter == true then
							perksactive.mcrafter = nil;
							u21 = u21 - v6.mcrafter.efx[1] / 100;
						end;
					end;
					if playerperks.spearsrun then
						if v193.weapontype == "Spear" then
							if perksactive.spearsrun == nil then
								perksactive.spearsrun = true;
								u22 = u22 + u13 * v6.spearsrun.efx[1] / 100;
							end;
						elseif perksactive.spearsrun == true then
							perksactive.spearsrun = nil;
							u22 = u22 - u13 * v6.spearsrun.efx[1] / 100;
						end;
					end;
					if playerperks.tracker then
						if v193.name == "Mantracker" then
							if perksactive.tracker == nil then
								perksactive.tracker = true;
								u22 = u22 + u13 * v6.tracker.efx[1] / 100;
							end;
						elseif perksactive.tracker == true then
							perksactive.tracker = nil;
							u22 = u22 - u13 * v6.tracker.efx[1] / 100;
						end;
					end;
					if v193.name == "'Polters Last Wish'" or v193.name == "'Polters Last Breath'" then
						for v433, v434 in ipairs(u19.Model:GetChildren()) do
							v434.Transparency = 0;
						end;
					end;
					v435 = 0.6;
					if v193.name == "Fists" then
						v435 = 0.9;
					end;
					if v193.animset == "PST" or v193.animset == "2HPST" then
						v435 = 0.8;
					end;
					curentanimset.equip:AdjustSpeed(v435);
					curentanimset.equip:Play(0, 1, v435);
					tpcurrentanimset.equip:AdjustSpeed(v435);
					tpcurrentanimset.equip:Play(0.2, 1, v435);
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
								if v193.animset == "LSMG" then
									u24();
								end;
							end;
						end;
					end);
					if u19 and u19:FindFirstChild("skinned") and v19[u19:FindFirstChild("skinned").Value] then
						primskin = v19[u19:FindFirstChild("skinned").Value];
					end;
					drawlockout = tick();
					invmanage("updatehud");
					check_walking_anim();
				end;
				v251 = p50;
				u18 = v251;
				return;
			end;
		else
			v252 = nil;
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
			if v196 == true and v204 == true and p50 == "Fist" then
				v204 = false;
			end;
			if character:FindFirstChild("hasPrimary") then
				v341 = tick();
				if v204 == true then
					while true do
						drawlockout = tick();
						RS:wait();
						if tick() - v341 >= 2 then
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
						if tick() - v341 >= 2 then
							break;
						end;
						if v196 == true then
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
			if v204 == true then
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
					v252 = true;
					v253 = v197;
					v254 = v252;
					if v253 == v254 then
						v342 = Instance.new("BoolValue");
						v342.Name = "trapped";
						v342.Parent = u19;
					end;
					v255 = u19;
					v343 = "JointGrip";
					v256 = v255;
					v257 = v343;
					v267 = v256[v257];
					v258 = fparms;
					v344 = "RightArm";
					v259 = v258;
					v260 = v344;
					v261 = v259[v260];
					v345 = "RUpperArm";
					v262 = v261;
					v263 = v345;
					v264 = v262[v263];
					v346 = "CFrame";
					v265 = v264;
					v266 = v346;
					v347 = v265[v266];
					v348 = "CFrame";
					v268 = v267;
					v269 = v348;
					v270 = v347;
					v268[v269] = v270;
					v349 = u19;
					v350 = "JointGrip";
					v271 = v349;
					v272 = v350;
					v351 = v271[v272];
					v352 = true;
					v353 = "Locked";
					v273 = v351;
					v274 = v353;
					v275 = v352;
					v273[v274] = v275;
					v354 = Instance.new;
					v355 = "Motor6D";
					v276 = v354;
					v277 = v355;
					v356 = v276(v277);
					v357 = "WeaponJoint";
					v358 = "Name";
					v278 = v356;
					v279 = v358;
					v280 = v357;
					v278[v279] = v280;
					v359 = fparms;
					v360 = "RightArm";
					v281 = v359;
					v282 = v360;
					v361 = v281[v282];
					v362 = "RUpperArm";
					v283 = v361;
					v284 = v362;
					v363 = v283[v284];
					v364 = "Part0";
					v285 = v356;
					v286 = v364;
					v287 = v363;
					v285[v286] = v287;
					v365 = u19;
					v366 = "JointGrip";
					v288 = v365;
					v289 = v366;
					v367 = v288[v289];
					v368 = "Part1";
					v290 = v356;
					v291 = v368;
					v292 = v367;
					v290[v291] = v292;
					v369 = CFrame.new;
					v370 = 0;
					v371 = -1;
					v372 = 0;
					v293 = 1;
					v294 = 0;
					v295 = 0;
					v296 = 0;
					v297 = 1;
					v298 = 0;
					v299 = 0;
					v300 = 0;
					v301 = 1;
					v302 = v369;
					v303 = v370;
					v304 = v371;
					v305 = v372;
					v306 = v293;
					v307 = v294;
					v308 = v295;
					v309 = v296;
					v310 = v297;
					v311 = v298;
					v312 = v299;
					v313 = v300;
					v314 = v301;
					v373 = v302(v303, v304, v305, v306, v307, v308, v309, v310, v311, v312, v313, v314);
					v374 = "C0";
					v315 = v356;
					v316 = v374;
					v317 = v373;
					v315[v316] = v317;
					v375 = u19;
					v376 = "Name";
					v318 = v375;
					v319 = v376;
					v377 = v318[v319];
					v378 = "LSMini";
					v320 = v377;
					v321 = v378;
					if v320 == v321 then
						v356.C0 = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1);
					end;
					v379 = "weldval";
					v380 = "FindFirstChild";
					v322 = v205;
					v381 = v322;
					v323 = v205;
					v324 = v380;
					v382 = v323[v324];
					v325 = v382;
					v326 = v381;
					v327 = v379;
					v383 = v325(v326, v327);
					v328 = v383;
					if v328 then
						v356.C1 = v205.weldval.Value;
					else
						v356.C1 = l__game__7.ReplicatedStorage.animationSets.global.gweldval.Value;
					end;
					v384 = u19;
					v385 = "Name";
					v329 = v384;
					v330 = v385;
					v386 = v329[v330];
					v387 = "Tourni";
					v331 = v386;
					v332 = v387;
					if v331 == v332 then
						v356.C0 = CFrame.new(0.155029297, -1.00993419, 0.217743874, 0, 7.10542736E-15, 0.999999285, 0.999999285, 0, 0, 0, 0.999999285, -7.10542736E-15);
						v356.C1 = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1);
					end;
					v388 = fparms;
					v389 = "Joints";
					v333 = v388;
					v334 = v389;
					v390 = v333[v334];
					v391 = "Parent";
					v335 = v356;
					v336 = v391;
					v337 = v390;
					v335[v336] = v337;
					v392 = u19;
					v393 = fparms;
					v394 = "Parent";
					v338 = v392;
					v339 = v394;
					v340 = v393;
					v338[v339] = v340;
					v209 = u9;
					v211 = false;
					v210 = "startswap";
					v212 = v209;
					v213 = v210;
					v214 = v211;
					v212[v213] = v214;
					v395 = fparms;
					v396 = l__CurrentCamera__1;
					v397 = "Parent";
					v215 = v395;
					v216 = v397;
					v217 = v396;
					v215[v216] = v217;
					v398 = pairs;
					v399 = "GetChildren";
					v218 = v205;
					v221 = v218;
					v219 = v205;
					v220 = v399;
					v400 = v219[v220];
					v222 = v400;
					v223 = v221;
					v225 = v222(v223);
					v224 = v398;
					for v401, v402 in v224(v225) do
						if v402:IsA("Animation") then
							v403 = fparms.AC:LoadAnimation(v402);
							v403.Name = v402.Name;
							curentanimset[v402.Name] = v403;
						end;
					end;
					v404 = pairs;
					v405 = "GetChildren";
					v226 = v206;
					v406 = v226;
					v227 = v206;
					v228 = v405;
					v407 = v227[v228];
					v229 = v407;
					v230 = v406;
					v232 = v229(v230);
					v231 = v404;
					for v408, v409 in v231(v232) do
						if v409:IsA("Animation") then
							v410 = hum:LoadAnimation(v409);
							v410.Name = v409.Name;
							tpcurrentanimset[v409.Name] = v410;
						end;
					end;
					v411 = curentanimset;
					v412 = "block";
					v233 = v411;
					v234 = v412;
					v413 = v233[v234];
					v235 = v413;
					if v235 then
						curentanimset.block:Stop();
						tpcurrentanimset.block:Stop();
					end;
					v414 = "weapontype";
					v236 = v193;
					v237 = v414;
					v415 = v236[v237];
					v416 = "Item";
					v238 = v415;
					v239 = v416;
					if v238 == v239 then
						if l__game__7.ReplicatedStorage.animationSets:FindFirstChild(v193.animset):FindFirstChild("equip") == nil then
							curentanimset.equip = globalanimsets.equip;
							tpcurrentanimset.equip = tpglobalanimsets.equip;
						end;
						l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", "Item" }, "draw", character.HumanoidRootPart);
					elseif l__game__7.ReplicatedStorage.soundLibrary.weapons:FindFirstChild(v193.weapontype) then
						if v196 == true then
							l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", v194 }, "draw", character.HumanoidRootPart);
						else
							l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", v193.weapontype }, "draw", character.HumanoidRootPart);
						end;
					else
						l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", v194 }, "draw", character.HumanoidRootPart);
						if v193.name == "FAMAS F1" and math.random(1, 3) == 1 then
							l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", v193.animset }, "aughfrench", character.HumanoidRootPart);
						end;
					end;
					v417 = "animset";
					v240 = v193;
					v241 = v417;
					v418 = v240[v241];
					v419 = "1PB";
					v242 = v418;
					v243 = v419;
					if v242 == v243 then
						spawn(function()
							v420 = tick();
							v421 = true;
							while true do
								if u17.animset ~= "1PB" then
									v421 = false;
									break;
								end;
								RS:wait();
								if tick() - v420 >= 0.4 then
									break;
								end;							
							end;
							if character.HumanoidRootPart:FindFirstChild("playerdrones") then
								baselayer = { character, l__workspace__1.NoTarget, l__workspace__1.GoreEffects, l__CurrentCamera__1, character.HumanoidRootPart:FindFirstChild("playerdrones").Part0.Parent };
							end;
							if v421 == true then
								v100({ "weapons", u17.animset }, "flash", nil, nil, true, true);
								l__plasmaEffect__422 = u19:WaitForChild("plasmaEffect");
								l__plasmaEffect__422:WaitForChild("flash").Enabled = true;
								l__plasmaEffect__422:WaitForChild("spark").Enabled = true;
								l__plasmaEffect__422:WaitForChild("lightglow").Enabled = true;
								l__plasmaEffect__422:WaitForChild("electric").Enabled = true;
								l__plasmaEffect__422.flash:Emit(20);
								l__plasmaEffect__422.spark:Emit(math.random(10, 20));
								l__plasmaEffect__422.flash.Enabled = false;
								l__plasmaEffect__422.spark.Enabled = false;
								if u19.Model:FindFirstChild("bladeglow") then
									u19.Model.bladeglow.Transparency = 0.1;
								end;
							end;
						end);
					end;
					v423 = "weapontype";
					v244 = v193;
					v245 = v423;
					v424 = v244[v245];
					v425 = "Gun";
					v246 = v424;
					v247 = v425;
					if (v246 == v247 or v193.weapontype == "Bow") and v193.weapontype == "Bow" then
						v426 = nil;
						for v427 = 1, 100 do
							if character:FindFirstChild("RBow") then
								v426 = character:FindFirstChild("RBow");
								if v426 == nil then
									v426 = character:FindFirstChild("CRBow");
									if v426 == nil then
										v426 = character:FindFirstChild("CPBow");
									end;
								end;
								break;
							end;
							if character:FindFirstChild("CRBow") then
								v426 = character:FindFirstChild("RBow");
								if v426 == nil then
									v426 = character:FindFirstChild("CRBow");
									if v426 == nil then
										v426 = character:FindFirstChild("CPBow");
									end;
								end;
								break;
							end;
							if character:FindFirstChild("CPBow") then
								v426 = character:FindFirstChild("RBow");
								if v426 == nil then
									v426 = character:FindFirstChild("CRBow");
									if v426 == nil then
										v426 = character:FindFirstChild("CPBow");
									end;
								end;
								break;
							end;
							RS:wait();
						end;
						if v426 then
							if u19:FindFirstChild("arrow") then
								for v428, v429 in ipairs(u19.arrow:GetChildren()) do
									if v429:IsA("BasePart") then
										v429.Transparency = 1;
									end;
								end;
							end;
							v426.bowString.stringA.Transparency = NumberSequence.new(1);
							v426.bowString.stringB.Transparency = NumberSequence.new(1);
						end;
					end;
					v430 = curentanimset;
					v431 = "equip";
					v248 = v430;
					v249 = v431;
					v432 = v248[v249];
					v250 = v432;
					if v250 then
						if playerperks.leather then
							if v193.weapontype == "Bludgeon" then
								if perksactive.leather == nil then
									perksactive.leather = true;
									u20 = u20 + v6.leather.efx[1] / 100;
								end;
							elseif perksactive.leather == true then
								perksactive.leather = nil;
								u20 = u20 - v6.leather.efx[1] / 100;
							end;
						end;
						if playerperks.boxer then
							if v193.weapontype == "Fists" then
								if perksactive.boxer == nil then
									perksactive.boxer = true;
									u21 = u21 + v6.boxer.efx[1] / 100;
								end;
							elseif perksactive.boxer == true then
								perksactive.boxer = nil;
								u21 = u21 - v6.boxer.efx[1] / 100;
							end;
						end;
						if playerperks.honor then
							if v193.weapontype == "Fists" then
								if perksactive.honor == nil then
									perksactive.honor = true;
									u21 = u21 + v6.honor.efx[1] / 100;
								end;
							elseif perksactive.honor == true then
								perksactive.honor = nil;
								u21 = u21 - v6.honor.efx[1] / 100;
							end;
						end;
						if v193.weapontype == "Fists" then
							if fist_speed_boost == false then
								fist_speed_boost = true;
								u22 = u22 + u13 * 15 / 100;
							end;
						elseif fist_speed_boost == true then
							fist_speed_boost = false;
							u22 = u22 - u13 * 15 / 100;
						end;
						if playerperks.mcrafter then
							if v193.name == "Crafted Spear" or v193.name == "Crafted Hatchet" or v193.name == "Crafted Knife" or v193.name == "Crafted Cudgel" then
								if perksactive.mcrafter == nil then
									perksactive.mcrafter = true;
									u21 = u21 + v6.mcrafter.efx[1] / 100;
								end;
							elseif perksactive.mcrafter == true then
								perksactive.mcrafter = nil;
								u21 = u21 - v6.mcrafter.efx[1] / 100;
							end;
						end;
						if playerperks.spearsrun then
							if v193.weapontype == "Spear" then
								if perksactive.spearsrun == nil then
									perksactive.spearsrun = true;
									u22 = u22 + u13 * v6.spearsrun.efx[1] / 100;
								end;
							elseif perksactive.spearsrun == true then
								perksactive.spearsrun = nil;
								u22 = u22 - u13 * v6.spearsrun.efx[1] / 100;
							end;
						end;
						if playerperks.tracker then
							if v193.name == "Mantracker" then
								if perksactive.tracker == nil then
									perksactive.tracker = true;
									u22 = u22 + u13 * v6.tracker.efx[1] / 100;
								end;
							elseif perksactive.tracker == true then
								perksactive.tracker = nil;
								u22 = u22 - u13 * v6.tracker.efx[1] / 100;
							end;
						end;
						if v193.name == "'Polters Last Wish'" or v193.name == "'Polters Last Breath'" then
							for v433, v434 in ipairs(u19.Model:GetChildren()) do
								v434.Transparency = 0;
							end;
						end;
						v435 = 0.6;
						if v193.name == "Fists" then
							v435 = 0.9;
						end;
						if v193.animset == "PST" or v193.animset == "2HPST" then
							v435 = 0.8;
						end;
						curentanimset.equip:AdjustSpeed(v435);
						curentanimset.equip:Play(0, 1, v435);
						tpcurrentanimset.equip:AdjustSpeed(v435);
						tpcurrentanimset.equip:Play(0.2, 1, v435);
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
									if v193.animset == "LSMG" then
										u24();
									end;
								end;
							end;
						end);
						if u19 and u19:FindFirstChild("skinned") and v19[u19:FindFirstChild("skinned").Value] then
							primskin = v19[u19:FindFirstChild("skinned").Value];
						end;
						drawlockout = tick();
						invmanage("updatehud");
						check_walking_anim();
					end;
					v251 = p50;
					u18 = v251;
					return;
				else
					u9.action = false;
					u9.swapping = false;
					return;
				end;
			else
				u19 = l__game__7.ReplicatedStorage.Weapons:FindFirstChild(v195):Clone();
				if v196 == true and playerstats.Exotic == "Tanto" then
					u19.sheath.Transparency = 0;
				end;
				v252 = true;
				v253 = v197;
				v254 = v252;
				if v253 == v254 then
					v342 = Instance.new("BoolValue");
					v342.Name = "trapped";
					v342.Parent = u19;
				end;
				v255 = u19;
				v343 = "JointGrip";
				v256 = v255;
				v257 = v343;
				v267 = v256[v257];
				v258 = fparms;
				v344 = "RightArm";
				v259 = v258;
				v260 = v344;
				v261 = v259[v260];
				v345 = "RUpperArm";
				v262 = v261;
				v263 = v345;
				v264 = v262[v263];
				v346 = "CFrame";
				v265 = v264;
				v266 = v346;
				v347 = v265[v266];
				v348 = "CFrame";
				v268 = v267;
				v269 = v348;
				v270 = v347;
				v268[v269] = v270;
				v349 = u19;
				v350 = "JointGrip";
				v271 = v349;
				v272 = v350;
				v351 = v271[v272];
				v352 = true;
				v353 = "Locked";
				v273 = v351;
				v274 = v353;
				v275 = v352;
				v273[v274] = v275;
				v354 = Instance.new;
				v355 = "Motor6D";
				v276 = v354;
				v277 = v355;
				v356 = v276(v277);
				v357 = "WeaponJoint";
				v358 = "Name";
				v278 = v356;
				v279 = v358;
				v280 = v357;
				v278[v279] = v280;
				v359 = fparms;
				v360 = "RightArm";
				v281 = v359;
				v282 = v360;
				v361 = v281[v282];
				v362 = "RUpperArm";
				v283 = v361;
				v284 = v362;
				v363 = v283[v284];
				v364 = "Part0";
				v285 = v356;
				v286 = v364;
				v287 = v363;
				v285[v286] = v287;
				v365 = u19;
				v366 = "JointGrip";
				v288 = v365;
				v289 = v366;
				v367 = v288[v289];
				v368 = "Part1";
				v290 = v356;
				v291 = v368;
				v292 = v367;
				v290[v291] = v292;
				v369 = CFrame.new;
				v370 = 0;
				v371 = -1;
				v372 = 0;
				v293 = 1;
				v294 = 0;
				v295 = 0;
				v296 = 0;
				v297 = 1;
				v298 = 0;
				v299 = 0;
				v300 = 0;
				v301 = 1;
				v302 = v369;
				v303 = v370;
				v304 = v371;
				v305 = v372;
				v306 = v293;
				v307 = v294;
				v308 = v295;
				v309 = v296;
				v310 = v297;
				v311 = v298;
				v312 = v299;
				v313 = v300;
				v314 = v301;
				v373 = v302(v303, v304, v305, v306, v307, v308, v309, v310, v311, v312, v313, v314);
				v374 = "C0";
				v315 = v356;
				v316 = v374;
				v317 = v373;
				v315[v316] = v317;
				v375 = u19;
				v376 = "Name";
				v318 = v375;
				v319 = v376;
				v377 = v318[v319];
				v378 = "LSMini";
				v320 = v377;
				v321 = v378;
				if v320 == v321 then
					v356.C0 = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1);
				end;
				v379 = "weldval";
				v380 = "FindFirstChild";
				v322 = v205;
				v381 = v322;
				v323 = v205;
				v324 = v380;
				v382 = v323[v324];
				v325 = v382;
				v326 = v381;
				v327 = v379;
				v383 = v325(v326, v327);
				v328 = v383;
				if v328 then
					v356.C1 = v205.weldval.Value;
				else
					v356.C1 = l__game__7.ReplicatedStorage.animationSets.global.gweldval.Value;
				end;
				v384 = u19;
				v385 = "Name";
				v329 = v384;
				v330 = v385;
				v386 = v329[v330];
				v387 = "Tourni";
				v331 = v386;
				v332 = v387;
				if v331 == v332 then
					v356.C0 = CFrame.new(0.155029297, -1.00993419, 0.217743874, 0, 7.10542736E-15, 0.999999285, 0.999999285, 0, 0, 0, 0.999999285, -7.10542736E-15);
					v356.C1 = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1);
				end;
				v388 = fparms;
				v389 = "Joints";
				v333 = v388;
				v334 = v389;
				v390 = v333[v334];
				v391 = "Parent";
				v335 = v356;
				v336 = v391;
				v337 = v390;
				v335[v336] = v337;
				v392 = u19;
				v393 = fparms;
				v394 = "Parent";
				v338 = v392;
				v339 = v394;
				v340 = v393;
				v338[v339] = v340;
				v209 = u9;
				v211 = false;
				v210 = "startswap";
				v212 = v209;
				v213 = v210;
				v214 = v211;
				v212[v213] = v214;
				v395 = fparms;
				v396 = l__CurrentCamera__1;
				v397 = "Parent";
				v215 = v395;
				v216 = v397;
				v217 = v396;
				v215[v216] = v217;
				v398 = pairs;
				v399 = "GetChildren";
				v218 = v205;
				v221 = v218;
				v219 = v205;
				v220 = v399;
				v400 = v219[v220];
				v222 = v400;
				v223 = v221;
				v225 = v222(v223);
				v224 = v398;
				v436, v437, v438 = v224(v225);
				while true do
					if v402:IsA("Animation") then
						v403 = fparms.AC:LoadAnimation(v402);
						v403.Name = v402.Name;
						curentanimset[v402.Name] = v403;
					end;				
				end;
				v404 = pairs;
				v405 = "GetChildren";
				v226 = v206;
				v406 = v226;
				v227 = v206;
				v228 = v405;
				v407 = v227[v228];
				v229 = v407;
				v230 = v406;
				v232 = v229(v230);
				v231 = v404;
				v439, v440, v441 = v231(v232);
				while true do
					if v409:IsA("Animation") then
						v410 = hum:LoadAnimation(v409);
						v410.Name = v409.Name;
						tpcurrentanimset[v409.Name] = v410;
					end;				
				end;
				v411 = curentanimset;
				v412 = "block";
				v233 = v411;
				v234 = v412;
				v413 = v233[v234];
				v235 = v413;
				if v235 then
					curentanimset.block:Stop();
					tpcurrentanimset.block:Stop();
				end;
				v414 = "weapontype";
				v236 = v193;
				v237 = v414;
				v415 = v236[v237];
				v416 = "Item";
				v238 = v415;
				v239 = v416;
				if v238 == v239 then
					if l__game__7.ReplicatedStorage.animationSets:FindFirstChild(v193.animset):FindFirstChild("equip") == nil then
						curentanimset.equip = globalanimsets.equip;
						tpcurrentanimset.equip = tpglobalanimsets.equip;
					end;
					l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", "Item" }, "draw", character.HumanoidRootPart);
				elseif l__game__7.ReplicatedStorage.soundLibrary.weapons:FindFirstChild(v193.weapontype) then
					if v196 == true then
						l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", v194 }, "draw", character.HumanoidRootPart);
					else
						l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", v193.weapontype }, "draw", character.HumanoidRootPart);
					end;
				else
					l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", v194 }, "draw", character.HumanoidRootPart);
					if v193.name == "FAMAS F1" and math.random(1, 3) == 1 then
						l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", v193.animset }, "aughfrench", character.HumanoidRootPart);
					end;
				end;
				v417 = "animset";
				v240 = v193;
				v241 = v417;
				v418 = v240[v241];
				v419 = "1PB";
				v242 = v418;
				v243 = v419;
				if v242 == v243 then
					spawn(function()
						v420 = tick();
						v421 = true;
						while true do
							if u17.animset ~= "1PB" then
								v421 = false;
								break;
							end;
							RS:wait();
							if tick() - v420 >= 0.4 then
								break;
							end;						
						end;
						if character.HumanoidRootPart:FindFirstChild("playerdrones") then
							baselayer = { character, l__workspace__1.NoTarget, l__workspace__1.GoreEffects, l__CurrentCamera__1, character.HumanoidRootPart:FindFirstChild("playerdrones").Part0.Parent };
						end;
						if v421 == true then
							v100({ "weapons", u17.animset }, "flash", nil, nil, true, true);
							l__plasmaEffect__422 = u19:WaitForChild("plasmaEffect");
							l__plasmaEffect__422:WaitForChild("flash").Enabled = true;
							l__plasmaEffect__422:WaitForChild("spark").Enabled = true;
							l__plasmaEffect__422:WaitForChild("lightglow").Enabled = true;
							l__plasmaEffect__422:WaitForChild("electric").Enabled = true;
							l__plasmaEffect__422.flash:Emit(20);
							l__plasmaEffect__422.spark:Emit(math.random(10, 20));
							l__plasmaEffect__422.flash.Enabled = false;
							l__plasmaEffect__422.spark.Enabled = false;
							if u19.Model:FindFirstChild("bladeglow") then
								u19.Model.bladeglow.Transparency = 0.1;
							end;
						end;
					end);
				end;
				v423 = "weapontype";
				v244 = v193;
				v245 = v423;
				v424 = v244[v245];
				v425 = "Gun";
				v246 = v424;
				v247 = v425;
				if (v246 == v247 or v193.weapontype == "Bow") and v193.weapontype == "Bow" then
					v426 = nil;
					for v427 = 1, 100 do
						if character:FindFirstChild("RBow") then
							v426 = character:FindFirstChild("RBow");
							if v426 == nil then
								v426 = character:FindFirstChild("CRBow");
								if v426 == nil then
									v426 = character:FindFirstChild("CPBow");
								end;
							end;
							break;
						end;
						if character:FindFirstChild("CRBow") then
							v426 = character:FindFirstChild("RBow");
							if v426 == nil then
								v426 = character:FindFirstChild("CRBow");
								if v426 == nil then
									v426 = character:FindFirstChild("CPBow");
								end;
							end;
							break;
						end;
						if character:FindFirstChild("CPBow") then
							v426 = character:FindFirstChild("RBow");
							if v426 == nil then
								v426 = character:FindFirstChild("CRBow");
								if v426 == nil then
									v426 = character:FindFirstChild("CPBow");
								end;
							end;
							break;
						end;
						RS:wait();
					end;
					if v426 then
						if u19:FindFirstChild("arrow") then
							for v428, v429 in ipairs(u19.arrow:GetChildren()) do
								if v429:IsA("BasePart") then
									v429.Transparency = 1;
								end;
							end;
						end;
						v426.bowString.stringA.Transparency = NumberSequence.new(1);
						v426.bowString.stringB.Transparency = NumberSequence.new(1);
					end;
				end;
				v430 = curentanimset;
				v431 = "equip";
				v248 = v430;
				v249 = v431;
				v432 = v248[v249];
				v250 = v432;
				if v250 then
					if playerperks.leather then
						if v193.weapontype == "Bludgeon" then
							if perksactive.leather == nil then
								perksactive.leather = true;
								u20 = u20 + v6.leather.efx[1] / 100;
							end;
						elseif perksactive.leather == true then
							perksactive.leather = nil;
							u20 = u20 - v6.leather.efx[1] / 100;
						end;
					end;
					if playerperks.boxer then
						if v193.weapontype == "Fists" then
							if perksactive.boxer == nil then
								perksactive.boxer = true;
								u21 = u21 + v6.boxer.efx[1] / 100;
							end;
						elseif perksactive.boxer == true then
							perksactive.boxer = nil;
							u21 = u21 - v6.boxer.efx[1] / 100;
						end;
					end;
					if playerperks.honor then
						if v193.weapontype == "Fists" then
							if perksactive.honor == nil then
								perksactive.honor = true;
								u21 = u21 + v6.honor.efx[1] / 100;
							end;
						elseif perksactive.honor == true then
							perksactive.honor = nil;
							u21 = u21 - v6.honor.efx[1] / 100;
						end;
					end;
					if v193.weapontype == "Fists" then
						if fist_speed_boost == false then
							fist_speed_boost = true;
							u22 = u22 + u13 * 15 / 100;
						end;
					elseif fist_speed_boost == true then
						fist_speed_boost = false;
						u22 = u22 - u13 * 15 / 100;
					end;
					if playerperks.mcrafter then
						if v193.name == "Crafted Spear" or v193.name == "Crafted Hatchet" or v193.name == "Crafted Knife" or v193.name == "Crafted Cudgel" then
							if perksactive.mcrafter == nil then
								perksactive.mcrafter = true;
								u21 = u21 + v6.mcrafter.efx[1] / 100;
							end;
						elseif perksactive.mcrafter == true then
							perksactive.mcrafter = nil;
							u21 = u21 - v6.mcrafter.efx[1] / 100;
						end;
					end;
					if playerperks.spearsrun then
						if v193.weapontype == "Spear" then
							if perksactive.spearsrun == nil then
								perksactive.spearsrun = true;
								u22 = u22 + u13 * v6.spearsrun.efx[1] / 100;
							end;
						elseif perksactive.spearsrun == true then
							perksactive.spearsrun = nil;
							u22 = u22 - u13 * v6.spearsrun.efx[1] / 100;
						end;
					end;
					if playerperks.tracker then
						if v193.name == "Mantracker" then
							if perksactive.tracker == nil then
								perksactive.tracker = true;
								u22 = u22 + u13 * v6.tracker.efx[1] / 100;
							end;
						elseif perksactive.tracker == true then
							perksactive.tracker = nil;
							u22 = u22 - u13 * v6.tracker.efx[1] / 100;
						end;
					end;
					if v193.name == "'Polters Last Wish'" or v193.name == "'Polters Last Breath'" then
						for v433, v434 in ipairs(u19.Model:GetChildren()) do
							v434.Transparency = 0;
						end;
					end;
					v435 = 0.6;
					if v193.name == "Fists" then
						v435 = 0.9;
					end;
					if v193.animset == "PST" or v193.animset == "2HPST" then
						v435 = 0.8;
					end;
					curentanimset.equip:AdjustSpeed(v435);
					curentanimset.equip:Play(0, 1, v435);
					tpcurrentanimset.equip:AdjustSpeed(v435);
					tpcurrentanimset.equip:Play(0.2, 1, v435);
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
								if v193.animset == "LSMG" then
									u24();
								end;
							end;
						end;
					end);
					if u19 and u19:FindFirstChild("skinned") and v19[u19:FindFirstChild("skinned").Value] then
						primskin = v19[u19:FindFirstChild("skinned").Value];
					end;
					drawlockout = tick();
					invmanage("updatehud");
					check_walking_anim();
				end;
				v251 = p50;
				u18 = v251;
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
local u65 = v49;
function unloadgun()
	local l__ammo__442 = l__game__7.ReplicatedStorage.Weapons:FindFirstChild(u19.Name):FindFirstChild("ammo");
	if l__ammo__442 ~= nil then
		if u9.action ~= true then
			if u17.ammoused ~= nil then
				if tick() - reload_locklout <= 2 then

				elseif akimbo_factors.active == true then
					return;
				else
					local l__Value__443 = l__ammo__442.Value;
					local v444 = nil;
					local v445, v446, v447 = pairs(v5);
					while true do
						local v448, v449 = v445(v446, v447);
						if v448 then

						else
							break;
						end;
						v447 = v448;
						if v449[2] == true then
							if v449[3] ~= nil then
								v444 = v449[3];
								if v449[3] <= 0 then
									return;
								end;
							end;
						end;					
					end;
					u9.action = true;
					reload_locklout = tick();
					local v450 = { globalanimsets.reload, tpglobalanimsets.reloadloop };
					if u17.animset == "MRV" then
						v450 = { curentanimset.reload, tpglobalanimsets.reloadloop };
					end;
					v450[1]:Play(0.3);
					v450[2]:Play(0.3);
					local u66 = nil;
					u66 = v450[1].KeyframeReached:connect(function(p54)
						if p54 == "Stop" then
							v450[1]:AdjustSpeed(0);
							u66:Disconnect();
						end;
					end);
					local u67 = nil;
					u67 = v450[2].KeyframeReached:connect(function(p55)
						if p55 == "Stop" then
							v450[2]:AdjustSpeed(0);
							u67:Disconnect();
						end;
					end);
					local v451 = tick();
					local v452 = 1 * u17.throwrating;
					l__workspace__1.ServerStuff.playAudio:FireServer({ "reloads" }, "unload", character.HumanoidRootPart, 0.05);
					local v453 = false;
					while true do
						if v452 / 1.3 < tick() - v451 then
							if v453 == false then
								v453 = true;
								l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "reloaddone", character.HumanoidRootPart, 0.05);
							end;
						end;
						if u17.weapontype ~= "Gun" then
							u9.action = false;
							v450[1]:Stop(0.5);
							v450[2]:Stop(0.5);
							return;
						end;
						RS:wait();
						if not (v452 < tick() - v451) then

						else
							break;
						end;					
					end;
					v450[1]:Stop(0.5);
					v450[2]:Stop(0.5);
					local v454, v455, v456 = pairs(v5);
					while true do
						local v457, v458 = v454(v455, v456);
						if v457 then

						else
							break;
						end;
						v456 = v457;
						if v458[2] == true then
							if v458[3] ~= nil then
								v458[3] = v458[3] - v444;
							end;
						end;					
					end;
					u64[u17.ammoused] = u64[u17.ammoused] + v444;
					invmanage("updatehud");
					local v459 = tick();
					local v460 = 0.2;
					while true do
						RS:wait();
						if not (v460 < tick() - v459) then

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
												local v461 = nil;
												local v462, v463, v464 = pairs(v5);
												while true do
													local v465, v466 = v462(v463, v464);
													if v465 then

													else
														break;
													end;
													v464 = v465;
													if v466[2] == false then
														if v17[v466[1]] then
															if v466[1] ~= "Mac" then
																if v17[v466[1]].animset ~= "PST" then

																else
																	v461 = v465;
																	break;
																end;
																if v17[v466[1]].animset ~= "2HPST" then

																else
																	v461 = v465;
																	break;
																end;
																if v17[v466[1]].animset == "RV" then
																	v461 = v465;
																	break;
																end;
															end;
														end;
													end;												
												end;
												if v461 ~= nil then
													akimbo_factors.weapon_slot = v461;
													akimbo_factors.alt_weapon_stats = v17[v5[v461][1]];
													akimbo_factors.alternate = false;
													akimbo_factors.alt_tick = 0;
													akimbo_factors.active = true;
													local v467 = l__game__7.ReplicatedStorage.Weapons:FindFirstChild(v5[v461][1]);
													if v467 then
														local v468 = l__game__7.ReplicatedStorage.misc.akimbocrosshair:Clone();
														local v469 = (u17.sizerating + akimbo_factors.alt_weapon_stats.sizerating) * 8;
														local v470 = math.clamp(v469 - v469 * v40, 10, 60);
														v468.Size = UDim2.new(0, v470, 0, v470);
														v468.Parent = maingui.Centre.crosshair;
														maingui.Centre.crosshair.A1.Visible = false;
														maingui.Centre.crosshair.A2.Visible = false;
														maingui.Centre.crosshair.B1.Visible = false;
														maingui.Centre.crosshair.B2.Visible = false;
														maingui.Centre.crosshair.dot.Visible = false;
														l__workspace__1.ServerStuff.playAudio:FireServer({ "firearms" }, "akimbo", character.HumanoidRootPart);
														u9.action = true;
														local v471 = v467:Clone();
														v471.Parent = fparms;
														akimbo_factors.alt_weapon = v471;
														local v472 = Instance.new("Motor6D");
														v472.Name = "fakeDual";
														v472.Part0 = fparms.LeftArm.LUpperArm;
														v472.Part1 = v471.JointGrip;
														v472.C0 = CFrame.new(0, -1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1) * CFrame.new(-0.1, 0, 0);
														local v473 = CFrame.new(0, 0, 0);
														local v474 = l__game__7.ReplicatedStorage.animationSets:FindFirstChild(akimbo_factors.alt_weapon_stats.animset);
														if v474:FindFirstChild("weldval") then
															v472.C1 = v474.weldval.Value;
														else
															v472.C1 = l__game__7.ReplicatedStorage.animationSets.global.gweldval.Value;
														end;
														v472.Parent = fparms.Joints;
														l__workspace__1.ServerStuff.quickDisplay:FireServer("fakeakimbo", { v5[v461][1], v472.C1 });
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
										v461 = nil;
										v462, v463, v464 = pairs(v5);
										while true do
											v465, v466 = v462(v463, v464);
											if v465 then

											else
												break;
											end;
											v464 = v465;
											if v466[2] == false then
												if v17[v466[1]] then
													if v466[1] ~= "Mac" then
														if v17[v466[1]].animset ~= "PST" then

														else
															v461 = v465;
															break;
														end;
														if v17[v466[1]].animset ~= "2HPST" then

														else
															v461 = v465;
															break;
														end;
														if v17[v466[1]].animset == "RV" then
															v461 = v465;
															break;
														end;
													end;
												end;
											end;										
										end;
										if v461 ~= nil then
											akimbo_factors.weapon_slot = v461;
											akimbo_factors.alt_weapon_stats = v17[v5[v461][1]];
											akimbo_factors.alternate = false;
											akimbo_factors.alt_tick = 0;
											akimbo_factors.active = true;
											v467 = l__game__7.ReplicatedStorage.Weapons:FindFirstChild(v5[v461][1]);
											if v467 then
												v468 = l__game__7.ReplicatedStorage.misc.akimbocrosshair:Clone();
												v469 = (u17.sizerating + akimbo_factors.alt_weapon_stats.sizerating) * 8;
												v470 = math.clamp(v469 - v469 * v40, 10, 60);
												v468.Size = UDim2.new(0, v470, 0, v470);
												v468.Parent = maingui.Centre.crosshair;
												maingui.Centre.crosshair.A1.Visible = false;
												maingui.Centre.crosshair.A2.Visible = false;
												maingui.Centre.crosshair.B1.Visible = false;
												maingui.Centre.crosshair.B2.Visible = false;
												maingui.Centre.crosshair.dot.Visible = false;
												l__workspace__1.ServerStuff.playAudio:FireServer({ "firearms" }, "akimbo", character.HumanoidRootPart);
												u9.action = true;
												v471 = v467:Clone();
												v471.Parent = fparms;
												akimbo_factors.alt_weapon = v471;
												v472 = Instance.new("Motor6D");
												v472.Name = "fakeDual";
												v472.Part0 = fparms.LeftArm.LUpperArm;
												v472.Part1 = v471.JointGrip;
												v472.C0 = CFrame.new(0, -1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1) * CFrame.new(-0.1, 0, 0);
												v473 = CFrame.new(0, 0, 0);
												v474 = l__game__7.ReplicatedStorage.animationSets:FindFirstChild(akimbo_factors.alt_weapon_stats.animset);
												if v474:FindFirstChild("weldval") then
													v472.C1 = v474.weldval.Value;
												else
													v472.C1 = l__game__7.ReplicatedStorage.animationSets.global.gweldval.Value;
												end;
												v472.Parent = fparms.Joints;
												l__workspace__1.ServerStuff.quickDisplay:FireServer("fakeakimbo", { v5[v461][1], v472.C1 });
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
									v461 = nil;
									v462, v463, v464 = pairs(v5);
									while true do
										v465, v466 = v462(v463, v464);
										if v465 then

										else
											break;
										end;
										v464 = v465;
										if v466[2] == false then
											if v17[v466[1]] then
												if v466[1] ~= "Mac" then
													if v17[v466[1]].animset ~= "PST" then

													else
														v461 = v465;
														break;
													end;
													if v17[v466[1]].animset ~= "2HPST" then

													else
														v461 = v465;
														break;
													end;
													if v17[v466[1]].animset == "RV" then
														v461 = v465;
														break;
													end;
												end;
											end;
										end;									
									end;
									if v461 ~= nil then
										akimbo_factors.weapon_slot = v461;
										akimbo_factors.alt_weapon_stats = v17[v5[v461][1]];
										akimbo_factors.alternate = false;
										akimbo_factors.alt_tick = 0;
										akimbo_factors.active = true;
										v467 = l__game__7.ReplicatedStorage.Weapons:FindFirstChild(v5[v461][1]);
										if v467 then
											v468 = l__game__7.ReplicatedStorage.misc.akimbocrosshair:Clone();
											v469 = (u17.sizerating + akimbo_factors.alt_weapon_stats.sizerating) * 8;
											v470 = math.clamp(v469 - v469 * v40, 10, 60);
											v468.Size = UDim2.new(0, v470, 0, v470);
											v468.Parent = maingui.Centre.crosshair;
											maingui.Centre.crosshair.A1.Visible = false;
											maingui.Centre.crosshair.A2.Visible = false;
											maingui.Centre.crosshair.B1.Visible = false;
											maingui.Centre.crosshair.B2.Visible = false;
											maingui.Centre.crosshair.dot.Visible = false;
											l__workspace__1.ServerStuff.playAudio:FireServer({ "firearms" }, "akimbo", character.HumanoidRootPart);
											u9.action = true;
											v471 = v467:Clone();
											v471.Parent = fparms;
											akimbo_factors.alt_weapon = v471;
											v472 = Instance.new("Motor6D");
											v472.Name = "fakeDual";
											v472.Part0 = fparms.LeftArm.LUpperArm;
											v472.Part1 = v471.JointGrip;
											v472.C0 = CFrame.new(0, -1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1) * CFrame.new(-0.1, 0, 0);
											v473 = CFrame.new(0, 0, 0);
											v474 = l__game__7.ReplicatedStorage.animationSets:FindFirstChild(akimbo_factors.alt_weapon_stats.animset);
											if v474:FindFirstChild("weldval") then
												v472.C1 = v474.weldval.Value;
											else
												v472.C1 = l__game__7.ReplicatedStorage.animationSets.global.gweldval.Value;
											end;
											v472.Parent = fparms.Joints;
											l__workspace__1.ServerStuff.quickDisplay:FireServer("fakeakimbo", { v5[v461][1], v472.C1 });
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
	local v475 = 0;
	for v476, v477 in pairs(v5) do
		if v477[2] == true and v477[3] ~= nil then
			v475 = v477[3];
		end;
	end;
	local v478 = u17.damagerating[3];
	if p59 == true then
		v478 = akimbo_factors.alt_weapon_stats.damagerating[3];
		v475 = v5[akimbo_factors.weapon_slot][3];
	end;
	if v475 <= 0 then
		return;
	end;
	u48(v478, p58, p59);
end;
local u72 = false;
local u73 = v39;
local u74 = false;
local u75 = tick();
local function v479(p60)
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
	local v480 = false;
	local v481 = false;
	local v482 = false;
	local v483 = false;
	while true do
		if ration_system_handler.full_bar - ration_system_handler.stats_lower <= tick() - ration_system_handler.hunger then
			if v481 == false then
				v481 = true;
				maingui.Thought.thoughttext.Text = "I'm starving.";
				inner_dialogue = tick();
				u21 = u21 - ration_system_handler.hunger_lower_atk / 100;
				u20 = u20 - ration_system_handler.hunger_lower_def / 100;
			end;
		elseif v481 == true then
			v481 = false;
			u21 = u21 + ration_system_handler.hunger_lower_atk / 100;
			u20 = u20 + ration_system_handler.hunger_lower_def / 100;
		end;
		if ration_system_handler.full_bar - ration_system_handler.stats_lower <= tick() - ration_system_handler.thirst then
			if v483 == false then
				v483 = true;
				maingui.Thought.thoughttext.Text = "I'm dehydrated.";
				inner_dialogue = tick();
				u21 = u21 - ration_system_handler.thirst_lower_atk / 100;
				u20 = u20 - ration_system_handler.thirst_lower_def / 100;
			end;
		elseif v483 == true then
			v483 = false;
			u21 = u21 + ration_system_handler.thirst_lower_atk / 100;
			u20 = u20 + ration_system_handler.thirst_lower_def / 100;
		end;
		if tick() - v108.timealive > 1 then
			if tick() - ration_system_handler.hunger <= ration_system_handler.full_bar - ration_system_handler.bonus_threshold then
				if v480 == false then
					v480 = true;
					maingui.Thought.thoughttext.Text = "I feel nourished.";
					inner_dialogue = tick();
					u21 = u21 + ration_system_handler.hunger_buff_atk / 100;
					u22 = u22 + ration_system_handler.hunger_buff_mvmt;
				end;
			elseif v480 == true then
				v480 = false;
				u21 = u21 - ration_system_handler.hunger_buff_atk / 100;
				u22 = u22 - ration_system_handler.hunger_buff_mvmt;
			end;
			if tick() - ration_system_handler.thirst <= ration_system_handler.full_bar - ration_system_handler.bonus_threshold then
				if v482 == false then
					v482 = true;
					maingui.Thought.thoughttext.Text = "I feel quenched.";
					inner_dialogue = tick();
					u20 = u20 + ration_system_handler.thirst_buff_def / 100;
					buff_sprint_stam = ration_system_handler.thirst_buff_stam;
				end;
			elseif v482 == true then
				v482 = false;
				u20 = u20 - ration_system_handler.thirst_buff_def / 100;
				buff_sprint_stam = 0;
			end;
		end;
		maingui.RationFrame.hunger.BackgroundColor3 = Color3.new(1, 1, 1);
		maingui.RationFrame.thirst.BackgroundColor3 = Color3.new(1, 1, 1);
		if v483 == true then
			maingui.RationFrame.thirst.BackgroundColor3 = Color3.fromRGB(170, 0, 0);
		end;
		if v481 == true then
			maingui.RationFrame.hunger.BackgroundColor3 = Color3.fromRGB(170, 0, 0);
		end;
		if v482 == true then
			maingui.RationFrame.thirst.BackgroundColor3 = Color3.fromRGB(19, 161, 30);
		end;
		if v480 == true then
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
	local v484 = 4.45;
	local v485 = globalanimsets["ration_" .. p63];
	local v486 = l__game__7.ReplicatedStorage.rations:FindFirstChild(p63);
	if v486 then
		u9.eating = true;
		if ration_system_handler[p63] then
			ration_system_handler[p63] = ration_system_handler[p63] - 1;
		end;
		u9.action = true;
		u9.channel = true;
		u22 = u22 - 8;
		local v487 = v486:Clone();
		v487.JointGrip.CFrame = l__CurrentCamera__1.CFrame;
		v487.Parent = fparms;
		local v488 = Instance.new("Motor6D");
		v488.Part1 = v487.JointGrip;
		v488.Part0 = fparms.RightArm.RUpperArm;
		v488.C0 = CFrame.new(0.182983398, -0.908285379, 0.225113869, 1.00000012, -7.27595761E-12, 8.77771527E-08, 8.70786607E-08, 4.47034836E-08, -1.00000012, 0, 1.00000012, 4.47034836E-08);
		v488.C1 = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1);
		v488.Parent = fparms.Joints;
		local v489 = false;
		local v490 = tick();
		local v491 = nil;
		if v485 ~= nil then
			v485:Play(0.1, 1, 0.8);
			v491 = v485.KeyframeReached:connect(function(p64)
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
		local v492 = tpglobalanimsets.ration_food;
		local v493 = false;
		local v494 = false;
		local v495 = "R.I.Beans";
		if p63 == "MRE" then
			v484 = 4.95;
			v493 = true;
			v495 = "MRE Lunchbox";
		elseif p63 == "Soda" then
			v492 = tpglobalanimsets.ration_drink;
			v484 = 4.85;
			v494 = true;
			v495 = "UlayCola";
		elseif p63 == "Bottle" then
			v492 = tpglobalanimsets.ration_drink;
			v484 = 3.75;
			v494 = true;
			v493 = true;
			v495 = "Aquafill Bottle";
		end;
		local v496 = v484 * 1.32;
		u76(v495, "CONSUMING");
		v492:Play(0.4, 1, 1);
		l__workspace__1.ServerStuff.quickDisplay:FireServer(p63);
		while true do
			maingui.ChargeOverlay.ChargeOverlay.Size = UDim2.new(math.clamp((tick() - v490) / v496, 0, 1), 0, 1, 0);
			RS:wait();
			if not (v496 <= tick() - v490) then

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
		v492:Stop(0.4);
		if v491 ~= nil then
			v491:Disconnect();
		end;
		v485:Stop(0.1, 1, 1);
		maingui.ChargeOverlay.Visible = false;
		if v496 <= tick() - v490 then
			v489 = true;
		end;
		if v489 == true then
			if v494 == true then
				ration_system_handler.cooldown_drink_tick = tick();
				if ration_system_handler.full_bar <= tick() - ration_system_handler.thirst then
					ration_system_handler.thirst = tick() - ration_system_handler.full_bar;
				end;
				if v493 == true then
					ration_system_handler.thirst = ration_system_handler.thirst + ration_system_handler.high_tier;
				else
					ration_system_handler.thirst = ration_system_handler.thirst + ration_system_handler.low_tier;
				end;
				if tick() - ration_system_handler.thirst <= 0 then
					ration_system_handler.thirst = tick();
					if v493 == true then
						ration_system_handler.thirst = ration_system_handler.thirst + ration_system_handler.bonus_add;
					end;
				end;
			else
				ration_system_handler.cooldown_eat_tick = tick();
				if ration_system_handler.full_bar <= tick() - ration_system_handler.hunger then
					ration_system_handler.hunger = tick() - ration_system_handler.full_bar;
				end;
				if v493 == true then
					ration_system_handler.hunger = ration_system_handler.hunger + ration_system_handler.high_tier;
				else
					ration_system_handler.hunger = ration_system_handler.hunger + ration_system_handler.low_tier;
				end;
				if tick() - ration_system_handler.hunger <= 0 then
					ration_system_handler.hunger = tick();
					if v493 == true then
						ration_system_handler.hunger = ration_system_handler.hunger + ration_system_handler.bonus_add;
					end;
				end;
			end;
		end;
		v487:Destroy();
		v488:Destroy();
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
	for v497 = 1, aux_usage do
		local v498 = maingui.UpperLower.auxcount.ex:Clone();
		v498.Name = "aux" .. v497;
		v498.Position = UDim2.new(1, 35 - 35 * #maingui.UpperLower.auxcount:GetChildren(), 0.65, 0);
		v498.Visible = true;
		v498.Parent = maingui.UpperLower.auxcount;
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
										local v499 = nil;
										if l__game__7.ReplicatedStorage.auxItems:FindFirstChild(aux_name) then
											v499 = l__game__7.ReplicatedStorage.auxItems:FindFirstChild(aux_name):Clone();
											v499.Parent = l__CurrentCamera__1;
										end;
										if v499 ~= nil then
											local v500 = Instance.new("Motor6D");
											v500.Part0 = fparms.LeftArm.LUpperArm;
											v500.Part1 = v499;
											v500.Parent = v499;
											v500.Parent = l__CurrentCamera__1;
										end;
										local v501 = globalanimsets.aux_resp;
										if globalanimsets["aux_" .. aux_name] then
											v501 = globalanimsets["aux_" .. aux_name];
										end;
										if tpglobalanimsets["aux_" .. aux_name] then
											tpglobalanimsets["aux_" .. aux_name]:Play(0.1);
										end;
										if aux_name == "knives" then
											v100({ "aux" }, "knife_equip", nil, nil, true, true);
										elseif aux_name == "decoy" then
											v100({ "aux" }, "decoy_ready", nil, nil, true, true);
										elseif aux_name == "concertina" then
											v100({ "aux" }, "concertina_hold", nil, nil, true, true);
										elseif aux_name == "tgas" then
											v100({ "aux" }, "tgas_equip", nil, nil, true, true);
										elseif aux_name == "ladder" then
											v100({ "aux" }, "ladder_grab", nil, nil, true, true);
										elseif aux_name == "buffer" then
											v100({ "echo_specific" }, "lighter", nil, nil, true, true);
											delay(0.3, function()
												v100({ "echo_specific" }, "lighter", nil, nil, true, true);
											end);
										elseif aux_name == "ballistic" then
											v100({ "aux" }, "ballistic_hold", nil, nil, true, true);
										end;
										local u77 = nil;
										u77 = v501.KeyframeReached:connect(function(p65)
											if p65 == "aux_use" then
												if current_aux.activestats.held == true then
													local v502 = false;
													maingui.Centre.crosshair.A1.Visible = false;
													maingui.Centre.crosshair.A2.Visible = false;
													maingui.Centre.crosshair.dot.Visible = false;
													maingui.Centre.crosshair.B1.Size = UDim2.new(0, 20, 0, 2);
													maingui.Centre.crosshair.B2.Size = UDim2.new(0, 20, 0, 2);
													v501.TimePosition = v501:GetTimeOfKeyframe("aux_use");
													v501:AdjustSpeed(0);
													v501.TimePosition = v501:GetTimeOfKeyframe("aux_use");
													while true do
														RS:wait();
														if u9.action ~= true then

														else
															v502 = true;
															break;
														end;
														if u9.channel ~= true then

														else
															v502 = true;
															break;
														end;
														if u9.staggering ~= true then

														else
															v502 = true;
															break;
														end;
														if u9.firing ~= true then

														else
															v502 = true;
															break;
														end;
														if u9.swinging ~= true then

														else
															v502 = true;
															break;
														end;
														if u9.blocking ~= true then

														else
															v502 = true;
															break;
														end;
														if u9.shoving ~= true then

														else
															v502 = true;
															break;
														end;
														if u9.swapping == true then
															v502 = true;
															break;
														end;
														if aux_held ~= false then

														else
															break;
														end;													
													end;
													v501.TimePosition = v501:GetTimeOfKeyframe("aux_use") + 0.01;
													if u9.throwing == false then
														maingui.Centre.crosshair.A1.Visible = true;
														maingui.Centre.crosshair.A2.Visible = true;
														maingui.Centre.crosshair.dot.Visible = true;
														maingui.Centre.crosshair.B1.Size = UDim2.new(0, 10, 0, 2);
														maingui.Centre.crosshair.B2.Size = UDim2.new(0, 10, 0, 2);
													end;
													if v502 == true then
														aux_held = false;
														u9.using_aux = false;
														v501:Stop(0);
														if v499 ~= nil then
															v499:Destroy();
														end;
														if u77 ~= nil then
															u77:Disconnect();
														end;
														return;
													end;
													v501:AdjustSpeed(1);
												end;
												aux_usage = aux_usage - 1;
												local v503, v504, v505 = ipairs(maingui.UpperLower.auxcount:GetChildren());
												while true do
													local v506, v507 = v503(v504, v505);
													if v506 then

													else
														break;
													end;
													v505 = v506;
													if v507.Name ~= "ex" then
														if tonumber(string.sub(v507.Name, 4, 6)) <= aux_usage then
															v507.inner.Visible = true;
														else
															v507.inner.Visible = false;
														end;
														if aux_usage == 0 then
															v507.inner.Visible = false;
														end;
													end;												
												end;
												if aux_name == "resp" then
													l__workspace__1.ServerStuff.playAudio:FireServer({ "aux" }, "resp_equip", character.HumanoidRootPart);
													afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).RespA);
													v499:Destroy();
													return;
												end;
												if aux_name == "knives" then
													tpglobalanimsets.aux_knifethrow:Play(0.1);
													l__workspace__1.ServerStuff.playAudio:FireServer({ "aux" }, "knife_throw", character.HumanoidRootPart);
													l__workspace__1.ServerStuff.throwWeapon:FireServer("TKnife", 20, l__CurrentCamera__1.CFrame, 1, v17.TKnife, 1, nil, v4);
													v499:Destroy();
													return;
												end;
												if aux_name == "tgas" then
													delay(0.45, function()
														l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", "Item" }, "pinpull", character.HumanoidRootPart);
													end);
													delay(0.8, function()
														l__workspace__1.ServerStuff.playAudio:FireServer({ "general_ui" }, "throw_fast", character.HumanoidRootPart);
														tpglobalanimsets.aux_overhead:Play(0.1);
														v499:Destroy();
														local v508 = l__CurrentCamera__1.CFrame + l__CurrentCamera__1.CFrame.lookVector * 1;
														l__workspace__1.ServerStuff.throwWeapon:FireServer("TGas", 20, l__CurrentCamera__1.CFrame, 1, v17.TGas, 1, nil, v4);
													end);
													return;
												end;
												if aux_name == "buffer" then
													v499:Destroy();
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
														v499:Destroy();
														l__workspace__1.ServerStuff.dealDamage:FireServer("throwdecoy", l__CurrentCamera__1.CFrame + l__CurrentCamera__1.CFrame.lookVector * 1, v4);
													end);
													return;
												end;
												if aux_name == "concertina" then
													delay(0.45, function()
														l__workspace__1.ServerStuff.playAudio:FireServer({ "aux" }, "concertina_throw", character.HumanoidRootPart);
														tpglobalanimsets.perk_throwing:Play(0.1);
														v499:Destroy();
														l__workspace__1.ServerStuff.dealDamage:FireServer("throwconcertina", l__CurrentCamera__1.CFrame + l__CurrentCamera__1.CFrame.lookVector * 1, v4);
													end);
													return;
												end;
												if aux_name == "ladder" then
													l__workspace__1.ServerStuff.playAudio:FireServer({ "aux" }, "ladder_deploy", character.HumanoidRootPart);
													tpglobalanimsets.aux_overhead:Play(0.1);
													v499:Destroy();
													l__workspace__1.ServerStuff.dealDamage:FireServer("create_ladder", l__CurrentCamera__1.CFrame + l__CurrentCamera__1.CFrame.lookVector * 1, v4);
													return;
												end;
												if aux_name == "holo" then
													l__workspace__1.ServerStuff.playAudio:FireServer({ "aux" }, "holo_spawn", character.HumanoidRootPart);
													l__workspace__1.ServerStuff.dealDamage:FireServer("create_holo", u30.w, v4);
													return;
												end;
												if aux_name == "ballistic" then
													tpglobalanimsets.aux_knifethrow:Play(0.1);
													l__workspace__1.ServerStuff.playAudio:FireServer({ "aux" }, "ballistic_shoot", character.HumanoidRootPart);
													v499.blade:Destroy();
													spawn(function()
														local v509, v510 = raycastline(l__CurrentCamera__1.CFrame.p, l__CurrentCamera__1.CFrame.LookVector, 80, baselayer);
														if v509 == nil then
															local v511 = v510;
															local v512 = 1 - 1;
															while true do
																local v513, v514 = raycastline(v511, l__CurrentCamera__1.CFrame.LookVector + Vector3.new(0, -0.05, 0), 3, baselayer);
																trigger_map_item_func(v513, "gundamage", 100);
																if v513 then
																	v509 = v513;
																	break;
																end;
																v511 = v514;
																RS:wait();
																if 0 <= 1 then
																	if v512 < 200 then

																	else
																		break;
																	end;
																elseif 200 < v512 then

																else
																	break;
																end;
																v512 = v512 + 1;															
															end;
														end;
														l__workspace__1.ServerStuff.applyGore:FireServer("bowarrow", character, ply, { l__CurrentCamera__1.CFrame, Vector3.new(0, 0, 0) });
														if v509 then
															if v509.Parent:FindFirstChild("Humanoid") then
																if 0 < v509.Parent:FindFirstChild("Humanoid").Health then
																	if v509.Parent:FindFirstChild("Head") then
																		if v509.Parent:IsDescendantOf(l__workspace__1.activeHostiles) then
																			v139();
																			u43(v509.Parent.Head.Position, current_aux.activestats.impact_damage);
																			l__workspace__1.ServerStuff.dealDamage:FireServer("aux_ballistic", v509.Parent, v4);
																		end;
																	end;
																end;
															end;
														end;
													end);
												end;
											end;
										end);
										v501:Play(0.1, 1, 1);
										while true do
											RS:wait();
											if v501.IsPlaying ~= false then

											else
												break;
											end;										
										end;
										u9.using_aux = false;
										if v499 ~= nil then
											v499:Destroy();
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
			local v515 = 1 - 1;
			while true do
				if sniperscope == nil then
					return;
				end;
				sniperscope.scopedFrame.Size = sniperscope.scopedFrame.Size + UDim2.new(0, 12, 0, 12);
				RS:wait();
				if 0 <= 1 then
					if v515 < 10 then

					else
						break;
					end;
				elseif 10 < v515 then

				else
					break;
				end;
				v515 = v515 + 1;			
			end;
			if sniperscope == nil then
				return;
			else
				local v516 = 1 - 1;
				while true do
					if sniperscope == nil then
						return;
					end;
					sniperscope.scopedFrame.Size = sniperscope.scopedFrame.Size - UDim2.new(0, 6, 0, 6);
					RS:wait();
					if 0 <= 1 then
						if v516 < 20 then

						else
							break;
						end;
					elseif 20 < v516 then

					else
						break;
					end;
					v516 = v516 + 1;				
				end;
				return;
			end;
		end;
		if p66 == "tilt" then
			local v517 = tick();
			while true do
				if sniperscope == nil then
					return;
				end;
				sniperscope.scopedFrame.crosshair.Rotation = lerp(sniperscope.scopedFrame.Rotation, -6, (tick() - v517) / 0.25);
				RS:wait();
				if not (0.25 <= tick() - v517) then

				else
					break;
				end;			
			end;
			local v518 = tick();
			while true do
				if sniperscope == nil then
					return;
				end;
				sniperscope.scopedFrame.crosshair.Rotation = lerp(sniperscope.scopedFrame.Rotation, 6, (tick() - v518) / 0.25);
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
				sniperscope.scopedFrame.crosshair.Rotation = lerp(sniperscope.scopedFrame.Rotation, 0, (tick() - v519) / 0.25);
				RS:wait();
				if not (0.25 <= tick() - v519) then

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
	local v520 = u10["Virus Stage 1"];
	if v520 == nil then
		v520 = u10["Virus Stage 2"];
	end;
	if v520 == nil then
		v520 = u10["Virus Stage 3"];
	end;
	if v520 == nil then
		v520 = u10["Virus Stage 4"];
	end;
	return v520;
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
		for v521, v522 in pairs(u10) do
			v522.effects.currentduration = 0;
		end;
	end);
	if u19 then
		u19:Destroy();
	end;
	for v523, v524 in pairs(v5) do
		v524[1] = "Fist";
		v524[3] = nil;
		if v524[2] == true then
			v524[1] = "LSMini";
			v524[3] = 200;
		end;
	end;
	l__workspace__1.ServerStuff.dealDamage:FireServer("putjugsuit", nil, v4);
	local l__speaker_music__525 = character:FindFirstChild("HumanoidRootPart"):WaitForChild("speaker_music");
	l__speaker_music__525.Volume = 0;
	local v526 = l__speaker_music__525:Clone();
	v526.SoundGroup = nil;
	v526.TimePosition = 0;
	v526.Volume = 2.5;
	v526.Parent = l__CurrentCamera__1;
	v526:Play();
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
	l__workspace__1.ServerStuff.initiateblock:FireServer(v4, false);
	u9.turnable = true;
	u45 = tick();
	u46 = 1;
	u25(0.025);
	local v527 = { globalanimsets.stagger, tpglobalanimsets.stagger };
	if p67 == "vomit" then
		v527 = { globalanimsets.stun, tpglobalanimsets.sick };
		l__workspace__1.ServerStuff.applyGore:FireServer("vomit", character, nil, nil);
		local u88 = nil;
		u88 = v527[1].KeyframeReached:connect(function(p68)
			if p68 == "Stop" then
				v527[1]:AdjustSpeed(0);
				u88:Disconnect();
			end;
		end);
		u9.turnable = false;
	end;
	v527[1]:Play(0.1);
	v527[2]:Play(0.1);
	u11 = 0.001;
	local v528 = Instance.new("BlurEffect");
	v528.Size = 15;
	if p67 == "normal" then
		shakecamera("stagger");
		v528.Parent = l__CurrentCamera__1;
	end;
	local v529 = false;
	u87 = false;
	while true do
		v528.Size = v528.Size - 0.5;
		if u87 == true then
			if v529 == false then
				v529 = true;
				if v527[2].TimePosition < v527[2].Length - 0.4 then
					v527[1].TimePosition = v527[1].Length - 0.4;
					v527[2].TimePosition = v527[2].Length - 0.4;
				end;
			end;
		end;
		RS:wait();
		if v527[1].IsPlaying ~= false then

		else
			break;
		end;
		if v527[2].IsPlaying ~= false then

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
	v528:Destroy();
	v527[1]:Stop(0.1);
	v527[2]:Stop();
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
	local v530 = l__game__7.ReplicatedStorage.effects.outlineFx:Clone();
	local v531 = v530:FindFirstChild(p69);
	local v532, v533, v534 = ipairs(v530:GetChildren());
	while true do
		local v535, v536 = v532(v533, v534);
		if v535 then

		else
			break;
		end;
		v534 = v535;
		if v536:IsA("BasePart") then
			local v537 = v531:Clone();
			v537.Enabled = true;
			v537.Parent = v536;
		elseif v536 ~= v531 then
			if not v536:IsA("Folder") then
				v536:Destroy();
			end;
		end;	
	end;
	v530.CFrame = l__CurrentCamera__1.CFrame;
	v530.Parent = l__CurrentCamera__1;
	local v538 = Instance.new("Motor6D");
	v538.Part0 = v530;
	v538.Part1 = cpart;
	v538.C1 = CFrame.new(0, 0, -0.4) * CFrame.Angles(0, 0, 0);
	v538.Parent = v530;
	if p70 then
		delay(p70, function()
			local v539, v540, v541 = ipairs(v530:GetDescendants());
			while true do
				local v542, v543 = v539(v540, v541);
				if v542 then

				else
					break;
				end;
				v541 = v542;
				if v543:IsA("ParticleEmitter") then
					v543.Enabled = false;
				end;			
			end;
			l__Debris__26:AddItem(v530, v531.Lifetime.Min + 0.5);
		end);
	end;
	return v530;
end;
if startperk.Value == "hiddenB" then
	local v544 = l__game__7.ReplicatedStorage.effects.wraithFX:Clone();
	v544.CFrame = l__CurrentCamera__1.CFrame;
	v544.Parent = l__CurrentCamera__1;
	local v545 = Instance.new("Motor6D");
	v545.Part0 = v544;
	v545.Part1 = cpart;
	v545.C1 = CFrame.new(0, 0, -0.4) * CFrame.Angles(0, 0, 0);
	v545.Parent = v544;
end;
local u89 = 1;
local u90 = v183;
local function u91(p71)
	maingui.infectionalert.TextTransparency = 1;
	maingui.infectionalert.TextStrokeTransparency = maingui.infectionalert.TextTransparency;
	maingui.infectionalert.Text = "";
	local u92 = "Systemic Infection has reached Stage " .. p71 .. ".";
	spawn(function()
		local v546 = tick();
		local v547 = 0;
		local v548 = tick();
		while true do
			maingui.infectionalert.TextTransparency = 1 - (tick() - v546) / 2;
			maingui.infectionalert.TextStrokeTransparency = maingui.infectionalert.TextTransparency;
			if tick() - v548 > 0.1 then
				v548 = tick();
				v547 = v547 + 1;
				maingui.infectionalert.Text = string.sub(u92, 1, v547);
				if string.len(u92) <= v547 then
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
		local v549 = tick();
		while true do
			RS:wait();
			if tick() - v549 >= 2 then
				break;
			end;		
		end;
		local v550 = tick();
		while true do
			maingui.infectionalert.TextTransparency = (tick() - v550) / 2;
			maingui.infectionalert.TextStrokeTransparency = maingui.infectionalert.TextTransparency;
			RS:wait();
			if tick() - v550 >= 2 then
				break;
			end;		
		end;
		maingui.infectionalert.TextTransparency = 1;
		maingui.infectionalert.TextStrokeTransparency = maingui.infectionalert.TextTransparency;
	end);
end;
local function u93()
	for v551, v552 in ipairs(maingui.HealthFrame.Statuses:GetChildren()) do
		if v552.Name ~= "Example" then
			v552.Position = UDim2.new(v551 - 0.7 + 0.1 * v551 - 2, 0, 0.5, 0);
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
		local v553 = {
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
		local v554, v555, v556 = pairs(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS));
		while true do
			local v557, v558 = v554(v555, v556);
			if v557 then

			else
				break;
			end;
			v556 = v557;
			if v558.name == p72.name then
				v553.effects.corename = v557;
				break;
			end;		
		end;
		v553.mainstats = p72;
		v553.effects.maxduration = v553.mainstats.dur;
		v553.effects.currentduration = tick();
		if p72.colour ~= nil then
			v553.effects.colour = p72.colour;
		end;
		local v559 = maingui.HealthFrame.Statuses.Example:Clone();
		v553.effects.currentgui = v559;
		v559.Name = v553.mainstats.name;
		local v560 = 0;
		v559.Icon.Image = "rbxassetid://" .. v553.mainstats.icon;
		v559.Visible = true;
		if v553.mainstats.name ~= "Death Morale 1" then
			if v553.mainstats.name ~= "Death Morale 2" then
				if v553.mainstats.name ~= "Death Morale 3" then
					if v553.mainstats.name ~= "Death Morale 4" then
						if v553.mainstats.name ~= "Arterial Bleed" then
							if v553.mainstats.name ~= "Toxins" then
								if v553.mainstats.name == "Artillerist Buff" then
									v559.EmptyBar.Visible = false;
									v559.textinsteadofbar.Visible = true;
									v559.textinsteadofbar.Text = "MORALE";
									if v553.mainstats.name == "Arterial Bleed" then
										v559.textinsteadofbar.Text = "ARTERY";
									elseif v553.mainstats.name == "Toxins" then
										v559.textinsteadofbar.Text = "TOXINS";
									elseif v553.mainstats.name == "Artillerist Buff" then
										v559.textinsteadofbar.Text = "DEADEYE";
									end;
								end;
							else
								v559.EmptyBar.Visible = false;
								v559.textinsteadofbar.Visible = true;
								v559.textinsteadofbar.Text = "MORALE";
								if v553.mainstats.name == "Arterial Bleed" then
									v559.textinsteadofbar.Text = "ARTERY";
								elseif v553.mainstats.name == "Toxins" then
									v559.textinsteadofbar.Text = "TOXINS";
								elseif v553.mainstats.name == "Artillerist Buff" then
									v559.textinsteadofbar.Text = "DEADEYE";
								end;
							end;
						else
							v559.EmptyBar.Visible = false;
							v559.textinsteadofbar.Visible = true;
							v559.textinsteadofbar.Text = "MORALE";
							if v553.mainstats.name == "Arterial Bleed" then
								v559.textinsteadofbar.Text = "ARTERY";
							elseif v553.mainstats.name == "Toxins" then
								v559.textinsteadofbar.Text = "TOXINS";
							elseif v553.mainstats.name == "Artillerist Buff" then
								v559.textinsteadofbar.Text = "DEADEYE";
							end;
						end;
					else
						v559.EmptyBar.Visible = false;
						v559.textinsteadofbar.Visible = true;
						v559.textinsteadofbar.Text = "MORALE";
						if v553.mainstats.name == "Arterial Bleed" then
							v559.textinsteadofbar.Text = "ARTERY";
						elseif v553.mainstats.name == "Toxins" then
							v559.textinsteadofbar.Text = "TOXINS";
						elseif v553.mainstats.name == "Artillerist Buff" then
							v559.textinsteadofbar.Text = "DEADEYE";
						end;
					end;
				else
					v559.EmptyBar.Visible = false;
					v559.textinsteadofbar.Visible = true;
					v559.textinsteadofbar.Text = "MORALE";
					if v553.mainstats.name == "Arterial Bleed" then
						v559.textinsteadofbar.Text = "ARTERY";
					elseif v553.mainstats.name == "Toxins" then
						v559.textinsteadofbar.Text = "TOXINS";
					elseif v553.mainstats.name == "Artillerist Buff" then
						v559.textinsteadofbar.Text = "DEADEYE";
					end;
				end;
			else
				v559.EmptyBar.Visible = false;
				v559.textinsteadofbar.Visible = true;
				v559.textinsteadofbar.Text = "MORALE";
				if v553.mainstats.name == "Arterial Bleed" then
					v559.textinsteadofbar.Text = "ARTERY";
				elseif v553.mainstats.name == "Toxins" then
					v559.textinsteadofbar.Text = "TOXINS";
				elseif v553.mainstats.name == "Artillerist Buff" then
					v559.textinsteadofbar.Text = "DEADEYE";
				end;
			end;
		else
			v559.EmptyBar.Visible = false;
			v559.textinsteadofbar.Visible = true;
			v559.textinsteadofbar.Text = "MORALE";
			if v553.mainstats.name == "Arterial Bleed" then
				v559.textinsteadofbar.Text = "ARTERY";
			elseif v553.mainstats.name == "Toxins" then
				v559.textinsteadofbar.Text = "TOXINS";
			elseif v553.mainstats.name == "Artillerist Buff" then
				v559.textinsteadofbar.Text = "DEADEYE";
			end;
		end;
		if v553.effects.colour ~= false then
			v559.EmptyBar.Bar.BackgroundColor3 = v553.effects.colour;
			v559.Icon.ImageColor3 = v553.effects.colour;
			v559.textinsteadofbar.TextColor3 = v553.effects.colour;
		end;
		v559.Parent = maingui.HealthFrame.Statuses;
		local v561, v562, v563 = pairs(u10);
		while true do
			local v564, v565 = v561(v562, v563);
			if v564 then

			else
				break;
			end;
			v563 = v564;
			v560 = v560 + 1;		
		end;
		v553.effects.currentpos = v560;
		if v553.mainstats.name ~= "Bleed" then
			if v553.mainstats.name ~= "Regeneration" then
				if v553.mainstats.name ~= "Arterial Bleed" then
					if v553.mainstats.name == "Fracture" then
						v553.effects.ticks[1] = 0;
					elseif v553.mainstats.name == "Vomit" then
						spawn(function()
							stagger("vomit");
						end);
					elseif v553.mainstats.name == "Blindness" then
						local v566 = l__game__7.ReplicatedStorage.effects.blackscreen:Clone();
						v566.Parent = maingui;
						v553.effects.ticks[1] = v566;
					elseif v553.mainstats.name ~= "Sickness" then
						if v553.mainstats.name == "Toxins" then
							if v553.mainstats.name == "Toxins" then
								local v567 = l__game__7.ReplicatedStorage.effects.sickcc:Clone();
							else
								v567 = l__game__7.ReplicatedStorage.effects.punjicc:Clone();
							end;
							v567.Parent = l__CurrentCamera__1;
							local v568 = Instance.new("BlurEffect");
							v568.Size = 0;
							v568.Parent = l__CurrentCamera__1;
							v553.effects.ticks[1] = { v567, v568, tick() };
							if v553.mainstats.name == "Sickness" then
								spawn(function()
									createfxoutline("sickParticle", v553.mainstats.dur);
								end);
							end;
							if v553.mainstats.name == "Toxins" then
								agent_speak("stormenter");
								local v569 = l__game__7.ReplicatedStorage.effects.stormfx_overlay:Clone();
								v569.CFrame = l__CurrentCamera__1.CFrame;
								v569.Parent = l__CurrentCamera__1;
								local v570 = Instance.new("Motor6D");
								v570.Part0 = v569;
								v570.Part1 = cpart;
								v570.C1 = CFrame.new(0, 0, -0.4) * CFrame.Angles(0, 0, 0);
								v570.Parent = v569;
								v553.effects.ticks[2] = v569;
							end;
						elseif v553.mainstats.name == "Tinnitus" then
							shakecamera("tinnitus");
							l__game__7:GetService("SoundService").regular.Volume = 0.3;
							local v571 = Instance.new("BlurEffect");
							v571.Size = 0;
							v571.Parent = l__CurrentCamera__1;
							local v572 = l__game__7.ReplicatedStorage.soundLibrary.general.earringing:Clone();
							v572.Looped = true;
							v572.Parent = l__CurrentCamera__1;
							v572:Play();
							v553.effects.ticks[1] = { v572, v571 };
						elseif v553.mainstats.name == "Berserk" then
							local v573 = l__game__7.ReplicatedStorage.effects.ragecc:Clone();
							v573.Parent = l__CurrentCamera__1;
							v553.effects.ticks[1] = { v573, v100({ "general" }, "doom", nil, nil, nil, true) };
							if playerstats.Settings.MuteMusic == true then
								v553.effects.ticks[1][2].Volume = 0;
							end;
						elseif v553.mainstats.name == "Snared" then
							local v574 = l__game__7.ReplicatedStorage.effects.snare:Clone();
							v574.Parent = maingui;
							u11 = 0.001;
							u9.turnable = false;
							v553.effects.ticks[1] = v574;
						elseif v553.mainstats.name == "Tracking Beacon" then
							v553.effects.ticks[1] = tick();
						elseif v553.mainstats.name ~= "Damage Buff" then
							if v553.mainstats.name == "Unwaivered" then
								u21 = u21 + v553.mainstats.ints[1] / 100;
								u58 = u58 + 1.2;
							elseif v553.mainstats.name == "Artillerist Buff" then
								u65 = u65 + v553.mainstats.ints[2] / 100;
								u73 = u73 + v553.mainstats.ints[1] / 100;
							elseif v553.mainstats.name == "Defense Buff" then
								u20 = u20 + v553.mainstats.ints[1] / 100;
							elseif v553.mainstats.name == "Susceptible" then
								u20 = u20 - v553.mainstats.ints[1] / 100;
							elseif v553.mainstats.name == "Armoured" then
								u20 = u20 + v553.mainstats.ints[1];
							elseif v553.mainstats.name ~= "Speed Buff" then
								if v553.mainstats.name == "Silencer" then
									v553.effects.ticks[1] = u13 * v553.mainstats.ints[1] / 100;
									u22 = u22 + v553.effects.ticks[1];
									u47 = u47 + 1;
									u51 = u51 + 1;
									u65 = u65 + 1.5;
								elseif v553.mainstats.name == "Exhausted" then
									u21 = u21 - v553.mainstats.ints[1];
								elseif v553.mainstats.name == "Respirator" then
									local v575 = l__game__7.ReplicatedStorage.misc.respOverlay:Clone();
									v575.Parent = maingui;
									v553.effects.ticks[1] = v575;
								elseif v553.mainstats.name == "Koldera Buff" then
									local v576 = l__game__7.ReplicatedStorage.auxItems.buffermodel:Clone();
									v576.CFrame = l__CurrentCamera__1.CFrame;
									v576.Parent = l__CurrentCamera__1;
									local v577 = Instance.new("Motor6D");
									v577.Part0 = v576;
									v577.Part1 = cpart;
									v577.C1 = CFrame.new(0, -0.8, -0.7) * CFrame.Angles(0, math.rad(90), 0);
									v577.Parent = v576;
									v553.effects.ticks[1] = v576;
									u21 = u21 + 0.1;
									u20 = u20 + 0.1;
									v553.effects.ticks[4] = u13 * 10 / 100;
									u22 = u22 + v553.effects.ticks[4];
									if not u10["Death Morale 1"] then
										if u10["Death Morale 2"] then
											u21 = u21 + 0.1;
											u20 = u20 + 0.1;
											v553.effects.ticks[3] = u13 * 10 / 100;
											u22 = u22 + v553.effects.ticks[3];
											v553.effects.ticks[2] = true;
										end;
									else
										u21 = u21 + 0.1;
										u20 = u20 + 0.1;
										v553.effects.ticks[3] = u13 * 10 / 100;
										u22 = u22 + v553.effects.ticks[3];
										v553.effects.ticks[2] = true;
									end;
									l__workspace__1.ServerStuff.quickDisplay:FireServer("add_buffer");
								elseif v553.mainstats.name == "Painkillers" then
									local v578 = l__game__7.ReplicatedStorage.effects.painkillers:Clone();
									v578.Parent = maingui;
									local v579 = l__game__7.ReplicatedStorage.misc.painkillersCC:Clone();
									v579.Parent = l__CurrentCamera__1;
									v553.effects.ticks[1] = v578;
									v553.effects.ticks[2] = v579;
									u20 = u20 + v553.mainstats.ints[1] / 100;
									maingui.HurtOverlay.Visible = false;
									maingui.HurtOverlayA.Visible = false;
									maingui.HurtOverlayB.Visible = false;
								elseif v553.mainstats.name == "Burning" then
									l__workspace__1.ServerStuff.playAudio:FireServer({ "status_fx" }, "burst", character.HumanoidRootPart);
									local v580 = l__game__7.ReplicatedStorage.effects.burnfx:Clone();
									v580.CFrame = l__CurrentCamera__1.CFrame;
									v580.Parent = l__CurrentCamera__1;
									local v581 = Instance.new("Motor6D");
									v581.Part0 = v580;
									v581.Part1 = cpart;
									v581.C1 = CFrame.new(0, 0, -0.6) * CFrame.Angles(0, 0, 0);
									v581.Parent = v580;
									local v582 = l__game__7.ReplicatedStorage.effects.fireCC:Clone();
									v582.Parent = l__CurrentCamera__1;
									v553.effects.ticks[1] = 0;
									v553.effects.ticks[2] = v580;
									v553.effects.ticks[3] = v582;
								elseif v553.mainstats.name == "Lazarus" then
									v100({ "perks" }, "laz_effect", nil, nil, true, true);
									local v583 = l__game__7.ReplicatedStorage.effects.lazarmfx:Clone();
									v583.Parent = fparms.RightArm.RLowerArm;
									local v584 = Instance.new("Weld");
									v584.Part0 = fparms.RightArm.RLowerArm;
									v584.Part1 = v583;
									v584.Parent = v583;
									local v585 = l__game__7.ReplicatedStorage.effects.lazarmfx:Clone();
									v585.Parent = fparms.RightArm.RUpperArm;
									local v586 = Instance.new("Weld");
									v586.Part0 = fparms.RightArm.RUpperArm;
									v586.Part1 = v585;
									v586.Parent = v585;
									local v587 = l__game__7.ReplicatedStorage.effects.lazarmfx:Clone();
									v587.Parent = fparms.LeftArm.LLowerArm;
									local v588 = Instance.new("Weld");
									v588.Part0 = fparms.LeftArm.LLowerArm;
									v588.Part1 = v587;
									v588.Parent = v587;
									local v589 = l__game__7.ReplicatedStorage.effects.lazarmfx:Clone();
									v589.Parent = fparms.LeftArm.LUpperArm;
									local v590 = Instance.new("Weld");
									v590.Part0 = fparms.LeftArm.LUpperArm;
									v590.Part1 = v589;
									v590.Parent = v589;
									v553.effects.ticks[1] = v583;
									v553.effects.ticks[2] = v585;
									v553.effects.ticks[3] = v587;
									v553.effects.ticks[4] = v589;
									v553.effects.ticks[5] = v100({ "perks" }, "laz_loop", nil, nil, nil, true);
									u21 = u21 + v553.mainstats.ints[1] / 100;
								elseif v553.mainstats.name == "Immolator Buff" then
									local v591 = l__game__7.ReplicatedStorage.effects.burnarm_fx:Clone();
									v591.Parent = fparms.RightArm.RLowerArm;
									local v592 = Instance.new("Weld");
									v592.Part0 = fparms.RightArm.RLowerArm;
									v592.Part1 = v591;
									v592.Parent = v591;
									local v593 = l__game__7.ReplicatedStorage.effects.burnarm_fx:Clone();
									v593.Parent = fparms.RightArm.RUpperArm;
									local v594 = Instance.new("Weld");
									v594.Part0 = fparms.RightArm.RUpperArm;
									v594.Part1 = v593;
									v594.Parent = v593;
									local v595 = l__game__7.ReplicatedStorage.effects.burnarm_fx:Clone();
									v595.Parent = fparms.LeftArm.LLowerArm;
									local v596 = Instance.new("Weld");
									v596.Part0 = fparms.LeftArm.LLowerArm;
									v596.Part1 = v595;
									v596.Parent = v595;
									local v597 = l__game__7.ReplicatedStorage.effects.burnarm_fx:Clone();
									v597.Parent = fparms.LeftArm.LUpperArm;
									local v598 = Instance.new("Weld");
									v598.Part0 = fparms.LeftArm.LUpperArm;
									v598.Part1 = v597;
									v598.Parent = v597;
									v553.effects.ticks[1] = v591;
									v553.effects.ticks[2] = v593;
									v553.effects.ticks[3] = v595;
									v553.effects.ticks[4] = v597;
								end;
							else
								v553.effects.ticks[1] = u13 * v553.mainstats.ints[1] / 100;
								u22 = u22 + v553.effects.ticks[1];
								u47 = u47 + 1;
								u51 = u51 + 1;
								u65 = u65 + 1.5;
							end;
						else
							u21 = u21 + v553.mainstats.ints[1] / 100;
							u58 = u58 + 1.2;
						end;
					else
						if v553.mainstats.name == "Toxins" then
							v567 = l__game__7.ReplicatedStorage.effects.sickcc:Clone();
						else
							v567 = l__game__7.ReplicatedStorage.effects.punjicc:Clone();
						end;
						v567.Parent = l__CurrentCamera__1;
						v568 = Instance.new("BlurEffect");
						v568.Size = 0;
						v568.Parent = l__CurrentCamera__1;
						v553.effects.ticks[1] = { v567, v568, tick() };
						if v553.mainstats.name == "Sickness" then
							spawn(function()
								createfxoutline("sickParticle", v553.mainstats.dur);
							end);
						end;
						if v553.mainstats.name == "Toxins" then
							agent_speak("stormenter");
							v569 = l__game__7.ReplicatedStorage.effects.stormfx_overlay:Clone();
							v569.CFrame = l__CurrentCamera__1.CFrame;
							v569.Parent = l__CurrentCamera__1;
							v570 = Instance.new("Motor6D");
							v570.Part0 = v569;
							v570.Part1 = cpart;
							v570.C1 = CFrame.new(0, 0, -0.4) * CFrame.Angles(0, 0, 0);
							v570.Parent = v569;
							v553.effects.ticks[2] = v569;
						end;
					end;
				else
					v553.effects.ticks[1] = 0;
				end;
			else
				v553.effects.ticks[1] = 0;
			end;
		else
			v553.effects.ticks[1] = 0;
		end;
		if v553.mainstats.name ~= "Virus Stage 2" then
			if v553.mainstats.name ~= "Virus Stage 3" then
				if v553.mainstats.name == "Virus Stage 4" then
					v553.effects.ticks[1] = u13 * v553.mainstats.ints[1] / 100;
					u22 = u22 - v553.effects.ticks[1];
					if v553.mainstats.name ~= "Virus Stage 2" then
						u20 = u20 - v553.mainstats.ints[2] / 100;
					end;
					l__workspace__1.ServerStuff.dealDamage:FireServer("virusmaxhealth", v553.mainstats.name, v4);
					if v553.mainstats.name == "Virus Stage 4" then
						v553.effects.ticks[2] = tick();
					end;
				end;
			else
				v553.effects.ticks[1] = u13 * v553.mainstats.ints[1] / 100;
				u22 = u22 - v553.effects.ticks[1];
				if v553.mainstats.name ~= "Virus Stage 2" then
					u20 = u20 - v553.mainstats.ints[2] / 100;
				end;
				l__workspace__1.ServerStuff.dealDamage:FireServer("virusmaxhealth", v553.mainstats.name, v4);
				if v553.mainstats.name == "Virus Stage 4" then
					v553.effects.ticks[2] = tick();
				end;
			end;
		else
			v553.effects.ticks[1] = u13 * v553.mainstats.ints[1] / 100;
			u22 = u22 - v553.effects.ticks[1];
			if v553.mainstats.name ~= "Virus Stage 2" then
				u20 = u20 - v553.mainstats.ints[2] / 100;
			end;
			l__workspace__1.ServerStuff.dealDamage:FireServer("virusmaxhealth", v553.mainstats.name, v4);
			if v553.mainstats.name == "Virus Stage 4" then
				v553.effects.ticks[2] = tick();
			end;
		end;
		if v553.mainstats.name ~= "Death Morale 1" then
			if v553.mainstats.name ~= "Death Morale 2" then
				if v553.mainstats.name ~= "Death Morale 3" then
					if v553.mainstats.name == "Death Morale 4" then
						u21 = u21 - v553.mainstats.ints[1] / 100;
						u20 = u20 - v553.mainstats.ints[2] / 100;
						u22 = u22 - u13 * v553.mainstats.ints[3] / 100;
						local v599 = l__game__7.ReplicatedStorage.effects.moralevignette:Clone();
						v599.Parent = maingui;
						v553.effects.ticks[1] = v599;
					end;
				else
					u21 = u21 - v553.mainstats.ints[1] / 100;
					u20 = u20 - v553.mainstats.ints[2] / 100;
					u22 = u22 - u13 * v553.mainstats.ints[3] / 100;
					v599 = l__game__7.ReplicatedStorage.effects.moralevignette:Clone();
					v599.Parent = maingui;
					v553.effects.ticks[1] = v599;
				end;
			else
				u21 = u21 - v553.mainstats.ints[1] / 100;
				u20 = u20 - v553.mainstats.ints[2] / 100;
				u22 = u22 - u13 * v553.mainstats.ints[3] / 100;
				v599 = l__game__7.ReplicatedStorage.effects.moralevignette:Clone();
				v599.Parent = maingui;
				v553.effects.ticks[1] = v599;
			end;
		else
			u21 = u21 - v553.mainstats.ints[1] / 100;
			u20 = u20 - v553.mainstats.ints[2] / 100;
			u22 = u22 - u13 * v553.mainstats.ints[3] / 100;
			v599 = l__game__7.ReplicatedStorage.effects.moralevignette:Clone();
			v599.Parent = maingui;
			v553.effects.ticks[1] = v599;
		end;
		v553.effects.currentloop = RS:connect(function()
			if v553.mainstats.name == "Cripple" then
				u89 = 1 - 1 * v553.mainstats.ints[v553.mainstats.intensity] / 100;
			elseif v553.mainstats.name == "Bleed" then
				if v553.mainstats.ints[v553.mainstats.intensity] < tick() - v553.effects.ticks[1] then
					if l__workspace__1.ServerStuff.game.disableInteraction.Value == false then
						if 1 < hum.Health then
							v553.effects.ticks[1] = tick();
							l__workspace__1.ServerStuff.dealDamage:FireServer("bleed", nil, v4);
							l__workspace__1.ServerStuff.applyGore:FireServer("bleed", character, nil, { 1, nil });
						end;
					end;
				end;
			elseif v553.mainstats.name == "Fracture" then
				if 0.1 < tick() - v553.effects.ticks[1] then
					v553.effects.ticks[1] = tick();
					u90 = CFrame.new(math.random(-10, 10) / 1000, math.random(-10, 10) / 1000, math.random(-10, 10) / 1000);
				end;
			elseif v553.mainstats.name == "Speed Buff" then
				sprint_stam = 100;
				if u10.Exhaustion then
					u10.Exhaustion.effects.currentduration = 0;
				end;
			elseif v553.mainstats.name == "Exhaustion" then
				if u10["Speed Buff"] == nil then
					sprint_stam = 0;
				end;
			elseif v553.mainstats.name == "Arterial Bleed" then
				if v553.mainstats.ints[1] < tick() - v553.effects.ticks[1] then
					if l__workspace__1.ServerStuff.game.disableInteraction.Value == false then
						v553.effects.ticks[1] = tick();
						l__workspace__1.ServerStuff.dealDamage:FireServer("bleed", nil, v4);
						l__workspace__1.ServerStuff.applyGore:FireServer("bleed", character, nil, { 1, nil });
						local v600 = l__game__7.ReplicatedStorage.effects.blood_drop:Clone();
						v600.Position = UDim2.new(math.random(15, 95) / 100, 0, math.random(15, 95) / 100, 0);
						v600.Rotation = math.random(0, 360);
						v600.Parent = maingui;
						spawn(function()
							while true do
								v600.ImageTransparency = v600.ImageTransparency + 0.01;
								RS:wait();
								if not (1 <= v600.ImageTransparency) then

								else
									break;
								end;							
							end;
							v600:Destroy();
						end);
					end;
				end;
				if u10["Bleed Prevention"] == nil then
					local l__Bld__601 = require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Bld;
					l__Bld__601.intensity = 4;
					afflictstatus(l__Bld__601);
				end;
			elseif v553.mainstats.name == "Burning" then
				if u10["Immolator Buff"] == nil then
					if v56 == false then
						u14.regentick = tick();
						if v553.mainstats.ints[1] < tick() - v553.effects.ticks[1] then
							v553.effects.ticks[1] = tick();
							l__workspace__1.ServerStuff.dealDamage:FireServer("burning", nil, v4);
						end;
					end;
				end;
			elseif v553.mainstats.name == "Immolator Buff" then
				afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Brn);
				if u10.Burning then
					u10.Burning.effects.ticks[1] = tick();
				end;
			elseif v553.mainstats.name == "Lazarus" then
				afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Pnk);
			elseif v553.mainstats.name == "Toxins" then
				if v553.mainstats.ints[2] < tick() - v553.effects.ticks[1][3] then
					if 0 < hum.Health then
						v553.effects.ticks[1][3] = tick();
						if u10.Respirator == nil then
							l__workspace__1.ServerStuff.dealDamage:FireServer("toxicated", nil, v4);
						end;
					end;
				end;
			elseif v553.mainstats.name == "Regeneration" then
				if 1 < tick() - v553.effects.ticks[1] then
					if hum.Health < hum.MaxHealth then
						v553.effects.ticks[1] = tick();
						if u10.Toxins == nil then
							l__workspace__1.ServerStuff.dealDamage:FireServer(v553.mainstats.name, nil, v4);
						end;
					end;
				end;
			elseif v553.mainstats.name == "Stamina Buff" then
				if 0.5 < tick() - u14.stamregen then
					u8 = v61;
					u26("stamina");
				end;
			elseif v553.mainstats.name == "Tracking Beacon" then
				if u9.walking == false then
					if v553.mainstats.ints[1] <= tick() - v553.effects.ticks[1] then
						v553.effects.currentduration = 0;
					end;
				else
					v553.effects.ticks[1] = tick();
				end;
			elseif v553.mainstats.name == "Blindness" then
				v553.effects.ticks[1].BackgroundTransparency = (tick() - v553.effects.currentduration) / 2 / v553.effects.maxduration;
			elseif v553.mainstats.name == "Bleed Prevention" then
				if u10.Bleed then
					u10.Bleed.effects.currentduration = 0;
				end;
			elseif v553.mainstats.name == "Cripple Prevention" then
				if u10.Cripple then
					u10.Cripple.effects.currentduration = 0;
				end;
				if u10.Fracture then
					u10.Fracture.effects.currentduration = 0;
				end;
			elseif v553.mainstats.name == "Virus Stage 4" then
				if v553.mainstats.ints[4] <= tick() - v553.effects.ticks[2] then
					v553.effects.ticks[2] = tick();
					afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Tnt);
				end;
			elseif v553.mainstats.name == "Painkillers" then
				v553.effects.ticks[1].ImageTransparency = v553.effects.ticks[1].ImageTransparency + (math.cos(time() * 2) * 0.5 - v553.effects.ticks[1].ImageTransparency) * 0.025 + 0.1;
			elseif v553.mainstats.name ~= "Sickness" then
				if v553.mainstats.name ~= "Toxins" then
					if v553.mainstats.name == "Tinnitus" then
						v553.effects.ticks[1][2].Size = math.sin(time() * 3) * 5 + 8;
					elseif v553.mainstats.name == "Silencer" then
						if u10.Cripple then
							u10.Cripple.effects.currentduration = 0;
						end;
						if u10.Bleed then
							u10.Bleed.effects.currentduration = 0;
						end;
					end;
				else
					v553.effects.ticks[1][2].Size = math.sin(time() * 3) * 5 + 8;
				end;
			else
				v553.effects.ticks[1][2].Size = math.sin(time() * 3) * 5 + 8;
			end;
			v553.effects.currentgui.EmptyBar.Bar.Size = UDim2.new((v553.effects.maxduration - (tick() - v553.effects.currentduration)) / v553.effects.maxduration, 0, 1, 0);
			if v553.effects.maxduration < tick() - v553.effects.currentduration then
				v553.effects.currentloop:Disconnect();
				v553.effects.currentgui:Destroy();
				if v553.mainstats.name == "Cripple" then
					u89 = 1;
				end;
				if v553.mainstats.name ~= "Damage Buff" then
					if v553.mainstats.name == "Unwaivered" then
						u21 = u21 - v553.mainstats.ints[1] / 100;
						afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Tnt);
						u58 = u58 - 1.2;
					elseif v553.mainstats.name == "Defense Buff" then
						u20 = u20 - v553.mainstats.ints[1] / 100;
						afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Tnt);
					elseif v553.mainstats.name == "Susceptible" then
						u20 = u20 + v553.mainstats.ints[1] / 100;
					elseif v553.mainstats.name == "Armoured" then
						u20 = u20 - v553.mainstats.ints[1];
						l__workspace__1.ServerStuff.dealDamage:FireServer("removearmour", nil, v4);
					elseif v553.mainstats.name ~= "Speed Buff" then
						if v553.mainstats.name == "Silencer" then
							u22 = u22 - v553.effects.ticks[1];
							afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Tnt);
							u47 = u47 - 1;
							u51 = u51 - 1;
							u65 = u65 - 1.5;
						elseif v553.mainstats.name ~= "Death Morale 1" then
							if v553.mainstats.name ~= "Death Morale 2" then
								if v553.mainstats.name ~= "Death Morale 3" then
									if v553.mainstats.name == "Death Morale 4" then
										u21 = u21 + v553.mainstats.ints[1] / 100;
										u20 = u20 + v553.mainstats.ints[2] / 100;
										u22 = u22 + u13 * v553.mainstats.ints[3] / 100;
										v553.effects.ticks[1]:Destroy();
									elseif v553.mainstats.name == "Stamina Buff" then
										afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Tnt);
									elseif v553.mainstats.name == "Respirator" then
										tpglobalanimsets.aux_resp_off:Play(0.1);
										v100({ "aux" }, "resp_remove", nil, nil, true, true);
										v553.effects.ticks[1]:Destroy();
										globalanimsets.aux_resp_remove:Play(0.1, 1, 1);
									elseif v553.mainstats.name == "Koldera Buff" then
										l__workspace__1.ServerStuff.quickDisplay:FireServer("remove_buffer");
										tpglobalanimsets.aux_resp_off:Play(0.1);
										v553.effects.ticks[1]:Destroy();
										globalanimsets.aux_resp_remove:Play(0.1, 1, 1);
										u21 = u21 - 0.1;
										u20 = u20 - 0.1;
										u22 = u22 - v553.effects.ticks[4];
										if v553.effects.ticks[2] == true then
											u21 = u21 - 0.1;
											u20 = u20 - 0.1;
											u22 = u22 - v553.effects.ticks[3];
										end;
									elseif v553.mainstats.name == "Burning" then
										l__workspace__1.ServerStuff.playAudio:FireServer({ "status_fx" }, "extinguish", character.HumanoidRootPart);
										l__workspace__1.ServerStuff.dealDamage:FireServer("burningstop", nil, v4);
										if v553.effects.ticks[2] then
											if v553.effects.ticks[2]:FindFirstChild("outline1") then
												l__Debris__26:AddItem(v553.effects.ticks[2], 5);
												local v602, v603, v604 = ipairs(v553.effects.ticks[2].outline1:GetChildren());
												while true do
													local v605, v606 = v602(v603, v604);
													if v605 then

													else
														break;
													end;
													v604 = v605;
													v606.Enabled = false;												
												end;
											end;
										end;
										v553.effects.ticks[3]:Destroy();
									elseif v553.mainstats.name == "Blindness" then
										v553.effects.ticks[1]:Destroy();
									elseif v553.mainstats.name == "Exhausted" then
										u21 = u21 + v553.mainstats.ints[1];
									elseif v553.mainstats.name == "Exhaustion" then
										sprint_stam = 10;
									elseif v553.mainstats.name == "Artillerist Buff" then
										u65 = u65 - v553.mainstats.ints[2] / 100;
										u73 = u73 - v553.mainstats.ints[1] / 100;
									elseif v553.mainstats.name ~= "Sickness" then
										if v553.mainstats.name == "Toxins" then
											v553.effects.ticks[1][1]:Destroy();
											v553.effects.ticks[1][2]:Destroy();
											if v553.mainstats.name == "Sickness" then
												afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Vcd);
											else
												v553.effects.ticks[2]:Destroy();
												agent_speak("stormleave");
											end;
										elseif v553.mainstats.name ~= "Berserk" then
											if v553.mainstats.name == "Tinnitus" then
												v553.effects.ticks[1][1]:Destroy();
												v553.effects.ticks[1][2]:Destroy();
												l__game__7:GetService("SoundService").regular.Volume = 1;
											elseif v553.mainstats.name == "Tracking Beacon" then
												l__workspace__1.ServerStuff.dealDamage:FireServer("removealarm", nil, v4);
											elseif v553.mainstats.name == "Showdown" then
												if u36.nowinshowdown == true then
													l__workspace__1.ServerStuff.callEvent:FireServer();
												end;
											elseif v553.mainstats.name == "Fracture" then
												u90 = CFrame.new(0, 0, 0);
											elseif v553.mainstats.name == "Painkillers" then
												v553.effects.ticks[1]:Destroy();
												v553.effects.ticks[2]:Destroy();
												maingui.HurtOverlay.Visible = true;
												maingui.HurtOverlayA.Visible = true;
												maingui.HurtOverlayB.Visible = true;
												v100({ "weapons", "Item" }, "adrenal", nil, nil, true, true);
												u20 = u20 - v553.mainstats.ints[1] / 100;
											elseif v553.mainstats.name == "Lazarus" then
												v553.effects.ticks[1]:Destroy();
												v553.effects.ticks[2]:Destroy();
												v553.effects.ticks[3]:Destroy();
												v553.effects.ticks[4]:Destroy();
												v553.effects.ticks[5]:Destroy();
												u21 = u21 - v553.mainstats.ints[1] / 100;
												if u10.Painkillers then
													u10.Painkillers.effects.currentduration = 0;
												end;
											elseif v553.mainstats.name == "Immolator Buff" then
												if u10.Burning then
													u10.Burning.effects.currentduration = 0;
												end;
												v553.effects.ticks[1]:Destroy();
												v553.effects.ticks[2]:Destroy();
												v553.effects.ticks[3]:Destroy();
												v553.effects.ticks[4]:Destroy();
											elseif v553.mainstats.name == "Snared" then
												if u9.staggering == false then
													if u9.channel == false then
														if sprint_stam <= 0 then
															u11 = u12;
														else
															u11 = u13;
														end;
														u9.turnable = true;
														v553.effects.ticks[1]:Destroy();
													end;
												end;
											end;
										else
											v553.effects.ticks[1][1]:Destroy();
											v553.effects.ticks[1][2]:Destroy();
											l__game__7:GetService("SoundService").regular.Volume = 1;
										end;
									else
										v553.effects.ticks[1][1]:Destroy();
										v553.effects.ticks[1][2]:Destroy();
										if v553.mainstats.name == "Sickness" then
											afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Vcd);
										else
											v553.effects.ticks[2]:Destroy();
											agent_speak("stormleave");
										end;
									end;
								else
									u21 = u21 + v553.mainstats.ints[1] / 100;
									u20 = u20 + v553.mainstats.ints[2] / 100;
									u22 = u22 + u13 * v553.mainstats.ints[3] / 100;
									v553.effects.ticks[1]:Destroy();
								end;
							else
								u21 = u21 + v553.mainstats.ints[1] / 100;
								u20 = u20 + v553.mainstats.ints[2] / 100;
								u22 = u22 + u13 * v553.mainstats.ints[3] / 100;
								v553.effects.ticks[1]:Destroy();
							end;
						else
							u21 = u21 + v553.mainstats.ints[1] / 100;
							u20 = u20 + v553.mainstats.ints[2] / 100;
							u22 = u22 + u13 * v553.mainstats.ints[3] / 100;
							v553.effects.ticks[1]:Destroy();
						end;
					else
						u22 = u22 - v553.effects.ticks[1];
						afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Tnt);
						u47 = u47 - 1;
						u51 = u51 - 1;
						u65 = u65 - 1.5;
					end;
				else
					u21 = u21 - v553.mainstats.ints[1] / 100;
					afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Tnt);
					u58 = u58 - 1.2;
				end;
				if v553.mainstats.name == "Virus Stage 1" then
					afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).VirusB);
					u91(2);
				elseif v553.mainstats.name == "Virus Stage 2" then
					afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).VirusC);
					u91(3);
					u22 = u22 + v553.effects.ticks[1];
				elseif v553.mainstats.name == "Virus Stage 3" then
					afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).VirusD);
					u91(4);
					u22 = u22 + v553.effects.ticks[1];
					u20 = u20 + v553.mainstats.ints[2] / 100;
				elseif v553.mainstats.name == "Virus Stage 4" then
					l__workspace__1.ServerStuff.dealDamage:FireServer("sepsis", nil, v4);
				end;
				u10[v553.mainstats.name] = nil;
				u93();
			end;
		end);
		u10[v553.mainstats.name] = v553;
		u93();
	end;
end;
l__workspace__1.ServerStuff.flinchTarget.OnClientEvent:Connect(function(p73, p74, p75, p76)
	if p73 == character.Torso or p73:FindFirstChild("RootJoint") == nil then
		return;
	end;
	local v607 = math.clamp(p76 * 2, 3, 35);
	if p75 > 80 then
		v607 = -v607;
	end;
	if p75 > 80 then
		p75 = 0;
	end;
	p75 = math.clamp(p75, -40, 40);
	for v608 = 1, 60 do
		if p73:FindFirstChild("Left Hip") == nil then
			break;
		end;
		if v608 < 5 then
			p74.RootJoint.C0 = p74.RootJoint.C0:lerp(CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0) * CFrame.Angles(math.rad(-v607), 0, 0) * CFrame.Angles(0, 0, math.rad(p75)), 0.5);
			p73["Right Hip"].C0 = p73["Right Hip"].C0:lerp(CFrame.new(1, -1, 0, -4.37113883E-08, 0, 1, -0, 0.99999994, 0, -1, 0, -4.37113883E-08) * CFrame.Angles(0, math.rad(-p75), 0) * CFrame.Angles(0, 0, math.rad(-v607)), 0.5);
			p73["Left Hip"].C0 = p73["Left Hip"].C0:lerp(CFrame.new(-1, -1, 0, -4.37113883E-08, 0, -1, 0, 0.99999994, 0, 1, 0, -4.37113883E-08) * CFrame.Angles(0, math.rad(p75), 0) * CFrame.Angles(0, 0, math.rad(v607)), 0.5);
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
	v100({ "gamemode" }, "shadowchosen", nil, nil, true, true);
	local v609 = Instance.new("Frame");
	v609.BorderSizePixel = 0;
	v609.BackgroundColor3 = Color3.new(0.9, 0, 0);
	v609.Size = UDim2.new(1, 0, 1, 0);
	v609.ZIndex = 100;
	v609.Parent = maingui;
	while true do
		v609.BackgroundTransparency = v609.BackgroundTransparency + 0.025;
		RS:wait();
		if not (1 <= v609.BackgroundTransparency) then

		else
			break;
		end;	
	end;
	v609:Destroy();
end;
local u94 = false;
local function u95(p77, p78, p79)
	local l__clientmusic__610 = l__workspace__1.clientmusic;
	while true do
		l__clientmusic__610.Volume = l__clientmusic__610.Volume - 0.05;
		RS:wait();
		if l__clientmusic__610.Volume <= 0 then
			break;
		end;	
	end;
	l__clientmusic__610:Stop();
	if playerstats.Settings.MuteMusic == true and p78 == nil then
		return;
	end;
	l__clientmusic__610.SoundId = p77;
	l__clientmusic__610:Play();
	local v611 = 0.5;
	if p79 then
		v611 = p79;
	end;
	while true do
		l__clientmusic__610.Volume = l__clientmusic__610.Volume + 0.05;
		RS:wait();
		if v611 <= l__clientmusic__610.Volume then
			break;
		end;	
	end;
	l__clientmusic__610.Volume = v611;
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
		v100({ "general" }, "deathwhisper", nil, nil, true, true);
		agent_speak("down", true);
		if v60 == true then
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
	for v612, v613 in ipairs(maingui.UpperLower.auxcount:GetChildren()) do
		if v613.Name ~= "ex" then
			if tonumber(string.sub(v613.Name, 4, 6)) <= aux_usage then
				v613.inner.Visible = true;
			else
				v613.inner.Visible = false;
			end;
			if aux_usage == 0 then
				v613.inner.Visible = false;
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
		local v614, v615, v616 = pairs(u10);
		while true do
			local v617, v618 = v614(v615, v616);
			if v617 then

			else
				break;
			end;
			v616 = v617;
			v618.effects.currentduration = 0;		
		end;
	end);
	v100({ "gamemode" }, "shadowidle", nil, nil, nil, true).Looped = true;
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
	local v619 = l__game__7.ReplicatedStorage.effects.wraithFX:Clone();
	v619.CFrame = l__CurrentCamera__1.CFrame;
	v619.Parent = l__CurrentCamera__1;
	local v620 = Instance.new("Motor6D");
	v620.Part0 = v619;
	v620.Part1 = cpart;
	v620.C1 = CFrame.new(0, 0, -0.4) * CFrame.Angles(0, 0, 0);
	v620.Parent = v619;
	shadowForm = true;
	if u19 then
		u19:Destroy();
	end;
	local v621, v622, v623 = pairs(v5);
	while true do
		local v624, v625 = v621(v622, v623);
		if v624 then

		else
			break;
		end;
		v623 = v624;
		v625[1] = "Fist";
		v625[3] = nil;	
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
	local v626 = false;
	remove_dual_wield();
	u23 = u17.name;
	local v627 = nil;
	for v628, v629 in pairs(v5) do
		if v629[2] == true and v629[3] ~= nil then
			v627 = v629[3];
		end;
	end;
	if u19:FindFirstChild("trapped") then
		v627 = "trapped";
	end;
	u19:Destroy();
	invmanage("updatehud");
	local v630 = nil;
	for v631, v632 in pairs(v5) do
		if v632[2] == true and v632[4] ~= nil then
			v630 = v632[4];
			v632[4] = nil;
			break;
		end;
	end;
	if v630 ~= nil then
		v627 = "AGENT" .. v630;
	end;
	RS:wait();
	for v633, v634 in pairs(v5) do
		if v634[2] == true and v634[1] == "Fist" then
			v626 = true;
		end;
	end;
	if v626 == false then
		for v635, v636 in pairs(v5) do
			if v636[2] == true then
				v636[1] = "Fist";
				v636[3] = nil;
				if v635 == 1 then
					primskin = nil;
				end;
			end;
		end;
		l__workspace__1.ServerStuff.throwWeapon:FireServer(u18, nil, l__CurrentCamera__1.CFrame, "drop", u17, v627, v5[1][2], v4, p83);
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
	local v637 = nil;
	if p86 then
		local v638 = CFrame.new(l__CurrentCamera__1.Focus.p, l__CurrentCamera__1.Focus.p + Vector3.new(l__CurrentCamera__1.CoordinateFrame.lookVector.x, 0, l__CurrentCamera__1.CoordinateFrame.lookVector.z).unit):inverse() * p86.HumanoidRootPart.Position;
		local l__unit__639 = Vector3.new(v638.x, v638.z).unit;
		v637 = math.deg(math.atan2(l__unit__639.y * 200, l__unit__639.x * 200)) + 90;
	end;
	if typeof(p87) ~= "string" then
		local v640 = p87 / 35;
		local v641 = math.clamp(3 - v640 * 2, 0.75, 3);
		local v642 = math.clamp(v640, 0.05, 0.8);
		if p88 > 0 then
			if hum.Health <= 15 and tick() - AGENT_debounces.low_health >= 15 then
				AGENT_debounces.low_health = tick();
				agent_speak("lowhealth", true);
			end;
			if p86 ~= character and u9.blocking == false then
				tpglobalanimsets.damage:Play(0.1, v642, v641);
			end;
			u33 = u33 + p87;
			u41();
			if u10.Painkillers == nil then
				shakecamera("damage", { p87 });
			end;
		end;
		if playerstats.Class == "sword" then
			if v59[3].dogtagsdamagetimer <= tick() - v58.dogtag_lose_timer then
				v58.dogtag_lose_damage = p87;
			else
				v58.dogtag_lose_damage = v58.dogtag_lose_damage + p87;
			end;
			v58.dogtag_lose_timer = tick();
			if v59[3].dogtagsheavydamage <= v58.dogtag_lose_damage then
				v58.dogtag_lose_damage = 0;
				v58.losetags(p87, false);
			end;
		elseif playerstats.Class == "fire" then
			local v643 = p87 * v59[3].overheat_cooldown_multiplier;
			if p85.weapontype == "Gun" then
				v643 = v643 * v59[3].overheat_gun_multiplier;
			end;
			v58.apply_overheat(v643, true);
		end;
		if playerstats.Class == "goggles" and v58.goggletakedamage and p87 > 2 then
			v58.goggletakedamage(p87);
		end;
		if v48 == true and (u17.weapontype == "Gun" or u17.weapontype == "Bow") then
			u96();
		end;
		if u10.Lazarus or u10["Defense Buff"] then
			local v644 = 8;
			if u10.Lazarus then
				v644 = v18.lazarus.activestats.min_heal;
			end;
			if hum.Health <= v644 then
				l__workspace__1.ServerStuff.dealDamage:FireServer("lazarusheal", p87, v4);
			end;
		end;
		v100({ "hitsound", "general" }, "hitreceive", nil, nil, true, true);
		local v645 = require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS);
		if p85.weapontype == "Bludgeon" or p85.weapontype == "Blade" or p85.weapontype == "Axe" or p85.weapontype == "Spear" or p85.weapontype == "Fists" then
			if p86 and u36.tagged[p86.Name] and p87 and p87 >= 12 then
				u36.tagged[p86.Name] = nil;
				u36.ticktimers[p86.Name] = tick();
				u36.suslevels[p86.Name] = tick();
			end;
			local v646 = nil;
			if p85.weapontype == "Bludgeon" then
				v646 = v645.Crp;
				if p90.sub then
					u8 = math.clamp(u8 - p87 * v6.sub.efx[1] / 100, 0, v61);
				end;
			elseif p85.weapontype == "Blade" then
				v646 = v645.Bld;
				if p90.clot then
					clottingwound = p85.woundrating;
					clotting = tick();
				end;
			elseif p85.weapontype == "Axe" then
				v646 = v645.Bld;
			elseif p85.weapontype == "Spear" then
				v646 = v645.Crp;
			end;
			if (p85.weapontype == "Bludgeon" or p85.weapontype == "Blade") and u10.Silencer then
				v646 = nil;
			end;
			if p85.name == "Hidden Knife" and p87 >= 40 then
				local l__Crp__647 = v645.Crp;
				l__Crp__647.intensity = 4;
				afflictstatus(l__Crp__647);
			end;
			if v646 then
				v646.intensity = p85.woundrating;
				if p90.maniac and p85.weapontype == "Axe" then
					v646.intensity = v6.maniac.efx[1];
				end;
				local v648 = math.random(1, 10);
				if p90 and p90.backstab == true then
					v648 = 1;
				end;
				if v648 == 1 then
					if u10.Bleed and v646 == v645.Bld and u10["Bleed Prevention"] == nil then
						afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).HeavBld);
					end;
					if v646 == v645.Crp and math.random(1, 2) == 1 then
						v646 = v645.Frac;
					end;
					afflictstatus(v646);
					if p90.clot and p85.weapontype == "Blade" and v6.clot.efx[1] < tick() - clotting then
						spawn(function()
							while true do
								v646.intensity = clottingwound;
								afflictstatus(v646);
								RS:wait();
								if v6.clot.efx[1] < tick() - clotting then
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
				v100({ "hitsound", "general" }, "hitheadshot", nil, nil, true, true);
			end;
			if v58.aegisshieldup ~= nil and p87 > 1 then
				v58.aegisshieldup(p87 * v59[3].aegisrangeddamagemultiplier);
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
					local l__Bld__649 = require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Bld;
					l__Bld__649.intensity = v6.codered.efx[1];
					afflictstatus(l__Bld__649);
				end;
			end;
		end;
		if p85 == "grenade" or p85 == "grenadeairburst" or p85 == "grenadetinnitus" then
			globalanimsets.explosion_waiver:Play(0.05, 1, 0.5);
			if playerperks.bomb == nil and v55 == false then
				local l__Bld__650 = require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Bld;
				l__Bld__650.intensity = 1;
				afflictstatus(l__Bld__650);
				if p85 ~= "grenadeairburst" then
					local l__Crp__651 = require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Crp;
					l__Crp__651.intensity = 1;
					afflictstatus(l__Crp__651);
				end;
			end;
			if p85 == "grenadetinnitus" and v55 == false then
				v100({ "general" }, "tinnitus", nil, nil, true, true);
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
					local l__Bld__652 = require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Bld;
					l__Bld__652.intensity = v17.TAxe.sizerating;
					local l__Crp__653 = require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Crp;
					l__Crp__653.intensity = v17.TAxe.sizerating;
					afflictstatus(l__Bld__652);
					afflictstatus(l__Crp__653);
				end;
			elseif p85[2].name == "Throwing Javelin" then
				afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Prc);
			end;
		end;
		if p85 == "caltrop" then
			local l__Bld__654 = require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Bld;
			l__Bld__654.intensity = 3;
			local l__Crp__655 = require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Crp;
			l__Crp__655.intensity = 3;
			afflictstatus(l__Bld__654);
			afflictstatus(l__Crp__655);
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
			v108.damagetaken = v108.damagetaken + p88;
			l__workspace__1.ServerStuff.adjustStats:FireServer("tracker", { "DamageTakenFrom", p88 });
			if tick() - hiddeneyescooldown > 2.5 and startperk.Value == "hiddenB" then
				hiddeneyescooldown = tick();
				l__workspace__1.ServerStuff.dealDamage:FireServer("hiddeneyes", nil, v4);
			end;
			local v656 = maingui.Damage:Clone();
			v656.Rotation = v637;
			v656.Visible = true;
			spawn(function()
				for v657 = 1, 40 do
					v656.Indicator.ImageTransparency = v656.Indicator.ImageTransparency + 0.025;
					RS:wait();
				end;
				v656:Destroy();
			end);
			v656.Parent = maingui;
		end;
		if p85 == "minigunbash" and (u9.sprinting == true or u9.swinging == true or u9.charging == true or u9.blocking == true) then
			spawn(function()
				stagger("normal");
			end);
		end;
		if v637 and p86 then
			l__workspace__1.ServerStuff.flinchTarget:FireServer(character.Torso, character.HumanoidRootPart, v637, p87);
		end;
	elseif p87 == "shove" then
		if u9.blocking == true and u10.Unwaivered == nil and u9.blockrecoil == false then
			spawn(function()
				stagger("normal");
			end);
		else
			l__workspace__1.ServerStuff.flinchTarget:FireServer(character.Torso, character.HumanoidRootPart, v637, 3);
		end;
	elseif p87 == "clienthitblocked" then
		if u9.staggering == false then
			spawn(function()
				stagger("normal");
			end);
		end;
	elseif p87 == "ai_grapple" or p87 == "force_stagger" or p87 == "airburst_stagger" then
		if p87 == "airburst_stagger" and v55 == true then
			return;
		end;
		if v50 == true or p87 == "force_stagger" then
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
		local l__Bld__658 = require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Bld;
		l__Bld__658.intensity = 2;
		afflictstatus(l__Bld__658);
	elseif p87 == "disability" then
		local l__Crp__659 = require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Crp;
		l__Crp__659.intensity = v6.disab.efx[1];
		afflictstatus(l__Crp__659);
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
	local v660 = p93;
	local v661 = Color3.new(0, 0.8, 0.9);
	if p91.Parent.Name == "Heavy Ammo" or p91.Parent.Name == "Shells Ammo" or p91.Parent.Name == "Light Ammo" or p91.Parent.Name == "Long Ammo" or p91.Parent.Name == "Short Ammo" or p91.Parent.Name == "Medium Ammo" or p91.Parent.Name == "Small Ammo" then
		v661 = Color3.new(1, 0.8, 0);
	elseif p91.Name == "HarvestWood" or p91.Name == "HarvestStone" then
		v661 = Color3.new(0.8, 0, 0.8);
	elseif p91.Name == "JointGrip" then
		v661 = Color3.new(0.2, 0.9, 0);
	elseif p91.Name == "Head" then
		v661 = Color3.new(1, 0.1, 0);
	end;
	if p92 == true then
		v660 = 8;
	end;
	local v662 = l__game__7.ReplicatedStorage.misc.teammateindicator:Clone();
	l__Debris__26:AddItem(v662, v660);
	v662.AlwaysOnTop = true;
	v662.ImageLabel.ImageColor3 = v661;
	v662.Parent = p91;
	v662.Adornee = p91;
	if p92 == true then
		v662.ImageLabel.Rotation = 180;
		delay(p93 - 0.5, function()
			while true do
				v662.ImageLabel.ImageTransparency = v662.ImageLabel.ImageTransparency + 0.05;
				RS:wait();
				if v662 == nil then
					break;
				end;
				if v662.ImageLabel.ImageTransparency >= 1 then
					break;
				end;			
			end;
			v662:Destroy();
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
			local v663 = l__game__7.ReplicatedStorage.effects.bloodSplatter:Clone();
			l__Debris__26:AddItem(v663, 2);
			v663.CFrame = CFrame.new(p95.Torso.Position);
			v663.Parent = l__workspace__1.NoTarget;
			local v664 = p96[1];
			if v664 == nil then
				v664 = 1;
			end;
			local v665 = v664 / 1.5;
			if v665 < 6 then
				v665 = 6;
			end;
			v663.fx1.Enabled = true;
			v663.fx1:Emit(math.random(v665, v665 + math.random(3, 5)));
			v663.fx1.Enabled = false;
			if p94 == "bloodhit" then
				local v666 = l__game__7.ReplicatedStorage.effects.bloodSplatter:Clone();
				l__Debris__26:AddItem(v666, 2);
				v666.CFrame = CFrame.new(p96[2]);
				v666.Parent = l__workspace__1.NoTarget;
				v666.fx2.Enabled = true;
				v666.fx2:Emit(math.random(1, 3));
				v666.fx2.Enabled = false;
				v666.fx3.Enabled = true;
				v666.fx3:Emit(math.random(5, 10));
				v666.fx3.Enabled = false;
				v666.fx4.Enabled = true;
				v666.fx4:Emit(math.random(5, 10));
				v666.fx4.Enabled = false;
			end;
		elseif p94 == "blocksmoke" then
			local v667 = l__game__7.ReplicatedStorage.effects.smokeBlock:Clone();
			l__Debris__26:AddItem(v667, 1);
			v667.Parent = p95.Torso;
			v667.Enabled = true;
			v667:Emit(math.random(3, 5));
			v667.Enabled = false;
		elseif p94 == "laz_shock" then
			local v668 = { "Left Arm", "Torso", "Right Arm" };
			if p96[2] ~= nil then
				v668 = { "Left Arm", "Torso", "Right Arm", "Left Leg", "Right Leg" };
			end;
			if p95 == character then
				v668 = { "Torso" };
				afflictstatus(require(l__game__7.Workspace.ServerStuff.Statistics.S_STATISTICS).Laz);
			end;
			local v669, v670, v671 = ipairs(v668);
			while true do
				local v672, v673 = v669(v670, v671);
				if v672 then

				else
					break;
				end;
				v671 = v672;
				if p95:FindFirstChild(v673) then
					local v674 = l__game__7.ReplicatedStorage.effects.electriclazarus:Clone();
					l__Debris__26:AddItem(v674, p96[1]);
					v674.Parent = p95:FindFirstChild(v673);
				end;			
			end;
		elseif p94 == "lazarus_fire" then
			local v675 = l__game__7.ReplicatedStorage.effects.lazarusfx:Clone();
			l__Debris__26:AddItem(v675, 10);
			v675.CFrame = CFrame.new(p96[1]);
			v675.Parent = l__workspace__1.NoTarget;
			v675.attach.ring1:Emit(1);
			v675.attach.ring2:Emit(1);
			v675.attach.spark3:Emit(1);
			v675.attach.spark2:Emit(1);
			v675.leftover:Emit(math.random(30, 60));
			v675.leftover.Enabled = false;
			v675.attach.ring1.Enabled = false;
			v675.attach.ring2.Enabled = false;
			v675.attach.spark3.Enabled = false;
			v675.attach.spark2.Enabled = false;
			delay(0.2, function()
				v675.attach.sparks.Enabled = false;
			end);
			delay(1, function()
				v675.residual.Enabled = false;
			end);
			RS:wait();
			v100({ "perks" }, "laz_explosion", v675, 0.05, true, false);
		elseif p94 == "immolate_ability" then
			local v676 = l__game__7.ReplicatedStorage.effects.immolatorEffect:Clone();
			l__Debris__26:AddItem(v676, 10);
			v676.CFrame = p96[1];
			v676.Parent = l__workspace__1.NoTarget;
			RS:wait();
			v676.ember:Emit(math.random(30, 40));
			v676.flame:Emit(math.random(30, 40));
			v676.small:Emit(math.random(30, 40));
			v676.smoke:Emit(math.random(30, 40));
			v676.flamespread:Emit(math.random(20, 30));
			v100({ "perks" }, "flamer_ignite", v676, 0.05, true, false);
		elseif p94 == "shotshell_blast" then
			local v677 = l__game__7.ReplicatedStorage.misc.shotshellFX:Clone();
			l__Debris__26:AddItem(v677, 5);
			v677.CFrame = CFrame.new(p96[1]);
			if p96[2] then
				v677.Beam.Enabled = true;
				v677.trail.CFrame = CFrame.new(p96[2]);
			end;
			v677.Parent = l__workspace__1.NoTarget;
			v677.fx:Emit(math.random(10, 15));
			v677.fx2:Emit(math.random(8, 10));
			v677.fx3:Emit(math.random(20, 30));
			v677.fx4:Emit(1);
			if p96[2] then
				v677.largefx1:Emit(math.random(10, 15));
				v677.largefx2:Emit(math.random(15, 20));
				v677.largefx3:Emit(1);
				delay(0.5, function()
					local v678 = 1 - 1;
					while true do
						v677.Beam.Transparency = NumberSequence.new(v678 / 30);
						RS:wait();
						if 0 <= 1 then
							if v678 < 30 then

							else
								break;
							end;
						elseif 30 < v678 then

						else
							break;
						end;
						v678 = v678 + 1;					
					end;
				end);
			end;
		elseif p94 == "lazarus_laser" then
			local v679 = l__game__7.ReplicatedStorage.effects.laztrail:Clone();
			l__Debris__26:AddItem(v679, 3);
			v679.trailA.CFrame = CFrame.new(p96[1]);
			v679.trailB.CFrame = CFrame.new(p96[2]);
			v679.Parent = l__workspace__1.NoTarget;
			v679.trailA.crystal:Emit(math.random(3, 8));
			v679.trailA.flare:Emit(1);
			v679.trailA.spark:Emit(math.random(5, 10));
			v679.trailA.crystal.Enabled = false;
			v679.trailA.flare.Enabled = false;
			v679.trailA.spark.Enabled = false;
			delay(0.3, function()
				local v680 = 1 - 1;
				while true do
					v679.Beam.Transparency = NumberSequence.new(v680 / 25);
					RS:wait();
					if 0 <= 1 then
						if v680 < 25 then

						else
							break;
						end;
					elseif 25 < v680 then

					else
						break;
					end;
					v680 = v680 + 1;				
				end;
				v679:Destroy();
			end);
		elseif p94 == "harvestmat" then
			if p96[2] == nil then
				return;
			end;
			local v681 = l__game__7.ReplicatedStorage.effects.harvest_fx:Clone();
			l__Debris__26:AddItem(v681, 2);
			v681.CFrame = CFrame.new(p96[2]);
			v681.Parent = l__workspace__1.NoTarget;
			if p96[1] == "salvaged" then
				v681.smokeharvest.Enabled = true;
				v681.smokeharvest:Emit(1);
				v681.smokeharvest.Enabled = false;
			else
				v681[p96[1] .. "fx1"].Enabled = true;
				v681[p96[1] .. "fx1"]:Emit(math.random(2, 4));
				v681[p96[1] .. "fx1"].Enabled = false;
				v681[p96[1] .. "fx2"].Enabled = true;
				v681[p96[1] .. "fx2"]:Emit(math.random(2, 4));
				v681[p96[1] .. "fx2"].Enabled = false;
			end;
		elseif p94 == "fall_nullified" then
			local v682 = l__game__7.ReplicatedStorage.effects.fall_fx:Clone();
			v682.CFrame = p95.Torso.CFrame;
			l__Debris__26:AddItem(v682, 3);
			local v683 = Instance.new("Weld");
			v683.Part0 = p95.Torso;
			v683.Part1 = v682;
			v682.Parent = p95.Torso;
			v683.Parent = v682;
			RS:wait();
			v682.attach.effect:Emit(math.random(20, 30));
			v682.attach.effect2:Emit(math.random(15, 20));
			v682.attach.effect.Enabled = false;
			v682.attach.effect2.Enabled = false;
		elseif p94 == "floorSplat" then
			if u9.air == false then
				local v684 = raycastline(p95.Torso.CFrame.p, -p95.Torso.CFrame.upVector, 8, { p95, character, l__workspace__1.NoTarget });
				if v684 then
					if v684.Name ~= "BLOODRoot" then
						local v685 = l__game__7.ReplicatedStorage.effects:FindFirstChild("floorblood" .. math.random(1, 4)):Clone();
						if p96 == nil then
							p96 = 20;
						end;
						local v686, v687, v688 = pairs(v685.BLOODRoot:GetChildren());
						while true do
							local v689, v690 = v686(v687, v688);
							if v689 then

							else
								break;
							end;
							v688 = v689;
							v690.Decal.Transparency = 0.5 - p96 / 65;						
						end;
						l__Debris__26:AddItem(v685, 23);
						v685:SetPrimaryPartCFrame(CFrame.new(p95.Torso.Position - Vector3.new(0, 2.9, 0)));
						delay(20, function()
							if v685:FindFirstChild("BLOODRoot") then
								local v691 = 1 - 1;
								while true do
									local v692, v693, v694 = pairs(v685.BLOODRoot:GetChildren());
									while true do
										local v695, v696 = v692(v693, v694);
										if v695 then

										else
											break;
										end;
										v694 = v695;
										v696.Decal.Transparency = v696.Decal.Transparency + 0.05;									
									end;
									RS:wait();
									if 0 <= 1 then
										if v691 < 20 then

										else
											break;
										end;
									elseif 20 < v691 then

									else
										break;
									end;
									v691 = v691 + 1;								
								end;
							end;
							v685:Destroy();
						end);
						v685.Parent = l__workspace__1.GoreEffects;
					end;
				end;
			elseif p94 == "firegun" then
				local v697 = l__game__7.ReplicatedStorage.effects.gunTrail:Clone();
				l__Debris__26:AddItem(v697, 3);
				v697.trailA.CFrame = CFrame.new(p96[1]);
				v697.trailB.CFrame = CFrame.new(p96[2]);
				v697.Parent = l__workspace__1.NoTarget;
				local v698 = l__game__7.ReplicatedStorage.effects.bullet_trail:Clone();
				l__Debris__26:AddItem(v698, 0.2);
				v698.CFrame = CFrame.new(p96[1], p96[2]);
				v698.CFrame = v698.CFrame + v698.CFrame.lookVector * math.random(15, 25);
				if p96[3] == false then
					v698.Parent = l__workspace__1.NoTarget;
					spawn(function()
						RS:wait();
						v698.Velocity = v698.Velocity + v698.CFrame.lookVector * 1000;
					end);
				end;
				if p96[4] == nil then
					if 0.02 < tick() - crackcd then
						v100({ "firearms" }, "crack", v697.trailB, 0.1, true, false);
					end;
					crackcd = tick();
					v697.trailB.debrisA.Enabled = true;
					v697.trailB.debrisB.Enabled = true;
					v697.trailB.smoke.Enabled = true;
					v697.trailB.spark.Enabled = true;
					v697.trailB.debrisA:Emit(math.random(3, 6));
					v697.trailB.debrisB:Emit(math.random(3, 6));
					v697.trailB.smoke:Emit(math.random(2, 4));
					v697.trailB.spark:Emit(math.random(8, 12));
					v697.trailB.debrisA.Enabled = false;
					v697.trailB.debrisB.Enabled = false;
					v697.trailB.smoke.Enabled = false;
					v697.trailB.spark.Enabled = false;
				else
					v100({ "hitsound", "guns" }, "bullet_impact" .. math.random(1, 3), v697.trailB, 0.1, true, false);
				end;
				if p96[5] == nil then
					local v699 = l__game__7.ReplicatedStorage.effects.gunFX:Clone();
					l__Debris__26:AddItem(v699, 1);
					v699.CFrame = CFrame.new(p96[1]);
					v699.Parent = l__workspace__1.NoTarget;
					spawn(function()
						if p96[3] == false then
							v699.flash.Enabled = true;
							v699.flash:Emit(1);
							v699.flash.Enabled = false;
							local v700 = l__game__7.ReplicatedStorage.misc.muzzleflash:Clone();
							l__Debris__26:AddItem(v700, 0.05);
							v700.Parent = v699;
						end;
						v699.smoke.Enabled = true;
						v699.smoke2.Enabled = true;
						v699.smoke:Emit(math.random(4, 6));
						v699.smoke:Emit(math.random(10, 15));
						v699.smoke.Enabled = false;
						v699.smoke2.Enabled = false;
					end);
				end;
			elseif p94 == "incendiary_trail" then
				local v701 = l__game__7.ReplicatedStorage.effects.incendiary_trail:Clone();
				l__Debris__26:AddItem(v701, 3);
				v701.trailA.CFrame = CFrame.new(p96[1]);
				v701.trailB.CFrame = CFrame.new(p96[2]);
				v701.Parent = l__workspace__1.NoTarget;
				if 0.02 < tick() - specialcrackcd then
					v100({ "firearms" }, "incendiary_crack", v701.trailB, 0.1, true, false);
				end;
				specialcrackcd = tick();
				v701.trailB.ember:Emit(math.random(8, 12));
				v701.trailB.flame:Emit(math.random(5, 10));
				v701.trailB.small:Emit(math.random(5, 10));
				spawn(function()
					local v702 = 1 - 1;
					while true do
						v701.Beam.Transparency = NumberSequence.new(v702 / 20);
						RS:wait();
						if 0 <= 1 then
							if v702 < 20 then

							else
								break;
							end;
						elseif 20 < v702 then

						else
							break;
						end;
						v702 = v702 + 1;					
					end;
				end);
			elseif p94 == "muzzle_flash" then
				local v703 = l__game__7.ReplicatedStorage.effects.gunFX:Clone();
				l__Debris__26:AddItem(v703, 1);
				v703.CFrame = CFrame.new(p96[1]);
				v703.Parent = l__workspace__1.NoTarget;
				spawn(function()
					if p96[2] == false then
						v703.flash.Enabled = true;
						v703.flash:Emit(1);
						v703.flash.Enabled = false;
						local v704 = l__game__7.ReplicatedStorage.misc.muzzleflash:Clone();
						l__Debris__26:AddItem(v704, 0.05);
						v704.Parent = v703;
					end;
					v703.smoke.Enabled = true;
					v703.smoke2.Enabled = true;
					v703.smoke:Emit(math.random(4, 6));
					v703.smoke:Emit(math.random(10, 15));
					v703.smoke.Enabled = false;
					v703.smoke2.Enabled = false;
				end);
			elseif p94 == "hangerPopup" then
				local function v705()
					local v706 = { "YOU ARE WORTHLESS", "USELESS", "YOU ARE HOPELESS", "HOPELESS", "DIE", "GIVE UP", "YOU ARE USELESS", "WORTHLESS", "MEANINGLESS", "YOU ARE MEANINGLESS" };
					local v707 = l__game__7.ReplicatedStorage.soundLibrary.general_ui.static:Clone();
					v707.TimePosition = math.random(1, 30);
					v707.Parent = l__CurrentCamera__1;
					local v708 = { "4452726587", "4452726886", "4452727160", "4452727454" };
					local v709 = math.random(1, 4);
					local v710 = l__game__7.ReplicatedStorage.misc.hangertext:Clone();
					v710.static.Image = "rbxassetid://" .. v708[v709];
					v710.popuptext.Text = v706[math.random(1, #v706)];
					local v711 = math.random(20, 80) / 100;
					local v712 = math.random(10, 90) / 100;
					v710.popuptext.Position = UDim2.new(v711, 0, v712, 0);
					local u99 = 0;
					local u100 = v709;
					spawn(function()
						v707:Play();
						v710.Parent = ply.PlayerGui;
						local v713 = tick();
						while true do
							v710.popuptext.Position = UDim2.new(v711, math.random(-10, 10), v712, math.random(-10, 10));
							if 0.05 <= tick() - u99 then
								u99 = tick();
								u100 = u100 + 1;
								if 4 < u100 then
									u100 = 1;
								end;
								v710.static.Image = "rbxassetid://" .. v708[u100];
							end;
							RS:wait();
							if not (0.3 <= tick() - v713) then

							else
								break;
							end;						
						end;
						v710:Destroy();
						v707:Destroy();
					end);
				end;
				if character:FindFirstChild("HumanoidRootPart") then
					if (character:FindFirstChild("HumanoidRootPart").Position - p95.Position).magnitude <= 30 then
						v705();
						if (character:FindFirstChild("HumanoidRootPart").Position - p95.Position).magnitude <= 15 then
							delay(1.5, function()
								v705();
							end);
						end;
					end;
				end;
			elseif p94 == "firelaser" then
				local v714 = l__game__7.ReplicatedStorage.effects.laserTrail:Clone();
				l__Debris__26:AddItem(v714, 3);
				v714.trailA.CFrame = CFrame.new(p96[1]);
				v714.trailB.CFrame = CFrame.new(p96[2]);
				v714.Parent = l__workspace__1.NoTarget;
				if p96[4] == nil then
					if 0.02 < tick() - crackcd then
						v100({ "hitsound", "general" }, "plasma", v714.trailB, 0.1, true, false);
					end;
					crackcd = tick();
					v714.trailB.debrisA.Enabled = true;
					v714.trailB.debrisB.Enabled = true;
					v714.trailB.smoke.Enabled = true;
					v714.trailB.spark.Enabled = true;
					v714.trailB.debrisA:Emit(math.random(3, 6));
					v714.trailB.debrisB:Emit(math.random(3, 6));
					v714.trailB.smoke:Emit(math.random(2, 4));
					v714.trailB.spark:Emit(math.random(8, 12));
					v714.trailB.debrisA.Enabled = false;
					v714.trailB.debrisB.Enabled = false;
					v714.trailB.smoke.Enabled = false;
					v714.trailB.spark.Enabled = false;
				end;
				if p96[3] ~= nil then
					v714.Beam.Color = ColorSequence.new(Color3.new(0.6392156862745098, 0.13333333333333333, 1));
				end;
				delay(0.3, function()
					local v715 = 1 - 1;
					while true do
						v714.Beam.Transparency = NumberSequence.new(v715 / 25);
						RS:wait();
						if 0 <= 1 then
							if v715 < 25 then

							else
								break;
							end;
						elseif 25 < v715 then

						else
							break;
						end;
						v715 = v715 + 1;					
					end;
					v714:Destroy();
				end);
				local v716 = l__game__7.ReplicatedStorage.effects.laserFX:Clone();
				if p96[3] ~= nil then
					local v717, v718, v719 = ipairs(v716:GetChildren());
					while true do
						local v720, v721 = v717(v718, v719);
						if v720 then

						else
							break;
						end;
						v719 = v720;
						if v721:IsA("ParticleEmitter") then
							v721.Color = ColorSequence.new(Color3.new(0.6392156862745098, 0.13333333333333333, 1));
						end;					
					end;
				end;
				l__Debris__26:AddItem(v716, 1);
				v716.CFrame = CFrame.new(p96[1]);
				v716.Parent = l__workspace__1.NoTarget;
				spawn(function()
					v716.flash.Enabled = true;
					v716.flash:Emit(1);
					v716.flash.Enabled = false;
					v716.crystal.Enabled = true;
					v716.crystal:Emit(math.random(2, 4));
					v716.crystal.Enabled = false;
					v716.spark.Enabled = true;
					v716.spark:Emit(math.random(4, 8));
					v716.spark.Enabled = false;
					v716.flare.Enabled = true;
					v716.flare:Emit(1);
					v716.flare.Enabled = false;
				end);
			elseif p94 == "bowarrow" then
				local v722 = l__game__7.ReplicatedStorage.effects.bowtrail:Clone();
				v722.CFrame = p96[1];
				v722.Parent = l__workspace__1.NoTarget;
				RS:wait();
				v722.CFrame = p96[1];
				local v723, v724 = raycastline(p96[1].p, p96[1].LookVector + p96[2], 80, { l__workspace__1.NoTarget, l__workspace__1.GoreEffects, l__CurrentCamera__1 });
				RS:wait();
				v722.CFrame = CFrame.new(v724);
				if v723 == nil then
					local v725 = v724;
					local v726 = 1 - 1;
					while true do
						local v727, v728 = raycastline(v725, p96[1].LookVector + p96[2] + Vector3.new(0, -0.05, 0), 3, baselayer);
						v722.CFrame = CFrame.new(v728);
						if v727 then
							break;
						end;
						v725 = v728;
						RS:wait();
						if 0 <= 1 then
							if v726 < 200 then

							else
								break;
							end;
						elseif 200 < v726 then

						else
							break;
						end;
						v726 = v726 + 1;					
					end;
				end;
				l__Debris__26:AddItem(v722, 5);
			elseif p94 == "vomit" then
				if p95:FindFirstChild("Head") == nil then
					return;
				end;
				local v729 = l__game__7.ReplicatedStorage.effects.vomitBlock:Clone();
				v729.CFrame = p95.Head.CFrame;
				l__Debris__26:AddItem(v729, 3);
				local v730 = Instance.new("Weld");
				v730.Part0 = p95.Head;
				v730.Part1 = v729;
				v729.Parent = p95.Head;
				v730.Parent = v729;
				delay(1, function()
					v729.sickParticle.Enabled = false;
				end);
			elseif p94 == "lostecho" then
				if current_in_echo == true then
					return;
				end;
				current_in_echo = true;
				agent_speak("echo_start");
				local v731 = l__game__7.ReplicatedStorage.misc.echo_bg:Clone();
				v731.Parent = p96[1].hoverpart;
				v731.Adornee = p96[1].hoverpart;
				local v732 = 0;
				local v733 = tick();
				local v734 = 0.03;
				local v735 = 11;
				local v736 = tick();
				while true do
					if v734 <= tick() - v733 then
						v733 = tick();
						v734 = math.random(20, 40) / 1000;
						v732 = v732 + 1;
						v731.loading.Text = tostring(v732) .. "%";
						v731.loadingbar.bar.Size = UDim2.new(v732 / 100, 0, 3, 0);
					end;
					if 0.05 <= tick() - v736 then
						if 0 < v735 then
							v736 = tick();
							v735 = v735 - 1;
							v731.loadingbar.Visible = not v731.loadingbar.Visible;
						end;
					end;
					v731.loading.TextTransparency = v731.loading.TextTransparency - 0.03;
					v731.ring.ImageTransparency = v731.ring.ImageTransparency - 0.03;
					v731.ring.Size = v731.ring.Size:Lerp(UDim2.new(1, 0, 1, 0), 0.1);
					RS:wait();
					if not (100 <= v732) then

					else
						break;
					end;
					if p96[1] ~= nil then

					else
						break;
					end;				
				end;
				v731:Destroy();
				if p96[1] then
					v100({ "general_ui" }, "echo_open", p96[1].hoverpart, 0.01, true, false);
					local v737 = l__game__7.ReplicatedStorage.effects.echoball:Clone();
					l__Debris__26:AddItem(v737, 20);
					v737.CFrame = p96[1].hoverpart.CFrame;
					v737.Parent = l__CurrentCamera__1;
					spawn(function()
						while true do
							v737.Size = v737.Size + Vector3.new(1, 1, 1);
							v737.Transparency = v737.Transparency + 0.05;
							RS:wait();
							if not (1 <= v737.Transparency) then

							else
								break;
							end;						
						end;
						delay(1.5, function()
							v737.fx.Enabled = false;
						end);
					end);
					if l__game__7.ReplicatedStorage.echo:FindFirstChild(p96[2]) then
						local v738 = l__game__7.ReplicatedStorage.echo:FindFirstChild(p96[2]):Clone();
						v738.Parent = l__CurrentCamera__1;
						local v739, v740, v741 = ipairs(v738:GetChildren());
						while true do
							local v742, v743 = v739(v740, v741);
							if v742 then

							else
								break;
							end;
							v741 = v742;
							if v743:FindFirstChild("torso") then
								spawn(function()
									local v744 = l__game__7.ReplicatedStorage.effects.echoball:Clone();
									l__Debris__26:AddItem(v744, 10);
									v744.Material = Enum.Material.Neon;
									v744.CFrame = v743.torso.CFrame;
									v744.fx.Enabled = false;
									v744.Parent = l__CurrentCamera__1;
									v744.flash:Emit(math.random(10, 20));
									while true do
										v744.Size = v744.Size + Vector3.new(0.5, 0.5, 0.5);
										v744.Transparency = v744.Transparency + 0.1;
										RS:wait();
										if not (1 <= v744.Transparency) then

										else
											break;
										end;									
									end;
								end);
							end;						
						end;
						if p96[2] == "mountain" then
							delay(1.5, function()
								v100({ "echo_specific" }, "seat", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(3.5, function()
								v100({ "firearms" }, "rack", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(1, function()
								v100({ "movement_sounds" }, "step1", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(2, function()
								v100({ "movement_sounds" }, "step2", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(3, function()
								v100({ "movement_sounds" }, "step4", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(4, function()
								v100({ "movement_sounds" }, "step2", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(4.2, function()
								v100({ "echo_specific" }, "seat", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(5.9, function()
								v100({ "weapons", "Fists" }, "swingvar2", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(6, function()
								v100({ "hitsound", "melee" }, "fists", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9, function()
								v100({ "general" }, "reloadpartial", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(12, function()
								v100({ "weapons", "RFL" }, "Model 870", p96[1].hoverpart, nil, true, false, true);
							end);
						elseif p96[2] == "ship" then
							delay(1, function()
								v100({ "echo_specific" }, "lighter", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(2, function()
								v100({ "echo_specific" }, "lighter", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(3, function()
								v100({ "echo_specific" }, "lighter", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(1.5, function()
								v100({ "movement_sounds" }, "step1", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(2.5, function()
								v100({ "movement_sounds" }, "step2", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(3.5, function()
								v100({ "movement_sounds" }, "step4", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(4.5, function()
								v100({ "movement_sounds" }, "step2", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(6, function()
								v100({ "world_item" }, "ration_pickup", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(7, function()
								v100({ "movement_sounds" }, "step1", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(8, function()
								v100({ "movement_sounds" }, "step2", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(8.5, function()
								v100({ "weapons", "1HBL" }, "draw", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9, function()
								v100({ "weapons", "1HBL" }, "chargeswing", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9.3, function()
								v100({ "deaths" }, "axe_hit", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9.3, function()
								v100({ "deaths" }, "slash", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9.4, function()
								v100({ "world_item" }, "ration_pickup", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9.4, function()
								v100({ "general" }, "reloaddone", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9.6, function()
								v100({ "echo_specific" }, "running", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(10, function()
								v100({ "weapons", "ASMG" }, "M60-E6", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(11, function()
								v100({ "firearms" }, "casing_heavy", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(10.11, function()
								v100({ "weapons", "ASMG" }, "M60-E6", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(11.11, function()
								v100({ "firearms" }, "casing_heavy", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(10.22, function()
								v100({ "weapons", "ASMG" }, "M60-E6", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(10.32, function()
								v100({ "firearms" }, "crack", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(11.22, function()
								v100({ "firearms" }, "casing_heavy", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(10.33, function()
								v100({ "weapons", "ASMG" }, "M60-E6", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(11.33, function()
								v100({ "firearms" }, "casing_heavy", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(10.44, function()
								v100({ "weapons", "ASMG" }, "M60-E6", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(10.54, function()
								v100({ "firearms" }, "crack", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(11.44, function()
								v100({ "firearms" }, "casing_heavy", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(11.1, function()
								v100({ "echo_specific" }, "running", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(13, function()
								v100({ "weapons", "Item" }, "medikitcap", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(13.5, function()
								v100({ "weapons", "Item" }, "medikitspit", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(14, function()
								v100({ "weapons", "Item" }, "medikitflick", p96[1].hoverpart, nil, true, false, true);
							end);
						elseif p96[2] == "valley" then
							delay(0.5, function()
								v100({ "weapons", "Item" }, "esmarch", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(1, function()
								v100({ "movement_sounds" }, "step1", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(2, function()
								v100({ "movement_sounds" }, "step2", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(3, function()
								v100({ "movement_sounds" }, "step1", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(3.5, function()
								v100({ "general" }, "reloadpartial", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(6.8, function()
								v100({ "weapons", "2HPST" }, "draw", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(6.4, function()
								v100({ "weapons", "PST" }, "Glock 17", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(6.5, function()
								v100({ "firearms" }, "crack", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(7.2, function()
								v100({ "firearms" }, "casing_light", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(6.6, function()
								v100({ "reloads" }, "single_start", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(7, function()
								v100({ "weapons", "PST" }, "Glock 17", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(7.1, function()
								v100({ "firearms" }, "crack", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(8, function()
								v100({ "firearms" }, "casing_light", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(8, function()
								v100({ "reloads" }, "pistol_mid", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(7.2, function()
								v100({ "weapons", "2HPST" }, "Mark VII", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(8.4, function()
								v100({ "firearms" }, "casing_medium", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(7.9, function()
								v100({ "hitsound", "extras" }, "grapple2", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(8.6, function()
								v100({ "weapons", "2HPST" }, "Mark VII", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9.6, function()
								v100({ "firearms" }, "casing_medium", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(8.7, function()
								v100({ "deaths" }, "headshot2", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9, function()
								v100({ "movement_sounds" }, "step2", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(10, function()
								v100({ "movement_sounds" }, "step1", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(11, function()
								v100({ "movement_sounds" }, "step4", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(12, function()
								v100({ "weapons", "2HPST" }, "Mark VII", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(13, function()
								v100({ "firearms" }, "casing_medium", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(12, function()
								v100({ "deaths" }, "headshot1", p96[1].hoverpart, nil, true, false, true);
							end);
						elseif p96[2] == "market" then
							delay(1, function()
								v100({ "rations" }, "liquid_sip", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(2, function()
								v100({ "rations" }, "liquid_sip", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(3, function()
								v100({ "rations" }, "liquid_sip", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(3.5, function()
								v100({ "movement_sounds" }, "movement", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(3.8, function()
								v100({ "echo_specific" }, "seat", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(4.5, function()
								v100({ "weapons", "2HPST" }, "draw", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(4.6, function()
								v100({ "weapons", "ASMG" }, "draw", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(4.7, function()
								v100({ "weapons", "SMG" }, "draw", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(4.8, function()
								v100({ "weapons", "PST" }, "draw", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(6, function()
								v100({ "movement_sounds" }, "step1", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(7, function()
								v100({ "movement_sounds" }, "step2", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(8, function()
								v100({ "general" }, "reloadpartial", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(8.5, function()
								v100({ "weapons", "ASMG" }, "Modded AKM", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(8.6, function()
								v100({ "weapons", "ASMG" }, "Modded AKM", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(8.7, function()
								v100({ "weapons", "ASMG" }, "Modded AKM", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(8.8, function()
								v100({ "weapons", "ASMG" }, "Modded AKM", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(8.9, function()
								v100({ "weapons", "ASMG" }, "Modded AKM", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9, function()
								v100({ "weapons", "ASMG" }, "Modded AKM", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9.5, function()
								v100({ "firearms" }, "casing_heavy", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9.7, function()
								v100({ "firearms" }, "casing_heavy", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9.8, function()
								v100({ "firearms" }, "casing_heavy", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9.9, function()
								v100({ "firearms" }, "casing_heavy", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(8.4, function()
								v100({ "weapons", "PST" }, "Glock 17", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9.4, function()
								v100({ "firearms" }, "casing_light", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(8.7, function()
								v100({ "weapons", "PST" }, "Glock 17", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9.7, function()
								v100({ "firearms" }, "casing_light", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9, function()
								v100({ "weapons", "PST" }, "Glock 17", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(10, function()
								v100({ "firearms" }, "casing_light", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(8.7, function()
								v100({ "weapons", "PST" }, "M1911A1", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9.7, function()
								v100({ "firearms" }, "casing_light", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9.2, function()
								v100({ "weapons", "PST" }, "M1911A1", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(10.2, function()
								v100({ "firearms" }, "casing_light", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(11, function()
								v100({ "movement_sounds" }, "step2", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(12, function()
								v100({ "movement_sounds" }, "step1", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(13, function()
								v100({ "movement_sounds" }, "step4", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(14, function()
								v100({ "world_item" }, "ration_pickup", p96[1].hoverpart, nil, true, false, true);
							end);
						elseif p96[2] == "base" then
							delay(0.5, function()
								v100({ "general" }, "writing", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(1, function()
								v100({ "movement_sounds" }, "step1", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(2, function()
								v100({ "movement_sounds" }, "step2", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(3, function()
								v100({ "movement_sounds" }, "step1", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(4, function()
								v100({ "movement_sounds" }, "step2", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(5, function()
								v100({ "movement_sounds" }, "step1", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(6, function()
								v100({ "movement_sounds" }, "step4", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(4, function()
								v100({ "AGENT" }, "blip", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(5, function()
								v100({ "AGENT" }, "bliptwo", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(7, function()
								v100({ "echo_specific" }, "glass", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(8, function()
								v100({ "weapons", "PST" }, "draw", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(8.5, function()
								v100({ "weapons", "PST" }, "M1911A1", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(8.7, function()
								v100({ "firearms" }, "crack", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9.5, function()
								v100({ "firearms" }, "casing_light", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9, function()
								v100({ "weapons", "SMG" }, "draw", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9.2, function()
								v100({ "weapons", "PST" }, "M1911A1", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9.4, function()
								v100({ "firearms" }, "crack", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(10.2, function()
								v100({ "firearms" }, "casing_light", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9.5, function()
								v100({ "weapons", "2HPST" }, "A.J.M. 9", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9.7, function()
								v100({ "hitsound", "guns" }, "bullet_impact1", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(10.5, function()
								v100({ "firearms" }, "casing_light", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9.554, function()
								v100({ "weapons", "2HPST" }, "A.J.M. 9", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9.754, function()
								v100({ "hitsound", "guns" }, "bullet_impact2", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(10.8, function()
								v100({ "firearms" }, "casing_light", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9.608, function()
								v100({ "weapons", "2HPST" }, "A.J.M. 9", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9.808, function()
								v100({ "hitsound", "guns" }, "bullet_impact3", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(11, function()
								v100({ "firearms" }, "casing_light", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(13, function()
								v100({ "world_item" }, "ration_pickup", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(13.5, function()
								v100({ "echo_specific" }, "running", p96[1].hoverpart, nil, true, false, true);
							end);
						elseif p96[2] == "tower" then
							delay(0.5, function()
								v100({ "weapons", "Fists" }, "swingvar2", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(0.6, function()
								v100({ "hitsound", "melee" }, "fists", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(1.1, function()
								v100({ "weapons", "Fists" }, "swingvar1", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(1.2, function()
								v100({ "hitsound", "melee" }, "fists", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(2, function()
								v100({ "general" }, "shove", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(2.1, function()
								v100({ "general" }, "shove_landed", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(2.4, function()
								v100({ "echo_specific" }, "fall", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(2.8, function()
								v100({ "general" }, "falldamage1", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(2.8, function()
								v100({ "echo_specific" }, "rope", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(2.8, function()
								v100({ "echo_specific" }, "bone", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(6, function()
								v100({ "movement_sounds" }, "step1", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(7, function()
								v100({ "movement_sounds" }, "step2", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(8, function()
								v100({ "movement_sounds" }, "step1", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9, function()
								v100({ "movement_sounds" }, "step4", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(10, function()
								v100({ "movement_sounds" }, "step2", p96[1].hoverpart, nil, true, false, true);
							end);
						elseif p96[2] == "castle" then
							delay(0.5, function()
								v100({ "harvesting" }, "stonebreak", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(1.5, function()
								v100({ "harvesting" }, "stonebreak", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(1, function()
								v100({ "movement_sounds" }, "step1", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(2, function()
								v100({ "movement_sounds" }, "step2", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(3, function()
								v100({ "movement_sounds" }, "step1", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(2.5, function()
								v100({ "harvesting" }, "stonebreak", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(2.6, function()
								v100({ "echo_specific" }, "wall2", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(2.7, function()
								v100({ "echo_specific" }, "wall", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(3, function()
								v100({ "ai" }, "ai_sprint", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(2.9, function()
								v100({ "shadow" }, "skinner_noise5", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(3.5, function()
								v100({ "weapons", "PST" }, "M1911A1", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(4, function()
								v100({ "weapons", "PST" }, "M1911A1", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(4.1, function()
								v100({ "firearms" }, "empty", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(4.4, function()
								v100({ "deaths" }, "cut_tear", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(4.45, function()
								v100({ "deaths" }, "flesh", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(3.5, function()
								v100({ "echo_specific" }, "running", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(4.8, function()
								v100({ "general" }, "blockraise", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(5.3, function()
								v100({ "hitsound", "general" }, "hitblocked", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(6.7, function()
								v100({ "hitsound", "general" }, "hitblocked", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(6.8, function()
								v100({ "weapons", "2H" }, "swingvar1", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(6.9, function()
								v100({ "deaths" }, "headbonk", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(4.5, function()
								v100({ "reloads" }, "rifle_mid", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(5, function()
								v100({ "general" }, "reloaddone", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(6.3, function()
								v100({ "weapons", "ASMG" }, "AK-74", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(6.392, function()
								v100({ "weapons", "ASMG" }, "AK-74", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(6.484, function()
								v100({ "weapons", "ASMG" }, "AK-74", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(6.576, function()
								v100({ "weapons", "ASMG" }, "AK-74", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(6.668, function()
								v100({ "weapons", "ASMG" }, "AK-74", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(6.76, function()
								v100({ "weapons", "ASMG" }, "AK-74", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(6.852, function()
								v100({ "weapons", "ASMG" }, "AK-74", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(6.944, function()
								v100({ "weapons", "ASMG" }, "AK-74", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(7.036, function()
								v100({ "weapons", "ASMG" }, "AK-74", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(7.1, function()
								v100({ "firearms" }, "empty", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(7.5, function()
								v100({ "firearms" }, "click", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(7.8, function()
								v100({ "firearms" }, "click", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(8.1, function()
								v100({ "firearms" }, "click", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(7.3, function()
								v100({ "shadow" }, "skinner_noise2", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9, function()
								v100({ "ai" }, "ai_sprint", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(8.8, function()
								v100({ "weapons", "1HBL" }, "chargeswing", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9, function()
								v100({ "deaths" }, "neck", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9, function()
								v100({ "hitsound", "general" }, "hitblocked", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(9.5, function()
								v100({ "hitsound", "extras" }, "grapple2", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(10.3, function()
								v100({ "hitsound", "general" }, "hitbackstab", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(10.3, function()
								v100({ "deaths" }, "slash", p96[1].hoverpart, nil, true, false, true);
							end);
							delay(11, function()
								v100({ "shadow" }, "skinner_noise4", p96[1].hoverpart, nil, true, false, true);
							end);
						end;
						local v745 = tick();
						while true do
							RS:wait();
							if not (15 <= tick() - v745) then

							else
								break;
							end;						
						end;
						agent_speak("echo_end");
						local v746, v747, v748 = ipairs(v738:GetChildren());
						while true do
							local v749, v750 = v746(v747, v748);
							if v749 then

							else
								break;
							end;
							v748 = v749;
							if v750:FindFirstChild("torso") then
								local v751 = l__game__7.ReplicatedStorage.effects.echoball:Clone();
								l__Debris__26:AddItem(v751, 10);
								v751.Material = Enum.Material.Neon;
								v751.CFrame = v750.torso.CFrame;
								v751.fx.Enabled = false;
								v751.Parent = l__CurrentCamera__1;
								v751.flash:Emit(math.random(10, 20));
								spawn(function()
									while true do
										v751.Size = v751.Size + Vector3.new(0.5, 0.5, 0.5);
										v751.Transparency = v751.Transparency + 0.1;
										RS:wait();
										if not (1 <= v751.Transparency) then

										else
											break;
										end;									
									end;
								end);
							end;						
						end;
						v738:Destroy();
						v100({ "general_ui" }, "echo_close", p96[1].hoverpart, 0.01, true, false);
						current_in_echo = false;
					end;
				end;
			elseif p94 == "scanarea" then
				if p96[1] ~= nil then
					local l__activestats__752 = v18.scan.activestats;
					local v753 = l__game__7.ReplicatedStorage.effects.scanball:Clone();
					l__Debris__26:AddItem(v753, 20);
					v753.CFrame = p96[1];
					v753.Parent = l__CurrentCamera__1;
					if p95 == character then
						spawn(function()
							local v754 = tick();
							maingui.PerkFrame.durationbar.Visible = true;
							maingui.PerkFrame.durationbar.fill.Size = UDim2.new(1, 0, 1, 0);
							while true do
								maingui.PerkFrame.durationbar.fill.Size = UDim2.new(1 - math.clamp((tick() - v754) / l__activestats__752.scanlast, 0, 1), 0, 1, 0);
								RS:wait();
								if not (l__activestats__752.scanlast <= tick() - v754) then

								else
									break;
								end;							
							end;
							maingui.PerkFrame.durationbar.Visible = false;
						end);
					end;
					spawn(function()
						local v755, v756, v757 = ipairs(l__workspace__1.Interactables:GetChildren());
						while true do
							local v758, v759 = v755(v756, v757);
							if v758 then

							else
								break;
							end;
							if v759:FindFirstChild("Interact") then
								if (v759.Interact.Position - p96[1].p).magnitude <= l__activestats__752.studsscan then
									if v759.Name ~= "Heavy Ammo" then
										if v759.Name ~= "Shells Ammo" then
											if v759.Name ~= "Light Ammo" then
												if v759.Name ~= "Long Ammo" then
													if v759.Name ~= "Short Ammo" then
														if v759.Name ~= "Medium Ammo" then
															if v759.Name == "Small Ammo" then
																u98(v759.Interact, false, l__activestats__752.scanlast);
															else
																u98(v759.Interact, false, l__activestats__752.scanlast);
															end;
														else
															u98(v759.Interact, false, l__activestats__752.scanlast);
														end;
													else
														u98(v759.Interact, false, l__activestats__752.scanlast);
													end;
												else
													u98(v759.Interact, false, l__activestats__752.scanlast);
												end;
											else
												u98(v759.Interact, false, l__activestats__752.scanlast);
											end;
										else
											u98(v759.Interact, false, l__activestats__752.scanlast);
										end;
									else
										u98(v759.Interact, false, l__activestats__752.scanlast);
									end;
								end;
							end;
							if v759:FindFirstChild("HarvestWood") then
								if (v759.HarvestWood.Position - p96[1].p).magnitude <= l__activestats__752.studsscan then
									u98(v759.HarvestWood, false, l__activestats__752.scanlast);
								end;
							end;
							if v759:FindFirstChild("HarvestStone") then
								if (v759.HarvestStone.Position - p96[1].p).magnitude <= l__activestats__752.studsscan then
									u98(v759.HarvestStone, false, l__activestats__752.scanlast);
								end;
							end;						
						end;
						local v760, v761, v762 = ipairs(l__workspace__1.WeaponDrops:GetChildren());
						while true do
							local v763, v764 = v760(v761, v762);
							if v763 then

							else
								break;
							end;
							v762 = v763;
							if v764:FindFirstChild("JointGrip") then
								if (v764.JointGrip.Position - p96[1].p).magnitude <= l__activestats__752.studsscan then
									u98(v764.JointGrip, false, l__activestats__752.scanlast);
								end;
							end;						
						end;
						local v765, v766, v767 = ipairs(l__workspace__1.activeHostiles:GetChildren());
						while true do
							local v768, v769 = v765(v766, v767);
							if v768 then

							else
								break;
							end;
							v767 = v768;
							if v769:FindFirstChild("Torso") then
								if v769:FindFirstChild("Head") then
									if v769:FindFirstChild("Humanoid") then
										if 0 <= v769.Humanoid.Health then
											if (v769.Torso.Position - p96[1].p).magnitude <= l__activestats__752.studsscan then
												local v770 = l__game__7.ReplicatedStorage.effects.health_scanned:Clone();
												l__Debris__26:AddItem(v770, l__activestats__752.scanlast);
												v770.Adornee = v769.Torso;
												v770.Parent = ply.PlayerGui;
												v770.update_health.Disabled = false;
											end;
										end;
									end;
								end;
							end;						
						end;
					end);
					spawn(function()
						while true do
							v753.Size = v753.Size + Vector3.new(2, 2, 2);
							v753.Transparency = v753.Transparency + 0.025;
							RS:wait();
							if not (1 <= v753.Transparency) then

							else
								break;
							end;						
						end;
						delay(3, function()
							v753.fx.Enabled = false;
						end);
					end);
				end;
			elseif p94 == "player_ping" then
				if p96[1] ~= nil then
					if l__workspace__1.NoTarget:FindFirstChild(p96[2] .. "PING_CAT" .. p96[3]) then
						l__workspace__1.NoTarget:FindFirstChild(p96[2] .. "PING_CAT" .. p96[3]):Destroy();
					end;
					local v771 = l__game__7.ReplicatedStorage.misc.ping_indicator:Clone();
					v771.Name = p96[2] .. "PING_CAT" .. p96[3];
					l__Debris__26:AddItem(v771, 20);
					v771.CFrame = CFrame.new(p96[1]);
					v771.bb.pinger.Text = p96[2];
					v771.Parent = l__workspace__1.NoTarget;
					local v772 = v771.bb:FindFirstChild("ping_cat" .. p96[3]);
					if v772 then
						v772.Visible = true;
						local v773 = v772:Clone();
						v773.Parent = v771.bb;
						spawn(function()
							while true do
								if v773 then
									if v772 then
										v773.Size = v773.Size + UDim2.new(0, 2, 0, 2);
										v773.ImageTransparency = v773.ImageTransparency + 0.05;
									end;
								end;
								RS:wait();
								if not (1 <= v773.ImageTransparency) then

								else
									break;
								end;
								if v772 ~= nil then

								else
									break;
								end;							
							end;
							v773:Destroy();
						end);
					end;
					local v774 = "ping_area";
					if p96[3] == 2 then
						v774 = "ping_enemy";
					elseif p96[3] == 3 then
						v774 = "ping_item";
					end;
					v100({ "general_ui" }, v774, nil, nil, true, true);
					local v775 = maingui.teammatesframe:FindFirstChild(p96[2]);
					if v775 then
						if v775:FindFirstChild("empty") then
							local v776 = "[Moving Here]";
							local v777 = Color3.fromRGB(255, 182, 122);
							if p96[3] == 3 then
								v777 = Color3.fromRGB(122, 232, 92);
								v776 = "[Marked " .. p96[4] .. "]";
							elseif p96[3] == 2 then
								v777 = Color3.fromRGB(216, 60, 60);
								v776 = "[Hostile]";
							elseif p96[3] == 4 then
								v777 = Color3.fromRGB(102, 137, 255);
								v776 = "[Located " .. p96[4] .. "]";
							elseif p96[3] == 5 then
								v777 = Color3.fromRGB(183, 89, 255);
								v776 = "[" .. p96[4] .. "]";
							end;
							local v778 = l__game__7.ReplicatedStorage.misc.ping_text:Clone();
							l__Debris__26:AddItem(v778, 6);
							v778.TextColor3 = v777;
							v778.Text = v776;
							v778.bg.ImageColor3 = v777;
							if v775:FindFirstChild("empty"):FindFirstChild("ping_text") then
								v775:FindFirstChild("empty"):FindFirstChild("ping_text"):Destroy();
							end;
							v778.Parent = v775:FindFirstChild("empty");
							spawn(function()
								while true do
									if v778 then
										if v778:FindFirstChild("bg") then
											v778.bg.ImageTransparency = v778.bg.ImageTransparency + 0.05;
											v778.bg.Size = v778.bg.Size + UDim2.new(0, 2, 0, 0);
										end;
									end;
									RS:wait();
									if v778 ~= nil then

									else
										break;
									end;
									if v778:FindFirstChild("bg") ~= nil then

									else
										break;
									end;
									if not (1 <= v778.bg.ImageTransparency) then

									else
										break;
									end;								
								end;
							end);
						end;
					end;
				end;
			elseif p94 == "selfscan" then
				local l__activestats__101 = v18.scan.activestats;
				spawn(function()
					local v779, v780, v781 = ipairs(l__workspace__1.Interactables:GetChildren());
					while true do
						local v782, v783 = v779(v780, v781);
						if v782 then

						else
							break;
						end;
						if v783:FindFirstChild("Interact") then
							if (v783.Interact.Position - character.HumanoidRootPart.Position).magnitude <= l__activestats__101.scan_around then
								if v783.Name ~= "Heavy Ammo" then
									if v783.Name ~= "Shells Ammo" then
										if v783.Name ~= "Light Ammo" then
											if v783.Name ~= "Long Ammo" then
												if v783.Name ~= "Short Ammo" then
													if v783.Name ~= "Medium Ammo" then
														if v783.Name == "Small Ammo" then
															u98(v783.Interact, true, l__activestats__101.scan_around_timer);
														else
															u98(v783.Interact, true, l__activestats__101.scan_around_timer);
														end;
													else
														u98(v783.Interact, true, l__activestats__101.scan_around_timer);
													end;
												else
													u98(v783.Interact, true, l__activestats__101.scan_around_timer);
												end;
											else
												u98(v783.Interact, true, l__activestats__101.scan_around_timer);
											end;
										else
											u98(v783.Interact, true, l__activestats__101.scan_around_timer);
										end;
									else
										u98(v783.Interact, true, l__activestats__101.scan_around_timer);
									end;
								else
									u98(v783.Interact, true, l__activestats__101.scan_around_timer);
								end;
							end;
						end;
						if v783:FindFirstChild("HarvestWood") then
							if (v783.HarvestWood.Position - character.HumanoidRootPart.Position).magnitude <= l__activestats__101.scan_around then
								u98(v783.HarvestWood, true, l__activestats__101.scan_around_timer);
							end;
						end;
						if v783:FindFirstChild("HarvestStone") then
							if (v783.HarvestStone.Position - character.HumanoidRootPart.Position).magnitude <= l__activestats__101.scan_around then
								u98(v783.HarvestStone, true, l__activestats__101.scan_around_timer);
							end;
						end;					
					end;
					local v784, v785, v786 = ipairs(l__workspace__1.WeaponDrops:GetChildren());
					while true do
						local v787, v788 = v784(v785, v786);
						if v787 then

						else
							break;
						end;
						v786 = v787;
						if v788:FindFirstChild("JointGrip") then
							if (v788.JointGrip.Position - character.HumanoidRootPart.Position).magnitude <= l__activestats__101.scan_around then
								u98(v788.JointGrip, true, l__activestats__101.scan_around_timer);
							end;
						end;					
					end;
				end);
			elseif p94 == "tased" then
				local v789 = createfxoutline("tasedParticle", 1.7);
			elseif p94 == "decap" then
				if p95:FindFirstChild("Head") == nil then
					return;
				end;
				local l__Head__790 = p95.Head;
				local v791 = l__game__7.ReplicatedStorage.effects.gFX.decap.decapstump:Clone();
				v791.CFrame = p95.Torso.CFrame;
				local v792 = Instance.new("Weld");
				v792.Part0 = v791;
				v792.Part1 = p95.Torso;
				v792.C1 = CFrame.new(0, 1, 0);
				v792.Parent = v791;
				v791.Parent = p95;
				local v793 = l__game__7.ReplicatedStorage.effects.gFX.decap.decapblock:Clone();
				local v794 = Instance.new("Weld");
				v794.Part0 = v793;
				v794.Part1 = l__Head__790;
				v794.Parent = v793;
				v794.Parent = p95;
				v793.Parent = p95;
				l__Head__790.CFrame = l__Head__790.CFrame * CFrame.new(0, 0.2, 0);
				RS:wait();
				l__Head__790.Velocity = l__Head__790.Velocity + Vector3.new(math.random(-3, 3), 20, math.random(-3, 3));
			elseif p94 == "crush" then
				local v795, v796, v797 = ipairs(p95:GetChildren());
				while true do
					local v798, v799 = v795(v796, v797);
					if v798 then

					else
						break;
					end;
					v797 = v798;
					if v799:IsA("Accessory") then
						v799:Destroy();
					end;				
				end;
				local v800, v801, v802 = ipairs(p95.Head:GetChildren());
				while true do
					local v803, v804 = v800(v801, v802);
					if v803 then

					else
						break;
					end;
					v802 = v803;
					if v804:IsA("Decal") then
						v804:Destroy();
					end;				
				end;
				if p95:FindFirstChild("Outfit") then
					if p95:FindFirstChild("Outfit"):FindFirstChild("Head") then
						local v805, v806, v807 = ipairs(p95:FindFirstChild("Outfit"):GetChildren());
						while true do
							local v808, v809 = v805(v806, v807);
							if v808 then

							else
								break;
							end;
							v807 = v808;
							if v809.Name == "Head" then
								v809:Destroy();
							end;						
						end;
					end;
				end;
				local l__Head__810 = p95.Head;
				local v811 = l__game__7.ReplicatedStorage.effects.gFX.crush.splat:Clone();
				l__Debris__26:AddItem(v811, 9);
				v811.CFrame = p95.Head.CFrame;
				v811.fx1:Emit(math.random(5, 10));
				v811.fx2:Emit(math.random(3, 5));
				v811.Parent = l__workspace__1.NoTarget;
				local v812 = l__game__7.ReplicatedStorage.effects.gFX.crush.bonestump:Clone();
				v812.CFrame = p95.Torso.CFrame;
				local v813 = Instance.new("Weld");
				v813.Part0 = v812;
				v813.Part1 = p95.Torso;
				v813.C1 = CFrame.new(0, 1, 0);
				v813.Parent = v812;
				v812.Parent = p95;
				p95.Head:Destroy();
				local v814 = { "gib", "bone" };
				local v815 = math.random(8, 15);
				local v816 = 1 - 1;
				while true do
					local v817 = l__game__7.ReplicatedStorage.effects.gFX.crush[v814[math.random(1, 2)]]:Clone();
					l__Debris__26:AddItem(v817, 7);
					v817.CFrame = l__Head__810.CFrame * CFrame.new(math.random(-15, 10) / 100, math.random(-15, 10) / 100, math.random(-15, 10) / 100);
					v817.Parent = l__workspace__1.NoTarget;
					v817.Velocity = v817.Velocity + Vector3.new(math.random(-6, 6), math.random(5, 15), math.random(-6, 6));
					if 0 <= 1 then
						if v816 < v815 then

						else
							break;
						end;
					elseif v815 < v816 then

					else
						break;
					end;
					v816 = v816 + 1;				
				end;
			elseif p94 == "arrowimpact" then
				local v818 = l__game__7.ReplicatedStorage.effects.gFX.arrowdeath.arrowimpact:Clone();
				v818.CFrame = p95.Head.CFrame;
				local v819 = Instance.new("Weld");
				v819.Part0 = v818;
				v819.Part1 = p95.Head;
				v819.Parent = v818;
				v818.Parent = p95;
				v818.gorepoint.bleedpoint1.splat.Enabled = true;
				v818.gorepoint.bleedpoint2.splat.Enabled = true;
				v818.gorepoint.bleedpoint1.splat:Emit(30, 50);
				v818.gorepoint.bleedpoint2.splat:Emit(30, 50);
				v818.gorepoint.bleedpoint1.splat.Enabled = false;
				v818.gorepoint.bleedpoint2.splat.Enabled = false;
			elseif p94 == "headshot_gun" then
				local v820 = l__game__7.ReplicatedStorage.effects.gFX.headshotdeath.headshotimpact:Clone();
				v820.CFrame = p95.Head.CFrame;
				local v821 = Instance.new("Weld");
				v821.Part0 = v820;
				v821.Part1 = p95.Head;
				v821.Parent = v820;
				v820.Parent = p95;
				v820.gorepoint.bleedpoint1.splat.Enabled = true;
				v820.gorepoint.bleedpoint1.cloud.Enabled = true;
				v820.gorepoint.bleedpoint2.splat.Enabled = true;
				v820.gorepoint.bleedpoint1.cloud:Emit(1, 3);
				v820.gorepoint.bleedpoint1.splat:Emit(30, 50);
				v820.gorepoint.bleedpoint2.splat:Emit(30, 50);
				v820.gorepoint.bleedpoint1.splat.Enabled = false;
				v820.gorepoint.bleedpoint1.cloud.Enabled = false;
				v820.gorepoint.bleedpoint2.splat.Enabled = false;
				v100({ "deaths" }, "headshot" .. math.random(1, 2), p95.Head, nil, true, false);
				v100({ "deaths" }, "decap", p95.Head, nil, true, false);
				if p96 ~= nil then
					if p96 == "self" then
						v820.gorepoint.Transparency = 1;
						v820.gorepoint.bleedpoint1.drip.Enabled = false;
						v820.gorepoint.bleedpoint2.drip.Enabled = false;
					end;
				end;
			elseif p94 ~= "head_bonk" then
				if p94 == "axe_embed" then
					local v822 = l__game__7.ReplicatedStorage.effects.gFX.blunthead.headbonk:Clone();
					v822.CFrame = p95.Head.CFrame;
					local v823 = Instance.new("Weld");
					v823.Part0 = v822;
					v823.Part1 = p95.Head;
					v823.Parent = v822;
					v822.Parent = p95;
					RS:wait();
					v822.gorepoint.bleedpoint1.splat.Enabled = true;
					v822.gorepoint.bleedpoint1.cloud.Enabled = true;
					v822.gorepoint.bleedpoint1.cloud:Emit(1, 3);
					v822.gorepoint.bleedpoint1.splat:Emit(15, 30);
					v822.gorepoint.bleedpoint1.splat.Enabled = false;
					v822.gorepoint.bleedpoint1.cloud.Enabled = false;
					if p94 == "head_bonk" then
						v100({ "deaths" }, "headbonk", p95.Head, nil, true, false);
					else
						local v824 = l__game__7.ReplicatedStorage.effects.gFX.axe_head.axed:Clone();
						v824.CFrame = p95.Head.CFrame;
						local v825 = Instance.new("Weld");
						v825.Part0 = v824;
						v825.Part1 = p95.Head;
						v825.Parent = v824;
						v824.Parent = p95;
						v100({ "deaths" }, "tear", p95.Head, nil, true, false);
						v100({ "deaths" }, "axe_hit", p95.Head, nil, true, false);
					end;
				elseif p94 ~= "take_limbs_arms" then
					if p94 == "take_limbs_legs" then
						local v826 = l__game__7.ReplicatedStorage.effects.gFX.limbremove.torsopart:Clone();
						v826.CFrame = p95.Torso.CFrame;
						local v827 = Instance.new("Weld");
						v827.Part0 = v826;
						v827.Part1 = p95.Torso;
						v827.Parent = v826;
						local v828 = "Left Arm";
						if math.random(1, 2) == 1 then
							v828 = "Right Arm";
						end;
						if p94 == "take_limbs_legs" then
							v828 = "Left Leg";
							if math.random(1, 2) == 1 then
								v828 = "Right Leg";
							end;
						end;
						local v829, v830, v831 = ipairs(v826:GetChildren());
						while true do
							local v832, v833 = v829(v830, v831);
							if v832 then

							else
								break;
							end;
							v831 = v832;
							if v833:IsA("BasePart") then
								if v833.Name ~= v828 then
									v833:Destroy();
								end;
							end;						
						end;
						v826.Parent = p95;
						if p95:FindFirstChild(v828) then
							p95:FindFirstChild(v828):Destroy();
						end;
						if p95:FindFirstChild("Outfit") then
							if p94 == "take_limbs_legs" then
								if p95.Outfit:FindFirstChild("Bottom") then
									if p95.Outfit.Bottom:FindFirstChild(v828) then
										p95.Outfit.Bottom:FindFirstChild(v828):Destroy();
									end;
								end;
							elseif p95.Outfit:FindFirstChild("Top") then
								if p95.Outfit.Top:FindFirstChild(v828) then
									p95.Outfit.Top:FindFirstChild(v828):Destroy();
								end;
							end;
						end;
						v100({ "deaths" }, "flesh", p95.Torso, nil, true, false);
						v100({ "deaths" }, "gurgle", p95.Torso, nil, true, false);
						v826:FindFirstChild(v828).attach.cloud.Enabled = true;
						v826:FindFirstChild(v828).attach.gib.Enabled = true;
						v826:FindFirstChild(v828).attach.cloud:Emit(math.random(1, 3));
						v826:FindFirstChild(v828).attach.gib:Emit(math.random(3, 7));
						v826:FindFirstChild(v828).attach.cloud.Enabled = false;
						v826:FindFirstChild(v828).attach.gib.Enabled = false;
					elseif p94 == "torso_cut" then
						local v834 = l__game__7.ReplicatedStorage.effects.gFX.torsocut.Torso:Clone();
						v834.CFrame = p95.Torso.CFrame;
						local v835 = Instance.new("Weld");
						v835.Part0 = v834;
						v835.Part1 = p95.Torso;
						v835.Parent = v834;
						v834.Parent = p95.Torso;
					elseif p94 == "pukedeath" then
						v100({ "deaths" }, "gurgle", p95.Head, nil, true, false);
						delay(0.5, function()
							v100({ "deaths" }, "puke", p95.Head, nil, true, false);
							local v836 = l__game__7.ReplicatedStorage.effects.gFX.pukedeath.puke:Clone();
							v836.CFrame = p95.Head.CFrame;
							local v837 = Instance.new("Weld");
							v837.Part0 = v836;
							v837.Part1 = p95.Head;
							v837.Parent = v836;
							v836.Parent = p95;
							v836.pukepoint.splat.Enabled = true;
							v836.pukepoint.splat2.Enabled = true;
							v836.pukepoint.splat:Emit(math.random(10, 20));
							v836.pukepoint.splat2:Emit(math.random(10, 20));
							RS:wait();
							v836.pukepoint.splat.Enabled = false;
							v836.pukepoint.splat2.Enabled = false;
						end);
					elseif p94 == "stomachrip" then
						local v838 = l__game__7.ReplicatedStorage.effects.gFX.spearstomach.torsoFX:Clone();
						v838.CFrame = p95.Torso.CFrame;
						local v839 = Instance.new("Weld");
						v839.Part0 = v838;
						v839.Part1 = p95.Torso;
						v839.Parent = v838;
						v838.Parent = p95;
						v838.fxpart.splat:Emit(30, 50);
						v838.fxpart.splat2:Emit(15, 30);
						local v840 = math.random(6, 10);
						local v841 = 1 - 1;
						while true do
							local v842 = l__game__7.ReplicatedStorage.effects.gFX.spearstomach.gib:Clone();
							l__Debris__26:AddItem(v842, 7);
							v842.CFrame = p95.Torso.CFrame * CFrame.new(math.random(-15, 10) / 100, math.random(-15, 10) / 100, math.random(-15, 10) / 100);
							v842.Parent = l__workspace__1.NoTarget;
							v842.Velocity = v842.Velocity + p95.Torso.CFrame.lookVector * 3;
							if 0 <= 1 then
								if v841 < v840 then

								else
									break;
								end;
							elseif v840 < v841 then

							else
								break;
							end;
							v841 = v841 + 1;						
						end;
					elseif p94 == "neckcut" then
						local v843 = l__game__7.ReplicatedStorage.effects.gFX.neckcut.fx:Clone();
						l__Debris__26:AddItem(v843, 9);
						v843.CFrame = p95.Torso.CFrame;
						local v844 = Instance.new("Weld");
						v844.Part0 = v843;
						v844.Part1 = p95.Torso;
						v844.Parent = v843;
						v844.Parent = p95;
						v843.Parent = p95;
						delay(2, function()
							v843.point.drip.Enabled = false;
							v843.point.fx1.Enabled = false;
						end);
						v843.point.fx2:Emit(1);
						v843.point.gib:Emit(math.random(2, 5));
						local v845 = l__game__7.ReplicatedStorage.effects.gFX.neckcut.neckpart:Clone();
						l__Debris__26:AddItem(v845, 7);
						v845.CFrame = p95.Head.CFrame + p95.Head.CFrame.lookVector * 1;
						v845.Parent = l__workspace__1.NoTarget;
						v845.Velocity = v845.Velocity + p95.Head.CFrame.lookVector * 3;
					elseif p94 == "explosive" then
						local l__HumanoidRootPart__846 = p95:FindFirstChild("HumanoidRootPart");
						if l__HumanoidRootPart__846 then

						else
							return;
						end;
						local v847, v848, v849 = ipairs(p95:GetChildren());
						while true do
							local v850, v851 = v847(v848, v849);
							if v850 then

							else
								break;
							end;
							v849 = v850;
							if v851.Name ~= "Torso" then
								if v851.Name ~= "Humanoid" then
									if v851.Name ~= "active" then
										v851:Destroy();
									elseif v851:IsA("BasePart") then
										v851.Transparency = 1;
										local v852, v853, v854 = ipairs(v851:GetChildren());
										while true do
											local v855, v856 = v852(v853, v854);
											if v855 then

											else
												break;
											end;
											v854 = v855;
											if v856:IsA("Decal") then
												v856:Destroy();
											end;										
										end;
									end;
								elseif v851:IsA("BasePart") then
									v851.Transparency = 1;
									v852, v853, v854 = ipairs(v851:GetChildren());
									while true do
										v855, v856 = v852(v853, v854);
										if v855 then

										else
											break;
										end;
										v854 = v855;
										if v856:IsA("Decal") then
											v856:Destroy();
										end;									
									end;
								end;
							elseif v851:IsA("BasePart") then
								v851.Transparency = 1;
								v852, v853, v854 = ipairs(v851:GetChildren());
								while true do
									v855, v856 = v852(v853, v854);
									if v855 then

									else
										break;
									end;
									v854 = v855;
									if v856:IsA("Decal") then
										v856:Destroy();
									end;								
								end;
							end;						
						end;
						if p95:FindFirstChild("Torso") then
							p95:FindFirstChild("Torso").Anchored = true;
							p95:FindFirstChild("Torso").Transparency = 1;
						end;
						local v857 = l__game__7.ReplicatedStorage.effects.gFX.explosion.explosiongib:Clone();
						l__Debris__26:AddItem(v857, 10);
						v857.CFrame = CFrame.new(l__HumanoidRootPart__846.Position) * CFrame.new(0, 1, 0);
						v857.Parent = l__workspace__1.NoTarget;
						v857.cloud:Emit(math.random(5, 8));
						v857.dust:Emit(math.random(5, 8));
						v857.expandcloud:Emit(math.random(5, 8));
						v857.gib:Emit(math.random(8, 12));
						local v858 = math.random(8, 12);
						local v859 = 1 - 1;
						while true do
							local v860 = l__game__7.ReplicatedStorage.effects.gFX.crush.gib:Clone();
							l__Debris__26:AddItem(v860, 7);
							v860.CFrame = v857.CFrame * CFrame.new(math.random(-15, 10) / 100, math.random(-15, 10) / 100, math.random(-15, 10) / 100);
							v860.Parent = l__workspace__1.NoTarget;
							v860.Velocity = v860.Velocity + Vector3.new(math.random(-12, 12), math.random(15, 20), math.random(-12, 12));
							if 0 <= 1 then
								if v859 < v858 then

								else
									break;
								end;
							elseif v858 < v859 then

							else
								break;
							end;
							v859 = v859 + 1;						
						end;
					elseif p94 == "armcut" then
						local v861 = l__game__7.ReplicatedStorage.effects.gFX.armcut.torsocopy:Clone();
						local v862 = l__game__7.ReplicatedStorage.effects.gFX.armcut.cutarm:Clone();
						v861.beam.Attachment0 = v861.a0;
						v861.beam.Attachment1 = v862.a1;
						local v863 = Instance.new("Weld");
						v863.Part0 = v861;
						v863.Part1 = p95.Torso;
						v863.Parent = v861;
						v861.Parent = p95;
						v862.CFrame = p95["Left Arm"].CFrame;
						local v864 = Instance.new("Weld");
						v864.Part0 = v862;
						v864.Part1 = p95["Left Arm"];
						v864.Parent = v862;
						v862.Parent = p95["Left Arm"];
						p95["Left Arm"].Velocity = p95["Left Arm"].Velocity + -p95.Torso.CFrame.rightVector * 5;
						delay(0.5, function()
							local v865 = 1 - 1;
							while true do
								local v866 = 1.5 * (1 - v865 / 15);
								v861.beam.Width0 = v866;
								v861.beam.Width1 = v866;
								RS:wait();
								if 0 <= 1 then
									if v865 < 15 then

									else
										break;
									end;
								elseif 15 < v865 then

								else
									break;
								end;
								v865 = v865 + 1;							
							end;
							v861.beam:Destroy();
						end);
					elseif p94 == "slice" then
						local v867, v868, v869 = ipairs(p95.Torso:GetChildren());
						while true do
							local v870, v871 = v867(v868, v869);
							if v870 then

							else
								break;
							end;
							v869 = v870;
							if v871:IsA("Decal") then
								v871:Destroy();
							end;						
						end;
						local l__Shirt__872 = p95:FindFirstChild("Shirt");
						if l__Shirt__872 == nil then
							local l__Pants__873 = p95:FindFirstChild("Pants");
							if l__Pants__873 == nil then
								local v874 = "";
							else
								v874 = l__Pants__873.PantsTemplate;
							end;
						else
							v874 = l__Shirt__872.ShirtTemplate;
						end;
						local v875 = l__game__7.ReplicatedStorage.effects.gFX.slice.slicehalf:Clone();
						v875.BrickColor = p95.Torso.BrickColor;
						v875.TextureID = v874;
						v875.CFrame = p95.Torso.CFrame;
						local v876 = Instance.new("Weld");
						v876.Part0 = v875;
						v876.Part1 = p95.Torso;
						v876.C1 = CFrame.new(0.6, 0, 0);
						v876.Parent = v875;
						v875.Parent = p95;
						p95.Torso.Transparency = 1;
						local v877 = l__game__7.ReplicatedStorage.effects.gFX.slice.otherslicehalf:Clone();
						local l__Shirt__878 = p95:FindFirstChild("Shirt");
						if l__Shirt__878 then
							l__Shirt__878:Clone().Parent = v877;
						end;
						local l__Pants__879 = p95:FindFirstChild("Pants");
						if l__Pants__879 then
							l__Pants__879:Clone().Parent = v877;
						end;
						local v880, v881, v882 = ipairs(v877:GetChildren());
						while true do
							local v883, v884 = v880(v881, v882);
							if v883 then

							else
								break;
							end;
							v882 = v883;
							if p95:FindFirstChild(v884.Name) then
								if v884:IsA("BasePart") then
									v884.BrickColor = p95:FindFirstChild(v884.Name).BrickColor;
								end;
							end;						
						end;
						v877.Torso.otherhalf.BrickColor = p95.Torso.BrickColor;
						v877.Torso.otherhalf.TextureID = v874;
						v877:SetPrimaryPartCFrame(p95.Torso.CFrame);
						v877.Parent = p95;
						v875.beam1.Attachment1 = v877.Torso.otherhalf.a1;
						v875.beam2.Attachment1 = v877.Torso.otherhalf.b1;
						v875.beam3.Attachment1 = v877.Torso.otherhalf.c1;
						p95["Left Arm"]:Destroy();
						p95["Left Leg"]:Destroy();
						RS:wait();
						v877.Humanoid.PlatformStand = true;
						v877.Torso.Velocity = v877.Torso.Velocity + v877.Torso.CFrame.rightVector * 6;
						if p95.Torso:FindFirstChild("Neck") then
							p95.Torso.Neck.C1 = CFrame.new(-0.341941595, -0.544243574, 0.0124545023, -0.951813221, 0, -0.306678385, -0.301639259, 0.180534005, 0.936173737, 0.0553658754, 0.983568728, -0.171834648);
							p95.Torso.Neck.C0 = CFrame.new(0, 1, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0);
						end;
						delay(0.5, function()
							local v885 = 1 - 1;
							while true do
								local v886 = 1.5 * (1 - v885 / 15);
								v875.beam1.Width0 = v886;
								v875.beam1.Width1 = v886;
								v875.beam2.Width0 = v886;
								v875.beam2.Width1 = v886;
								v875.beam3.Width0 = v886;
								v875.beam3.Width1 = v886;
								RS:wait();
								if 0 <= 1 then
									if v885 < 15 then

									else
										break;
									end;
								elseif 15 < v885 then

								else
									break;
								end;
								v885 = v885 + 1;							
							end;
							v875.beam1:Destroy();
							v875.beam2:Destroy();
							v875.beam3:Destroy();
						end);
					end;
				else
					v826 = l__game__7.ReplicatedStorage.effects.gFX.limbremove.torsopart:Clone();
					v826.CFrame = p95.Torso.CFrame;
					v827 = Instance.new("Weld");
					v827.Part0 = v826;
					v827.Part1 = p95.Torso;
					v827.Parent = v826;
					v828 = "Left Arm";
					if math.random(1, 2) == 1 then
						v828 = "Right Arm";
					end;
					if p94 == "take_limbs_legs" then
						v828 = "Left Leg";
						if math.random(1, 2) == 1 then
							v828 = "Right Leg";
						end;
					end;
					v829, v830, v831 = ipairs(v826:GetChildren());
					while true do
						v832, v833 = v829(v830, v831);
						if v832 then

						else
							break;
						end;
						v831 = v832;
						if v833:IsA("BasePart") then
							if v833.Name ~= v828 then
								v833:Destroy();
							end;
						end;					
					end;
					v826.Parent = p95;
					if p95:FindFirstChild(v828) then
						p95:FindFirstChild(v828):Destroy();
					end;
					if p95:FindFirstChild("Outfit") then
						if p94 == "take_limbs_legs" then
							if p95.Outfit:FindFirstChild("Bottom") then
								if p95.Outfit.Bottom:FindFirstChild(v828) then
									p95.Outfit.Bottom:FindFirstChild(v828):Destroy();
								end;
							end;
						elseif p95.Outfit:FindFirstChild("Top") then
							if p95.Outfit.Top:FindFirstChild(v828) then
								p95.Outfit.Top:FindFirstChild(v828):Destroy();
							end;
						end;
					end;
					v100({ "deaths" }, "flesh", p95.Torso, nil, true, false);
					v100({ "deaths" }, "gurgle", p95.Torso, nil, true, false);
					v826:FindFirstChild(v828).attach.cloud.Enabled = true;
					v826:FindFirstChild(v828).attach.gib.Enabled = true;
					v826:FindFirstChild(v828).attach.cloud:Emit(math.random(1, 3));
					v826:FindFirstChild(v828).attach.gib:Emit(math.random(3, 7));
					v826:FindFirstChild(v828).attach.cloud.Enabled = false;
					v826:FindFirstChild(v828).attach.gib.Enabled = false;
				end;
			else
				v822 = l__game__7.ReplicatedStorage.effects.gFX.blunthead.headbonk:Clone();
				v822.CFrame = p95.Head.CFrame;
				v823 = Instance.new("Weld");
				v823.Part0 = v822;
				v823.Part1 = p95.Head;
				v823.Parent = v822;
				v822.Parent = p95;
				RS:wait();
				v822.gorepoint.bleedpoint1.splat.Enabled = true;
				v822.gorepoint.bleedpoint1.cloud.Enabled = true;
				v822.gorepoint.bleedpoint1.cloud:Emit(1, 3);
				v822.gorepoint.bleedpoint1.splat:Emit(15, 30);
				v822.gorepoint.bleedpoint1.splat.Enabled = false;
				v822.gorepoint.bleedpoint1.cloud.Enabled = false;
				if p94 == "head_bonk" then
					v100({ "deaths" }, "headbonk", p95.Head, nil, true, false);
				else
					v824 = l__game__7.ReplicatedStorage.effects.gFX.axe_head.axed:Clone();
					v824.CFrame = p95.Head.CFrame;
					v825 = Instance.new("Weld");
					v825.Part0 = v824;
					v825.Part1 = p95.Head;
					v825.Parent = v824;
					v824.Parent = p95;
					v100({ "deaths" }, "tear", p95.Head, nil, true, false);
					v100({ "deaths" }, "axe_hit", p95.Head, nil, true, false);
				end;
			end;
		elseif p94 == "firegun" then
			v697 = l__game__7.ReplicatedStorage.effects.gunTrail:Clone();
			l__Debris__26:AddItem(v697, 3);
			v697.trailA.CFrame = CFrame.new(p96[1]);
			v697.trailB.CFrame = CFrame.new(p96[2]);
			v697.Parent = l__workspace__1.NoTarget;
			v698 = l__game__7.ReplicatedStorage.effects.bullet_trail:Clone();
			l__Debris__26:AddItem(v698, 0.2);
			v698.CFrame = CFrame.new(p96[1], p96[2]);
			v698.CFrame = v698.CFrame + v698.CFrame.lookVector * math.random(15, 25);
			if p96[3] == false then
				v698.Parent = l__workspace__1.NoTarget;
				spawn(function()
					RS:wait();
					v698.Velocity = v698.Velocity + v698.CFrame.lookVector * 1000;
				end);
			end;
			if p96[4] == nil then
				if 0.02 < tick() - crackcd then
					v100({ "firearms" }, "crack", v697.trailB, 0.1, true, false);
				end;
				crackcd = tick();
				v697.trailB.debrisA.Enabled = true;
				v697.trailB.debrisB.Enabled = true;
				v697.trailB.smoke.Enabled = true;
				v697.trailB.spark.Enabled = true;
				v697.trailB.debrisA:Emit(math.random(3, 6));
				v697.trailB.debrisB:Emit(math.random(3, 6));
				v697.trailB.smoke:Emit(math.random(2, 4));
				v697.trailB.spark:Emit(math.random(8, 12));
				v697.trailB.debrisA.Enabled = false;
				v697.trailB.debrisB.Enabled = false;
				v697.trailB.smoke.Enabled = false;
				v697.trailB.spark.Enabled = false;
			else
				v100({ "hitsound", "guns" }, "bullet_impact" .. math.random(1, 3), v697.trailB, 0.1, true, false);
			end;
			if p96[5] == nil then
				v699 = l__game__7.ReplicatedStorage.effects.gunFX:Clone();
				l__Debris__26:AddItem(v699, 1);
				v699.CFrame = CFrame.new(p96[1]);
				v699.Parent = l__workspace__1.NoTarget;
				spawn(function()
					if p96[3] == false then
						v699.flash.Enabled = true;
						v699.flash:Emit(1);
						v699.flash.Enabled = false;
						v700 = l__game__7.ReplicatedStorage.misc.muzzleflash:Clone();
						l__Debris__26:AddItem(v700, 0.05);
						v700.Parent = v699;
					end;
					v699.smoke.Enabled = true;
					v699.smoke2.Enabled = true;
					v699.smoke:Emit(math.random(4, 6));
					v699.smoke:Emit(math.random(10, 15));
					v699.smoke.Enabled = false;
					v699.smoke2.Enabled = false;
				end);
			end;
		elseif p94 == "incendiary_trail" then
			v701 = l__game__7.ReplicatedStorage.effects.incendiary_trail:Clone();
			l__Debris__26:AddItem(v701, 3);
			v701.trailA.CFrame = CFrame.new(p96[1]);
			v701.trailB.CFrame = CFrame.new(p96[2]);
			v701.Parent = l__workspace__1.NoTarget;
			if 0.02 < tick() - specialcrackcd then
				v100({ "firearms" }, "incendiary_crack", v701.trailB, 0.1, true, false);
			end;
			specialcrackcd = tick();
			v701.trailB.ember:Emit(math.random(8, 12));
			v701.trailB.flame:Emit(math.random(5, 10));
			v701.trailB.small:Emit(math.random(5, 10));
			spawn(function()
				v702 = 1 - 1;
				while true do
					v701.Beam.Transparency = NumberSequence.new(v702 / 20);
					RS:wait();
					if 0 <= 1 then
						if v702 < 20 then

						else
							break;
						end;
					elseif 20 < v702 then

					else
						break;
					end;
					v702 = v702 + 1;				
				end;
			end);
		elseif p94 == "muzzle_flash" then
			v703 = l__game__7.ReplicatedStorage.effects.gunFX:Clone();
			l__Debris__26:AddItem(v703, 1);
			v703.CFrame = CFrame.new(p96[1]);
			v703.Parent = l__workspace__1.NoTarget;
			spawn(function()
				if p96[2] == false then
					v703.flash.Enabled = true;
					v703.flash:Emit(1);
					v703.flash.Enabled = false;
					v704 = l__game__7.ReplicatedStorage.misc.muzzleflash:Clone();
					l__Debris__26:AddItem(v704, 0.05);
					v704.Parent = v703;
				end;
				v703.smoke.Enabled = true;
				v703.smoke2.Enabled = true;
				v703.smoke:Emit(math.random(4, 6));
				v703.smoke:Emit(math.random(10, 15));
				v703.smoke.Enabled = false;
				v703.smoke2.Enabled = false;
			end);
		elseif p94 == "hangerPopup" then
			local function v705()
				v706 = { "YOU ARE WORTHLESS", "USELESS", "YOU ARE HOPELESS", "HOPELESS", "DIE", "GIVE UP", "YOU ARE USELESS", "WORTHLESS", "MEANINGLESS", "YOU ARE MEANINGLESS" };
				v707 = l__game__7.ReplicatedStorage.soundLibrary.general_ui.static:Clone();
				v707.TimePosition = math.random(1, 30);
				v707.Parent = l__CurrentCamera__1;
				v708 = { "4452726587", "4452726886", "4452727160", "4452727454" };
				v709 = math.random(1, 4);
				v710 = l__game__7.ReplicatedStorage.misc.hangertext:Clone();
				v710.static.Image = "rbxassetid://" .. v708[v709];
				v710.popuptext.Text = v706[math.random(1, #v706)];
				v711 = math.random(20, 80) / 100;
				v712 = math.random(10, 90) / 100;
				v710.popuptext.Position = UDim2.new(v711, 0, v712, 0);
				u99 = 0;
				u100 = v709;
				spawn(function()
					v707:Play();
					v710.Parent = ply.PlayerGui;
					v713 = tick();
					while true do
						v710.popuptext.Position = UDim2.new(v711, math.random(-10, 10), v712, math.random(-10, 10));
						if 0.05 <= tick() - u99 then
							u99 = tick();
							u100 = u100 + 1;
							if 4 < u100 then
								u100 = 1;
							end;
							v710.static.Image = "rbxassetid://" .. v708[u100];
						end;
						RS:wait();
						if not (0.3 <= tick() - v713) then

						else
							break;
						end;					
					end;
					v710:Destroy();
					v707:Destroy();
				end);
			end;
			if character:FindFirstChild("HumanoidRootPart") then
				if (character:FindFirstChild("HumanoidRootPart").Position - p95.Position).magnitude <= 30 then
					v705();
					if (character:FindFirstChild("HumanoidRootPart").Position - p95.Position).magnitude <= 15 then
						delay(1.5, function()
							v705();
						end);
					end;
				end;
			end;
		elseif p94 == "firelaser" then
			v714 = l__game__7.ReplicatedStorage.effects.laserTrail:Clone();
			l__Debris__26:AddItem(v714, 3);
			v714.trailA.CFrame = CFrame.new(p96[1]);
			v714.trailB.CFrame = CFrame.new(p96[2]);
			v714.Parent = l__workspace__1.NoTarget;
			if p96[4] == nil then
				if 0.02 < tick() - crackcd then
					v100({ "hitsound", "general" }, "plasma", v714.trailB, 0.1, true, false);
				end;
				crackcd = tick();
				v714.trailB.debrisA.Enabled = true;
				v714.trailB.debrisB.Enabled = true;
				v714.trailB.smoke.Enabled = true;
				v714.trailB.spark.Enabled = true;
				v714.trailB.debrisA:Emit(math.random(3, 6));
				v714.trailB.debrisB:Emit(math.random(3, 6));
				v714.trailB.smoke:Emit(math.random(2, 4));
				v714.trailB.spark:Emit(math.random(8, 12));
				v714.trailB.debrisA.Enabled = false;
				v714.trailB.debrisB.Enabled = false;
				v714.trailB.smoke.Enabled = false;
				v714.trailB.spark.Enabled = false;
			end;
			if p96[3] ~= nil then
				v714.Beam.Color = ColorSequence.new(Color3.new(0.6392156862745098, 0.13333333333333333, 1));
			end;
			delay(0.3, function()
				v715 = 1 - 1;
				while true do
					v714.Beam.Transparency = NumberSequence.new(v715 / 25);
					RS:wait();
					if 0 <= 1 then
						if v715 < 25 then

						else
							break;
						end;
					elseif 25 < v715 then

					else
						break;
					end;
					v715 = v715 + 1;				
				end;
				v714:Destroy();
			end);
			v716 = l__game__7.ReplicatedStorage.effects.laserFX:Clone();
			if p96[3] ~= nil then
				v717, v718, v719 = ipairs(v716:GetChildren());
				while true do
					v720, v721 = v717(v718, v719);
					if v720 then

					else
						break;
					end;
					v719 = v720;
					if v721:IsA("ParticleEmitter") then
						v721.Color = ColorSequence.new(Color3.new(0.6392156862745098, 0.13333333333333333, 1));
					end;				
				end;
			end;
			l__Debris__26:AddItem(v716, 1);
			v716.CFrame = CFrame.new(p96[1]);
			v716.Parent = l__workspace__1.NoTarget;
			spawn(function()
				v716.flash.Enabled = true;
				v716.flash:Emit(1);
				v716.flash.Enabled = false;
				v716.crystal.Enabled = true;
				v716.crystal:Emit(math.random(2, 4));
				v716.crystal.Enabled = false;
				v716.spark.Enabled = true;
				v716.spark:Emit(math.random(4, 8));
				v716.spark.Enabled = false;
				v716.flare.Enabled = true;
				v716.flare:Emit(1);
				v716.flare.Enabled = false;
			end);
		elseif p94 == "bowarrow" then
			v722 = l__game__7.ReplicatedStorage.effects.bowtrail:Clone();
			v722.CFrame = p96[1];
			v722.Parent = l__workspace__1.NoTarget;
			RS:wait();
			v722.CFrame = p96[1];
			v723, v724 = raycastline(p96[1].p, p96[1].LookVector + p96[2], 80, { l__workspace__1.NoTarget, l__workspace__1.GoreEffects, l__CurrentCamera__1 });
			RS:wait();
			v722.CFrame = CFrame.new(v724);
			if v723 == nil then
				v725 = v724;
				v726 = 1 - 1;
				while true do
					v727, v728 = raycastline(v725, p96[1].LookVector + p96[2] + Vector3.new(0, -0.05, 0), 3, baselayer);
					v722.CFrame = CFrame.new(v728);
					if v727 then
						break;
					end;
					v725 = v728;
					RS:wait();
					if 0 <= 1 then
						if v726 < 200 then

						else
							break;
						end;
					elseif 200 < v726 then

					else
						break;
					end;
					v726 = v726 + 1;				
				end;
			end;
			l__Debris__26:AddItem(v722, 5);
		elseif p94 == "vomit" then
			if p95:FindFirstChild("Head") == nil then
				return;
			end;
			v729 = l__game__7.ReplicatedStorage.effects.vomitBlock:Clone();
			v729.CFrame = p95.Head.CFrame;
			l__Debris__26:AddItem(v729, 3);
			v730 = Instance.new("Weld");
			v730.Part0 = p95.Head;
			v730.Part1 = v729;
			v729.Parent = p95.Head;
			v730.Parent = v729;
			delay(1, function()
				v729.sickParticle.Enabled = false;
			end);
		elseif p94 == "lostecho" then
			if current_in_echo == true then
				return;
			end;
			current_in_echo = true;
			agent_speak("echo_start");
			v731 = l__game__7.ReplicatedStorage.misc.echo_bg:Clone();
			v731.Parent = p96[1].hoverpart;
			v731.Adornee = p96[1].hoverpart;
			v732 = 0;
			v733 = tick();
			v734 = 0.03;
			v735 = 11;
			v736 = tick();
			while true do
				if v734 <= tick() - v733 then
					v733 = tick();
					v734 = math.random(20, 40) / 1000;
					v732 = v732 + 1;
					v731.loading.Text = tostring(v732) .. "%";
					v731.loadingbar.bar.Size = UDim2.new(v732 / 100, 0, 3, 0);
				end;
				if 0.05 <= tick() - v736 then
					if 0 < v735 then
						v736 = tick();
						v735 = v735 - 1;
						v731.loadingbar.Visible = not v731.loadingbar.Visible;
					end;
				end;
				v731.loading.TextTransparency = v731.loading.TextTransparency - 0.03;
				v731.ring.ImageTransparency = v731.ring.ImageTransparency - 0.03;
				v731.ring.Size = v731.ring.Size:Lerp(UDim2.new(1, 0, 1, 0), 0.1);
				RS:wait();
				if not (100 <= v732) then

				else
					break;
				end;
				if p96[1] ~= nil then

				else
					break;
				end;			
			end;
			v731:Destroy();
			if p96[1] then
				v100({ "general_ui" }, "echo_open", p96[1].hoverpart, 0.01, true, false);
				v737 = l__game__7.ReplicatedStorage.effects.echoball:Clone();
				l__Debris__26:AddItem(v737, 20);
				v737.CFrame = p96[1].hoverpart.CFrame;
				v737.Parent = l__CurrentCamera__1;
				spawn(function()
					while true do
						v737.Size = v737.Size + Vector3.new(1, 1, 1);
						v737.Transparency = v737.Transparency + 0.05;
						RS:wait();
						if not (1 <= v737.Transparency) then

						else
							break;
						end;					
					end;
					delay(1.5, function()
						v737.fx.Enabled = false;
					end);
				end);
				if l__game__7.ReplicatedStorage.echo:FindFirstChild(p96[2]) then
					v738 = l__game__7.ReplicatedStorage.echo:FindFirstChild(p96[2]):Clone();
					v738.Parent = l__CurrentCamera__1;
					v739, v740, v741 = ipairs(v738:GetChildren());
					while true do
						v742, v743 = v739(v740, v741);
						if v742 then

						else
							break;
						end;
						v741 = v742;
						if v743:FindFirstChild("torso") then
							spawn(function()
								v744 = l__game__7.ReplicatedStorage.effects.echoball:Clone();
								l__Debris__26:AddItem(v744, 10);
								v744.Material = Enum.Material.Neon;
								v744.CFrame = v743.torso.CFrame;
								v744.fx.Enabled = false;
								v744.Parent = l__CurrentCamera__1;
								v744.flash:Emit(math.random(10, 20));
								while true do
									v744.Size = v744.Size + Vector3.new(0.5, 0.5, 0.5);
									v744.Transparency = v744.Transparency + 0.1;
									RS:wait();
									if not (1 <= v744.Transparency) then

									else
										break;
									end;								
								end;
							end);
						end;					
					end;
					if p96[2] == "mountain" then
						delay(1.5, function()
							v100({ "echo_specific" }, "seat", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(3.5, function()
							v100({ "firearms" }, "rack", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(1, function()
							v100({ "movement_sounds" }, "step1", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(2, function()
							v100({ "movement_sounds" }, "step2", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(3, function()
							v100({ "movement_sounds" }, "step4", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(4, function()
							v100({ "movement_sounds" }, "step2", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(4.2, function()
							v100({ "echo_specific" }, "seat", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(5.9, function()
							v100({ "weapons", "Fists" }, "swingvar2", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(6, function()
							v100({ "hitsound", "melee" }, "fists", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9, function()
							v100({ "general" }, "reloadpartial", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(12, function()
							v100({ "weapons", "RFL" }, "Model 870", p96[1].hoverpart, nil, true, false, true);
						end);
					elseif p96[2] == "ship" then
						delay(1, function()
							v100({ "echo_specific" }, "lighter", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(2, function()
							v100({ "echo_specific" }, "lighter", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(3, function()
							v100({ "echo_specific" }, "lighter", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(1.5, function()
							v100({ "movement_sounds" }, "step1", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(2.5, function()
							v100({ "movement_sounds" }, "step2", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(3.5, function()
							v100({ "movement_sounds" }, "step4", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(4.5, function()
							v100({ "movement_sounds" }, "step2", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(6, function()
							v100({ "world_item" }, "ration_pickup", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(7, function()
							v100({ "movement_sounds" }, "step1", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(8, function()
							v100({ "movement_sounds" }, "step2", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(8.5, function()
							v100({ "weapons", "1HBL" }, "draw", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9, function()
							v100({ "weapons", "1HBL" }, "chargeswing", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9.3, function()
							v100({ "deaths" }, "axe_hit", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9.3, function()
							v100({ "deaths" }, "slash", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9.4, function()
							v100({ "world_item" }, "ration_pickup", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9.4, function()
							v100({ "general" }, "reloaddone", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9.6, function()
							v100({ "echo_specific" }, "running", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(10, function()
							v100({ "weapons", "ASMG" }, "M60-E6", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(11, function()
							v100({ "firearms" }, "casing_heavy", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(10.11, function()
							v100({ "weapons", "ASMG" }, "M60-E6", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(11.11, function()
							v100({ "firearms" }, "casing_heavy", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(10.22, function()
							v100({ "weapons", "ASMG" }, "M60-E6", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(10.32, function()
							v100({ "firearms" }, "crack", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(11.22, function()
							v100({ "firearms" }, "casing_heavy", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(10.33, function()
							v100({ "weapons", "ASMG" }, "M60-E6", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(11.33, function()
							v100({ "firearms" }, "casing_heavy", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(10.44, function()
							v100({ "weapons", "ASMG" }, "M60-E6", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(10.54, function()
							v100({ "firearms" }, "crack", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(11.44, function()
							v100({ "firearms" }, "casing_heavy", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(11.1, function()
							v100({ "echo_specific" }, "running", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(13, function()
							v100({ "weapons", "Item" }, "medikitcap", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(13.5, function()
							v100({ "weapons", "Item" }, "medikitspit", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(14, function()
							v100({ "weapons", "Item" }, "medikitflick", p96[1].hoverpart, nil, true, false, true);
						end);
					elseif p96[2] == "valley" then
						delay(0.5, function()
							v100({ "weapons", "Item" }, "esmarch", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(1, function()
							v100({ "movement_sounds" }, "step1", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(2, function()
							v100({ "movement_sounds" }, "step2", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(3, function()
							v100({ "movement_sounds" }, "step1", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(3.5, function()
							v100({ "general" }, "reloadpartial", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(6.8, function()
							v100({ "weapons", "2HPST" }, "draw", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(6.4, function()
							v100({ "weapons", "PST" }, "Glock 17", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(6.5, function()
							v100({ "firearms" }, "crack", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(7.2, function()
							v100({ "firearms" }, "casing_light", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(6.6, function()
							v100({ "reloads" }, "single_start", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(7, function()
							v100({ "weapons", "PST" }, "Glock 17", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(7.1, function()
							v100({ "firearms" }, "crack", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(8, function()
							v100({ "firearms" }, "casing_light", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(8, function()
							v100({ "reloads" }, "pistol_mid", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(7.2, function()
							v100({ "weapons", "2HPST" }, "Mark VII", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(8.4, function()
							v100({ "firearms" }, "casing_medium", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(7.9, function()
							v100({ "hitsound", "extras" }, "grapple2", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(8.6, function()
							v100({ "weapons", "2HPST" }, "Mark VII", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9.6, function()
							v100({ "firearms" }, "casing_medium", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(8.7, function()
							v100({ "deaths" }, "headshot2", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9, function()
							v100({ "movement_sounds" }, "step2", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(10, function()
							v100({ "movement_sounds" }, "step1", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(11, function()
							v100({ "movement_sounds" }, "step4", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(12, function()
							v100({ "weapons", "2HPST" }, "Mark VII", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(13, function()
							v100({ "firearms" }, "casing_medium", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(12, function()
							v100({ "deaths" }, "headshot1", p96[1].hoverpart, nil, true, false, true);
						end);
					elseif p96[2] == "market" then
						delay(1, function()
							v100({ "rations" }, "liquid_sip", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(2, function()
							v100({ "rations" }, "liquid_sip", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(3, function()
							v100({ "rations" }, "liquid_sip", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(3.5, function()
							v100({ "movement_sounds" }, "movement", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(3.8, function()
							v100({ "echo_specific" }, "seat", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(4.5, function()
							v100({ "weapons", "2HPST" }, "draw", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(4.6, function()
							v100({ "weapons", "ASMG" }, "draw", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(4.7, function()
							v100({ "weapons", "SMG" }, "draw", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(4.8, function()
							v100({ "weapons", "PST" }, "draw", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(6, function()
							v100({ "movement_sounds" }, "step1", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(7, function()
							v100({ "movement_sounds" }, "step2", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(8, function()
							v100({ "general" }, "reloadpartial", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(8.5, function()
							v100({ "weapons", "ASMG" }, "Modded AKM", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(8.6, function()
							v100({ "weapons", "ASMG" }, "Modded AKM", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(8.7, function()
							v100({ "weapons", "ASMG" }, "Modded AKM", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(8.8, function()
							v100({ "weapons", "ASMG" }, "Modded AKM", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(8.9, function()
							v100({ "weapons", "ASMG" }, "Modded AKM", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9, function()
							v100({ "weapons", "ASMG" }, "Modded AKM", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9.5, function()
							v100({ "firearms" }, "casing_heavy", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9.7, function()
							v100({ "firearms" }, "casing_heavy", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9.8, function()
							v100({ "firearms" }, "casing_heavy", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9.9, function()
							v100({ "firearms" }, "casing_heavy", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(8.4, function()
							v100({ "weapons", "PST" }, "Glock 17", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9.4, function()
							v100({ "firearms" }, "casing_light", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(8.7, function()
							v100({ "weapons", "PST" }, "Glock 17", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9.7, function()
							v100({ "firearms" }, "casing_light", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9, function()
							v100({ "weapons", "PST" }, "Glock 17", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(10, function()
							v100({ "firearms" }, "casing_light", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(8.7, function()
							v100({ "weapons", "PST" }, "M1911A1", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9.7, function()
							v100({ "firearms" }, "casing_light", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9.2, function()
							v100({ "weapons", "PST" }, "M1911A1", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(10.2, function()
							v100({ "firearms" }, "casing_light", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(11, function()
							v100({ "movement_sounds" }, "step2", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(12, function()
							v100({ "movement_sounds" }, "step1", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(13, function()
							v100({ "movement_sounds" }, "step4", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(14, function()
							v100({ "world_item" }, "ration_pickup", p96[1].hoverpart, nil, true, false, true);
						end);
					elseif p96[2] == "base" then
						delay(0.5, function()
							v100({ "general" }, "writing", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(1, function()
							v100({ "movement_sounds" }, "step1", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(2, function()
							v100({ "movement_sounds" }, "step2", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(3, function()
							v100({ "movement_sounds" }, "step1", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(4, function()
							v100({ "movement_sounds" }, "step2", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(5, function()
							v100({ "movement_sounds" }, "step1", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(6, function()
							v100({ "movement_sounds" }, "step4", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(4, function()
							v100({ "AGENT" }, "blip", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(5, function()
							v100({ "AGENT" }, "bliptwo", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(7, function()
							v100({ "echo_specific" }, "glass", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(8, function()
							v100({ "weapons", "PST" }, "draw", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(8.5, function()
							v100({ "weapons", "PST" }, "M1911A1", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(8.7, function()
							v100({ "firearms" }, "crack", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9.5, function()
							v100({ "firearms" }, "casing_light", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9, function()
							v100({ "weapons", "SMG" }, "draw", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9.2, function()
							v100({ "weapons", "PST" }, "M1911A1", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9.4, function()
							v100({ "firearms" }, "crack", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(10.2, function()
							v100({ "firearms" }, "casing_light", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9.5, function()
							v100({ "weapons", "2HPST" }, "A.J.M. 9", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9.7, function()
							v100({ "hitsound", "guns" }, "bullet_impact1", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(10.5, function()
							v100({ "firearms" }, "casing_light", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9.554, function()
							v100({ "weapons", "2HPST" }, "A.J.M. 9", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9.754, function()
							v100({ "hitsound", "guns" }, "bullet_impact2", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(10.8, function()
							v100({ "firearms" }, "casing_light", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9.608, function()
							v100({ "weapons", "2HPST" }, "A.J.M. 9", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9.808, function()
							v100({ "hitsound", "guns" }, "bullet_impact3", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(11, function()
							v100({ "firearms" }, "casing_light", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(13, function()
							v100({ "world_item" }, "ration_pickup", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(13.5, function()
							v100({ "echo_specific" }, "running", p96[1].hoverpart, nil, true, false, true);
						end);
					elseif p96[2] == "tower" then
						delay(0.5, function()
							v100({ "weapons", "Fists" }, "swingvar2", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(0.6, function()
							v100({ "hitsound", "melee" }, "fists", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(1.1, function()
							v100({ "weapons", "Fists" }, "swingvar1", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(1.2, function()
							v100({ "hitsound", "melee" }, "fists", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(2, function()
							v100({ "general" }, "shove", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(2.1, function()
							v100({ "general" }, "shove_landed", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(2.4, function()
							v100({ "echo_specific" }, "fall", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(2.8, function()
							v100({ "general" }, "falldamage1", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(2.8, function()
							v100({ "echo_specific" }, "rope", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(2.8, function()
							v100({ "echo_specific" }, "bone", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(6, function()
							v100({ "movement_sounds" }, "step1", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(7, function()
							v100({ "movement_sounds" }, "step2", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(8, function()
							v100({ "movement_sounds" }, "step1", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9, function()
							v100({ "movement_sounds" }, "step4", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(10, function()
							v100({ "movement_sounds" }, "step2", p96[1].hoverpart, nil, true, false, true);
						end);
					elseif p96[2] == "castle" then
						delay(0.5, function()
							v100({ "harvesting" }, "stonebreak", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(1.5, function()
							v100({ "harvesting" }, "stonebreak", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(1, function()
							v100({ "movement_sounds" }, "step1", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(2, function()
							v100({ "movement_sounds" }, "step2", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(3, function()
							v100({ "movement_sounds" }, "step1", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(2.5, function()
							v100({ "harvesting" }, "stonebreak", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(2.6, function()
							v100({ "echo_specific" }, "wall2", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(2.7, function()
							v100({ "echo_specific" }, "wall", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(3, function()
							v100({ "ai" }, "ai_sprint", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(2.9, function()
							v100({ "shadow" }, "skinner_noise5", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(3.5, function()
							v100({ "weapons", "PST" }, "M1911A1", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(4, function()
							v100({ "weapons", "PST" }, "M1911A1", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(4.1, function()
							v100({ "firearms" }, "empty", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(4.4, function()
							v100({ "deaths" }, "cut_tear", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(4.45, function()
							v100({ "deaths" }, "flesh", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(3.5, function()
							v100({ "echo_specific" }, "running", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(4.8, function()
							v100({ "general" }, "blockraise", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(5.3, function()
							v100({ "hitsound", "general" }, "hitblocked", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(6.7, function()
							v100({ "hitsound", "general" }, "hitblocked", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(6.8, function()
							v100({ "weapons", "2H" }, "swingvar1", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(6.9, function()
							v100({ "deaths" }, "headbonk", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(4.5, function()
							v100({ "reloads" }, "rifle_mid", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(5, function()
							v100({ "general" }, "reloaddone", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(6.3, function()
							v100({ "weapons", "ASMG" }, "AK-74", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(6.392, function()
							v100({ "weapons", "ASMG" }, "AK-74", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(6.484, function()
							v100({ "weapons", "ASMG" }, "AK-74", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(6.576, function()
							v100({ "weapons", "ASMG" }, "AK-74", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(6.668, function()
							v100({ "weapons", "ASMG" }, "AK-74", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(6.76, function()
							v100({ "weapons", "ASMG" }, "AK-74", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(6.852, function()
							v100({ "weapons", "ASMG" }, "AK-74", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(6.944, function()
							v100({ "weapons", "ASMG" }, "AK-74", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(7.036, function()
							v100({ "weapons", "ASMG" }, "AK-74", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(7.1, function()
							v100({ "firearms" }, "empty", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(7.5, function()
							v100({ "firearms" }, "click", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(7.8, function()
							v100({ "firearms" }, "click", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(8.1, function()
							v100({ "firearms" }, "click", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(7.3, function()
							v100({ "shadow" }, "skinner_noise2", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9, function()
							v100({ "ai" }, "ai_sprint", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(8.8, function()
							v100({ "weapons", "1HBL" }, "chargeswing", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9, function()
							v100({ "deaths" }, "neck", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9, function()
							v100({ "hitsound", "general" }, "hitblocked", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(9.5, function()
							v100({ "hitsound", "extras" }, "grapple2", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(10.3, function()
							v100({ "hitsound", "general" }, "hitbackstab", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(10.3, function()
							v100({ "deaths" }, "slash", p96[1].hoverpart, nil, true, false, true);
						end);
						delay(11, function()
							v100({ "shadow" }, "skinner_noise4", p96[1].hoverpart, nil, true, false, true);
						end);
					end;
					v745 = tick();
					while true do
						RS:wait();
						if not (15 <= tick() - v745) then

						else
							break;
						end;					
					end;
					agent_speak("echo_end");
					v746, v747, v748 = ipairs(v738:GetChildren());
					while true do
						v749, v750 = v746(v747, v748);
						if v749 then

						else
							break;
						end;
						v748 = v749;
						if v750:FindFirstChild("torso") then
							v751 = l__game__7.ReplicatedStorage.effects.echoball:Clone();
							l__Debris__26:AddItem(v751, 10);
							v751.Material = Enum.Material.Neon;
							v751.CFrame = v750.torso.CFrame;
							v751.fx.Enabled = false;
							v751.Parent = l__CurrentCamera__1;
							v751.flash:Emit(math.random(10, 20));
							spawn(function()
								while true do
									v751.Size = v751.Size + Vector3.new(0.5, 0.5, 0.5);
									v751.Transparency = v751.Transparency + 0.1;
									RS:wait();
									if not (1 <= v751.Transparency) then

									else
										break;
									end;								
								end;
							end);
						end;					
					end;
					v738:Destroy();
					v100({ "general_ui" }, "echo_close", p96[1].hoverpart, 0.01, true, false);
					current_in_echo = false;
				end;
			end;
		elseif p94 == "scanarea" then
			if p96[1] ~= nil then
				l__activestats__752 = v18.scan.activestats;
				v753 = l__game__7.ReplicatedStorage.effects.scanball:Clone();
				l__Debris__26:AddItem(v753, 20);
				v753.CFrame = p96[1];
				v753.Parent = l__CurrentCamera__1;
				if p95 == character then
					spawn(function()
						v754 = tick();
						maingui.PerkFrame.durationbar.Visible = true;
						maingui.PerkFrame.durationbar.fill.Size = UDim2.new(1, 0, 1, 0);
						while true do
							maingui.PerkFrame.durationbar.fill.Size = UDim2.new(1 - math.clamp((tick() - v754) / l__activestats__752.scanlast, 0, 1), 0, 1, 0);
							RS:wait();
							if not (l__activestats__752.scanlast <= tick() - v754) then

							else
								break;
							end;						
						end;
						maingui.PerkFrame.durationbar.Visible = false;
					end);
				end;
				spawn(function()
					v755, v756, v757 = ipairs(l__workspace__1.Interactables:GetChildren());
					while true do
						v758, v759 = v755(v756, v757);
						if v758 then

						else
							break;
						end;
						if v759:FindFirstChild("Interact") then
							if (v759.Interact.Position - p96[1].p).magnitude <= l__activestats__752.studsscan then
								if v759.Name ~= "Heavy Ammo" then
									if v759.Name ~= "Shells Ammo" then
										if v759.Name ~= "Light Ammo" then
											if v759.Name ~= "Long Ammo" then
												if v759.Name ~= "Short Ammo" then
													if v759.Name ~= "Medium Ammo" then
														if v759.Name == "Small Ammo" then
															u98(v759.Interact, false, l__activestats__752.scanlast);
														else
															u98(v759.Interact, false, l__activestats__752.scanlast);
														end;
													else
														u98(v759.Interact, false, l__activestats__752.scanlast);
													end;
												else
													u98(v759.Interact, false, l__activestats__752.scanlast);
												end;
											else
												u98(v759.Interact, false, l__activestats__752.scanlast);
											end;
										else
											u98(v759.Interact, false, l__activestats__752.scanlast);
										end;
									else
										u98(v759.Interact, false, l__activestats__752.scanlast);
									end;
								else
									u98(v759.Interact, false, l__activestats__752.scanlast);
								end;
							end;
						end;
						if v759:FindFirstChild("HarvestWood") then
							if (v759.HarvestWood.Position - p96[1].p).magnitude <= l__activestats__752.studsscan then
								u98(v759.HarvestWood, false, l__activestats__752.scanlast);
							end;
						end;
						if v759:FindFirstChild("HarvestStone") then
							if (v759.HarvestStone.Position - p96[1].p).magnitude <= l__activestats__752.studsscan then
								u98(v759.HarvestStone, false, l__activestats__752.scanlast);
							end;
						end;					
					end;
					v760, v761, v762 = ipairs(l__workspace__1.WeaponDrops:GetChildren());
					while true do
						v763, v764 = v760(v761, v762);
						if v763 then

						else
							break;
						end;
						v762 = v763;
						if v764:FindFirstChild("JointGrip") then
							if (v764.JointGrip.Position - p96[1].p).magnitude <= l__activestats__752.studsscan then
								u98(v764.JointGrip, false, l__activestats__752.scanlast);
							end;
						end;					
					end;
					v765, v766, v767 = ipairs(l__workspace__1.activeHostiles:GetChildren());
					while true do
						v768, v769 = v765(v766, v767);
						if v768 then

						else
							break;
						end;
						v767 = v768;
						if v769:FindFirstChild("Torso") then
							if v769:FindFirstChild("Head") then
								if v769:FindFirstChild("Humanoid") then
									if 0 <= v769.Humanoid.Health then
										if (v769.Torso.Position - p96[1].p).magnitude <= l__activestats__752.studsscan then
											v770 = l__game__7.ReplicatedStorage.effects.health_scanned:Clone();
											l__Debris__26:AddItem(v770, l__activestats__752.scanlast);
											v770.Adornee = v769.Torso;
											v770.Parent = ply.PlayerGui;
											v770.update_health.Disabled = false;
										end;
									end;
								end;
							end;
						end;					
					end;
				end);
				spawn(function()
					while true do
						v753.Size = v753.Size + Vector3.new(2, 2, 2);
						v753.Transparency = v753.Transparency + 0.025;
						RS:wait();
						if not (1 <= v753.Transparency) then

						else
							break;
						end;					
					end;
					delay(3, function()
						v753.fx.Enabled = false;
					end);
				end);
			end;
		elseif p94 == "player_ping" then
			if p96[1] ~= nil then
				if l__workspace__1.NoTarget:FindFirstChild(p96[2] .. "PING_CAT" .. p96[3]) then
					l__workspace__1.NoTarget:FindFirstChild(p96[2] .. "PING_CAT" .. p96[3]):Destroy();
				end;
				v771 = l__game__7.ReplicatedStorage.misc.ping_indicator:Clone();
				v771.Name = p96[2] .. "PING_CAT" .. p96[3];
				l__Debris__26:AddItem(v771, 20);
				v771.CFrame = CFrame.new(p96[1]);
				v771.bb.pinger.Text = p96[2];
				v771.Parent = l__workspace__1.NoTarget;
				v772 = v771.bb:FindFirstChild("ping_cat" .. p96[3]);
				if v772 then
					v772.Visible = true;
					v773 = v772:Clone();
					v773.Parent = v771.bb;
					spawn(function()
						while true do
							if v773 then
								if v772 then
									v773.Size = v773.Size + UDim2.new(0, 2, 0, 2);
									v773.ImageTransparency = v773.ImageTransparency + 0.05;
								end;
							end;
							RS:wait();
							if not (1 <= v773.ImageTransparency) then

							else
								break;
							end;
							if v772 ~= nil then

							else
								break;
							end;						
						end;
						v773:Destroy();
					end);
				end;
				v774 = "ping_area";
				if p96[3] == 2 then
					v774 = "ping_enemy";
				elseif p96[3] == 3 then
					v774 = "ping_item";
				end;
				v100({ "general_ui" }, v774, nil, nil, true, true);
				v775 = maingui.teammatesframe:FindFirstChild(p96[2]);
				if v775 then
					if v775:FindFirstChild("empty") then
						v776 = "[Moving Here]";
						v777 = Color3.fromRGB(255, 182, 122);
						if p96[3] == 3 then
							v777 = Color3.fromRGB(122, 232, 92);
							v776 = "[Marked " .. p96[4] .. "]";
						elseif p96[3] == 2 then
							v777 = Color3.fromRGB(216, 60, 60);
							v776 = "[Hostile]";
						elseif p96[3] == 4 then
							v777 = Color3.fromRGB(102, 137, 255);
							v776 = "[Located " .. p96[4] .. "]";
						elseif p96[3] == 5 then
							v777 = Color3.fromRGB(183, 89, 255);
							v776 = "[" .. p96[4] .. "]";
						end;
						v778 = l__game__7.ReplicatedStorage.misc.ping_text:Clone();
						l__Debris__26:AddItem(v778, 6);
						v778.TextColor3 = v777;
						v778.Text = v776;
						v778.bg.ImageColor3 = v777;
						if v775:FindFirstChild("empty"):FindFirstChild("ping_text") then
							v775:FindFirstChild("empty"):FindFirstChild("ping_text"):Destroy();
						end;
						v778.Parent = v775:FindFirstChild("empty");
						spawn(function()
							while true do
								if v778 then
									if v778:FindFirstChild("bg") then
										v778.bg.ImageTransparency = v778.bg.ImageTransparency + 0.05;
										v778.bg.Size = v778.bg.Size + UDim2.new(0, 2, 0, 0);
									end;
								end;
								RS:wait();
								if v778 ~= nil then

								else
									break;
								end;
								if v778:FindFirstChild("bg") ~= nil then

								else
									break;
								end;
								if not (1 <= v778.bg.ImageTransparency) then

								else
									break;
								end;							
							end;
						end);
					end;
				end;
			end;
		elseif p94 == "selfscan" then
			l__activestats__101 = v18.scan.activestats;
			spawn(function()
				v779, v780, v781 = ipairs(l__workspace__1.Interactables:GetChildren());
				while true do
					v782, v783 = v779(v780, v781);
					if v782 then

					else
						break;
					end;
					if v783:FindFirstChild("Interact") then
						if (v783.Interact.Position - character.HumanoidRootPart.Position).magnitude <= l__activestats__101.scan_around then
							if v783.Name ~= "Heavy Ammo" then
								if v783.Name ~= "Shells Ammo" then
									if v783.Name ~= "Light Ammo" then
										if v783.Name ~= "Long Ammo" then
											if v783.Name ~= "Short Ammo" then
												if v783.Name ~= "Medium Ammo" then
													if v783.Name == "Small Ammo" then
														u98(v783.Interact, true, l__activestats__101.scan_around_timer);
													else
														u98(v783.Interact, true, l__activestats__101.scan_around_timer);
													end;
												else
													u98(v783.Interact, true, l__activestats__101.scan_around_timer);
												end;
											else
												u98(v783.Interact, true, l__activestats__101.scan_around_timer);
											end;
										else
											u98(v783.Interact, true, l__activestats__101.scan_around_timer);
										end;
									else
										u98(v783.Interact, true, l__activestats__101.scan_around_timer);
									end;
								else
									u98(v783.Interact, true, l__activestats__101.scan_around_timer);
								end;
							else
								u98(v783.Interact, true, l__activestats__101.scan_around_timer);
							end;
						end;
					end;
					if v783:FindFirstChild("HarvestWood") then
						if (v783.HarvestWood.Position - character.HumanoidRootPart.Position).magnitude <= l__activestats__101.scan_around then
							u98(v783.HarvestWood, true, l__activestats__101.scan_around_timer);
						end;
					end;
					if v783:FindFirstChild("HarvestStone") then
						if (v783.HarvestStone.Position - character.HumanoidRootPart.Position).magnitude <= l__activestats__101.scan_around then
							u98(v783.HarvestStone, true, l__activestats__101.scan_around_timer);
						end;
					end;				
				end;
				v784, v785, v786 = ipairs(l__workspace__1.WeaponDrops:GetChildren());
				while true do
					v787, v788 = v784(v785, v786);
					if v787 then

					else
						break;
					end;
					v786 = v787;
					if v788:FindFirstChild("JointGrip") then
						if (v788.JointGrip.Position - character.HumanoidRootPart.Position).magnitude <= l__activestats__101.scan_around then
							u98(v788.JointGrip, true, l__activestats__101.scan_around_timer);
						end;
					end;				
				end;
			end);
		elseif p94 == "tased" then
			v789 = createfxoutline("tasedParticle", 1.7);
		elseif p94 == "decap" then
			if p95:FindFirstChild("Head") == nil then
				return;
			end;
			l__Head__790 = p95.Head;
			v791 = l__game__7.ReplicatedStorage.effects.gFX.decap.decapstump:Clone();
			v791.CFrame = p95.Torso.CFrame;
			v792 = Instance.new("Weld");
			v792.Part0 = v791;
			v792.Part1 = p95.Torso;
			v792.C1 = CFrame.new(0, 1, 0);
			v792.Parent = v791;
			v791.Parent = p95;
			v793 = l__game__7.ReplicatedStorage.effects.gFX.decap.decapblock:Clone();
			v794 = Instance.new("Weld");
			v794.Part0 = v793;
			v794.Part1 = l__Head__790;
			v794.Parent = v793;
			v794.Parent = p95;
			v793.Parent = p95;
			l__Head__790.CFrame = l__Head__790.CFrame * CFrame.new(0, 0.2, 0);
			RS:wait();
			l__Head__790.Velocity = l__Head__790.Velocity + Vector3.new(math.random(-3, 3), 20, math.random(-3, 3));
		elseif p94 == "crush" then
			v795, v796, v797 = ipairs(p95:GetChildren());
			while true do
				v798, v799 = v795(v796, v797);
				if v798 then

				else
					break;
				end;
				v797 = v798;
				if v799:IsA("Accessory") then
					v799:Destroy();
				end;			
			end;
			v800, v801, v802 = ipairs(p95.Head:GetChildren());
			while true do
				v803, v804 = v800(v801, v802);
				if v803 then

				else
					break;
				end;
				v802 = v803;
				if v804:IsA("Decal") then
					v804:Destroy();
				end;			
			end;
			if p95:FindFirstChild("Outfit") then
				if p95:FindFirstChild("Outfit"):FindFirstChild("Head") then
					v805, v806, v807 = ipairs(p95:FindFirstChild("Outfit"):GetChildren());
					while true do
						v808, v809 = v805(v806, v807);
						if v808 then

						else
							break;
						end;
						v807 = v808;
						if v809.Name == "Head" then
							v809:Destroy();
						end;					
					end;
				end;
			end;
			l__Head__810 = p95.Head;
			v811 = l__game__7.ReplicatedStorage.effects.gFX.crush.splat:Clone();
			l__Debris__26:AddItem(v811, 9);
			v811.CFrame = p95.Head.CFrame;
			v811.fx1:Emit(math.random(5, 10));
			v811.fx2:Emit(math.random(3, 5));
			v811.Parent = l__workspace__1.NoTarget;
			v812 = l__game__7.ReplicatedStorage.effects.gFX.crush.bonestump:Clone();
			v812.CFrame = p95.Torso.CFrame;
			v813 = Instance.new("Weld");
			v813.Part0 = v812;
			v813.Part1 = p95.Torso;
			v813.C1 = CFrame.new(0, 1, 0);
			v813.Parent = v812;
			v812.Parent = p95;
			p95.Head:Destroy();
			v814 = { "gib", "bone" };
			v815 = math.random(8, 15);
			v816 = 1 - 1;
			while true do
				v817 = l__game__7.ReplicatedStorage.effects.gFX.crush[v814[math.random(1, 2)]]:Clone();
				l__Debris__26:AddItem(v817, 7);
				v817.CFrame = l__Head__810.CFrame * CFrame.new(math.random(-15, 10) / 100, math.random(-15, 10) / 100, math.random(-15, 10) / 100);
				v817.Parent = l__workspace__1.NoTarget;
				v817.Velocity = v817.Velocity + Vector3.new(math.random(-6, 6), math.random(5, 15), math.random(-6, 6));
				if 0 <= 1 then
					if v816 < v815 then

					else
						break;
					end;
				elseif v815 < v816 then

				else
					break;
				end;
				v816 = v816 + 1;			
			end;
		elseif p94 == "arrowimpact" then
			v818 = l__game__7.ReplicatedStorage.effects.gFX.arrowdeath.arrowimpact:Clone();
			v818.CFrame = p95.Head.CFrame;
			v819 = Instance.new("Weld");
			v819.Part0 = v818;
			v819.Part1 = p95.Head;
			v819.Parent = v818;
			v818.Parent = p95;
			v818.gorepoint.bleedpoint1.splat.Enabled = true;
			v818.gorepoint.bleedpoint2.splat.Enabled = true;
			v818.gorepoint.bleedpoint1.splat:Emit(30, 50);
			v818.gorepoint.bleedpoint2.splat:Emit(30, 50);
			v818.gorepoint.bleedpoint1.splat.Enabled = false;
			v818.gorepoint.bleedpoint2.splat.Enabled = false;
		elseif p94 == "headshot_gun" then
			v820 = l__game__7.ReplicatedStorage.effects.gFX.headshotdeath.headshotimpact:Clone();
			v820.CFrame = p95.Head.CFrame;
			v821 = Instance.new("Weld");
			v821.Part0 = v820;
			v821.Part1 = p95.Head;
			v821.Parent = v820;
			v820.Parent = p95;
			v820.gorepoint.bleedpoint1.splat.Enabled = true;
			v820.gorepoint.bleedpoint1.cloud.Enabled = true;
			v820.gorepoint.bleedpoint2.splat.Enabled = true;
			v820.gorepoint.bleedpoint1.cloud:Emit(1, 3);
			v820.gorepoint.bleedpoint1.splat:Emit(30, 50);
			v820.gorepoint.bleedpoint2.splat:Emit(30, 50);
			v820.gorepoint.bleedpoint1.splat.Enabled = false;
			v820.gorepoint.bleedpoint1.cloud.Enabled = false;
			v820.gorepoint.bleedpoint2.splat.Enabled = false;
			v100({ "deaths" }, "headshot" .. math.random(1, 2), p95.Head, nil, true, false);
			v100({ "deaths" }, "decap", p95.Head, nil, true, false);
			if p96 ~= nil then
				if p96 == "self" then
					v820.gorepoint.Transparency = 1;
					v820.gorepoint.bleedpoint1.drip.Enabled = false;
					v820.gorepoint.bleedpoint2.drip.Enabled = false;
				end;
			end;
		elseif p94 ~= "head_bonk" then
			if p94 == "axe_embed" then
				v822 = l__game__7.ReplicatedStorage.effects.gFX.blunthead.headbonk:Clone();
				v822.CFrame = p95.Head.CFrame;
				v823 = Instance.new("Weld");
				v823.Part0 = v822;
				v823.Part1 = p95.Head;
				v823.Parent = v822;
				v822.Parent = p95;
				RS:wait();
				v822.gorepoint.bleedpoint1.splat.Enabled = true;
				v822.gorepoint.bleedpoint1.cloud.Enabled = true;
				v822.gorepoint.bleedpoint1.cloud:Emit(1, 3);
				v822.gorepoint.bleedpoint1.splat:Emit(15, 30);
				v822.gorepoint.bleedpoint1.splat.Enabled = false;
				v822.gorepoint.bleedpoint1.cloud.Enabled = false;
				if p94 == "head_bonk" then
					v100({ "deaths" }, "headbonk", p95.Head, nil, true, false);
				else
					v824 = l__game__7.ReplicatedStorage.effects.gFX.axe_head.axed:Clone();
					v824.CFrame = p95.Head.CFrame;
					v825 = Instance.new("Weld");
					v825.Part0 = v824;
					v825.Part1 = p95.Head;
					v825.Parent = v824;
					v824.Parent = p95;
					v100({ "deaths" }, "tear", p95.Head, nil, true, false);
					v100({ "deaths" }, "axe_hit", p95.Head, nil, true, false);
				end;
			elseif p94 ~= "take_limbs_arms" then
				if p94 == "take_limbs_legs" then
					v826 = l__game__7.ReplicatedStorage.effects.gFX.limbremove.torsopart:Clone();
					v826.CFrame = p95.Torso.CFrame;
					v827 = Instance.new("Weld");
					v827.Part0 = v826;
					v827.Part1 = p95.Torso;
					v827.Parent = v826;
					v828 = "Left Arm";
					if math.random(1, 2) == 1 then
						v828 = "Right Arm";
					end;
					if p94 == "take_limbs_legs" then
						v828 = "Left Leg";
						if math.random(1, 2) == 1 then
							v828 = "Right Leg";
						end;
					end;
					v829, v830, v831 = ipairs(v826:GetChildren());
					while true do
						v832, v833 = v829(v830, v831);
						if v832 then

						else
							break;
						end;
						v831 = v832;
						if v833:IsA("BasePart") then
							if v833.Name ~= v828 then
								v833:Destroy();
							end;
						end;					
					end;
					v826.Parent = p95;
					if p95:FindFirstChild(v828) then
						p95:FindFirstChild(v828):Destroy();
					end;
					if p95:FindFirstChild("Outfit") then
						if p94 == "take_limbs_legs" then
							if p95.Outfit:FindFirstChild("Bottom") then
								if p95.Outfit.Bottom:FindFirstChild(v828) then
									p95.Outfit.Bottom:FindFirstChild(v828):Destroy();
								end;
							end;
						elseif p95.Outfit:FindFirstChild("Top") then
							if p95.Outfit.Top:FindFirstChild(v828) then
								p95.Outfit.Top:FindFirstChild(v828):Destroy();
							end;
						end;
					end;
					v100({ "deaths" }, "flesh", p95.Torso, nil, true, false);
					v100({ "deaths" }, "gurgle", p95.Torso, nil, true, false);
					v826:FindFirstChild(v828).attach.cloud.Enabled = true;
					v826:FindFirstChild(v828).attach.gib.Enabled = true;
					v826:FindFirstChild(v828).attach.cloud:Emit(math.random(1, 3));
					v826:FindFirstChild(v828).attach.gib:Emit(math.random(3, 7));
					v826:FindFirstChild(v828).attach.cloud.Enabled = false;
					v826:FindFirstChild(v828).attach.gib.Enabled = false;
				elseif p94 == "torso_cut" then
					v834 = l__game__7.ReplicatedStorage.effects.gFX.torsocut.Torso:Clone();
					v834.CFrame = p95.Torso.CFrame;
					v835 = Instance.new("Weld");
					v835.Part0 = v834;
					v835.Part1 = p95.Torso;
					v835.Parent = v834;
					v834.Parent = p95.Torso;
				elseif p94 == "pukedeath" then
					v100({ "deaths" }, "gurgle", p95.Head, nil, true, false);
					delay(0.5, function()
						v100({ "deaths" }, "puke", p95.Head, nil, true, false);
						v836 = l__game__7.ReplicatedStorage.effects.gFX.pukedeath.puke:Clone();
						v836.CFrame = p95.Head.CFrame;
						v837 = Instance.new("Weld");
						v837.Part0 = v836;
						v837.Part1 = p95.Head;
						v837.Parent = v836;
						v836.Parent = p95;
						v836.pukepoint.splat.Enabled = true;
						v836.pukepoint.splat2.Enabled = true;
						v836.pukepoint.splat:Emit(math.random(10, 20));
						v836.pukepoint.splat2:Emit(math.random(10, 20));
						RS:wait();
						v836.pukepoint.splat.Enabled = false;
						v836.pukepoint.splat2.Enabled = false;
					end);
				elseif p94 == "stomachrip" then
					v838 = l__game__7.ReplicatedStorage.effects.gFX.spearstomach.torsoFX:Clone();
					v838.CFrame = p95.Torso.CFrame;
					v839 = Instance.new("Weld");
					v839.Part0 = v838;
					v839.Part1 = p95.Torso;
					v839.Parent = v838;
					v838.Parent = p95;
					v838.fxpart.splat:Emit(30, 50);
					v838.fxpart.splat2:Emit(15, 30);
					v840 = math.random(6, 10);
					v841 = 1 - 1;
					while true do
						v842 = l__game__7.ReplicatedStorage.effects.gFX.spearstomach.gib:Clone();
						l__Debris__26:AddItem(v842, 7);
						v842.CFrame = p95.Torso.CFrame * CFrame.new(math.random(-15, 10) / 100, math.random(-15, 10) / 100, math.random(-15, 10) / 100);
						v842.Parent = l__workspace__1.NoTarget;
						v842.Velocity = v842.Velocity + p95.Torso.CFrame.lookVector * 3;
						if 0 <= 1 then
							if v841 < v840 then

							else
								break;
							end;
						elseif v840 < v841 then

						else
							break;
						end;
						v841 = v841 + 1;					
					end;
				elseif p94 == "neckcut" then
					v843 = l__game__7.ReplicatedStorage.effects.gFX.neckcut.fx:Clone();
					l__Debris__26:AddItem(v843, 9);
					v843.CFrame = p95.Torso.CFrame;
					v844 = Instance.new("Weld");
					v844.Part0 = v843;
					v844.Part1 = p95.Torso;
					v844.Parent = v843;
					v844.Parent = p95;
					v843.Parent = p95;
					delay(2, function()
						v843.point.drip.Enabled = false;
						v843.point.fx1.Enabled = false;
					end);
					v843.point.fx2:Emit(1);
					v843.point.gib:Emit(math.random(2, 5));
					v845 = l__game__7.ReplicatedStorage.effects.gFX.neckcut.neckpart:Clone();
					l__Debris__26:AddItem(v845, 7);
					v845.CFrame = p95.Head.CFrame + p95.Head.CFrame.lookVector * 1;
					v845.Parent = l__workspace__1.NoTarget;
					v845.Velocity = v845.Velocity + p95.Head.CFrame.lookVector * 3;
				elseif p94 == "explosive" then
					l__HumanoidRootPart__846 = p95:FindFirstChild("HumanoidRootPart");
					if l__HumanoidRootPart__846 then

					else
						return;
					end;
					v847, v848, v849 = ipairs(p95:GetChildren());
					while true do
						v850, v851 = v847(v848, v849);
						if v850 then

						else
							break;
						end;
						v849 = v850;
						if v851.Name ~= "Torso" then
							if v851.Name ~= "Humanoid" then
								if v851.Name ~= "active" then
									v851:Destroy();
								elseif v851:IsA("BasePart") then
									v851.Transparency = 1;
									v852, v853, v854 = ipairs(v851:GetChildren());
									while true do
										v855, v856 = v852(v853, v854);
										if v855 then

										else
											break;
										end;
										v854 = v855;
										if v856:IsA("Decal") then
											v856:Destroy();
										end;									
									end;
								end;
							elseif v851:IsA("BasePart") then
								v851.Transparency = 1;
								v852, v853, v854 = ipairs(v851:GetChildren());
								while true do
									v855, v856 = v852(v853, v854);
									if v855 then

									else
										break;
									end;
									v854 = v855;
									if v856:IsA("Decal") then
										v856:Destroy();
									end;								
								end;
							end;
						elseif v851:IsA("BasePart") then
							v851.Transparency = 1;
							v852, v853, v854 = ipairs(v851:GetChildren());
							while true do
								v855, v856 = v852(v853, v854);
								if v855 then

								else
									break;
								end;
								v854 = v855;
								if v856:IsA("Decal") then
									v856:Destroy();
								end;							
							end;
						end;					
					end;
					if p95:FindFirstChild("Torso") then
						p95:FindFirstChild("Torso").Anchored = true;
						p95:FindFirstChild("Torso").Transparency = 1;
					end;
					v857 = l__game__7.ReplicatedStorage.effects.gFX.explosion.explosiongib:Clone();
					l__Debris__26:AddItem(v857, 10);
					v857.CFrame = CFrame.new(l__HumanoidRootPart__846.Position) * CFrame.new(0, 1, 0);
					v857.Parent = l__workspace__1.NoTarget;
					v857.cloud:Emit(math.random(5, 8));
					v857.dust:Emit(math.random(5, 8));
					v857.expandcloud:Emit(math.random(5, 8));
					v857.gib:Emit(math.random(8, 12));
					v858 = math.random(8, 12);
					v859 = 1 - 1;
					while true do
						v860 = l__game__7.ReplicatedStorage.effects.gFX.crush.gib:Clone();
						l__Debris__26:AddItem(v860, 7);
						v860.CFrame = v857.CFrame * CFrame.new(math.random(-15, 10) / 100, math.random(-15, 10) / 100, math.random(-15, 10) / 100);
						v860.Parent = l__workspace__1.NoTarget;
						v860.Velocity = v860.Velocity + Vector3.new(math.random(-12, 12), math.random(15, 20), math.random(-12, 12));
						if 0 <= 1 then
							if v859 < v858 then

							else
								break;
							end;
						elseif v858 < v859 then

						else
							break;
						end;
						v859 = v859 + 1;					
					end;
				elseif p94 == "armcut" then
					v861 = l__game__7.ReplicatedStorage.effects.gFX.armcut.torsocopy:Clone();
					v862 = l__game__7.ReplicatedStorage.effects.gFX.armcut.cutarm:Clone();
					v861.beam.Attachment0 = v861.a0;
					v861.beam.Attachment1 = v862.a1;
					v863 = Instance.new("Weld");
					v863.Part0 = v861;
					v863.Part1 = p95.Torso;
					v863.Parent = v861;
					v861.Parent = p95;
					v862.CFrame = p95["Left Arm"].CFrame;
					v864 = Instance.new("Weld");
					v864.Part0 = v862;
					v864.Part1 = p95["Left Arm"];
					v864.Parent = v862;
					v862.Parent = p95["Left Arm"];
					p95["Left Arm"].Velocity = p95["Left Arm"].Velocity + -p95.Torso.CFrame.rightVector * 5;
					delay(0.5, function()
						v865 = 1 - 1;
						while true do
							v866 = 1.5 * (1 - v865 / 15);
							v861.beam.Width0 = v866;
							v861.beam.Width1 = v866;
							RS:wait();
							if 0 <= 1 then
								if v865 < 15 then

								else
									break;
								end;
							elseif 15 < v865 then

							else
								break;
							end;
							v865 = v865 + 1;						
						end;
						v861.beam:Destroy();
					end);
				elseif p94 == "slice" then
					v867, v868, v869 = ipairs(p95.Torso:GetChildren());
					while true do
						v870, v871 = v867(v868, v869);
						if v870 then

						else
							break;
						end;
						v869 = v870;
						if v871:IsA("Decal") then
							v871:Destroy();
						end;					
					end;
					l__Shirt__872 = p95:FindFirstChild("Shirt");
					if l__Shirt__872 == nil then
						l__Pants__873 = p95:FindFirstChild("Pants");
						if l__Pants__873 == nil then
							v874 = "";
						else
							v874 = l__Pants__873.PantsTemplate;
						end;
					else
						v874 = l__Shirt__872.ShirtTemplate;
					end;
					v875 = l__game__7.ReplicatedStorage.effects.gFX.slice.slicehalf:Clone();
					v875.BrickColor = p95.Torso.BrickColor;
					v875.TextureID = v874;
					v875.CFrame = p95.Torso.CFrame;
					v876 = Instance.new("Weld");
					v876.Part0 = v875;
					v876.Part1 = p95.Torso;
					v876.C1 = CFrame.new(0.6, 0, 0);
					v876.Parent = v875;
					v875.Parent = p95;
					p95.Torso.Transparency = 1;
					v877 = l__game__7.ReplicatedStorage.effects.gFX.slice.otherslicehalf:Clone();
					l__Shirt__878 = p95:FindFirstChild("Shirt");
					if l__Shirt__878 then
						l__Shirt__878:Clone().Parent = v877;
					end;
					l__Pants__879 = p95:FindFirstChild("Pants");
					if l__Pants__879 then
						l__Pants__879:Clone().Parent = v877;
					end;
					v880, v881, v882 = ipairs(v877:GetChildren());
					while true do
						v883, v884 = v880(v881, v882);
						if v883 then

						else
							break;
						end;
						v882 = v883;
						if p95:FindFirstChild(v884.Name) then
							if v884:IsA("BasePart") then
								v884.BrickColor = p95:FindFirstChild(v884.Name).BrickColor;
							end;
						end;					
					end;
					v877.Torso.otherhalf.BrickColor = p95.Torso.BrickColor;
					v877.Torso.otherhalf.TextureID = v874;
					v877:SetPrimaryPartCFrame(p95.Torso.CFrame);
					v877.Parent = p95;
					v875.beam1.Attachment1 = v877.Torso.otherhalf.a1;
					v875.beam2.Attachment1 = v877.Torso.otherhalf.b1;
					v875.beam3.Attachment1 = v877.Torso.otherhalf.c1;
					p95["Left Arm"]:Destroy();
					p95["Left Leg"]:Destroy();
					RS:wait();
					v877.Humanoid.PlatformStand = true;
					v877.Torso.Velocity = v877.Torso.Velocity + v877.Torso.CFrame.rightVector * 6;
					if p95.Torso:FindFirstChild("Neck") then
						p95.Torso.Neck.C1 = CFrame.new(-0.341941595, -0.544243574, 0.0124545023, -0.951813221, 0, -0.306678385, -0.301639259, 0.180534005, 0.936173737, 0.0553658754, 0.983568728, -0.171834648);
						p95.Torso.Neck.C0 = CFrame.new(0, 1, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0);
					end;
					delay(0.5, function()
						v885 = 1 - 1;
						while true do
							v886 = 1.5 * (1 - v885 / 15);
							v875.beam1.Width0 = v886;
							v875.beam1.Width1 = v886;
							v875.beam2.Width0 = v886;
							v875.beam2.Width1 = v886;
							v875.beam3.Width0 = v886;
							v875.beam3.Width1 = v886;
							RS:wait();
							if 0 <= 1 then
								if v885 < 15 then

								else
									break;
								end;
							elseif 15 < v885 then

							else
								break;
							end;
							v885 = v885 + 1;						
						end;
						v875.beam1:Destroy();
						v875.beam2:Destroy();
						v875.beam3:Destroy();
					end);
				end;
			else
				v826 = l__game__7.ReplicatedStorage.effects.gFX.limbremove.torsopart:Clone();
				v826.CFrame = p95.Torso.CFrame;
				v827 = Instance.new("Weld");
				v827.Part0 = v826;
				v827.Part1 = p95.Torso;
				v827.Parent = v826;
				v828 = "Left Arm";
				if math.random(1, 2) == 1 then
					v828 = "Right Arm";
				end;
				if p94 == "take_limbs_legs" then
					v828 = "Left Leg";
					if math.random(1, 2) == 1 then
						v828 = "Right Leg";
					end;
				end;
				v829, v830, v831 = ipairs(v826:GetChildren());
				while true do
					v832, v833 = v829(v830, v831);
					if v832 then

					else
						break;
					end;
					v831 = v832;
					if v833:IsA("BasePart") then
						if v833.Name ~= v828 then
							v833:Destroy();
						end;
					end;				
				end;
				v826.Parent = p95;
				if p95:FindFirstChild(v828) then
					p95:FindFirstChild(v828):Destroy();
				end;
				if p95:FindFirstChild("Outfit") then
					if p94 == "take_limbs_legs" then
						if p95.Outfit:FindFirstChild("Bottom") then
							if p95.Outfit.Bottom:FindFirstChild(v828) then
								p95.Outfit.Bottom:FindFirstChild(v828):Destroy();
							end;
						end;
					elseif p95.Outfit:FindFirstChild("Top") then
						if p95.Outfit.Top:FindFirstChild(v828) then
							p95.Outfit.Top:FindFirstChild(v828):Destroy();
						end;
					end;
				end;
				v100({ "deaths" }, "flesh", p95.Torso, nil, true, false);
				v100({ "deaths" }, "gurgle", p95.Torso, nil, true, false);
				v826:FindFirstChild(v828).attach.cloud.Enabled = true;
				v826:FindFirstChild(v828).attach.gib.Enabled = true;
				v826:FindFirstChild(v828).attach.cloud:Emit(math.random(1, 3));
				v826:FindFirstChild(v828).attach.gib:Emit(math.random(3, 7));
				v826:FindFirstChild(v828).attach.cloud.Enabled = false;
				v826:FindFirstChild(v828).attach.gib.Enabled = false;
			end;
		else
			v822 = l__game__7.ReplicatedStorage.effects.gFX.blunthead.headbonk:Clone();
			v822.CFrame = p95.Head.CFrame;
			v823 = Instance.new("Weld");
			v823.Part0 = v822;
			v823.Part1 = p95.Head;
			v823.Parent = v822;
			v822.Parent = p95;
			RS:wait();
			v822.gorepoint.bleedpoint1.splat.Enabled = true;
			v822.gorepoint.bleedpoint1.cloud.Enabled = true;
			v822.gorepoint.bleedpoint1.cloud:Emit(1, 3);
			v822.gorepoint.bleedpoint1.splat:Emit(15, 30);
			v822.gorepoint.bleedpoint1.splat.Enabled = false;
			v822.gorepoint.bleedpoint1.cloud.Enabled = false;
			if p94 == "head_bonk" then
				v100({ "deaths" }, "headbonk", p95.Head, nil, true, false);
			else
				v824 = l__game__7.ReplicatedStorage.effects.gFX.axe_head.axed:Clone();
				v824.CFrame = p95.Head.CFrame;
				v825 = Instance.new("Weld");
				v825.Part0 = v824;
				v825.Part1 = p95.Head;
				v825.Parent = v824;
				v824.Parent = p95;
				v100({ "deaths" }, "tear", p95.Head, nil, true, false);
				v100({ "deaths" }, "axe_hit", p95.Head, nil, true, false);
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
		v663 = l__game__7.ReplicatedStorage.effects.bloodSplatter:Clone();
		l__Debris__26:AddItem(v663, 2);
		v663.CFrame = CFrame.new(p95.Torso.Position);
		v663.Parent = l__workspace__1.NoTarget;
		v664 = p96[1];
		if v664 == nil then
			v664 = 1;
		end;
		v665 = v664 / 1.5;
		if v665 < 6 then
			v665 = 6;
		end;
		v663.fx1.Enabled = true;
		v663.fx1:Emit(math.random(v665, v665 + math.random(3, 5)));
		v663.fx1.Enabled = false;
		if p94 == "bloodhit" then
			v666 = l__game__7.ReplicatedStorage.effects.bloodSplatter:Clone();
			l__Debris__26:AddItem(v666, 2);
			v666.CFrame = CFrame.new(p96[2]);
			v666.Parent = l__workspace__1.NoTarget;
			v666.fx2.Enabled = true;
			v666.fx2:Emit(math.random(1, 3));
			v666.fx2.Enabled = false;
			v666.fx3.Enabled = true;
			v666.fx3:Emit(math.random(5, 10));
			v666.fx3.Enabled = false;
			v666.fx4.Enabled = true;
			v666.fx4:Emit(math.random(5, 10));
			v666.fx4.Enabled = false;
		end;
	end;
end;
l__workspace__1.ServerStuff.applyGore.OnClientEvent:Connect(applygore);
l__workspace__1.ServerStuff.relayStats.OnClientInvoke = function(p97)
	local v887 = {};
	for v888, v889 in pairs(u10) do
		v887[v889.effects.corename] = { v889.mainstats.intensity, (v889.effects.maxduration - (tick() - v889.effects.currentduration)) / v889.effects.maxduration };
	end;
	return { hum.Health, u8, v887, u9.blocking, { hum.WalkSpeed, u21 + u40, u20 }, hum.MaxHealth, nametag, v5, playerstats, v61 };
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
		local v890 = true;
		if p99[2] == true then
			p99 = tonumber(string.char(p99[1].Value));
		else
			v890 = false;
			p99 = p99[1];
		end;
		if v5[p99][2] ~= true then
			local v891, v892, v893 = pairs(v5);
			while true do
				local v894, v895 = v891(v892, v893);
				if v894 then

				else
					break;
				end;
				v893 = v894;
				v895[2] = false;			
			end;
			v5[p99][2] = true;
			if v890 == true then
				u61(v5[p99][1]);
				return;
			end;
		end;
	elseif p98 == "updatehud" then
		local v896, v897, v898 = pairs(v5);
		while true do
			local v899, v900 = v896(v897, v898);
			if v899 then

			else
				break;
			end;
			v898 = v899;
			local v901 = maingui.InventoryFrame:FindFirstChild(tostring("slot" .. v899));
			if v901 then
				local v902 = v17[v900[1]];
				local v903 = v902.name;
				local v904 = nil;
				local v905 = nil;
				if v903 == "Fists" then
					v903 = "EMPTY";
					if v900[2] == true then
						if playerstats.Exotic ~= "none" then
							if v19[playerstats.Exotic] then
								v903 = v19[playerstats.Exotic].name;
								v904 = v903;
								v905 = v19[playerstats.Exotic].param[3];
							end;
						end;
					end;
				end;
				if primskin then
					if v899 == 1 then
						v903 = primskin.name;
						v904 = primskin.name;
						v905 = primskin.param[3];
					end;
				end;
				v901.slotarea.slotname.Text = string.upper(v903);
				if v900[2] == true then
					if v900[3] ~= nil then
						maingui.LowerHudFrame.main.Visible = true;
						maingui.LowerHudFrame.reserve.Visible = true;
						if v902.ability ~= nil then
							maingui.LowerHudFrame.altitem.Visible = true;
							maingui.LowerHudFrame.altitem.Text = v902.ability;
						end;
						maingui.LowerHudFrame.itemusage.Visible = false;
						if v902.ammoused ~= nil then
							maingui.LowerHudFrame.altitem.Visible = true;
							maingui.LowerHudFrame.altitem.Text = "Uses " .. v902.ammoused .. " ammo.";
							maingui.LowerHudFrame.reserve.label.Text = u64[v902.ammoused];
						else
							maingui.LowerHudFrame.reserve.label.Text = "USES";
						end;
						maingui.LowerHudFrame.main.label.Text = tostring(v900[3]);
						if akimbo_factors.active == true then
							maingui.LowerHudFrame.altitem.Text = "RESERVE: " .. u64[akimbo_factors.alt_weapon_stats.ammoused];
							maingui.LowerHudFrame.main.label.Text = tostring(v5[akimbo_factors.weapon_slot][3]) .. "/" .. tostring(v900[3]);
						end;
					else
						maingui.LowerHudFrame.main.Visible = false;
						maingui.LowerHudFrame.reserve.Visible = false;
						maingui.LowerHudFrame.altitem.Visible = false;
						if v902.ability ~= nil then
							maingui.LowerHudFrame.itemusage.Visible = true;
							local v906 = "";
							if v902.rarity ~= nil then
								v906 = "Tier " .. v902.rarity .. " / ";
							end;
							maingui.LowerHudFrame.itemusage.Text = v906 .. v902.ability;
							if v905 then
								maingui.LowerHudFrame.itemusage.Text = v906 .. v905;
							end;
						end;
					end;
					v901.BackgroundColor3 = Color3.new(1, 1, 1);
					v901.slotarea.BackgroundColor3 = Color3.new(1, 1, 1);
					v901.highlight.Visible = true;
					v901.slotarea.Size = UDim2.new(0, 200, 0, 45);
					maingui.LowerHudFrame.itemname.Text = v902.name;
					if v904 then
						maingui.LowerHudFrame.itemname.Text = v904;
					end;
				else
					v901.highlight.Visible = false;
					v901.BackgroundColor3 = Color3.new(0, 0, 0);
					v901.slotarea.Size = UDim2.new(0, 200, 0, 25);
					v901.slotarea.BackgroundColor3 = Color3.new(0, 0, 0);
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
	local v907 = tick();
	while true do
		p100.hunted.Position = p100.hunted.Position:Lerp(UDim2.new(0.5, 0, 0.2, 0), 0.1);
		p100.focus.Position = p100.focus.Position:Lerp(UDim2.new(1.5, 0, 0.6, 0), 0.3);
		p100.status.Position = p100.status.Position:Lerp(UDim2.new(0.5, 0, 1, 0), 0.1);
		RS:wait();
		if tick() - v907 >= 2 then
			break;
		end;	
	end;
	playerstats = l__workspace__1.ServerStuff.retrieveStats:InvokeServer();
	if p101 == "loss" then
		p100.status.spectate.Visible = false;
		p100.status.menu.Visible = true;
		local v908 = { "WHAT THE HELL WERE YOU DOING?", "I'M BEWILDERED", "THAT'S JUST SAD", "UNFORTUNATE", "YOU DISAPPOINT ME", "HOW DID YOU MANAGE THAT?", "IMPRESSIVE", "SMOOTH MOVES", "EVERYONE MAKES MISTAKES", "THE MISTAKE HERE IS YOU", "UNFORTUNATE ACCIDENT", "THAT'S RATHER SAD", "DAMN", "WELL YOU TRIED", "YOU GET POINTS FOR TRYING" };
		p100.status.reports.killedby.eliminatedlevel.Text = v908[math.random(1, #v908)];
		if v108.killer ~= nil and (l__game__7.Players:FindFirstChild(v108.killer) or v108.killer == "Contestant") then
			local v909 = l__workspace__1.ServerStuff.relaylobbystat:InvokeServer(v108.killer);
			if v909 then
				local v910 = v108.killer;
				local v911 = v909.Level;
				if v909.Settings.Anonymous == true then
					if l__game__7.Players:FindFirstChild(v108.killer).Character and l__game__7.Players:FindFirstChild(v108.killer).Character:FindFirstChild("playerID") then
						local v912 = "Contestant #" .. l__game__7.Players:FindFirstChild(v108.killer).Character:FindFirstChild("playerID").Value;
					end;
					v910 = "Contestant";
					v911 = 0;
				end;
				p100.status.reports.killedby.eliminated.Text = "ELIMINATED BY: " .. v910;
				p100.status.reports.killedby.eliminatedlevel.Text = "LEVEL " .. v911;
			else
				p100.status.reports.killedby.eliminated.Text = "ELIMINATED BY: Contestant";
				p100.status.reports.killedby.eliminatedlevel.Text = "LEVEL " .. 0;
			end;
		end;
	else
		p100.status.reports.killedby.eliminated.Text = "TOTAL WINS: " .. playerstats.MainStats.Wins;
		p100.status.reports.killedby.eliminatedlevel.Text = "WIN STREAK: " .. playerstats.MainStats.WinStreak;
	end;
	p100.status.reports.rankings.damage.Text = "MELEE DAMAGE DONE: " .. math.ceil(v108.damage);
	p100.status.reports.rankings.eliminations.Text = "ELIMINATIONS: " .. v108.kills;
	p100.status.reports.rankings.timealive.Text = "TIME ALIVE: " .. math.ceil((tick() - v108.timealive) / 60) .. "M";
	p100.status.reports.fansearned.amt.Text = "FANS EARNED: " .. playerstats.MatchXP;
	local v913 = "ST";
	if v108.placed == 2 then
		v913 = "ND";
	elseif v108.placed == 3 then
		v913 = "RD";
	elseif v108.placed > 3 then
		v913 = "TH";
	end;
	p100.status.reports.rankings.place.Text = "PLACED: " .. v108.placed .. v913;
	if p101 == "siege" then
		p100.status.reports.rankings.place.Visible = false;
	end;
	local function v914(p102)
		local v915 = 0;
		local v916 = tick();
		while true do
			p102.Visible = true;
			if tick() - v916 >= 0.075 then
				v916 = tick();
				v915 = v915 + 1;
				p102.Visible = false;
			end;
			RS:wait();
			if v915 >= 5 then
				break;
			end;		
		end;
		p102.Visible = true;
	end;
	v914(p100.status.reports.killedby);
	spawn(function()
		v914(p100.status.reports.rankings);
	end);
	spawn(function()
		v914(p100.status.reports.fansearned);
	end);
end;
local u107 = nil;
local u108 = nil;
local u109 = nil;
local u110 = nil;
function alertplay(p103, p104)
	if typeof(p103) == "table" then

	else
		local v917 = nil;
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
		if p103 == "THE SIEGE HAS BEGUN" then
			if startperk.Value == "hubbing" then
				return;
			else
				v100({ "gamemode" }, "horn", nil, nil, true, true);
				u56("begin");
				v917 = false;
				v918 = maingui;
				v919 = "alert";
				v920 = v918;
				v921 = v919;
				v922 = v920[v921];
				local v948 = "TextTransparency";
				v923 = v922;
				v924 = v948;
				v925 = v923[v924];
				local v949 = 1;
				v926 = v925;
				v927 = v949;
				if v926 == v927 then
					v917 = true;
				end;
				local v950 = tick;
				v928 = v950;
				local v951 = v928();
				v929 = v951;
				alertplaytimer = v929;
				local v952 = maingui;
				local v953 = "alert";
				v930 = v952;
				v931 = v953;
				local v954 = v930[v931];
				local v955 = "Text";
				v932 = v954;
				v933 = v955;
				v934 = p103;
				v932[v933] = v934;
				local v956 = maingui;
				local v957 = "alert";
				v935 = v956;
				v936 = v957;
				local v958 = v935[v936];
				local v959 = 0;
				local v960 = "TextTransparency";
				v937 = v958;
				v938 = v960;
				v939 = v959;
				v937[v938] = v939;
				local v961 = maingui;
				local v962 = "alert";
				v940 = v961;
				v941 = v962;
				local v963 = v940[v941];
				local v964 = 0;
				local v965 = "TextStrokeTransparency";
				v942 = v963;
				v943 = v965;
				v944 = v964;
				v942[v943] = v944;
				v945 = p104;
				if v945 then
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
								v100({ "general_ui" }, "nightevent_start", nil, nil, true, true);
								local v966 = 1 - 1;
								while true do
									maingui.NightEvent.lefticon.Position = maingui.NightEvent.lefticon.Position + UDim2.new(0.055, 0, 0, 0);
									maingui.NightEvent.righticon.Position = maingui.NightEvent.righticon.Position - UDim2.new(0.055, 0, 0, 0);
									RS:wait();
									if 0 <= 1 then
										if v966 < 10 then

										else
											break;
										end;
									elseif 10 < v966 then

									else
										break;
									end;
									v966 = v966 + 1;								
								end;
								maingui.NightEvent.lefticon.Position = UDim2.new(0.35, 0, 0.5, 0);
								maingui.NightEvent.righticon.Position = UDim2.new(0.65, 0, 0.5, 0);
								v100({ "general_ui" }, "nightevent_mid", nil, nil, true, true);
								v100({ "general_ui" }, "nightevent_scav", nil, nil, true, true);
								local v967 = Instance.new("Frame");
								v967.Name = "flashwhite";
								v967.BorderSizePixel = 0;
								v967.BackgroundColor3 = Color3.new(1, 1, 1);
								v967.Size = UDim2.new(1, 0, 1, 0);
								v967.ZIndex = 3;
								v967.Parent = maingui;
								maingui.NightEvent.middletext.Visible = true;
								local v968 = tick();
								while true do
									v967.BackgroundTransparency = v967.BackgroundTransparency + 0.05;
									RS:wait();
									if not (4 <= tick() - v968) then

									else
										break;
									end;								
								end;
								v967:Destroy();
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
				local v969 = true;
				v946 = v917;
				v947 = v969;
				if v946 == v947 then
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
				v917 = false;
				v918 = maingui;
				v919 = "alert";
				v920 = v918;
				v921 = v919;
				v922 = v920[v921];
				v948 = "TextTransparency";
				v923 = v922;
				v924 = v948;
				v925 = v923[v924];
				v949 = 1;
				v926 = v925;
				v927 = v949;
				if v926 == v927 then
					v917 = true;
				end;
				v950 = tick;
				v928 = v950;
				v951 = v928();
				v929 = v951;
				alertplaytimer = v929;
				v952 = maingui;
				v953 = "alert";
				v930 = v952;
				v931 = v953;
				v954 = v930[v931];
				v955 = "Text";
				v932 = v954;
				v933 = v955;
				v934 = p103;
				v932[v933] = v934;
				v956 = maingui;
				v957 = "alert";
				v935 = v956;
				v936 = v957;
				v958 = v935[v936];
				v959 = 0;
				v960 = "TextTransparency";
				v937 = v958;
				v938 = v960;
				v939 = v959;
				v937[v938] = v939;
				v961 = maingui;
				v962 = "alert";
				v940 = v961;
				v941 = v962;
				v963 = v940[v941];
				v964 = 0;
				v965 = "TextStrokeTransparency";
				v942 = v963;
				v943 = v965;
				v944 = v964;
				v942[v943] = v944;
				v945 = p104;
				if v945 then
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
								v100({ "general_ui" }, "nightevent_start", nil, nil, true, true);
								v966 = 1 - 1;
								while true do
									maingui.NightEvent.lefticon.Position = maingui.NightEvent.lefticon.Position + UDim2.new(0.055, 0, 0, 0);
									maingui.NightEvent.righticon.Position = maingui.NightEvent.righticon.Position - UDim2.new(0.055, 0, 0, 0);
									RS:wait();
									if 0 <= 1 then
										if v966 < 10 then

										else
											break;
										end;
									elseif 10 < v966 then

									else
										break;
									end;
									v966 = v966 + 1;								
								end;
								maingui.NightEvent.lefticon.Position = UDim2.new(0.35, 0, 0.5, 0);
								maingui.NightEvent.righticon.Position = UDim2.new(0.65, 0, 0.5, 0);
								v100({ "general_ui" }, "nightevent_mid", nil, nil, true, true);
								v100({ "general_ui" }, "nightevent_scav", nil, nil, true, true);
								v967 = Instance.new("Frame");
								v967.Name = "flashwhite";
								v967.BorderSizePixel = 0;
								v967.BackgroundColor3 = Color3.new(1, 1, 1);
								v967.Size = UDim2.new(1, 0, 1, 0);
								v967.ZIndex = 3;
								v967.Parent = maingui;
								maingui.NightEvent.middletext.Visible = true;
								v968 = tick();
								while true do
									v967.BackgroundTransparency = v967.BackgroundTransparency + 0.05;
									RS:wait();
									if not (4 <= tick() - v968) then

									else
										break;
									end;								
								end;
								v967:Destroy();
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
				v969 = true;
				v946 = v917;
				v947 = v969;
				if v946 == v947 then
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
			v917 = false;
			v918 = maingui;
			v919 = "alert";
			v920 = v918;
			v921 = v919;
			v922 = v920[v921];
			v948 = "TextTransparency";
			v923 = v922;
			v924 = v948;
			v925 = v923[v924];
			v949 = 1;
			v926 = v925;
			v927 = v949;
			if v926 == v927 then
				v917 = true;
			end;
			v950 = tick;
			v928 = v950;
			v951 = v928();
			v929 = v951;
			alertplaytimer = v929;
			v952 = maingui;
			v953 = "alert";
			v930 = v952;
			v931 = v953;
			v954 = v930[v931];
			v955 = "Text";
			v932 = v954;
			v933 = v955;
			v934 = p103;
			v932[v933] = v934;
			v956 = maingui;
			v957 = "alert";
			v935 = v956;
			v936 = v957;
			v958 = v935[v936];
			v959 = 0;
			v960 = "TextTransparency";
			v937 = v958;
			v938 = v960;
			v939 = v959;
			v937[v938] = v939;
			v961 = maingui;
			v962 = "alert";
			v940 = v961;
			v941 = v962;
			v963 = v940[v941];
			v964 = 0;
			v965 = "TextStrokeTransparency";
			v942 = v963;
			v943 = v965;
			v944 = v964;
			v942[v943] = v944;
			v945 = p104;
			if v945 then
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
							v100({ "general_ui" }, "nightevent_start", nil, nil, true, true);
							v966 = 1 - 1;
							while true do
								maingui.NightEvent.lefticon.Position = maingui.NightEvent.lefticon.Position + UDim2.new(0.055, 0, 0, 0);
								maingui.NightEvent.righticon.Position = maingui.NightEvent.righticon.Position - UDim2.new(0.055, 0, 0, 0);
								RS:wait();
								if 0 <= 1 then
									if v966 < 10 then

									else
										break;
									end;
								elseif 10 < v966 then

								else
									break;
								end;
								v966 = v966 + 1;							
							end;
							maingui.NightEvent.lefticon.Position = UDim2.new(0.35, 0, 0.5, 0);
							maingui.NightEvent.righticon.Position = UDim2.new(0.65, 0, 0.5, 0);
							v100({ "general_ui" }, "nightevent_mid", nil, nil, true, true);
							v100({ "general_ui" }, "nightevent_scav", nil, nil, true, true);
							v967 = Instance.new("Frame");
							v967.Name = "flashwhite";
							v967.BorderSizePixel = 0;
							v967.BackgroundColor3 = Color3.new(1, 1, 1);
							v967.Size = UDim2.new(1, 0, 1, 0);
							v967.ZIndex = 3;
							v967.Parent = maingui;
							maingui.NightEvent.middletext.Visible = true;
							v968 = tick();
							while true do
								v967.BackgroundTransparency = v967.BackgroundTransparency + 0.05;
								RS:wait();
								if not (4 <= tick() - v968) then

								else
									break;
								end;							
							end;
							v967:Destroy();
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
			v969 = true;
			v946 = v917;
			v947 = v969;
			if v946 == v947 then
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
		v108.placed = 1;
		if playerstats.Settings.MuteMusic == false then
			l__workspace__1.clientmusic:Stop();
			l__workspace__1.clientmusic.SoundId = l__game__7.ReplicatedStorage.soundLibrary.gamemode.matchwin.SoundId;
			l__workspace__1.clientmusic.Volume = 1.5;
			l__workspace__1.clientmusic:Play();
		end;
		local v970, v971, v972 = ipairs(maingui:GetChildren());
		while true do
			local v973, v974 = v970(v971, v972);
			if v973 then

			else
				break;
			end;
			v972 = v973;
			if v974:IsA("ScreenGui") ~= true then
				v974.Visible = false;
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
					v100({ "gamemode" }, "cheer", nil, nil, true, true);
					v100({ "gamemode" }, "fireworks", nil, nil, true, true);
					while true do
						ply.PlayerGui.fadetoblack.frame.BackgroundTransparency = ply.PlayerGui.fadetoblack.frame.BackgroundTransparency + 0.05;
						RS:wait();
						if not (1 <= ply.PlayerGui.fadetoblack.frame.BackgroundTransparency) then

						else
							break;
						end;					
					end;
					delay(2, function()
						local v975 = l__game__7.ReplicatedStorage.effects.endgamegui:Clone();
						v975.Parent = ply.PlayerGui;
						u106(v975, "win");
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
					v100({ "events", "survevents" }, p103[2], nil, nil, true, true);
				end;
				delay(0.3, function()
					local v976 = maingui.eventframe.frameofevent:Clone();
					if p103[2] == "killswitch" then
						v976.eventname.Text = "The KillSwitch!";
						v976.desc.Text = "A master KillSwitch Panel has been placed in the center of the map!\nActivate it and see what happens!";
					elseif p103[2] == "monte" then
						v976.eventname.Text = "Three Crate Monte!";
						v976.desc.Text = "One Ulacylon Special airdrop have been delivered to the center arena!\nThe other two will go boom!";
					elseif p103[2] == "bloodrush" then
						v976.eventname.Text = "Blood Rush!";
						v976.desc.Text = "Soon, every contestant will be marked through walls with their health status!\nKills will grant a health bonus!";
						delay(7, function()
							local v977 = l__game__7.ReplicatedStorage.effects.bloodrushflash:Clone();
							l__Debris__26:AddItem(v977, 5);
							v100({ "events" }, "bloodrushsfx", nil, nil, true, true);
							afflictstatus(require(l__game__7.Workspace.ServerStuff.Statistics.S_STATISTICS)["Speedy Thrusts"]);
							v977.Parent = ply.PlayerGui;
							spawn(function()
								while true do
									v977.frame.BackgroundTransparency = v977.frame.BackgroundTransparency + 0.05;
									RS:wait();
									if not (1 <= v977.frame.BackgroundTransparency) then

									else
										break;
									end;								
								end;
							end);
							l__game__7.ReplicatedStorage.effects.bloodrush:Clone().Parent = l__game__7.Lighting;
							local v978, v979, v980 = ipairs(l__workspace__1.activePlayers:GetChildren());
							while true do
								local v981, v982 = v978(v979, v980);
								if v981 then

								else
									break;
								end;
								v980 = v981;
								if v982.Name ~= character.Name then
									if v982:FindFirstChild("Humanoid") then
										if 0 < v982:FindFirstChild("Humanoid").Health then
											if v982:FindFirstChild("Head") then
												local v983 = l__game__7.ReplicatedStorage.misc.teammateindicator:Clone();
												v983.Name = "BloodRushMarker";
												v983.AlwaysOnTop = true;
												local v984 = v982:FindFirstChild("Humanoid").Health / v982:FindFirstChild("Humanoid").MaxHealth;
												if v984 <= 0.5 then
													v984 = v984 - 0.1;
												end;
												v983.ImageLabel.ImageColor3 = Color3.new(1, v984, v984);
												v983.Adornee = v982.Head;
												v983.Parent = ply.PlayerGui;
												v982.Humanoid.Died:Connect(function()
													v983:Destroy();
												end);
											end;
										end;
									end;
								end;							
							end;
							delay(20, function()
								local v985 = l__game__7.ReplicatedStorage.effects.bloodrushflash:Clone();
								l__Debris__26:AddItem(v985, 5);
								v985.Parent = ply.PlayerGui;
								spawn(function()
									while true do
										v985.frame.BackgroundTransparency = v985.frame.BackgroundTransparency + 0.05;
										RS:wait();
										if not (1 <= v985.frame.BackgroundTransparency) then

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
								local v986, v987, v988 = ipairs(ply.PlayerGui:GetChildren());
								while true do
									local v989, v990 = v986(v987, v988);
									if v989 then

									else
										break;
									end;
									v988 = v989;
									if v990.Name == "BloodRushMarker" then
										v990:Destroy();
									end;								
								end;
							end);
						end);
					elseif p103[2] == "flareraid" then
						v976.eventname.Text = "Flare Raid!";
						v976.desc.Text = "Three Drones will fly over the arena and drop a Flare Box!\nGrab them while it's hot!";
					elseif p103[2] == "exotic" then
						v976.eventname.Text = "Exotic Armoury!";
						v976.desc.Text = "A very slow drone carrying an Airdrop with an exceedingly dangerous weapon will arrive at the map centre!";
					elseif p103[2] == "thunder" then
						v976.eventname.Text = "Rolling Thunder!";
						v976.desc.Text = "Soon, missiles will embed across the arena before exploding!\nGet to a safe bunker!";
					end;
					v976.Parent = maingui.eventframe;
					spawn(function()
						local v991 = 1 - 1;
						while true do
							v976.Position = v976.Position:Lerp(UDim2.new(0, 0, 0, 0), 0.1);
							RS:wait();
							if 0 <= 1 then
								if v991 < 60 then

								else
									break;
								end;
							elseif 60 < v991 then

							else
								break;
							end;
							v991 = v991 + 1;						
						end;
						delay(8, function()
							local v992 = 1 - 1;
							while true do
								v976.Position = v976.Position:Lerp(UDim2.new(-1.5, 0, 0, 0), 0.1);
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
							v976:Destroy();
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
	local v993 = true;
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
																			v993 = false;
																		end;
																	else
																		v993 = false;
																	end;
																else
																	v993 = false;
																end;
															else
																v993 = false;
															end;
														else
															v993 = false;
														end;
													else
														v993 = false;
													end;
												else
													v993 = false;
												end;
											else
												v993 = false;
											end;
										else
											v993 = false;
										end;
									end;
								else
									v993 = false;
								end;
							else
								v993 = false;
							end;
						else
							v993 = false;
						end;
					else
						v993 = false;
					end;
				else
					v993 = false;
				end;
			else
				v993 = false;
			end;
		else
			v993 = false;
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
											v993 = false;
										end;
									else
										v993 = false;
									end;
								else
									v993 = false;
								end;
							else
								v993 = false;
							end;
						else
							v993 = false;
						end;
					else
						v993 = false;
					end;
				else
					v993 = false;
				end;
			else
				v993 = false;
			end;
		else
			v993 = false;
		end;
	end;
	local v994 = "teamvictory";
	delay(0.1, function()
		l__workspace__1.clientmusic.Volume = 0;
		if 0 < hum.Health then
			delay(4, function()
				local v995 = l__game__7.ReplicatedStorage.effects.endgamegui:Clone();
				v995.Parent = ply.PlayerGui;
				u106(v995, "siege");
			end);
		end;
	end);
	if v993 == false then
		maingui.TeamResults.bg.ImageColor3 = Color3.new(0.8705882352941177, 0, 0);
		maingui.TeamResults.definetext.Text = "D E F E A T";
		maingui.TeamResults.lowertext.Text = "TEAM LEADER ELIMINATED";
		v994 = "teamdefeat";
	end;
	if startperk.Value ~= "tElimB" then
		if startperk.Value == "tElimA" then
			maingui.TeamResults.lowertext.Text = "OPPOSING TEAM ELIMINATED";
			if v993 == false then
				maingui.TeamResults.lowertext.Text = "CURRENT TEAM ELIMINATED";
			end;
		end;
	else
		maingui.TeamResults.lowertext.Text = "OPPOSING TEAM ELIMINATED";
		if v993 == false then
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
			if v993 == false then
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
		if v993 == false then
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
			if v993 == false then
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
		if v993 == false then
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
			if v993 == false then
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
		if v993 == false then
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
			if v993 == false then
				maingui.TeamResults.lowertext.Text = "MISSION FAILURE";
			end;
		end;
	else
		maingui.TeamResults.lowertext.Text = "MISSION SUCCESS";
		if v993 == false then
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
			if v993 == false then
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
		if v993 == false then
			if startperk.Value == "jElimA" then
				maingui.TeamResults.lowertext.Text = "TEAM WIPED OUT";
			else
				maingui.TeamResults.lowertext.Text = "JUGGERNAUT LOSS";
			end;
		end;
	end;
	v100({ "gamemode" }, v994, nil, nil, true, true);
	maingui.TeamResults.Visible = true;
	spawn(function()
		local v996 = 1 - 1;
		while true do
			maingui.TeamResults.bg.ImageTransparency = maingui.TeamResults.bg.ImageTransparency - 0.075;
			maingui.TeamResults.bg.Size = maingui.TeamResults.bg.Size:Lerp(UDim2.new(1, 0, 1, 0), 0.1);
			RS:wait();
			if 0 <= 1 then
				if v996 < 60 then

				else
					break;
				end;
			elseif 60 < v996 then

			else
				break;
			end;
			v996 = v996 + 1;		
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
		if v58.berzactive ~= nil then
			l__workspace__1.ServerStuff.dealDamage:FireServer("berzheal", nil, v4);
			local v997 = v58.berzactive + v59[3].regenonkill;
			if tick() - v997 > 0 then
				v58.berzactive = v997;
				return;
			else
				v58.berzactive = tick();
				return;
			end;
		elseif v58.gogglesactive ~= nil and v58.gogglehandledamage ~= nil then
			v58.gogglehandledamage("add");
		end;
	end;
end);
if v59[3].start_empty == true then
	v67 = tick();
end;
local u111 = v67;
local u112 = false;
l__workspace__1.ServerStuff.givePlayerIndicator.OnClientEvent:Connect(function(p108, p109)
	if startperk.Value == "hubbing" or hum.Health <= 0 then
		return;
	end;
	if (p108 == "xpadded" or p108 == "addoden") and playerstats.Settings.HideGains == true then
		return;
	end;
	v100({ "general" }, "serverindicator", nil, nil, true, true);
	local v998 = maingui.Centre.xpandgold.ex:Clone();
	l__Debris__26:AddItem(v998, 5);
	v998.Name = "notex";
	v998.Visible = true;
	v998.Position = UDim2.new(0.5, 0, 0, -16 + 16 * #maingui.Centre.xpandgold:GetChildren());
	if p108 == "xpadded" then
		v998.Text = p109 .. " XP earned.";
	elseif p108 == "addoden" then
		v998.Text = p109 .. " Odens gained.";
	elseif p108 == "levelup" then
		v998.Text = "Levelled up to " .. p109 .. ".";
	elseif p108 == "prophetscan" then
		v998.Text = p109 .. " scanned.";
	elseif p108 == "lazarusbuff" then
		v998.Text = p109 .. " Lazarus buffed.";
	elseif p108 == "immolatebuff" then
		v998.Text = p109 .. " Immolator buffed.";
		afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).FireBuff);
	elseif p108 == "ticktriggered" then
		v998.Text = "Tick has been triggered.";
	elseif p108 == "commendgiven" then
		v998.Text = p109 .. " commended.";
	elseif p108 == "commended" then
		l__workspace__1.ServerStuff.adjustStats:FireServer("tracker", { "Commendments", 1 });
		v998.Text = "Commended by " .. p109 .. ".";
	elseif p108 == "dronelatched" then
		v998.Text = "Enemy has been Mindkilled.";
	elseif p108 == "dogtag" then
		v998.Text = p109 .. " Dogtag collected.";
		if playerstats.Class == "sword" then
			maingui.PerkFrame.numberstat.Visible = true;
			if v58.dogtags == nil then
				v58.dogtags = p109;
			else
				v58.dogtags = v58.dogtags + p109;
			end;
			maingui.PerkFrame.numberstat.Text = v58.dogtags;
			local v999 = p109;
			if v59[3].dogtagmaxmovement < v58.dogtags then
				v999 = v999 - (v58.dogtags - v59[3].dogtagmaxmovement);
			end;
			if v999 > 0 then
				u22 = u22 + u13 * (v59[3].dogtagmovementbuff * v999) / 100;
			end;
		end;
	end;
	v998.Parent = maingui.Centre.xpandgold;
	spawn(function()
		while true do
			v998.gradient.ImageTransparency = v998.gradient.ImageTransparency + 0.1;
			v998.gradient.Size = v998.gradient.Size + UDim2.new(0, 2, 0, 0);
			RS:wait();
			if v998.gradient.ImageTransparency >= 1 then
				break;
			end;		
		end;
		v998.gradient.ImageTransparency = 1;
		local v1000 = tick();
		while true do
			RS:wait();
			if tick() - v1000 >= 2 then
				break;
			end;		
		end;
		while true do
			v998.TextTransparency = v998.TextTransparency + 0.1;
			v998.TextStrokeTransparency = v998.TextTransparency;
			RS:wait();
			if v998.TextTransparency >= 1 then
				break;
			end;		
		end;
		v998:Destroy();
		for v1001, v1002 in ipairs(maingui.Centre.xpandgold:GetChildren()) do
			if v1002.Name ~= "ex" and v1002.Position ~= UDim2.new(0.5, 0, 0, 0) then
				v1002.Position = v1002.Position - UDim2.new(0, 0, 0, 16);
			end;
		end;
	end);
end);
local function u113(p110, p111)
	local v1003 = p110;
	local v1004 = nil;
	for v1005, v1006 in ipairs(fparms:GetDescendants()) do
		if v1006.Name == v1003.Name and v1006:IsA("BasePart") then
			v1004 = v1006;
			v1003 = v1003:GetDescendants();
			break;
		end;
	end;
	if v1004 == nil then
		return;
	end;
	for v1007 = 1, #v1003 do
		if v1003[v1007]:IsA("BasePart") then
			v1003[v1007].Transparency = 0;
			local v1008 = Instance.new("Weld");
			v1008.Part0 = p110;
			v1008.Part1 = v1003[v1007];
			local v1009 = CFrame.new(p110.Position);
			v1008.C0 = p110.CFrame:inverse() * v1009;
			v1008.C1 = v1003[v1007].CFrame:inverse() * v1009;
			v1008.Parent = v1003[v1007];
			if p111 ~= nil then
				if v1003[v1007].Parent.Name == "primary" then
					if p111[1] ~= "original" then
						v1003[v1007].Color = Color3.new(p111[1][1], p111[1][2], p111[1][3]);
					end;
				elseif v1003[v1007].Parent.Name == "secondary" and p111[2] ~= "original" then
					v1003[v1007].Color = Color3.new(p111[2][1], p111[2][2], p111[2][3]);
				end;
			end;
			v1003[v1007].Locked = true;
			v1003[v1007].Anchored = false;
			v1003[v1007].CanCollide = false;
			v1003[v1007].Parent = p110;
		end;
	end;
	local v1010 = Instance.new("Weld");
	v1010.Part0 = v1004;
	v1010.Part1 = p110;
	v1010.C0 = CFrame.new(0, 0, 0);
	v1010.Parent = fparms.SkinParts;
	if p110.Parent.Name ~= "primary" and p110.Parent.Name ~= "secondary" then
		p110.Parent = fparms.SkinParts;
		return;
	end;
	p110.Parent.Parent = fparms.SkinParts;
end;
u80 = function(p112, p113)
	for v1011, v1012 in ipairs(fparms.SkinParts:GetChildren()) do
		v1012:Destroy();
	end;
	local v1013 = l__game__7.ReplicatedStorage.skins.firstperson:WaitForChild(p112):Clone();
	for v1014, v1015 in ipairs(fparms:GetDescendants()) do
		for v1016, v1017 in ipairs(v1013:GetChildren()) do
			if v1015.Name == v1017.Name and v1015:IsA("BasePart") then
				v1015.BrickColor = v1017.BrickColor;
			end;
		end;
	end;
	for v1018, v1019 in ipairs(v1013:GetChildren()) do
		if v1019:IsA("BasePart") then
			v1019.Transparency = 1;
			u113(v1019, p113);
		end;
	end;
	if l__CurrentCamera__1:FindFirstChild("Bottom") then
		l__CurrentCamera__1:FindFirstChild("Bottom"):Destroy();
		if character:FindFirstChild("Outfit") and character:FindFirstChild("Outfit"):FindFirstChild("Bottom") then
			character:FindFirstChild("Outfit"):FindFirstChild("Bottom"):Clone().Parent = l__workspace__1.Camera;
		end;
	end;
	if playerstats.Settings.AltSkin == true then
		for v1020, v1021 in ipairs(fparms:GetDescendants()) do
			if v1021:IsA("BasePart") and v1021.BrickColor == BrickColor.new("Pastel brown") then
				v1021.BrickColor = BrickColor.new("Dark taupe");
			end;
		end;
	end;
end;
if playerstats.Class == "damn" then
	local v1022 = l__game__7.ReplicatedStorage.misc.fpcuffs:Clone();
	v1022.cuffA.CFrame = fparms.LeftArm.LUpperArm.CFrame;
	local v1023 = Instance.new("Weld");
	v1023.Part0 = v1022.cuffA;
	v1023.Part1 = fparms.LeftArm.LUpperArm;
	v1023.C0 = CFrame.new(-85.2399902, -5.52000141, -0.500001013, 1, 0, 0, 0, 0, -1, 0, 1, 0);
	v1023.C1 = CFrame.new(-85.2399902, -5.14707661, -0.500001013, 1, 0, 0, 0, 0, -1, 0, 1, 0) * CFrame.new(0, 0, 0.6);
	v1023.Parent = v1022.cuffA;
	v1022.cuffB.CFrame = fparms.RightArm.RUpperArm.CFrame;
	local v1024 = Instance.new("Weld");
	v1024.Part0 = v1022.cuffB;
	v1024.Part1 = fparms.RightArm.RUpperArm;
	v1024.C0 = CFrame.new(-82.3999939, -5.52000141, -0.500001013, 1, 0, 0, 0, 0, -1, 0, 1, 0);
	v1024.C1 = CFrame.new(-82.3999939, -5.14707661, -0.500001013, 1, 0, 0, 0, 0, -1, 0, 1, 0) * CFrame.new(0, 0, 0.6);
	v1024.Parent = v1022.cuffB;
	v1022.Parent = fparms;
	spawn(function()
		local l__cuffs__1025 = character:WaitForChild("cuffs");
		if l__cuffs__1025 then
			l__cuffs__1025.beam.Enabled = false;
		end;
	end);
end;
function kickoutspec()
	v100({ "general" }, "keyboard", nil, nil, true, true);
	local v1026 = l__game__7.ReplicatedStorage.misc.staticflash:Clone();
	v1026.static.Disabled = false;
	v1026.Parent = ply.PlayerGui;
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
local v1027 = tick();
local v1028 = tick();
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
	local v1029 = v42;
	if p115[3] ~= nil then
		v1029 = 0;
	elseif v59[3].ammo_cd_pickup ~= nil and tick() - u111 < v59[3].cooldown then
		u111 = u111 - v59[3].ammo_cd_pickup;
	end;
	if u64[string.sub(p115[1], 1, -6)] then
		u64[string.sub(p115[1], 1, -6)] = u64[string.sub(p115[1], 1, -6)] + p115[2] + math.ceil(p115[2] * v1029);
	end;
	l__workspace__1.ServerStuff.playAudio:FireServer({ "firearms" }, "ammo_pickup", character.HumanoidRootPart, 0.1);
	invmanage("updatehud");
end);
local function v1030()
	v100({ "AGENT" }, "menu", nil, nil, true, true);
	local v1031 = maingui.TabMenu.bg.bg:Clone();
	v1031.Parent = maingui.TabMenu.bg;
	spawn(function()
		while true do
			v1031.ImageTransparency = v1031.ImageTransparency + 0.05;
			RS:wait();
			if v1031.ImageTransparency >= 1 then
				break;
			end;		
		end;
		v1031:Destroy();
	end);
end;
scrap_drop_amount = 5;
scrap_tick = tick();
function handle_scrap_drop(p116)
	scrap_drop_amount = scrap_drop_amount + p116;
	scrap_drop_amount = math.clamp(scrap_drop_amount, 0, u16);
end;
for v1032, v1033 in ipairs(maingui.TabMenu.bg.scraptab:GetChildren()) do
	if v1033:IsA("TextButton") then
		local u114 = v1028;
		v1033.MouseButton1Click:connect(function()
			v1030();
			if v1033.Name == "lessbutton" then
				handle_scrap_drop(-5);
			elseif v1033.Name == "majorlessbutton" then
				handle_scrap_drop(-25);
			elseif v1033.Name == "morebutton" then
				handle_scrap_drop(5);
			elseif v1033.Name == "majormorebutton" then
				handle_scrap_drop(25);
			end;
			if v1033.Name == "dropbutton" and u16 > 0 and tick() - scrap_tick >= 0.5 and scrap_drop_amount ~= 0 then
				u114 = tick();
				scrap_tick = tick();
				l__workspace__1.ServerStuff.dropAmmo:FireServer("scrap", scrap_drop_amount);
				u38(-scrap_drop_amount, "SCRAP DROPPED");
				handle_scrap_drop(0);
			end;
		end);
	end;
end;
for v1034, v1035 in ipairs(maingui.TabMenu.bg.ammodroptab:GetChildren()) do
	if u64[v1035.Name] then
		local u115 = v1028;
		v1035.dropbutton.MouseButton1Click:connect(function()
			if tick() - u115 >= 0.2 then
				u115 = tick();
				v1030();
				v479(v1035.Name);
			end;
		end);
	end;
end;
for v1036, v1037 in ipairs(maingui.TabMenu.bg.rationstab:GetChildren()) do
	if ration_system_handler[v1037.Name] then
		local u116 = v1028;
		v1037.eat.MouseButton1Click:connect(function()
			if tick() - u116 >= 0.2 then
				u116 = tick();
				v1030();
				if ration_system_handler[v1037.Name] > 0 then
					local v1038 = false;
					local v1039 = ration_system_handler.cooldown_eat_tick;
					if v1037.Name == "Bottle" or v1037.Name == "Soda" then
						v1038 = true;
						v1039 = ration_system_handler.cooldown_drink_tick;
					end;
					if ration_system_handler.cooldown_rations < tick() - v1039 then
						if u17.weapontype == "Fists" then
							consume_rations(v1037.Name);
							return;
						else
							maingui.Thought.thoughttext.Text = "My hands are full right now.";
							inner_dialogue = tick();
							return;
						end;
					end;
					if v1038 == true then
						maingui.Thought.thoughttext.Text = "I can't drink any more right now.";
					else
						maingui.Thought.thoughttext.Text = "I can't eat any more right now.";
					end;
					inner_dialogue = tick();
				end;
			end;
		end);
		v1037.drop.MouseButton1Click:connect(function()
			if tick() - u116 >= 0.2 then
				u116 = tick();
				v1030();
				if tick() - u75 <= 0.3 then
					return;
				end;
				u75 = tick();
				if ration_system_handler[v1037.Name] > 0 then
					ration_system_handler[v1037.Name] = ration_system_handler[v1037.Name] - 1;
					l__workspace__1.ServerStuff.dropAmmo:FireServer("rations", v1037.Name);
				end;
			end;
		end);
	end;
end;
tabmenu_options = { maingui.TabMenu.bg.ammodrop, maingui.TabMenu.bg.scrap, maingui.TabMenu.bg.weaponinfo, maingui.TabMenu.bg.rations };
for v1040, v1041 in ipairs(tabmenu_options) do
	if maingui.TabMenu.bg:FindFirstChild(v1041.Name .. "tab") then
		v1041.MouseButton1Click:connect(function()
			v1030();
			for v1042, v1043 in ipairs(tabmenu_options) do
				if maingui.TabMenu.bg:FindFirstChild(v1043.Name .. "tab") then
					maingui.TabMenu.bg:FindFirstChild(v1043.Name .. "tab").Visible = false;
					v1043.BackgroundTransparency = 0.7;
				end;
			end;
			maingui.TabMenu.bg:FindFirstChild(v1041.Name .. "tab").Visible = true;
			v1041.BackgroundTransparency = 0.3;
		end);
	end;
end;
reset_arms_timer = 0;
local u117 = v111;
local u118 = v110;
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
		local v1044 = 1 - 1;
		while true do
			l__CurrentCamera__1.CFrame = CFrame.new(character.HumanoidRootPart.Position + u31) * CFrame.Angles(0, 0, 0) * CFrame.Angles(0, 0, 0) * u117;
			camroot.CFrame = cpart.CFrame * CFrame.new(0, -1, 0.3) * CFrame.Angles(math.rad(-90), 0, math.rad(180)) * u118 * u90;
			l__CurrentCamera__1.CameraSubject = ply.Character.Humanoid;
			l__CurrentCamera__1.CameraType = "Custom";
			character.HumanoidRootPart.Anchored = false;
			ply.CameraMode = "LockFirstPerson";
			RS:wait();
			if 0 <= 1 then
				if v1044 < 10 then

				else
					break;
				end;
			elseif 10 < v1044 then

			else
				break;
			end;
			v1044 = v1044 + 1;		
		end;
	end);
	local v1045, v1046, v1047 = ipairs(maingui:GetChildren());
	while true do
		local v1048, v1049 = v1045(v1046, v1047);
		if v1048 then

		else
			break;
		end;
		v1047 = v1048;
		if v1049.Name == "snare" then
			v1049:Destroy();
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
	v100({ "weapons", "1HBL" }, "draw", nil, nil, true, true);
	spawn(function()
		while true do
			if RS:wait() then

			else
				break;
			end;
			local v1050, v1051, v1052 = pairs(globalanimsets);
			while true do
				local v1053, v1054 = v1050(v1051, v1052);
				if v1053 then

				else
					break;
				end;
				v1052 = v1053;
				if v1053 ~= "self_poke" then
					v1054:Stop(0);
				end;			
			end;
			local v1055, v1056, v1057 = pairs(tpglobalanimsets);
			while true do
				local v1058, v1059 = v1055(v1056, v1057);
				if v1058 then

				else
					break;
				end;
				v1057 = v1058;
				if v1058 ~= "pokey" then
					v1059:Stop(0);
				end;			
			end;		
		end;
	end);
	if u19 then
		u19:Destroy();
	end;
	local v1060 = l__game__7.ReplicatedStorage.misc.SwitchB:Clone();
	local v1061 = Instance.new("Motor6D");
	v1061.Name = "WeaponJoint";
	v1061.Part0 = fparms.RightArm.RUpperArm;
	v1061.Part1 = v1060.JointGrip;
	v1061.C0 = CFrame.new(0, -1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1);
	v1061.C1 = l__game__7.ReplicatedStorage.animationSets["1HBL"].weldval.Value;
	v1061.Parent = fparms.Joints;
	v1060.Parent = fparms;
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
	local v1062 = true;
	local v1063 = false;
	if u17.animset ~= "SMG" then
		if u17.animset ~= "ASMG" then
			if u17.animset ~= "RFL" then
				if u17.animset ~= "2HPST" then
					if u17.animset ~= "PST" then
						if u17.animset ~= "DBB" then
							if u17.animset == "RV" then
								local v1064 = 0;
								local v1065, v1066, v1067 = pairs(v5);
								while true do
									local v1068, v1069 = v1065(v1066, v1067);
									if v1068 then

									else
										break;
									end;
									v1067 = v1068;
									if v1069[2] == true then
										if v1069[3] ~= nil then
											v1064 = v1069[3];
										end;
									end;								
								end;
								if 0 < v1064 then
									if u17.animset ~= "DBB" then
										if u17.animset ~= "RV" then
											if u17.animset ~= "2HPST" then
												if u17.animset == "PST" then
													v1063 = true;
												end;
											else
												v1063 = true;
											end;
										else
											v1063 = true;
										end;
									else
										v1063 = true;
									end;
									v1062 = false;
								end;
							end;
						else
							v1064 = 0;
							v1065, v1066, v1067 = pairs(v5);
							while true do
								v1068, v1069 = v1065(v1066, v1067);
								if v1068 then

								else
									break;
								end;
								v1067 = v1068;
								if v1069[2] == true then
									if v1069[3] ~= nil then
										v1064 = v1069[3];
									end;
								end;							
							end;
							if 0 < v1064 then
								if u17.animset ~= "DBB" then
									if u17.animset ~= "RV" then
										if u17.animset ~= "2HPST" then
											if u17.animset == "PST" then
												v1063 = true;
											end;
										else
											v1063 = true;
										end;
									else
										v1063 = true;
									end;
								else
									v1063 = true;
								end;
								v1062 = false;
							end;
						end;
					else
						v1064 = 0;
						v1065, v1066, v1067 = pairs(v5);
						while true do
							v1068, v1069 = v1065(v1066, v1067);
							if v1068 then

							else
								break;
							end;
							v1067 = v1068;
							if v1069[2] == true then
								if v1069[3] ~= nil then
									v1064 = v1069[3];
								end;
							end;						
						end;
						if 0 < v1064 then
							if u17.animset ~= "DBB" then
								if u17.animset ~= "RV" then
									if u17.animset ~= "2HPST" then
										if u17.animset == "PST" then
											v1063 = true;
										end;
									else
										v1063 = true;
									end;
								else
									v1063 = true;
								end;
							else
								v1063 = true;
							end;
							v1062 = false;
						end;
					end;
				else
					v1064 = 0;
					v1065, v1066, v1067 = pairs(v5);
					while true do
						v1068, v1069 = v1065(v1066, v1067);
						if v1068 then

						else
							break;
						end;
						v1067 = v1068;
						if v1069[2] == true then
							if v1069[3] ~= nil then
								v1064 = v1069[3];
							end;
						end;					
					end;
					if 0 < v1064 then
						if u17.animset ~= "DBB" then
							if u17.animset ~= "RV" then
								if u17.animset ~= "2HPST" then
									if u17.animset == "PST" then
										v1063 = true;
									end;
								else
									v1063 = true;
								end;
							else
								v1063 = true;
							end;
						else
							v1063 = true;
						end;
						v1062 = false;
					end;
				end;
			else
				v1064 = 0;
				v1065, v1066, v1067 = pairs(v5);
				while true do
					v1068, v1069 = v1065(v1066, v1067);
					if v1068 then

					else
						break;
					end;
					v1067 = v1068;
					if v1069[2] == true then
						if v1069[3] ~= nil then
							v1064 = v1069[3];
						end;
					end;				
				end;
				if 0 < v1064 then
					if u17.animset ~= "DBB" then
						if u17.animset ~= "RV" then
							if u17.animset ~= "2HPST" then
								if u17.animset == "PST" then
									v1063 = true;
								end;
							else
								v1063 = true;
							end;
						else
							v1063 = true;
						end;
					else
						v1063 = true;
					end;
					v1062 = false;
				end;
			end;
		else
			v1064 = 0;
			v1065, v1066, v1067 = pairs(v5);
			while true do
				v1068, v1069 = v1065(v1066, v1067);
				if v1068 then

				else
					break;
				end;
				v1067 = v1068;
				if v1069[2] == true then
					if v1069[3] ~= nil then
						v1064 = v1069[3];
					end;
				end;			
			end;
			if 0 < v1064 then
				if u17.animset ~= "DBB" then
					if u17.animset ~= "RV" then
						if u17.animset ~= "2HPST" then
							if u17.animset == "PST" then
								v1063 = true;
							end;
						else
							v1063 = true;
						end;
					else
						v1063 = true;
					end;
				else
					v1063 = true;
				end;
				v1062 = false;
			end;
		end;
	else
		v1064 = 0;
		v1065, v1066, v1067 = pairs(v5);
		while true do
			v1068, v1069 = v1065(v1066, v1067);
			if v1068 then

			else
				break;
			end;
			v1067 = v1068;
			if v1069[2] == true then
				if v1069[3] ~= nil then
					v1064 = v1069[3];
				end;
			end;		
		end;
		if 0 < v1064 then
			if u17.animset ~= "DBB" then
				if u17.animset ~= "RV" then
					if u17.animset ~= "2HPST" then
						if u17.animset == "PST" then
							v1063 = true;
						end;
					else
						v1063 = true;
					end;
				else
					v1063 = true;
				end;
			else
				v1063 = true;
			end;
			v1062 = false;
		end;
	end;
	if v1062 == true then
		big_poke();
		return;
	end;
	v100({ "firearms" }, "ads_in", nil, nil, true, true);
	curentanimset.lower:Play(0.1, 1, 0.5);
	local u119 = nil;
	u119 = curentanimset.lower.KeyframeReached:connect(function(p117)
		if p117 == "Stop" then
			curentanimset.lower:AdjustSpeed(0);
			u119:Disconnect();
		end;
	end);
	local v1070 = tpglobalanimsets.influence_gun;
	if v1063 == true then
		v1070 = tpglobalanimsets.influence_pistol;
	end;
	v1070:Play(0.3, 1, 0.8);
	local u120 = nil;
	u120 = v1070.KeyframeReached:connect(function(p118)
		if p118 == "Stop" then
			v1070:AdjustSpeed(0);
			u120:Disconnect();
		end;
	end);
	local v1071 = tick();
	while true do
		RS:wait();
		if not (1.5 <= tick() - v1071) then

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
	v1070:Stop(0);
	local v1072, v1073, v1074 = pairs(v5);
	while true do
		local v1075, v1076 = v1072(v1073, v1074);
		if v1075 then

		else
			break;
		end;
		v1074 = v1075;
		if v1076[2] == true then
			if v1076[3] ~= nil then
				v1076[3] = v1076[3] - 1;
			end;
		end;	
	end;
	local l__Position__1077 = u19.muzzle.Position;
	l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", u17.animset }, u17.name, character.HumanoidRootPart, 0.05);
	if u17.animset ~= "LSMG" then
		if u17.name == "A.J.M. 9" then
			l__workspace__1.ServerStuff.applyGore:FireServer("firelaser", character, ply, { l__Position__1077, l__Position__1077 });
		else
			l__workspace__1.ServerStuff.applyGore:FireServer("firegun", character, ply, { l__Position__1077, l__Position__1077 });
		end;
	else
		l__workspace__1.ServerStuff.applyGore:FireServer("firelaser", character, ply, { l__Position__1077, l__Position__1077 });
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
	v100({ "shadow", "hang" }, "cast", nil, nil, true, true);
	local v1078 = "self_knife";
	local v1079 = false;
	if u17.weapontype == "Gun" then
		local v1080 = 0;
		local v1081, v1082, v1083 = pairs(v5);
		while true do
			local v1084, v1085 = v1081(v1082, v1083);
			if v1084 then

			else
				break;
			end;
			v1083 = v1084;
			if v1085[2] == true then
				if v1085[3] ~= nil then
					v1080 = v1085[3];
				end;
			end;		
		end;
		if 0 < v1080 then
			if u17.animset ~= "ASMG" then
				if u17.animset == "RFL" then
					v1078 = "self_gun";
				end;
			else
				v1078 = "self_gun";
			end;
			if u17.animset ~= "DBB" then
				if u17.animset ~= "RV" then
					if u17.animset ~= "2HPST" then
						if u17.animset == "PST" then
							v1078 = "self_gun";
							v1079 = true;
						end;
					else
						v1078 = "self_gun";
						v1079 = true;
					end;
				else
					v1078 = "self_gun";
					v1079 = true;
				end;
			else
				v1078 = "self_gun";
				v1079 = true;
			end;
			if v1078 == "self_gun" then
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
	local v1086 = nil;
	if v1078 == "self_knife" then
		v1086 = l__game__7.ReplicatedStorage.misc.SwitchB:Clone();
		local v1087 = Instance.new("Motor6D");
		v1087.Name = "WeaponJoint";
		v1087.Part0 = fparms.LeftArm.LUpperArm;
		v1087.Part1 = v1086.JointGrip;
		v1087.C0 = CFrame.new(0, -1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1);
		v1087.C1 = l__game__7.ReplicatedStorage.animationSets["1HBL"].weldval.Value;
		v1087.Parent = fparms.Joints;
		v1086.Parent = fparms;
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
		local v1088 = Instance.new("Frame");
		v1088.BackgroundColor3 = Color3.new(0, 0, 0);
		v1088.BackgroundTransparency = 0;
		v1088.Size = UDim2.new(1, 0, 1, 0);
		v1088.ZIndex = 10;
		v1088.Parent = maingui;
		while true do
			v1088.BackgroundTransparency = v1088.BackgroundTransparency + 0.03;
			RS:wait();
			if not (1 <= v1088.BackgroundTransparency) then

			else
				break;
			end;		
		end;
		v1088:Destroy();
	end);
	local v1089 = Instance.new("Frame");
	v1089.BackgroundColor3 = Color3.new(0, 0, 0);
	v1089.BackgroundTransparency = 0.3;
	v1089.Size = UDim2.new(1, 0, 1, 0);
	v1089.ZIndex = 10;
	v1089.Parent = maingui;
	influence_taps = 1;
	local v1090 = l__game__7.ReplicatedStorage.misc.warningtext:Clone();
	v1090.Text = "> E <\nRESIST THE INFLUENCE";
	v1090.Parent = maingui;
	local v1091 = tpglobalanimsets.influence_gun;
	if v1079 == true then
		v1091 = tpglobalanimsets.influence_pistol;
	end;
	if v1078 == "self_knife" then
		v1091 = tpglobalanimsets.influence_knife;
	end;
	v1091:Play(0.3, 1, 0.8);
	local u123 = nil;
	u123 = v1091.KeyframeReached:connect(function(p121)
		if p121 == "Stop" then
			v1091:AdjustSpeed(0);
			u123:Disconnect();
		end;
	end);
	local v1092 = tick();
	local v1093 = tick();
	local v1094 = 0;
	while true do
		if 1 <= tick() - v1094 then
			v1094 = tick();
			applygore("hangerPopup", character.Torso, nil);
		end;
		if 0.3 <= tick() - v1092 then
			v1092 = tick();
			if v1090.Text == "> E <\nRESIST THE INFLUENCE" then
				v1090.Text = "E\nRESIST THE INFLUENCE";
			else
				v1090.Text = "> E <\nRESIST THE INFLUENCE";
			end;
		end;
		v1090.Position = UDim2.new(0.5, math.random(-8, 8), 0.6, math.random(-8, 8));
		RS:wait();
		if not (3.8 <= tick() - v1093) then

		else
			break;
		end;	
	end;
	if v1086 then
		globalanimsets.influence_knife:Stop(0);
		v1086:Destroy();
	end;
	if curentanimset.lower then
		curentanimset.lower:Stop(0);
	end;
	v1091:Stop(0);
	v1090:Destroy();
	v1089:Destroy();
	if influence_taps < 18 then

	else
		u22 = u22 + 14;
		local v1095 = Instance.new("Frame");
		v1095.BackgroundColor3 = Color3.new(1, 1, 1);
		v1095.BackgroundTransparency = 0;
		v1095.Size = UDim2.new(1, 0, 1, 0);
		v1095.ZIndex = 10;
		v1095.Parent = maingui;
		spawn(function()
			while true do
				v1095.BackgroundTransparency = v1095.BackgroundTransparency + 0.02;
				RS:wait();
				if not (1 <= v1095.BackgroundTransparency) then

				else
					break;
				end;			
			end;
			v1095:Destroy();
		end);
		l__workspace__1.ServerStuff.handlePerkVisibility:FireServer("hide_perk");
		influence_taps = 0;
		u9.action = false;
		u9.channel = false;
		u9.staggering = false;
		u9.turnable = true;
		return;
	end;
	if v1078 == "self_gun" then
		local v1096, v1097, v1098 = pairs(v5);
		while true do
			local v1099, v1100 = v1096(v1097, v1098);
			if v1099 then

			else
				break;
			end;
			v1098 = v1099;
			if v1100[2] == true then
				if v1100[3] ~= nil then
					v1100[3] = v1100[3] - 1;
				end;
			end;		
		end;
		local l__Position__1101 = u19.muzzle.Position;
		l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", u17.animset }, u17.name, character.HumanoidRootPart, 0.05);
		if u17.animset ~= "LSMG" then
			if u17.name == "A.J.M. 9" then
				l__workspace__1.ServerStuff.applyGore:FireServer("firelaser", character, ply, { l__Position__1101, l__Position__1101 });
			else
				l__workspace__1.ServerStuff.applyGore:FireServer("firegun", character, ply, { l__Position__1101, l__Position__1101 });
			end;
		else
			l__workspace__1.ServerStuff.applyGore:FireServer("firelaser", character, ply, { l__Position__1101, l__Position__1101 });
		end;
		l__workspace__1.ServerStuff.playAudio:FireServer({ "firearms" }, "bass", character.HumanoidRootPart, 0.1);
	end;
	l__workspace__1.ServerStuff.callEvent:FireServer(v1078);
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
	local v1102 = raycastline(l__CurrentCamera__1.CFrame.p, l__CurrentCamera__1.CFrame.LookVector, 50, { l__workspace__1.NoTarget, l__workspace__1.PlayerShootThroughs, character });
	if v1102 then
		if v1102.Parent:FindFirstChild("Humanoid") then
			local v1103 = l__game__7.Players:GetPlayerFromCharacter(v1102.Parent);
			if v1103 then
				if commendedplayer[v1103.Name] == nil then
					commendedtick = tick();
					commendedplayer[v1103.Name] = true;
					commendedcount = commendedcount - 1;
					l__workspace__1.ServerStuff.callEvent:FireServer("commend", v1103.Name);
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
	for v1104, v1105 in pairs(v5) do
		if v1105[2] == true and v1105[3] <= 0 then
			return;
		end;
	end;
	for v1106, v1107 in ipairs(u19.arrow:GetChildren()) do
		if v1107:IsA("BasePart") then
			v1107.Transparency = 0;
		end;
	end;
	u9.action = true;
	curentanimset.arrow:Play(0.1);
	l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", u17.animset }, "reload", character.HumanoidRootPart);
	for v1108 = 1, 15 do
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
	local v1109, v1110 = raycastline(l__CurrentCamera__1.CFrame.p, l__CurrentCamera__1.CFrame.LookVector, 200, baselayer);
	local v1111 = 1;
	local v1112 = nil;
	if v1109 and v1109.Parent:FindFirstChild("Humanoid") and v1109.Parent:FindFirstChild("Humanoid").Health > 0 and v1109.Parent:FindFirstChild("HumanoidRootPart") and v1109.Parent:IsDescendantOf(l__workspace__1.activeHostiles) then
		v1110 = v1109.Parent:FindFirstChild("HumanoidRootPart").Position;
		v1111 = 2;
	end;
	if v1109 and v1109.Name == "JointGrip" then
		if v17[v1109.Parent.Name] then
			v1112 = v17[v1109.Parent.Name].name;
		end;
		v1110 = v1109.Position;
		v1111 = 3;
	end;
	if v1109 and v1109.Name == "Interact" and v1109.Parent:IsDescendantOf(l__workspace__1.Interactables) then
		v1112 = v1109.Parent.Name;
		v1110 = v1109.Position;
		v1111 = 4;
	end;
	if v1109 and (v1109.Name == "HarvestWood" or v1109.Name == "HarvestStone") and v1109.Parent:IsDescendantOf(l__workspace__1.Interactables) then
		v1112 = "Wood Pile";
		if v1109.Name == "HarvestStone" then
			v1112 = "Stone Pile";
		end;
		v1110 = v1109.Position;
		v1111 = 5;
	end;
	l__workspace__1.ServerStuff.applyGore:FireServer("player_ping", character, ply, { v1110, ply.Name, v1111, v1112 });
end;
local u126 = false;
local function u127()
	if can_player_sprint == false then
		return;
	end;
	if u30.w ~= false and u9.air ~= true and u9.channel ~= true and u9.sprinting ~= true then
		if u10.Cripple and u10.Painkillers == nil and v58.berzactive == nil then
			return;
		elseif tick() - sprint_lockout <= 0.1 then
			return;
		else
			u9.sprinting = false;
			RS:wait();
			sprint_lockout = tick();
			u9.sprinting = true;
			u9.sneaking = false;
			local v1113 = u11 * 1;
			u22 = u22 + v1113;
			if playerperks.stealth == nil and character:FindFirstChild("Head") and character.Head:FindFirstChild("Running") then
				character.Head.Running:Play();
			end;
			slide_wait = tick() - 0.5;
			l__workspace__1.ServerStuff.movementAdjust:FireServer("sprint", true, v1113 / 8);
			local v1114 = 0;
			while true do
				if character:FindFirstChild("Head") and character.Head:FindFirstChild("Running") then
					character.Head.Running.Volume = 1;
				end;
				if u9.action == false and u9.aiming == false and u9.swapping == false then
					gun_holster_timer = 0;
				end;
				RS:wait();
				u25(nil);
				if tick() - v1114 > 0.125 then
					v1114 = tick();
					if sprint_stam > 0 and u10["Speed Buff"] == nil then
						sprint_stam = sprint_stam - 1;
					end;
					u26("stamina");
				end;
				if sprint_stam <= 0 then
					afflictstatus(require(l__game__7.Workspace.ServerStuff.Statistics.S_STATISTICS).Exha);
				end;
				if u10.Cripple and u10.Painkillers == nil and v58.berzactive == nil then
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
			u22 = u22 - v1113;
			return;
		end;
	end;
end;
local function u128()
	if (u9.action ~= true or u9.swapping ~= false) and u9.channel ~= true and u9.air ~= false then
		local v1115 = { "N", "N", "N" };
		local v1116, v1117 = raycastline(character.HumanoidRootPart.CFrame.p, character.HumanoidRootPart.CFrame.lookVector, 2, baselayer);
		if v1116 and not v1116.Parent:FindFirstChild("Humanoid") then
			v1115[1] = "Y";
		end;
		local v1118, v1119 = raycastline((character.HumanoidRootPart.CFrame + Vector3.new(0, 2.5, 0)).p, character.HumanoidRootPart.CFrame.lookVector, 2, baselayer);
		if not v1118 then
			v1115[2] = "Y";
		end;
		local v1120, v1121 = raycastline((character.HumanoidRootPart.CFrame + Vector3.new(0, 6, 0)).p, character.HumanoidRootPart.CFrame.lookVector, 2, baselayer);
		if not v1120 then
			v1115[3] = "Y";
		end;
		if table.concat(v1115) == "YYY" then
			l__workspace__1.ServerStuff.adjustStats:FireServer("tracker", { "Mantles", 1 });
			u9.canjump = false;
			shakecamera("climb");
			globalanimsets.climb:Play(0.1, 1, 1);
			tpglobalanimsets.climb:Play(0.1, 1, 1);
			l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "mantle", character.HumanoidRootPart);
			u9.action = true;
			local v1122 = Instance.new("BodyPosition");
			v1122.Name = "parkourPositionThing";
			v1122.MaxForce = Vector3.new(200000, 200000, 200000);
			v1122.P = 2000;
			v1122.D = 500;
			v1122.Position = character.HumanoidRootPart.Position + Vector3.new(0, 5, 0) + character.HumanoidRootPart.CFrame.lookVector * 5;
			v1122.Parent = character.HumanoidRootPart;
			u8 = u8 + 40;
			u26("stamina");
			delay(0.4, function()
				v1122:Destroy();
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
	local l__ammo__1123 = l__game__7.ReplicatedStorage.Weapons:FindFirstChild(u19.Name):FindFirstChild("ammo");
	if l__ammo__1123 ~= nil and u9.action ~= true and u17.ammoused ~= nil and not (tick() - reload_locklout <= 2) then
		local l__Value__1124 = l__ammo__1123.Value;
		local v1125 = false;
		if u64[u17.ammoused] == nil or u64[u17.ammoused] <= 0 then
			v1125 = true;
		end;
		local v1126 = false;
		local v1127 = false;
		local v1128 = nil;
		local v1129 = 0;
		local v1130 = true;
		if akimbo_factors.active == true then
			v1126 = true;
			if v5[akimbo_factors.weapon_slot][3] then
				v1128 = v5[akimbo_factors.weapon_slot][3];
				if v1128 <= 0 then
					v1127 = true;
				end;
			end;
			v1129 = l__game__7.ReplicatedStorage.Weapons:FindFirstChild(v5[akimbo_factors.weapon_slot][1]):FindFirstChild("ammo").Value;
			if u64[akimbo_factors.alt_weapon_stats.ammoused] ~= nil then
				local v1131 = nil;
				local v1132 = nil;
				if u64[akimbo_factors.alt_weapon_stats.ammoused] <= 0 then
					if v1125 == true then
						return;
					else
						v1131 = v1128;
						v1132 = l__Value__1124;
						if v1131 == v1132 and v1125 == true then
							return;
						elseif v1125 == true and v1130 == true then
							return;
						else
							local v1133 = nil;
							for v1134, v1135 in pairs(v5) do
								if v1135[2] == true and v1135[3] ~= nil then
									v1133 = v1135[3];
									if l__Value__1124 <= v1135[3] and v1126 == false then
										return;
									end;
								end;
							end;
							if v1133 == l__Value__1124 and v1126 == false then
								return;
							elseif v1128 == v1129 and v1133 == l__Value__1124 then
								return;
							else
								local v1136 = false;
								if v1133 == 0 then
									v1136 = true;
								end;
								u9.action = true;
								reload_locklout = tick();
								local v1137 = { globalanimsets.reload, tpglobalanimsets.reloadloop };
								if u17.animset == "MRV" then
									v1137 = { curentanimset.reload, tpglobalanimsets.reloadloop };
								end;
								if akimbo_factors.active == true then
									v1137 = { akimbosets.reload, tpglobalanimsets.reloadloop };
								end;
								v1137[1]:Play(0.3);
								v1137[2]:Play(0.3);
								local u132 = nil;
								u132 = v1137[1].KeyframeReached:connect(function(p123)
									if p123 == "Stop" then
										v1137[1]:AdjustSpeed(0);
										u132:Disconnect();
									end;
								end);
								local u133 = nil;
								u133 = v1137[2].KeyframeReached:connect(function(p124)
									if p124 == "Stop" then
										v1137[2]:AdjustSpeed(0);
										u133:Disconnect();
									end;
								end);
								local v1138 = tick();
								local v1139 = 1.5 * u17.throwrating;
								local v1140 = l__Value__1124 - v1133;
								if u64[u17.ammoused] < v1140 then
									v1140 = u64[u17.ammoused];
								end;
								u64[u17.ammoused] = u64[u17.ammoused] - v1140;
								if u64[u17.ammoused] < 0 then
									u64[u17.ammoused] = 0;
								end;
								if u64[u17.ammoused] > 1000 then
									ply:Kick(filth[math.random(1, #filth)]);
								end;
								if akimbo_factors.active == true then
									local v1141 = v1129 - v1128;
									if u64[akimbo_factors.alt_weapon_stats.ammoused] < v1141 then
										v1141 = u64[akimbo_factors.alt_weapon_stats.ammoused];
									end;
									u64[akimbo_factors.alt_weapon_stats.ammoused] = u64[akimbo_factors.alt_weapon_stats.ammoused] - 0;
									if u64[akimbo_factors.alt_weapon_stats.ammoused] < 0 then
										u64[akimbo_factors.alt_weapon_stats.ammoused] = 0;
									end;
									v1139 = 1.5 * u17.throwrating + 1.5 * akimbo_factors.alt_weapon_stats.throwrating / 1.5;
								end;
								local v1142 = 1;
								local v1143 = "pistol";
								local v1144 = "pistol";
								if u17.animset == "RFL" or u17.animset == "SMG" or u17.animset == "ASMG" then
									v1143 = "rifle";
								end;
								if u17.name == "AK-74" or u17.name == "MCX VIRTUS" or u17.name == "AS Val" or u17.name == "FAMAS F1" or u17.name == "FN SCAR-H" or u17.name == "R11 RSASS" then
									v1143 = "ar";
								end;
								if u17.name == "Modded Rifle" or u17.name == "PGM FR-12.7" or u17.name == "M60-E6" then
									v1143 = "sniper";
								end;
								if u17.name == "Model 6 Unica" then
									v1143 = "rv";
								end;
								if u17.name == "Karabiner 98k" or u17.name == "M1891 Avtomat" or u17.name == "Dolch 96" then
									v1143 = "clip";
								end;
								local v1145 = v1139 * u65 / v1139;
								if u17.name == "SPAS-12" or u17.name == "Caldwell Handcannon" or u17.name == "Caldwell 940" or u17.name == "Model 870" or u17.name == "Kel-Tec KSG" or u17.name == "MVD KS-23" then
									v1145 = 0;
									v1139 = 0.5 * (u17.throwrating - u17.throwrating * u65 / u17.throwrating);
									v1143 = "shotgun";
									v1142 = v1140;
								end;
								local v1146 = false;
								local v1147 = false;
								local v1148 = false;
								if u17.name == "Remington 700" or u17.name == "Peacemaker" or u17.name == "Peacemaker Uppercut" or u17.name == "Peacemaker Chain" or u17.name == "'The Redeemer'" or u17.name == "Winchester 940-1" then
									local v1149 = 0;
									local v1150 = 0.4;
									if akimbo_factors.active == true then
										v1150 = 0.6;
									end;
									v1139 = v1150 * (u17.throwrating - u17.throwrating * u65 / u17.throwrating);
									v1143 = "single";
									v1142 = v1140;
									v1146 = true;
								end;
								if u17.name == "Commissioned Musket" then
									v1143 = "single";
								end;
								if akimbo_factors.active == true then
									if akimbo_factors.alt_weapon_stats.name == "Model 6 Unica" then
										v1144 = "rv";
									end;
									if akimbo_factors.alt_weapon_stats.name == "Peacemaker" or akimbo_factors.alt_weapon_stats.name == "'The Redeemer'" or u17.name == "Peacemaker Uppercut" or u17.name == "Peacemaker Chain" then
										v1149 = 0;
										v1139 = 0.6 * (akimbo_factors.alt_weapon_stats.throwrating - akimbo_factors.alt_weapon_stats.throwrating * u65 / akimbo_factors.alt_weapon_stats.throwrating);
										v1144 = "single";
										v1142 = 0;
										if v1146 == true then
											v1142 = v1142 + v1140;
										else
											v1147 = true;
										end;
									end;
								end;
								local v1151 = v1139 - v1149;
								l__workspace__1.ServerStuff.playAudio:FireServer({ "reloads" }, v1143 .. "_start", character.HumanoidRootPart, 0.05);
								if akimbo_factors.active == true then
									delay(0.3, function()
										l__workspace__1.ServerStuff.playAudio:FireServer({ "reloads" }, v1144 .. "_start", character.HumanoidRootPart, 0.05);
									end);
								end;
								for v1152 = 1, v1142 do
									local v1153 = false;
									while true do
										if v1151 / 2 < tick() - v1138 and v1153 == false then
											if v1147 == true then
												v1143 = v1144;
												v1144 = v1144;
											end;
											l__workspace__1.ServerStuff.playAudio:FireServer({ "reloads" }, v1143 .. "_mid", character.HumanoidRootPart, 0.05);
											if u17.name == "M1891 Avtomat" then
												delay(1, function()
													l__workspace__1.ServerStuff.playAudio:FireServer({ "reloads" }, v1143 .. "_mid", character.HumanoidRootPart, 0.05);
													delay(1, function()
														l__workspace__1.ServerStuff.playAudio:FireServer({ "reloads" }, v1143 .. "_mid", character.HumanoidRootPart, 0.05);
													end);
												end);
											end;
											if akimbo_factors.active == true then
												if v1147 == true or v1146 == true then
													if v1148 == false and math.floor(v1142 / 2) <= v1152 then
														v1148 = true;
														delay(0.4, function()
															l__workspace__1.ServerStuff.playAudio:FireServer({ "reloads" }, v1144 .. "_mid", character.HumanoidRootPart, 0.05);
														end);
													end;
												else
													delay(0.4, function()
														l__workspace__1.ServerStuff.playAudio:FireServer({ "reloads" }, v1144 .. "_mid", character.HumanoidRootPart, 0.05);
													end);
												end;
											end;
										end;
										if u17.weapontype ~= "Gun" then
											u9.action = false;
											v1137[1]:Stop(0.5);
											v1137[2]:Stop(0.5);
											return;
										end;
										RS:wait();
										if v1151 < tick() - v1138 then
											break;
										end;									
									end;
									v1138 = tick();
								end;
								local v1154 = 0.5;
								if playerperks.reliab then
									v1136 = false;
									v1127 = false;
									v1154 = 0.2;
								end;
								if v1136 == true then
									l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "reloaddone", character.HumanoidRootPart, 0.05);
									local v1155 = tick();
									while true do
										RS:wait();
										if tick() - v1155 > 0.8 then
											break;
										end;									
									end;
								else
									l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "reloadpartial", character.HumanoidRootPart, 0.05);
								end;
								if akimbo_factors.active == true then
									local v1156 = tick();
									while true do
										RS:wait();
										if v1154 < tick() - v1156 then
											break;
										end;									
									end;
									if v1127 == true then
										l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "reloaddone", character.HumanoidRootPart, 0.05);
										local v1157 = tick();
										while true do
											RS:wait();
											if tick() - v1157 > 0.8 then
												break;
											end;										
										end;
									else
										l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "reloadpartial", character.HumanoidRootPart, 0.05);
									end;
								end;
								v1137[1]:Stop(0.5);
								v1137[2]:Stop(0.5);
								for v1158, v1159 in pairs(v5) do
									if v1159[2] == true and v1159[3] ~= nil then
										v1159[3] = v1159[3] + v1140;
									end;
								end;
								if akimbo_factors.active == true then
									v5[akimbo_factors.weapon_slot][3] = v5[akimbo_factors.weapon_slot][3] + 0;
								end;
								invmanage("updatehud");
								local v1160 = tick();
								local v1161 = 0.2;
								while true do
									RS:wait();
									if v1161 < tick() - v1160 then
										break;
									end;								
								end;
								u9.action = false;
								return;
							end;
						end;
					end;
				else
					v1130 = false;
					v1131 = v1128;
					v1132 = l__Value__1124;
					if v1131 == v1132 and v1125 == true then
						return;
					elseif v1125 == true and v1130 == true then
						return;
					else
						v1133 = nil;
						for v1134, v1135 in pairs(v5) do
							if v1135[2] == true and v1135[3] ~= nil then
								v1133 = v1135[3];
								if l__Value__1124 <= v1135[3] and v1126 == false then
									return;
								end;
							end;
						end;
						if v1133 == l__Value__1124 and v1126 == false then
							return;
						elseif v1128 == v1129 and v1133 == l__Value__1124 then
							return;
						else
							v1136 = false;
							if v1133 == 0 then
								v1136 = true;
							end;
							u9.action = true;
							reload_locklout = tick();
							v1137 = { globalanimsets.reload, tpglobalanimsets.reloadloop };
							if u17.animset == "MRV" then
								v1137 = { curentanimset.reload, tpglobalanimsets.reloadloop };
							end;
							if akimbo_factors.active == true then
								v1137 = { akimbosets.reload, tpglobalanimsets.reloadloop };
							end;
							v1137[1]:Play(0.3);
							v1137[2]:Play(0.3);
							u132 = nil;
							u132 = v1137[1].KeyframeReached:connect(function(p123)
								if p123 == "Stop" then
									v1137[1]:AdjustSpeed(0);
									u132:Disconnect();
								end;
							end);
							u133 = nil;
							u133 = v1137[2].KeyframeReached:connect(function(p124)
								if p124 == "Stop" then
									v1137[2]:AdjustSpeed(0);
									u133:Disconnect();
								end;
							end);
							v1138 = tick();
							v1139 = 1.5 * u17.throwrating;
							v1140 = l__Value__1124 - v1133;
							if u64[u17.ammoused] < v1140 then
								v1140 = u64[u17.ammoused];
							end;
							u64[u17.ammoused] = u64[u17.ammoused] - v1140;
							if u64[u17.ammoused] < 0 then
								u64[u17.ammoused] = 0;
							end;
							if u64[u17.ammoused] > 1000 then
								ply:Kick(filth[math.random(1, #filth)]);
							end;
							if akimbo_factors.active == true then
								v1141 = v1129 - v1128;
								if u64[akimbo_factors.alt_weapon_stats.ammoused] < v1141 then
									v1141 = u64[akimbo_factors.alt_weapon_stats.ammoused];
								end;
								u64[akimbo_factors.alt_weapon_stats.ammoused] = u64[akimbo_factors.alt_weapon_stats.ammoused] - 0;
								if u64[akimbo_factors.alt_weapon_stats.ammoused] < 0 then
									u64[akimbo_factors.alt_weapon_stats.ammoused] = 0;
								end;
								v1139 = 1.5 * u17.throwrating + 1.5 * akimbo_factors.alt_weapon_stats.throwrating / 1.5;
							end;
							v1142 = 1;
							v1143 = "pistol";
							v1144 = "pistol";
							if u17.animset == "RFL" or u17.animset == "SMG" or u17.animset == "ASMG" then
								v1143 = "rifle";
							end;
							if u17.name == "AK-74" or u17.name == "MCX VIRTUS" or u17.name == "AS Val" or u17.name == "FAMAS F1" or u17.name == "FN SCAR-H" or u17.name == "R11 RSASS" then
								v1143 = "ar";
							end;
							if u17.name == "Modded Rifle" or u17.name == "PGM FR-12.7" or u17.name == "M60-E6" then
								v1143 = "sniper";
							end;
							if u17.name == "Model 6 Unica" then
								v1143 = "rv";
							end;
							if u17.name == "Karabiner 98k" or u17.name == "M1891 Avtomat" or u17.name == "Dolch 96" then
								v1143 = "clip";
							end;
							v1145 = v1139 * u65 / v1139;
							if u17.name == "SPAS-12" or u17.name == "Caldwell Handcannon" or u17.name == "Caldwell 940" or u17.name == "Model 870" or u17.name == "Kel-Tec KSG" or u17.name == "MVD KS-23" then
								v1145 = 0;
								v1139 = 0.5 * (u17.throwrating - u17.throwrating * u65 / u17.throwrating);
								v1143 = "shotgun";
								v1142 = v1140;
							end;
							v1146 = false;
							v1147 = false;
							v1148 = false;
							if u17.name == "Remington 700" or u17.name == "Peacemaker" or u17.name == "Peacemaker Uppercut" or u17.name == "Peacemaker Chain" or u17.name == "'The Redeemer'" or u17.name == "Winchester 940-1" then
								v1149 = 0;
								v1150 = 0.4;
								if akimbo_factors.active == true then
									v1150 = 0.6;
								end;
								v1139 = v1150 * (u17.throwrating - u17.throwrating * u65 / u17.throwrating);
								v1143 = "single";
								v1142 = v1140;
								v1146 = true;
							end;
							if u17.name == "Commissioned Musket" then
								v1143 = "single";
							end;
							if akimbo_factors.active == true then
								if akimbo_factors.alt_weapon_stats.name == "Model 6 Unica" then
									v1144 = "rv";
								end;
								if akimbo_factors.alt_weapon_stats.name == "Peacemaker" or akimbo_factors.alt_weapon_stats.name == "'The Redeemer'" or u17.name == "Peacemaker Uppercut" or u17.name == "Peacemaker Chain" then
									v1149 = 0;
									v1139 = 0.6 * (akimbo_factors.alt_weapon_stats.throwrating - akimbo_factors.alt_weapon_stats.throwrating * u65 / akimbo_factors.alt_weapon_stats.throwrating);
									v1144 = "single";
									v1142 = 0;
									if v1146 == true then
										v1142 = v1142 + v1140;
									else
										v1147 = true;
									end;
								end;
							end;
							v1151 = v1139 - v1149;
							l__workspace__1.ServerStuff.playAudio:FireServer({ "reloads" }, v1143 .. "_start", character.HumanoidRootPart, 0.05);
							if akimbo_factors.active == true then
								delay(0.3, function()
									l__workspace__1.ServerStuff.playAudio:FireServer({ "reloads" }, v1144 .. "_start", character.HumanoidRootPart, 0.05);
								end);
							end;
							for v1152 = 1, v1142 do
								v1153 = false;
								while true do
									if v1151 / 2 < tick() - v1138 and v1153 == false then
										if v1147 == true then
											v1143 = v1144;
											v1144 = v1144;
										end;
										l__workspace__1.ServerStuff.playAudio:FireServer({ "reloads" }, v1143 .. "_mid", character.HumanoidRootPart, 0.05);
										if u17.name == "M1891 Avtomat" then
											delay(1, function()
												l__workspace__1.ServerStuff.playAudio:FireServer({ "reloads" }, v1143 .. "_mid", character.HumanoidRootPart, 0.05);
												delay(1, function()
													l__workspace__1.ServerStuff.playAudio:FireServer({ "reloads" }, v1143 .. "_mid", character.HumanoidRootPart, 0.05);
												end);
											end);
										end;
										if akimbo_factors.active == true then
											if v1147 == true or v1146 == true then
												if v1148 == false and math.floor(v1142 / 2) <= v1152 then
													v1148 = true;
													delay(0.4, function()
														l__workspace__1.ServerStuff.playAudio:FireServer({ "reloads" }, v1144 .. "_mid", character.HumanoidRootPart, 0.05);
													end);
												end;
											else
												delay(0.4, function()
													l__workspace__1.ServerStuff.playAudio:FireServer({ "reloads" }, v1144 .. "_mid", character.HumanoidRootPart, 0.05);
												end);
											end;
										end;
									end;
									if u17.weapontype ~= "Gun" then
										u9.action = false;
										v1137[1]:Stop(0.5);
										v1137[2]:Stop(0.5);
										return;
									end;
									RS:wait();
									if v1151 < tick() - v1138 then
										break;
									end;								
								end;
								v1138 = tick();
							end;
							v1154 = 0.5;
							if playerperks.reliab then
								v1136 = false;
								v1127 = false;
								v1154 = 0.2;
							end;
							if v1136 == true then
								l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "reloaddone", character.HumanoidRootPart, 0.05);
								v1155 = tick();
								while true do
									RS:wait();
									if tick() - v1155 > 0.8 then
										break;
									end;								
								end;
							else
								l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "reloadpartial", character.HumanoidRootPart, 0.05);
							end;
							if akimbo_factors.active == true then
								v1156 = tick();
								while true do
									RS:wait();
									if v1154 < tick() - v1156 then
										break;
									end;								
								end;
								if v1127 == true then
									l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "reloaddone", character.HumanoidRootPart, 0.05);
									v1157 = tick();
									while true do
										RS:wait();
										if tick() - v1157 > 0.8 then
											break;
										end;									
									end;
								else
									l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "reloadpartial", character.HumanoidRootPart, 0.05);
								end;
							end;
							v1137[1]:Stop(0.5);
							v1137[2]:Stop(0.5);
							for v1158, v1159 in pairs(v5) do
								if v1159[2] == true and v1159[3] ~= nil then
									v1159[3] = v1159[3] + v1140;
								end;
							end;
							if akimbo_factors.active == true then
								v5[akimbo_factors.weapon_slot][3] = v5[akimbo_factors.weapon_slot][3] + 0;
							end;
							invmanage("updatehud");
							v1160 = tick();
							v1161 = 0.2;
							while true do
								RS:wait();
								if v1161 < tick() - v1160 then
									break;
								end;							
							end;
							u9.action = false;
							return;
						end;
					end;
				end;
			elseif v1125 == true then
				return;
			else
				v1131 = v1128;
				v1132 = l__Value__1124;
				if v1131 == v1132 and v1125 == true then
					return;
				elseif v1125 == true and v1130 == true then
					return;
				else
					v1133 = nil;
					for v1134, v1135 in pairs(v5) do
						if v1135[2] == true and v1135[3] ~= nil then
							v1133 = v1135[3];
							if l__Value__1124 <= v1135[3] and v1126 == false then
								return;
							end;
						end;
					end;
					if v1133 == l__Value__1124 and v1126 == false then
						return;
					elseif v1128 == v1129 and v1133 == l__Value__1124 then
						return;
					else
						v1136 = false;
						if v1133 == 0 then
							v1136 = true;
						end;
						u9.action = true;
						reload_locklout = tick();
						v1137 = { globalanimsets.reload, tpglobalanimsets.reloadloop };
						if u17.animset == "MRV" then
							v1137 = { curentanimset.reload, tpglobalanimsets.reloadloop };
						end;
						if akimbo_factors.active == true then
							v1137 = { akimbosets.reload, tpglobalanimsets.reloadloop };
						end;
						v1137[1]:Play(0.3);
						v1137[2]:Play(0.3);
						u132 = nil;
						u132 = v1137[1].KeyframeReached:connect(function(p123)
							if p123 == "Stop" then
								v1137[1]:AdjustSpeed(0);
								u132:Disconnect();
							end;
						end);
						u133 = nil;
						u133 = v1137[2].KeyframeReached:connect(function(p124)
							if p124 == "Stop" then
								v1137[2]:AdjustSpeed(0);
								u133:Disconnect();
							end;
						end);
						v1138 = tick();
						v1139 = 1.5 * u17.throwrating;
						v1140 = l__Value__1124 - v1133;
						if u64[u17.ammoused] < v1140 then
							v1140 = u64[u17.ammoused];
						end;
						u64[u17.ammoused] = u64[u17.ammoused] - v1140;
						if u64[u17.ammoused] < 0 then
							u64[u17.ammoused] = 0;
						end;
						if u64[u17.ammoused] > 1000 then
							ply:Kick(filth[math.random(1, #filth)]);
						end;
						if akimbo_factors.active == true then
							v1141 = v1129 - v1128;
							if u64[akimbo_factors.alt_weapon_stats.ammoused] < v1141 then
								v1141 = u64[akimbo_factors.alt_weapon_stats.ammoused];
							end;
							u64[akimbo_factors.alt_weapon_stats.ammoused] = u64[akimbo_factors.alt_weapon_stats.ammoused] - 0;
							if u64[akimbo_factors.alt_weapon_stats.ammoused] < 0 then
								u64[akimbo_factors.alt_weapon_stats.ammoused] = 0;
							end;
							v1139 = 1.5 * u17.throwrating + 1.5 * akimbo_factors.alt_weapon_stats.throwrating / 1.5;
						end;
						v1142 = 1;
						v1143 = "pistol";
						v1144 = "pistol";
						if u17.animset == "RFL" or u17.animset == "SMG" or u17.animset == "ASMG" then
							v1143 = "rifle";
						end;
						if u17.name == "AK-74" or u17.name == "MCX VIRTUS" or u17.name == "AS Val" or u17.name == "FAMAS F1" or u17.name == "FN SCAR-H" or u17.name == "R11 RSASS" then
							v1143 = "ar";
						end;
						if u17.name == "Modded Rifle" or u17.name == "PGM FR-12.7" or u17.name == "M60-E6" then
							v1143 = "sniper";
						end;
						if u17.name == "Model 6 Unica" then
							v1143 = "rv";
						end;
						if u17.name == "Karabiner 98k" or u17.name == "M1891 Avtomat" or u17.name == "Dolch 96" then
							v1143 = "clip";
						end;
						v1145 = v1139 * u65 / v1139;
						if u17.name == "SPAS-12" or u17.name == "Caldwell Handcannon" or u17.name == "Caldwell 940" or u17.name == "Model 870" or u17.name == "Kel-Tec KSG" or u17.name == "MVD KS-23" then
							v1145 = 0;
							v1139 = 0.5 * (u17.throwrating - u17.throwrating * u65 / u17.throwrating);
							v1143 = "shotgun";
							v1142 = v1140;
						end;
						v1146 = false;
						v1147 = false;
						v1148 = false;
						if u17.name == "Remington 700" or u17.name == "Peacemaker" or u17.name == "Peacemaker Uppercut" or u17.name == "Peacemaker Chain" or u17.name == "'The Redeemer'" or u17.name == "Winchester 940-1" then
							v1149 = 0;
							v1150 = 0.4;
							if akimbo_factors.active == true then
								v1150 = 0.6;
							end;
							v1139 = v1150 * (u17.throwrating - u17.throwrating * u65 / u17.throwrating);
							v1143 = "single";
							v1142 = v1140;
							v1146 = true;
						end;
						if u17.name == "Commissioned Musket" then
							v1143 = "single";
						end;
						if akimbo_factors.active == true then
							if akimbo_factors.alt_weapon_stats.name == "Model 6 Unica" then
								v1144 = "rv";
							end;
							if akimbo_factors.alt_weapon_stats.name == "Peacemaker" or akimbo_factors.alt_weapon_stats.name == "'The Redeemer'" or u17.name == "Peacemaker Uppercut" or u17.name == "Peacemaker Chain" then
								v1149 = 0;
								v1139 = 0.6 * (akimbo_factors.alt_weapon_stats.throwrating - akimbo_factors.alt_weapon_stats.throwrating * u65 / akimbo_factors.alt_weapon_stats.throwrating);
								v1144 = "single";
								v1142 = 0;
								if v1146 == true then
									v1142 = v1142 + v1140;
								else
									v1147 = true;
								end;
							end;
						end;
						v1151 = v1139 - v1149;
						l__workspace__1.ServerStuff.playAudio:FireServer({ "reloads" }, v1143 .. "_start", character.HumanoidRootPart, 0.05);
						if akimbo_factors.active == true then
							delay(0.3, function()
								l__workspace__1.ServerStuff.playAudio:FireServer({ "reloads" }, v1144 .. "_start", character.HumanoidRootPart, 0.05);
							end);
						end;
						for v1152 = 1, v1142 do
							v1153 = false;
							while true do
								if v1151 / 2 < tick() - v1138 and v1153 == false then
									if v1147 == true then
										v1143 = v1144;
										v1144 = v1144;
									end;
									l__workspace__1.ServerStuff.playAudio:FireServer({ "reloads" }, v1143 .. "_mid", character.HumanoidRootPart, 0.05);
									if u17.name == "M1891 Avtomat" then
										delay(1, function()
											l__workspace__1.ServerStuff.playAudio:FireServer({ "reloads" }, v1143 .. "_mid", character.HumanoidRootPart, 0.05);
											delay(1, function()
												l__workspace__1.ServerStuff.playAudio:FireServer({ "reloads" }, v1143 .. "_mid", character.HumanoidRootPart, 0.05);
											end);
										end);
									end;
									if akimbo_factors.active == true then
										if v1147 == true or v1146 == true then
											if v1148 == false and math.floor(v1142 / 2) <= v1152 then
												v1148 = true;
												delay(0.4, function()
													l__workspace__1.ServerStuff.playAudio:FireServer({ "reloads" }, v1144 .. "_mid", character.HumanoidRootPart, 0.05);
												end);
											end;
										else
											delay(0.4, function()
												l__workspace__1.ServerStuff.playAudio:FireServer({ "reloads" }, v1144 .. "_mid", character.HumanoidRootPart, 0.05);
											end);
										end;
									end;
								end;
								if u17.weapontype ~= "Gun" then
									u9.action = false;
									v1137[1]:Stop(0.5);
									v1137[2]:Stop(0.5);
									return;
								end;
								RS:wait();
								if v1151 < tick() - v1138 then
									break;
								end;							
							end;
							v1138 = tick();
						end;
						v1154 = 0.5;
						if playerperks.reliab then
							v1136 = false;
							v1127 = false;
							v1154 = 0.2;
						end;
						if v1136 == true then
							l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "reloaddone", character.HumanoidRootPart, 0.05);
							v1155 = tick();
							while true do
								RS:wait();
								if tick() - v1155 > 0.8 then
									break;
								end;							
							end;
						else
							l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "reloadpartial", character.HumanoidRootPart, 0.05);
						end;
						if akimbo_factors.active == true then
							v1156 = tick();
							while true do
								RS:wait();
								if v1154 < tick() - v1156 then
									break;
								end;							
							end;
							if v1127 == true then
								l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "reloaddone", character.HumanoidRootPart, 0.05);
								v1157 = tick();
								while true do
									RS:wait();
									if tick() - v1157 > 0.8 then
										break;
									end;								
								end;
							else
								l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "reloadpartial", character.HumanoidRootPart, 0.05);
							end;
						end;
						v1137[1]:Stop(0.5);
						v1137[2]:Stop(0.5);
						for v1158, v1159 in pairs(v5) do
							if v1159[2] == true and v1159[3] ~= nil then
								v1159[3] = v1159[3] + v1140;
							end;
						end;
						if akimbo_factors.active == true then
							v5[akimbo_factors.weapon_slot][3] = v5[akimbo_factors.weapon_slot][3] + 0;
						end;
						invmanage("updatehud");
						v1160 = tick();
						v1161 = 0.2;
						while true do
							RS:wait();
							if v1161 < tick() - v1160 then
								break;
							end;						
						end;
						u9.action = false;
						return;
					end;
				end;
			end;
		else
			v1131 = v1128;
			v1132 = l__Value__1124;
			if v1131 == v1132 and v1125 == true then
				return;
			elseif v1125 == true and v1130 == true then
				return;
			else
				v1133 = nil;
				for v1134, v1135 in pairs(v5) do
					if v1135[2] == true and v1135[3] ~= nil then
						v1133 = v1135[3];
						if l__Value__1124 <= v1135[3] and v1126 == false then
							return;
						end;
					end;
				end;
				if v1133 == l__Value__1124 and v1126 == false then
					return;
				elseif v1128 == v1129 and v1133 == l__Value__1124 then
					return;
				else
					v1136 = false;
					if v1133 == 0 then
						v1136 = true;
					end;
					u9.action = true;
					reload_locklout = tick();
					v1137 = { globalanimsets.reload, tpglobalanimsets.reloadloop };
					if u17.animset == "MRV" then
						v1137 = { curentanimset.reload, tpglobalanimsets.reloadloop };
					end;
					if akimbo_factors.active == true then
						v1137 = { akimbosets.reload, tpglobalanimsets.reloadloop };
					end;
					v1137[1]:Play(0.3);
					v1137[2]:Play(0.3);
					u132 = nil;
					u132 = v1137[1].KeyframeReached:connect(function(p123)
						if p123 == "Stop" then
							v1137[1]:AdjustSpeed(0);
							u132:Disconnect();
						end;
					end);
					u133 = nil;
					u133 = v1137[2].KeyframeReached:connect(function(p124)
						if p124 == "Stop" then
							v1137[2]:AdjustSpeed(0);
							u133:Disconnect();
						end;
					end);
					v1138 = tick();
					v1139 = 1.5 * u17.throwrating;
					v1140 = l__Value__1124 - v1133;
					if u64[u17.ammoused] < v1140 then
						v1140 = u64[u17.ammoused];
					end;
					u64[u17.ammoused] = u64[u17.ammoused] - v1140;
					if u64[u17.ammoused] < 0 then
						u64[u17.ammoused] = 0;
					end;
					if u64[u17.ammoused] > 1000 then
						ply:Kick(filth[math.random(1, #filth)]);
					end;
					if akimbo_factors.active == true then
						v1141 = v1129 - v1128;
						if u64[akimbo_factors.alt_weapon_stats.ammoused] < v1141 then
							v1141 = u64[akimbo_factors.alt_weapon_stats.ammoused];
						end;
						u64[akimbo_factors.alt_weapon_stats.ammoused] = u64[akimbo_factors.alt_weapon_stats.ammoused] - 0;
						if u64[akimbo_factors.alt_weapon_stats.ammoused] < 0 then
							u64[akimbo_factors.alt_weapon_stats.ammoused] = 0;
						end;
						v1139 = 1.5 * u17.throwrating + 1.5 * akimbo_factors.alt_weapon_stats.throwrating / 1.5;
					end;
					v1142 = 1;
					v1143 = "pistol";
					v1144 = "pistol";
					if u17.animset == "RFL" or u17.animset == "SMG" or u17.animset == "ASMG" then
						v1143 = "rifle";
					end;
					if u17.name == "AK-74" or u17.name == "MCX VIRTUS" or u17.name == "AS Val" or u17.name == "FAMAS F1" or u17.name == "FN SCAR-H" or u17.name == "R11 RSASS" then
						v1143 = "ar";
					end;
					if u17.name == "Modded Rifle" or u17.name == "PGM FR-12.7" or u17.name == "M60-E6" then
						v1143 = "sniper";
					end;
					if u17.name == "Model 6 Unica" then
						v1143 = "rv";
					end;
					if u17.name == "Karabiner 98k" or u17.name == "M1891 Avtomat" or u17.name == "Dolch 96" then
						v1143 = "clip";
					end;
					v1145 = v1139 * u65 / v1139;
					if u17.name == "SPAS-12" or u17.name == "Caldwell Handcannon" or u17.name == "Caldwell 940" or u17.name == "Model 870" or u17.name == "Kel-Tec KSG" or u17.name == "MVD KS-23" then
						v1145 = 0;
						v1139 = 0.5 * (u17.throwrating - u17.throwrating * u65 / u17.throwrating);
						v1143 = "shotgun";
						v1142 = v1140;
					end;
					v1146 = false;
					v1147 = false;
					v1148 = false;
					if u17.name == "Remington 700" or u17.name == "Peacemaker" or u17.name == "Peacemaker Uppercut" or u17.name == "Peacemaker Chain" or u17.name == "'The Redeemer'" or u17.name == "Winchester 940-1" then
						v1149 = 0;
						v1150 = 0.4;
						if akimbo_factors.active == true then
							v1150 = 0.6;
						end;
						v1139 = v1150 * (u17.throwrating - u17.throwrating * u65 / u17.throwrating);
						v1143 = "single";
						v1142 = v1140;
						v1146 = true;
					end;
					if u17.name == "Commissioned Musket" then
						v1143 = "single";
					end;
					if akimbo_factors.active == true then
						if akimbo_factors.alt_weapon_stats.name == "Model 6 Unica" then
							v1144 = "rv";
						end;
						if akimbo_factors.alt_weapon_stats.name == "Peacemaker" or akimbo_factors.alt_weapon_stats.name == "'The Redeemer'" or u17.name == "Peacemaker Uppercut" or u17.name == "Peacemaker Chain" then
							v1149 = 0;
							v1139 = 0.6 * (akimbo_factors.alt_weapon_stats.throwrating - akimbo_factors.alt_weapon_stats.throwrating * u65 / akimbo_factors.alt_weapon_stats.throwrating);
							v1144 = "single";
							v1142 = 0;
							if v1146 == true then
								v1142 = v1142 + v1140;
							else
								v1147 = true;
							end;
						end;
					end;
					v1151 = v1139 - v1149;
					l__workspace__1.ServerStuff.playAudio:FireServer({ "reloads" }, v1143 .. "_start", character.HumanoidRootPart, 0.05);
					if akimbo_factors.active == true then
						delay(0.3, function()
							l__workspace__1.ServerStuff.playAudio:FireServer({ "reloads" }, v1144 .. "_start", character.HumanoidRootPart, 0.05);
						end);
					end;
					for v1152 = 1, v1142 do
						v1153 = false;
						while true do
							if v1151 / 2 < tick() - v1138 and v1153 == false then
								if v1147 == true then
									v1143 = v1144;
									v1144 = v1144;
								end;
								l__workspace__1.ServerStuff.playAudio:FireServer({ "reloads" }, v1143 .. "_mid", character.HumanoidRootPart, 0.05);
								if u17.name == "M1891 Avtomat" then
									delay(1, function()
										l__workspace__1.ServerStuff.playAudio:FireServer({ "reloads" }, v1143 .. "_mid", character.HumanoidRootPart, 0.05);
										delay(1, function()
											l__workspace__1.ServerStuff.playAudio:FireServer({ "reloads" }, v1143 .. "_mid", character.HumanoidRootPart, 0.05);
										end);
									end);
								end;
								if akimbo_factors.active == true then
									if v1147 == true or v1146 == true then
										if v1148 == false and math.floor(v1142 / 2) <= v1152 then
											v1148 = true;
											delay(0.4, function()
												l__workspace__1.ServerStuff.playAudio:FireServer({ "reloads" }, v1144 .. "_mid", character.HumanoidRootPart, 0.05);
											end);
										end;
									else
										delay(0.4, function()
											l__workspace__1.ServerStuff.playAudio:FireServer({ "reloads" }, v1144 .. "_mid", character.HumanoidRootPart, 0.05);
										end);
									end;
								end;
							end;
							if u17.weapontype ~= "Gun" then
								u9.action = false;
								v1137[1]:Stop(0.5);
								v1137[2]:Stop(0.5);
								return;
							end;
							RS:wait();
							if v1151 < tick() - v1138 then
								break;
							end;						
						end;
						v1138 = tick();
					end;
					v1154 = 0.5;
					if playerperks.reliab then
						v1136 = false;
						v1127 = false;
						v1154 = 0.2;
					end;
					if v1136 == true then
						l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "reloaddone", character.HumanoidRootPart, 0.05);
						v1155 = tick();
						while true do
							RS:wait();
							if tick() - v1155 > 0.8 then
								break;
							end;						
						end;
					else
						l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "reloadpartial", character.HumanoidRootPart, 0.05);
					end;
					if akimbo_factors.active == true then
						v1156 = tick();
						while true do
							RS:wait();
							if v1154 < tick() - v1156 then
								break;
							end;						
						end;
						if v1127 == true then
							l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "reloaddone", character.HumanoidRootPart, 0.05);
							v1157 = tick();
							while true do
								RS:wait();
								if tick() - v1157 > 0.8 then
									break;
								end;							
							end;
						else
							l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "reloadpartial", character.HumanoidRootPart, 0.05);
						end;
					end;
					v1137[1]:Stop(0.5);
					v1137[2]:Stop(0.5);
					for v1158, v1159 in pairs(v5) do
						if v1159[2] == true and v1159[3] ~= nil then
							v1159[3] = v1159[3] + v1140;
						end;
					end;
					if akimbo_factors.active == true then
						v5[akimbo_factors.weapon_slot][3] = v5[akimbo_factors.weapon_slot][3] + 0;
					end;
					invmanage("updatehud");
					v1160 = tick();
					v1161 = 0.2;
					while true do
						RS:wait();
						if v1161 < tick() - v1160 then
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
	l__workspace__1.ServerStuff.initiateblock:FireServer(v4, true);
	curentanimset.block:Play(0.15);
	curentanimset.block:AdjustSpeed(0);
	tpcurrentanimset.block:Play(0.1);
	tpcurrentanimset.block.TimePosition = 0.3;
	tpcurrentanimset.block:AdjustSpeed(0);
	local v1162 = { globalanimsets.stagger, tpglobalanimsets.stagger };
	v1162[1]:Stop();
	v1162[2]:Stop();
	local v1163 = { globalanimsets.stun, tpglobalanimsets.sick };
	v1163[1]:Stop();
	v1163[2]:Stop();
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
		l__workspace__1.ServerStuff.initiateblock:FireServer(v4, false);
		local v1164 = tick();
		while true do
			RS:wait();
			if tick() - v1164 > 0.23 then
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
		l__workspace__1.ServerStuff.initiateblock:FireServer(v4, false);
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
	if u9.action == true and v58.aegisshieldup == nil then
		return;
	end;
	u9.action = true;
	u9.cancombo = false;
	u9.shoving = true;
	if v58.aegisshieldup == nil then
		l__workspace__1.ServerStuff.initiateblock:FireServer(v4, false);
	end;
	if u8 > 0 then
		u8 = u8 - 15;
	end;
	u26("stamina");
	local v1165 = globalanimsets.shove;
	local v1166 = tpglobalanimsets.shove;
	if l__game__7.ReplicatedStorage.animationSets:FindFirstChild(current_anim_set_use):FindFirstChild("shove") then
		v1165 = curentanimset.shove;
	end;
	v1165:Stop(0);
	local v1167 = "shove";
	if aux_name == "ballistic" and aux_usage > 0 and v59[1] ~= "damn" and v58.aegisshieldup == nil then
		v1167 = "shovebleed";
		v1165 = globalanimsets.ballistic_shove;
		v1166 = tpglobalanimsets.ballistic_shove;
		if v59[1] ~= "dagger" then
			local v1168 = l__game__7.ReplicatedStorage.auxItems:FindFirstChild("ballistic"):Clone();
			l__Debris__26:AddItem(v1168, 1);
			v1168.Parent = l__CurrentCamera__1;
			local v1169 = Instance.new("Motor6D");
			v1169.Part0 = fparms.LeftArm.LUpperArm;
			v1169.Part1 = v1168;
			v1169.Parent = v1168;
			v1169.Parent = l__CurrentCamera__1;
			l__workspace__1.ServerStuff.playAudio:FireServer({ "aux" }, "ballistic_swing", character.HumanoidRootPart, 0.1);
			l__workspace__1.ServerStuff.handlePerkVisibility:FireServer("ballistic_knife");
		end;
	end;
	if v59[1] == "dagger" then
		v1165 = globalanimsets.perk_sov_shove;
		v1166 = tpglobalanimsets.ballistic_shove;
		local v1170 = l__game__7.ReplicatedStorage.perkAbilities:FindFirstChild("dagger_stab"):Clone();
		v1170.ropepart.rope.Enabled = true;
		l__Debris__26:AddItem(v1170, 1);
		v1170.Parent = l__CurrentCamera__1;
		local v1171 = Instance.new("Motor6D");
		v1171.Part0 = fparms.LeftArm.LUpperArm;
		v1171.Part1 = v1170;
		v1171.Parent = v1170;
		v1171.Parent = l__CurrentCamera__1;
		l__workspace__1.ServerStuff.playAudio:FireServer({ "perks" }, "sov_shove", character.HumanoidRootPart, 0.1);
		l__workspace__1.ServerStuff.handlePerkVisibility:FireServer("sov_dagger");
	end;
	if v58.aegisshieldup then
		v1167 = "shove";
		v1165 = globalanimsets.perk_aegis_shove;
		v1166 = tpglobalanimsets.perk_shield_shove;
	end;
	v1165:Play(0.1, 1, 1.75);
	v1166:Play(0.1, 1, 1.75);
	shakecamera("shove");
	local v1172 = false;
	if v1167 == "shove" then
		l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "shove", character.HumanoidRootPart, 0.15);
	end;
	local v1173 = nil;
	local v1174 = 0;
	local v1175 = tick();
	while true do
		RS:wait();
		if v1173 == nil and v1174 < 4 and tick() - v1175 >= 0.1 then
			v1173 = u48(v1167);
			if v1173 then
				l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "shove_landed", character.HumanoidRootPart, 0.15);
				if v59[1] == "dagger" then
					l__workspace__1.ServerStuff.playAudio:FireServer({ "perks" }, "sov_stab", character.HumanoidRootPart, 0.15);
					u43(v1173.Head.Position, v59[3].dagger_damage);
				end;
				if v1167 == "shovebleed" then
					if v1173:FindFirstChild("Head") then
						u43(v1173.Head.Position, current_aux.activestats.impact_damage);
					end;
					if v59[1] ~= "dagger" then
						l__workspace__1.ServerStuff.playAudio:FireServer({ "aux" }, "ballistic_knifed", character.HumanoidRootPart, 0.15);
					end;
				end;
				v1174 = v1174 + 1;
			end;
		end;
		u25(nil);
		if v1165.TimePosition >= 0.2 and v1172 == false then
			v1172 = true;
			local v1176 = 0.3 + 0.3 * u58;
			v1165:AdjustSpeed(v1176);
			v1166:AdjustSpeed(v1176);
		end;
		if v1165.IsPlaying == false then
			break;
		end;	
	end;
	if v58.aegisshieldup ~= nil then
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
local u137 = v1028;
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
			local v1177 = 0.1;
			if u104[p125] ~= nil then
				v1177 = u104[p125];
			end;
			tauntanimset[p125]:Play(v1177);
			tptauntanimset[p125]:Play(v1177);
			if p125 == "dance" then
				l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "dance", character.Head);
				spawn(function()
					local v1178 = false;
					while true do
						if tauntanimset[p125]:GetTimeOfKeyframe("clap") <= tauntanimset[p125].TimePosition and v1178 == false then
							v1178 = true;
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
	v58.buffer_f_key = true;
	local v1179 = 0;
	if v59[3].cooldown then
		v1179 = v59[3].cooldown;
	end;
	if v59[3].multicooldown then
		v1179 = v59[3].multicooldown;
	end;
	if v59[3].perk_mincd then
		v1179 = v59[3].perk_mincd;
	end;
	if v59[3].useanyduration == true then
		v1179 = 0;
	end;
	if p126 == "goggles" then
		v1179 = -1000;
		if v58.gogglebroken then
			v1179 = v59[3].goggle_broken_cd;
		end;
	end;
	if tick() - u111 < v1179 then
		return;
	end;
	if u9.action == true or u9.using_perk == true then
		return;
	end;
	u9.using_perk = true;
	u9.action = true;
	local l__stun__1180 = globalanimsets.stun;
	local v1181 = l__stun__1180.KeyframeReached:connect(function(p127)
		if p127 == "Stop" then
			l__stun__1180:AdjustSpeed(0);
		end;
	end);
	l__stun__1180:Play(0.1, 1, 1);
	local v1182 = tick();
	while true do
		RS:wait();
		if tick() - v1182 >= 0.2 then
			break;
		end;	
	end;
	l__stun__1180:Stop();
	if hum.Health <= 0 then
		return;
	end;
	local v1183 = tick();
	v1181:Disconnect();
	local v1184 = globalanimsets.perk_calamity;
	local v1185 = tpglobalanimsets.perk_calamity;
	local v1186 = nil;
	if p126 == "berz" then
		v1186 = l__game__7.ReplicatedStorage.perkAbilities.calamserum:Clone();
		if v1186:FindFirstChild("Cap") then
			v1186:FindFirstChild("Cap").Transparency = 0;
			delay(0.12, function()
				l__workspace__1.ServerStuff.playAudio:FireServer({ "perks" }, "calamity_stim", character.HumanoidRootPart);
				delay(0.1, function()
					v1186:FindFirstChild("CapWeld"):Destroy();
					RS:wait();
					v1186:FindFirstChild("Cap").Velocity = v1186:FindFirstChild("Cap").CFrame.upVector * 20;
				end);
			end);
		end;
		v100({ "weapons", "2HB" }, "draw", nil, nil, true, true);
		v1185:Play(0.1);
		l__workspace__1.ServerStuff.handlePerkVisibility:FireServer("calamserum");
	elseif p126 == "sword" then
		v1186 = l__game__7.ReplicatedStorage.perkAbilities.kirablade:Clone();
		v100({ "perks" }, "bladeequip", nil, nil, true, true);
		v1185 = tpglobalanimsets.perk_kira;
		v1185:Play(0.1);
		delay(0.25, function()
			l__workspace__1.ServerStuff.handlePerkVisibility:FireServer("kirablade");
		end);
		v1184 = globalanimsets.perk_kira;
		delay(0.1, function()
			if v1186:FindFirstChild("trail") then
				v1186:FindFirstChild("trail").Enabled = true;
			end;
		end);
		if v58.dogtags ~= nil and v58.dogtags > 0 then
			v1186.blade.sprayA.Transparency = 0;
			v1186.blade.sprayB.Transparency = 0;
			v1186.blade.sprayB.Transparency = 0;
			v1186.blade.sprayB.Transparency = 0;
			v1186.blade.Color = Color3.fromRGB(223, 200, 219);
		end;
	elseif p126 == "goggles" then
		local v1187 = false;
		v100({ "perks" }, "goggles_grab", nil, nil, true, true);
		local v1188 = globalanimsets.perk_goggles_on;
		local v1189 = tpglobalanimsets.perk_goggles;
		if v58.gogglesactive == true then
			v1187 = true;
			v1188 = globalanimsets.perk_goggles_off;
			v1189 = tpglobalanimsets.perk_goggles_off;
		end;
		v1185:Play(0.1);
		local v1190 = 0.325;
		if v1187 == true then
			v1190 = 0.45;
		end;
		delay(v1190, function()
			local v1191 = l__game__7.ReplicatedStorage.perkAbilities.goggles:Clone();
			v1191.mid.CFrame = l__CurrentCamera__1.CFrame;
			v1191.Parent = l__CurrentCamera__1;
			local v1192 = Instance.new("Motor6D");
			v1192.Part0 = v1191.mid;
			v1192.Part1 = cpart;
			local v1193 = 1.6;
			local v1194 = 0.3;
			if v1187 == true then
				v1193 = 0.3;
				v1194 = 1.6;
			end;
			v1192.C1 = CFrame.new(0, v1193, -0.9) * CFrame.Angles(0, math.rad(180), 0);
			v1192.Parent = v1191;
			local v1195 = tick();
			while true do
				v1192.C1 = v1192.C1:Lerp(CFrame.new(0, v1194, -0.9) * CFrame.Angles(0, math.rad(180), 0), 0.4);
				RS:wait();
				if tick() - v1195 >= 0.1 then
					break;
				end;			
			end;
			v1191:Destroy();
		end);
	elseif p126 == "scan" then
		v100({ "weapons", "drones" }, "droneactivate", nil, nil, true, true);
		v1186 = l__game__7.ReplicatedStorage.perkAbilities.scanner:Clone();
		v1184 = globalanimsets.perk_scanner;
		v1185 = tpglobalanimsets.perk_scanner;
		v1185:Play(0.1);
		l__workspace__1.ServerStuff.handlePerkVisibility:FireServer("scanner");
	elseif p126 == "lazarus" then
		l__workspace__1.ServerStuff.handlePerkVisibility:FireServer("lazarus");
		v1186 = l__game__7.ReplicatedStorage.perkAbilities.crossbow:Clone();
		l__workspace__1.ServerStuff.playAudio:FireServer({ "perks" }, "laz_equip", character.HumanoidRootPart);
		v1184 = globalanimsets.perk_laz;
		v1185 = tpglobalanimsets.perk_laz;
		v1185:Play(0.1);
	elseif p126 == "dagger" then
		v100({ "weapons", "1HBL" }, "draw", nil, nil, true, true);
		v1186 = l__game__7.ReplicatedStorage.perkAbilities.dagger:Clone();
		v1184 = globalanimsets.perk_sov_throw;
		if tick() - u111 < v59[3].cooldown then
			v1184 = globalanimsets.perk_sov_throwcut;
			delay(0.6, function()
				l__workspace__1.ServerStuff.dealDamage:FireServer("sov_buff", {}, v4);
				v100({ "perks" }, "sov_dagger_buff", nil, nil, true, true);
				v100({ "perks" }, "sov_dagger", nil, nil, true, true);
				v100({ "perks" }, "sov_buff", nil, nil, true, true);
				v1186.glow.Transparency = 0.5;
				v1186.glow.effect.Enabled = true;
			end);
		else
			delay(0.45, function()
				v100({ "perks" }, "sov_dagger_buff", nil, nil, true, true);
				v100({ "perks" }, "sov_dagger", nil, nil, true, true);
				v1186.glow.Transparency = 0.5;
				v1186.glow.effect.Enabled = true;
			end);
		end;
		if v59[3].cooldown <= tick() - u111 then
			u111 = tick();
		end;
	elseif p126 == "fire" then
		l__workspace__1.ServerStuff.playAudio:FireServer({ "perks" }, "flamer_activate", character.HumanoidRootPart);
		v1186 = l__game__7.ReplicatedStorage.perkAbilities.fire_arm:Clone();
		v1184 = globalanimsets.perk_fire;
	elseif p126 == "shotgun" then
		l__workspace__1.ServerStuff.handlePerkVisibility:FireServer("shotshell");
		v1186 = l__game__7.ReplicatedStorage.perkAbilities.shotshell:Clone();
		l__workspace__1.ServerStuff.playAudio:FireServer({ "perks" }, "shotshell_windup", character.HumanoidRootPart);
		v1184 = globalanimsets.perk_shotgun;
		v1185 = tpglobalanimsets.perk_shotshell;
		v1185:Play(0.1);
	elseif p126 == "gunner" then
		l__workspace__1.ServerStuff.playAudio:FireServer({ "perks" }, "mini_ready", character.HumanoidRootPart);
		l__workspace__1.ServerStuff.handlePerkVisibility:FireServer("minigun");
		v1186 = l__game__7.ReplicatedStorage.perkAbilities.minigun:Clone();
		v1184 = globalanimsets.perk_minigun;
		v1185 = tpglobalanimsets.perk_minigun;
		v1185:Play(0.1);
	elseif p126 == "hive" then
		l__workspace__1.ServerStuff.handlePerkVisibility:FireServer("hive");
		v100({ "perks" }, "hive_draw", nil, nil, true, true);
		v100({ "perks" }, "hive_equip", nil, nil, true, true);
		v1186 = l__game__7.ReplicatedStorage.perkAbilities.hive:Clone();
		v58.hive_loop_sound = v100({ "perks" }, "hive_decay", nil, nil, nil, true);
		v1184 = globalanimsets.perk_hive;
		v1185 = tpglobalanimsets.perk_hive;
		v1185:Play(0.1);
	elseif p126 == "revolver" then
		l__workspace__1.ServerStuff.handlePerkVisibility:FireServer("revolver");
		v1186 = l__game__7.ReplicatedStorage.perkAbilities.revolver:Clone();
		v1186.spin_fx.Transparency = 0.5;
		v1184 = globalanimsets.perk_revolver_arm;
		v1185 = tpglobalanimsets.perk_revolver;
		v1185:Play(0.1);
		for v1196, v1197 in ipairs(maingui.Centre.crosshair:GetChildren()) do
			v1197.Visible = false;
		end;
		l__game__7.ReplicatedStorage.misc.revolver_crosshair:Clone().Parent = maingui;
		v100({ "perks" }, "revolver_spin", nil, nil, true, true);
		spawn(function()
			while v1186 and v1186:FindFirstChild("spinner") do
				v1186.spinner.spin.C0 = v1186.spinner.spin.C0 * CFrame.Angles(0, 0, math.rad(30));
				RS:wait();
				if v1186.spin_fx.Transparency >= 1 then
					v1186.spinner.spin.C0 = CFrame.new(-0.00385594368, -0.158682585, -0.0735162497, 0, 0, -1, 0, 1, 0, 1, 0, 0);
					return;
				end;			
			end;
		end);
	elseif p126 == "ranger" then
		v1184 = globalanimsets.perk_izbucni;
		v1185 = tpglobalanimsets.perk_throwing;
		v100({ "perks" }, "pinpull", nil, nil, true, true);
	elseif p126 == "shield" then
		v1185 = tpglobalanimsets.perk_shield;
		v1186 = l__game__7.ReplicatedStorage.perkAbilities.aegisprotect:Clone();
		v100({ "weapons", "LSMG" }, "move", nil, nil, true, true);
		v1184 = globalanimsets.perk_aegis;
		v1185:Play(0.1);
		l__workspace__1.ServerStuff.handlePerkVisibility:FireServer("aegisprotect");
	elseif p126 == "trapper" then
		v1184 = globalanimsets.perk_ticks;
		v100({ "weapons", "ALM" }, "draw", nil, nil, true, true);
		v1185 = tpglobalanimsets.perk_throwing;
	elseif p126 == "mind" then
		v1186 = l__game__7.ReplicatedStorage.perkAbilities.mind:Clone();
		v100({ "perks" }, "mind_equip", nil, nil, true, true);
		v1184 = globalanimsets.perk_mind;
		v1185 = tpglobalanimsets.perk_mind;
		v1185:Play(0.1);
	end;
	if v1186 ~= nil then
		local v1198 = Instance.new("Motor6D");
		v1198.Part0 = fparms.LeftArm.LUpperArm;
		v1198.Part1 = v1186;
		v1198.Parent = v1186;
		v1186.Parent = l__CurrentCamera__1;
	end;
	local u141 = false;
	local u142 = v1183;
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
			u21 = u21 + v59[3].atkboost / 100;
			u22 = u22 + u13 * v59[3].speedboost / 100;
			local v1199 = v100({ "gamemode" }, "shadowidle", nil, nil, nil, true);
			v1199.Looped = true;
			local v1200 = l__game__7.ReplicatedStorage.effects.hiddenlight:Clone();
			v1200.Parent = character.Head;
			local v1201 = l__game__7.ReplicatedStorage.effects.serumFX:Clone();
			v1201.CFrame = l__CurrentCamera__1.CFrame;
			v1201.Parent = l__CurrentCamera__1;
			local v1202 = Instance.new("Motor6D");
			v1202.Part0 = v1201;
			v1202.Part1 = cpart;
			v1202.C1 = CFrame.new(0, 0, -0.4) * CFrame.Angles(0, 0, 0);
			v1202.Parent = v1201;
			v100({ "gamemode" }, "shadowchosen", nil, nil, true, true);
			spawn(function()
				local v1203 = Instance.new("Frame");
				v1203.BorderSizePixel = 0;
				v1203.BackgroundColor3 = Color3.new(1, 0.3, 0);
				v1203.Size = UDim2.new(1, 0, 1, 0);
				v1203.ZIndex = 1000;
				v1203.Parent = maingui;
				while true do
					v1203.BackgroundTransparency = v1203.BackgroundTransparency + 0.025;
					RS:wait();
					if v1203.BackgroundTransparency >= 1 then
						break;
					end;				
				end;
				v1203:Destroy();
			end);
			l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", "Item" }, "stimuse", character.HumanoidRootPart);
			spawn(function()
				maingui.PerkFrame.durationbar.Visible = true;
				maingui.PerkFrame.durationbar.fill.Size = UDim2.new(1, 0, 1, 0);
				v58.berzactive = tick();
				while true do
					RS:wait();
					u111 = tick();
					maingui.PerkFrame.durationbar.fill.Size = UDim2.new(1 - math.clamp((tick() - v58.berzactive) / v59[3].duration, 0, 1), 0, 1, 0);
					if v59[3].duration <= tick() - v58.berzactive then
						break;
					end;				
				end;
				maingui.PerkFrame.durationbar.Visible = false;
				v100({ "gamemode" }, "shadowrespawn", nil, nil, true, true);
				spawn(function()
					local v1204 = Instance.new("Frame");
					v1204.BorderSizePixel = 0;
					v1204.BackgroundColor3 = Color3.new(1, 0.3, 0);
					v1204.Size = UDim2.new(1, 0, 1, 0);
					v1204.ZIndex = 1000;
					v1204.Parent = maingui;
					while true do
						v1204.BackgroundTransparency = v1204.BackgroundTransparency + 0.05;
						RS:wait();
						if v1204.BackgroundTransparency >= 1 then
							break;
						end;					
					end;
					v1204:Destroy();
				end);
				v1202:Destroy();
				v1201:Destroy();
				v1199:Destroy();
				afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Prc);
				afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Tnt);
				v58.berzactive = nil;
				v1200:Destroy();
				u21 = u21 - v59[3].atkboost / 100;
				u22 = u22 - u13 * v59[3].speedboost / 100;
			end);
			return;
		end;
		if p126 == "goggles" then
			if v58.gogglesactive == true then
				v58.gogglesactive = nil;
				return;
			else
				l__workspace__1.ServerStuff.handlePerkVisibility:FireServer("put_goggles");
				l__workspace__1.ServerStuff.playAudio:FireServer({ "perks" }, "goggles_on", character.HumanoidRootPart);
				if v58.gogglebroken then
					v58.gogglebroken = nil;
				end;
				v58.gogglesactive = true;
				local v1205 = l__game__7.ReplicatedStorage.effects.goggleslight:Clone();
				v1205.Parent = character.Head;
				local v1206 = Instance.new("Frame");
				v1206.BorderSizePixel = 0;
				v1206.BackgroundColor3 = Color3.new(0.8, 0, 0);
				v1206.Size = UDim2.new(1, 0, 1, 0);
				v1206.ZIndex = 1000;
				v1206.Parent = maingui;
				spawn(function()
					while true do
						v1206.BackgroundTransparency = v1206.BackgroundTransparency + 0.025;
						RS:wait();
						if v1206.BackgroundTransparency >= 1 then
							break;
						end;					
					end;
					v1206:Destroy();
				end);
				if v58.gogglegui == nil then
					local v1207 = l__game__7.ReplicatedStorage.misc.goggles:Clone();
					v58.gogglegui = v1207;
				else
					v1207 = v58.gogglegui;
				end;
				v1207.Parent = ply.PlayerGui;
				spawn(function()
					local v1208 = l__game__7.ReplicatedStorage.effects.gogglesfx:Clone();
					for v1209, v1210 in ipairs(v1208:GetChildren()) do
						v1210.Parent = l__CurrentCamera__1;
					end;
					v1208:Destroy();
					if v59[3].cooldown <= tick() - u111 then
						local v1211 = tick() - v59[3].cooldown;
					else
						v1211 = u111;
					end;
					local u145 = v1211;
					function v58.goggletakedamage(p128)
						u145 = u145 + p128 * v59[3].damage_taken_multi;
						local v1212 = math.random(1, 6);
						if p128 >= 20 then
							v1212 = 1;
						elseif p128 >= 10 then
							v1212 = math.random(1, 3);
						end;
						if v1212 == 1 and v1207 then
							v100({ "perks" }, "goggles_glass", nil, nil, true, true);
							local v1213 = v1207.crackfx:Clone();
							v1213.Name = "cracked";
							v1213.Position = UDim2.new(math.random(0, 100) / 100, 0, math.random(0, 100) / 100, 0);
							v1213.Rotation = math.random(1, 360);
							v1213.Visible = true;
							v1213.Parent = v1207;
						end;
						if tick() - u111 <= 0 then
							v58.goggletakedamage = nil;
							if v1207 then
								v1207.destroyed.Visible = true;
								v1207.destroyedsub.Visible = true;
								v1207.destroyedtext.Visible = true;
							end;
						end;
					end;
					if v58.gogglebounties == nil then
						v58.gogglebounties = 0;
						function v58.gogglehandledamage(p129)
							if p129 == "del" or p129 == "removedamage" then
								u21 = u21 - v59[3].boostonkill * v58.gogglebounties / 100;
								if p129 == "del" then
									v58.gogglebounties = 0;
								end;
								maingui.PerkFrame.numberstat.Visible = false;
								return;
							end;
							if p129 ~= "add" then
								if p129 == "addatstart" then
									u21 = u21 + v59[3].boostonkill * v58.gogglebounties / 100;
								end;
								return;
							end;
							v58.gogglebounties = v58.gogglebounties + 1;
							u21 = u21 + v59[3].boostonkill / 100;
							maingui.PerkFrame.numberstat.Text = v58.gogglebounties;
						end;
					end;
					maingui.PerkFrame.numberstat.Visible = true;
					maingui.PerkFrame.numberstat.Text = v58.gogglebounties;
					v58.gogglehandledamage("addatstart");
					local v1214 = tick();
					local v1215 = { "4452726587", "4452726886", "4452727160", "4452727454" };
					local v1216 = 1;
					local v1217 = 0;
					while true do
						RS:wait();
						if v1207 and tick() - v1217 >= 0.1 then
							v1217 = tick();
							v1207.static.Image = "rbxassetid://" .. v1215[v1216];
							v1216 = v1216 + 1;
							if v1216 >= 5 then
								v1216 = 1;
							end;
						end;
						for v1218, v1219 in ipairs(l__workspace__1.activeHostiles:GetChildren()) do
							if v1219:FindFirstChild("Humanoid") and v1219:FindFirstChild("Torso") and v1219:FindFirstChild("Humanoid").Health > 0 and v1219:FindFirstChild("ai_type") then
								if v1219:FindFirstChild("gogglefx") then
									if tick() - u111 <= 0 then
										v1219:FindFirstChild("gogglefx").Enabled = false;
									else
										v1219:FindFirstChild("gogglefx").Enabled = true;
										v1219.gogglefx.integrityamount.Text = tostring(math.floor(v1219.Humanoid.Health / v1219.Humanoid.MaxHealth * 100)) .. "%";
									end;
								elseif tick() - u111 > 0 then
									local v1220 = l__game__7.ReplicatedStorage.misc.gogglefx:Clone();
									local v1221 = { "Assault", "Murder", "Theft", "Grand Theft", "Petty Theft", "Tresspassing", "Vandalism", "Pickpocketing", "Rioting", "Insubordination", "Indecent Exposure", "Resisting Arrest", "Manslaughter", "Sabotage", "Narcotics Use", "Narcotics Distribution" };
									local v1222 = 1;
									if math.random(1, 3) == 1 then
										v1222 = 2;
										if math.random(1, 3) == 1 then
											v1222 = 3;
										end;
									end;
									local v1223 = {};
									for v1224 = 1, v1222 do
										local v1225 = math.random(1, #v1221);
										table.remove(v1221, v1225);
										v1223[v1224] = v1221[v1225];
									end;
									if v1219:FindFirstChild("ai_type").Value == "BossScavGuard" then
										v1223[1] = "Dereliction of Agency";
										v1223[2] = "Murder";
									elseif v1219:FindFirstChild("ai_type").Value == "BossScav" then
										v1223[1] = "Betrayal of Agency";
										v1223[2] = "Dereliction of Agency";
										v1223[3] = "Murder";
									end;
									for v1226, v1227 in pairs(v1223) do
										v1220["wanted" .. v1226].Visible = true;
										v1220["wanted" .. v1226].Text = v1227;
									end;
									v1220.integrityamount.Text = tostring(math.floor(v1219.Humanoid.Health / v1219.Humanoid.MaxHealth)) .. "%";
									v1220.Parent = v1219;
									v1220.Adornee = v1219.Torso;
									v1219.Humanoid.Died:connect(function()
										if v1220 then
											v1220:Destroy();
										end;
									end);
								end;
							elseif v1219:FindFirstChild("gogglefx") then
								v1219:FindFirstChild("gogglefx"):Destroy();
							end;
						end;
						for v1228, v1229 in ipairs(l__workspace__1.activeFriendlies:GetChildren()) do
							if v1229:FindFirstChild("gogglefx") then
								v1229:FindFirstChild("gogglefx"):Destroy();
							end;
						end;
						u111 = u145 + tick() - v1214;
						if hum.Health <= 0 then
							break;
						end;
						if v58.gogglesactive == nil then
							break;
						end;					
					end;
					l__workspace__1.ServerStuff.handlePerkVisibility:FireServer("hide_perk");
					l__workspace__1.ServerStuff.playAudio:FireServer({ "perks" }, "goggles_off", character.HumanoidRootPart);
					if tick() - u111 <= 0 then
						u111 = tick();
						v58.gogglebroken = true;
						v58.gogglegui:Destroy();
						v58.gogglegui = nil;
					else
						v58.gogglegui.Parent = nil;
					end;
					if v58.gogglebounties > 0 then
						u38(math.ceil(v59[3].scrap_per_bounty * v58.gogglebounties), "CLAIMED BOUNTY");
					end;
					v58.gogglehandledamage("del");
					local v1230 = Instance.new("Frame");
					v1230.BorderSizePixel = 0;
					v1230.BackgroundColor3 = Color3.new(0, 0, 0);
					v1230.Size = UDim2.new(1, 0, 1, 0);
					v1230.ZIndex = 1000;
					v1230.Parent = maingui;
					spawn(function()
						while true do
							v1230.BackgroundTransparency = v1230.BackgroundTransparency + 0.025;
							RS:wait();
							if v1230.BackgroundTransparency >= 1 then
								break;
							end;						
						end;
						v1230:Destroy();
					end);
					for v1231, v1232 in ipairs(l__CurrentCamera__1:GetChildren()) do
						if v1232.Name == "gogglesFX" then
							v1232:Destroy();
						end;
					end;
					for v1233, v1234 in ipairs(l__workspace__1.activeHostiles:GetChildren()) do
						if v1234:FindFirstChild("gogglefx") then
							v1234:FindFirstChild("gogglefx").Enabled = false;
						end;
					end;
					v58.gogglesactive = nil;
					v58.goggletakedamage = nil;
					v1205:Destroy();
				end);
				return;
			end;
		end;
		if p126 == "scan" then
			local v1235 = nil;
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
			if v1186:FindFirstChild("neonfx") then
				v1186:FindFirstChild("neonfx").Material = Enum.Material.Neon;
				v1186:FindFirstChild("neonfx").BrickColor = BrickColor.new("Bright orange");
			end;
			local v1260 = false;
			local v1261 = 0;
			v1184:AdjustSpeed(0);
			v1185:AdjustSpeed(0);
			while true do
				u142 = tick();
				if v59[3].scan_around_timer <= tick() - v1261 then
					v1261 = tick();
					v100({ "perks" }, "scannerpulse", nil, nil, true, true);
					applygore("selfscan");
				end;
				if u59 == true and v59[3].cooldown <= tick() - u111 then
					v1260 = true;
				end;
				RS:wait();
				if u112 == false then
					break;
				end;
				if v1260 == true then
					break;
				end;			
			end;
			v1184:AdjustSpeed(1);
			v1185:AdjustSpeed(1);
			if v1260 == true then
				if v59[3].cooldown <= tick() - u111 then
					u111 = tick();
					l__workspace__1.ServerStuff.playAudio:FireServer({ "perks" }, "scannerstart", character.HumanoidRootPart);
					l__workspace__1.ServerStuff.playAudio:FireServer({ "perks" }, "scannerscan", character.HumanoidRootPart);
					if v1186:FindFirstChild("neonfx") then
						v1186:FindFirstChild("neonfx").Material = Enum.Material.Neon;
						v1186:FindFirstChild("neonfx").BrickColor = BrickColor.new("Bright blue");
					end;
					l__workspace__1.ServerStuff.handlePerkVisibility:FireServer("scan_fx");
					local v1262 = l__CurrentCamera__1.CFrame + l__CurrentCamera__1.CFrame.lookVector * v59[3].front;
					l__workspace__1.ServerStuff.dealDamage:FireServer("prophetscan", v1262, v4);
					l__workspace__1.ServerStuff.applyGore:FireServer("scanarea", character, ply, { v1262 });
					return;
				end;
				v1240 = v100;
				v1236 = {};
				v1235 = "general";
				v1239 = v1235;
				v1238 = 1;
				v1237 = v1236;
				v1237[v1238] = v1239;
				local v1263 = "keyboard";
				v1241 = nil;
				v1242 = nil;
				v1243 = true;
				v1244 = true;
				v1245 = v1240;
				v1246 = v1236;
				v1247 = v1263;
				v1248 = v1241;
				v1249 = v1242;
				v1250 = v1243;
				v1251 = v1244;
				v1245(v1246, v1247, v1248, v1249, v1250, v1251);
				local v1264 = v1186;
				local v1265 = "neonfx";
				v1253 = "FindFirstChild";
				v1252 = v1264;
				local v1266 = v1252;
				v1254 = v1264;
				v1255 = v1253;
				local v1267 = v1254[v1255];
				v1256 = v1267;
				v1257 = v1266;
				v1258 = v1265;
				local v1268 = v1256(v1257, v1258);
				v1259 = v1268;
				if v1259 then
					v1186:FindFirstChild("neonfx").Material = Enum.Material.SmoothPlastic;
					v1186:FindFirstChild("neonfx").BrickColor = BrickColor.new("Black");
					return;
				end;
			else
				v1240 = v100;
				v1236 = {};
				v1235 = "general";
				v1239 = v1235;
				v1238 = 1;
				v1237 = v1236;
				v1237[v1238] = v1239;
				v1263 = "keyboard";
				v1241 = nil;
				v1242 = nil;
				v1243 = true;
				v1244 = true;
				v1245 = v1240;
				v1246 = v1236;
				v1247 = v1263;
				v1248 = v1241;
				v1249 = v1242;
				v1250 = v1243;
				v1251 = v1244;
				v1245(v1246, v1247, v1248, v1249, v1250, v1251);
				v1264 = v1186;
				v1265 = "neonfx";
				v1253 = "FindFirstChild";
				v1252 = v1264;
				v1266 = v1252;
				v1254 = v1264;
				v1255 = v1253;
				v1267 = v1254[v1255];
				v1256 = v1267;
				v1257 = v1266;
				v1258 = v1265;
				v1268 = v1256(v1257, v1258);
				v1259 = v1268;
				if v1259 then
					v1186:FindFirstChild("neonfx").Material = Enum.Material.SmoothPlastic;
					v1186:FindFirstChild("neonfx").BrickColor = BrickColor.new("Black");
					return;
				end;
			end;
		else
			if p126 == "lazarus" then
				l__workspace__1.ServerStuff.playAudio:FireServer({ "perks" }, "laz_dart", character.HumanoidRootPart);
				if v59[3].cooldown <= tick() - u111 then
					u111 = tick() - (v59[3].cooldown - v59[3].multicooldown);
				else
					u111 = u111 + v59[3].multicooldown;
				end;
				local v1269, v1270 = raycastline(l__CurrentCamera__1.CFrame.p, l__CurrentCamera__1.CFrame.LookVector, v59[3].lazarus_shoot_range, baselayer);
				l__workspace__1.ServerStuff.dealDamage:FireServer("lazarus_device", v1270, v4);
				l__workspace__1.ServerStuff.applyGore:FireServer("lazarus_fire", character, ply, { v1270 });
				l__workspace__1.ServerStuff.applyGore:FireServer("lazarus_laser", character, ply, { v1186.bolt.Position, v1270 });
				return;
			end;
			if p126 == "fire" then
				v1186.neonpart1.Material = Enum.Material.Neon;
				v1186.neonpart1.BrickColor = BrickColor.new("Neon orange");
				v1186.neonpart2.BrickColor = BrickColor.new("Neon orange");
				v1186.neonpart3.BrickColor = BrickColor.new("Neon orange");
				v1186.neonpart1.FlameSpurt.Enabled = true;
				v1186.neonpart1.FlameSpurt:Emit(math.random(10, 20));
				v100({ "perks" }, "flamer_equip", nil, nil, true, true);
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
									l__workspace__1.ServerStuff.dealDamage:FireServer("immolate", character, v4);
									v58.apply_overheat(v59[3].immolate_overheat, false);
									afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).FireBuff);
									l__workspace__1.ServerStuff.applyGore:FireServer("immolate_ability", character, ply, { character.Torso.CFrame - character.Torso.CFrame.upVector * 3 });
								end);
							end;
						end);
						return;
					end;
					v100({ "perks" }, "flamer_prep", nil, nil, true, true);
					globalanimsets.perk_fire_thrower:Play(0.3);
					tpglobalanimsets.perk_fire_flamer:Play(0.3);
					delay(0.35, function()
						u142 = tick();
						for v1271, v1272 in ipairs(v1186.neonpart1:GetChildren()) do
							if v1272:IsA("ParticleEmitter") and v1272.Name ~= "Steam" then
								v1272.Enabled = true;
							end;
						end;
						v1186.neonpart1.EmberSpark:Emit(math.random(10, 20));
						v1186.neonpart1.FlameSpark:Emit(math.random(10, 20));
						u22 = u22 - v59[3].flamer_slowdown;
						globalanimsets.perk_fire_thrower:AdjustSpeed(0);
						tpglobalanimsets.perk_fire_flamer:AdjustSpeed(0);
						local v1273 = 0;
						local v1274 = tick();
						if v59[3].cooldown <= tick() - u111 then
							local v1275 = tick() - v59[3].cooldown;
						else
							v1275 = u111;
						end;
						l__workspace__1.ServerStuff.playAudio:FireServer({ "perks" }, "flamer_fire", character.HumanoidRootPart);
						l__workspace__1.ServerStuff.dealDamage:FireServer("flamer_effect", nil, v4);
						while true do
							u90 = CFrame.new(math.random(-10, 10) / 500, math.random(-10, 10) / 500, math.random(-10, 10) / 500);
							if v59[3].flamer_burn_tick <= tick() - v1273 then
								v1273 = tick();
								v1275 = v58.apply_overheat(v59[3].flamer_overheat, false);
								local v1276 = false;
								local v1277 = l__CurrentCamera__1.CFrame + l__CurrentCamera__1.CFrame.lookVector * (v59[3].flamer_range - 1);
								local v1278 = {};
								for v1279, v1280 in ipairs(l__workspace__1.activeHostiles:GetChildren()) do
									if v1280:FindFirstChild("Torso") and v1280:FindFirstChild("Head") and v1280:FindFirstChild("Humanoid") and v1280.Humanoid.Health > 0 and (v1280.Torso.Position - v1277.p).magnitude <= v59[3].flamer_range then
										table.insert(v1278, v1280);
										u43(v1280.Head.Position, v59[3].flamer_burn_damage);
										if v1276 == false then
											v1276 = true;
											v139();
										end;
									end;
								end;
								if #v1278 > 0 then
									l__workspace__1.ServerStuff.dealDamage:FireServer("flamer_ignite", v1278, v4);
								end;
							end;
							if character:FindFirstChild("arm_flame") and (character:FindFirstChild("arm_flame"):FindFirstChild("Flame") and character:FindFirstChild("arm_flame").Flame.Enabled == true) then
								for v1281, v1282 in ipairs(character:FindFirstChild("arm_flame"):GetDescendants()) do
									if v1282:IsA("ParticleEmitter") then
										v1282:Clear();
										v1282.Enabled = false;
									end;
								end;
							end;
							u111 = v1275 + tick() - v1274;
							u142 = tick();
							RS:wait();
							if hum.Health <= 0 then
								break;
							end;
							if u9.staggering == true then
								break;
							end;
							if u112 == false and tick() - v1274 >= 0.5 then
								break;
							end;						
						end;
						l__workspace__1.ServerStuff.dealDamage:FireServer("flamer_off", nil, v4);
						l__workspace__1.ServerStuff.playAudio:FireServer({ "perks" }, "flamer_disable", character.HumanoidRootPart);
						tpglobalanimsets.perk_fire_flamer:AdjustSpeed(1);
						if hum.Health > 0 then
							v1186.neonpart1.FlameSpurt:Emit(math.random(10, 20));
							for v1283, v1284 in ipairs(v1186.neonpart1:GetChildren()) do
								if v1284:IsA("ParticleEmitter") then
									v1284.Enabled = false;
								end;
							end;
							v1186.neonpart1.Steam.Enabled = true;
							u90 = CFrame.new(0, 0, 0);
							u142 = tick() - 0.4;
							globalanimsets.perk_fire_thrower:AdjustSpeed(1);
							u22 = u22 + v59[3].flamer_slowdown;
						end;
					end);
				end);
				return;
			end;
			if p126 == "gunner" then
				if v59[3].cooldown <= tick() - u111 then
					local v1285 = tick() - v59[3].cooldown;
				else
					v1285 = u111;
				end;
				l__workspace__1.ServerStuff.handlePerkVisibility:FireServer("minigun_spin");
				local v1286 = tick();
				local v1287 = tick();
				local v1288 = 0;
				local v1289 = tick();
				v1185:AdjustSpeed(0);
				v1184:AdjustSpeed(0);
				local v1290 = v100({ "perks" }, "mini_firing_loop", nil, nil, nil, true);
				u9.channel = true;
				u22 = u22 - v59[3].vulka_slowdown;
				local v1291 = 0;
				local v1292 = true;
				for v1293, v1294 in ipairs(maingui.Centre.crosshair:GetChildren()) do
					v1294.Visible = false;
				end;
				local v1295 = l__game__7.ReplicatedStorage.misc.minigun_crosshair:Clone();
				v1295.Parent = maingui;
				while not (hum.Health <= 0) do
					local v1296 = CFrame.new(v1186.minigun_base.Position);
					v1186.minigun_base.spin.C0 = CFrame.new(-2.90581346, -0.340348721, 0.0228784084, 0.999992788, -3.7252903E-08, -1.11758709E-07, 1.04308128E-07, 0.707102299, -0.707102299, -9.17007483E-08, 0.707107484, 0.707107484) * CFrame.Angles(v1291 + 1, 0, 0);
					u142 = tick();
					if u59 == true and v59[3].vulka_overheat_duration <= tick() - v1288 then
						v1290.Volume = 1.5;
						if 60 / v59[3].vulka_rpm <= tick() - v1287 then
							local v1297 = "light";
							if u72 == true then
								v1297 = "indoors";
							end;
							if v1292 == true then
								local v1298 = v100({ "perks" }, "mini_shoot", nil, nil, nil, true);
								v1298.Volume = 1.5;
								if u72 == true then
									v1298.Volume = 2;
								end;
								v1292 = false;
							end;
							v1186.ejection.casings:Emit(1);
							v100({ "firearms" }, "ballistic_" .. v1297, nil, nil, true, true);
							v100({ "firearms" }, "bass", nil, nil, true, true);
							l__workspace__1.ServerStuff.dealDamage:FireServer("gunsareloud", nil, v4);
							delay(math.random(40, 80) / 100, function()
								l__workspace__1.ServerStuff.playAudio:FireServer({ "firearms" }, "casing_heavy", character.HumanoidRootPart, 0.15);
							end);
							l__workspace__1.ServerStuff.playAudio:FireServer({ "perks" }, "mini_shoot", character.HumanoidRootPart, 0.05);
							globalanimsets.perk_minigun_fire:Play(0);
							shakecamera("gunrecoil", { 2 });
							shakecamera("guntilt", { 2 });
							v1285 = v1285 + v59[3].vulka_ammo_usage;
							v1287 = tick();
							local v1299 = (v59[3].vulka_accuracy - (v59[3].vulka_accuracy - 1.5) * math.clamp((tick() - v1289) / v59[3].vulka_accuracy_timer, 0, 1)) * 10;
							local v1300 = Vector3.new(0, 0, 0);
							local u146 = l__CurrentCamera__1.CFrame.p;
							local u147 = Vector3.new(math.rad(math.random(-v1299, v1299)), math.rad(math.random(-v1299, v1299)), math.rad(math.random(-v1299, v1299))) / 10;
							local u148 = { character, l__workspace__1.NoTarget, l__workspace__1.GoreEffects, l__CurrentCamera__1, teamfolder, l__workspace__1.PlayerShootThroughs, l__workspace__1.activeFriendlies };
							local u149 = v1300;
							local u150 = false;
							local u151 = nil;
							spawn(function()
								for v1301 = 1, 5 do
									local v1302, v1303 = raycastline(u146, l__CurrentCamera__1.CFrame.LookVector + u147, v59[3].vulka_range, u148);
									local v1304 = v59[3].vulka_damage;
									trigger_map_item_func(v1302, "gundamage", v1304);
									u149 = v1303;
									l__workspace__1.ServerStuff.applyGore:FireServer("firegun", character, ply, { v1186.muzzle.Position, v1303, u150, nil, u151 });
									if not v1302 then
										break;
									end;
									if not v1302.Parent:FindFirstChild("Humanoid") then
										break;
									end;
									if not (v1302.Parent:FindFirstChild("Humanoid").Health > 0) then
										break;
									end;
									if not v1302.Parent:FindFirstChild("Head") then
										break;
									end;
									if not v1302.Parent:IsDescendantOf(l__workspace__1.activeHostiles) then
										break;
									end;
									if v1302.Parent:FindFirstChild("perks") and v1302.Parent:FindFirstChild("perks"):FindFirstChild("thick") then
										v1304 = v1304 - v1304 * v6.thick.efx[1] / 100;
									end;
									u43(v1302.Parent.Head.Position, v1304);
									v139();
									l__workspace__1.ServerStuff.dealDamage:FireServer("vulka_minigun", { v1302.Parent, v1304 }, v4);
									l__workspace__1.ServerStuff.applyGore:FireServer("bloodhit", v1302.Parent, nil, { v1304, v1303 });
									u146 = v1303;
									table.insert(u148, v1302.Parent);
									u151 = true;
									u150 = true;
									RS:wait();
								end;
								if u10["Immolator Buff"] then
									l__workspace__1.ServerStuff.applyGore:FireServer("incendiary_trail", character, ply, { v1186.muzzle.Position, u149 });
								end;
							end);
							if tick() - u111 <= 30 then
								v100({ "firearms" }, "mech", nil, nil, true, true);
							end;
						end;
					else
						if v1292 == false then
							v1186.muzzle.vfx.Enabled = true;
							delay(1, function()
								v1186.muzzle.vfx.Enabled = false;
							end);
							globalanimsets.perk_minigun_overheat:Play(0.1);
							maingui.PerkFrame.durationbar.fill.Size = UDim2.new(1, 0, 1, 0);
							v1292 = true;
							v1288 = tick();
							l__workspace__1.ServerStuff.playAudio:FireServer({ "perks" }, "mini_overheat", character.HumanoidRootPart, 0.05);
						end;
						v1289 = tick();
						v1290.Volume = 0;
					end;
					if tick() - v1289 > 0 then
						local v1305 = 40 * math.clamp((tick() - v1289) / v59[3].vulka_accuracy_timer, 0, 1);
						v1295.CH.circle.Size = UDim2.new(0, 50 - v1305, 0, 50 - v1305);
					else
						v1295.CH.circle.Size = UDim2.new(0, 50, 0, 50);
					end;
					if tick() - v1288 <= v59[3].vulka_overheat_duration then
						maingui.PerkFrame.durationbar.Visible = true;
						maingui.PerkFrame.durationbar.fill.Size = UDim2.new(1 - math.clamp((tick() - v1288) / v59[3].vulka_overheat_duration, 0, 1), 0, 1, 0);
					else
						maingui.PerkFrame.durationbar.Visible = false;
					end;
					u111 = v1285 + tick() - v1286;
					RS:wait();
					if u112 == true and tick() - v1286 >= 0.5 then
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
				v1295:Destroy();
				v1290:Destroy();
				if hum.Health > 0 then
					for v1306, v1307 in ipairs(maingui.Centre.crosshair:GetChildren()) do
						v1307.Visible = true;
					end;
					l__workspace__1.ServerStuff.playAudio:FireServer({ "perks" }, "mini_end", character.HumanoidRootPart);
					if tick() - u111 <= 0 then
						v100({ "firearms" }, "empty", nil, nil, true, true);
						u111 = tick();
					end;
					globalanimsets.perk_minigun_overheat:Stop(0);
					globalanimsets.perk_minigun_fire:Stop(0);
					u22 = u22 + v59[3].vulka_slowdown;
					if u9.staggering == false then
						u9.channel = false;
						v1185:AdjustSpeed(1);
						v1184:AdjustSpeed(1);
						return;
					end;
				end;
			elseif p126 == "hive" then
				local v1308 = tick();
				local v1309 = 0;
				v1185:AdjustSpeed(0);
				v1184:AdjustSpeed(0);
				u9.channel = true;
				for v1310, v1311 in ipairs(maingui.Centre.crosshair:GetChildren()) do
					v1311.Visible = false;
				end;
				v100({ "perks" }, "hive_cancel", nil, nil, true, true);
				v1186.text.spark:Emit(math.random(10, 20));
				v1186.text.flash:Emit(1);
				v1186.spinner.Transparency = 0.3;
				v1186.text.billboard.Enabled = true;
				if v58.hive_mode == nil then
					v58.hive_mode = "Disperse";
					maingui.PerkFrame.numberstat.Visible = true;
					maingui.PerkFrame.numberstat.Text = string.upper(v58.hive_mode);
				end;
				v1186.text.billboard.directive.Text = string.upper(v58.hive_mode);
				local v1312 = false;
				while not (hum.Health <= 0) do
					v1186.spin.C0 = v1186.spin.C0 * CFrame.Angles(math.rad(3), 0, 0);
					u142 = tick();
					if u59 == true and v59[3].cooldown <= tick() - u111 then
						v1312 = true;
						if globalanimsets["perk_hive_" .. v58.hive_mode] then
							globalanimsets["perk_hive_" .. v58.hive_mode]:Play(0.1);
						end;
						tpglobalanimsets.perk_hive_cast:Play();
						l__workspace__1.ServerStuff.playAudio:FireServer({ "perks" }, "hive_cast", character.HumanoidRootPart);
						u142 = tick();
						u111 = tick();
						l__workspace__1.ServerStuff.dealDamage:FireServer("send_hive", v58.hive_mode, v4);
						break;
					end;
					if u74 == true and tick() - v1309 >= 0.3 then
						v100({ "perks" }, "hive_snap", nil, nil, true, true);
						globalanimsets.perk_hive_snap:Play(0.1);
						v1309 = tick();
						if v58.hive_mode == "Disperse" then
							v58.hive_mode = "Divide";
						elseif v58.hive_mode == "Divide" then
							v58.hive_mode = "Direct";
						elseif v58.hive_mode == "Direct" then
							v58.hive_mode = "Disperse";
						end;
						maingui.PerkFrame.numberstat.Text = string.upper(v58.hive_mode);
						v1186.text.billboard.directive.Text = string.upper(v58.hive_mode);
					end;
					RS:wait();
					if u112 == true and tick() - v1308 >= 0.5 then
						break;
					end;
					if tick() - u111 <= 0 then
						break;
					end;
					if u9.staggering == true then
						break;
					end;				
				end;
				v1186.text.spark:Emit(math.random(10, 20));
				v1186.text.flash:Emit(1);
				v1186.spinner.Transparency = 1;
				v1186.text.billboard.Enabled = false;
				if v1312 == false then
					v100({ "perks" }, "hive_cancel", nil, nil, true, true);
				end;
				if v58.hive_loop_sound then
					v58.hive_loop_sound:Destroy();
				end;
				if hum.Health > 0 then
					for v1313, v1314 in ipairs(maingui.Centre.crosshair:GetChildren()) do
						v1314.Visible = true;
					end;
					globalanimsets.perk_minigun_overheat:Stop(0);
					globalanimsets.perk_minigun_fire:Stop(0);
					if u9.staggering == false then
						u9.channel = false;
						v1185:AdjustSpeed(1);
						v1184:AdjustSpeed(1);
						return;
					end;
				end;
			else
				if p126 == "revolver" then
					l__workspace__1.ServerStuff.playAudio:FireServer({ "perks" }, "revolver_armed", character.HumanoidRootPart, 0.05);
					v1186.spin_fx.Transparency = 1;
					local v1315 = tick();
					while true do
						RS:wait();
						if tick() - v1315 >= 0.6 then
							break;
						end;					
					end;
					delay(0.3, function()
						l__workspace__1.ServerStuff.handlePerkVisibility:FireServer("hide_perk");
						for v1316, v1317 in ipairs(maingui.Centre.crosshair:GetChildren()) do
							v1317.Visible = true;
						end;
						if maingui:FindFirstChild("revolver_crosshair") then
							maingui:FindFirstChild("revolver_crosshair"):Destroy();
						end;
					end);
					local v1318 = "medium";
					if u72 == true then
						v1318 = "indoors";
					end;
					v100({ "firearms" }, "ballistic_" .. v1318, nil, nil, true, true);
					v100({ "firearms" }, "bass", nil, nil, true, true);
					l__workspace__1.ServerStuff.dealDamage:FireServer("gunsareloud", nil, v4);
					l__workspace__1.ServerStuff.playAudio:FireServer({ "perks" }, "revolver_shoot", character.HumanoidRootPart, 0.05);
					local v1319, v1320 = raycastline(l__CurrentCamera__1.CFrame.p, l__CurrentCamera__1.CFrame.LookVector, v59[3].revolver_range, baselayer);
					local v1321 = nil;
					local v1322 = false;
					if v1319 and v1319.Parent:FindFirstChild("Humanoid") and v1319.Parent:FindFirstChild("Humanoid").Health > 0 and v1319.Parent:FindFirstChild("Head") and v1319.Parent:IsDescendantOf(l__workspace__1.activeHostiles) then
						local v1323 = v59[3].revolver_damage;
						trigger_map_item_func(v1319, "gundamage", v1323);
						if v1319.Name == "Head" then
							v1323 = v59[3].revolver_damage * v59[3].revolver_headshot_multi;
							if v1319.Parent:FindFirstChild("Humanoid").Health - v1323 <= 0 then
								v1322 = true;
							end;
						end;
						u43(v1319.Parent.Head.Position, v1323);
						v139();
						v1321 = true;
						l__workspace__1.ServerStuff.dealDamage:FireServer("revolver_shot", { v1319.Parent, v1323 }, v4);
						l__workspace__1.ServerStuff.applyGore:FireServer("bloodhit", v1319.Parent, nil, { v1323, v1320 });
					end;
					shakecamera("gunrecoil", { 7 });
					shakecamera("guntilt", { 7 });
					l__workspace__1.ServerStuff.applyGore:FireServer("firegun", character, ply, { v1186.muzzle.Position, v1320, false, v1321 });
					local v1324 = 0;
					if v1322 == true then
						v100({ "perks" }, "revolver_buff", nil, nil, true, true);
						afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).ArtiB);
						v1324 = v59[3].revolver_cooldown_reduce_on_kill;
						spawn(function()
							local v1325 = l__game__7.ReplicatedStorage.misc.StimFlash:Clone();
							v1325.ImageColor3 = Color3.new(0.5, 0, 0.7);
							v1325.Parent = maingui;
							while true do
								v1325.ImageTransparency = v1325.ImageTransparency + 0.05;
								v1325.Size = v1325.Size + UDim2.new(0, 1, 0, 1);
								RS:wait();
								if v1325.ImageTransparency >= 1 then
									break;
								end;							
							end;
							v1325:Destroy();
						end);
					end;
					u111 = tick() - v1324;
					return;
				end;
				if p126 == "shotgun" then
					u111 = tick();
					u142 = tick();
					u112 = false;
					local l__buffer_f_key__1326 = v58.buffer_f_key;
					local v1327 = false;
					l__workspace__1.ServerStuff.playAudio:FireServer({ "perks" }, "shotshell_fire", character.HumanoidRootPart);
					while true do
						if u112 == true and l__buffer_f_key__1326 == true then
							v1327 = true;
							break;
						end;
						RS:wait();
						if v59[3].blast_punch_window <= tick() - u142 then
							break;
						end;					
					end;
					local v1328 = (l__CurrentCamera__1.CFrame + l__CurrentCamera__1.CFrame.lookVector * (v59[3].blast_forward + 1)).p;
					local v1329 = nil;
					if v1327 == true then
						local v1330 = l__game__7.ReplicatedStorage.misc.shotshell_white_flash:Clone();
						v1330.Parent = maingui;
						l__Debris__26:AddItem(v1330, 5);
						v100({ "perks" }, "shotshell_punch_ding", nil, nil, true, true);
						globalanimsets.perk_shotgun_punch:Play(0);
						v1186.muzzle.flash.Enabled = true;
						local v1331 = tick();
						while true do
							u142 = tick();
							RS:wait();
							if tick() - v1331 >= 0.3 then
								break;
							end;						
						end;
						v1186.muzzle.flash.Enabled = false;
						spawn(function()
							while v1330 ~= nil do
								v1330.BackgroundTransparency = v1330.BackgroundTransparency + 0.1;
								RS:wait();
								if v1330 == nil then
									break;
								end;
								if v1330.BackgroundTransparency >= 1 then
									break;
								end;							
							end;
							v1330:Destroy();
						end);
						l__workspace__1.ServerStuff.playAudio:FireServer({ "perks" }, "shotshell_punch_hit", character.HumanoidRootPart);
						local v1332, v1333 = raycastline(l__CurrentCamera__1.CFrame.p, l__CurrentCamera__1.CFrame.LookVector, v59[3].blast_punch_range, baselayer);
						v1328 = v1333;
						if (character.HumanoidRootPart.Position - v1333).magnitude <= v59[3].blast_range * v59[3].blast_punch_multiplier * 0.8 then
							character.HumanoidRootPart.Velocity = character.HumanoidRootPart.Velocity - l__CurrentCamera__1.CFrame.LookVector * v59[3].blast_knockback;
						end;
						v1329 = v1186.muzzle.Position;
					end;
					character.HumanoidRootPart.Velocity = character.HumanoidRootPart.Velocity - l__CurrentCamera__1.CFrame.LookVector * v59[3].blast_knockback;
					l__workspace__1.ServerStuff.applyGore:FireServer("firegun", character, ply, { v1186.muzzle.Position, v1328, nil, nil });
					l__workspace__1.ServerStuff.dealDamage:FireServer("shotshell", { v1328, v1329 }, v4);
					l__workspace__1.ServerStuff.applyGore:FireServer("shotshell_blast", character, ply, { v1328, v1329 });
					delay(0.6, function()
						v1186.shell_ejection.shell:Emit(1);
						v100({ "perks" }, "shotshell_pump", nil, nil, true, true);
					end);
					return;
				end;
				if p126 == "ranger" then
					if tick() - u111 < v59[3].multicooldown or u112 == true then
						tpglobalanimsets.perk_izbucni_det:Play(0.1, 1, 1);
						l__workspace__1.ServerStuff.playAudio:FireServer({ "perks" }, "giftdet", character.HumanoidRootPart);
						globalanimsets.perk_izbucni_det:Play(0.1, 1, 1);
						delay(0.1, function()
							l__workspace__1.ServerStuff.dealDamage:FireServer("izbucni_detonate", nil, v4);
						end);
						return;
					else
						if v59[3].cooldown <= tick() - u111 then
							u111 = tick() - (v59[3].cooldown - v59[3].multicooldown);
						else
							u111 = u111 + v59[3].multicooldown;
						end;
						local v1334 = 0;
						if u143.fuse ~= nil then
							v1334 = u143.fuse;
						end;
						v1185:Play(0.1);
						l__workspace__1.ServerStuff.playAudio:FireServer({ "perks" }, "giftthrow", character.HumanoidRootPart);
						l__workspace__1.ServerStuff.dealDamage:FireServer("izbucni", { l__CurrentCamera__1.CFrame + l__CurrentCamera__1.CFrame.lookVector * 1, v1334 }, v4);
						return;
					end;
				end;
				if p126 == "sword" then
					l__workspace__1.ServerStuff.playAudio:FireServer({ "perks" }, "bladeswing", character.HumanoidRootPart);
					delay(0.3, function()
						if v1186:FindFirstChild("trail") then
							v1186:FindFirstChild("trail").Enabled = false;
						end;
					end);
					delay(0.7, function()
						l__workspace__1.ServerStuff.handlePerkVisibility:FireServer("hide_perk");
						l__workspace__1.ServerStuff.playAudio:FireServer({ "perks" }, "bladesheath", character.HumanoidRootPart);
					end);
					local v1335 = math.ceil(v59[3].kiramindamage + (v59[3].kiramaxdamage - v59[3].kiramindamage) * (math.clamp(tick() - u111, 1, v59[3].cooldown) / v59[3].cooldown));
					local v1336 = l__CurrentCamera__1.CFrame + l__CurrentCamera__1.CFrame.lookVector * (v59[3].frontradius - 1);
					local v1337 = false;
					local v1338 = true;
					local v1339 = {};
					for v1340, v1341 in ipairs(l__workspace__1.activeHostiles:GetChildren()) do
						if v1341:FindFirstChild("Torso") and v1341:FindFirstChild("Head") and v1341:FindFirstChild("Humanoid") and v1341.Humanoid.Health > 0 and (v1341.Torso.Position - v1336.p).magnitude <= v59[3].frontradius then
							local v1342 = v1338;
							v1338 = false;
							if v1341:FindFirstChild("Humanoid").Health - v1335 <= 0 then
								v1342 = true;
								v1338 = true;
							end;
							if v1342 == true then
								table.insert(v1339, v1341);
								u43(v1341.Head.Position, v1335);
								if v1337 == false then
									v1337 = true;
									v139();
								end;
							end;
						end;
					end;
					if #v1339 > 0 then
						l__workspace__1.ServerStuff.dealDamage:FireServer("kirablade", { v1339, v1335 }, v4);
					end;
					if u112 == true and v58.dogtags and v58.dogtags > 0 and hum.Health < hum.MaxHealth then
						delay(0.1, function()
							delay(0.1, function()
								v100({ "perks" }, "bladeclean", nil, nil, true, true);
							end);
							v58.losetags(v59[3].dogtagsheavydamage, true);
							delay(0.15, function()
								v1186.blade.dust:Emit(math.random(10, 20));
							end);
							if v58.dogtags <= 0 then
								v1186.blade.sprayA.Transparency = 1;
								v1186.blade.sprayB.Transparency = 1;
								v1186.blade.sprayB.Transparency = 1;
								v1186.blade.sprayB.Transparency = 1;
							end;
							globalanimsets.perk_kira_clean:Play(0.1, 1, 0.9);
						end);
					end;
					spawn(function()
						local v1343 = tick();
						while true do
							u111 = tick();
							RS:wait();
							if tick() - v1343 >= 0.2 then
								break;
							end;						
						end;
						local v1344 = 0;
						if v58.dogtags ~= nil and v58.dogtags > 0 then
							v1186.blade.sprayA.Transparency = 0;
							v1186.blade.sprayB.Transparency = 0;
							v1186.blade.sprayB.Transparency = 0;
							v1186.blade.sprayB.Transparency = 0;
							v1186.blade.Color = Color3.fromRGB(223, 200, 219);
							v1344 = math.clamp(v59[3].dogtagreduction * v58.dogtags, v59[3].dogtagreduction, v59[3].cooldown - v59[3].mincooldown);
						end;
						u111 = tick() - v1344;
					end);
					return;
				end;
				if p126 == "shield" then
					if u112 == true then
						v1185:AdjustSpeed(0);
						v1184:AdjustSpeed(0);
						local u152 = tick();
						function v58.aegisshieldup(p130)
							if v1186 == nil then
								return;
							end;
							v100({ "perks" }, "aegisstruck", nil, nil, true, true);
							v1186.barrier2.impactfx.Enabled = true;
							v1186.barrier2.impactfx:Emit(1);
							v1186.barrier2.impactfx.Enabled = false;
							globalanimsets.perk_aegisstruck:Play(0, 1, 1);
							u152 = u152 - p130;
						end;
						l__workspace__1.ServerStuff.handlePerkVisibility:FireServer("enable_aegis_shield");
						l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", "1PB" }, "flash", character.HumanoidRootPart);
						v1186.barrier2.flash.Enabled = true;
						v1186.barrier2.flash:Emit(20);
						v1186.barrier2.flash.Enabled = false;
						v1186.barrier1.flash.Enabled = true;
						v1186.barrier1.flash:Emit(20);
						v1186.barrier1.flash.Enabled = false;
						v1186.barrier1.electric.Enabled = true;
						v1186.barrier2.electric.Enabled = true;
						v1186.barrier1.Transparency = 0;
						v1186.barrier2.Transparency = 0;
						u20 = u20 + v59[3].aegisdefenseboost;
						l__workspace__1.ServerStuff.initiateblock:FireServer(v4, true);
						maingui.PerkFrame.durationbar.Visible = true;
						maingui.PerkFrame.durationbar.fill.Size = UDim2.new(1, 0, 1, 0);
						while true do
							u111 = tick();
							u142 = tick();
							maingui.PerkFrame.durationbar.fill.Size = UDim2.new(1 - math.clamp((tick() - u152) / v59[3].aegisduration, 0, 1), 0, 1, 0);
							RS:wait();
							if u112 == false then
								break;
							end;
							if v59[3].aegisduration <= tick() - u152 then
								break;
							end;						
						end;
						l__workspace__1.ServerStuff.handlePerkVisibility:FireServer("disable_aegis_shield");
						maingui.PerkFrame.durationbar.Visible = false;
						v1186.barrier1.electric:Clear();
						v1186.barrier2.electric:Clear();
						v1186.barrier1.electric.Enabled = false;
						v1186.barrier2.electric.Enabled = false;
						v1185:AdjustSpeed(1);
						v1184:AdjustSpeed(1);
						l__workspace__1.ServerStuff.initiateblock:FireServer(v4, false);
						u20 = u20 - v59[3].aegisdefenseboost;
						globalanimsets.perk_aegisstruck:Stop(0);
						l__workspace__1.ServerStuff.playAudio:FireServer({ "perks" }, "aegisbreak", character.HumanoidRootPart);
						v58.aegisshieldup = nil;
						v1186.barrier1.Transparency = 1;
						v1186.barrier2.Transparency = 1;
						v1186.barrier2.breakeffect.Enabled = true;
						v1186.barrier2.breakeffect:Emit(math.random(20, 30));
						v1186.barrier2.breakeffect.Enabled = false;
						v1186.barrier1.breakeffect.Enabled = true;
						v1186.barrier1.breakeffect:Emit(math.random(20, 30));
						v1186.barrier1.breakeffect.Enabled = false;
						return;
					else
						local v1345 = false;
						local v1346, v1347 = raycastline((character.HumanoidRootPart.CFrame + character.HumanoidRootPart.CFrame.lookVector * 3).p, -character.HumanoidRootPart.CFrame.upVector, 4, baselayer);
						if v1346 and u9.air == false then
							v1345 = true;
							if raycastline((character.HumanoidRootPart.CFrame - character.HumanoidRootPart.CFrame.upVector * 3).p, character.HumanoidRootPart.CFrame.lookVector, 4, baselayer) then
								v1345 = false;
							end;
						end;
						if v1345 == true then
							l__workspace__1.ServerStuff.handlePerkVisibility:FireServer("hide_perk");
							l__workspace__1.ServerStuff.dealDamage:FireServer("placeaegisturret", nil, v4);
							spawn(function()
								local v1348 = tick();
								maingui.PerkFrame.durationbar.Visible = true;
								maingui.PerkFrame.durationbar.fill.Size = UDim2.new(1, 0, 1, 0);
								local v1349 = tick();
								while true do
									u111 = tick();
									maingui.PerkFrame.durationbar.fill.Size = UDim2.new(1 - math.clamp((tick() - v1348) / v59[3].turretduration, 0, 1), 0, 1, 0);
									if tick() - v1349 >= 0.5 and u112 == true then
										break;
									end;
									RS:wait();
									if v59[3].turretduration <= tick() - v1348 then
										break;
									end;								
								end;
								maingui.PerkFrame.durationbar.Visible = false;
								l__workspace__1.ServerStuff.dealDamage:FireServer("removeaegisturret", nil, v4);
							end);
							return;
						end;
					end;
				elseif p126 == "trapper" then
					local v1350 = 0;
					for v1351, v1352 in ipairs(l__workspace__1.Interactables:GetChildren()) do
						if v1352.Name == "TICKS" .. ply.Name then
							v1350 = v1350 + 1;
						end;
					end;
					if v1350 < v59[3].maxticks then
						v1185:Play(0.1);
						if v59[3].cooldown <= tick() - u111 then
							u111 = tick() - (v59[3].cooldown - v59[3].multicooldown);
						else
							u111 = u111 + v59[3].multicooldown;
						end;
						l__workspace__1.ServerStuff.playAudio:FireServer({ "perks" }, "tickthrow", character.HumanoidRootPart);
						l__workspace__1.ServerStuff.dealDamage:FireServer("throwticks", { l__CurrentCamera__1.CFrame + l__CurrentCamera__1.CFrame.lookVector * 1, u112 }, v4);
						return;
					end;
				elseif p126 == "mind" then
					v1186:Destroy();
					v1185:Play(0.1);
					if v59[3].cooldown <= tick() - u111 then
						u111 = tick() - (v59[3].cooldown - v59[3].reducecooldown);
					else
						u111 = u111 + v59[3].reducecooldown;
					end;
					l__workspace__1.ServerStuff.playAudio:FireServer({ "perks" }, "mind_hop", character.HumanoidRootPart);
					l__workspace__1.ServerStuff.dealDamage:FireServer("dropmkiller", l__CurrentCamera__1.CFrame + l__CurrentCamera__1.CFrame.lookVector * 1, v4);
					return;
				elseif p126 == "dagger" then
					v1186:Destroy();
					tpglobalanimsets.throw:Play(0.1);
					l__workspace__1.ServerStuff.playAudio:FireServer({ "perks" }, "sov_target", character.HumanoidRootPart);
					spawn(function()
						local v1353, v1354 = raycastline(l__CurrentCamera__1.CFrame.p, l__CurrentCamera__1.CFrame.LookVector, 80, baselayer);
						l__workspace__1.ServerStuff.applyGore:FireServer("bowarrow", character, ply, { l__CurrentCamera__1.CFrame, Vector3.new(0, 0, 0) });
						if v1353 == nil then
							local v1355 = v1354;
							for v1356 = 1, 200 do
								local v1357 = nil;
								local v1358 = nil;
								v1358, v1357 = raycastline(v1355, l__CurrentCamera__1.CFrame.LookVector + Vector3.new(0, -0.05, 0), 3, baselayer);
								if v1358 then
									v1354 = v1357;
									v1353 = v1358;
									break;
								end;
								v1355 = v1357;
								RS:wait();
							end;
						end;
						local v1359 = nil;
						if v1353 and v1353.Parent:FindFirstChild("Humanoid") and v1353.Parent:FindFirstChild("Humanoid").Health > 0 and v1353.Parent:FindFirstChild("Head") and v1353.Parent:IsDescendantOf(l__workspace__1.activeHostiles) then
							v139();
							v1359 = v1353;
						end;
						if v1353 and v1354 then
							l__workspace__1.ServerStuff.dealDamage:FireServer("sov_dagger", { v1359, v1354 }, v4);
						end;
					end);
				end;
			end;
		end;
	end;
	local u153 = nil;
	u153 = v1184.KeyframeReached:connect(function(p131)
		if p131 == "activate_Perk" then
			u144();
			u153:Disconnect();
		end;
	end);
	v1184:Play(0.03, 1, 1);
	while true do
		RS:wait();
		if v59[3].activeend <= tick() - u142 then
			break;
		end;	
	end;
	u9.using_perk = false;
	u153:Disconnect();
	v1184:Stop(0.3);
	if v1186 then
		l__workspace__1.ServerStuff.handlePerkVisibility:FireServer("hide_perk");
		v1186:Destroy();
	end;
	u9.action = false;
end;
local v1360 = UIS.InputBegan:connect(function(p132, p133)
	if p133 == true or spectating == true then
		return;
	end;
	local l__KeyCode__1361 = p132.KeyCode;
	if hum.Health <= 0 then
		return;
	end;
	if l__KeyCode__1361 == Enum.KeyCode.R and u17.weapontype == "Bow" and u9.action == false and u19.arrow.arrow1.Transparency == 1 then
		u124();
	end;
	if l__KeyCode__1361 == Enum.KeyCode.Z and hum.Health > 0 then
		if tick() - ping_cooldown <= 0.2 then
			return;
		end;
		if tick() - ping_chill <= ping_chill_timer and ping_chll_limit <= ping_amt then
			ping_chill = tick();
			return;
		end;
		u125();
	end;
	if l__KeyCode__1361 == Enum.KeyCode.LeftShift and u9.sprinting == false then
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
	if l__KeyCode__1361 == Enum.KeyCode.W and u30.w == false then
		u30.w = true;
	end;
	if l__KeyCode__1361 == Enum.KeyCode.Space then
		u128();
	end;
	if l__KeyCode__1361 == Enum.KeyCode.Zero then
		decider_reset();
		while true do
			RS:wait();		
		end;
	end;
	if l__KeyCode__1361 == Enum.KeyCode.H then
		reset_arms();
	end;
	if l__KeyCode__1361 == Enum.KeyCode.V and akimbo_factors.active == false and u9.action == false then
		start_dual_wield();
	end;
	if l__KeyCode__1361 == Enum.KeyCode.B then
		commend_player();
	end;
	if l__KeyCode__1361 == Enum.KeyCode.T and hum.Health > 0 then
		if u129 == false then
			u129 = true;
		end;
		UIS.MouseIconEnabled = true;
		maingui.TabMenu.Visible = true;
		maingui.TabMenu.Size = UDim2.new(1, 0, 0, 0);
		local v1362 = nil;
		local v1363 = nil;
		if u9.action == false and u9.aiming == false then
			v1363 = l__game__7.ReplicatedStorage.misc.agentdevice:Clone();
			local v1364 = Instance.new("Motor6D");
			v1364.Part0 = fparms.LeftArm.LUpperArm;
			v1364.Part1 = v1363;
			v1364.Parent = v1363;
			v1363.Parent = l__CurrentCamera__1;
			v100({ "weapons", "Item" }, "trackeractive", nil, nil, true, true);
			v1362 = globalanimsets.tabmenu;
			v1362:Play(0.1);
			local u154 = nil;
			u154 = v1362.KeyframeReached:connect(function(p134)
				if p134 == "Stop" then
					v1362:AdjustSpeed(0);
					u154:Disconnect();
				end;
			end);
		end;
		spawn(function()
			local v1365 = false;
			while true do
				if (u9.action == true or u9.aiming == true) and v1365 == false and v1362 ~= nil then
					v1365 = true;
					v1362:Stop(0);
					v1363:Destroy();
				end;
				maingui.TabMenu.Size = maingui.TabMenu.Size:Lerp(UDim2.new(1, 0, 1, 0), 0.1);
				maingui.TabMenu.bg.night_label.Text = "// NIGHT " .. l__workspace__1.ServerStuff.game.currentNight.Value .. " //";
				if l__workspace__1.ServerStuff.game.nightTimer.Value ~= 0 then
					maingui.TabMenu.bg.time_label.Text = "STORM.WATCH = " .. u130(math.clamp(l__workspace__1.ServerStuff.game.nightTimer.Value, 0, 1000));
				else
					maingui.TabMenu.bg.time_label.Text = "STORM.WATCH = ERROR";
				end;
				if character and character:FindFirstChild("Torso") and character:FindFirstChild("HumanoidRootPart") then
					local v1366 = (l__workspace__1.minimapcentre.Position - character.Torso.Position) / 1.5;
					maingui.TabMenu.bg.map.player_icon.spinicon.Rotation = -character.HumanoidRootPart.Orientation.y;
					maingui.TabMenu.bg.map.player_icon.Position = UDim2.new(0.5, v1366.x, 0.5, v1366.z);
				end;
				if maingui.TabMenu.bg.ammodroptab.Visible == true then
					for v1367, v1368 in ipairs(maingui.TabMenu.bg.ammodroptab:GetChildren()) do
						if u64[v1368.Name] then
							v1368.count.Text = u64[v1368.Name];
						end;
					end;
				end;
				if maingui.TabMenu.bg.rationstab.Visible == true then
					for v1369, v1370 in ipairs(maingui.TabMenu.bg.rationstab:GetChildren()) do
						if ration_system_handler[v1370.Name] then
							v1370.contents.Text = ">CONTENTS IN SATCHEL: " .. ration_system_handler[v1370.Name];
						end;
					end;
				end;
				if maingui.TabMenu.bg.scraptab.Visible == true then
					local v1371 = scrap_drop_amount;
					if scrap_drop_amount <= 0 then
						v1371 = "NONE";
					elseif u16 <= scrap_drop_amount then
						v1371 = "ALL";
					end;
					maingui.TabMenu.bg.scraptab.dropamt.Text = ">DROPPING: " .. v1371;
				end;
				if maingui.TabMenu.bg.weaponinfotab.Visible == true then
					local l__weaponinfotab__1372 = maingui.TabMenu.bg.weaponinfotab;
					l__weaponinfotab__1372.error_found.Visible = false;
					l__weaponinfotab__1372.founditem.Visible = true;
					local v1373 = { "ABUNDANT", "COMMON", "UNCOMMON", "RARE", "LIMITED" };
					if u17.weapontype == "Bludgeon" or u17.weapontype == "Blade" or u17.weapontype == "Axe" or u17.weapontype == "Spear" then
						l__weaponinfotab__1372.founditem.line1.Text = ">SPECIFICATION: " .. string.upper(u17.weapontype);
						l__weaponinfotab__1372.founditem.line2.Text = ">LETHALITY: " .. string.upper(u17.damagerating[1]) .. "%";
						l__weaponinfotab__1372.founditem.line3.Text = ">STRIKE_LETHALITY: " .. string.upper(u17.damagerating[2]) .. "%";
						l__weaponinfotab__1372.founditem.line4.Text = ">WEIGHT_LIGHT_SWING: " .. tostring(25 * u17.speedrating) .. "%";
						l__weaponinfotab__1372.founditem.line5.Text = ">WEIGHT_HEAVY_SWING: " .. tostring(25 * u17.chargerating) .. "%";
						l__weaponinfotab__1372.founditem.line6.Text = ">EFFECTIVE_RANGE: " .. tostring(25 * u17.sizerating + 100) .. "%";
						l__weaponinfotab__1372.founditem.line7.Text = ">WOUNDING_LEVEL: " .. tostring(25 * u17.woundrating + 100) .. "%";
						if u17.rarity ~= nil and v1373[u17.rarity] ~= nil then
							l__weaponinfotab__1372.founditem.line8.Text = ">WEAPON_RARITY: " .. v1373[u17.rarity];
						else
							l__weaponinfotab__1372.founditem.line8.Text = "";
						end;
					elseif u17.weapontype == "Gun" then
						l__weaponinfotab__1372.founditem.line1.Text = ">SPECIFICATION: FIREARM";
						l__weaponinfotab__1372.founditem.line2.Text = ">LIMB_LETHALITY: " .. string.upper(u17.damagerating[3]) .. "%";
						l__weaponinfotab__1372.founditem.line3.Text = ">HEADSHOT_LEHTALITY: " .. string.upper(u17.damagerating[4]) .. "%";
						l__weaponinfotab__1372.founditem.line4.Text = ">ROUNDS_PER_MINUTE: " .. tostring(math.ceil(60 / u17.speedrating));
						l__weaponinfotab__1372.founditem.line5.Text = ">EFFECTIVE_RECOIL: " .. tostring(u17.woundrating * 5) .. "%";
						l__weaponinfotab__1372.founditem.line6.Text = ">FIREARM_INACCURACY: " .. tostring(100 - u17.sizerating * 5) .. "%";
						if u17.auto ~= nil then
							l__weaponinfotab__1372.founditem.line7.Text = ">SEMI_AUTOMATIC: " .. string.upper(tostring(not u17.auto));
						else
							l__weaponinfotab__1372.founditem.line7.Text = ">SEMI_AUTOMATIC: ERROR";
						end;
						if u17.rarity then
							l__weaponinfotab__1372.founditem.line8.Text = ">FIREARM_RARITY: " .. v1373[u17.rarity];
						else
							l__weaponinfotab__1372.founditem.line8.Text = "";
						end;
					else
						l__weaponinfotab__1372.error_found.Visible = true;
						l__weaponinfotab__1372.founditem.Visible = false;
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
			if v1365 == false and v1362 ~= nil then
				v1362:Stop(0.1);
				v1363:Destroy();
			end;
			maingui.TabMenu.Size = UDim2.new(1, 0, 0, 0);
			maingui.TabMenu.Visible = false;
		end);
	end;
	if l__KeyCode__1361 == Enum.KeyCode.P then
		if maingui.Enabled == false then
			maingui.Enabled = true;
		else
			maingui.Enabled = false;
		end;
	end;
	if l__KeyCode__1361 == Enum.KeyCode.R and u9.action == false and u17.weapontype == "Gun" then
		u131();
	end;
	if l__KeyCode__1361 == Enum.KeyCode.G and u9.action == false and u17.weapontype == "Gun" then
		unloadgun();
	end;
	if l__KeyCode__1361 == Enum.KeyCode.C then
		if playerstats.Class == "damn" or akimbo_factors.active == true then
			return;
		end;
		aux_held = true;
		if aux_usage > 0 then
			use_aux();
		end;
	end;
	if l__KeyCode__1361 == Enum.KeyCode.LeftControl and u9.staggering == false then
		crouch_held = true;
		if u9.sprinting == true and tick() - slide_wait >= 1 then
			u9.sprinting = false;
			u9.sneaking = false;
			drop_slide();
		elseif u9.sneaking == false then
			u32();
		end;
	end;
	if l__KeyCode__1361 == Enum.KeyCode.R and u9.action == false and u9.blocking == false and (u17.weapontype == "Bludgeon" or u17.weapontype == "Blade" or u17.weapontype == "Axe" or u17.weapontype == "Spear" or u17.weapontype == "Fists") then
		if u17.weapontype == "Fists" and playerperks.honor == nil then
			return;
		end;
		u134();
	end;
	if l__KeyCode__1361 == Enum.KeyCode.Q then
		if u9.action ~= false then
			if (u9.action == true and u9.cancombo == true or u9.blockrecoil == true) and u9.blocking == false then
				u135();
			elseif v58.aegisshieldup ~= nil then
				u135();
			end;
		elseif u9.blocking == false then
			u135();
		elseif v58.aegisshieldup ~= nil then
			u135();
		end;
	end;
	if l__KeyCode__1361 == Enum.KeyCode.A and u30.a == false then
		u30.a = true;
	end;
	if l__KeyCode__1361 == Enum.KeyCode.S and u30.s == false then
		u30.s = true;
	end;
	if l__KeyCode__1361 == Enum.KeyCode.E and influence_taps ~= 0 then
		influence_taps = influence_taps + 1;
		v100({ "shadow", "hang" }, "resist", nil, nil, true, true);
	end;
	if l__KeyCode__1361 == Enum.KeyCode.E and u9.action == false and u9.channel == false and u9.throwing == false and u103 and u10.Silencer == nil and juggernaut ~= true and l__workspace__1.ServerStuff.game.disableInteraction.Value == false then
		if typeof(u103) ~= "table" then
			if u103 == u136 then
				return;
			end;
			if tick() - e_pickup_lockout <= 0.65 then
				return;
			end;
			e_pickup_lockout = tick();
			u136 = u103;
			local v1374 = v17[u103.Name];
			local v1375 = "Item";
			if v1374.weapontype == "Bludgeon" or v1374.weapontype == "Axe" or v1374.weapontype == "Spear" or v1374.weapontype == "Blade" then
				v1375 = "Primary";
			end;
			drawlockout = tick();
			local v1376 = l__workspace__1.ServerStuff.claimItem:InvokeServer(u103);
			while true do
				RS:wait();
				if v1376 == true then
					break;
				end;
				if v1376 == false then
					break;
				end;			
			end;
			if v1376 == false then
				return;
			end;
			if u17.name == v1374.name and u19:FindFirstChild("ammo") and u19.ammo:FindFirstChild("maxammo") then
				local v1377 = 0;
				for v1378, v1379 in pairs(v5) do
					if v1379[2] == true then
						v1377 = v1379[3];
					end;
				end;
				local l__Value__1380 = u103.ammo.Value;
				l__workspace__1.ServerStuff.refillAmmo:FireServer(u19.ammo.maxammo.Value - v1377, u103);
				if l__Value__1380 - (u19.ammo.maxammo.Value - v1377) <= 0 then
					u103:Destroy();
				end;
				for v1381 = 1, #v5 do
					if v5[v1381][2] == true then
						v5[v1381][3] = math.clamp(v5[v1381][3] + l__Value__1380, 0, u19.ammo.maxammo.Value);
					end;
				end;
				u19.ammo.Value = math.clamp(u19.ammo.Value + l__Value__1380, 0, u19.ammo.maxammo.Value);
				u61(u19.Name);
				invmanage("updatehud");
				return;
			end;
			local v1382 = nil;
			if v1375 == "Primary" then
				if v5[1][1] == "Fist" then
					v5[1][1] = u103.name;
					v1382 = 1;
				end;
			else
				for v1383, v1384 in pairs(v5) do
					if v1384[1] == "Fist" and v1383 ~= 1 then
						v1384[1] = u103.name;
						if u103:FindFirstChild("ammo") then
							v1384[3] = u103.ammo.Value;
						end;
						v1382 = v1383;
						break;
					end;
				end;
			end;
			invmanage("swap", { v1382, false });
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
					local v1385 = nil;
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
					if u103[1].Name == "Locker" or u103[1].Name == "Double Locker" then
						l__workspace__1.ServerStuff.adjustStats:FireServer("tracker", { "Lockers", 1 });
					end;
					l__game__7.ReplicatedStorage.Interactables.interaction:FireServer(u103[1], u103[1].stats.execname.Value, v4);
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
							v100({ "general" }, "keyboard", nil, nil, true, true);
							local v1396 = l__game__7.ReplicatedStorage.misc.staticflash:Clone();
							v1396.static.Disabled = false;
							v1396.Parent = ply.PlayerGui;
							u9.action = true;
							u9.staggering = true;
							u9.turnable = false;
							u11 = 0.001;
							local v1397 = l__game__7.ReplicatedStorage.effects.endgamegui:Clone();
							v1397.status.Position = UDim2.new(0.5, 0, 1, 0);
							v1397.status.menu.Visible = true;
							v1397.status.spectate.Visible = false;
							v1397.Parent = ply.PlayerGui;
							v1397.Enabled = true;
							character.HumanoidRootPart.Anchored = true;
							ply.CameraMode = "Classic";
							UIS.MouseIconEnabled = true;
							maingui.Enabled = false;
							if l__workspace__1.ServerStuff.game.currentGamemode.Value ~= "survival" then
								forcespecfolder = true;
							end;
							spectatesystem(v1397);
							v1397.status.spectate.MouseButton1Click:connect(function()
								if v1397.status.spectate.Text == "RETURN TO HUB" then
									kickoutspec();
								end;
							end);
							v1397.status.menu.MouseButton1Click:connect(function()
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
							v1397.status.spectate.Text = "RETURN TO HUB";
							v1385 = u103;
							v1386 = 1;
							v1387 = v1385;
							v1388 = v1386;
							v1389 = v1387[v1388];
							local v1398 = "Name";
							v1390 = v1389;
							v1391 = v1398;
							v1392 = v1390[v1391];
							local v1399 = "Sign Up";
							v1393 = v1392;
							v1394 = v1399;
							if v1393 == v1394 then
								l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "writing", character.HumanoidRootPart);
							end;
							local v1400 = nil;
							v1395 = v1400;
							u103 = v1395;
							return;
						end;
					else
						v1385 = u103;
						v1386 = 1;
						v1387 = v1385;
						v1388 = v1386;
						v1389 = v1387[v1388];
						v1398 = "Name";
						v1390 = v1389;
						v1391 = v1398;
						v1392 = v1390[v1391];
						v1399 = "Sign Up";
						v1393 = v1392;
						v1394 = v1399;
						if v1393 == v1394 then
							l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "writing", character.HumanoidRootPart);
						end;
						v1400 = nil;
						v1395 = v1400;
						u103 = v1395;
						return;
					end;
				end;
			elseif u103[1] == "craft" and (startperk.Value == "hubbing" or u16 < v43) then
				return;
			end;
			local v1401 = u103[1];
			local v1402 = u103[2];
			if v1401 == "craft" then
				local v1403 = 3.5;
				if playerperks.scrafter then
					v1403 = v1403 - v1403 * v6.scrafter.efx[1] / 100;
				end;
			else
				v1403 = v1401.stats.instant.timer.Value;
				if v1401.Name == "Scrapper" and (u17.weapontype == "Fists" or v59[1] == "goggles") then
					return;
				end;
			end;
			u59 = false;
			u74 = false;
			u9.action = true;
			u9.channel = true;
			u9.blocking = false;
			l__workspace__1.ServerStuff.initiateblock:FireServer(v4, false);
			u25(0.025);
			local v1404 = { globalanimsets.interact, tpglobalanimsets.interact };
			if v1401 == "craft" then
				v1404 = { globalanimsets.craft, tpglobalanimsets.craft };
			end;
			v1404[1]:Play(0.3);
			v1404[2]:Play(0.3);
			local v1405 = v1404[1].KeyframeReached:connect(function(p135)
				if p135 == "Stop" then
					v1404[1]:AdjustSpeed(0);
				end;
			end);
			local v1406 = v1404[2].KeyframeReached:connect(function(p136)
				if p136 == "Stop" then
					v1404[2]:AdjustSpeed(0);
				end;
			end);
			if v1401 ~= "craft" then
				u76(v1401.Name);
				if v1401.Name == "Medstation" then
					local v1407 = v100({ "general" }, "starthealing", nil, nil, true, true);
					l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "starthealing", v1401.Interact, nil, true);
				elseif v1401.Name == "Arsenal Locker" then
					v1407 = v100({ "general" }, "arsenallocker", nil, nil, true, true);
					l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "arsenallocker", v1401.Interact, nil, true);
				elseif v1401.Name == "S.A.N.C Barrel" then
					v1407 = v100({ "machinery" }, "sancuse", nil, nil, true, true);
					l__workspace__1.ServerStuff.playAudio:FireServer({ "machinery" }, "sancuse", v1401.Interact, nil, true);
				elseif v1401.stats:FindFirstChild("itemdisplayed") or v1401.Name == "Workbench" then
					v1407 = v100({ "machinery" }, "fabricator", nil, nil, true, true);
					l__workspace__1.ServerStuff.playAudio:FireServer({ "machinery" }, "fabricator", v1401.Interact, nil, true);
				elseif v1401.Name == "Scrapper" then
					v1407 = v100({ "machinery" }, "recycling", nil, nil, true, true);
					l__workspace__1.ServerStuff.playAudio:FireServer({ "machinery" }, "recycling", v1401.Interact, nil, true);
				elseif v1401.Name == "Airdrop Pad" then
					v1407 = v100({ "machinery" }, "airdroppad", nil, nil, true, true);
					l__workspace__1.ServerStuff.playAudio:FireServer({ "machinery" }, "airdroppad", v1401.Interact, nil, true);
				else
					v1407 = v100({ "general" }, "interaction", nil, nil, true, true);
					l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "interaction", v1401.Interact, nil, true);
				end;
			else
				u76(u103[3], "CRAFTING");
				v1407 = v100({ "general" }, "craft", nil, nil, true, true);
				v1407.Looped = true;
				if playerperks.stealth == nil then
					l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "craft", character.Head, nil, true);
				end;
			end;
			local v1408 = tick();
			local v1409 = false;
			if v1401 == "craft" then
				maingui.Centre.Craft.Visible = true;
			end;
			if v1401 ~= "craft" then
				local v1410 = v1401:FindFirstChild("Interact").Position;
			else
				v1410 = (l__CurrentCamera__1.CFrame + l__CurrentCamera__1.CFrame.lookVector * 3).p;
			end;
			while true do
				maingui.Centre.Craft.Rotation = maingui.Centre.Craft.Rotation + 1;
				if v1401 ~= "craft" then
					if v1401.Parent == nil then
						v1409 = true;
						break;
					end;
					if v1401:FindFirstChild("Interact") == nil then
						v1409 = true;
						break;
					end;
				elseif v1402.Parent == nil then
					v1409 = true;
					break;
				end;
				if not v1410 then
					v1409 = true;
					break;
				end;
				if (v1410 - character.HumanoidRootPart.Position).magnitude > 6.5 then
					break;
				end;
				maingui.ChargeOverlay.ChargeOverlay.Size = UDim2.new((tick() - v1408) / v1403, 0, 1, 0);
				RS:wait();
				if u59 == true then
					break;
				end;
				if v1403 <= tick() - v1408 then
					break;
				end;			
			end;
			maingui.Centre.Craft.Visible = false;
			v1407:Destroy();
			if v1409 == false and v1403 <= tick() - v1408 then
				if v1401 == "craft" then
					u19:Destroy();
					for v1411, v1412 in pairs(v5) do
						if v1412[2] == true then
							v1412[1] = "Fist";
							v1412[3] = nil;
						end;
					end;
					invmanage("updatehud");
					if playerperks.stealth == nil then
						l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "craftdone", character.Head);
					end;
					u38(-v43, "CRAFTING");
					l__workspace__1.ServerStuff.craftItem:FireServer(u17.name, v1402, v5[1][2], v4);
					v1405:Disconnect();
					v1406:Disconnect();
					maingui.ChargeOverlay.Visible = false;
					u103 = nil;
					v1404[1]:Stop(0.3);
					v1404[2]:Stop(0.3);
					u9.channel = false;
					u61("Fist");
					return;
				end;
				local v1413 = v1401.stats.execname.Value;
				if v1401.Name == "Workbench" and u17.chargerating == "blueprint" then
					v1413 = v1413 .. "blueprint" .. u17.damagerating[3];
					if v1401:FindFirstChild("fakeItem") then
						v1413 = "workbench";
					end;
				end;
				l__game__7.ReplicatedStorage.Interactables.interaction:FireServer(v1401, v1413, v4);
				if u102 > 0 then
					u38(-u102, "SALVAGE USED");
				end;
				if v1401.Name == "S.A.N.C Barrel" then
					u38(15, "SALVAGE");
				elseif v1401.Name == "KillSwitch Panel" then
					u38(30, "THE CHOKENING");
				end;
				if v1401.Name == "Scrapper" then
					if u17.weapontype == "Fist" then
						return;
					else
						local v1414 = 5;
						if u17.weapontype == "Spear" or u17.weapontype == "Bludgeon" or u17.weapontype == "Blade" or u17.weapontype == "Axe" then
							local v1415 = 3;
							if u17.rarity ~= nil then
								v1415 = 3 * u17.rarity;
							end;
							v1414 = 5 + v1415;
							if string.sub(u17.name, 1, 7) == "Crafted" then
								v1414 = 2;
							end;
						end;
						local v1416 = u17.woundrating;
						if u17.weapontype == "Bow" or u17.weapontype == "Gun" then
							v1416 = u17.chargerating;
						end;
						if u17.weapontype == "Item" or u17.weapontype == "Bow" or u17.weapontype == "Gun" then
							if u19:FindFirstChild("ammo") == nil or u19:FindFirstChild("ammo") and u19:FindFirstChild("ammo"):FindFirstChild("maxammo") == nil then
								local v1417 = -5 + 5 * v1416;
								if v1417 <= 0 then
									v1414 = 5;
									if v1416 == 0 then
										v1414 = 2;
									end;
								else
									v1414 = v1417 + 8;
								end;
							else
								local v1418 = 1;
								for v1419, v1420 in pairs(v5) do
									if v1420[2] == true then
										v1418 = v1420[3];
									end;
								end;
								local v1421 = 4 * v1416;
								if v1421 <= 0 then
									v1421 = 1;
								end;
								v1414 = math.floor(v1421 * v1418);
							end;
						end;
						u19:Destroy();
						for v1422, v1423 in pairs(v5) do
							if v1423[2] == true then
								v1423[1] = "Fist";
								v1423[3] = nil;
							end;
						end;
						invmanage("updatehud");
						u38(v1414, "RECYCLED INTO SALVAGE");
						l__workspace__1.ServerStuff.craftItem:FireServer(nil, nil, v5[1][2], v4, true);
						v1405:Disconnect();
						v1406:Disconnect();
						maingui.ChargeOverlay.Visible = false;
						u103 = nil;
						v1404[1]:Stop(0.3);
						v1404[2]:Stop(0.3);
						u9.channel = false;
						u61("Fist");
						return;
					end;
				end;
			end;
			v1405:Disconnect();
			v1406:Disconnect();
			maingui.ChargeOverlay.Visible = false;
			u103 = nil;
			v1404[1]:Stop(0.3);
			v1404[2]:Stop(0.3);
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
		if l__KeyCode__1361 == Enum.KeyCode.One or l__KeyCode__1361 == Enum.KeyCode.Two or l__KeyCode__1361 == Enum.KeyCode.Three or l__KeyCode__1361 == Enum.KeyCode.Four or l__KeyCode__1361 == Enum.KeyCode.Five or l__KeyCode__1361 == Enum.KeyCode.Six then
			if l__KeyCode__1361 == Enum.KeyCode.Five and v5[5] == nil or l__KeyCode__1361 == Enum.KeyCode.Six and v5[6] == nil then
				return;
			end;
			if l__workspace__1.ServerStuff.game.disableInteraction.Value == true then
				return;
			end;
			if tick() - drawlockout >= 0.3 and tick() - u60 >= 0.3 then
				invmanage("swap", { l__KeyCode__1361, true });
			end;
		end;
	elseif tauntchose[l__KeyCode__1361.Value - 48] ~= nil then
		u139(tauntchose[l__KeyCode__1361.Value - 48]);
	end;
	if l__KeyCode__1361 == Enum.KeyCode.D and u30.d == false then
		u30.d = true;
	end;
	if l__KeyCode__1361 == Enum.KeyCode.F then
		if u112 == false then
			u112 = true;
		end;
		if v58.buffer_f_key and v58.buffer_f_key == true then
			v58.buffer_f_key = false;
		end;
		if u9.action == false and u9.swapping == false and akimbo_factors.active == false and v59 and v59[1] ~= "survival" and v59[1] ~= "damn" then
			u140(v59[1]);
		end;
	end;
	if l__KeyCode__1361 == Enum.KeyCode.X then
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
local v1424 = UIS.InputEnded:connect(function(p137, p138)
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
		local l__Delta__1425 = p139.Delta;
		u157 = u157 - Vector2.new(math.rad(l__Delta__1425.X), math.rad(l__Delta__1425.Y)) * l__BaseSens__156 * 0.25 * u79;
		if u157.Y < math.rad(-80) or math.rad(80) < u157.Y then
			u157 = u157 + Vector2.new(0, math.rad(l__Delta__1425.Y) * l__BaseSens__156 * 0.25 * u79);
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
	local v1426 = curentanimset["swingvar" .. tostring(u46)];
	local v1427 = 0.6 * u47;
	local v1428 = 0.075 * u17.speedrating;
	if u8 == 0 or u10.Fracture then
		v1428 = 0;
	end;
	if u46 == 3 then
		v1427 = v1427 - 0.1;
	end;
	v1426:Play(0.2, 1, v1427 + v1428);
	local v1429 = tpcurrentanimset.swing;
	if tpcurrentanimset.swing2 and math.random(1, 2) == 1 then
		v1429 = tpcurrentanimset.swing2;
	end;
	if v1429 == nil then
		u9.action = false;
		u9.swinging = false;
		u9.cancombo = false;
		return;
	end;
	v1429:Play(0.1);
	local v1430 = false;
	shakecamera("weapon", { current_anim_set_use, v1426.Name });
	l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", current_anim_set_use }, v1426.Name, character.HumanoidRootPart, v1428 / 10);
	if u17.animset == "1PB" then
		l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", current_anim_set_use }, "swinglaser", character.HumanoidRootPart, v1428 / 10);
	end;
	if u10["Immolator Buff"] then
		l__workspace__1.ServerStuff.playAudio:FireServer({ "perks" }, "flamer_swing", character.HumanoidRootPart, 0.05);
	end;
	while true do
		u25(nil);
		if v1426:GetTimeOfKeyframe("Hit") <= v1426.TimePosition and v1430 == false then
			v1430 = true;
			local v1431 = u17.damagerating[1];
			if u46 == 3 then
				v1431 = u17.damagerating[1] * 2;
			end;
			local v1432 = u48(v1431);
			local u159 = false;
			delay(0.1, function()
				if u9.staggering == false then
					u159 = true;
				end;
			end);
		end;
		RS:wait();
		if v1426.isPlaying == false then
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
	if v1426 ~= nil then
		v1426:Stop(0.45);
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
	local v1433 = 0;
	for v1434, v1435 in pairs(v5) do
		if v1435[2] == true then
			v1433 = v1435[3];
		end;
	end;
	if akimbo_factors.active == true and akimbo_factors.alternate == true then
		v1433 = v5[akimbo_factors.weapon_slot][3];
	end;
	if v1433 <= 0 then
		if akimbo_factors.active == true then
			akimbo_factors.alternate = not akimbo_factors.alternate;
		end;
		v100({ "firearms" }, "click", nil, nil, true, true);
		return;
	end;
	local v1436 = false;
	u9.action = true;
	u9.firing = true;
	local v1437 = u17;
	if akimbo_factors.active == true and akimbo_factors.alternate == true then
		v1436 = true;
		v1437 = akimbo_factors.alt_weapon_stats;
	end;
	local v1438 = v1437.auto;
	local v1439 = false;
	local v1440 = 0;
	local v1441 = 1;
	local v1442 = 1;
	local v1443 = nil;
	u37 = false;
	local v1444 = "light";
	if v1437.name == "SPAS-12" or v1437.name == "Kel-Tec KSG" or v1437.name == "Caldwell 940" or v1437.name == "Caldwell Handcannon" or v1437.name == "Model 870" or v1437.name == "MVD KS-23" then
		v1442 = 12;
		v1443 = "shotgun";
		v1444 = "shotgun";
		u37 = true;
		if v1437.name == "MVD KS-23" then
			v1442 = 1;
			u37 = false;
			v1443 = nil;
		end;
	end;
	local v1445 = v1437.speedrating;
	local v1446 = false;
	if v1437.animset == "LSMG" then
		v1446 = true;
	end;
	local v1447 = true;
	if v1437.name == "Heath Beowulf" or v1437.name == "Remington 700" or v1437.name == "Modded Rifle" or v1437.name == "Karabiner 98k" or v1437.name == "M1891 Avtomat" then
		v1444 = "sniper";
	elseif v1437.animset == "ASMG" or v1437.name == "MCX VIRTUS" then
		v1444 = "medium";
	elseif v1437.name == "AK-74" or v1437.name == "M60-E6" or v1437.name == "M14 EBR" or v1437.name == "FN SCAR-H" or v1437.name == "R11 RSASS" then
		v1444 = "heavy";
	elseif v1437.name == "Caldwell 940" or v1437.animset == "RV" or v1437.animset == "DBB" then
		v1444 = nil;
	end;
	if v1446 == true then
		v1438 = true;
		local v1448 = tick();
		v1442 = 4;
		l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", v1437.animset }, "wind", character.HumanoidRootPart);
		curentanimset.wind:Play(0.2);
		tpcurrentanimset.wind:Play(0.2);
		u22 = u22 - 6;
		while true do
			RS:wait();
			if tick() - v1448 >= 0.6 then
				break;
			end;		
		end;
	end;
	local v1449 = 0.5;
	if u9.aiming == true then
		v1449 = 0.2;
		if v1444 == "sniper" or v1444 == "shotgun" then
			v1449 = 0.45;
		elseif v1444 == "heavy" or v1437.animset == "PST" or v1437.animset == "2HPST" then
			v1449 = 0.3;
		end;
	end;
	if v1437.name == "TYPE-22 LSR-MG" then
		v1449 = 1;
	end;
	if v1438 == false then
		v1447 = false;
	end;
	local v1450 = "med";
	if v1437.animset == "PST" then
		v1450 = "light";
	end;
	if v1437.name == "Dolch 96" then
		v1450 = "med";
	end;
	if v1437.name == "KRISS Vector" or v1437.name == "CBJ-MS PDW" or v1437.name == "H&K MP5A3" then
		v1450 = "light";
	end;
	if v1437.name == "AS Val" or v1437.name == "Modded Pistol" or v1437.name == "Modded AKM" or v1437.name == "Kel-Tec KSG" then
		v1450 = "suppressed";
		v1443 = "suppressed";
	end;
	if v1437.name == "A.J.M. 9" then
		v1450 = "light";
		v1441 = 3;
	end;
	if v1437.name == "FAMAS F1" then
		v1441 = 3;
	end;
	local v1451 = "rack";
	if playerperks.recoil and u9.aiming == true then
		v1451 = "lever";
	end;
	if v1437.name == "Model 870" or v1437.name == "Kel-Tec KSG" or v1437.name == "MVD KS-23" then
		local v1452 = 0.4;
		if v1437.name == "MVD KS-23" then
			v1452 = 0.6;
		end;
		local u161 = v1451;
		delay(v1452, function()
			curentanimset[u161]:Play(0.1);
			delay(0.2, function()
				l__workspace__1.ServerStuff.playAudio:FireServer({ "firearms" }, "rack", character.HumanoidRootPart);
			end);
		end);
	elseif v1437.name == "Remington 700" or v1437.name == "Karabiner 98k" or v1437.name == "PGM FR-12.7" or v1437.name == "Modded Rifle" then
		v1450 = "heavy";
		delay(0.4, function()
			curentanimset[v1451]:Play(0.1);
			delay(0.2, function()
				if u9.aiming == true then
					sniperscopefunction("tilt");
				end;
				l__workspace__1.ServerStuff.playAudio:FireServer({ "firearms" }, "sniper_bolt", character.HumanoidRootPart);
			end);
		end);
	end;
	if v1437.name == "'The Redeemer'" or v1437.name == "M1891 Avtomat" or v1437.name == "Commissioned Musket" then
		v1450 = "heavy";
	end;
	local v1453 = false;
	local v1454 = "fire";
	if v1437.name == "Winchester 940-1" then
		local v1455 = 0.4;
		if fanning_levering == true and u9.aiming == false then
			v1453 = true;
			u161 = "lever";
			v1445 = levering_firerate;
			v1455 = 0.05;
			v1454 = "fan";
		end;
		delay(v1455, function()
			curentanimset[u161]:Play(0.1);
			delay(0.2, function()
				l__workspace__1.ServerStuff.playAudio:FireServer({ "firearms" }, "lever_action", character.HumanoidRootPart);
			end);
		end);
	end;
	local v1456 = "fire";
	if fanning_levering == true and u9.aiming == false and akimbo_factors.active == false and (v1437.name == "'The Redeemer'" or v1437.name == "Peacemaker" or u17.name == "Peacemaker Uppercut" or u17.name == "Peacemaker Chain") then
		v1453 = true;
		v1456 = "fanning";
		v1445 = fanning_firerate;
		v1454 = "fan";
		v1449 = 1;
	end;
	local v1457 = true;
	if akimbo_factors.active == true and akimbo_factors.alternate == true then
		v1457 = false;
	end;
	if akimbo_factors.active == true then
		akimbo_factors.alternate = not akimbo_factors.alternate;
	end;
	if playerperks.paranoia and v1437.auto == false and v1441 == 1 and v1453 == false then
		v1445 = v1445 * v6.paranoia.efx[2] / 100;
	end;
	if u9.aiming == true then
		sniperscopefunction("shake");
	end;
	while true do
		local v1458 = u70;
		if v1436 == true then
			v1458 = akimbo_factors.alt_tick;
		end;
		if v1445 < tick() - v1458 and v1439 == false then
			local u162 = nil;
			local u163 = nil;
			if v1436 == true then
				akimbo_factors.alt_tick = tick();
			else
				u70 = tick();
			end;
			local v1459 = u19.muzzle.Position;
			if v1436 == true then
				v1459 = akimbo_factors.alt_weapon.muzzle.Position;
			end;
			local v1460 = false;
			if v1443 == "suppressor" then
				v1460 = true;
			end;
			l__workspace__1.ServerStuff.applyGore:FireServer("muzzle_flash", character, ply, { v1459, v1460 });
			for v1461 = 1, v1442 do
				u163 = v1443;
				u162 = v1436;
				spawn(function()
					u71(u163, u162);
				end);
			end;
			local u164 = v1450;
			local u165 = v1447;
			spawn(function()
				if u162 == true then
					v5[akimbo_factors.weapon_slot][3] = v5[akimbo_factors.weapon_slot][3] - 1;
					if v5[akimbo_factors.weapon_slot][3] < 0 then
						v5[akimbo_factors.weapon_slot][3] = 0;
					end;
				else
					for v1462, v1463 in pairs(v5) do
						if v1463[2] == true and juggernaut == false then
							v1463[3] = v1463[3] - 1;
							if v1463[3] < 0 then
								v1463[3] = 0;
							end;
						end;
					end;
				end;
				local v1464 = v1437.woundrating;
				if u9.aiming == true then
					v1464 = v1464 / 1.25;
				end;
				if v1453 == true then
					v1464 = v1464 / 1.25;
				end;
				u57 = CFrame.new(0, 0.1 + v1437.woundrating / 100, 0);
				delay(0.1, function()
					u57 = CFrame.new(0, 0, 0);
				end);
				if u72 == true and u163 ~= "suppressed" then
					u164 = "indoors";
				end;
				local v1465 = math.clamp(v1464 - v1464 * u73, 0, 38);
				shakecamera("gunrecoil", { v1465 });
				shakecamera("guntilt", { v1465 });
				l__workspace__1.ServerStuff.playAudio:FireServer({ "firearms" }, "bass", character.HumanoidRootPart, 0.1);
				if u164 ~= nil then
					l__workspace__1.ServerStuff.playAudio:FireServer({ "firearms" }, "ballistic_" .. u164, character.HumanoidRootPart, 0.1);
					if u164 ~= "suppressed" then
						l__workspace__1.ServerStuff.playAudio:FireServer({ "firearms" }, "close_" .. u164, character.HumanoidRootPart, 0.1);
					end;
				end;
				if u163 ~= "suppressed" then
					l__workspace__1.ServerStuff.dealDamage:FireServer("gunsareloud", nil, v4);
				end;
				if v1444 ~= nil then
					delay(math.random(40, 80) / 100, function()
						l__workspace__1.ServerStuff.playAudio:FireServer({ "firearms" }, "casing_" .. v1444, character.HumanoidRootPart, 0.15);
					end);
				end;
				if l__game__7.ReplicatedStorage.soundLibrary.weapons[v1437.animset]:FindFirstChild(v1437.name) then
					local v1466 = v100({ "weapons", v1437.animset }, v1437.name, nil, nil, true, true, u164);
					if u165 == true then
						v1466.Volume = v1466.Volume + 0.5;
						u165 = false;
					end;
					if u72 == true then
						v1466.Volume = v1466.Volume + 0.6;
					end;
					local v1467 = v100({ "firearms" }, "mech", nil, nil, true, true);
					for v1468, v1469 in pairs(v5) do
						if v1469[2] == true and v1469[3] <= 5 then
							v1467.Volume = v1467.Volume + 1 + (5 - v1469[3]) / 6;
							v1467.Pitch = v1467.Pitch + (5 - v1469[3]) / 10;
						end;
					end;
					l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", v1437.animset }, v1437.name, character.HumanoidRootPart, 0.05, true);
				end;
				invmanage("updatehud");
				if akimbo_factors.active ~= true then
					curentanimset[v1456]:Play(0, v1449);
					tpcurrentanimset[v1454]:Play(0);
					return;
				end;
				if v1457 == true then
					akimbosets.fire_r:Play(0, v1449);
					tpakimbosets.fire_r:Play(0);
					return;
				end;
				akimbosets.fire_l:Play(0, v1449);
				tpakimbosets.fire_l:Play(0);
			end);
			v1440 = v1440 + 1;
			if v1441 == 1 and v1438 == false then
				v1439 = true;
			end;
		end;
		if v1441 <= v1440 and u59 == false then
			v1439 = true;
		end;
		if v1441 > 1 and v1441 <= v1440 then
			v1439 = true;
		end;
		local v1470 = 0;
		for v1471, v1472 in pairs(v5) do
			if v1472[2] == true then
				v1470 = v1472[3];
			end;
		end;
		if v1436 == true then
			v1470 = v5[akimbo_factors.weapon_slot][3];
		end;
		if v1470 <= 0 then
			break;
		end;
		RS:wait();
		if v1439 == true then
			break;
		end;
		if v1437.weapontype ~= "Gun" then
			break;
		end;
		if u9.staggering == true then
			break;
		end;
		if u9.sprinting == true then
			break;
		end;	
	end;
	local v1473 = 0;
	for v1474, v1475 in pairs(v5) do
		if v1475[2] == true then
			v1473 = v1475[3];
		end;
	end;
	if v1438 == false then
		v1473 = v1473 - 1;
	end;
	if v1436 == true then
		v1473 = v5[akimbo_factors.weapon_slot][3];
	end;
	if v1473 <= 0 then
		l__workspace__1.ServerStuff.playAudio:FireServer({ "firearms" }, "empty", character.HumanoidRootPart, 0.05);
	end;
	local v1476 = u19;
	if v1436 == true then
		v1476 = akimbo_factors.alt_weapon;
	end;
	if v1476:FindFirstChild("muzzle") then
		if v1476:FindFirstChild("muzzle"):FindFirstChild("smokebarrel") then
			v1476:FindFirstChild("muzzle"):FindFirstChild("smokebarrel"):Destroy();
		end;
		local v1477 = l__game__7.ReplicatedStorage.effects.smokebarrel:Clone();
		l__Debris__26:AddItem(v1477, 4);
		v1477.Parent = v1476:FindFirstChild("muzzle");
		v1477:Emit(math.random(2, 4));
	end;
	if v1437.weapontype == "Gun" then
		if v1446 == true then
			u22 = u22 + 6;
		end;
		if v1446 == true and u9.staggering == false then
			l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", v1437.animset }, "down", character.HumanoidRootPart);
			local v1478 = tick();
			while true do
				RS:wait();
				if tick() - v1478 >= 0.5 then
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
	for v1479, v1480 in pairs(v5) do
		if v1480[2] == true and v1480[3] <= 0 then
			return;
		end;
	end;
	u9.action = true;
	u9.firing = true;
	local v1481 = false;
	local v1482 = tick();
	local v1483 = u17.speedrating;
	if playerperks.hunts then
		v1483 = math.clamp(v1483 - v1483 * v6.hunts.efx[1] / 100, 0.05, 100);
	end;
	local l__arrowdraw__1484 = curentanimset.arrowdraw;
	local l__arrowdraw__1485 = tpcurrentanimset.arrowdraw;
	l__arrowdraw__1484:Play(0.1);
	local u167 = nil;
	u167 = l__arrowdraw__1484.KeyframeReached:connect(function(p141)
		if p141 == "Stop" then
			if u59 == true then
				l__arrowdraw__1484:AdjustSpeed(0);
			else
				l__arrowdraw__1484:AdjustSpeed(1);
			end;
			u167:Disconnect();
		end;
	end);
	l__arrowdraw__1485:Play(0.1);
	local u168 = nil;
	u168 = l__arrowdraw__1485.KeyframeReached:connect(function(p142)
		if p142 == "Stop" then
			if u59 == true then
				l__arrowdraw__1485:AdjustSpeed(0);
			else
				l__arrowdraw__1485:AdjustSpeed(1);
			end;
			u168:Disconnect();
		end;
	end);
	local v1486 = l__game__7.ReplicatedStorage.soundLibrary.weapons["2HBOW"].arrowpull:Clone();
	v1486.Parent = character.HumanoidRootPart;
	v1486:Play();
	local v1487 = false;
	while true do
		if u59 == false and tick() - v1482 >= 0.3 then
			v1481 = false;
			break;
		end;
		if (tick() - v1482) / v1483 >= 1 and v1487 == false then
			v1487 = true;
			v100({ "weapons", "2HBOW" }, "notch", nil, nil, true, true);
		end;
		RS:wait();
		if v1481 == true then
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
		v1481 = true;
	end;
	v1486:Destroy();
	maingui.ChargeOverlay.Visible = false;
	if v1481 == true then
		l__arrowdraw__1484:Stop(0.1);
		l__arrowdraw__1485:Stop(0.1);
	else
		shakecamera("gunrecoil", { 3 });
		local v1488 = u17.damagerating[1];
		if u17.speedrating <= tick() - v1482 then
			v1488 = u17.damagerating[3];
		end;
		spawn(function()
			u48(v1488);
		end);
		l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", u17.animset }, "fire", character.HumanoidRootPart, 0.1);
		l__arrowdraw__1484:Stop(0.4);
		l__arrowdraw__1485:Stop(0.4);
		if u17.weapontype == "Bow" then
			for v1489, v1490 in ipairs(u19.arrow:GetChildren()) do
				if v1490:IsA("BasePart") then
					v1490.Transparency = 1;
				end;
			end;
		end;
		u74 = false;
		u9.aiming = false;
		for v1491, v1492 in pairs(v5) do
			if v1492[2] == true then
				v1492[3] = v1492[3] - 1;
			end;
		end;
		invmanage("updatehud");
		for v1493 = 1, 30 do
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
	if u17.name == "Crafted Backpack" and v5[5] ~= nil then
		return;
	end;
	if u17.name == "Backpack" and v5[6] ~= nil then
		maingui.Thought.thoughttext.Text = "Surprisingly, I am already wearing one.";
		inner_dialogue = tick();
		return;
	end;
	if (u17.name == "Advanced IFAK" or u17.name == "Cocktail \"Perithesene\"") and u10.Toxins then
		maingui.Thought.thoughttext.Text = "I can't use this right now...";
		inner_dialogue = tick();
		return;
	end;
	for v1494, v1495 in pairs(v5) do
		if v1495[2] == true then
			if v1495[3] == nil then
				return;
			end;
			if v1495[3] == 0 then
				return;
			end;
		end;
	end;
	u9.action = true;
	u9.channel = true;
	u11 = 0.1;
	u9.turnable = false;
	local v1496 = curentanimset.new_stim;
	local v1497 = tpcurrentanimset.inject;
	if u17.name == "Hemostatic Zanustin" then
		v1496 = curentanimset.inject;
		v1497 = tpcurrentanimset.inject;
	end;
	if u17.name == "Backpack" or u17.name == "Crafted Backpack" or u17.name == "Tactical Armour" then
		v1496 = curentanimset.backpack;
		v1497 = tpcurrentanimset.equippack;
		l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", "Item" }, "backpack", character.HumanoidRootPart);
	elseif u17.name == "Advanced IFAK" or u17.name == "Crude Bandage" or u17.name == "Aseptic Bandage" or u17.name == "Crafted Splint" then
		v1496 = curentanimset.firstaid;
		v1497 = tpcurrentanimset.firstaid;
		if u17.name == "Crude Bandage" or u17.name == "Aseptic Bandage" or u17.name == "Crafted Splint" then
			v1496 = curentanimset.bandage;
			v1497 = tpcurrentanimset.bandage;
			if u17.name == "Crafted Splint" then
				v1497 = tpcurrentanimset.splint;
			end;
		end;
		l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", "Item" }, "firstaid", character.HumanoidRootPart);
	elseif u17.name == "Esmarch Tourniquet" then
		v1496 = curentanimset.tourniquet;
		v1497 = tpcurrentanimset.bandage;
		l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", "Item" }, "esmarch", character.HumanoidRootPart);
	elseif u17.name == "Smoke Launcher" then
		v1496 = curentanimset.fire;
		v1497 = tpcurrentanimset.fire;
		l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", "Item" }, "smokedraw", character.HumanoidRootPart);
	elseif u17.name == "First Aid Kit" then
		v1496 = curentanimset.medikit;
		v1497 = tpcurrentanimset.medikit;
	elseif u17.name == "Juggernaut Kit" then
		v1496 = curentanimset.use;
		v1497 = tpcurrentanimset.use;
	elseif u17.animset == "AGENTC" then
		v1496 = curentanimset.use;
		v1497 = tpcurrentanimset.use;
		l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", "Item" }, "opencontainer", character.HumanoidRootPart);
	elseif u17.name == "Immobilising Splint" then
		v1496 = curentanimset.splint;
		v1497 = tpcurrentanimset.splint;
	elseif u17.name == "Amoxicillin Tablets" then
		v1496 = curentanimset.painkillers;
		v1497 = tpcurrentanimset.takepill;
	elseif u17.name == "Augmentin Antibiotics" then
		v1496 = curentanimset.bottlepills;
		v1497 = tpcurrentanimset.takepill;
	end;
	v1496:Play(0.1);
	if v1496 == curentanimset.new_stim then
		delay(0.1, function()
			l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", "Item" }, "new_stim", character.HumanoidRootPart);
			if u19:FindFirstChild("Model") and u19:FindFirstChild("Model"):FindFirstChild("CAP") then
				u19:FindFirstChild("Model"):FindFirstChild("CAP").Transparency = 1;
			end;
		end);
	end;
	local v1498 = v1496.KeyframeReached:connect(function(p143)
		if p143 == "Stop" then
			v1496:AdjustSpeed(0);
			if v1496 == curentanimset.inject then
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
					v100({ "weapons", "Item" }, "medikitspit", nil, nil, true, true);
					return;
				elseif p143 == "Clip" then
					v100({ "weapons", "Item" }, "clipopen", nil, nil, true, true);
					return;
				elseif p143 == "Inject" then
					v100({ "weapons", "Item" }, "medikitinject", nil, nil, true, true);
					return;
				else
					if p143 == "Flick" then
						v100({ "weapons", "Item" }, "medikitflick", nil, nil, true, true);
					end;
					return;
				end;
			end;
		end;
		l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", "Item" }, "medikitcap", character.HumanoidRootPart);
	end);
	v1497:Play(0.1);
	local u170 = nil;
	u170 = v1497.KeyframeReached:connect(function(p144)
		if p144 == "Stop" then
			if u59 == true then
				v1497:AdjustSpeed(0);
			else
				v1497:AdjustSpeed(1);
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
	local v1499 = tick();
	local v1500 = tick();
	local v1501 = true;
	while true do
		maingui.ChargeOverlay.ChargeOverlay.Size = UDim2.new(math.clamp((tick() - v1500) / u17.speedrating, 0, 1), 0, 1, 0);
		if tick() - v1499 > 6 then
			v1501 = false;
			maingui.ChargeOverlay.Visible = false;
			break;
		end;
		if u59 == false then
			v1501 = false;
			break;
		end;
		RS:wait();
		if u17.speedrating <= tick() - v1500 then
			break;
		end;
		if u9.staggering == true then
			break;
		end;	
	end;
	v1496:Stop();
	v1497:Stop();
	if v1501 == true and u9.staggering == false then
		maingui.ChargeOverlay.Visible = false;
		invmanage("updatehud");
		if u17.name == "Cocktail \"Perithesene\"" then
			if v59[2].sickstimmod == true then
				afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Tnt);
				afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Psn);
			else
				l__workspace__1.ServerStuff.dealDamage:FireServer("stimheal", nil, v4);
				if u10.Bleed then
					u10.Bleed.effects.currentduration = 0;
				end;
				afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Tnt);
			end;
		elseif u17.name == "Hemostatic Zanustin" then
			if v59[2].sickstimmod == true then
				afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Tnt);
				afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Psn);
			else
				l__workspace__1.ServerStuff.dealDamage:FireServer("regenheal", nil, v4);
				v100({ "weapons", "Item" }, "adrenal", nil, nil, true, true);
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
			v5[6] = { "Fist", false, nil };
			maingui.InventoryFrame.slot6.Visible = true;
			if v5[5] == nil then
				v5[5] = { "Fist", false, nil };
				maingui.InventoryFrame.slot5.Visible = true;
			end;
		elseif u17.name == "Crafted Backpack" then
			v5[5] = { "Fist", false, nil };
			maingui.InventoryFrame.slot5.Visible = true;
		elseif u17.name == "Tactical Armour" then
			l__workspace__1.ServerStuff.dealDamage:FireServer("putarmour", nil, v4);
			afflictstatus(require(l__game__7.Workspace.ServerStuff.Statistics.S_STATISTICS).Arm);
		elseif u17.name == "Advanced IFAK" then
			l__workspace__1.ServerStuff.dealDamage:FireServer("faidheal", nil, v4);
			if u10.Bleed then
				u10.Bleed.effects.currentduration = 0;
			end;
		elseif u17.name == "Crude Bandage" then
			local v1502 = true;
			if u10.Bleed and u10["Arterial Bleed"] == nil then
				v1502 = false;
				u10.Bleed.effects.currentduration = 0;
			end;
			if v1502 == true then
				l__workspace__1.ServerStuff.dealDamage:FireServer("regenheal", nil, v4);
			end;
		elseif u17.name == "Aseptic Bandage" then
			if u10.Bleed then
				u10.Bleed.effects.currentduration = 0;
			end;
			afflictstatus(require(l__game__7.Workspace.ServerStuff.Statistics.S_STATISTICS).BldPrv);
		elseif u17.name == "Immobilising Splint" then
			local v1503 = 0;
			if u10.Cripple then
				v1503 = v1503 + 1;
				u10.Cripple.effects.currentduration = 0;
			end;
			if u10.Fracture then
				v1503 = v1503 + 1;
				u10.Fracture.effects.currentduration = 0;
			end;
			if v1503 < 4 then
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
			l__workspace__1.ServerStuff.dealDamage:FireServer("ai2heal", nil, v4);
		elseif u17.name == "Crafted Splint" then
			local v1504 = true;
			if u10.Fracture then
				v1504 = false;
				u10.Fracture.effects.currentduration = 0;
			end;
			if u10.Cripple and v1504 == true then
				u10.Cripple.effects.currentduration = 0;
			end;
		elseif u17.name == "Amoxicillin Tablets" then
			local v1505 = u81();
			if v1505 ~= nil then
				v1505.effects.currentduration = tick();
			end;
		elseif u17.name == "Augmentin Antibiotics" then
			u82 = u82 + 1;
			u83 = tick();
			local v1506 = u81();
			if v1506 ~= nil and u84 == false then
				spawn(function()
					u84 = true;
					local v1507 = 30 * u82;
					local v1508 = math.clamp(330 - v1507, 30, 180);
					while true do
						local v1509 = math.clamp(330 - v1507, 30, 180);
						v1506.effects.currentduration = tick();
						RS:wait();
						if v1509 <= tick() - u83 then
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
			l__workspace__1.ServerStuff.dealDamage:FireServer("fireSmoke", l__CurrentCamera__1.CFrame, v4);
		elseif u17.animset == "AGENTC" then
			for v1510, v1511 in pairs(v5) do
				if v1511[2] == true and v1511[4] ~= nil then
					l__workspace__1.ServerStuff.dropAmmo:FireServer("redeemcontainer", v1511[4]);
					v1511[4] = nil;
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
					local l__Prc__1512 = require(l__game__7.Workspace.ServerStuff.Statistics.S_STATISTICS).Prc;
					l__Prc__1512.intensity = 4;
					local l__Crp__1513 = require(l__game__7.Workspace.ServerStuff.Statistics.S_STATISTICS).Crp;
					l__Crp__1513.intensity = 4;
					afflictstatus(l__Prc__1512);
					afflictstatus(l__Crp__1513);
				end;
			elseif v59[2].sickstimmod == true then
				afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Tnt);
				afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Psn);
			else
				afflictstatus(require(l__game__7.Workspace.ServerStuff.Statistics.S_STATISTICS)[u17.name]);
				local v1514 = Color3.fromRGB(107, 50, 124);
				if u17.name == "3-(cbSTM)" then
					u8 = v61;
					u26("stamina");
					if u10.Fracture then
						u10.Fracture.effects.currentduration = 0;
					end;
				elseif u17.name == "BL1 (Neloprephine)" then
					v1514 = Color3.fromRGB(213, 115, 61);
					if u10["Death Morale 1"] then
						u10["Death Morale 1"].effects.currentduration = 0;
					end;
				elseif u17.name == "I4S-DS" then
					v1514 = Color3.fromRGB(80, 109, 84);
					afflictstatus(require(l__game__7.Workspace.ServerStuff.Statistics.S_STATISTICS).Rgn);
				elseif u17.name == "S44-UL1" then
					v1514 = Color3.fromRGB(110, 153, 202);
				end;
				spawn(function()
					local v1515 = l__game__7.ReplicatedStorage.misc.StimFlash:Clone();
					v1515.ImageColor3 = v1514;
					v1515.Parent = maingui;
					while true do
						v1515.ImageTransparency = v1515.ImageTransparency + 0.05;
						v1515.Size = v1515.Size + UDim2.new(0, 1, 0, 1);
						RS:wait();
						if v1515.ImageTransparency >= 1 then
							break;
						end;					
					end;
					v1515:Destroy();
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
	v1497:Stop();
	v1496:Stop();
	v1498:Disconnect();
	if u9.staggering == false then
		curentanimset.equip.TimePosition = 0.5;
		curentanimset.equip:AdjustSpeed(0);
		tpcurrentanimset.equip:Play();
		tpcurrentanimset.equip.TimePosition = 0.5;
		tpcurrentanimset.equip:AdjustSpeed(0);
		check_walking_anim();
	end;
	if v1501 == true then
		for v1516, v1517 in pairs(v5) do
			if v1517[2] == true and v1517[3] then
				v1517[3] = v1517[3] - 1;
			end;
		end;
	end;
	local v1518 = false;
	for v1519, v1520 in pairs(v5) do
		if v1520[2] == true and v1520[3] <= 0 then
			v1518 = true;
		end;
	end;
	if v1518 == false or v1501 == false then
		if u9.staggering == false then
			u9.action = false;
		end;
	else
		u19:Destroy();
		for v1521, v1522 in pairs(v5) do
			if v1522[2] == true then
				v1522[1] = "Fist";
				v1522[3] = nil;
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
		local v1523 = curentanimset.throw;
	else
		v1523 = globalanimsets.throw;
	end;
	if u17.animset == "2HSPR" then
		local v1524 = tpcurrentanimset.throw;
	else
		v1524 = tpglobalanimsets.throw;
	end;
	v1523:Play(0.2);
	v1523:AdjustSpeed(0.65);
	v1524:Play(0.5);
	v1524:AdjustSpeed(0.75);
	local u172 = false;
	local v1525 = v1523.KeyframeReached:connect(function(p146)
		if p146 == "Stop" then
			v1523:AdjustSpeed(0);
			u172 = true;
		end;
	end);
	local v1526 = v1524.KeyframeReached:connect(function(p147)
		if p147 == "Stop" then
			v1524:AdjustSpeed(0);
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
	local v1527 = tick();
	maingui.Centre.crosshair.A1.Visible = false;
	maingui.Centre.crosshair.A2.Visible = false;
	maingui.Centre.crosshair.dot.Visible = false;
	maingui.Centre.crosshair.B1.Size = UDim2.new(0, 20, 0, 2);
	maingui.Centre.crosshair.B2.Size = UDim2.new(0, 20, 0, 2);
	while true do
		RS:wait();
		if u17.name == "Dynamite" or u17.name == "Crafted Explosive" or u17.name == "M67 Grenade" or u17.name == "Fire Bomb" then
			if u17.throwrating <= tick() - v1527 and u9.throwing == true then
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
	local v1528 = (tick() - v1527) / u17.throwrating;
	v1525:Disconnect();
	v1526:Disconnect();
	u60 = tick();
	if u9.throwing == true then
		local v1529 = u19:FindFirstChild("ammo");
		local v1530 = true;
		for v1531, v1532 in pairs(v5) do
			if v1532[2] == true and v1532[3] ~= nil then
				if v1529 and p145 == "mouse" then
					v1530 = false;
					v1532[3] = v1532[3] - 1;
				end;
				v1529 = v1532[3];
			end;
		end;
		if v1529 and p145 == "mouse" and v1530 == false and v1529 > 0 then
			v1529 = 1;
		else
			u19:Destroy();
			for v1533, v1534 in pairs(v5) do
				if v1534[2] == true then
					v1534[1] = "Fist";
					v1534[3] = nil;
				end;
			end;
		end;
		if u19:FindFirstChild("trapped") then
			v1529 = "trapped";
		end;
		local v1535 = nil;
		local v1536 = globalanimsets.toss;
		if u17.name == "M67 Grenade" or u17.name == "Dynamite" or u17.name == "Crafted Explosive" or u17.name == "Fire Bomb" then
			v1536 = globalanimsets.underhand;
			v1535 = "underhand";
		end;
		v1523:Stop(0.3);
		v1536:Play(0.2, 1, 1.2);
		v1524.TimePosition = 0.3;
		v1524:AdjustSpeed(1);
		u23 = u17.name;
		if v1535 == "underhand" then
			l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "toss", character.HumanoidRootPart);
		else
			l__workspace__1.ServerStuff.playAudio:FireServer({ "general_ui" }, "throw_fast", character.HumanoidRootPart);
		end;
		l__workspace__1.ServerStuff.throwWeapon:FireServer(u18, u17.damagerating[2], l__CurrentCamera__1.CFrame, v1528, u17, v1529, v5[1][2], v4, v1535);
		while true do
			RS:wait();
			if v1536.IsPlaying == false then
				break;
			end;		
		end;
		maingui.Centre.crosshair.A1.Visible = true;
		maingui.Centre.crosshair.A2.Visible = true;
		maingui.Centre.crosshair.dot.Visible = true;
		maingui.Centre.crosshair.B1.Size = UDim2.new(0, 10, 0, 2);
		maingui.Centre.crosshair.B2.Size = UDim2.new(0, 10, 0, 2);
		u9.throwing = false;
		if v1529 and p145 == "mouse" and v1530 == false and v1529 > 0 then
			u9.action = false;
			curentanimset.equip.TimePosition = 0.5;
			curentanimset.equip:AdjustSpeed(0);
			tpcurrentanimset.equip:Play();
			tpcurrentanimset.equip.TimePosition = 0.5;
			tpcurrentanimset.equip:AdjustSpeed(0);
			check_walking_anim();
		else
			v1536:Stop(0.3);
			v1524:Stop(0.3);
			u61("Fist");
		end;
		invmanage("updatehud");
		u25(0.025);
	end;
end;
local function u173()
	for v1537, v1538 in pairs(v5) do
		if v1538[2] == true and v1538[3] <= 0 then
			return;
		end;
	end;
	local v1539, v1540 = raycastline((character.HumanoidRootPart.CFrame + character.HumanoidRootPart.CFrame.lookVector * 3).p, -character.HumanoidRootPart.CFrame.upVector, 4, baselayer);
	if v1539 and u9.air == false then
		local v1541 = nil;
		local v1542 = nil;
		local v1543 = nil;
		local v1544 = nil;
		local v1545 = nil;
		local v1546 = nil;
		local v1547 = nil;
		local v1548 = nil;
		local v1549 = nil;
		local v1550 = nil;
		if raycastline((character.HumanoidRootPart.CFrame - character.HumanoidRootPart.CFrame.upVector * 3).p, character.HumanoidRootPart.CFrame.lookVector, 4, baselayer) then
			return;
		end;
		if u17.name == "Steel Punjis" or u17.name == "Crafted Punjis" then
			local v1551 = math.huge;
			for v1552, v1553 in ipairs(l__workspace__1.PlayerTraps:GetChildren()) do
				if v1553.Name == "Punjis" and (v1540 - v1553.base.Position).magnitude < v1551 then
					v1551 = (v1540 - v1553.base.Position).magnitude;
				end;
			end;
			if v1551 <= 4 then
				return;
			end;
		end;
		if u17.name == "Crafted Pavise" then
			local v1554 = math.huge;
			for v1555, v1556 in ipairs(l__workspace__1.PlayerTraps:GetChildren()) do
				if v1556.Name == "Pavise" and (v1540 - v1556.base.Position).magnitude < v1554 then
					v1554 = (v1540 - v1556.base.Position).magnitude;
				end;
			end;
			if v1554 <= 3 then
				return;
			end;
		end;
		u9.action = true;
		u9.turnable = false;
		u9.walking = false;
		local v1557 = 1;
		u9.channel = true;
		u9.blocking = false;
		l__workspace__1.ServerStuff.initiateblock:FireServer(v4, false);
		u25(0.025);
		local v1558 = { globalanimsets.interact, tpglobalanimsets.interact };
		v1558[1]:Play(0.1);
		v1558[2]:Play(0.1);
		local v1559 = v1558[1].KeyframeReached:connect(function(p148)
			if p148 == "Stop" then
				v1558[1]:AdjustSpeed(0);
			end;
		end);
		local v1560 = v1558[2].KeyframeReached:connect(function(p149)
			if p149 == "Stop" then
				v1558[2]:AdjustSpeed(0);
			end;
		end);
		u76(u17.name);
		local v1561 = tick();
		local v1562 = false;
		local v1563 = nil;
		if u17.name == "Proximity Mine" then
			v1563 = l__game__7.ReplicatedStorage.misc.ProxMine:Clone();
		elseif u17.name == "Crafted Pavise" then
			v1563 = l__game__7.ReplicatedStorage.misc.Pavise:Clone();
		elseif u17.name == "Steel Punjis" or u17.name == "Crafted Punjis" then
			v1563 = l__game__7.ReplicatedStorage.misc.Punjis:Clone();
			v1563:FindFirstChild(u17.name):Destroy();
		elseif u17.name == "Remote Explosive" then
			v1563 = l__game__7.ReplicatedStorage.misc.RemoteEx:Clone();
			v1557 = 1.5;
		elseif u17.name == "Steel Snares" then
			v1557 = 2;
			v1563 = l__game__7.ReplicatedStorage.misc.Snare:Clone();
		end;
		v1563.Parent = l__CurrentCamera__1;
		v1563:SetPrimaryPartCFrame((ply.Character.HumanoidRootPart.CFrame + ply.Character.HumanoidRootPart.CFrame.lookVector * 3) * CFrame.new(0, -2.75, 0));
		if u17.name == "Steel Punjis" or u17.name == "Crafted Punjis" then
			v1563:SetPrimaryPartCFrame((ply.Character.HumanoidRootPart.CFrame + ply.Character.HumanoidRootPart.CFrame.lookVector * 3) * CFrame.new(0, -2.5, 0));
		elseif u17.name == "Steel Snares" then
			v1563:SetPrimaryPartCFrame((ply.Character.HumanoidRootPart.CFrame + ply.Character.HumanoidRootPart.CFrame.lookVector * 3) * CFrame.new(0, -2.25, 0));
		elseif u17.name == "Crafted Pavise" then
			v1563:SetPrimaryPartCFrame((ply.Character.HumanoidRootPart.CFrame + ply.Character.HumanoidRootPart.CFrame.lookVector * 3) * CFrame.new(0, -2, 0));
		end;
		for v1564, v1565 in ipairs(v1563:GetDescendants()) do
			if v1565:IsA("BasePart") and v1565.Transparency == 0 then
				v1565.BrickColor = BrickColor.new("Bright green");
				v1565.Material = "Neon";
				v1565.Transparency = 0.5;
				v1565.Anchored = true;
				v1565.CanCollide = false;
				v1565.Locked = true;
			elseif not v1565:IsA("Folder") then
				v1565:Destroy();
			end;
		end;
		if playerperks.trapper then
			v1557 = v1557 - v1557 * v6.trapper.efx[1] / 100;
		end;
		local v1566 = v1557 - v1557 * v47;
		while true do
			if u59 == false then
				v1562 = true;
				break;
			end;
			if u9.walking == true then
				v1562 = true;
				break;
			end;
			maingui.ChargeOverlay.ChargeOverlay.Size = UDim2.new((tick() - v1561) / v1566, 0, 1, 0);
			RS:wait();
			if v1566 <= tick() - v1561 then
				break;
			end;
			if u9.staggering == true then
				break;
			end;		
		end;
		v1563:Destroy();
		v1558[1]:Stop();
		v1558[2]:Stop();
		v1559:Disconnect();
		v1560:Disconnect();
		maingui.ChargeOverlay.Visible = false;
		u9.channel = false;
		u9.turnable = true;
		if v1562 == false then
			if u9.staggering == false then
				for v1567, v1568 in pairs(v5) do
					if v1568[2] == true then
						v1568[3] = v1568[3] - 1;
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
						local v1569 = l__game__7.ReplicatedStorage.misc.snareindicators:Clone();
						l__Debris__26:AddItem(v1569, 10);
						v1569.CFrame = (character.HumanoidRootPart.CFrame + character.HumanoidRootPart.CFrame.lookVector * 3) * CFrame.new(0, -2.25, 0);
						v1569.Parent = l__workspace__1.NoTarget;
						delay(2, function()
							for v1570 = 1, 20 do
								v1569.Transparency = v1570 / 20;
								RS:wait();
							end;
							v1569:Destroy();
						end);
					end);
				end;
				l__workspace__1.ServerStuff.deployTrap:FireServer(u17.name, v4);
				local l__throw__1571 = tpglobalanimsets.throw;
				globalanimsets.toss:Play(0.2);
				l__throw__1571.TimePosition = 0.3;
				l__throw__1571:AdjustSpeed(1);
				while true do
					RS:wait();
					if globalanimsets.toss.IsPlaying == false then
						break;
					end;				
				end;
				globalanimsets.toss:Stop(0.3);
				l__throw__1571:Stop(0.3);
				curentanimset.equip.TimePosition = 0.5;
				curentanimset.equip:AdjustSpeed(0);
				tpcurrentanimset.equip:Play();
				tpcurrentanimset.equip.TimePosition = 0.5;
				tpcurrentanimset.equip:AdjustSpeed(0);
				check_walking_anim();
				local v1572 = false;
				for v1573, v1574 in pairs(v5) do
					if v1574[2] == true and v1574[3] <= 0 then
						v1572 = true;
					end;
				end;
				if u17.name == "Remote Explosive" then
					v1572 = false;
				end;
				if v1572 == false then
					u9.action = false;
					return;
				else
					u19:Destroy();
					for v1575, v1576 in pairs(v5) do
						if v1576[2] == true then
							v1576[1] = "Fist";
							v1576[3] = nil;
						end;
					end;
					invmanage("updatehud");
					l__workspace__1.ServerStuff.useupItem:FireServer();
					u61("Fist");
					return;
				end;
			end;
			v1541 = u9;
			v1543 = false;
			v1542 = "action";
			v1544 = v1541;
			v1545 = v1542;
			v1546 = v1543;
			v1544[v1545] = v1546;
			local v1577 = u9;
			local v1578 = "staggering";
			v1547 = v1577;
			v1548 = v1578;
			local v1579 = v1547[v1548];
			local v1580 = false;
			v1549 = v1579;
			v1550 = v1580;
			if v1549 == v1550 then
				curentanimset.equip.TimePosition = 0.5;
				curentanimset.equip:AdjustSpeed(0);
				tpcurrentanimset.equip:Play();
				tpcurrentanimset.equip.TimePosition = 0.5;
				tpcurrentanimset.equip:AdjustSpeed(0);
				check_walking_anim();
			end;
		else
			v1541 = u9;
			v1543 = false;
			v1542 = "action";
			v1544 = v1541;
			v1545 = v1542;
			v1546 = v1543;
			v1544[v1545] = v1546;
			v1577 = u9;
			v1578 = "staggering";
			v1547 = v1577;
			v1548 = v1578;
			v1579 = v1547[v1548];
			v1580 = false;
			v1549 = v1579;
			v1550 = v1580;
			if v1549 == v1550 then
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
				local v1581 = u70;
				local v1582 = u17.speedrating;
				if akimbo_factors.active == true and akimbo_factors.alternate == true then
					v1581 = akimbo_factors.alt_tick;
					v1582 = akimbo_factors.alt_weapon_stats.speedrating;
				end;
				local v1583 = false;
				if fanning_levering == true and u9.aiming == false then
					v1583 = true;
					if u17.name == "Winchester 940-1" then
						v1582 = levering_firerate;
					end;
					if u17.name == "'The Redeemer'" or u17.name == "Peacemaker" or u17.name == "Peacemaker Uppercut" or u17.name == "Peacemaker Chain" then
						v1582 = fanning_firerate;
					end;
				end;
				if playerperks.paranoia and u17.auto == false and v1583 == false then
					v1582 = v1582 * v6.paranoia.efx[2] / 100;
				end;
				if v1582 < tick() - v1581 then
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
	l__workspace__1.ServerStuff.initiateblock:FireServer(v4, false);
	u26("stamina");
	local v1584 = u51;
	local v1585 = ({ 0.6, 0.7, 0.75, 0.8 })[u17.chargerating];
	if u10.Fracture or u8 <= 0 then
		v1585 = 0.6;
	end;
	if u17.name == "Executioner Sword" then
		v1585 = 0.45;
		v1584 = 1;
	end;
	local v1586 = v1585 * v1584;
	curentanimset.charge:Play(0);
	curentanimset.charge:AdjustSpeed(v1586);
	tpcurrentanimset.charge:Play(0);
	tpcurrentanimset.charge:AdjustSpeed(math.clamp(v1586 * 1.25, 0.5, 1));
	local v1587 = tick();
	local u175 = false;
	local v1588 = tpcurrentanimset.charge.KeyframeReached:connect(function(p150)
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
	v1588:Disconnect();
	if u9.staggering == false and u175 == true then
		if u17.animset == "1PB" then
			if u9.sprinting == true then
				l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", u17.animset }, "heavychargeswing", character.HumanoidRootPart, 0.05);
				local v1589 = tick();
				local v1590 = Instance.new("BodyVelocity");
				v1590.Name = "parkourPositionThing";
				v1590.P = 3000;
				v1590.MaxForce = Vector3.new(math.huge, math.huge, math.huge);
				v1590.Velocity = character.HumanoidRootPart.Velocity + character.HumanoidRootPart.CFrame.lookVector * 40;
				v1590.Parent = character.HumanoidRootPart;
				u39 = true;
				while true do
					RS:wait();
					if tick() - v1589 >= 0.2 then
						break;
					end;				
				end;
				delay(0.1, function()
					v1590:Destroy();
				end);
			end;
			l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", current_anim_set_use }, "swingheavy", character.HumanoidRootPart, 0.05);
			local l__plasmaEffect__1591 = u19:WaitForChild("plasmaEffect");
			l__plasmaEffect__1591:WaitForChild("t1").Enabled = true;
			l__plasmaEffect__1591:WaitForChild("t2").Enabled = true;
			delay(0.3, function()
				l__plasmaEffect__1591.t1.Enabled = false;
				l__plasmaEffect__1591.t2.Enabled = false;
			end);
		end;
		shakecamera("weapon", { current_anim_set_use, "charge" });
		l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", current_anim_set_use }, "chargeswing", character.HumanoidRootPart);
		if u10["Immolator Buff"] then
			l__workspace__1.ServerStuff.playAudio:FireServer({ "perks" }, "flamer_swing", character.HumanoidRootPart, 0.01);
		end;
		if startperk.Value == "hiddenB" then
			l__workspace__1.ServerStuff.dealDamage:FireServer("hiddeneyes", nil, v4);
			l__workspace__1.ServerStuff.playAudio:FireServer({ "events", "hiddenB" }, "attack", character.HumanoidRootPart);
		end;
		local v1592 = 0.55;
		if u8 <= 0 then
			v1592 = 0.45;
		end;
		curentanimset.charge.TimePosition = 0.4;
		curentanimset.charge:AdjustSpeed(v1592);
		tpcurrentanimset.charge.TimePosition = 0.4;
		tpcurrentanimset.charge:AdjustSpeed(v1592);
		local v1593 = false;
		local v1594 = u17.damagerating[2];
		u50 = tick();
		local v1595 = false;
		while true do
			if curentanimset.charge:GetTimeOfKeyframe("Hit") <= curentanimset.charge.TimePosition and v1593 == false then
				v1593 = true;
				if u48(v1594, "heavy") ~= nil then
					if v58.berzactive ~= nil then
						l__workspace__1.ServerStuff.dealDamage:FireServer("berzheal", nil, v4);
					end;
					if v1595 == false and u17.name == "'The Decimator'" then
						v1595 = true;
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
	v100({ "weapons", u17.animset }, "swingwindup", nil, nil, true, true);
	delay(0.4, function()
		l__workspace__1.ServerStuff.playAudio:FireServer({ "weapons", u17.animset }, "swing", character.HumanoidRootPart);
	end);
	curentanimset.swing:Play(0.2, 1, 1.2);
	tpcurrentanimset.swing:Play(0.2, 1, 1.2);
	local v1596 = false;
	shakecamera("weapon", { "LSMG", "swing" });
	local v1597 = nil;
	while true do
		u25(nil);
		if curentanimset.swing:GetTimeOfKeyframe("Strike") <= curentanimset.swing.TimePosition and v1596 == false then
			v1596 = true;
			v1597 = u48("minigunbash");
			if v1597 then
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
		if u9.cancombo == false and v1597 ~= nil then
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
	if v59[2].noaimmod == true then
		return;
	end;
	if u10.Fracture then
		return;
	end;
	if u9.action == true and u9.firing == false then
		return;
	end;
	if v58.gogglesactive == true then
		return;
	end;
	if tick() - baseadstick <= 0.5 then
		return;
	end;
	v100({ "firearms" }, "ads_in", nil, nil, true, true);
	baseadstick = tick();
	u9.aiming = true;
	local v1598 = 60;
	u78 = 0.2;
	if u17.weapontype == "Bow" then
		v1598 = 40;
	end;
	local v1599 = false;
	local v1600 = tick();
	local v1601 = nil;
	if u17.name == "Modded Rifle" or u17.name == "Remington 700" or u17.name == "R11 RSASS" then
		v1599 = true;
		v1598 = 50;
	end;
	if v1599 == true then
		v1601 = l__game__7.ReplicatedStorage.effects.sniperScope:Clone();
		v1601.Enabled = false;
		v1601.Parent = ply.PlayerGui;
		sniperscope = v1601;
	end;
	if playerperks.zoom then
		v1598 = v1598 - v1598 * v6.zoom.efx[1] / 100;
	end;
	if u17.weapontype == "Gun" then
		maingui.Centre.crosshair.Visible = playerstats.Settings.ADSCrosshair;
	end;
	u79 = playerstats.Settings.AimSens;
	while true do
		RS:wait();
		if v1599 == true then
			if tick() - v1600 < 0.5 then
				l__CurrentCamera__1.FieldOfView = lerp(l__CurrentCamera__1.FieldOfView, v1598, 0.05);
			elseif v1601.Enabled == false then
				v1601.Enabled = true;
				fparms.Parent = nil;
				l__CurrentCamera__1.FieldOfView = 10;
				maingui.Enabled = false;
			end;
		else
			l__CurrentCamera__1.FieldOfView = lerp(l__CurrentCamera__1.FieldOfView, v1598, 0.05);
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
	v100({ "firearms" }, "ads_out", nil, nil, true, true);
	if v1599 == true then
		fparms.Parent = l__CurrentCamera__1;
		maingui.Enabled = true;
		if v1601 ~= nil then
			v1601:Destroy();
			sniperscope = nil;
		end;
		l__CurrentCamera__1.FieldOfView = v1598;
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
			local v1602 = "detexplosives";
			if u17.name == "Rigged Detonator" then
				v1602 = "detrigged";
			end;
			l__workspace__1.ServerStuff.deployTrap:FireServer(v1602, v4);
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
local v1603 = mouse.Move:connect(function()
	if character:FindFirstChild("Torso") == nil then
		return;
	end;
	u178();
	local v1604 = math.asin((mouse.Hit.p - mouse.Origin.p).unit.y);
	if u9.staggering == true then
		v1604 = 0;
	end;
	if tick() - u179 >= 0.1 then
		u179 = tick();
		l__workspace__1.ServerStuff.adjustArms:FireServer(character.Torso, v1604);
	end;
end);
local u180 = nil;
local u181 = nil;
local function u182()
	local v1605 = getPstats(u180);
	if maingui:FindFirstChild("EnemyFrame") == nil then
		return;
	end;
	maingui.EnemyFrame.Visible = true;
	maingui.EnemyFrame.EnemyName.Text = v1605[7];
	maingui.EnemyFrame.HealthBar.Bar.Size = UDim2.new(v1605[1] / v1605[6], 0, 1, 0);
	maingui.EnemyFrame.StaminaBar.Bar.Size = UDim2.new(v1605[2] / v1605[10], 0, 1, 0);
	for v1606, v1607 in pairs(v1605[3]) do
		local v1608 = require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS)[v1606];
		if v1608 ~= nil then
			if not maingui.EnemyFrame.EnemyDebuffs:FindFirstChild(v1606) and not maingui.EnemyFrame.EnemyBuffs:FindFirstChild(v1606) then
				local v1609 = false;
				local v1610 = maingui.EnemyFrame.EnemyDebuffs;
				if v1608.colour ~= nil then
					v1609 = true;
					v1610 = maingui.EnemyFrame.EnemyBuffs;
				end;
				local v1611 = v1610.Example:Clone();
				v1611.Visible = true;
				v1611.Name = v1606;
				v1611.Icon.Image = "rbxassetid://" .. v1608.icon;
				v1611.Bar.Size = UDim2.new(1, 0, v1607[2], 0);
				if v1609 == true then
					v1611.Bar.BackgroundColor3 = v1608.colour;
				end;
				v1611.Parent = v1610;
				for v1612, v1613 in ipairs(v1610:GetChildren()) do
					if v1613.Name ~= "Example" then
						v1613.Position = UDim2.new(-0.2 + 0.1 * v1612, 0, 0.5, 0);
					end;
				end;
			else
				local v1614 = maingui.EnemyFrame.EnemyDebuffs:FindFirstChild(v1606);
				if v1614 == nil then
					v1614 = maingui.EnemyFrame.EnemyBuffs:FindFirstChild(v1606);
				end;
				if v1614 ~= nil then
					v1614.Bar.Size = UDim2.new(1, 0, v1607[2], 0);
				end;
			end;
		end;
	end;
	for v1615, v1616 in ipairs({ maingui.EnemyFrame.EnemyDebuffs, maingui.EnemyFrame.EnemyBuffs }) do
		local v1617, v1618, v1619 = ipairs(v1616:GetChildren());
		while true do
			local v1620, v1621 = v1617(v1618, v1619);
			if not v1620 then
				break;
			end;
			local v1622 = true;
			for v1623, v1624 in pairs(v1605[3]) do
				if v1621.Name == v1623 then
					v1622 = false;
				end;
			end;
			if v1622 == true and v1621.Name ~= "Example" then
				v1621:Destroy();
				for v1625, v1626 in ipairs(v1616:GetChildren()) do
					if v1626.Name ~= "Example" then
						v1626.Position = UDim2.new(-0.2 + 0.1 * v1625, 0, 0.5, 0);
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
		for v1627, v1628 in ipairs(maingui.EnemyFrame.EnemyDebuffs:GetChildren()) do
			if v1628.Name ~= "Example" then
				v1628:Destroy();
			end;
		end;
		for v1629, v1630 in ipairs(maingui.EnemyFrame.EnemyBuffs:GetChildren()) do
			if v1630.Name ~= "Example" then
				v1630:Destroy();
			end;
		end;
	end;
end;
u178 = function()
	local v1631 = raycastline(l__CurrentCamera__1.CFrame.p, l__CurrentCamera__1.CFrame.LookVector, 50, baselayer);
	if v1631 then
		if v1631.Parent:FindFirstChild("Humanoid") and l__game__7.Players:GetPlayerFromCharacter(v1631.Parent) and v1631.Parent:FindFirstChild("Humanoid").Health > 0 and v1631.Parent:FindFirstChild("Torso") and v1631.Parent:FindFirstChild("Torso").Transparency ~= 1 then
			if u180 == nil then
				u180 = l__game__7.Players:GetPlayerFromCharacter(v1631.Parent);
				l__game__7:GetService("RunService"):BindToRenderStep("targlockstep", 150, u182);
				u181 = true;
				return;
			elseif l__game__7.Players:GetPlayerFromCharacter(v1631.Parent) ~= u180 then
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
if v59[3].multicooldown then
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
	local v1632 = maingui.teammatesframe:GetChildren();
	for v1633, v1634 in pairs(v1632) do
		if v1634.Name ~= "ex" then
			v1634.Parent = nil;
		end;
	end;
	for v1635, v1636 in pairs(v1632) do
		if v1636.Name ~= "ex" then
			v1636.Position = UDim2.new(0, 0, 1, 70 - 70 * #maingui.teammatesframe:GetChildren());
			v1636.Parent = maingui.teammatesframe;
		end;
	end;
end;
local function u191(p154)
	if tick() - u184 <= 1 then
		return;
	end;
	if p154 <= -43 then
		if v51 ~= false then
			u184 = tick();
			l__workspace__1.ServerStuff.dealDamage:FireServer("fall_damage", nil, v4);
			l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "falldamage1", character.Head);
			l__workspace__1.ServerStuff.playAudio:FireServer({ "general" }, "falldamage2", character.Head);
			local l__Crp__1637 = require(l__game__7.Workspace.ServerStuff.Statistics.S_STATISTICS).Crp;
			l__Crp__1637.intensity = 4;
			afflictstatus(l__Crp__1637);
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
	local v1638 = nil;
	local v1639, v1640 = raycastline(l__CurrentCamera__1.CFrame.p, l__CurrentCamera__1.CFrame.LookVector, 5, baselayer);
	u102 = 0;
	local v1641 = nil;
	if v1639 then
		if v1639.Name == "JointGrip" then
			v1641 = "Item";
		elseif v1639.Name == "Interact" then
			v1641 = "Interaction";
		end;
		v1638 = v1639.Parent;
	end;
	local v1642 = 4;
	if v1638 == nil and v1641 == nil then
		for v1643, v1644 in pairs(l__workspace__1.WeaponDrops:GetChildren()) do
			if v1644:FindFirstChild("JointGrip") and (v1644.JointGrip.CFrame.p - v1640).magnitude < v1642 and v1644:FindFirstChild("JointGrip").Locked == false then
				v1642 = (v1644.JointGrip.CFrame.p - v1640).magnitude;
				v1638 = v1644;
				if v1644:FindFirstChild("JointGrip") then
					v1641 = "Item";
				elseif v1644:FindFirstChild("Interact") then
					v1641 = "Interactable";
				end;
			end;
		end;
	end;
	if v1638 and craftlist[u17.name] then
		if craftlist[u17.name][v1638.Name] then
			v1641 = { craftlist[u17.name][v1638.Name], v17[craftlist[u17.name][v1638.Name]].name };
		elseif v1638.Name == "Model" and craftlist[u17.name][v1638.Parent.Name] then
			v1641 = { craftlist[u17.name][v1638.Parent.Name], v17[craftlist[u17.name][v1638.Parent.Name]].name };
		end;
	end;
	maingui.Centre.craftingmarker.Visible = false;
	maingui.Centre.interactmarker.Visible = false;
	maingui.Centre.pickupmarker.Visible = false;
	local v1645 = false;
	if v1638 and u9.action == false and v1641 then
		maingui.Centre.crosshair.Visible = false;
		if v1641 == "Item" then
			local v1646 = v17[v1638.Name];
			local v1647 = "Item";
			if v1646.weapontype == "Bludgeon" or v1646.weapontype == "Axe" or v1646.weapontype == "Spear" or v1646.weapontype == "Blade" then
				v1647 = "Primary";
			end;
			if v1647 == "Primary" then
				if v5[1][1] == "Fist" then
					v1645 = true;
				end;
			else
				for v1648, v1649 in pairs(v5) do
					if v1649[1] == "Fist" and v1648 ~= 1 then
						v1645 = true;
						break;
					end;
				end;
				if v1646.name == u17.name and u19:FindFirstChild("ammo") and u19.ammo:FindFirstChild("maxammo") then
					local v1650 = nil;
					for v1651, v1652 in pairs(v5) do
						if v1652[2] == true then
							v1650 = v1652[3];
						end;
					end;
					v1645 = v1650 < u19.ammo.maxammo.Value;
				end;
			end;
			maingui.Centre.pickupmarker.Visible = true;
			if v1645 == true then
				maingui.InteractFrame.dispText.Text = "TAKE";
				if v1646.name == u17.name and u19:FindFirstChild("ammo") and u19.ammo:FindFirstChild("maxammo") then
					maingui.InteractFrame.dispText.Text = "REFILL";
				end;
				maingui.InteractFrame.intText.Text = v1646.name;
				if v1638 and v1638:FindFirstChild("skinned") and v19[v1638:FindFirstChild("skinned").Value] then
					maingui.InteractFrame.intText.Text = v19[v1638:FindFirstChild("skinned").Value].name;
				end;
				maingui.InteractFrame.Visible = true;
				u103 = v1638;
				return;
			else
				maingui.InteractFrame.dispText.Text = "FULL";
				if v1646.name == u17.name and u19:FindFirstChild("ammo") and u19.ammo:FindFirstChild("maxammo") then
					maingui.InteractFrame.dispText.Text = "FULL";
				end;
				maingui.InteractFrame.intText.Text = v1646.name;
				maingui.InteractFrame.Visible = true;
				u103 = nil;
				return;
			end;
		elseif v1641 == "Interaction" then
			maingui.Centre.interactmarker.Visible = true;
			maingui.InteractFrame.dispText.Text = "INTERACT";
			maingui.InteractFrame.intText.Text = v1638.Name;
			maingui.InteractFrame.Visible = true;
			if v1638:FindFirstChild("stats") and v1638:FindFirstChild("stats"):FindFirstChild("cost") then
				u102 = v1638:FindFirstChild("stats"):FindFirstChild("cost").Value;
			end;
			u103 = { v1638 };
			return;
		elseif typeof(v1641) == "table" then
			maingui.Centre.craftingmarker.Visible = true;
			maingui.InteractFrame.dispText.Text = "CRAFT";
			maingui.InteractFrame.intText.Text = v1641[2];
			maingui.InteractFrame.Visible = true;
			u103 = { "craft", v1638, v1641[2] };
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
	local v1653 = l__workspace__1.activePlayers:GetChildren();
	if teamfolder ~= nil then
		v1653 = teamfolder:GetChildren();
	end;
	if forcespecfolder == true then
		local v1654 = {};
		local v1655, v1656, v1657 = ipairs(l__workspace__1.GamemodeStuff:FindFirstChild("TeamA"):GetChildren());
		while true do
			local v1658, v1659 = v1655(v1656, v1657);
			if v1658 then

			else
				break;
			end;
			v1657 = v1658;
			table.insert(v1653, v1659);		
		end;
		local v1660, v1661, v1662 = ipairs(l__workspace__1.GamemodeStuff:FindFirstChild("TeamB"):GetChildren());
		while true do
			local v1663, v1664 = v1660(v1661, v1662);
			if v1663 then

			else
				break;
			end;
			v1662 = v1663;
			table.insert(v1653, v1664);		
		end;
	end;
	local v1665 = v1653[spectatenum];
	if spectatenum < 1 then
		v1665 = v1653[#v1653];
	end;
	if v1665 ~= nil then
		if v1665:FindFirstChild("HumanoidRootPart") then

		else
			spectatenum = 1;
			if 0 < #v1653 then
				beginspectate(p155);
			end;
			return;
		end;
	else
		spectatenum = 1;
		if 0 < #v1653 then
			beginspectate(p155);
		end;
		return;
	end;
	l__CurrentCamera__1.CameraType = "Follow";
	l__CurrentCamera__1.CameraSubject = v1665:FindFirstChild("HumanoidRootPart");
	p155.spectate.current.Text = v1665.Name;
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
	local v1666 = tick();
	while true do
		p156.status.Position = p156.status.Position:Lerp(UDim2.new(0.5, 0, 1, 0), 0.05);
		p156.blackbar1.Position = p156.blackbar1.Position:Lerp(UDim2.new(0, 0, 0, -180), 0.1);
		p156.blackbar2.Position = p156.blackbar2.Position:Lerp(UDim2.new(0, 0, 1, 180), 0.1);
		RS:wait();
		if not (2 <= tick() - v1666) then

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
		if hum.Health < v6.desp.efx[1] then
			if perksactive.desp == nil then
				perksactive.desp = true;
				u21 = u21 + v6.desp.efx[2] / 100;
			end;
		elseif perksactive.desp == true then
			perksactive.desp = nil;
			u21 = u21 - v6.desp.efx[2] / 100;
		end;
	end;
	if playerperks.octopus and hum.Health < v6.octopus.efx[1] and perksactive.octopus == nil then
		perksactive.octopus = true;
		l__workspace__1.ServerStuff.dealDamage:FireServer("dropsmoke", nil, v4);
	end;
	if playerperks.second and hum.Health < v6.second.efx[1] and perksactive.second == nil then
		perksactive.second = true;
		u8 = u8 + 100;
		delay(v6.second.efx[3], function()
			perksactive.second = nil;
		end);
	end;
	if v59[2].nothirstmod == true then
		ration_system_handler.thirst = tick();
	end;
	local v1667 = CFrame.new();
	if (u17.animset == "RV" or u17.animset == "PST" or u17.animset == "2HPST") and u9.aiming == false and playerstats.Class == "revolver" and u9.using_perk == false and akimbo_factors.active == false then
		v1667 = CFrame.new(0.5, 0, -1) * CFrame.Angles(0, math.rad(30), math.rad(-4));
	end;
	if u17.animset == "RV" or u17.animset == "PST" or u17.animset == "RFL" or u17.animset == "SMG" or u17.animset == "ASMG" or u17.animset == "2HPST" then
		if tick() - gun_holster_timer > 3 then
			local v1668 = globalanimsets.holster_rifle;
			if u17.animset == "RV" or u17.animset == "PST" or u17.animset == "2HPST" then
				v1668 = globalanimsets.holster_pistol;
				if playerstats.Class == "revolver" then
					v1668 = nil;
				end;
			elseif u17.animset == "SMG" then
				v1668 = globalanimsets.holster_smg;
			end;
			if akimbo_factors.active == true then
				v1668 = globalanimsets.holster_akimbo;
			end;
			if v1668 ~= nil and v1668.IsPlaying == false then
				v1668:Play(0.5, 1, 1);
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
	local v1669 = u78;
	if not (not u10["Stamina Buff"]) or not (not u10["Artillerist Buff"]) or u10["Koldera Buff"] then
		v1669 = 0.02;
	end;
	local v1670 = UIS:GetMouseDelta();
	move_delta = move_delta:Lerp(CFrame.Angles(math.clamp(math.rad(v1670.y) / 6, -0.35, 0.35), math.clamp(math.rad(v1670.x) / 8, -0.35, 0.35), math.clamp(math.rad(v1670.x) / 6, -0.35, 0.35)), 0.2);
	if u9.walking == true and u11 > 0.1 then
		tpglobalanimsets.run:AdjustWeight(hum.WalkSpeed / 18);
		tpglobalanimsets.run:AdjustSpeed(0.6 + hum.WalkSpeed / 40);
		u186 = 8 * hum.WalkSpeed / 18;
		local v1671 = move_delta;
		if u9.aiming == true then
			v1671 = CFrame.Angles(0, 0, 0);
		end;
		u118 = u118:Lerp(CFrame.new(math.cos(time() * 6 * u186 / 8) * 0.2 / 2 * v1669, 0, math.sin(time() * 14 * u186 / 8) * 0.075 / 2 * v1669) * u57 * v1667 * v1671, 0.3);
		local v1672 = 0;
		if u10.Cripple and u10.Painkillers == nil then
			v1672 = math.clamp(math.cos(time() * 6) * 0.05, -10000, 0);
		end;
		u117 = u117:Lerp(CFrame.Angles(math.sin(time() * 8 * u186 / 8) * 0.075 / 6 * v1669, math.cos(time() * 4 * u186 / 8) * 0.2 / 6 * v1669, v1672), 0.3);
	else
		if u9.aiming == false then
			u118 = u118:Lerp(CFrame.new(0, 0, math.cos(time() * 1.5) * 0.05) * u57 * v1667 * move_delta, 0.3);
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
	if playerperks.regen and hum.Health < hum.MaxHealth and v6.regen.efx[1] < tick() - u187 then
		u187 = tick();
		l__workspace__1.ServerStuff.dealDamage:FireServer("regenperk", nil, v4);
	end;
	local v1673 = 300;
	local v1674 = true;
	local v1675 = true;
	if l__workspace__1.GamemodeStuff:FindFirstChild("outerGas") and startperk.Value ~= "hubbing" then
		local v1676 = math.clamp(l__workspace__1.GamemodeStuff:FindFirstChild("outerGas").Size.X / 2.1 - (character.HumanoidRootPart.Position - l__workspace__1.mapCentre.Position).magnitude, -300, 300);
		if (character.HumanoidRootPart.Position - l__workspace__1.mapCentre.Position).magnitude <= 150 and (character.HumanoidRootPart.Position - l__workspace__1.mapCentre.Position).magnitude <= 130 and (character.HumanoidRootPart.Position - l__workspace__1.mapCentre.Position).magnitude >= 70 then
			v1674 = false;
			u188 = lerp(u188, 30, 0.05);
		end;
		if v1673 <= 20 and u10.Toxins == nil then
			v1675 = false;
			v57.Volume = 1.2 - v1673 / 20;
		end;
		if l__workspace__1.GamemodeStuff:FindFirstChild("outerGas").Size.X / 2.1 <= (character.HumanoidRootPart.Position - l__workspace__1.mapCentre.Position).magnitude then
			afflictstatus(require(l__workspace__1.ServerStuff.Statistics.S_STATISTICS).Psn);
		elseif u97 == false and u10.Toxins then
			u10.Toxins.effects.currentduration = 0;
		end;
	end;
	if v1675 == true then
		if u10.Toxins == nil then
			if u72 == true then
				v57.Volume = 0.1;
			else
				v57.Volume = l__game__7.ReplicatedStorage.soundLibrary.general_ui.storm_ambience.Volume;
			end;
		else
			v57.Volume = 1.3;
		end;
	end;
	if v1674 == true then
		u188 = lerp(u188, 0, 0.1);
	end;
	if u21 >= 30 then
		ply:Kick(filth[math.random(1, #filth)]);
	end;
	if u20 >= 30 then
		ply:Kick(filth[math.random(1, #filth)]);
	end;
	if v1673 < 0 then
		v1673 = -v1673;
	end;
	l__game__7.Lighting.FogEnd = v1673 + u188;
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
		v100({ "movement_sounds" }, "step" .. math.random(1, 4), nil, nil, true, true);
	end;
	if maingui.Centre.crosshair.Visible == true then
		maingui.Centre.crosshair.A1.Position = UDim2.new(0.5, 0, 0.5, -5);
		maingui.Centre.crosshair.A2.Position = UDim2.new(0.5, 0, 0.5, 5);
		maingui.Centre.crosshair.B1.Position = UDim2.new(0.5, -5, 0.5, 0);
		maingui.Centre.crosshair.B2.Position = UDim2.new(0.5, 5, 0.5, 0);
		if (u17.weapontype == "Bow" or u17.weapontype == "Gun") and (u17.weapontype == "Gun" and u9.aiming == false or u17.weapontype == "Bow" and u9.walking == true) then
			local v1677 = u17.sizerating * 3.5;
			local v1678 = math.clamp(v1677 - v1677 * v40, 1.5, 30);
			maingui.Centre.crosshair.A1.Position = UDim2.new(0.5, 0, 0.5, -5 - v1678);
			maingui.Centre.crosshair.A2.Position = UDim2.new(0.5, 0, 0.5, 5 + v1678);
			maingui.Centre.crosshair.B1.Position = UDim2.new(0.5, -5 - v1678, 0.5, 0);
			maingui.Centre.crosshair.B2.Position = UDim2.new(0.5, 5 + v1678, 0.5, 0);
		end;
		if u9.throwing == true then
			maingui.Centre.crosshair.B1.Position = UDim2.new(0.5, -10, 0.5, 0);
			maingui.Centre.crosshair.B2.Position = UDim2.new(0.5, 10, 0.5, 0);
		end;
	end;
	if teamfolder ~= nil and tick() - updateteamhealth >= 0.3 then
		updateteamhealth = tick();
		for v1679, v1680 in pairs(teamfolder:GetChildren()) do
			if maingui.teammatesframe:FindFirstChild(v1680.Name) and v1680:FindFirstChild("Humanoid") then
				maingui.teammatesframe:FindFirstChild(v1680.Name).empty.bar.Size = UDim2.new(v1680:FindFirstChild("Humanoid").Health / v1680:FindFirstChild("Humanoid").MaxHealth, 0, 1, 0);
				maingui.teammatesframe:FindFirstChild(v1680.Name).exact_health.Text = math.ceil(v1680:FindFirstChild("Humanoid").Health);
			elseif maingui.teammatesframe:FindFirstChild(v1680.Name) == nil and v1680:FindFirstChild("Humanoid") and v1680.Name ~= ply.Name then
				local v1681 = maingui.teammatesframe.ex:Clone();
				v1681.Name = v1680.Name;
				v1681.exact_health.Text = math.ceil(v1680:FindFirstChild("Humanoid").Health);
				v1681.empty.bar.Size = UDim2.new(v1680:FindFirstChild("Humanoid").Health / v1680:FindFirstChild("Humanoid").MaxHealth, 0, 1, 0);
				v1681.playername.Text = v1680.Name;
				v1681.Visible = true;
				v1681.Position = UDim2.new(0, 0, 1, 70 - 70 * #maingui.teammatesframe:GetChildren());
				v1681.Parent = maingui.teammatesframe;
			end;
		end;
		for v1682, v1683 in pairs(maingui.teammatesframe:GetChildren()) do
			if teamfolder:FindFirstChild(v1683.Name) == nil and v1683.Name ~= "ex" then
				v1683:Destroy();
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
	if v52 == true then
		if u10.Bleed then
			u10.Bleed.effects.currentduration = 0;
		end;
		if u10["Arterial Bleed"] then
			u10["Arterial Bleed"].effects.currentduration = 0;
		end;
	end;
	if v54 == true and u10.Fracture then
		u10.Fracture.effects.currentduration = 0;
	end;
	if v53 == true and u10.Cripple then
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
	if startperk.Value ~= "hubbing" and v59 and v59[3] and v59[3].cooldown then
		local v1684 = (tick() - u111) / v59[3].cooldown;
		maingui.PerkFrame.status.Text = math.round(math.clamp(v1684, 0, 1) * 100) .. "%";
		if v59[3].multicooldown then
			maingui.PerkFrame.multiple.Text = "x" .. math.floor(math.clamp(tick() - u111, 0, v59[3].cooldown) / v59[3].multicooldown);
		end;
		if v59[3].inverse_cd then
			maingui.PerkFrame.status.Text = 100 - math.round(math.clamp(v1684, 0, 1) * 100) .. "%";
		end;
		if v1684 >= 1 then
			if cd_ping == false then
				v100({ "perks" }, "perk_ping", nil, nil, true, true);
				cd_ping = true;
			end;
		else
			cd_ping = false;
		end;
	end;
	if u8 < v61 and tick() - u14.stamregen > 0.5 then
		local v1685 = u15;
		if u9.walking == true then
			v1685 = v1685 + 0.05;
		end;
		if v1685 < tick() - u14.regentick then
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
	local v1686 = CFrame.Angles(0, 0, 0);
	for v1687, v1688 in pairs(u27) do
		v1686 = v1686 * v1688;
	end;
	if spectating == false then
		adjustcamto = adjustcamto:Lerp(u31, 0.075);
		l__CurrentCamera__1.CFrame = CFrame.new(character.HumanoidRootPart.Position + adjustcamto) * CFrame.Angles(0, u157.X, 0) * CFrame.Angles(u157.Y, 0, 0) * u117 * v1686;
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
		local v1689 = 1 + baseadsmod;
		if u17.animset == "PST" or u17.animset == "2HPST" or u17.animset == "RV" then
			v1689 = v1689 + 1;
		end;
		if u10["Speed Buff"] then
			v1689 = v1689 + 2;
		end;
		if u10["Artillerist Buff"] then
			v1689 = v1689 + 1;
		end;
		local v1690 = baseadstime / v1689;
		local v1691 = math.clamp(tick() - baseadstick, 0, v1690) / v1690;
		if u9.aiming == true and u17.weapontype == "Gun" then
			camroot.camRootWeld.C0 = camroot.camRootWeld.C0:Lerp(fparms.ROOT.CFrame:toObjectSpace(u19.ADS.CFrame * CFrame.new(0, -1, -1.75) * CFrame.Angles(math.rad(-90), 0, 0)):inverse(), v1691);
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
	if v108.damagetaken >= 200 then
		l__workspace__1.ServerStuff.adjustStats:FireServer("tracker", { "Tanked200", 1 });
	end;
	if v108.damage <= 50 then
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
			local l__cuffs__1692 = character:WaitForChild("cuffs");
			if l__cuffs__1692 then
				l__cuffs__1692.beam.Enabled = true;
			end;
		end);
	end;
	v108.placed = #l__workspace__1.activePlayers:GetChildren();
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
	v1424:Disconnect();
	v109:Disconnect();
	pcall(function()
		l__game__7:GetService("RunService"):UnbindFromRenderStep("rsloop");
	end);
	v1603:Disconnect();
	for v1693, v1694 in ipairs(l__workspace__1.NoTarget:GetChildren()) do
		if v1694.Name == "colBox" then
			v1694:Destroy();
		end;
	end;
	for v1695, v1696 in ipairs(l__CurrentCamera__1:GetChildren()) do
		v1696:Destroy();
	end;
	RS:wait();
	l__CurrentCamera__1.CameraType = Enum.CameraType.Scriptable;
	local l__Torso__1697 = character:FindFirstChild("Torso");
	if l__Torso__1697 ~= nil then
		l__CurrentCamera__1.FieldOfView = 40;
		l__CurrentCamera__1.CameraSubject = l__Torso__1697;
		local u193 = false;
		spawn(function()
			local v1698 = 6.3;
			local v1699, v1700 = raycastline(l__CurrentCamera__1.CFrame.p, -l__CurrentCamera__1.CFrame.lookVector, 6.3, baselayer);
			if v1699 then
				v1698 = (l__CurrentCamera__1.CFrame.p - v1700).magnitude;
			end;
			l__CurrentCamera__1.CFrame = l__Torso__1697.CFrame * CFrame.new(v1698, 1, -5) * CFrame.Angles(math.rad(-10), math.rad(110), 0);
			while true do
				fparms.Parent = nil;
				local v1701, v1702 = raycastline(l__CurrentCamera__1.CFrame.p, -l__CurrentCamera__1.CFrame.lookVector, 6.3, baselayer);
				if v1701 and (l__CurrentCamera__1.CFrame.p - v1702).magnitude <= v1698 then
					v1698 = (l__CurrentCamera__1.CFrame.p - v1702).magnitude;
				end;
				l__CurrentCamera__1.CFrame = CFrame.new(l__Torso__1697.CFrame.p) * CFrame.new(v1698, 1, -3) * CFrame.Angles(math.rad(-10), math.rad(110), 0);
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
		v100({ "deaths" }, "suspense", nil, nil, true, true);
		delay(1.05, function()
			l__game__7:GetService("SoundService").regular.Volume = 0;
			ply.PlayerGui.fadetoblack.frame.BackgroundTransparency = 0;
			u194 = true;
			delay(1, function()
				l__game__7:GetService("SoundService").regular.Volume = 1;
				l__game__7.Lighting.FogStart = 0;
				l__game__7.Lighting.FogEnd = 100;
				local v1703 = l__game__7.ReplicatedStorage.effects.endgamegui:Clone();
				v1703.status.Position = UDim2.new(0.5, 0, 1, 0);
				v1703.status.menu.Visible = true;
				v1703.status.spectate.Visible = false;
				v1703.Parent = ply.PlayerGui;
				v1703.Enabled = true;
				ply.CameraMode = "Classic";
				UIS.MouseIconEnabled = true;
				maingui.Enabled = false;
				spectatesystem(v1703);
				v1703.status.spectate.Visible = false;
				v1703.status.menu.MouseButton1Click:connect(function()
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
	v108.timealive = tick();
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
	local v1704 = l__game__7.ReplicatedStorage.effects.endgamegui:Clone();
	v1704.status.Position = UDim2.new(0.5, 0, 1, 0);
	v1704.status.menu.Visible = true;
	v1704.status.spectate.Visible = false;
	v1704.Parent = ply.PlayerGui;
	v1704.Enabled = true;
	character.HumanoidRootPart.Anchored = true;
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
end;
if startperk.Value ~= "hubbing" then
	l__CurrentCamera__1.CameraSubject = ply.Character.Humanoid;
	l__CurrentCamera__1.CameraType = "Custom";
end;
RS:wait();
if spectating == false then
	afflictstatus(require(l__game__7.Workspace.ServerStuff.Statistics.S_STATISTICS).VirusA);
end;
for v1705 = 1, 10 do
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