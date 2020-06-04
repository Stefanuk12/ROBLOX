local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local gearList = {
    PaintBucket = 18474459,
    Hyperlaser = 130113146,
    RainbowCarpet = 225921000,
    Airstrike = 88885539,
    SuperRLauncher = 190094159,
    SSTripmine = 11999247,
    ASSentry = 68603151,
    RPOSword = 159229806,
}
local prefix = ":give "
Player.Chatted:Connect(function(msg)
    local splitmessage = string.split(msg, " ")
    if string.sub(msg, 1) == (prefix.."help") then
        print('Welcome to Gear Giver - for Kohls Admin House. Prefix is :give - You need admin! All of the available gears will be listed below.')
        for i,v in pairs(gearList) do
            local itemName = game:GetService("MarketplaceService"):GetProductInfo(v).Name
            print("> "..itemName.." = "..i)
        end
        print('Example - :give all SSTripmine')
    end
    for i,v in pairs(gearList) do
        if string.match(msg, prefix) and string.match(msg, i) then
            Players:Chat(tostring(":gear", splitmessage[2], v))
        end
    end
end)