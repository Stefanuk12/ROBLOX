-- // Vars
local Globals = getrenv()._G.globals
local ModelInstances = Globals.gbl_sol_state.r15_models
local CLIPlayers = Globals.cli_plrs
local CLITeams = Globals.cli_teams

-- //
local __index
__index = hookmetamethod(game, "__index", function(t, k)
    -- // Make sure the game cannot access this
    if (checkcaller()) then
        -- // Check if we are trying to get a player's character, team, or teamcolor
        if (t:IsA("Player") and (k == "Character" or k == "Team" or k == "TeamColor")) then
            -- // Vars
            local PlayerId = table.find(CLIPlayers, t)

            -- // Make sure we got the id
            if (not PlayerId) then
                return nil
            end

            -- // Return their character
            if (k == "Character") then
                return ModelInstances[PlayerId]
            end

            -- // Return their team
            if (k == "Team") then
                -- // Create the team
                local PlayerTeam = CLITeams[PlayerId]
                local Team = Instance.new("Team")
                Team.TeamColor = BrickColor.new(PlayerTeam)
                Team.Name = tostring(PlayerTeam)

                -- // Return it
                return Team
            end

            -- // Return their team color
            if (k == "TeamColor") then
                local PlayerTeam = CLITeams[PlayerId]
                return BrickColor.new(PlayerTeam)
            end
        end
    end

    -- //
    return __index(t, k)
end)