//获取首页新闻
function loadNews() {
    progress.visible=true;
    var xhr = new XMLHttpRequest();
    var url="http://cnbeta1.com/api/getArticles"
    xhr.open("GET",url,true);
    xhr.onreadystatechange = function()
    {
        if ( xhr.readyState == xhr.DONE)
        {
            if ( xhr.status == 200)
            {
                var jsonObject = eval('(' + xhr.responseText + ')');
                for ( var i in jsonObject  )
                {
                    newlistModel.append({
                                            "id":jsonObject[i].id,
                                            "article_id":jsonObject[i].article_id,
                                            "title":jsonObject[i].title,
                                            "date":jsonObject[i].date,
                                            "intro":jsonObject[i].intro,
                                            "topic":jsonObject[i].topic

                                        });

                }
                showNews.fromArticleID = jsonObject[(newlistModel.count-1)].article_id
                progress.visible=false
                if(newlistModel.count>3){
                    showNews.display = true;
                }else if( newlistModel.count==0 ){
                    showNews.display = false;
                    header.title="无结果"
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
    progress.visible=true;
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
    progress.visible=false;

}

//获取更多新闻

function loadMore(fromArticleID)
{
    progress.visible=true;
    var xhr = new XMLHttpRequest();
    var url="http://cnbeta1.com/api/getMoreArticles/"+fromArticleID;
    xhr.open("GET",url,true);
    xhr.onreadystatechange = function()
    {
        if ( xhr.readyState == xhr.DONE)
        {
            if ( xhr.status == 200)
            {
                var jsonObject = eval('(' + xhr.responseText + ')');
                for ( var i in jsonObject  )
                {
                    newlistModel.append({
                                            "id":jsonObject[i].id,
                                            "article_id":jsonObject[i].article_id,
                                            "title":jsonObject[i].title,
                                            "date":jsonObject[i].date,
                                            "intro":jsonObject[i].intro,
                                            "topic":jsonObject[i].topic

                                        });

                }

                progress.visible=false
                if(newlistModel.count>3){
                    showNews.display = true;
                }else if( newlistModel.count==0 ){
                    showNews.display = false;
                    header.title="无结果"
                }
                else{
                    showNews.display = false;
                }
            }
        }
    }

    xhr.send();

}
