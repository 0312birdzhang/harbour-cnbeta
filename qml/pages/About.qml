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
Page {
    id: aboutPage
    SilicaFlickable {
        id: about
        anchors.fill: parent
        contentHeight: aboutRectangle.height

        VerticalScrollDecorator { flickable: about }

        Column {
            id: aboutRectangle
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width
            spacing: Theme.paddingSmall

            PageHeader {
                //: headline of application information page
                title: qsTr("关于")
            }

            Image {
                source: "../cover/icon.png"
                width: parent.width
                fillMode: Image.PreserveAspectFit
                horizontalAlignment: Image.AlignHCenter
            }

            Label {
                text:  "Cnbeta 0.4"
                horizontalAlignment: Text.Center
                width: parent.width - Theme.paddingLarge * 2
                anchors.horizontalCenter: parent.horizontalCenter
            }

            SectionHeader {
                //: headline for application description
                text: "描述"
            }

            Label {
                //: application description
                textFormat: Text.RichText;
                text: '<style>a:link { color: ' + Theme.highlightColor + '; }</style>此程序使用了<a href="http://cnbeta1.com/">http://cnbeta1.com/</a>'+
                      '的API,感谢Cnbeta1的开放接口<br/>'+
                      "感谢梦梦提供的桌面图标.<br/> "+
                      "如果你对本软件有什么好的想法，可以邮件联系我 Email:birdzhang@9smart.cn<br/>"
                width: parent.width - Theme.paddingLarge * 2
                anchors.horizontalCenter: parent.horizontalCenter
                wrapMode: Text.WordWrap
                font.pixelSize: Theme.fontSizeSmall
            }

            SectionHeader {
                //: headline for application licensing information
                text: qsTr("License")
            }

            Label {
                //: Copyright and license information
                text: qsTr("Copyright © by") + " 0312birzhang\n" + qsTr("License") + ": GPL v2"
                width: parent.width - Theme.paddingLarge * 2
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: Theme.fontSizeSmall
            }

            SectionHeader {
                //: headline for application project information
                text: "项目源码"
                font.pixelSize: Theme.fontSizeSmall
            }

            Label {
                textFormat: Text.RichText;
                text: "<style>a:link { color: " + Theme.highlightColor + "; }</style><a href=\"https://github.com/0312birdzhang/harbour-cnbeta\">https://github.com/0312birdzhang/harbour-cnbeta\</a>"
                width: parent.width - Theme.paddingLarge * 2
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: Theme.fontSizeTiny

                onLinkActivated: {
                    Qt.openUrlExternally(link)
                }
            }
            SectionHeader {
                //: headline for application licensing information
                text: qsTr("Changelog")
            }
            Label {
                text:"version 0.5<br/>"+
                     "1.更改首页加载消息的api，可以分页查看旧消息<br/>"+
                    "version 0.4<br/>
                        1.将设置有图无图入库，不必每次都要设置<br/>
                        2.去掉上滑菜单，添加刷新下拉菜单<br/>
                        3.微调界面<br/>"+
                        "version 0.3<br/>"+
                        "匹配其他设备分辨率"
                width: parent.width - Theme.paddingLarge * 2
                wrapMode: Text.WordWrap
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: Theme.fontSizeSmall
            }
        }
    }
}
