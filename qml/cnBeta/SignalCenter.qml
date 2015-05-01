import QtQuick 2.0

QtObject {
    id: signalCenter;

    function showMessage(msg){
        if (msg||false){
            infoBanner.text = msg;
            infoBanner.open();

        }
    }
}
