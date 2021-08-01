-- // Hooking __newindex
local __newindex
__newindex = hookmetamethod(game, "__newindex", function(t, k, v)
    -- // See if the game is trying to make it so we cannot jump :(
    if (t.Name == "Humanoid" and k == "Jump" and v == false) then
        -- // bad game
        return
    end

    -- // So we do not mess with anything else
    return __newindex(t, k, v)
end)