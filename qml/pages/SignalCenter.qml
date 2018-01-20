import QtQuick 2.0
import Sailfish.Silica 1.0
//import io.thp.pyotherside 1.3

QtObject{
    id:signalcenter;
    signal loadStarted;
    signal loadFinished;
    signal loadFailed(string errorstring);


    signal getRecent(var result);

    function showMessage(msg){
        appwindow.showMsg(msg)
    }
}
