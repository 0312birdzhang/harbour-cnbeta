# -*- coding: utf-8 -*-

import sys,os
import urllib.request
import urllib.parse
import json
import time
import hashlib

def query(url):
    headers = ("Referer","http://www.cnbeta.com/")
    opener=urllib.request.build_opener()
    opener.addheaders=[headers]
    data = opener.open(url).read()
    return data

def getNews(page):
    url="http://www.cnbeta.com/more?type=all&page="+str(page)
    data=query(url)
    return data

def hex_md5(str):
    print(str)
    m = hashlib.md5()
    m.update(str.encode('utf-8'))
    return m.hexdigest()

def getunixtime():
	return str(int(time.time()))

def newapi():
    unixtime=getunixtime()
    #print(unixtime)
    sign = hex_md5("app_key=10000&format=json&method=Article.Lists&timestamp="+unixtime+"&v=1.0&mpuffgvbvbttn3Rc")
    #print(sign)
    url = "http://api.cnbeta.com/capi?app_key=10000&format=json&method=Article.Lists&timestamp="+unixtime+"&v=1.0&sign="+ sign
    #print(url)
    data = query(url)
    return data

def getnewscontent(sid):
	unixtime=getunixtime()
	sign = hex_md5("app_key=10000&format=json&method=Article.NewsContent&sid="+sid+"&timestamp="+unixtime+"&v=1.0&mpuffgvbvbttn3Rc")
	url="http://api.cnbeta.com/capi?app_key=10000&format=json&method=Article.NewsContent&sid="+sid+"&timestamp="+unixtime+"&v=1.0&sign="+ sign
	print(url)
	data = query(url)
	print(data)
	return data
def getnewcomment(sid):
	unixtime=getunixtime()
	sign = hex_md5("app_key=10000&format=json&method=Article.Comment&page=1&sid="+sid+"&timestamp="+unixtime+"&v=1.0&mpuffgvbvbttn3Rc")
	url="http://api.cnbeta.com/capi?app_key=10000&format=json&method=Article.Comment&page=1&sid="+sid+"&timestamp="+unixtime+"&v=1.0&sign="+sign
	print(url)
	data = query(url)
	print(data)
	return data
def postcomment(sid):
	unixtime=getunixtime()
	sign = hex_md5("app_key=10000&content=verygood&format=json&method=Article.DoCmt&op=publish&sid="+sid+"&timestamp="+unixtime+"&v=1.0&mpuffgvbvbttn3Rc")
	url="http://api.cnbeta.com/capi?app_key=10000&content=verygood&format=json&method=Article.DoCmt&op=publish&sid="+sid+"&timestamp="+unixtime+"&v=1.0&sign="+sign
	print(url)
	data = query(url)
	print(data)
def supportagainst(op,sid,tid):
	unixtime=getunixtime()
	sign = hex_md5("app_key=10000&format=json&method=Article.DoCmt&op="+op+"&sid="+sid+"&tid="+tid+"&timestamp="+unixtime+"&v=1.0&mpuffgvbvbttn3Rc")
	url="http://api.cnbeta.com/capi?app_key=10000&format=json&method=Article.DoCmt&op="+op+"&sid="+sid+"&tid="+tid+"&timestamp="+unixtime+"&v=1.0&sign="+sign
	print(url)
	data = query(url)
	print(data)
if __name__ == "__main__":
    #getnewcomment("401937")
	#postcomment("401937")
	supportagainst("against","401937","11291183")

