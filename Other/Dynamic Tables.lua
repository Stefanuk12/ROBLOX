
-- // Executed when table index is added/updated
function onUA(tbl)
    local before = tbl[1]
    local after = tbl[2]
    print(before, after)
end

-- // Executed when table index is removed
function onR(tbl)
    local modifiedtbl = tbl[1]
    local modifiedindex = tbl[2]
    local modifiedvalue = tbl[3]
    print(modifiedtbl, modifiedindex, modifiedvalue)
end

-- // Handles the part when a table index is added/updated
local function tableHandler(targetTable, onUA)
    local onUA = onUA or function() end
	return setmetatable({}, {
		__mode = "s"
	})
end

-- // Handles the part where a table index is removed
setreadonly(table, false)
local savedtblremove = table.remove 
table.remove = function(table, index, result)
    local result = result or function() end
    result({table, index, table[index]})
    savedtblremove(table, index)
end
setreadonly(table, true)

-- // Simple testing script
local tbl = tableHandler({}, onUA)
tbl["a"] = 1
table.remove(tbl, 1, onR)
