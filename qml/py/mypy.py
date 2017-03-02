import sys,os
import urllib.request
import urllib.parse
import pyotherside
import json
from basedir import *
import subprocess

target=HOME+"/Downloads/"

def query(url):
    headers = ("Referer","http://www.cnbeta.com/")
    data="""{"state":"error","message":"","result":[]}"""
    try:
        opener=urllib.request.build_opener()
        opener.addheaders=[headers]
        data = opener.open(url).read()
    except urllib.error.HTTPError as e:
        pass
    #print(data)
    return data
def queryreal(nextsid):
    print(nextsid)
    url="http://www.cnbeta.com/more?type=realtime&sid="+str(nextsid)
    print(url)
    data=query(url)
    pyotherside.send(data)
    #return data

def getNews(page):
    url="http://www.cnbeta.com/home/more?type=all&page="+str(page)
    data=query(url)
    #print(data)
    return data

def netOkorFail():
    fnull = open(os.devnull, 'w')
    result=subprocess.call('ping 223.5.5.5',shell=True,stdout=fnull,stderr=fnull)
    if result:
        return False
    else:
        return True
    fnull.close()

def get_ip_address(ifname=b"wlan0"):
    import socket
    import fcntl
    import struct
    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        return socket.inet_ntoa(fcntl.ioctl(
            s.fileno(),
            0x8915, # SIOCGIFADDR
            struct.pack(b'256s', ifname[:15])
        )[20:24])
    except:
        #return "You may not connected to wifi"
        return False
