import QtQuick 2.0
import Sailfish.Silica 1.0
//import "../components"

Dialog {
    id: page
    property real lati
    property real longi

    allowedOrientations: Orientation.Portrait


    Column {
        id: col1
        anchors.left: parent.left
        anchors.right: parent.right
        spacing: Theme.paddingMedium

        DialogHeader {}

        Label {
            id: aLabel
            anchors.right: parent.right
            anchors.rightMargin: Theme.paddingLarge
            color: Theme.highlightColor
            font.pixelSize: Theme.fontSizeLarge
            text: qsTr("Create anchor")
        }

        Separator {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.rightMargin: Theme.paddingMedium
            color: Theme.highlightColor
        }

        Row {
            width:parent.width

            TextField {
                id: sName
                width: parent.width - iBtn.width
                EnterKey.iconSource: "image://theme/icon-m-enter-next"
                EnterKey.onClicked: {focus = false;lName.focus = true}
                placeholderText: qsTr("Anchor name")
                label: qsTr("Anchor name")
            }
            Image {
                id:iBtn
                source: "image://theme/icon-m-car"
            }
        }

        TextField {
            id: lName
            width: parent.width
            EnterKey.iconSource: "image://theme/icon-m-enter-next"
            EnterKey.onClicked: {focus = false}
            placeholderText: qsTr("Anchor description")
            label: qsTr("Anchor description")
        }

        Label {
            id: iLabel
            anchors.right: parent.right
            anchors.rightMargin: Theme.paddingLarge
            color: Theme.highlightColor
            font.pixelSize: Theme.fontSizeLarge
            text: qsTr("Choose icon")
        }

        Separator {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.rightMargin: Theme.paddingMedium
            color: Theme.highlightColor
        }

        Grid {
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width
            columns: 4
            spacing: 2
            IconButton  {
                width: parent.width / 4
                height: width / 1.5
                icon.source: "image://theme/icon-m-car"
                onClicked: iBtn.source = icon.source
            }

            IconButton  {
                width: parent.width / 4
                height: width / 1.5
                icon.source: "image://theme/icon-m-airplane-mode"
                onClicked: iBtn.source = icon.source
            }

            IconButton  {
                width: parent.width / 4
                height: width / 1.5
                icon.source: "image://theme/icon-m-whereami"
                onClicked: iBtn.source = icon.source
            }

            IconButton  {
                width: parent.width / 4
                height: width / 1.5
                icon.source: "image://theme/icon-m-person"
                onClicked: iBtn.source = icon.source
            }

            IconButton  {
                width: parent.width / 4
                height: width / 1.5
                icon.source: "image://theme/icon-m-train"
                onClicked: iBtn.source = icon.source
            }

            IconButton  {
                width: parent.width / 4
                height: width / 1.5
                icon.source: "image://theme/icon-m-region"
                onClicked: iBtn.source = icon.source
            }
            IconButton  {
                width: parent.width / 4
                height: width / 1.5
                icon.source: "image://theme/icon-m-favorite"
                onClicked: iBtn.source = icon.source
            }
            IconButton  {
                id: lim
                width: parent.width / 4
                height: width / 1.5
                icon.source: "image://theme/icon-m-home"
                onClicked: iBtn.source = icon.source
            }
        }
        Label {
            id: cLabel
            anchors.right: parent.right
            anchors.rightMargin: Theme.paddingLarge
            color: Theme.highlightColor
            font.pixelSize: Theme.fontSizeLarge
            text: qsTr("Latitude & Longitude")
        }
        Separator {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.rightMargin: Theme.paddingMedium
            color: Theme.highlightColor
        }

        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            text: anchorLatitude + " - " + anchorLongitude
        }
    }

    onAccepted: {
        console.log("*** ACCEPTED")
        anchorIcon = iBtn.source
        anchorName = sName.text
        anchorDescription = lName.text
        anchorLatitude = aGps.currentLatitude
        anchorLongitude = aGps.currentLongitude
        settings.setSettings(anchorLatitude,anchorLongitude,anchorIcon,anchorName,anchorDescription)
        settings.setAnchor(anchorName, anchorDescription, anchorIcon, anchorLatitude, anchorLongitude)
        settings.getAnchors(dbAnchors)
    }
}
