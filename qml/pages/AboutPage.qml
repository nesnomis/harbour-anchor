import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page
    //allowedOrientations: Orientation.Landscape | Orientation.Portrait



    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height


        Column {
            id: column
            PageHeader {

                title: qsTr("About Anchor v.")+Qt.application.version

            }

            width: parent.width
            spacing: Theme.paddingLarge
            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Author")
                color: Theme.secondaryHighlightColor
                font.pixelSize: Theme.fontSizeLarge
            }
            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Niels Simonsen (nesnomis)"
                font.pixelSize: Theme.fontSizeMedium
            }
            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Info")
                color: Theme.secondaryHighlightColor
                font.pixelSize: Theme.fontSizeLarge
            }
            Text {
                x: Theme.paddingLarge
                width: parent.width - 2*Theme.paddingLarge
                wrapMode: Text.Wrap
                text: qsTr("Anchor is a small app using compass/magnetometer and GPS to mark your current position (make an anchor) so you can find your direction back. This could be where you parked your car, or other useful places?!")
                font.pixelSize: Theme.fontSizeMedium
                color: Theme.primaryColor
                horizontalAlignment: Text.AlignHCenter
            }
            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Copyrights (2018)")
                color: Theme.secondaryHighlightColor
                font.pixelSize: Theme.fontSizeLarge
            }
            Label {
                text: qsTr("Anchor is public domain. If nothing else is stated, it is licened under GPL.")
                x: Theme.paddingLarge
                width: parent.width - 2*Theme.paddingLarge
                wrapMode: Text.Wrap
                font.pixelSize: Theme.fontSizeMedium
                color: Theme.primaryColor
                horizontalAlignment: Text.AlignHCenter
            }
            Image {
                anchors.horizontalCenter: parent.horizontalCenter
                opacity: 0.7
                fillMode: Image.PreserveAspectFit
                source: "../images/harbour-anchor.png"//anchorIcon !== "0" ? anchorIcon : "image://theme/icon-m-whereami" //anchorIcon !== "0" ? anchorIcon + "?" + Theme.highlightColor : "image://theme/icon-m-whereami?" + Theme.highlightColor
            }
        }

    }
}


