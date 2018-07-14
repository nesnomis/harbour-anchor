import QtQuick 2.0
import Sailfish.Silica 1.0
import "pages"
import "components"

ApplicationWindow
{
    property string anchorIcon: settings.getSettings("anchorIcon")
    property string anchorName
    property string anchorDescription
    property real anchorLatitude: settings.getSettings("anchorLatitude",500)
    property real anchorLongitude: settings.getSettings("anchorLongitude",500)
    property int anchorRadius: settings.getSettings("anchorRadius",10)
    property int showCompasNumbers: settings.getSettings("numbers",0)
    property int calibrateDist: 0
    property variant dbModel: dbAnchors
    property int azimuth: aCompass.enabled ? 360 - aCompass.azimuth : 360 - aMagnetometer.azimuth
    property bool inact: false
    property bool keepScreenOn: settings.getSettings("keepScreenOn",1) === 1 && Qt.application.active ? true : false

    ListModel{id: dbAnchors}

    Settings {id: settings}
    Gps {id: aGps}
    Compass {id: aCompass}
    Magnetometer {id: aMagnetometer}
    ScreenBlank {id: screenBlank}

    Component.onCompleted: {
        settings.getAnchors(dbAnchors)
    }

    initialPage: Component { AnchorPage { } }
    cover: Qt.resolvedUrl("cover/CoverPage.qml")
    allowedOrientations: defaultAllowedOrientations
}
