import os
import re
import linecache
import csv
import numpy as np
import sys

#f=os.listdir(os.getcwd()) 
#print f   
#def is_fuelnode(x):
#    return x.split('_',2)[0] == 'fuelnode'
#f = filter(is_fuelnode, f)
fileData = "x,y,z\n"
f = open ('fuelnode', 'r')
print "file name is ", f.name
lines = f.readlines()
for line in lines:
	line = line.replace(' ', ',')
	line = line.replace(')', '')
	line = line.replace('(', '')	
	print line
	fileData += line
	
f = open ('fuelnode', 'w')
f.write(fileData)

	
f.close()
	
