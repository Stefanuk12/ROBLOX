-- // Services
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")

-- // Vars
local Binds = {}

-- //
local Module = {
    TestMode = false
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
    local ValidInputItems = {"KeyCode", "UserInputType"}
    function Module.CreateBind(Data)
        -- // Make sure we gave a keybind
        local Keybind = typeof(Data.Keybind) == "function" and Data.Keybind() or Data.Keybind
        assert(typeof(Keybind) == "EnumItem" and table.find(ValidInputItems, tostring(Keybind.EnumType)), "Invalid keybind")

        -- // Add to binds
        local Id = HttpService:GenerateGUID()
        table.insert(Binds, {
            Id = Id,
            Keybind = Data.Keybind,
            Callback = Data.Callback or function(State, Bind) end,
            ProcessedCheck = Data.ProcessedCheck or false,
            Hold = Data.Hold or false,
            State = Data.State or false
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
            -- // Loop through all binds
            for _, Bind in ipairs(Binds) do
                -- // Check
                local Keybind = Bind.Keybind
                Keybind = typeof(Keybind) == "function" and Keybind() or Keybind
                local Property = tostring(Keybind.EnumType)
                if (Input[Property] ~= Keybind) or (Bind.ProcessedCheck and gameProcessedEvent) then
                    continue
                end

                -- // Fire
                if (Bind.Hold) then
                    Bind.State = true
                else
                    Bind.State = not Bind.State
                end

                Bind.Callback(Bind.State, Bind)
            end
        end)

        -- // See whenever we lift up
        Module.InputEndedConnection = UserInputService.InputEnded:Connect(function(Input, gameProcessedEvent)
            -- // Loop through all binds
            for _, Bind in ipairs(Binds) do
                -- // Make sure is a hold
                if (not Bind.Hold) then
                    continue
                end

                -- // Check
                local Keybind = Bind.Keybind
                Keybind = typeof(Keybind) == "function" and Keybind() or Keybind
                local Property = tostring(Keybind.EnumType)
                if (Input[Property] ~= Keybind) or (Bind.ProcessedCheck and gameProcessedEvent) then
                    continue
                end

                -- // Fire
                Bind.State = false
                Bind.Callback(Bind.State, Bind)
            end
        end)
    end

    -- // Completely destroys everything
    function Module.Destroy(KeepConnection)
        -- // Destroy connection
        if (not KeepConnection) then
            if (Module.InputBeganConnection) then
                Module.InputBeganConnection:Disconnect()
                Module.InputBeganConnection = nil
            end

            if (Module.InputEndedConnection) then
                Module.InputEndedConnection:Disconnect()
                Module.InputEndedConnection = nil
            end
        end

        -- // Empty binds
        Binds = {}
    end
end

-- // Start
Module.CreateConnection()

-- // Test + Example usage
if (Module.TestMode) then
    Module.CreateBind({
        Keybind = Enum.KeyCode.X,
        ProcessedCheck = true,
        Callback = function(State, Bind)
            print(Bind.Keybind.Name .. " was pressed with state " .. tostring(State))
        end
    })
    Module.CreateBind({
        Keybind = Enum.UserInputType.MouseButton2,
        ProcessedCheck = true,
        Callback = function(State, Bind)
            print(Bind.Keybind.Name .. " was pressed with state " .. tostring(State))
        end
    })


    Module.CreateBind({
        Keybind = Enum.UserInputType.MouseButton2,
        ProcessedCheck = true,
        Callback = function(State, Bind)
            local Action = State and "pressed" or "released"
            print(Bind.Keybind.Name .. " was " .. Action)
        end,
        Hold = true
    })
end

-- // Return
return Module