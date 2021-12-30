-- // Client Manager Class
local ClientManager = {}
ClientManager.__index = ClientManager
do
    -- // Feel free to add more
    ClientManager.Identifiers = {
        ["table"] = {
            getbodyparts = "replication",
            updateammo = "hud",
            onmousemove = "input",
            basecframe = "camera"
        }
    }

    -- //
    local function HasIdentifiers(v, IdentifyType)
        -- // Loop through identifiers
        for Identifier, Name in pairs(ClientManager.Identifiers[IdentifyType] or {}) do
            -- // Check it has the identifier
            local TableCheck = IdentifyType == "table" and rawget(v, Identifier)
            local FunctionCheck = IdentifyType == "function" and debug.getinfo(v).name == Identifier
            if (TableCheck or FunctionCheck) then
                -- // Return the stuffs
                return Identifier, Name
            end
        end
    end

    -- // Constructor
    function ClientManager.new()
        -- // Initialise object
        local self = setmetatable({}, ClientManager)

        -- //
        self:InitialiseIdentifiers()
        self.Characters = debug.getupvalue(self.replication.getbodyparts, 1)

        -- // Return object
        return self
    end

    -- //
    function ClientManager.InitialiseIdentifiers(self)
        -- // Loop through GC
        for _, v in ipairs(getgc(true)) do
            -- / Vars
            local Type = typeof(v)

            -- // See if has identifiers
            local _, Name = HasIdentifiers(v, Type)
            if (Name) then
                -- // Set
                self[Name] = v
            end
        end
    end
end

-- //
return ClientManager