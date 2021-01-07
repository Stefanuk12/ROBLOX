// Dependencies
const MusicAPI = require("../MusicAPI.js");
const fs = require("fs");
const config = require("../config.json");

// Vars
const soundsToAdd = [
    {Name: "Juice WRLD – Fall In Love", SoundId: "6094673438"},
    {Name: "XXXTENTACION - Looking for a Star", SoundId: "6067177973"},
    {Name: "RØNIN - ALL GIRLS ARE THE SAME", SoundId: "5947589334"},
    {Name: "Shabazz PBG – Shells", SoundId: "5021706790"},
    {Name: "Shoreline Mafia - Backdoor", SoundId: "6067298303"},
    {Name: "50 Cent - In Da Club", SoundId: "6098146219"},
    {Name: "Juice WRLD - Lucid Dreams", SoundId: "5625287809"},
    {Name: "lil ricefield - TRAPANESE", SoundId: "6079946028"},
    {Name: "Lil Uzi Vert - Bankroll", SoundId: "6045287727"},
    {Name: "NPK - Two Man On A Ped Lyrics", SoundId: "4934129153"},
    {Name: "NPK - Put In A Spliff Lyrics", SoundId: "4961071295"},
    {Name: "LR (Sin Squad) - Opp Block", SoundId: "4814788069"},
    {Name: "Kempachii - Met Her on the Internet", SoundId: "6058627999"}
];

// 
fs.readFile(`${config.MusicTableLocation}/${config.MusicTableName}`, "utf8", async function(err, data){
    if (err){
        throw(err);
    };

    var MusicTable = JSON.parse(data);
    var newMusicTable = await MusicAPI.addSoundsToMusicTable(soundsToAdd, MusicTable);
    newMusicTable = await MusicAPI.removeDuplicateSounds(MusicTable);

    fs.writeFile(`${config.MusicTableLocation}/${config.MusicTableName}`, JSON.stringify(newMusicTable), "utf8", function(err, data){
        if (err){
            throw(err);
        };

        console.log('Done!');
    });
});