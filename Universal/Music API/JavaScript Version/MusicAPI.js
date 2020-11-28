// Requirements
const got = require('got');

// Filter to check if sound got deleted
soundCheckFilter = function(webSource){
    // Assets that indicate a sound got deleted
    const removedAssets = [
        "https://images.rbxcdn.com/9281912c23312bc0d08ab750afa588cc.png",
        "https://t6.rbxcdn.com/70608418c648be7ac4e323e3294bb059"
    ];

    // Loop
    removedAssets.forEach(asset => {
        if (webSource.body.includes(asset)){
            // Return
            return true;
        };
    });

    // Return
    return true;
};

// Check if a certain sound got deleted
module.exports.isSoundDeleted = async function(SoundId, filter = soundCheckFilter){
    try {
        // Get webpage source
        const webSource = await got.get(`https://roblox.com/library/${SoundId}`);
        // Filter it to see if it is a deleted sound
        const result = filter(webSource);
        // Return if it is a deleted sounds
        return !result;
    } catch(error) {
        // Return
        return true;
    };
};

// Check if a sound is in a table
module.exports.isSoundInTable = async function(SoundId, Table){
    // Loop
    Table.forEach(item => {
        if (item.SoundId == SoundId){
            // Return
            return true;
        };
    });

    // Return
    return false;
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
module.exports.updateMusicTable = async function(MusicTable){
    // Vars
    updatedMusicTable = [];

    // Remove any duplicates
    MusicTable = await module.exports.removeDuplicateSounds(MusicTable);

    // Remove Deleted sounds
    for await (var item of MusicTable){
        (async (item) => {
            const result = await module.exports.isSoundDeleted(item.SoundId);
            if (!result){
                updatedMusicTable.push(item);
            };
        })();
    };

    // Return updated
    return updatedMusicTable;
};

// Add sounds to table
module.exports.addSoundsToMusicTable = async function(Sounds, MusicTable){
    for await (var item of Sounds){
        const result = module.exports.isSoundDeleted(item.SoundId);
        if (!result){
            item["UUID"] = MusicTable.length + 1;
            MusicTable.push(item);
        };
    };

    MusicTable = await module.exports.removeDuplicateSounds(MusicTable);

    return MusicTable;
};