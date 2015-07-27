import requests
import json
import time
import sys
import re

url = 'http://zx-control-center.c.zetaops-academic-erp.internal:49153/fleet/v1/units'
unit_url = 'https://raw.githubusercontent.com/zetaops/zcloud/master/units/'
headers={'content-type':'application/json'}

def incrementUnitName(unitname):
	units = [u['name'] for u in requests.get(url).json()['units']]
	for unit in units:
		if unitname.split('@')[0] in unit:
			name = unit
	return '@'.join([unitname.split('@')[0], str(int(name.split('@')[1][0])+1) + '.service'])

def createServiceOptions(unitname):
	r = requests.get(unit_url+unitname)
	lines=r.content.split('\n')
	section = ''
	options = []
	for line in lines:
		if '[' in line:
			section = re.search('\[(.*)\]', line).group(1)
		options.append({'section':section, 'name': line.split('=')[0], 'value': '='.join(line.split('=')[1:])}) if '=' in line else True
	return options

def createUnit(unitname):
	if unitname[-1] != '@':
		raise Exception('unitname must end with @')
	newunit = {}
	newunit['name'] = incrementUnitName(unitname)
	newunit['desiredState'] = 'loaded'
	newunit['options'] = createServiceOptions(unitname)
	unitcreate = requests.put(url+'/'+newunit['name'], data=json.dumps(newunit), headers=headers)
	return unitcreate.content

if __name__ == '__main__':
	createUnit(sys.argv[1])