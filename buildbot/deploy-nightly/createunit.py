# Copyright (C) 2015 ZetaOps Inc.
#
# This file is licensed under the GNU General Public License v3
# (GPLv3).  See LICENSE.txt for details.

import requests
import json
import time
import sys
import re
import subprocess

url = 'http://ulakbus-control-center.zetaops.local:49153/fleet/v1/units'
unit_url = 'https://raw.githubusercontent.com/zetaops/zcloud/master/units/'
headers={'content-type':'application/json'}

oldunitscount = 0
oldunits = []

def incrementUnitName(unitname):
	#
	# @returns str (unitname with incremented number)
	#

	# get units with name from fleet api
	units = [u['name'] for u in requests.get(url).json()['units']]

	# oldunitscount is count of units with given unitname
	oldunitscount = sum(1 for i in units if unitname.split('@')[0] in i)
	sys.stdout.write('number of old units with name "%s": %s' % (unitname, oldunitscount))

	# oldunits will be destroyed after unit created and registered to haproxy
	oldunits = [i for i in units if unitname.split('@')[0] in i]
	sys.stdout.write('old units with name "%s": %s' % (unitname, oldunits))

	for unit in units:
		if unitname.split('@')[0] in unit:
			name = unit
	return '@'.join([unitname.split('@')[0], str(int(name.split('@')[1].split('.')[0])+1) + '.service'])

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

def removeOldUnits():
	for unit in oldunits:
		deleteunit = requests.delete(url+'/'+unit)
		sys.stdout.write('destroyed unit(s) result: %s' % deleteunit.content)

def createUnit(unitname):
	# if unitname[-1] != '@':
	# 	raise Exception('unitname must end with @')
	newunit = {}
	newunit['name'] = incrementUnitName(unitname)
	newunit['desiredState'] = 'launched'
	newunit['options'] = createServiceOptions(unitname)
	unitcreate = requests.put(url+'/'+newunit['name'], data=json.dumps(newunit), headers=headers)
	sys.stdout.write('created unit with name %s' % newunit['name'])
	# wait for new unit registered to haproxy
	if sys.argv[2] == "--no-delete":
		time.sleep(150)
		removeOldUnits()
		sys.stdout.write('destroyed unit(s) with name %s' % ', '.join(oldunits))

	return unitcreate.content

if __name__ == '__main__':
	createUnit(sys.argv[1])





