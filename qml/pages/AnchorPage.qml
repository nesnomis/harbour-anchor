import QtQuick 2.0
import Sailfish.Silica 1.0
import "../components"
import QtSensors 5.0

Page {
    id: page
    property int dots: 1
    property real calibration: aCompass.calibration ? aCompass.calibration : aMagnetometer.calibration

    allowedOrientations: Orientation.Portrait

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: Screen.height

        PullDownMenu {

            MenuItem {
                enabled: false//aGps.active
                visible: false
                text: qsTr("Refresh to current position")
                onClicked: {
                    anchorLatitude = aGps.currentLatitude
                    anchorLongitude = aGps.currentLongitude
                    settings.setSettings(anchorLatitude,anchorLongitude,anchorIcon,anchorName,anchorDescription)
                    settings.setAnchor(anchorName, anchorDescription, anchorIcon, anchorLatitude, anchorLongitude)
                }
            }

            MenuItem {
                enabled: aGps.active
                text: qsTr("Add anchor")
                onClicked: pageStack.push(Qt.resolvedUrl("AddAnchorPage.qml")),{lati: aGps.currentLatitude,longi: aGps.currentLongitude};//posTimer.running = true//pageStack.push(Qt.resolvedUrl("SecondPage.qml"))
            }

            MenuItem {
                enabled: true
                text: qsTr("Select anchor")
                onClicked: {pageStack.push(Qt.resolvedUrl("EditAnchorsPage.qml"))}
            }
        }

        PushUpMenu {
            MenuItem {
                enabled: true
                text: aGps.enabled ? qsTr("Disable GPS in app") : qsTr("Enable GPS in app")
                onClicked: aGps.enabled ? aGps.enabled = false : aGps.enabled = true
            }
            MenuItem {
                enabled: true
                text: qsTr("Settings")
                onClicked: pageStack.push(Qt.resolvedUrl("SettingsPage.qml"))
            }
            MenuItem {
                enabled: true
                text: qsTr("About Anchor")
                onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
            }
        }

        Item {
            id: header2
            visible: !header.visible
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.topMargin: Theme.paddingLarge
            anchors.top: parent.top
            anchors.bottom: compassCapsule.top
            anchors.bottomMargin: Theme.paddingLarge

            Row {
                spacing: Theme.paddingLarge
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter

                Image {
                    //id:iBtn
                    height: apHeader2.height+apInfo2.height
                    width: height
                    fillMode: Image.PreserveAspectFit
                    source: "../images/harbour-anchor.png"//anchorIcon !== "0" ? anchorIcon : "image://theme/icon-m-whereami" //anchorIcon !== "0" ? anchorIcon + "?" + Theme.highlightColor : "image://theme/icon-m-whereami?" + Theme.highlightColor
                }

                Column {
                    Label {
                        id: apHeader2
                        style: Text.Outline; styleColor: Theme.secondaryHighlightColor;
                        font.pixelSize: Theme.fontSizeHuge
                        text: qsTr("Anchor") //anchorName !== "0" ? anchorName : qsTr("No anchor") //"Anchor: Quick"
                    }

                    Label {
                        id: apInfo2
                        color: Theme.secondaryColor
                        font.pixelSize: Theme.fontSizeMedium
                        text: qsTr("A compass & anchor app") //anchorDescription !== "0" ? anchorDescription : "" // "[Default anchor]"
                    }
                }
            }
        }

        Item {
            id: header
            visible: aGps.enabled
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.topMargin: Theme.paddingLarge
            anchors.top: parent.top
            anchors.bottom: compassCapsule.top
            anchors.bottomMargin: Theme.paddingLarge

            Row {
                spacing: Theme.paddingMedium
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter

                Image {
                    id:iBtn
                    height: apHeader.height+apInfo.height
                    width: height
                    fillMode: Image.PreserveAspectFit
                    source: anchorIcon ? anchorIcon : "image://theme/icon-m-whereami" //anchorIcon !== "0" ? anchorIcon + "?" + Theme.highlightColor : "image://theme/icon-m-whereami?" + Theme.highlightColor
                }

                Column {
                    Label {
                        id: apHeader
                        style: Text.Outline; styleColor: Theme.secondaryHighlightColor;
                        font.pixelSize: Theme.fontSizeExtraLarge
                        text: anchorName ? anchorName : qsTr("No anchor") //"Anchor: Quick"
                    }

                    Label {
                        id: apInfo
                        color: Theme.secondaryColor
                        font.pixelSize: Theme.fontSizeMedium
                        text: anchorDescription ? anchorDescription : qsTr("Add an anchor") // "[Default anchor]"
                    }
                }
            }
        }

        CompassCapsule {
            id: compassCapsule
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width * 0.8
            height: width
            anchorArrow: aGps.active && aGps.distance > anchorRadius ? 0.8 : 0.0
            azimuth: aCompass.enabled ? aCompass.azimuth : aMagnetometer.azimuth
            anchor: aGps.direction
        }

        Dot {
            id: dotN
            visible: !showCompasNumbers
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: compassCapsule.top
            width: compassCapsule.width / 12
            color: Theme.highlightColor
            opacity: aGps.active && aGps.distance > anchorRadius ? 0.7 : 0.1
        }

        Item {
            id: footer
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.topMargin: Theme.paddingLarge
            anchors.top: compassCapsule.bottom
            anchors.bottom: info.top
            anchors.bottomMargin: Theme.paddingLarge
            Column {
                spacing: Theme.paddingMedium
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter

                Label {
                    id: gpsconnect
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: Theme.primaryColor

                    font.pixelSize: Theme.fontSizeHuge//aGps.active ? Theme.fontSizeHuge : Theme.fontSizeExtraLarge
                    text: aGps.active ? aGps.distance > anchorRadius ? qsTr("Distance: ")+aGps.distance + " m" : qsTr("HERE") : aGps.enabled ? qsTr("WAITING FOR GPS") : azimuth

                    Timer {
                        property bool up
                        id: glowingTimer
                        running: !aGps.active && aGps.enabled
                        repeat: true
                        interval: 100

                        onRunningChanged: if (!running) gpsconnect.opacity = 1
                        onTriggered: {
                            if (gpsconnect.opacity === 1){
                                up = false
                            } else if (gpsconnect.opacity < 0.5) {
                                up = true
                            }
                            if (up)
                                gpsconnect.opacity += 0.1
                            else
                                gpsconnect.opacity -= 0.1
                        }
                    }
                }

                Label {
                    id: gpsheight
                    visible: aGps.enabled
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: Theme.secondaryColor
                    font.pixelSize: aGps.active ? Theme.fontSizeExtraLarge : Theme.fontSizeMedium
                    text: aGps.active ? qsTr("Altitude: ")+aGps.currentAltitude + " m" : qsTr("Make sure your phone GPS is enabled!")
                }
            }
        }

        Rectangle {
            id: calibRect
            color: "transparent"
            border.color: Theme.highlightColor
            anchors.bottom: parent.bottom
            anchors.bottomMargin: Theme.paddingMedium
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: Theme.paddingMedium
            anchors.rightMargin: Theme.paddingMedium
            height: calibrationBar.height
            visible: calibration < 1 ? true : false//aCompass.enabled ? aCompass.calibration < 1 && aCompass.calibration > 0 ? true : aMagnetometer.calibration < 1 && aMagnetometer.calibration > 0 ? true : false : false

            ProgressBar {
                id: calibrationBar
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                minimumValue: 0.0
                maximumValue: 1.0
                width: parent.width
                value: aCompass.enabled ? aCompass.calibration : aMagnetometer.calibration
                label: qsTr("Rotate phone to calibrate compass")
            }
         }

        Label {
            id: info
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottomMargin: Theme.paddingLarge
            anchors.bottom: parent.bottom
            color: Theme.highlightColor
            font.pixelSize: Theme.fontSizeSmall
            text: "Anchor v."+Qt.application.version+" "+qsTr("is an app by")+" nesnomis"
            visible: !calibRect.visible
        }

        Rectangle {
            id: rect
            visible: false
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: page.width * 0.75
            height: width
            color: Theme.highlightDimmerColor
            border.color: Theme.highlightColor
            border.width: 1
            radius: width

            Column {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter

                Text {
                     color: Theme.highlightColor
                     font.pixelSize: Theme.fontSizeHuge
                     text: aGps.positionBearing + " ("+aGps.direction+")"
                }

                Text {
                    visible: aCompass.running
                     color: Theme.highlightColor
                     font.pixelSize: Theme.fontSizeHuge
                     text: aCompass.enabled ? aCompass.azimuth : aMagnetometer.azimuth//compass.compassBearing + " ("+compass.compasNumber+")"
                }
            }
        }
    }

    Component.onCompleted: {
        settings.getQanchor()
        var types = QmlSensors.sensorTypes();
        console.log(types.join(", "));

    }
}
