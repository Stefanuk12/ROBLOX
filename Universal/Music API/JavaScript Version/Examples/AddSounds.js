// Dependencies
const MusicAPI = require("../MusicAPI.js");
const fs = require("fs");
const config = require("../config.json");

// Vars
const soundsToAdd = [
    {Name: "LIL DARKIE - HOLOCAUST", SoundId: "6044540546"},
    {Name: "Pop Smoke - Aim For The Moon", SoundId: "6063441962"},
    {Name: "Tay K - The Race", SoundId: "5935675625"},
    {Name: "XXXTENTACION - YuNg BrAtZ", SoundId: "6049966361"},
    {Name: "Pop Smoke - Hello", SoundId: "6049906434"},
    {Name: "Tay K - Lemonade", SoundId: "6016170369"},
    {Name: "Juice WRLD - Bandit", SoundId: "6015970190"},
    {Name: "PnB Rock - Middle Child", SoundId: "6062471305"},
    {Name: "#A92 Dbo x KSav x BT x Nikz x Kebz - A9 Freestyle", SoundId: "6098149765"},
    {Name: "#OFB DZ x YF - Back 2 Back", SoundId: "6098271089"},
    {Name: "Octavian & Skepta - Papi Chulo", SoundId: "6094292718"},
    {Name: "Mastermind x #OFB Bandokay - War", SoundId: "6094342574"},
    {Name: "Abra Cadabra x Sneakbo x M.O. - Pon Me", SoundId: "6094360121"},
    {Name: "Baby Mane - 2Twenty", SoundId: "6094375690"},
    {Name: "Loski - Basil Brush ft. OFB, Bandokay, Double Lz", SoundId: "6094392782"},
    {Name: "Loski - 2AM", SoundId: "6094424341"},
    {Name: "Loski - Daily Duppy", SoundId: "6094636377"},
    {Name: "Gully - Wave", SoundId: "6094656975 "},
    {Name: "XXXTENTACION - going down!", SoundId: "6031259337"},
    {Name: "XXXTENTACION - Gospel", SoundId: "6031255117"},
    {Name: "100 gecs - money machine [n word]", SoundId: "5485540533"},
    {Name: "$uicideboy$ - I Miss My Dead Friends", SoundId: "5796096874"},
    {Name: "Ambjaay - Uno", SoundId: "5598437718"},
    {Name: "lil peep - white tee", SoundId: "6048966075"},
    {Name: "XXXTENTACION - Hope", SoundId: "6049046006"},
    {Name: "$uicideboy$ - Dead Batteries", SoundId: "5578897134"},
    {Name: "Lil Tecca - 4. AM", SoundId: "5957846998"},
    {Name: "Lil Uzi Vert - Myron", SoundId: "6066644399"},
    {Name: "Lil Tecca - Love No Thot", SoundId: "6071412295"}
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