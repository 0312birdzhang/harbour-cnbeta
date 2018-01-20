import QtQuick 2.0
import Sailfish.Silica 1.0
import io.thp.pyotherside 1.4

Page{
    id:newDetail
    property string sid
    property string catid
    property string topic
    property string aid
    property string title
    property string keywords
    property string hometext
    property string listorder
    property string comments
    property string counter
    property string collectnum
    property string good
    property string bad
    property string score
    property string ratings
    property string socre_story
    property string ratings_story
    property string pollid
    property string queueid
    property string ifcom
    property string ishome
    property string elite
    property string status
    property string inputtime
    property string updatetime
    property string thumb
    property string source
    property string data_id
    property string bodytext
    property string relation
    property string shorttitle
    property string brief
    property string time
    //onBodytextChanged: console.log(formathtml(bodytext).replace(/<img src/g,"<img src='default.jpg' x-src"))
    allowedOrientations: Orientation.Landscape | Orientation.Portrait | Orientation.LandscapeInverted

    onIsLandscapeChanged: {

    }


    function parseContent(result){
        title=result.title;
        source=result.source.replace(/<a [^<>]*.*?>/g,"").replace("</a>","");;
        hometext=result.hometext;
        bodytext=result.bodytext;
        time=result.time;
        comments=result.comments;
        aid=result.aid;


    }

    ListModel{
        id:commentModel
    }

    Python{
        id:detailpy
        Component.onCompleted: {
            addImportPath(Qt.resolvedUrl('../py'));
            detailpy.importModule('cnbeta', function () {
                 detailpy.loadDetail(sid)
             });

        }
        function loadDetail(sid){
            loading = true;
            detailpy.call('cnbeta.getnewscontent',[sid],function(result){
                //console.log("resutl:"+result);
                result= eval('(' + result + ')');
                parseContent(result.result);
                loading = false;
            })
        }

        onError: {
            showMsg("加载失败，请重试！")
            progress.visible=false;
        }


    }


    SilicaFlickable {
        id:view
        visible: PageStatus.Active


        PullDownMenu{
            MenuItem{
                id:comment
                text:"查看评论("+comments+")"
                onClicked: pageStack.push(Qt.resolvedUrl("CommentsPage.qml"),{"sid":sid,"commentscount":comments})

            }
        }

        VerticalScrollDecorator { flickable: view }
        anchors.fill: parent
        contentHeight: detail.height
        Column{
            id:detail
            spacing: Theme.paddingMedium
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width

            PageHeader {
                id:header
                title: newDetail.title//"详情"
                _titleItem.font.pixelSize: Theme.fontSizeSmall
            }

            Label{
                id:detailtime
                text:"稿源 : " + source + " 发布时间 : "+time
                anchors{
                    left:parent.left
                    right:parent.right
                    leftMargin: Theme.paddingMedium
                    rightMargin: Theme.paddingMedium
                }
                horizontalAlignment:Text.AlignHCenter
                font.pixelSize: Theme.fontSizeExtraSmall
                truncationMode: TruncationMode.Fade
                wrapMode: Text.WordWrap

            }

            Rectangle {
                id:fromMsg_bg
                width:parent.width
                height: fromMsg.height + Theme.paddingMedium*2
                anchors{
                    left: parent.left;
                    right: parent.right;
                    leftMargin: Theme.paddingMedium
                    rightMargin: Theme.paddingMedium
                }
                radius: 5;
                color: "#1affffff"
                Label{
                    id:fromMsg
                    width: parent.width
                    text:hometext.replace(/(<[\/]?strong>)|(<[\/]?p>)/g,"")
                    textFormat: Text.StyledText
                    font.pixelSize: Theme.fontSizeExtraSmall
                    linkColor:Theme.primaryColor
                    color: Theme.secondaryColor
                    elide: Text.ElideMiddle
                    wrapMode: Text.WordWrap
                    font.letterSpacing: 2;
                    anchors.centerIn: parent
                }
            }

            Label{
                id:contentbody
                opacity: 0.8
                textFormat: Text.RichText //openimg == 1 ? Text.RichText : Text.StyledText;
                text:(networkmode == 4||settings.openimg) ? formathtml(bodytext).replace(/src='default.jpg' x-src/g,"src") :
                                    formathtml(bodytext);
                font.pixelSize: Theme.fontSizeExtraSmall
                wrapMode: Text.WordWrap
                linkColor:Theme.primaryColor
                font.letterSpacing: 2;
                anchors{
                    left:parent.left
                    right:parent.right
                    leftMargin: Theme.paddingMedium
                    rightMargin: Theme.paddingMedium
                }
                onLinkActivated: {
                    var linklist=link.split(".")
                    var linktype=linklist[linklist.length -1]
                    if(linktype =="png" ||linktype =="jpg"||linktype =="jpeg"||linktype =="gif"||linktype =="ico"||linktype =="svg"){
                        //console.log(linktype)
                    }else if(linktype =="showimg"){
                        var utl=link.substring(0,link.length-8)
                        contentbody.text=contentbody.text.replace(link+"'><img src='default.jpg' x-src=\""+utl+"\"",utl+"'><img src=\""+utl+"\"")
                    }else{
                        remorse.execute("即将打开链接...",function(){
                            Qt.openUrlExternally(link);
                        },3000);
                    }
                }
            }

            Label{
                id:detaileditor
                text:"   [ 责任编辑 : " + aid + " ]"
                anchors{
                    right:parent.right
                    rightMargin: Theme.paddingMedium
                }
                font.pixelSize: Theme.fontSizeExtraSmall
                truncationMode: TruncationMode.Fade
                wrapMode: Text.WordWrap
            }
        }
    }


}
