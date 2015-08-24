#!/bin/python
import os
files = [f for f in os.listdir('.') if os.path.isfile(f)]


def search():
	for file in files:
		with open(file,'r') as f:
    			newlines = []
    			for line in f.readlines():
        			newlines.append(line.replace('run -v /etc/localtime:/etc/localtime:ro ', 'run -v /etc/localtime:/etc/localtime:ro  -v /etc/localtime:/etc/localtime:ro '))
		with open(file, 'w') as f:
	    		for line in newlines:
        			f.write(line)
