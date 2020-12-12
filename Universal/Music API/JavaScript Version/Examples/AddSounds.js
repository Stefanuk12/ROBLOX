// Dependencies
const MusicAPI = require("../MusicAPI.js");
const fs = require("fs");
const config = require("../config.json");

// Vars
const soundsToAdd = [
    {Name: "24kGoldn - Coco", SoundId: "6070511325"},
    {Name: "Mariah Carey - All I Want For Christmas Is You", SoundId: "6066714802"},
    {Name: "Dapz - Mama", SoundId: "6070410633"},
    {Name: "JAY1 - Your Mrs", SoundId: "6070451257"},
    {Name: "JAY1 - GWOP", SoundId: "6070455638"},
    {Name: "JAY1 - Good Vibes ", SoundId: "6066403641"},
    {Name: "JAY1 - Sweet One", SoundId: "6066599352"},
    {Name: "Dapz - Take You Away", SoundId: "6066639778"},
    {Name: "The Pogues - Fairytale Of New York", SoundId: "6066748416"}
];

// 
fs.readFile(`${config.MusicTableLocation}/${config.MusicTableName}`, "utf8", async function(err, data){
    if (err){
        throw(err);
    };

    var MusicTable = JSON.parse(data);
    var newMusicTable = await MusicAPI.addSoundsToMusicTable(soundsToAdd, MusicTable);

    fs.writeFile(`${config.MusicTableLocation}/${config.MusicTableName}`, JSON.stringify(newMusicTable), "utf8", function(err, data){
        if (err){
            throw(err);
        };

        console.log('Done!');
    });
});