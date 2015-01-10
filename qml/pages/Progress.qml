import QtQuick 2.0
import Sailfish.Silica 1.0
Item{
    width:540
    height:960
    y:960/2-BusyIndicatorSize.Large/2
    Row {
        spacing: Theme.paddingLarge
        anchors.horizontalCenter: parent.horizontalCenter

        BusyIndicator {
            running: true
            size: BusyIndicatorSize.Large
            anchors.verticalCenter: parent.verticalCenter
        }
    }
}
