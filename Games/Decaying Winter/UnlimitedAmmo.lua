-- // Information
--[[
    Note: If you set the amount to a high value, make sure you also execute the anti-cheat bypass as well
]]

-- // Vars
local Amount = 200

-- // Loop through gc
for _, v in ipairs(getgc(true)) do
    -- // Make sure is a table and narrow it down to the ammo table
    if (typeof(v) == "table" and rawget(v, "Light") and rawget(v, "Small")) then
        -- // Set Ammo
        for AmmoType, _ in pairs(v) do
            v[AmmoType] = Amount
        end
    end
end