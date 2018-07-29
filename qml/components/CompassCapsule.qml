import QtQuick 2.0
import Sailfish.Silica 1.0

Item {
    id: compassCapsule
    width: parent.height
    height: width

    property real direction: normalize360(- __ringRotation)  // In degrees, 0-359
    property int azimuth: 0    // In degrees, set (bind) from outside, the compass needle follows this
    property int anchor: 0
    property bool changingDirection: false  // Is the direction (ring rotation) changing right now?
    property alias anchorArrow: anchorArrow.opacity
    property real __previousAngle: 0
    property real __ringRotation: 0

    function normalize360(angle) {
        var semiNormalized = angle % 360
        return semiNormalized >= 0 ? semiNormalized : semiNormalized + 360
    }

    Image {
        id: basePicture
        source: showCompasNumbers ? "../images/compass_ring_base_black.png" : "../images/compass_ring_base_white.png"
        opacity: showCompasNumbers ? 0.7 : 0.5
        //visible: !aGps.enabled
        width: parent.width
        height: parent.height
        fillMode: Image.PreserveAspectFit
        anchors.centerIn: parent
    }
    Image {
        id: numberRing
        source: "../images/compass_ring_360_day.png"
       // opacity:
        visible: showCompasNumbers
        width: parent.width
        height: parent.height
        fillMode: Image.PreserveAspectFit
        anchors.centerIn: parent
    }
    Image {
        source: "../images/compass_needle_day_N_red.png"
        anchors.centerIn: parent
        width: parent.width*0.80
        height: parent.height*0.80
        fillMode: Image.PreserveAspectFit
        visible: true
        opacity: 0.7
        rotation: - compassCapsule.azimuth
        Behavior on rotation { RotationAnimation { duration: 250; direction: RotationAnimation.Shortest } }
        Behavior on opacity {
            FadeAnimator {}
        }
    }

    Image {
        id: anchorArrow
        source: "../images/compass_needle_day_N_green.png"
        anchors.centerIn: parent
        width: parent.width*0.80
        height: parent.height*0.80
        fillMode: Image.PreserveAspectFit
        opacity: 0.8
        rotation: - compassCapsule.azimuth + compassCapsule.anchor //compassCapsule.azimuth > compassCapsule.anchor ? compassCapsule.anchor - compassCapsule.azimuth : compassCapsule.azimuth - compassCapsule.anchor
        Behavior on rotation { RotationAnimation { duration: 200; direction: RotationAnimation.Shortest } }
        Behavior on opacity {
            FadeAnimator {duration: 200}
        }
    }
}
