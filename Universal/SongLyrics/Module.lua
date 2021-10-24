-- // Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- // Vars
local SayMessageRequest = ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest
local Module = {}

-- //
local URLMatch = "https://www.azlyrics.com/lyrics/%s/%s.html"
function Module.GetSongLyrics(Artist, Title)
    -- // Lower Artist and Title, and remove any non-alphanumeric characters
    Artist = Artist:lower():gsub("[^%w]+", "")
    Title = Title:lower():gsub("[^%w]+", "")

    -- // Vars
    local URL = URLMatch:format(Artist, Title)
    local Body = game:HttpGet(URL)

    -- // Parse the song
    local Data = Body:split("<!-- Usage of azlyrics.com content by any third-party lyrics provider is prohibited by our licensing agreement. Sorry about that. -->")[2]
    local End = Data:find("</div>")
    local Song = Data:sub(0, End - 1)

    -- // Remove any odd whitespace
    Song = Song:gsub("[\n\t]+", "")

    -- // Split line by line
    Song = Song:split("<br>")

    -- // Remove any empty lyrics
    for i, Lyric in ipairs(Song) do
        -- // See if empty
        if (Lyric == "") then
            -- // Remove
            table.remove(Song, i)
        end
    end

    -- // Remove first character from first lyric
    Song[1] = Song[1]:sub(2)

    -- // Return
    return Song
end

-- // Chats the message
function Module.Chat(Message)
    -- // Chat the message
    SayMessageRequest:FireServer(Message, "All")
end

-- // Chats each lyric of a song
function Module.ChatLyrics(Artist, Title, Delay)
    -- // Get the song's lyrics
    local Song = Module.GetSongLyrics(Artist, Title)

    -- // Loop through each lyric
    for _, Lyric in ipairs(Song) do
        -- // Chat the lyric
        Module.Chat(Lyric)

        -- // Delay
        wait(Delay)
    end
end

-- //
return Module