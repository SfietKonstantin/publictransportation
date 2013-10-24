import QtQuick 2.0
import Sailfish.Silica 1.0
import org.SfietKonstantin.pt2 1.0

Page {
    id: container

    RealTimeStationSearchModel {
        id: stationSearchModel
        backendManager: manager
        property string searchText
        onSearchTextChanged: {
            search(searchText)
            placeHolder.setText()
        }
        onShortChanged: placeHolder.setText()
        onLoadingChanged: placeHolder.setText()
        onCountChanged: placeHolder.setText()
    }

    SilicaListView {
        anchors.fill: parent
        currentIndex: -1
        header: Column {
            width: container.width

            PageHeader {
                title: "Search station"
            }

            SearchField {
                id: searchField
                width: parent.width
                placeholderText: qsTr("Search")
                Component.onCompleted: forceActiveFocus()

                Binding {
                    target: stationSearchModel
                    property: "searchText"
                    value: searchField.text.toLowerCase().trim()
                }
            }
        }
        model: stationSearchModel
        delegate: BackgroundItem {
            Label {
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left; anchors.leftMargin: Theme.paddingLarge
                anchors.right: parent.right; anchors.rightMargin: Theme.paddingLarge
                text: model.name
            }
            onClicked: {
                container.pageContainer.push(Qt.resolvedUrl("RealTimeRidesFromStationPage.qml"),
                                             {"index": model.index,
                                              "stationSearchModel": stationSearchModel})
            }
        }

        ViewPlaceholder {
            id: placeHolder
            Component.onCompleted: setText()
            function setText() {
                if (stationSearchModel.searchText.length == 0) {
                    placeHolder.text = qsTr("Enter the name of a station in the search field")
                    return
                }
                if (stationSearchModel.short) {
                    placeHolder.text = qsTr("Enter more letters")
                    return
                }
                if (stationSearchModel.loading) {
                    placeHolder.text = qsTr("Loading")
                    return
                }
                if (stationSearchModel.count == 0) {
                    placeHolder.text = qsTr("No station found")
                    return
                }
                placeHolder.text = ""
            }

            enabled: stationSearchModel.count == 0
        }
    }


}
