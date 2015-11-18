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
import Sailfish.Silica 1.0
import io.thp.pyotherside 1.3

Page{
    id:showNews

    property int operationType: PageStackAction.Animated
    property int fromArticleID
    property int page:1
    allowedOrientations: Orientation.Landscape | Orientation.Portrait | Orientation.LandscapeInverted

    Progress{
        id:progress
        parent:showNews
        anchors.centerIn: parent
    }

    ListModel {
        id:newlistModel
    }
    ListModel{
        id:tmpModel
    }

    function clearModel(){
        newlistModel.clear();

    }

    function appModel(result){
        for ( var i in result.result.list){
            newlistModel.append({
                                    "id":result.result.list[i].sid,
                                    "article_id":result.result.list[i].sid,
                                    "title":result.result.list[i].title,
                                    "date":result.result.list[i].inputtime,
                                    "intro":result.result.list[i].hometext,
                                    "comments":result.result.list[i].comments,//评论数
                                    "counter":result.result.list[i].counter,//浏览数
                                    "score":result.result.list[i].score,//文章分
                                    "score_story":result.result.list[i].score_story//事件分
                                });

                       }
    }
    function insertModel(querydata){
        for ( var i in querydata.result){
            console.log("refresh:"+querydata.result[i].title);
            newlistModel.insert(0,{
                                    "id":querydata.result[i].sid,
                                    "article_id":querydata.result[i].sid,
                                    "title":querydata.result[i].title,
                                    "date":querydata.result[i].inputtime,
                                    "intro":querydata.result[i].hometext,
                                    "comments":querydata.result[i].comments,//评论数
                                    "counter":querydata.result[i].counter,//浏览数
                                    "score":querydata.result[i].score,//文章分
                                    "score_story":querydata.result[i].score_story//事件分
                                });
        }
    }

    Python{
        id:py
        Component.onCompleted: {
            addImportPath(Qt.resolvedUrl('../py'));
            py.importModule('mypy', function () {
                py.loadNews(page);
             });

        }
        function loadNews(page){
            progress.running = true;
            //timer.start()
            py.call('mypy.getNews',[page],function(result){
                //console.log("resutl:"+result);
                result= eval('(' + result + ')');
                appModel(result);
                progress.running = false;
                timer.stop()
            });
        }
//        function netOkorFail(){
//            py.call('mypy.netOkorFail',[],function(result){
//                    if(!result){
//                        return "未连接到互联网！"
//                    }
//                })
//        }

        onError: {
            //showMsg("加载失败，请刷新重试！")
            progress.visible=false;
        }

    }
    Python{
        id:repy
        Component.onCompleted: {
            addImportPath(Qt.resolvedUrl('../py'));
            repy.importModule('mypy', function () {
             });
        }
        function querytime(nextsid){
             progress.running = true;
            repy.call('mypy.queryreal',[nextsid],function(result){
            })
        }

        onReceived: {
            var querydata = eval('(' + data + ')');
            var befcount = newlistModel.count;
            insertModel(querydata);
            //newlistModel = newlistModel.revert();
            progress.running = false
            var aftcount = newlistModel.count;
            showMsg((parseInt(aftcount)-parseInt(befcount))+" 条新资讯")
        }
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
                text:"关于&设置"

                onClicked:pageStack.push(Qt.resolvedUrl("About.qml"));
            }
//            MenuItem{
//                text: openimg == 1 ? "切换到省流量模式" : "切换到有图模式"
//                onClicked: updateSetting()
//            }
            MenuItem{
                text:"加载最新"
                enabled: page == 1
                onClicked: {
                    console.log(newlistModel.count)
                    if(newlistModel.count > 0){
                        var nextsid=newlistModel.get(0).article_id;
                        repy.querytime(nextsid);
                    }else{
                        py.loadNews(page)
                    }
                }
            }
        }
        PushUpMenu{
            id:pushUp

            MenuItem{
                text:"返回顶部"
                onClicked: view.scrollToTop()
            }

        }

        clip: true
        model : newlistModel
        //spacing:Theme.paddingMedium
        delegate:
            BackgroundItem{
            id:showlist
            height:titleid.height+timeid.height+summaryid.height+Theme.paddingMedium*4
            width: parent.width
            Label{
                id:titleid
                text:title
                font.pixelSize: Theme.fontSizeSmall
                truncationMode: TruncationMode.Fade
                wrapMode: Text.WordWrap
                color: Theme.highlightColor
                font.bold:true;
                anchors {
                    top:parent.top;
                    left: parent.left
                    right: parent.right
                    topMargin: Theme.paddingMedium
                    leftMargin: Theme.paddingMedium
                    rightMargin: Theme.paddingMedium
                }
            }

            Label{
                id:summaryid
                text:intro.replace(/(<[\/]?strong>)|(<[\/]?p>)/g,"")
                textFormat: Text.StyledText
                font.pixelSize: Theme.fontSizeExtraSmall
                wrapMode: Text.WordWrap
                linkColor:Theme.primaryColor
                maximumLineCount: 6
                anchors {
                    top: titleid.bottom
                    left: parent.left
                    right: parent.right
                    topMargin: Theme.paddingMedium
                    leftMargin: Theme.paddingMedium
                    rightMargin: Theme.paddingMedium
                }
            }
            Label{
                id:timeid
                text:"文章分 : "+score+" 分 / 事件分: "+score_story+" 分"//"发布时间 : "+date
                //opacity: 0.7
                font.pixelSize: Theme.fontSizeTiny
                //font.italic: true
                color: Theme.secondaryColor
                //horizontalAlignment: Text.AlignRight
                anchors {
                    top:summaryid.bottom
                    left: parent.left
                    topMargin: Theme.paddingMedium
                    leftMargin: Theme.paddingMedium
                }
            }
            Label{
                id:viewcount
                text:"评论 : "+comments+" / 浏览 : "+counter
                //opacity: 0.7
                font.pixelSize: Theme.fontSizeTiny
                //font.italic: true
                color: Theme.secondaryColor
                //horizontalAlignment: Text.AlignRight
                anchors {
                    top:summaryid.bottom
                    right: parent.right
                    topMargin: Theme.paddingMedium
                    rightMargin: Theme.paddingMedium
                }
            }
            Separator {
                visible:(index > 0?true:false)
                width:parent.width;
                //alignment:Qt.AlignHCenter
                color: Theme.highlightColor
            }
            onClicked: {
                pageStack.push(Qt.resolvedUrl("NewsDetail.qml"),{
                                   "sid":article_id,
                                   "comments":comments
                               });
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
                        visible: page > 1
                        onClicked: {
                            page--;
                            clearModel();
                            py.loadNews(page);
                        }
                    }
                    Button{
                        text:"下一页"
                        onClicked: {
                            page++;
                            clearModel();
                            py.loadNews(page);
                        }
                    }
                }
            }

        }

        VerticalScrollDecorator {flickable: view}

        ViewPlaceholder {
            enabled: view.count == 0 && !PageStatus.Active
            text: "无结果，点击重试"
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    py.loadNews(page)
                }
            }
        }

    }



//    Timer{
//        id:timer
//        interval: 1500; running: true; repeat: false
//        onTriggered: view.count = 0
//    }
}
