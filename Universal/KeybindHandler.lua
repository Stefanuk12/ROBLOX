-- // Services
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")

-- // Vars
local Binds = {}

-- // Deep copying
local function DeepCopy(Original)
    -- // Assert
    assert(typeof(Original) == "table", "invalid type for Original (expected table)")

    -- // Vars
    local Copy = {}

    -- // Loop through original
    for i, v in pairs(Original) do
        -- // Recursion if table
        if (typeof(v) == "table") then
            v = DeepCopy(v)
        end

        -- // Set
        Copy[i] = v
    end

    -- // Return the copy
    return Copy
end

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

    -- // Convert a character to KeyCode
    function Module.CharacterToKeyCode(Character, ErrorInvalid)
        -- // Check if function
        local CharacterType = typeof(Character)
        if (CharacterType == "function") then
            return Module.CharacterToKeyCode(Character(), ErrorInvalid)
        end

        -- // Make sure is string
        if (typeof(Character) ~= "string") then
            return Character
        end

        -- // Converting mb1, mb2, mb3
        Character = Character:lower()
        if (Character:match("mb%d")) then
            return Enum.UserInputType["MouseButton" .. Character:gsub("mb", "")]
        end

        -- // Check length
        if (ErrorInvalid and #Character ~= 1) then
            error("invalid character")
        end

        -- // Loop through all keycodes
        for _, Keycode in pairs(Enum.KeyCode:GetEnumItems()) do
            -- // Return if matches
            if Keycode.Value == Character:byte() then
                return Keycode
            end
        end

        -- // uh oh
        if (ErrorInvalid) then
            error("cannot find character")
        end
    end

    -- // Creates a bind
    local ValidInputItems = {"KeyCode", "UserInputType"}
    function Module.CreateBind(Data)
        -- // Change bind if not function
        local TypeBind = typeof(Data.Keybind)
        local TestBind = Module.CharacterToKeyCode(Data.Keybind, true)
        if (TypeBind == "string") then
            Data.Keybind = TestBind
        end

        -- // Make sure we gave a keybind
        assert(typeof(TestBind) == "EnumItem" and table.find(ValidInputItems, tostring(TestBind.EnumType)), "Invalid keybind")

        -- // Add to binds
        local Id = HttpService:GenerateGUID()
        table.insert(Binds, {
            Id = Id,
            Keybind = Data.Keybind,
            Callback = Data.Callback or function(State, Bind) end,
            ProcessedCheck = Data.ProcessedCheck or false,
            Hold = Data.Hold or false,
            State = Data.State or false,

            InternalKeybind = nil,
            InternalHold = nil
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
                -- // Setting internal stuff
                local Keybind = Module.CharacterToKeyCode(Bind.Keybind, true)
                Bind.InternalKeybind = Keybind
                local BindHold = Bind.Hold
                if (typeof(BindHold) == "function") then
                    BindHold = BindHold()
                end
                Bind.InternalHold = BindHold

                -- // Check
                local Property = tostring(Keybind.EnumType)
                if (Input[Property] ~= Keybind) or (Bind.ProcessedCheck and gameProcessedEvent) then
                    continue
                end

                -- // Set
                if (BindHold) then
                    Bind.State = true
                else
                    Bind.State = not Bind.State
                end

                -- // Check if was a function
                Bind = DeepCopy(Bind)
                if (typeof(Bind.Keybind) == "function") then
                    Bind.Keybind = Keybind
                end
                if (typeof(Bind.Hold) == "function") then
                    Bind.Hold = BindHold
                end

                -- // Call
                Bind.Callback(Bind.State, Bind)
            end
        end)

        -- // See whenever we lift up
        Module.InputEndedConnection = UserInputService.InputEnded:Connect(function(Input, gameProcessedEvent)
            -- // Loop through all binds
            for _, Bind in ipairs(Binds) do
                local BindHold = Bind.InternalHold

                -- // Make sure is a hold
                if (not BindHold) then
                    continue
                end

                -- // Check
                local Keybind = Bind.InternalKeybind
                local Property = tostring(Keybind.EnumType)
                if (Input[Property] ~= Keybind) or (Bind.ProcessedCheck and gameProcessedEvent) then
                    continue
                end

                -- // Set
                Bind.State = false

                -- // Check if was a function
                Bind = DeepCopy(Bind)
                if (typeof(Bind.Keybind) == "function") then
                    Bind.Keybind = Keybind
                end
                if (typeof(Bind.Hold) == "function") then
                    Bind.Hold = BindHold
                end

                -- // Fire
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
        Keybind = "y",
        ProcessedCheck = true,
        Callback = function(State, Bind)
            print(Bind.Keybind.Name .. " was pressed with state " .. tostring(State))
        end
    })
    Module.CreateBind({
        Keybind = function() return math.random() < 0.5 and "Z" or "J" end,
        ProcessedCheck = true,
        Callback = function(State, Bind)
            print(Bind.Keybind.Name .. " was pressed with state " .. tostring(State))
        end
    })
    Module.CreateBind({
        Keybind = "MB1",
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
    Module.CreateBind({
        Keybind = "l",
        ProcessedCheck = true,
        Callback = function(State, Bind)
            print(Bind.Keybind.Name .. " has state " .. tostring(State) .. ". Hold = " .. tostring(Bind.Hold))
        end,
        Hold = function() return math.random() < 0.5 end
    })
    Module.CreateBind({
        Keybind = function() return math.random() < 0.5 and "r" or "t" end,
        ProcessedCheck = true,
        Callback = function(State, Bind)
            print(Bind.Keybind.Name .. " has state " .. tostring(State) .. ". Hold = " .. tostring(Bind.Hold))
        end,
        Hold = function() return math.random() < 0.5 end
    })
end

-- // Return
return Module