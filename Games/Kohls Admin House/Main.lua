--[[
    Mockup KAHHax Table Layout:

    KAHHax = {
        Admin = {
            Coroutines = {COROUTINES},
            Functions = {FUNCTIONS},
            Toggles = {TOGGLES},
        },
        Server OOF = {
            Coroutines = {COROUTINES},
            Functions = {FUNCTIONS},
            Toggles = {TOGGLES},
        },
        Sound Abuse = {
            Coroutines = {COROUTINES},
            Functions = {FUNCTIONS},
            Toggles = {TOGGLES},
        },
        -- there is no "extra" due to it being a bit complex and stufyudsgfuyds
    }
]]

-- // Initialisation
getgenv().KAHHax = {}
loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Kohls%20Admin%20House/Modules/Admin/Main.lua"))() -- // Admin Section
loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Kohls%20Admin%20House/Modules/Server%20OOF/Main.lua"))() -- // Server OOF Section
loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Kohls%20Admin%20House/Modules/Sound%20Abuse/Main.lua"))() -- // Sound Abuse Section