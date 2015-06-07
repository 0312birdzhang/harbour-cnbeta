import os,sys,shutil
import pyotherside
import subprocess
from basedir import *

cachePath=XDG_CACHE_HOME+"/harbour-9store/9store/"
savePath=HOME+"/Pictures/save/9store/"

def saveImg(basename,volname):
    try:
        realpath=cachePath+basename+".png"
        isExis()
        shutil.copy(realpath,savePath+volname)
        pyotherside.send("status","1")
    except:
        pyotherside.send("status","-1")

def isExis():
    if os.path.exists(savePath):
        pass
    else:
        os.makedirs(savePath)

"""
    缓存图片
"""
def cacheImg(url,md5name,imgtype):
    cachedFile = cachePath+md5name+"."+imgtype
    if os.path.exists(cachedFile):
        pass
    else:
        if os.path.exists(cachePath):
            pass
        else:
            os.makedirs(cachePath)
        downloadImg(cachedFile,url)
    return cachedFile

"""
    下载文件

"""
def downloadImg(downname,downurl):
    p = subprocess.Popen("curl -o "+downname+" "+downurl,shell=True)
    #0则安装成功
    retval = p.wait()

