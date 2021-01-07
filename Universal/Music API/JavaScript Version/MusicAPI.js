// Requirements
const got = require('got');

// Filter to check if sound got deleted
soundCheckFilter = function(webSource){
    // Assets that indicate a sound got deleted
    const removedAssets = [
        "https://images.rbxcdn.com/9281912c23312bc0d08ab750afa588cc.png",
        "https://t6.rbxcdn.com/70608418c648be7ac4e323e3294bb059",
        "https://t5.rbxcdn.com/d28c1b5eed271a7aa76f16689e74ca04"
    ];

    // Loop
    var returnValue = false;
    removedAssets.forEach(asset => {
        if (webSource.body.includes(asset)){
            // Return
            returnValue = true;
        };
    });

    // Return
    return returnValue;
};

// Check if a certain sound got deleted
module.exports.isSoundDeleted = async function(SoundId, Verbose = false, filter = soundCheckFilter){
    try {
        // Get webpage source
        const webSource = await got.get(`https://roblox.com/library/${SoundId}`);

        // Filter it to see if it is a deleted sound
        const result = filter(webSource);

        // Verbose print
        if (result && Verbose){
            console.log(`${SoundId} deleted.`)
        };

        // Return if it is a deleted sounds
        return result;
    } catch(error) {
        // Return
        return true;
    };
};

// Fix UUIDs
module.exports.fixMusicTableUUIDs = async function(Table){
    // Vars
    var uuidCount = 1;

    // Loop
    for (let i = 0; i <= Table.length; i++){
        if (Table[i] !== undefined){
            Table[i].UUID = uuidCount;
            uuidCount++;
        }; 
    };

    // Return
    return Table;
};

// Alphabetical Sort
module.exports.alphabeticalSort = async function(Table){
    return Table.sort((a, b) => {
        if (a.Name < b.Name) return -1;
        if (a.Name > b.Name) return 1;

        return 0;
    });
};

// Check if a sound is in a table
module.exports.isSoundInTable = async function(SoundId, Table){
    var returnVal = false;

    // Loop
    Table.forEach(item => {
        if (item.SoundId == SoundId){
            // Return
            returnVal = true;
        };
    });

    // Return
    return returnVal;
};

// Remove any duplicate sounds
module.exports.removeDuplicateSounds = async function(Table){
    // Vars
    var checkTable = [];

    // Loop
    for await (var item of Table){
        if (!await module.exports.isSoundInTable(item.SoundId, checkTable)){
            checkTable.push(item);
        };
    };

    // Return
    return checkTable;
};

// Removes removed sounds from Music Table
module.exports.updateMusicTable = async function(MusicTable, Verbose = false){
    // Vars
    updatedMusicTable = [];

    // Remove any duplicates
    MusicTable = await module.exports.removeDuplicateSounds(MusicTable);

    // Remove Deleted sounds
    for await (var item of MusicTable){
        const result = await module.exports.isSoundDeleted(item.SoundId, Verbose);
        if (!result){
            updatedMusicTable.push(item);
        };
    };

    // Return updated
    return await module.exports.fixMusicTableUUIDs(updatedMusicTable);
};

// Add sounds to table
module.exports.addSoundsToMusicTable = async function(Sounds, MusicTable){
    for await (var item of Sounds){
        const result = await module.exports.isSoundDeleted(item.SoundId);
        if (!result){
            item["UUID"] = MusicTable.length + 1;
            MusicTable.push(item);
        };
    };

    MusicTable = await module.exports.removeDuplicateSounds(MusicTable);

    return await module.exports.fixMusicTableUUIDs(MusicTable);
};
