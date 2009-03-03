#!/usr/bin/python
import os

def printProjects(dictionary):
    for key in  dictionary.keys():
        print key + ':'
        for i in dictionary[key]:
            print '\t' + i

def findProjectsHelper(root,studentIds, d):
    projDirs = []
    absDir = os.path.abspath(root)
    for x in os.listdir(absDir):
        path = os.path.join(absDir, x)
        if os.path.isdir(path):
            projDirs.append(path)
            
    for sId in studentIds:
        temp = []
        for Dir in projDirs:
            sDir = os.path.join(Dir, sId)
            if not os.path.isdir(sDir):
                continue
            for x in os.listdir(sDir):
                submitted = os.path.join(sDir, x)
                temp.append(submitted)
        d[sId] = temp
        
def findProjects(root, studentIds):
    retVal = {}

    findProjectsHelper(root, studentIds, retVal)

    return retVal
