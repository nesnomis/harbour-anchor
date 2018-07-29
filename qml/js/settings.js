var db = undefined;
function settings_db_open() {
    if (db == undefined)
        db = LocalStorage.openDatabaseSync("harbour-anchor", "1.0", "StorageDatabase", 100000);
    return db;
}
/// GAME SETTINGS
function getValue(setting,def) {
    var db = settings_db_open();
    var res=def;
    try {
       db.transaction(function(tx) {
          var rs = tx.executeSql('SELECT value FROM settings WHERE setting=?;', [setting]);
             if (rs.rows.length > 0) {
                res = rs.rows.item(0).value;
             } else {
                res = def;
             }
       })
    } catch (err) {
        console.log("*** getValue ERROR ")
       res = def
    };
    console.log("*** getValue: "+res+" setting: "+setting)
    return res
}

// insert anchor in db
function setAnchor(name, description, icon, latitude, longitude) {
    var db = settings_db_open();
    var res = "";
    db.transaction(function(tx) {
        tx.executeSql('CREATE TABLE IF NOT EXISTS anchors(name TEXT UNIQUE, description TEXT, icon TEXT, latitude REAL, longitude REAL)');
        var rs = tx.executeSql('INSERT OR REPLACE INTO anchors VALUES (?,?,?,?,?);', [name, description, icon, latitude, longitude]);
             if (rs.rowsAffected > 0) {
                res = "OK";

             } else {
                res = "Error";
             }
       }
    );
    return res;
}

function setValue(setting, value) {
    var db = settings_db_open();
    var res = "";
    db.transaction(function(tx) {
        tx.executeSql('CREATE TABLE IF NOT EXISTS settings(setting TEXT UNIQUE, value TEXT)');
        var rs = tx.executeSql('INSERT OR REPLACE INTO settings VALUES (?,?);', [setting,value]);
             if (rs.rowsAffected > 0) {
                res = "OK";

             } else {
                res = "Error";
             }
       }
    );
    console.log("*** setValue: "+res+" setting: "+setting+" = "+value)
    return res;
}

/// GET ANCHORS
function getAnchors(model) {
    model.clear()
    var db = settings_db_open();
    var res="OK";
    try {
       db.transaction(function(tx) {
          var rs = tx.executeSql('SELECT * FROM anchors;');
            for (var i = 0; i < rs.rows.length; i++)
            {
                model.append({"name" : rs.rows.item(i).name,"description" : rs.rows.item(i).description,"icon" : rs.rows.item(i).icon,"latitude" : rs.rows.item(i).latitude,"longitude" : rs.rows.item(i).longitude})
            }
       })
    } catch (err) {
       res = "ERROR"
    };
    return res
}

function delAnchor(name) {
    var db = settings_db_open();
    var res = "";
    db.transaction(function(tx) {
        //tx.executeSql('CREATE TABLE IF NOT EXISTS settings(savegame TEXT UNIQUE, value TEXT)'); //tx.executeSql('DELETE FROM channels WHERE source=?', [source])
        var rs = tx.executeSql('DELETE FROM anchors where name=?', [name]);
             if (rs.rowsAffected > 0) {
                res = "OK";

             } else {
                res = "Error";
             }
       }
    );
    return res;
}

/// LOAD/SAVE GAME
function getSave(setting,def) {
    var db = settings_db_open();
    var res=def;
    try {
       db.transaction(function(tx) {
          var rs = tx.executeSql('SELECT value FROM savegame WHERE setting=?;', [setting]);
             if (rs.rows.length > 0) {
                res = rs.rows.item(0).value;
             } else {
                res = def;
             }
       })
    } catch (err) {
       res = def
    };
    return res
}

function setSave(setting, value) {
    var db = settings_db_open();
    var res = "";
    db.transaction(function(tx) {
        tx.executeSql('CREATE TABLE IF NOT EXISTS settings(savegame TEXT UNIQUE, value TEXT)');
        var rs = tx.executeSql('INSERT OR REPLACE INTO savegame VALUES (?,?);', [setting,value]);
             if (rs.rowsAffected > 0) {
                res = "OK";

             } else {
                res = "Error";
             }
       }
    );
    return res;
}
