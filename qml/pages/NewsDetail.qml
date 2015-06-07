import QtQuick 2.0
import Sailfish.Silica 1.0
import "API.js" as JS
import "Setting.js" as Settings
Page{
    id:newDetail
    property string article_id
    property string newtitle
    property string date
    property string source
    //property string sourceLink
    property string intro
    property string topicId
    property string topicImage
    property string content
    property string author
    property string comment_num
    property string view_num
    property string hotlist
    property int setting: 0
    SilicaFlickable {
        id:view
        PageHeader {
            id:header
            title: "详情"
        }
        anchors.fill: parent
        Component.onCompleted: {
            JS.loadDetail(article_id);
        }
        contentHeight: detail.height
        Progress{
            id:progress
            running: !PageStatus.Active
            parent:newDetail
            anchors.centerIn: parent
        }
        Item{
            id:detail
            y:header.height
            width:newDetail.width
            height: title.height+fromMsg.height+contentID.height+header.height+Theme.fontSizeMedium
            Label{
                id:title
                text:newtitle
                anchors.margins: Theme.paddingLarge
                width:parent.width
                font.pixelSize: Theme.fontSizeMedium
                truncationMode: TruncationMode.Fade
                wrapMode: Text.WordWrap
            }
            Label{
                id:fromMsg
                text:intro
                font.pixelSize: Theme.fontSizeExtraSmall
                wrapMode: Text.WordWrap
                anchors{
                    left:parent.left
                    right:parent.right
                    top:title.bottom
                    margins: Theme.paddingMedium
                }
            }
            Label{
                id:contentID
                text:content
                textFormat: (setting === 0?Text.RichText:Text.text)
                font.pixelSize: Theme.fontSizeExtraSmall
                wrapMode: Text.WordWrap
                anchors{
                    left:parent.left
                    right:parent.right
                    top:fromMsg.bottom
                    margins: Theme.paddingMedium
                }
                onLinkActivated: {
                    var linklist=link.split(".")
                    var linktype=linklist[linklist.length -1]
                    if(linktype =="png" ||linktype =="jpg"||linktype =="jpeg"||linktype =="gif"||linktype =="ico"||linktype =="svg"){
                    }else{
                       Qt.openUrlExternally(link)
                    }
                }
            }

        }
    }
}
