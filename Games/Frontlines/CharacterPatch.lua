-- // Vars
local Globals = getrenv()._G.globals
local ModelInstances = Globals.gbl_sol_state.r15_models
local CLIPlayers = Globals.cli_plrs
local CLITeams = Globals.cli_teams

local Teams = {}

-- //
local function GrabPlayerId(Player)
    -- // Loop through all the players
    for i, v in pairs(CLIPlayers) do
        -- // See if the players match
        if (v == Player) then
            -- // Return their player id
            return i
        end
    end
end

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

                -- // Check if the team exists
                if (not Teams[PlayerTeam]) then
                    -- // Create a new team
                    local Team = Instance.new("Team")
                    Team.TeamColor = BrickColor.new(PlayerTeam)
                    Team.Name = PlayerTeam

                    -- // Add it
                    Teams[PlayerTeam] = Team
                end

                -- // Return team
                local ResolvedTeam = Teams[PlayerTeam]
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