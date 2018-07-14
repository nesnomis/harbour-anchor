import QtQuick 2.0
import QtPositioning 5.2
//import QtLocation 5.0

Item {
    property real currentLatitude: 0.0
    property real currentLongitude: 0.0
    property real currentAltitude: 0.0
    property int distance: 0
    property int direction: 0
    property string positionBearing: ""
    property bool active: inact == 0 ? true : false
    property int inact: 2
    property bool enabled: false

    onEnabledChanged: {
        if (!enabled) inact = 2; else waittimer.running = true
    }

    Timer {
        id: waittimer
        running: inact == 0 ? false : true
        repeat: true
        interval: 3000
        onTriggered: {
            inact = inact + 1
        }
    }

    PositionSource {
        id: src
        active: enabled ? true : false

        onPositionChanged: {
            var coord = src.position.coordinate;
            currentLongitude = coord.longitude
            currentLatitude = coord.latitude
            currentAltitude = coord.altitude
            if (anchorLatitude == 500 && anchorLongitude == 500) {
                anchorLatitude = currentLatitude
                anchorLongitude = currentLongitude
            }

            distance = getdistance(currentLatitude,currentLongitude,anchorLatitude,anchorLongitude)
            direction = positionbearing(currentLatitude,currentLongitude,anchorLatitude,anchorLongitude)

            //console.log(anchorLatitude + " - " + anchorLongitude)

            if (inact > 2) {
                waittimer.running = false
                inact = 0
            }
        }
    }

    function radians(n) {
        return n * (Math.PI / 180);
    }

    function degrees(n) {
        return n * (180 / Math.PI);
    }

    function getdistance(lat1,lon1,lat2,lon2){
        var R = 6371; // km
        var dLat = radians(lat2-lat1) //(lat2-lat1) * Math.PI / 180;
        var dLon = radians(lon2-lon1) //(lon2-lon1) * Math.PI / 180;
        lat1 = radians(lat1) //lat1 * Math.PI / 180;
        lat2 = radians(lat2) //lat2 * Math.PI / 180;

        var a = Math.sin(dLat/2) * Math.sin(dLat/2) +
                Math.sin(dLon/2) * Math.sin(dLon/2) * Math.cos(lat1) * Math.cos(lat2);
        var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
        var d = (R * c) * 1000;

        return d

    }

    function positionbearing(lat1,lon1,lat2,lon2){
        var startLat = radians(lat1);
        var startLong = radians(lon1);
        var endLat = radians(lat2);
        var endLong = radians(lon2);
        var dLong = endLong - startLong;
        var dPhi = Math.log(Math.tan(endLat/2.0+Math.PI/4.0)/Math.tan(startLat/2.0+Math.PI/4.0));

        if (Math.abs(dLong) > Math.PI){
            if (dLong > 0.0)
                dLong = -(2.0 * Math.PI - dLong);
            else
                dLong = (2.0 * Math.PI + dLong);
        }

        var brng = degrees(Math.atan2(dLong,dPhi))
        return brng
    }
}
