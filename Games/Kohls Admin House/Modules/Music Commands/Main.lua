local musicTable = game:GetService('HttpService'):JSONDecode(game:HttpGetAsync('https://github.com/Stefanuk12/ROBLOX/blob/master/Games/Kohls%20Admin%20House/Modules/Music%20Commands/MusicTable.js'))

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
		if testContentDeleted(musicTable[i].SoundId) == false then
			musicTable[i] = nil
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

function getMusic()
    updateMusicTable()

	for i=1, #musicTable do
		local namex = musicTable[i].Name
        print("You can play", namex, "- Index =", i)
    end
end

print(getMusic())