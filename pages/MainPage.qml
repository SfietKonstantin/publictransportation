import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: container
    SilicaListView {
        anchors.fill: parent
        model: ListModel {
            ListElement {
                text: "Real time informations"
                page: "RealTimePage.qml"
            }
        }
        delegate: BackgroundItem {
            Label {
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left; anchors.leftMargin: Theme.paddingLarge
                anchors.right: parent.right; anchors.rightMargin: Theme.paddingLarge
                text: model.text
            }
            onClicked: container.pageContainer.push(Qt.resolvedUrl(model.page))
        }
        header: PageHeader {
            title: qsTr("Public transportation")
        }

        PullDownMenu {
            id: menu
            MenuItem {
                text: qsTr("Manage providers")
                onClicked: container.pageContainer.push(Qt.resolvedUrl("BackendPage.qml"))
            }
        }
    }
}
