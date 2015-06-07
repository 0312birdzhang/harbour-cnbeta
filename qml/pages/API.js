Qt.include("md5.js")
//获取首页新闻
function loadNews() {
    progress.visible=true;
    newlistModel.clear();
    var xhr = new XMLHttpRequest();
    var unixtime = (new Date()).valueOf();
    var sign = hex_md5("app_key=10000&format=json&method=&timestamp=&"+unixtime+"&v=1.0&mpuffgvbvbttn3Rc");
    var url="http://www.cnbeta.com/more?type=all&page=1"
    //var url = "http://api.cnbeta.com/capi?app_key=10000&format=json&method=Article.Lists&timestamp="+unixtime+"&v=1.0&sign="+sign;
    var params="&type=realtime"

    xhr.open("GET",url,true);
    xhr.setRequestHeader("Referer","http://www.cnbeta.com");
    xhr.onreadystatechange = function()
    {
        if ( xhr.readyState == xhr.DONE){
            if ( xhr.status == 200){
                var jsonObject = eval('(' + xhr.responseText + ')');
                console.log("type"+jsonObject.result.status)
                console.log("jsonObject:"+jsonObject.result.list)
                for ( var i in jsonObject.result.list){
                    console.log("get contents:"+jsonObject.result.list[i].title);
                    newlistModel.append({
                                            "topic":jsonObject.result.list[i].topic,
                                            "article_id":jsonObject.result.list[i].sid,
                                            "title":jsonObject.result.list[i].title,
                                            "date":jsonObject.result.list[i].inputtime,
                                            "intro":jsonObject.result.list[i].hometext,
                                            //"topic":jsonObject.result.list[i].topic

                                        });

                               }
                //showNews.fromArticleID = jsonObject[(newlistModel.count-1)].article_id
                progress.visible=false
                if(newlistModel.count>3){
                    showNews.display = true;
                }else if( newlistModel.count==0 ){
                    showNews.display = false;
                    //header.title="无结果"
                }
                else{
                    showNews.display = false;
                }
            }
        }
    }

    xhr.send();


}


//获取新闻详情
function loadDetail(article_id)
{

    var xhr = new XMLHttpRequest();
    var url="http://cnbeta1.com/api/getArticleDetail/"+article_id;
    xhr.open("GET",url,true);
    xhr.onreadystatechange = function()
    {
        if ( xhr.readyState == xhr.DONE)
        {
            if ( xhr.status == 200)
            {
                var jsonObject = eval('(' + xhr.responseText + ')');
                //console.log("Title:"+jsonObject.title);
                newtitle=jsonObject.title;
                date=jsonObject.date;
                //source=jsonObject.source;
                //sourceLink=jsonObject.sourceLink;
                intro=jsonObject.intro;
                topicId=jsonObject.topicId;
                topicImage=jsonObject.topicImage;
                content=jsonObject.content;
                author=jsonObject.author;
                comment_num=jsonObject.comment_num;
                view_num=jsonObject.view_num;


            }
        }
    }

    xhr.send();
}

