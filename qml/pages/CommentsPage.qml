import QtQuick 2.0
import Sailfish.Silica 1.0
import "API.js" as JS
import "Setting.js" as Settings
import io.thp.pyotherside 1.3

Page{
    id:commtenPage
    property string sid
    property int commpage: 1
    property int commentscount : 1
    ListModel{
        id:commentModel
    }

    Progress{
        id:progress
        running: !PageStatus.Active
        parent:commtenPage
        anchors.centerIn: parent
    }
    function clearModel(){
        commentModel.clear();

    }
    Python{
        id:commentspy
        Component.onCompleted: {
            addImportPath(Qt.resolvedUrl('../py'));
            commentspy.importModule('cnbeta', function () {
                 loadComment(sid,commpage)
             });

        }


       function loadComment(sid,commpage){
            progress.running = true;
           commentspy.call('cnbeta.getnewscomment',[sid,commpage],function(result){
                result= eval('(' + result + ')');
               if(result.result.length == 0){
                   tip.visible = true;
               }else{
                   tip.visible = false;
                   for(var i in result.result){
                   commentModel.append({
                                    "tid":result.result[i].tid,
                                    "comments":result.result[i].content,
                                    "created_time":result.result[i].created_time,
                                    "username":result.result[i].username,
                                    "support":result.result[i].support,
                                    "against":result.result[i].against
                               })
                   }
               }

           })
           progress.running = false;
       }
       function supportagainst(op,sid,tid){

           commentspy.call('cnbeta.supportagainst',[op,sid,tid],function(result){
                result= eval('(' + result + ')');
                showMsg(result.result)
           })

       }
        onError: {
            showMsg("提交失败，请重试！")
        }
        onReceived: {
            console.log(data)
        }
    }

    SilicaListView{
        id:view
        header: PageHeader{
            title: "Comments"
        }
        anchors.fill: parent
        model:commentModel
        clip: true
        delegate: ListItem{
            id:showcomments
            width: parent.width
            contentHeight:nick.height + contenId.height +suppnum.height
            menu:contextMenuComponent
            Label{
                id:nick
                text:username.length>1?username:"匿名人士"
                font.pixelSize: Theme.fontSizeSmall
                color: Theme.highlightColor
                horizontalAlignment: Text.AlignLeft
                truncationMode: TruncationMode.Elide
                width: parent.width
                anchors {
                    top:parent.top
                    left: parent.left
                    leftMargin: Theme.paddingMedium
                }
            }
            Label{
                id:date
                text:created_time
                font.pixelSize: Theme.fontSizeExtraSmall
                font.italic: true
                horizontalAlignment: Text.AlignRight
                anchors{
                    right:parent.right
                    top:parent.top
                    rightMargin: Theme.paddingMedium
                }
            }
            Label{
                id:contenId
                text:comments
                width: parent.width
                opacity:0.8
                font.pixelSize: Theme.fontSizeExtraSmall
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignLeft
                truncationMode: TruncationMode.Elide
                anchors {
                    top:nick.bottom
                    left: parent.left
                    right:parent.right
                    leftMargin: Theme.paddingMedium
                    rightMargin: Theme.paddingMedium
                }
            }
            Label{
                id:suppnum
                width: parent.width
                text:"支持("+support+")"+"  反对("+against+")"
                wrapMode: Text.WordWrap
                opacity:0.9
                horizontalAlignment: Text.AlignRight
                font.pixelSize: Theme.fontSizeExtraSmall
                anchors{
                    right:parent.right
                    bottom:parent.bottom
                    rightMargin: Theme.paddingMedium
                }

            }
            Component {
                id: contextMenuComponent
                ContextMenu {
                    id:contextMenu
                    MenuItem {
                        text: "支持"
                        onClicked: {
                            console.log("sid:"+sid+",tid:"+tid)
                            commentspy.supportagainst("support",sid,tid)
                        }
                    }
                    MenuItem {
                        text: "反对"
                        onClicked: {
                           commentspy.supportagainst("against",sid,tid)
                        }
                    }
                }
            }
            Separator {
                visible: (index>0?true:false)
                width:parent.width;
                color: Theme.highlightColor
            }

        }
        footer: Component{

            Item {
                id: loadMoreID
                visible: !progress.running
                anchors {
                    left: parent.left;
                    right: parent.right;
                }
                height: Theme.itemSizeMedium
                Row {
                    id:footItem
                    spacing: Theme.paddingLarge
                    anchors.horizontalCenter: parent.horizontalCenter
                    Button {
                        text: "上一页"
                        visible: commpage > 1
                        onClicked: {
                            commpage--;
                            clearModel();
                            commentspy.loadComment(sid,commpage);
                        }
                    }
                    Button{
                        text:"下一页"
                        visible:commentscount > 10
                        onClicked: {
                            commpage++;
                            clearModel();
                            commentspy.loadComment(sid,commpage);
                        }
                    }
                }
            }

        }
        VerticalScrollDecorator {}
    }
    Label{
        id:tip
        text:"暂无评论"
        anchors.centerIn: parent
        visible: false
    }

}
