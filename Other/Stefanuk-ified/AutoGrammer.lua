-- // Information
--[[
    Original by: eos (https://v3rmillion.net/showthread.php?tid=1156181)
    Edited by: Stefanuk12

    Note: I know that the iterations of Output can be combined but for the sake of seperating stuff out and such, I did it the way I did.
]]

-- // Vars
local CapitaliseI = true
local ReplaceDictionary = {
    ["i"] = "I",
    ["im"] = "I am",
    ["ive"] = "I've",
    ["dont"] = "don't",
    ["doesnt"] = "doesn't",
    ["cant"] = "can't",
    ["youre"] = "you're",
    ["ur"] = "your",
    ["u"] = "you",
    ["its"] = "it's",
    ["oh"] = "oh,",
    ["thnks"] = "thanks",
    ["thx"] = "thanks",
    ["git"] = "get",
    ["gud"] = "good",
    ["gramer"] = "grammar",
    ["grammer"] = "grammar",
    ["anymor"] = "anymore",
}
local QuestionPrompts = {
    "mean",
    "ask",
    "you",
    "care",
    "script",
    "is",
    "what",
    "how"
}
local Punctuation = {
    "!",
    ".",
    "?"
}

-- // Replace words
local function ReplaceWords(Output)
    -- // Loop through output
    for i, Word in ipairs(Output) do
        -- // Vars
        Word = Word:lower()
        local Replace = ReplaceDictionary[Word]

        -- // Make sure exists within our replace dictionary
        if (Replace) then
            -- // Replace the word
            Output[i] = Replace
        end
    end

    -- // Return
    return Output
end

-- // Capitalise
local function Capitalise(Output)
    -- // Make the first letter capital
    local FirstLetter = Output[1]:sub(1, 1)
    Output[1] = FirstLetter:upper() .. Output[1]:sub(2)

    -- // Capitalise all I's
    if (CapitaliseI) then
        -- // Loop through output
        for i, Word in ipairs(Output) do
            -- // Check if single i
            if (Word == "i") then
                -- // Make uppercase
                Output[i] = "I"
            end
        end
    end

    -- // Return
    return Output
end

-- // Add punctuation
local function Punctuate(Output)
    -- // Vars
    local LastWordI = #Output
    local LastWord = Output[LastWordI]

    local LastLetterI = #LastWord
    local LastLetter = LastWord:sub(LastLetterI, LastLetterI)

    -- // Make sure we have not already added punctuation to the last word
    if not (table.find(Punctuation, LastLetter)) then
        -- // Add a question mark or full stop, depending if it starts with a question prompt
        local Punctation = table.find(QuestionPrompts, Output[1]:lower()) and "?" or "."
        Output[LastWordI] = LastWord .. Punctation
    end

    -- // Return
    return Output
end

-- // Improves it all
local function Improve(Input)
    -- // Vars
    local Output = Input:split(" ")

    -- // Do grammer
    Output = ReplaceWords(Output)
    Output = Capitalise(Output)
    Output = Punctuate(Output)

    -- // Return
    return table.concat(Output, " ")
end

-- // This handles the hook process
local function ReplaceHook(Old, ReplaceI, ...)
    -- // Vars
    local args = {...}

    -- // Replace the content of the message
    args[ReplaceI] = Improve(args[ReplaceI])

    -- // Return
    return Old(unpack(args))
end

-- // Initialises this script - this could probably be improved
local function Initialise()
    -- // Loop through GC
    for _, v in ipairs(getgc(true)) do
        -- // Make sure it is the table we are looking for
        if (typeof(v) == "table" and rawget(v, "SendMessage") and rawget(v, "RegisterSayMessageFunction")) then
            -- // Replace the function with our modified version
            local SendMessage = rawget(v, "SendMessage")
            rawset(v, "SendMessage", function(...)
                return ReplaceHook(SendMessage, 2, ...)
            end)
        end
    end
end

-- // End
Initialise()
return Improve