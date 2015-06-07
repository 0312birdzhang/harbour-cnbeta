import sys,os
import urllib.request
import urllib.parse
import pyotherside
import json
from basedir import *

target=HOME+"/Downloads/"

url="http://www.cnbeta.com/more?type=all&page=1"

headers = ("Referer","http://www.cnbeta.com/")
opener=urllib.request.build_opener()
opener.addheaders=[headers]
data = opener.open(url).read()


def getNews():
    return data


