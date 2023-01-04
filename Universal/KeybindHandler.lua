-- // Services
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")

-- // Vars
local Binds = {}

-- //
local Module = {
    TestMode = true
}
do
    -- // Returns all or one of the binds
    function Module.Get(Id)
        -- // Return all
        if (not Id) then
            return Binds
        end

        -- // Loop through each bind
        local FoundI = -1
        for i, Bind in ipairs(Binds) do
            -- // Check if id matches
            if (Bind.Id == Id) then
                -- // Set
                FoundI = i
                break
            end
        end

        -- // Make sure we got something
        if (FoundI == -1) then
            return false
        end

        -- // Return
        return Binds[FoundI], FoundI
    end

    -- // Creates a bind
    function Module.CreateBind(Keybind, Callback, ProcessedCheck, State)
        -- // Add to binds
        local Id = HttpService:GenerateGUID()
        table.insert(Binds, {
            Id = Id,
            Keybind = Keybind,
            Callback = Callback,
            ProcessedCheck = ProcessedCheck,
            State = false
        })

        -- // Return the Id
        return Id
    end

    -- // Updates a bind's property
    function Module.Update(Id, Property, NewValue)
        -- // Get the bind
        local Bind = Module.Get(Id)
        if (not Bind) then
            return false
        end

        -- // Set
        Bind[Property] = NewValue
        return true
    end

    -- // Updates a bind's keybind
    function Module.UpdateKeybind(Id, NewKeybind)
        return Module.Update(Id, "Keybind", NewKeybind)
    end

    -- // Updates a bind's callback
    function Module.UpdateCallback(Id, NewCallback)
        return Module.Update(Id, "Callback", NewCallback)
    end


    -- // Removes a bind
    function Module.RemoveBind(Id)
        -- // Get the bind
        local _, FoundI = Module.Get(Id)
        if (not FoundI) then
            return false
        end

        -- // Remove
        table.remove(Binds, FoundI)
        return true
    end

    -- // Creates the connection
    function Module.CreateConnection()
        -- // Connects to whenever we make an input
        Module.InputBeganConnection = UserInputService.InputBegan:Connect(function(Input, gameProcessedEvent)
            print(gameProcessedEvent)
            -- // Loop through all binds
            for _, Bind in ipairs(Binds) do
                -- // Check
                local Keybind = Bind.Keybind
                local Property = tostring(Keybind.EnumType)
                if (Input[Property] ~= Keybind) or (Bind.ProcessedCheck and gameProcessedEvent) then
                    continue
                end

                -- // Fire
                Bind.State = not Bind.State
                Bind.Callback(Bind.State, Bind)
            end
        end)
    end

    -- // Completely destroys everything
    function Module.Destroy(KeepConnection)
        -- // Destroy connection
        if (not KeepConnection and Module.InputBeganConnection) then
            Module.InputBeganConnection:Disconnect()
        end

        -- // Empty binds
        Binds = {}
    end
end

-- // Start
Module.CreateConnection()

-- // Test + Example usage
if (Module.TestMode) then
    Module.CreateBind(Enum.KeyCode.X, function(State, Bind)
        print(Bind.Keybind.Name, "was pressed with state", State)
    end, true)

    Module.CreateBind(Enum.UserInputType.MouseButton1, function(State, Bind)
        print(Bind.Keybind.Name, "was pressed with state", State)
    end, true)
end

-- // Return
return Module