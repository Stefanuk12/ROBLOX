// Dependencies
const MusicAPI = require("../MusicAPI.js");
const fs = require("fs");
const config = require("../config.json");

// Vars
const soundsToAdd = [
    {Name: "XXXTentacion - going down!", SoundId: "6031259337"},
    {Name: "$NOT - Mean", SoundId: "6033522087"},
    {Name: "Lil Tecca - Love No Thot", SoundId: "6034017442"},
    {Name: "Lil Tecca - Amigo", SoundId: "6029385077"},
    {Name: "YNW Melly - Suicidal", SoundId: "6029387414"},
    {Name: "Lil Nas X - HOLIDAY", SoundId: "6029390564"},
    {Name: "XXXTENTACION - King Of The Dead", SoundId: "5285302193"},
    {Name: "POP SMOKE - ELEMENT", SoundId: "6009015262"},
    {Name: "Lil Peep - Paid 2 Party", SoundId: "5957778837"},
    {Name: "XXXTENTACION - ILOVEITWHENTHEYRUN", SoundId: "5142292418"},
    {Name: "Juice WRLD - Tell Me U Luv Me ft. Trippie Redd", SoundId: "5155864261"},
    {Name: "$UICIDEBOY$ - NOW I’M UP TO MY NECK WITH OFFERS", SoundId: "5156522678"},
    {Name: "Lil Tracy x Lil Peep - GODS", SoundId: "5278542681"},
    {Name: "Lil Tecca - Out Of Love", SoundId: "5285672433"},
    {Name: "$uicideboy$ - Kill Yourself Part III", SoundId: "5121386882"},
    {Name: "$UICIDEBOY$ x POUYA - RUNNIN' THRU THE 7TH WITH MY WOADIES", SoundId: "5278241371"},
    {Name: "$UICIDEBOY$ x BLACK SMURF - ...AND SO IT WAS", SoundId: "5125677449"}
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