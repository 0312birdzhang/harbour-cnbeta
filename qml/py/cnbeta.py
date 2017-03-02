
import sys,os
import urllib.request
import urllib.parse
import json
import time
import hashlib
#import pyotherside


api = "http://api.cnbeta.com/capi?"

def query(url):
    headers = ("Referer","http://www.cnbeta.com/")
    data="""{"state":"error","message":"","result":[]}"""
    try:
        opener=urllib.request.build_opener()
        opener.addheaders=[headers]
        data = opener.open(url).read()
    except urllib.error.HTTPError as e:
        print("error:",e)
        pass
    return data


def getsign(url):
    m = hashlib.md5()
    m.update(url.encode('utf-8'))
    return "&sign="+str(m.hexdigest())

def getunixtime():
        return str(int(time.time()))

def getnewslist():
    unixtime=getunixtime()
    url="app_key=10000&format=json&method=Article.Lists&timestamp="+unixtime+"&v=1.0&mpuffgvbvbttn3Rc"
    url=api+url+getsign(url)
    data = query(url)
    return data


def loadrealtime(nextsid):
    url="http://www.cnbeta.com/more?type=realtime&sid="+str(nextsid)
    data=query(url)
    return data

def getnewscontent(sid):
    unixtime=getunixtime()
    url="app_key=10000&format=json&method=Article.NewsContent&sid="+str(sid)+"&timestamp="+unixtime+"&v=1.0&mpuffgvbvbttn3Rc"
#     print("url",url)
    url=api+url+getsign(url)
    #print(url)
    data = query(url)
    return data

def getnewscomment(sid,commpage):
    unixtime=getunixtime()
    url="app_key=10000&format=json&method=Article.Comment&page="+str(commpage)+"&sid="+str(sid)+"&timestamp="+unixtime+"&v=1.0&mpuffgvbvbttn3Rc"
    url=api+url+getsign(url)
    data = query(url)
    #print(data)
    return data


def postcomment(sid,comment):
    unixtime=getunixtime()
    url="app_key=10000&content="+comment+"&format=json&method=Article.DoCmt&op=publish&sid="+str(sid)+"&timestamp="+unixtime+"&v=1.0&mpuffgvbvbttn3Rc"
    url=api+url+getsign(url)
    #print(url)
    data = query(url)
    return data
    #against/support,sid,tid

def supportagainst(op,sid,tid):
    unixtime=getunixtime()
    url="app_key=10000&format=json&method=Article.DoCmt&op="+op+"&sid="+str(sid)+"&tid="+str(tid)+"&timestamp="+unixtime+"&v=1.0&mpuffgvbvbttn3Rc"
    url=api+url+getsign(url)
    #pyotherside.send(url)
    #print(url)
    data = query(url)
    return data

def queryNext(start_sid,topicid):
    unixtime=getunixtime()
    #app_key=10000&format=json&method=Article.Lists&start_sid=" +
                #startSid + "&timestamp=" + timestamp +
                #"&topicid=" + topicId + "&v=1.0&mpuffgvbvbttn3Rc"
    url="app_key=10000&format=json&method=Article.Lists&start_sid="+str(start_sid)+"&timestamp="+unixtime+"&v=1.0&mpuffgvbvbttn3Rc"
    url=api+url+getsign(url)
    data = query(url)
    return data


def queryBefore(end_sid,topicid):
    unixtime=getunixtime()
    #app_key=10000&format=json&method=Article.Lists&start_sid=" +
                #startSid + "&timestamp=" + timestamp +
                #"&topicid=" + topicId + "&v=1.0&mpuffgvbvbttn3Rc"
    url="app_key=10000&end_sid="+str(end_sid)+"&format=json&method=Article.Lists&timestamp="+unixtime+"&v=1.0&mpuffgvbvbttn3Rc"
    url=api+url+getsign(url)
    data = query(url)
    return data

if __name__ == "__main__":
#     pprint(json.loads(getnewslist().decode()))
#     pprint(postcomment(589003,"MY comments"))
#     print(json.loads(getnewscomment(589003,1).decode()))
#     pprint(json.loads(queryBefore(588995,243).decode()))
    print(json.loads(queryBefore(589081,318).decode()).get("result"))
