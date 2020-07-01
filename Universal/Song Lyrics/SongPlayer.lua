local LyricModule = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Universal/Song%20Lyrics/SongLyricsModule.lua"))()
local SelectedSong = "Juice WRLD - Lucid Dreams"
local GlobalAbort = false
local DoingLyrics = false
function doLyrics()
    if not GlobalAbort and not DoingLyrics and LyricModule[SelectedSong] then
        for _,song in pairs(LyricModule[SelectedSong].Lyrics) do
            game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(song.Lyric, "All")
            wait(song.Time)
        end
    end
end