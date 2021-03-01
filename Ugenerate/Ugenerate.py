import os
import re
import linecache
import csv
import numpy as np
import sys

#transfer ref
fileData = ""
f = open ('ref', 'r')
print "file name is ", f.name
lines = f.readlines()
for line in lines:
	line = line.strip() 
	line = "(" + line + ")\n"
	line = line.replace(',', ' ')
	print line
	fileData += line
f = open ('ref_of_format', 'w')
f.write(fileData)
f.close()
#transfer R
fileData = ""
f = open ('R', 'r')
print "file name is ", f.name
lines = f.readlines()
for line in lines:
	line = line.strip() 
	line = "(" + line + ")\n"
	line = line.replace(',', ' ')
	print line
	fileData += line	
f = open ('R_of_format', 'w')
f.write(fileData)	
f.close()
	

ref = ""
refFile = open ('ref_of_format', 'r')
lines = refFile.readlines()
for line in lines:
	ref += line

L = ""
Lfile = open ('L', 'r')
lines = Lfile.readlines()
for line in lines:
	L += line

R = ""
Rfile = open ('R_of_format', 'r')
lines = Rfile.readlines()
for line in lines:
	R += line

temp = ""
f = open ('Ux', 'r')
lines = f.readlines()
for line in lines:
	temp += line
	if line == "//L\n":
		temp += L
	if line == "//R\n":
		temp += R
	if line == "//ref\n":
		temp += ref

f = open ('U', 'w')
f.write(temp)
f.close()
	
