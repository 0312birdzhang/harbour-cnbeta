import QtQuick 2.0
import Sailfish.Silica 1.0
import Sailfish.Silica.Theme 1.0

QtObject {
    id: constant;

    // color
    property color colorLight: Theme.colorNormalLightInverted;
    property color colorMid: Theme.colorNormalMidInverted;
    property color colorMarginLine: Theme.colorDisabledLightInverted;
    property color colorTextSelection: Theme.colorTextSelectionInverted;
    property color colorDisabled: Theme.colorDisabledMidInverted;

    // padding size
    property int paddingSmall: Theme.paddingSmall
    property int paddingMedium: Theme.paddingMedium
    property int paddingLarge: Theme.paddingLarge
    property int paddingXLarge: Theme.paddingLarge + Theme.paddingSmall

    // graphic size
    property int graphicSizeTiny: Theme.graphicSizeTiny
    property int graphicSizeSmall: Theme.graphicSizeSmall
    property int graphicSizeMedium: Theme.graphicSizeMedium
    property int graphicSizeLarge: Theme.graphicSizeLarge
    property int thumbnailSize: Theme.graphicSizeLarge * 1.5

    // font size
    property int fontXSmall: Theme.fontSizeSmall - 2
    property int fontSmall: Theme.fontSizeSmall
    property int fontMedium: Theme.fontSizeMedium
    property int fontLarge: Theme.fontSizeLarge
    property int fontXLarge: Theme.fontSizeLarge + 2
    property int fontXXLarge: Theme.fontSizeLarge + 4

    property variant subTitleFont: __subTitleText.font;
    property variant labelFont: __label.font;
    property variant titleFont: __titleText.font;

    // size
    property variant sizeTiny: Qt.size(graphicSizeTiny, graphicSizeTiny);
    property variant sizeMedium: Qt.size(graphicSizeMedium, graphicSizeMedium);

    // others
    property int headerHeight: privateStyle.tabBarHeightPortrait;

    // private
    property ListItemText __titleText: ListItemText {}
    property ListItemText __subTitleText: ListItemText { role: "SubTitle"; }
    property Label __label: Label {}
}
