local lyrics = {
    {Lyric = "I still see your shadows on my room.", Time = 5},
    {Lyric = "Can't take back the love I gave you.", Time = 4},
    {Lyric = "It's to the point where I love you and hate you, and I cannot change you, so I must replace you, Oh.", Time = 7}
}
local playLyrics = true
for i,v in pairs(lyrics) do
    if playLyrics then
        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(v.Lyric, "All")
        wait(v.Time)
    end
end