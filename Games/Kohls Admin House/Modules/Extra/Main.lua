-- // Initialisation
getgenv().KAHHax["Extra"] = {}
getgenv().KAHHax["Extra"]["Functions"] = {}
getgenv().KAHHax["Extra"]["Toggles"] = {}
getgenv().KAHHax["Extra"]["Coroutines"] = {}

getgenv().KAHHax["Extra"]["Music Commands"] = {}
getgenv().KAHHax["Extra"]["Music Commands"]["Functions"] = {}
getgenv().KAHHax["Extra"]["Music Commands"]["Toggles"] = {}
getgenv().KAHHax["Extra"]["Music Commands"]["Coroutines"] = {}

loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Kohls%20Admin%20House/Modules/Extra/Music%20Commands/Main.lua"))() -- // Music Commands

getgenv().KAHHax["Extra"]["Functions"].intGearGiver = function()
    loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Kohls%20Admin%20House/Modules/Extra/Gear%20Giver/Main.lua"))()
end

getgenv().KAHHax["Extra"]["Functions"].newSilentCommands = function()
    loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Kohls%20Admin%20House/Modules/Extra/Silent%20Commands/Main.lua"))()
end