import QtQuick 2.0
import Sailfish.Silica 1.0
import org.SfietKonstantin.pt2 1.0

Page {
    id: container
    property int index
    property RealTimeStationSearchModel stationSearchModel

    RealTimeRidesFromStationModel {
        id: ridesFromStationModel
        stationSearchModel: container.stationSearchModel
    }

    Component.onCompleted: stationSearchModel.requestRidesFromStation(container.index)
}
