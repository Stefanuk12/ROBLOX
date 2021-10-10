-- // Dependencies
local Benchmark = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Benchmark/Module.lua"))()

-- // Vars
local LoopTable = table.create(9e9, "sex")
local IterationsA = 1000
local IterationsB = 100

-- // ipairs
local function _ipairs()
    for i, item in ipairs(LoopTable) do
        
    end
end

-- // Numerical
local function _Numerical()
    for i = 1, #LoopTable do
        local item = LoopTable[i]
    end
end

-- //
local Results = {
    ipairs = Benchmark.ExecuteAverage(IterationsA, IterationsB, _ipairs),
    numerical = Benchmark.ExecuteAverage(IterationsA, IterationsB, _Numerical)
}

-- //
local ipairsFaster = Results.ipairs > Results.numerical
local difference = Results.ipairs - Results.numerical
local format = "ipairs is %sfaster by %f seconds"
print(format:format(ipairsFaster and "" or "not ", difference))