import QtQuick 2.0
import Sailfish.Silica 1.0
//import "../components"

Dialog {
    id: page
    canAccept: sName.text !== "" && lName.text !=="" && la.text !== "" && lo.text !=="" ? true : false
    property bool edit: false
    property bool newAnchor: false
    allowedOrientations: Orientation.Portrait

    SilicaFlickable {
        anchors.fill: parent
        contentX: 0
        contentHeight: col1.height
        //contentWidth: text.width; contentHeight: text.height

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
                text: edit ? qsTr("Edit anchor") : qsTr("Create anchor")
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
                    placeholderText: edit && !newAnchor ? "" : qsTr("Anchor name")
                    text: edit ? anchorName : ""
                    label: qsTr("Anchor name")
                }
                Image {
                    id:iBtn
                    source: edit ? anchorIcon : "image://theme/icon-m-car"
                }
            }

            TextField {
                id: lName
                width: parent.width
                EnterKey.iconSource: "image://theme/icon-m-enter-next"
                EnterKey.onClicked: {edit || newAnchor? la.focus = true : focus = false}
                placeholderText: edit && !newAnchor ? "" : qsTr("Anchor description")
                text: edit ? anchorDescription : ""
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

            Item {
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width
                height: Theme.itemSizeMedium
                TextField {
                    id: lo
                    enabled: edit || newAnchor
                    anchors.left: parent.horizontalCenter
                    anchors.leftMargin: Theme.paddingLarge
                    width: parent.width * 0.5 - Theme.paddingLarge
                    EnterKey.iconSource: "image://theme/icon-m-enter-next"
                    EnterKey.onClicked: {focus = false}
                    inputMethodHints: Qt.ImhFormattedNumbersOnly //| Qt.ImhNoPredictiveText
                    placeholderText: newAnchor ? "Longitude" : ""
                    text: edit ? anchorLongitude : newAnchor ? "" : aGps.currentLongitude
                    onTextChanged: text = text.replace(",",".")
                }
                TextField {
                    id: la
                    enabled: edit || newAnchor
                    anchors.right: parent.horizontalCenter
                    anchors.rightMargin: Theme.paddingLarge
                    anchors.top: lo.top
                    width: parent.width * 0.5 - Theme.paddingLarge
                    EnterKey.iconSource: "image://theme/icon-m-enter-next"
                    EnterKey.onClicked: {focus = false;lo.focus = true}
                    inputMethodHints: Qt.ImhFormattedNumbersOnly //| Qt.ImhNoPredictiveText
                    placeholderText: newAnchor ? "Latitude" : ""
                    horizontalAlignment: Qt.AlignRight
                    text: edit ? anchorLatitude : newAnchor ? "" : aGps.currentLatitude
                    onTextChanged: text = text.replace(",",".")
                }
            }
        }
    }
    onAccepted: {
        console.log("*** ACCEPTED")
        if (sName.text !== "" && la.text !== "" && lo.text !=="") {
            if (edit && !newAnchor) settings.delAnchor(anchorName)
            anchorIcon = iBtn.source
            anchorName = sName.text
            anchorDescription = lName.text
            anchorLatitude = la.text
            anchorLongitude = lo.text
            settings.setSettings(anchorLatitude,anchorLongitude,anchorIcon,anchorName,anchorDescription)
            settings.getAnchors(dbAnchors)
            settings.setAnchor(anchorName, anchorDescription, anchorIcon, anchorLatitude, anchorLongitude)
            settings.getAnchors(dbAnchors)
        }
    }
}
