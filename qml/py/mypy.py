import sys,os
import urllib.request
import urllib.parse
import pyotherside
import json
from basedir import *

target=HOME+"/Downloads/"

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


def loadrealtime():
    url="http://www.cnbeta.com/more?type=realtime"
    return query(url)
