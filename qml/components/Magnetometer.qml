import QtQuick 2.0
import QtSensors 5.0

Item {
    property bool running: false
    property bool enabled: false//settings.getSettings("magnetometerSetting",true)
    property int azimuth: 0
    property real calibration: 0.0
    property variant data: [0,0,0,0,0]

    onEnabledChanged: {
        console.log("*** MAGNETOMETER: "+enabled)
        if (!enabled) running = false
    }

    Accelerometer
    {
        id: accel
        dataRate: 6
        active: enabled && Qt.application.active
    }

    Magnetometer {
        id: mag
        dataRate: 6
        returnGeoValues: true // not sure
        active: enabled && Qt.application.active

        onReadingChanged: {
            running = true
            var accelVec = [accel.reading.x, accel.reading.y, accel.reading.z]
            var magEast = crossProduct([mag.reading.x, mag.reading.y, mag.reading.z], accelVec)
            var magNorth = crossProduct(accelVec, magEast)

            magEast = normVec(magEast)
            magNorth = normVec(magNorth)

            var deviceHeading = [0., 1., -1.] //This is for portrait orientation on android
            var dotWithEast = dotProduct(deviceHeading, magEast)
            var dotWithNorth = dotProduct(deviceHeading, magNorth)
            var bearingRad = Math.atan2(dotWithEast, dotWithNorth)
            var t = ((bearingRad * 180 / Math.PI) - 360) %360
            var bearingDeg = 360 - Math.abs(t)
            calibration = mag.reading.calibrationLevel
            azimuth = normalize360(bearingDeg)
        }

        function normalize360(angle) {
            var semiNormalized = angle % 360
            return semiNormalized >= 0 ? semiNormalized : semiNormalized + 360
        }

        function normalizeAngle(angle)
        {
            var newAngle = angle;
            if (newAngle <= -180) newAngle = newAngle + 360;
            if (newAngle > 180) newAngle = newAngle - 360;
            return newAngle;
        }

        function crossProduct(a, b) {
            if (a.length != 3 || b.length != 3) {
                return;
            }

            return [a[1]*b[2] - a[2]*b[1],
                  a[2]*b[0] - a[0]*b[2],
                  a[0]*b[1] - a[1]*b[0]];
        }

        function normVec(a) {
            var compSq = 0.
            for(var i=0;i<a.length;i++)
                compSq += Math.pow(a[i], 2)
            var mag = Math.pow(compSq, 0.5)
            if(mag == 0.) return
            var out = []
            for(var i=0;i<a.length;i++)
                out.push(a[i]/mag)
            return out
        }

        function dotProduct(a, b)
        {
            if (a.length != b.length) return;
            var comp = 0.
            for(var i=0;i<a.length;i++)
                comp += a[i] * b[i]
            return comp
        }
    }
}
