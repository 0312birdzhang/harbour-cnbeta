import Sailfish.Silica.extras 1.1
import QtQuick 2.0
import Sailfish.Silica 1.0
PageStackWindow {
    id: app;

    platformInverted: true;
    showStatusBar: true;
    showToolBar: true;

    initialPage: MainPage { id: mainPage; }

    Binding {
        target: app.pageStack.toolBar;
        property: "platformInverted";
        value: false;
    }

    InfoBanner { id: infoBanner; platformInverted: true; }

    Constant { id: constant; }

    SignalCenter { id: signalCenter; }
}
