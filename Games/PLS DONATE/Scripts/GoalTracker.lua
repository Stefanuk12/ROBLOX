-- // Dependencies
local Signals = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/PLS%20DONATE/Signals.lua"))()
local DonateManager, BoothManager, ChatMessageManager, BoothMessageManager, MessageManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/PLS%20DONATE/Manager.lua"))()

-- // Services
local HttpService = game:GetService("HttpService")

-- //
local GoalTracker = {}
GoalTracker.__index = GoalTracker
do
    -- // Vars
    GoalTracker.DefaultData = {
        GoalId = 5,

        Progress = 0,
        Goal = 100,

        GoalFormat = "Goal: %d out of %d",
        StoreDirectory = "goals"
    }

    -- // Constructor
    function GoalTracker.new(Data)
        -- // Default
        Data = Data or {}

        -- // Create object
        local self = setmetatable({}, GoalTracker)

        -- // Vars
        self:LoadDefaults(Data)

        -- // Return object
        return self
    end

    -- // Updates the booth
    function GoalTracker.UpdateBooth(self)
        -- // Vars
        local Text = self.GoalFormat:format(self.Progress, self.Goal)

        -- // Set
        BoothManager.EditText(nil, Text)
    end

    -- // Start the listener
    function GoalTracker.StartListener(self)
        -- // Disable current connection, if there is one
        if (self.Listener) then
            self.Listener:Disconnect()
        end

        -- //
        self.Listener = Signals:Connect("Purchase", function(Tipper, Amount)
            -- // Make sure the amount matches
            if not (Amount == self.GoalId) then
                return
            end

            -- // Add
            self.Progress = self.Progress + self.GoalId

            -- // Update
            self:UpdateBooth()

            -- // Save
            self:Save()
        end)
    end

    -- // Load default
    function GoalTracker.LoadDefaults(self, Data)
        -- // Loop through default data
        for i, v in pairs(self.DefaultData) do
            -- // Vars
            local Value = v

            -- // Check if data has it
            if (Data[i] ~= nil) then
                Value = Data[i]
            end

            -- // Set
            self[i] = Value
        end
    end

    -- // Load from a file
    function GoalTracker.LoadFromFile(self, GoalId)
        -- // Make sure the file exists
        local Directory = self.StoreDirectory .. "/" .. GoalId .. ".json"
        assert(isfile(Directory), "file does not exist")

        -- // Load it
        local Contents = readfile(Directory)
        Contents = HttpService:JSONDecode(Contents)

        -- // Load
        self:LoadDefaults(Contents)
    end

    -- // To JSON
    function GoalTracker.ToJSON(self)
        -- // Vars
        local Data = {}

        -- // Grab
        for i, v in pairs(self.DefaultData) do
            Data[i] = self[i]
        end

        -- // Return as json
        return HttpService:JSONEncode(Data), Data
    end

    -- // Save
    function GoalTracker.Save(self)
        -- // Make sure the directory exists
        if (not isfolder(self.StoreDirectory)) then
            makefolder(self.StoreDirectory)
        end

        -- // Convert contents
        local Contents = self:ToJSON()

        -- // Save
        local Directory = self.StoreDirectory .. "/" .. self.GoalId .. ".json"
        writefile(Directory, Contents)
    end
end