import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    SilicaListView {
        id: listView
        anchors.fill: parent
        clip: true

        header: PageHeader {
            id: pHeader
            title: qsTr("Anchors")
        }

        model: dbModel

        delegate: ListItem {
            id: delegate
            height: menuOpen ? contextMenu.height + img.height + (Theme.paddingMedium * 2): img.height + (Theme.paddingMedium * 2)
            contentHeight: img.height
            width: parent.width - Theme.paddingMedium * 2
            anchors.horizontalCenter: parent.horizontalCenter
            menu: contextMenu
            showMenuOnPressAndHold: true
            ListView.onRemove: animateRemoval(delegate)

            function remove() {
                remorseAction(qsTr("Deleting"), function() { settings.delAnchor(name);listView.model.remove(index) })
            }

            ContextMenu {
                id: contextMenu

                MenuItem {
                    id:mlisten
                    text: qsTr("Select anchor")
                    //enabled: false
                   onClicked: {
                       aGps.enabled = true
                       anchorIcon = icon
                       anchorName = name
                       anchorDescription = description
                       anchorLatitude = latitude
                       anchorLongitude = longitude
                       settings.setSettings(latitude,longitude,icon,name,description)
                       pageStack.navigateBack()                    }
                }

                MenuItem {
                    id:medit
                    text: qsTr("Edit anchor")
                    enabled: true

                    onClicked: {
                       // aGps.enabled = true
                      //  anchorIcon = icon
                      //  anchorName = name
                      //  anchorDescription = description
                        //anchorLatitude = latitude
                        //anchorLongitude = longitude
                        anchorIcon = icon
                        anchorName = name
                        anchorDescription = description
                        anchorLatitude = latitude
                        anchorLongitude = longitude
                        settings.setSettings(latitude,longitude,icon,name,description)
                        pageStack.push(Qt.resolvedUrl("AddAnchorPage.qml"),{edit: true,newAnchor: false});
                        //settings.setSettings(anchorLatitude,anchorLatitude,anchorIcon,anchorName,anchorDescription)
                        //pageStack.navigateBack()
                    }

              //      onClicked: window.pageStack.push(Qt.resolvedUrl("AddOwnRadio.qml"),
              //                                       {infotext: qsTr("Edit radio station"),titlfield: title,streamurlfield: source,homepagefield: site,sectionfield: section,oldsource: source})
                }

                MenuItem {
                    id:mdelete
                    text: qsTr("Delete anchor")

                    onClicked: remove()//listView.currentItem.remove(rpindex,rpsource) //listView.remorseAction();
                }
            }

            Row {
                spacing: Theme.paddingLarge
                width: parent.width

                Image {
                   id: img
                   height: aName.height + aDesc.height
                   width: height
                   fillMode: Image.PreserveAspectFit
                   source: icon
                }

                Column {
                    Text {
                         id: aName
                         text: name
                         color: highlighted ? Theme.highlightColor : Theme.primaryColor
                         wrapMode: Text.ElideRight
                         font.pixelSize: Theme.fontSizeLarge
                    }
                    Text {
                         id: aDesc
                         text: description
                         color: highlighted ? Theme.secondaryHighlightColor : Theme.secondaryColor
                         wrapMode: Text.ElideRight
                         font.pixelSize: Theme.fontSizeMedium
                    }
                }
            }

            onClicked: {
                aGps.enabled = true
                anchorIcon = icon
                anchorName = name
                anchorDescription = description
                anchorLatitude = latitude
                anchorLongitude = longitude
                settings.setSettings(latitude,longitude,icon,name,description)
                pageStack.navigateBack()
            }
        }
    }
}

