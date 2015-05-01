import QtQuick 2.0
import Sailfish.Silica 1.0
Rectangle {
    id: root;

    property alias title: text.text;

    signal clicked;

    implicitWidth: screen.width;
    implicitHeight: constant.headerHeight;
    color: "#1f2837";
    z: 10;

    Rectangle {
        id: mask;
        anchors.fill: parent;
        color: "black";
        opacity: mouseArea.pressed ? 0.3 : 0;
    }

    Image {
        anchors { left: parent.left; top: parent.top; }
        source: "../gfx/meegoTLCorner.png";
    }
    Image {
        anchors { right: parent.right; top: parent.top; }
        source: "../gfx/meegoTRCorner.png";
    }

    Text {
        id: text;
        anchors {
            left: parent.left; right: parent.right;
            margins: constant.paddingXLarge;
            verticalCenter: parent.verticalCenter;
        }
        font.pixelSize: constant.fontXLarge;
        color: "white";
        style: Text.Raised;
        styleColor: constant.colorMid;
        maximumLineCount: 2;
        elide: Text.ElideRight;
        wrapMode: Text.WrapAnywhere;
    }

    MouseArea {
        id: mouseArea;
        anchors.fill: parent;
        onClicked: root.clicked();
    }
}
