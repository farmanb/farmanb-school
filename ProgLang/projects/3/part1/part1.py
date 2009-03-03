#!/usr/bin/python
import os
import re

#Compile the RegExp(s)
javaPattern = r'.+?\.java$'
java = re.compile(javaPattern, re.IGNORECASE)

catchPattern = r'.*?(catch)\s*\((.+?)\s+'
catch = re.compile(catchPattern, re.IGNORECASE)

re_try = re.compile(r'.*?\s*try(?!\w).*?')

re_finally = re.compile(r'.*?\s*finally(?!\w).*?')

re_fileNameParser = re.compile(r'.*?(\w+)\.java$')

def totalSubDir(s):
    size = 0
    for x in os.listdir(s):
        path = os.path.join(s,x)
        if (os.path.isdir(path)):
            size += totalSubDir(path)
        elif java.match(path):
            size += os.path.getsize(os.path.abspath(path))
        else:
            continue
    return size

def getJavaFilesHelper(root, d):
    absDir = os.path.abspath(root)
    d[root] = totalSubDir(absDir)

    for x in os.listdir(absDir):
        path = os.path.join(absDir, x)
        if (os.path.isdir(path)):
            getJavaFilesHelper(path, d)
        elif java.match(path):
            d[path] = os.path.getsize(path)
        else:
            continue

def getJavaFiles(root):
    retVal = {}

    getJavaFilesHelper(root, retVal)

    return retVal

#Returns the index of a tuple in a list
def getTupleByName(l, n):
    for i in range(len(l)):
        temp = l[i][0]
        if temp == n:
            return i
    return -1

def incrementCount(tuples, name):
    i = getTupleByName(tuples, name)
    if not (i is -1):
        tuples[i] = (name, tuples[i][1]+1)
    else:
        tuples.append((name, 1))
        
def parse(line, l):
    matched = False
    m = catch.match(line)
    if m:
        matched = True
        exType = m.group(2)
        incrementCount(l, exType)
        incrementCount(l, 'catch')

    m = re_try.match(line)
    if m:
        matched = True
        incrementCount(l, 'try')

    m = re_finally.match(line)
    if m:
        matched = True
        incrementCount(l, 'finally')

    return matched 

#Scanner--Removes unneeded comments and strings before
#passing it to the parser
def scanFile(fileName, tuples):
    inString = False
    inComment = False
    commentType = ''
    retVal = {}
    line = ''
    temp = ''
    infh = open(fileName, 'r')
    while 1:
        c = infh.read(1)
        if not c:
            break

        #Catch escaped chars
        if inString and c == '\\':
            c = infh.read(1)
            c = infh.read(1)

        if (not inComment and inString) and c == '"':
            inString = False
            c = infh.read(1)
            
        #Catch string openings outside comments
        if not inComment and c == '"':
            inString = True
        
        if inString:
            continue
            
        #Catch comment openings outside comments & strings
        if (not inComment and not inString) and c == '/':
            temp = c
            c = infh.read(1)
            if c == '/':
                inComment = True
                commentType = 'single'
            elif c == '*':
                inComment = True
                commentType = 'multi'
            else:
                #Not in a comment, append the temp char
                line = line + temp

        #Catch comment closings (multi-line)
        if c == '*' and inComment:
            c = infh.read(1)
            #Multi-line comment is now closed, discard
            #both characters
            if c == '/':
                inComment = False
                continue

        #Break off the line, pass it to the parser
        if c == '\n':
            parse(line, tuples)
            line = ''
            if inComment and commentType == 'single':
                #Line ended, comment also ended
                inComment = False
            continue

        #If not part of a comment, append it to the line.
        if not inComment:
            line = line + c
        else:
            #Discard the char
            continue

def printExceptDict(d):
    for f in d.keys():
        print "%s:" % (f)
        l = d[f]
        for t in range(len(l)):
            print "\t%s: %s" % (l[t][0], l[t][1])

def findExceptHelper(root, d):
    files = getJavaFiles(root)
    for f in files.keys():
        m = re_fileNameParser.match(f)
        if m:
            name = f
            if not(d.has_key(name)):
                d[name] = []

            scanFile(f, d[name])
                
def findExcept(root):
    retVal = {}

    findExceptHelper(root, retVal)
    
    return retVal
