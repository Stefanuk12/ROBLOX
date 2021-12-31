-- // Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- // Vars
local WeaponManagerClient = require(ReplicatedStorage.Modules.Client.Managers.WeaponManagerClient)

-- // Hook the function that makes the connections
hookfunction(WeaponManagerClient.ConnectCharacterChecker, function() end)

-- // Hook the current connected funcs
for _, v in ipairs(getreg()) do
    -- // Vars
    local constants = debug.getconstants(v)

    -- // Check constants
    if (not is_synapse_function(v) and islclosure(v) and table.find(constants, "HipHeight") and table.find(constants, 3.1)) then
        -- // Hook
        print(v)
        hookfunction(v, function() end)
    end
end