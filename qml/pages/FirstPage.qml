/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/
import QtQuick 2.0
import "API.js" as JS
import Sailfish.Silica 1.0
import "Setting.js" as Settings
Page{
    id:showNews

    property int operationType: PageStackAction.Animated
    property int fromArticleID
    property bool display:false
    property int setting
    Component.onCompleted: {
        Settings.initialize();
        Settings.getSetting();
        JS.loadNews();
    }
    Progress{
        id:progress
        parent:showNews
        anchors.centerIn: parent
    }

    ListModel {
        id:newlistModel
    }


    SilicaListView {
        id:view
        header: PageHeader {
            id:header
            title: qsTr("Cnbeta")
        }
        anchors.fill: parent
        PullDownMenu{
            MenuItem{
                text:"关于"
                onClicked:   pageStack.push(Qt.resolvedUrl("About.qml"));
            }
            MenuItem{
                text:(setting ===0?"无图模式":"有图模式" )
                onClicked :{
                    Settings.setPic(setting);
                }
            }
            MenuItem{
                text:"刷新"
                onClicked: JS.loadNews();
            }
        }
        PushUpMenu{
            id:pushUp
//            MenuItem{
//                id:loadMoreID
//                visible:display
//                text:"加载更多..."
//                onClicked: JS.loadMore(fromArticleID);
//            }
            MenuItem{
                text:"返回顶部"
                onClicked: view.scrollToTop()
            }

        }

        clip: true
        model : newlistModel
        //contentHeight: childrenRect.height
        delegate:
            BackgroundItem{
            id:showlist
            height:titleid.height+timeid.height+summaryid.height
            width: parent.width
            Label{
                id:titleid
                text:"<br/>"+title
                font.pixelSize: Theme.fontSizeMedium
                truncationMode: TruncationMode.Fade
                wrapMode: Text.WordWrap
                anchors {
                    left: parent.left
                    right: parent.right
                    leftMargin: Theme.paddingSmall
                }
            }
            Label{
                id:timeid
                text:"<font size='1' >发布时间 : "+date+"</font>"
                font.pixelSize: Theme.fontSizeExtraSmall * 4 / 3
                font.italic: true
                //horizontalAlignment: Text.AlignRight
                anchors {
                    top:titleid.bottom
                    left: parent.left
                    leftMargin: Theme.paddingSmall
                }
            }
            Label{
                id:summaryid
                text:"<font size='1' >"+intro+"</font><br/>"
                font.pixelSize: Theme.fontSizeExtraSmall*4/3
                wrapMode: Text.WordWrap
                anchors {
                    top: timeid.bottom
                    left: parent.left
                    right: parent.right
                    leftMargin: Theme.paddingSmall
                    rightMargin: Theme.paddingSmall
                }
            }

            Separator {
                visible:(index > 0?true:false)
                width:parent.width;
                color: Theme.highlightColor
            }
            onClicked: {
                pageStack.push(Qt.resolvedUrl("NewsDetail.qml"),{
                                   "article_id":article_id,
                                   "setting":setting
                               });
            }
        }

//        footer:  Component{

//            Item {
//                id: loadMoreID
//                anchors { left: parent.left; right: parent.right }
//                height: visible ? Theme.itemSizeMedium : 0
//                visible:display
//                signal clicked()

//                Item {
//                    id:footItem
//                    width: parent.width
//                    height: Theme.itemSizeMedium
//                    Button {
//                        anchors.centerIn: parent
//                        text: qsTr("Load More...")
//                        onClicked: {
//                            JS.loadMore(fromArticleID);
//                        }
//                    }
//                }
//            }

//        }

        VerticalScrollDecorator {flickable: view}

    }
}

