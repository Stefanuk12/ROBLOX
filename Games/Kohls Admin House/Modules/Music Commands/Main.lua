
local musicTable = game:GetService("HttpService"):JSONDecode(game:HttpGetAsync('https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Kohls%20Admin%20House/Modules/Music%20Commands/MusicTable.json'))
function testContentDeleted(songid)
	local sound = Instance.new("Sound", game:GetService("Lighting"))
	sound.SoundId = "rbxassetid://"..songid
	sound.Volume = 0
	sound:Play()
	wait(0.1)
	if sound.TimeLength < 0.05 then 
		sound:Destroy()		
        return false
	else
		sound:Destroy()		
        return true
	end
end

function updateMusicTable()
	for i,v in pairs(musicTable) do
		if testContentDeleted(v.SoundId) == false then
			v = nil
		end
	end
end

function changeMusicTable(Index, Name, SoundId)
    updateMusicTable()
    if musicTable[Index] then
        if SoundId then
            musicTable[Index].SoundId = SoundId
        end
        if Name then
            musicTable[Index].Name = Name
        end
    end
end

function addMusicTable(Name, SoundId)
    updateMusicTable()
    local Index = #musicTable + 1
    musicTable[Index] = {}
    musicTable[Index].Name = Name
    musicTable[Index].SoundId = SoundId
end

function removeMusicTable(Index)
    updateMusicTable()
    table.remove(musicTable, Index)
end

function playMusic(num)
    updateMusicTable()
    if musicTable[num] then
        game:GetService("Players"):Chat(":music ".. musicTable[num].SoundId)
        print('Now playing:', musicTable[num].Name)
        return musicTable[num].Name
    end
end

function getMusic()
    updateMusicTable()
    for i,v in pairs(musicTable) do
        print(i, "|", v.Name)
    end
end

local prefix = ":"
game:GetService("Players").LocalPlayer.Chatted:Connect(function(msg)
    if string.sub(msg, 1, 6) == (prefix.."play ") then
        if musicTable[tonumber(string.sub(msg, 7))] then
            playMusic(tonumber(string.sub(msg, 7)))
        end
    end
end)

game:GetService("Players").LocalPlayer.Chatted:Connect(function(msg)
    if string.sub(msg, 1) == (prefix.."getmusic") then
        getMusic()
    end
end)

game:GetService("Players").LocalPlayer.Chatted:Connect(function(msg)
    if string.sub(msg, 1) == (prefix.."getmusichelp") then
        print([[*Make sure you have admin*
        
            :getmusic - gets all of the playable music
            :play [number] - plays a certain song from the playable music list
        ]])
    end
end)