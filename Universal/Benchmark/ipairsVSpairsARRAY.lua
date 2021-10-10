-- // Information
--[[
    they pretty much go hand in hand
]]

-- // Dependencies
local Benchmark = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Benchmark/Module.lua"))()

-- // Vars
local LoopTable = table.create(10000, "sex")
local IterationsA = 10
local IterationsB = 100

-- // ipairs
local function _ipairs()
    for i, item in ipairs(LoopTable) do

    end
end

-- // Numerical
local function _pairs()
    for i, item in pairs(LoopTable) do

    end
end

-- //
local Results = {
    ipairs = Benchmark.ExecuteAverage(IterationsA, IterationsB, _ipairs),
    pairs = Benchmark.ExecuteAverage(IterationsA, IterationsB, _pairs)
}

-- //
local ipairsFaster = Results.ipairs < Results.pairs
local difference = Results.pairs - Results.ipairs
local format = "ipairs is %sfaster by %f seconds"
print(format:format(ipairsFaster and "" or "not ", difference))