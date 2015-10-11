
import sys,os
import urllib.request
import urllib.parse
import json
import time
import hashlib
import pyotherside

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
    url=url+"&mpuffgvbvbttn3Rc"
    m.update(url.encode('utf-8'))
    return "&sign="+str(m.hexdigest())

def getunixtime():
        return str(int(time.time()))

def getnewslist():
    unixtime=getunixtime()
    url="app_key=10000&format=json&method=Article.Lists&timestamp="+unixtime+"&v=1.0"
    url=api+url+getsign(url)
    data = query(url)
    return data


def loadrealtime(nextsid):
    url="http://www.cnbeta.com/more?type=realtime&sid="+str(nextsid)
    data=query(url)
    return data

def getnewscontent(sid):
    unixtime=getunixtime()
    url="app_key=10000&format=json&method=Article.NewsContent&sid="+str(sid)+"&timestamp="+unixtime+"&v=1.0"
    print("url",url)
    url=api+url+getsign(url)
    #print(url)
    data = query(url)
    return data

def getnewscomment(sid,commpage):
    unixtime=getunixtime()
    url="app_key=10000&format=json&method=Article.Comment&page="+str(commpage)+"&sid="+str(sid)+"&timestamp="+unixtime+"&v=1.0"
    url=api+url+getsign(url)
    data = query(url)
    #print(data)
    return data


def postcomment(sid,comment):
    unixtime=getunixtime()
    url="app_key=10000&content="+comment+"&format=json&method=Article.DoCmt&op=publish&sid="+sid+"&timestamp="+unixtime+"&v=1.0"
    url=api+url+getsign(url)
    #print(url)
    data = query(url)
    return data
    #against/support,sid,tid

def supportagainst(op,sid,tid):
    unixtime=getunixtime()
    url="app_key=10000&format=json&method=Article.DoCmt&op="+op+"&sid="+str(sid)+"&tid="+str(tid)+"&timestamp="+unixtime+"&v=1.0"
    url=api+url+getsign(url)
    #pyotherside.send(url)
    #print(url)
    data = query(url)
    return data
