#!/usr/bin/python
import os
import re
import  urllib2

addyPattern = r'.*?<a href="(.*?)".*'
addy = re.compile(addyPattern, re.IGNORECASE)

addyTypePattern = '^(?:.*?)/(\w+)\.(.*?)\.(\w+)/'
addyType = re.compile(addyTypePattern)

trailingSlashPattern = '/$'
trailingSlash = re.compile(trailingSlashPattern)

def incrementCount(d, name):
    if d.has_key(name):
        d[name] += 1
    else:
        d[name] = 1

def freqURLs(url):
    retVal = {}
    baseUrl = ''

    m = trailingSlash.match(baseUrl)
    if not m:
        url = url + '/'
    
    m = addyType.match(url)
    if m:
        baseUrl = m.group(1) + '.' + m.group(2) + '.' + m.group(3)
        
    infh = urllib2.urlopen(url)

    while 1:
        line = infh.readline()
        if not line:
            break
        
        m = addy.match(line)
        if m:
            a = m.group(1)
            z = trailingSlash.match(a)
            
            if not z:
                a = a + '/'
                
            n = addyType.match(a)
            if n:
                concat = n.group(1) + '.' + n.group(2) + '.' + n.group(3)
                incrementCount(retVal, concat)
            else:
                incrementCount(retVal, baseUrl)
                
    return retVal

def printURLs(dictionary):
    for key in dictionary.keys():
        print key + str(dictionary[key])

printURLs(freqURLs('http://www.cs.rpi.edu'))
        
