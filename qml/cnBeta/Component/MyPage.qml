import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: root;

    property bool loading;

    //orientationLock: PageOrientation.LockPortrait;

    BusyIndicator {
        id: loadingIndicator;
        visible: root.loading;
       // platformInverted: true;
        width: constant.graphicSizeLarge;
        height: constant.graphicSizeLarge;
        anchors.centerIn: parent;
        running: true;
        z: 10;
    }
}
