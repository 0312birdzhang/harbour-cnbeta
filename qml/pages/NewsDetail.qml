import QtQuick 2.0
import Sailfish.Silica 1.0
import io.thp.pyotherside 1.3

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

    function parseContent(result){
        title=result.result.title;
        source=result.result.source.replace(/<a [^<>]*.*?>/g,"").replace("</a>","");;
        hometext=result.result.hometext;
        bodytext=result.result.bodytext;
        time=result.result.time;

        comments=result.result.comments;
        aid=result.result.aid;


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
            progress.running = true;
            detailpy.call('cnbeta.getnewscontent',[sid],function(result){
                //console.log("resutl:"+result);
                result= eval('(' + result + ')');
                parseContent(result);
                progress.running = false;
            })
        }

        onError: {
            showMsg("加载失败，请重试！")
            progress.visible=false;
        }


    }
    Progress{
        id:progress
        running: !PageStatus.Active
        parent:newDetail
        anchors.centerIn: parent
    }

    SilicaFlickable {
        id:view
        visible: PageStatus.Active
        PageHeader {
            id:header
            title: newDetail.title//"详情"
            _titleItem.font.pixelSize: Theme.fontSizeSmall
        }

        PullDownMenu{
            MenuItem{
                id:comment
                text:"查看评论("+comments+")"
                onClicked: pageStack.push(Qt.resolvedUrl("CommentsPage.qml"),{"sid":sid,"commentscount":comments})

            }
        }

        anchors.fill: parent
        contentHeight: detail.height

        Item{
            id:detail
            y:header.height
            width:newDetail.width
            height: detailtime.height+fromMsg.height+contentbody.height+header.height+detaileditor.height+Theme.paddingLarge*5
            Label{
                id:detailtime
                text:"稿源 : " + source + "\n发布时间 : "+time
                anchors{
                    left:parent.left
                    right:parent.right
                    margins: Theme.paddingMedium
                }
                horizontalAlignment:Text.AlignHCenter
                font.pixelSize: Theme.fontSizeExtraSmall
                truncationMode: TruncationMode.Fade
                wrapMode: Text.WordWrap
            }
            Rectangle {
                id:fromMsg_bg
                width:parent.width
                height: fromMsg.height+Theme.paddingMedium*2
                anchors{
                    top:detailtime.bottom
                    left: parent.left;
                    right: parent.right;
                    margins: Theme.paddingMedium
                }
                radius: 5;
                color: "#1affffff"
            }
            Label{
                id:fromMsg
                text:hometext.replace(/(<[\/]?strong>)|(<[\/]?p>)/g,"")
                textFormat: Text.StyledText
                font.pixelSize: Theme.fontSizeExtraSmall
                linkColor:Theme.primaryColor
                color: Theme.secondaryColor
                elide: Text.ElideMiddle
                wrapMode: Text.WordWrap
                font.letterSpacing: 2;
                anchors{
                    top:fromMsg_bg.top
                    left:fromMsg_bg.left
                    right:fromMsg_bg.right
                    topMargin: Theme.paddingMedium
                    leftMargin: Theme.paddingMedium
                    rightMargin: Theme.paddingSmall
                }
            }

            Label{
                id:contentbody
                opacity: 0.8
                textFormat: Text.RichText //openimg == 1 ? Text.RichText : Text.StyledText;
                text:(iswifi||openimg == 1) ? formathtml(bodytext).replace(/src='default.jpg' x-src/g,"src") :
                                    formathtml(bodytext);
                font.pixelSize: Theme.fontSizeExtraSmall
                wrapMode: Text.WordWrap
                linkColor:Theme.primaryColor
                font.letterSpacing: 2;
                anchors{
                    top:fromMsg.bottom
                    left:parent.left
                    right:parent.right
                    topMargin: Theme.paddingLarge
                    leftMargin: Theme.paddingMedium
                    rightMargin: Theme.paddingSmall
                    bottomMargin: Theme.paddingLarge
                }
                onLinkActivated: {
                    console.log(link)
                    var linklist=link.split(".")
                    var linktype=linklist[linklist.length -1]
                    if(linktype =="png" ||linktype =="jpg"||linktype =="jpeg"||linktype =="gif"||linktype =="ico"||linktype =="svg"){
                        //console.log(linktype)
                    }else if(linktype =="showimg"){
                        var utl=link.substring(0,link.length-8)
                        contentbody.text=contentbody.text.replace(link+"'><img src='default.jpg' x-src=\""+utl+"\"",utl+"'><img src=\""+utl+"\"")
                    }else{
                       Qt.openUrlExternally(link)
                    }
                }
            }
            Label{
                id:detaileditor
                text:"   [ 责任编辑 : " + aid + " ]"
                anchors{
                    top:contentbody.bottom
                    left:parent.left
                    right:parent.right
                    margins: Theme.paddingLarge
                }
                font.pixelSize: Theme.fontSizeExtraSmall
                truncationMode: TruncationMode.Fade
                wrapMode: Text.WordWrap
            }
        }
    }


}
