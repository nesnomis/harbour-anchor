import QtQuick 2.0
import QtQuick.LocalStorage 2.0
import "../js/settings.js" as Settings

Item {

    function delAnchor(name) {
        Settings.delAnchor(name)
    }

    function getAnchors() {
        Settings.getAnchors(dbAnchors)
    }

    function setAnchor(name, description, icon, latitude, longitude) {
        Settings.setAnchor(name, description, icon, latitude, longitude)
    }

    function setSettings(slati,slongi,icon,name,description) {
        Settings.setValue("anchorLatitude",slati)
        Settings.setValue("anchorLongitude",slongi)
        Settings.setValue("anchorIcon",icon)
        Settings.setValue("anchorName",name)
        Settings.setValue("anchorDescription",description)
    }

    function getQanchor() {
        anchorIcon = Settings.getValue("anchorIcon")
        anchorName = Settings.getValue("anchorName")
        anchorDescription = Settings.getValue("anchorDescription")
        anchorLatitude = Settings.getValue("anchorLatitude")
        anchorLongitude = Settings.getValue("anchorLongitude")
    }

    function getSettings(setting,def) {
        return Settings.getValue(setting,def)

    }
    function setSettingSetting(compass,magnet,radius,numbers) {
   //     Settings.setValue("compassSetting",compass)
   //     Settings.setValue("magnetometerSetting",magnet)
        Settings.setValue("anchorRadius",radius)
        Settings.setValue("numbers",numbers)
    }
}
