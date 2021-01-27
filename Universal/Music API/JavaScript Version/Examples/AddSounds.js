// Dependencies
const MusicAPI = require("../MusicAPI.js");
const fs = require("fs");
const config = require("../config.json");

// Vars
const soundsToAdd = [
    {Name: "[imadethis] Kalan FrFr - Right Wit It", SoundId: "6301501695"}
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