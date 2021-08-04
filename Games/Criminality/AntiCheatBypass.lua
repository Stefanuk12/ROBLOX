-- // not fully done. this just covers the client-sided part. I recommend to reset character after execution if you have already spawned in

-- // Check if a table contains indexes
local function checkTable(tbl, ...)
    -- // Vars
    local Indexes = {...}

    -- // Loop through Indexes
    for _, v in ipairs(Indexes) do
        -- // See if it has all the indexes
        if not (rawget(tbl, v)) then
            -- // If not, return false
            return false
        end
    end

    -- //
    return true
end

-- // Find u21 - includes all the anti cheat thing that sends it to the server
local u21
for _,v in ipairs(getgc(true)) do
    if (typeof(v) == "table" and checkTable(v, "A", "B", "GP", "EN")) then
        u21 = v
        break
    end
end

-- // Hook
hookfunction(u21.A, function()

end)
hookfunction(u21.B, function()

end)