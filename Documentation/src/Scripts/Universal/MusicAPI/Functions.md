# Functions

#### ValiantMusicAPI.checkBadSound
This checks if a SoundId is removed or not.

```markdown
<bool> ValiantMusicAPI.checkBadSound(<string> SoundId, <string> SoundName, <bool> UseMarketplace, <bool> Verbose)
```

#### ValiantMusicAPI.removeDuplicates
Removes any duplicate Sound Ids.

```markdown
<table> ValiantMusicAPI.removeDuplicates(<table> targetTable)
```

#### ValiantMusicAPI.testAllSounds
Tests all of the sounds in the GitHub Table and then updates the music table.

```markdown
<table> ValiantMusicAPI.testAllSounds(<bool> Verbose, <number> waitTime, <bool> UseMarketplace)
```

#### ValiantMusicAPI.printMusic
Prints all of the music table in a formatted way.

```markdown
<void> ValiantMusicAPI.printMusic(<void>)
```

#### ValiantMusicAPI.getSound
Returns the Sound Id at the Index of the music table.

```markdown
<string> ValiantMusicAPI.getSound(<number> Index)
```

#### ValiantMusicAPI.getSoundName
Returns the Sound Name at the Index of the music table.

```markdown
<string> ValiantMusicAPI.getSoundName(<number> Index)
```

#### ValiantMusicAPI.saveMusicTableJSON
Saves the Music Table as a json file to your workspace.

```markdown
<void> ValiantMusicAPI.saveMusicTableJSON(<bool> Verbose)
```

#### ValiantMusicAPI.exportMusicToClipboard
Copies the Music Table to your Clipboard in a formatted way.

```markdown
ValiantMusicAPI.exportMusicToClipboard(<bool> Verbose)
```