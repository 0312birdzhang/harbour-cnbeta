Qt.include("md5.js")
var api = "http://api.cnbeta.com/capi?"
//获取首页新闻
function loadNews() {
    progress.visible=true;
    newlistModel.clear();
    var xhr = new XMLHttpRequest();
    var unixtime =getunixtime();
    var url="app_key=10000&format=json&method=Article.Lists&timestamp="+unixtime+"&v=1.0"
    url=api+url+getsign(url)
    xhr.open("GET",url,true);
    xhr.setRequestHeader("Referer","http://www.cnbeta.com");
    xhr.onreadystatechange = function()
    {
        if ( xhr.readyState == xhr.DONE){
            if ( xhr.status == 200){
                var jsonObject = eval('(' + xhr.responseText + ')');
                for ( var i in jsonObject.result.list){
                    newlistModel.append({
                                            "topic":jsonObject.result.list[i].topic,
                                            "sid":jsonObject.result.list[i].sid,
                                            "title":jsonObject.result.list[i].title,
                                            "date":jsonObject.result.list[i].pubtime,
                                            "intro":jsonObject.result.list[i].summary,


                                        });

                               }
                //showNews.fromArticleID = jsonObject[(newlistModel.count-1)].article_id
                progress.visible=false
                if(newlistModel.count>3){

                }else if( newlistModel.count==0 ){

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
function getunixtime(){
    var unixtime = ""+(new Date()).valueOf();
    return unixtime=unixtime.substring(0,unixtime.length-3)
}

function getsign(url){
    return "&sign="+hex_md5(url+"&mpuffgvbvbttn3Rc")
}
