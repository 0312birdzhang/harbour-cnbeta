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
import "pages"
import "pages/Setting.js" as Settings
import org.nemomobile.notifications 1.0
ApplicationWindow
{

    id:appwindow
    property int openimg:-1

    Component.onCompleted: {
        Settings.initialize();
        openimg=Settings.getSetting();
    }
    Notification{
        id:notification
        appName: "CnBeta"
    }
    function updateSetting(){
        openimg=-1*openimg;
        Settings.setPic(openimg);
    }
    function formathtml(html){
       html=html.replace(/<a href=/g,"<a style='color:"+Theme.highlightColor+"' target='_blank' href=");
       html=html.replace(/<a class=/g,"<a style='color:"+Theme.highlightColor+"' target='_blank' class=");
       html=html.replace(/<p>/g,"<p style='text-indent:24px'>");
       html=html.replace(/<p style='text-indent:24px'><img/g,"<p><img");
       html=html.replace(/<p style='text-indent:24px'><a [^<>]*href=\"([^<>"]*)\".*?><img/g,"<p><a href='$1'><img");
       html=html.replace(/<img src=\"([^<>"]*)\".*?>/g,"<a href='$1.showimg'><img src=\"$1\" width="+(Screen.width-Theme.paddingMedium*2)+"/></a>");//$&</a>");
       html=html.replace(/<img src/g,"<img src='default.jpg' x-src");
//        html=html.replace(/<p><img /g,"<p style='text-indent:-10px'><img width="+Screen.width+" ");
//        html=html.replace(/<img /g,"<img style='max-width:"+Screen.width+";margin-left:-10px;' ");

        return html;
    }
    initialPage: Component {
        FirstPage { }
    }

    function showMsg(message) {
        notification.previewBody = "Cnbeta";
        notification.previewSummary = message;
        notification.close();
        notification.publish();
    }

    cover: CoverBackground {
        CoverPlaceholder{
            icon.source: "cover/icon.png"
            text:"Cnbeta"
        }
//        CoverActionList {
//            id: coverAction

//            CoverAction {
//                iconSource: "image://theme/icon-cover-refresh"
//                onTriggered:{
//                    appwindow.activate();
//                }
//            }
//        }
    }
}


