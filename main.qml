import QtQuick 2.0
import Sailfish.Silica 1.0
import org.SfietKonstantin.pt2 1.0
import "pages"

ApplicationWindow {
    id: app

    DBusBackendManager {
        id: manager
    }

    BackendModel {
        id: backendModel
        backendManager: manager
        Component.onCompleted: {
            reload()
        }
    }

    initialPage: Component { MainPage { id: mainPage } }
//    cover: Qt.resolvedUrl("cover/CalendarCover.qml")
}

