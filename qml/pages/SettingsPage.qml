import QtQuick 2.0
import Sailfish.Silica 1.0

Dialog {
    id: settingsDialog
    property bool aComp
    property bool aMag
    property int aR: anchorRadius

    Column {
        //id: col1
        anchors.left: parent.left
        anchors.right: parent.right
        spacing: Theme.paddingMedium

        DialogHeader {}

        Label {
            id: sLabel
            anchors.right: parent.right
            anchors.rightMargin: Theme.paddingLarge
            color: Theme.highlightColor
            font.pixelSize: Theme.fontSizeLarge
            text: qsTr("Compass")
        }

        Separator {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.rightMargin: Theme.paddingMedium
            color: Theme.highlightColor
        }

            TextSwitch {
                id: activateACompass
                width: parent.width
                checked: aCompass.enabled
                enabled: false //aCompass.running
                text: qsTr("Compass")
                description: qsTr("Enables the compass")
                onCheckedChanged: {
                    activateAMagnet.checked = !checked
                    aComp = checked
                    aMag = !checked
                    }
                }

            TextSwitch {
                id: activateAMagnet
                width: parent.width
                checked: aMagnetometer.enabled
                enabled: false //aMagnetometer.running
                text: qsTr("Magnetometer")
                description: qsTr("Activates the magnetometer")
                onCheckedChanged: {
                    activateACompass.checked = !checked
                    aComp = !checked
                    aMag = checked
                }
            }
            TextSwitch {
                id: activateNumbers
                width: parent.width
                checked: showCompasNumbers
                enabled: true //aMagnetometer.running
                text: qsTr("Degrees")
                description: qsTr("Show degrees in compass")
                onCheckedChanged: {
                }
            }
            Label {
                id: rLabel
                anchors.right: parent.right
                anchors.rightMargin: Theme.paddingLarge
                color: Theme.highlightColor
                font.pixelSize: Theme.fontSizeLarge
                text: qsTr("Here radius")+" "+rSlider.value + " "+qsTr("meters")
            }

            Slider {
                id: rSlider
                width: parent.width
                minimumValue: 1
                maximumValue: 30
                stepSize: 1.0
                value: aR
                onValueChanged: aR = value
            }

            Label {
              //  id: sLabel
                anchors.right: parent.right
                anchors.rightMargin: Theme.paddingLarge
                color: Theme.highlightColor
                font.pixelSize: Theme.fontSizeLarge
                text: qsTr("Anchor settings")
            }

            Separator {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.rightMargin: Theme.paddingMedium
                color: Theme.highlightColor
            }
            TextSwitch {
                id: keepSon
                width: parent.width
                checked: keepScreenOn
                enabled: true //aMagnetometer.running
                text: qsTr("Prevent screensaver")
                description: qsTr("Prevent screensaver when Anchor is active")
            }

    }

    onAccepted: {
        activateNumbers.checked ? showCompasNumbers = 1 : showCompasNumbers = 0
        var scron
        keepSon.checked ? scron = 1 : scron = 0
        keepScreenOn = keepSon.checked
        settings.setSettingSetting(aComp,aMag,aR,showCompasNumbers,scron)
        anchorRadius = aR
    }
}
