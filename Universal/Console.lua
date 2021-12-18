-- // Dependencies
local Chalk = loadstring(game:HttpGet("https://raw.githubusercontent.com/Belkworks/chalk/master/init.lua"))()

-- // Vars
local Types = {
    print = "white",
    warn = "yellow",
    error = "red"
}

-- //
local function OutputManager(Type, ...)
    -- // Vars
    local Colour = Chalk[Types[Type]]
    local Time = os.date("%H:%M:%S")

    -- //
    local TimePrefix = Time .. " --"
    local ToPrint = Colour(TimePrefix, ...)

    -- //
    Chalk.print(ToPrint)
end

-- // Loop through each type
for Type, _ in pairs(Types) do
    -- // Hook the type
    local old
    old = hookfunction(getgenv()[Type], function(...)
        -- // See if we called
        if (checkcaller()) then
            -- //
            OutputManager(Type, ...)
            return
        end

        -- //
        old(...)
        return
    end)
end