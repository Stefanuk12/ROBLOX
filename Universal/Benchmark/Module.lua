-- //
local Benchmark = {}

-- //
function Benchmark.ExecuteOnce(Iterations, Function, ...)
    -- // Vars
    local Start = os.clock()

    -- //
    for i = 1, Iterations do
        Function(...)
    end

    -- //
    return os.clock() - Start
end

-- //
function Benchmark.ExecuteAverage(IterationsA, IterationsB, Function, ...)
    -- // Vars
    local Total = 0

    -- //
    for i = 1, IterationsA do
        Total = Total + Benchmark.ExecuteOnce(IterationsB, Function)
    end

    -- //
    return (Total / IterationsA)
end

-- //
return Benchmark