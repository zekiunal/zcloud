import requests
import json
import datetime
import sys

url = 'http://zx-control-center.c.zetaops-academic-erp.internal:49153/fleet/v1/units'
headers={'content-type':'application/json'}

def getUnits():
	return requests.get(url).json()['units']

def getCurrentServiceOptions(unit):
	for i in getUnits():
		if unit in i['name']:
			return i['options']

def createUnit(unit):
	print unit, unit[-1]
	if unit[-1] != '@':
		raise Exception('unitname must end with @')
	newunit = {}
	newunit['name'] = unit + datetime.date.today().isoformat() + '.service'
	newunit['desiredState'] = 'loaded'
	newunit['options'] = getCurrentServiceOptions(unit)
	unitcreate = requests.put(url+newunit['name'], data=json.dumps(newunit), headers=headers)
	return unitcreate.content

if __name__ == '__main__':
	createUnit(sys.argv[1])