-- // Vars
local ModelInstances;
local CLIPlayerNames;
local CLITeams;

local Teams = {}

-- // Grab data from GC.
for i,v in next, getgc(true) do 
    if typeof(v) == "table" and rawget(v,"cli_names") then 
        CLIPlayerNames = v.cli_names;
        CLITeams = v.cli_teams;
        ModelInstances = v.gbl_sol_state.r15_models;
    end
end

-- //
local function GrabPlayerId(Player)
   -- // Loop through all the players
    for i, v in pairs(CLIPlayerNames) do
        -- // See if the players match
        if (v == Player.Name) then
            -- // Return their player id
            return i
        end
    end
end

-- //
local function CreateTeams()
   -- // There are always 3 (0 = Lobby, 1 = Blue, 2 = Red)

   -- // Lobby
   local Team0 = Instance.new("Team")
   Team0.TeamColor = BrickColor.Gray()
   Team0.Name = "0"
   Teams["0"] = Team0

   -- // Blue
   local Team1 = Instance.new("Team")
   Team1.TeamColor = BrickColor.Blue()
   Team1.Name = "1"
   Teams["1"] = Team1

   -- // Red
   local Team2 = Instance.new("Team")
   Team2.TeamColor = BrickColor.Red()
   Team2.Name = "2"
   Teams["2"] = Team2
end

-- // Lets go ahead and make those.
CreateTeams();

-- //
local __index
__index = hookmetamethod(game, "__index", function(t, k)
    -- // Make sure the game cannot access this
    if (checkcaller()) then
        -- // Check if we are trying to get a player's character, team, or teamcolor
        if (t:IsA("Player") and (k == "Character" or k == "Team" or k == "TeamColor")) then
            -- // Vars
            local PlayerId = GrabPlayerId(t)

            -- // Make sure we got the id
            if (not PlayerId) then
                return nil
            end

            -- // Return their character
            if (k == "Character") then
                return ModelInstances[PlayerId]
            end

            -- // Return their team
            if (k == "Team" or k == "TeamColor") then
                -- // Vars
                local PlayerTeam = CLITeams[PlayerId]

                -- // Return team
                local ResolvedTeam = Teams[tostring(PlayerTeam)]
                if (k == "Team") then
                    return ResolvedTeam
                else
                    return ResolvedTeam.TeamColor
                end
            end
        end
    end

    -- //
    return __index(t, k)
end)
