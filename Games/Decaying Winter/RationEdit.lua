-- // Services
local Players = game:GetService("Players")

-- // Vars
local LocalPlayer = Players.LocalPlayer
local Backpack = LocalPlayer.Backpack
local mainHandler = Backpack:WaitForChild("mainHandler")

local ration_system_handler = getsenv(mainHandler).ration_system_handler
local RationSystemHandlerProxy = {
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
}

-- // Set
for i, v in pairs(RationSystemHandlerProxy) do
    ration_system_handler[i] = v
end