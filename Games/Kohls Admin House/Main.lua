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
        Extra = {
            Coroutines = {COROUTINES},
            Functions = {FUNCTIONS},
            Toggles = {TOGGLES},
            Music Commands = {
                Coroutines = {COROUTINES},
                Functions = {FUNCTIONS},
                Toggles = {TOGGLES},
            },
        },
    }
]]

-- // Initialisation
getgenv().KAHHax = {}
loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Kohls%20Admin%20House/Modules/Admin/Main.lua"))() -- // Admin Section
loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Kohls%20Admin%20House/Modules/Server%20OOF/Main.lua"))() -- // Server OOF Section
loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Kohls%20Admin%20House/Modules/Sound%20Abuse/Main.lua"))() -- // Sound Abuse Section
loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Kohls%20Admin%20House/Modules/Extra/Main.lua"))() -- // Extra Section