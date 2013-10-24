import QtQuick 2.0
import Sailfish.Silica 1.0
import org.SfietKonstantin.pt2 1.0

Page {
    SilicaListView {
        id: view
        anchors.fill: parent
        model: backendModel
        header: PageHeader {
            title: qsTr("Providers")
        }

        delegate: BackgroundItem {
            GlassItem {
                id: glassItem
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left; anchors.leftMargin: Theme.paddingMedium
                color: {
                    switch (model.status) {
                    case BackendModel.Launching:
                        "yellow"
                        break
                    case BackendModel.Stopping:
                        "orange"
                        break
                    case BackendModel.Invalid:
                        "red"
                        break
                    default:
                        "white"
                        break
                    }
                }
                dimmed: model.status == BackendModel.Stopped
            }

            Label {
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: glassItem.right; anchors.leftMargin: Theme.paddingMedium
                text: model.name
            }
            onClicked: {
                switch (model.status) {
                case BackendModel.Launched:
                    backendModel.stopBackend(model.identifier)
                    break
                case BackendModel.Stopped:
                    backendModel.startBackend(model.identifier)
                    break
                }
            }
        }

        ViewPlaceholder {
            enabled: backendModel.count == 0
            text: qsTr("Installs some public transportation providers")
        }
    }
}
