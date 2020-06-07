if not getgenv()["KAHHax"] then getgenv()["KAHHax"] = {} end
if not KAHHax["intGearGiver"] then
    game:GetService("Players").LocalPlayer.Chatted:Connect(function(msg)
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
        local splitmessage = string.split(msg, " ")
        if string.match(msg, prefix.."help") then
            print('Welcome to Gear Giver - for Kohls Admin House. Prefix is :give - You need admin! All of the available gears will be listed below.')
            for i,v in pairs(gearList) do
                local itemName = game:GetService("MarketplaceService"):GetProductInfo(v).Name
                print("> "..itemName.." = "..i)
            end
            print('Example - :give all SSTripmine')
        end
        for i,v in pairs(gearList) do
            if string.match(msg, prefix) and string.match(msg, i) then
                game:GetService("Players"):Chat(":gear "..splitmessage[2].." "..v)
            end
        end
    end)

    KAHHax["intGearGiver"] = true
end