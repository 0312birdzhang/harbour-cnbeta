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
    id: aboutPopup
    width: parent.width - 42
    height: parent.height
    PageHeader {
        id: header
        title: "关于 "
    }

    Column{

        Row {
            id: title
            width: parent.width
            x:200
            y: header.height
            Text { text: "C"; color: "#FEBA02"; font.pixelSize: 50 }
            Text { text: "n"; color: "#028CBB"; font.pixelSize: 50 }
            Text { text: "b"; color: "#ea2c81"; font.pixelSize: 50 }
            Text { text: "e"; color: "#c0bc01"; font.pixelSize: 50 }
            Text { text: "t"; color: "#76a1d6"; font.pixelSize: 50 }
            Text { text: "a"; color: "#d491c5"; font.pixelSize: 50 }
        }
    }
    Item {
        id: aboutInfos
        property string version:'0.2'
        property string text:
            '<style>a:link { color: ' + Theme.primaryColor  + '; }</style>' +
            '<br>' +
            '<br><br>此程序使用了<a href="http://cnbeta1.com/"><b>http://cnbeta1.com/</b></a>' +
            '<br>的开放API,感谢Cnbeta1的开放接口.' +
            '<br><br>© copyleft by 0312birdzhang.' +
            '<br>源码地址 :' +
            '<br><a href="https://github.com/0312birdzhang/harbour-cnbeta"><b>https://github.com/0312birdzhang/harbour-cnbeta</b></a>'
    }

    SilicaFlickable {
        id: aboutFlick
        anchors.fill: parent
        contentHeight: contentItem.childrenRect.height
        contentWidth: aboutFlick.width

        Column {
            id: aboutColumn
            anchors {
                left: parent.left
                right: parent.right
                margins: Theme.paddingMedium
            }
            y:header.height+title.height
            spacing: Theme.paddingMedium

            Item {
                width: 1
                height: Theme.paddingMedium
            }
            Label {
                id: content
                text: aboutInfos.text
                width: aboutFlick.width-20
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter;
                font.pixelSize: Theme.fontSizeSmall
                textFormat: Text.RichText
                anchors {
                    left: parent.left
                    right: parent.right
                    margins: Theme.paddingMedium
                }
                onLinkActivated: {
                    Qt.openUrlExternally(link)
                }
            }
        }
        VerticalScrollDecorator { flickable: aboutFlick }
    }
}
