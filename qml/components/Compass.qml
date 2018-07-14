import QtQuick 2.0
import QtSensors 5.0

Item {
    property int azimuth: 0
    property real calibration: 0.0
    property bool running: false
    property bool enabled: true//settings.getSettings("compassSetting",false)

    Timer {
        id: waittimer
        running: false
        repeat: false
        interval: 750
        onTriggered: {
            if (!aCompass.running) {
                aCompass.enabled = false
                aMagnetometer.enabled = true
            }
        }
    }

    Component.onCompleted: waittimer.running = true//if (!running) {enabled = false;aMagnetometer.enabled = true}

    onEnabledChanged: {
        console.log("*** COMPASS: "+enabled)
        if (!enabled) running = false
    }

    Compass {
        active: enabled && Qt.application.active
        dataRate: 5

        onReadingChanged:  {
            running = true
            if (enabled) {
                azimuth = reading.azimuth
                calibration = reading.calibrationLevel
            }
        }
    }
}
