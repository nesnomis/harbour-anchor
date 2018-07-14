import QtQuick 2.0
import Sailfish.Silica 1.0

CoverBackground {
    onStatusChanged: {
      //  status !== 2 ? inact = true : inact = false
      //  console.log(inact)
    }
    CoverPlaceholder {
        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: Theme.paddingLarge
            color: Theme.highlightColor
            font.pixelSize: Theme.fontSizeExtraLarge//!aGps.running ? Theme.fontSizeMedium : Theme.fontSizeHuge
            text: "Anchor"//aGps.active ? aGps.distance > 10 ? aGps.distance + " m" : "HERE" : "ANCHOR"//compass.running ? compass.distance>10 ? compass.distance + " m" : "HERE" : "CONNECTING"//compass.running ? compass.distance + " m" : "CONNECTING"
        }
        Image {
            //id:iBtn
         //   anchors.verticalCenter: parent.verticalCenter
            width: parent.width * 0.85
            height: parent.height
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
           // anchors.top: column.bottom
           // anchors.bottom: parent.bottom
            //height: parent.height * 0.8
            //width: parent.width * 0.8
            opacity: 0.7
            fillMode: Image.PreserveAspectFit
            source: "../images/harbour-anchor.png"//anchorIcon !== "0" ? anchorIcon : "image://theme/icon-m-whereami" //anchorIcon !== "0" ? anchorIcon + "?" + Theme.highlightColor : "image://theme/icon-m-whereami?" + Theme.highlightColor
        }
        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: Theme.paddingLarge
            color: Theme.highlightColor
            font.pixelSize: Theme.fontSizeExtraLarge//!aGps.running ? Theme.fontSizeMedium : Theme.fontSizeHuge
            text: "v."+Qt.application.version//aGps.active ? aGps.distance > 10 ? aGps.distance + " m" : "HERE" : "ANCHOR"//compass.running ? compass.distance>10 ? compass.distance + " m" : "HERE" : "CONNECTING"//compass.running ? compass.distance + " m" : "CONNECTING"
        }
    }
}
