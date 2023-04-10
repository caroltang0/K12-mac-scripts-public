#!/usr/bin/python

import os
import platform
from docklib import Dock

appsToRemove= [ 
    'Safari',
    'Music',
    'Podcasts',
    'TV',
    'Maps',
    'App Store',
    'Siri',
    'Contacts',
]
    
appToAdd = [
    '/System/Applications/Launchpad.app',
    '/Applications/Google Chrome.app',
    '/Applications/Managed Software Center.app',    
]

dock = Dock()


for item in appsToRemove: 
    if dock.findExistingEntry(item, section='persistent-apps') > -1:
        dock.removeDockEntry(item)
        
dock.items['persistent-apps'] = []        
for item in appToAdd:
    if dock.findExistingEntry(item, section='persistent-apps') == -1:
        item = dock.makeDockEntry(item)
        dock.items['persistent-apps'].append(item)
        
if dock.findExistingLabel('Clever Dashboard', section='persistent-others') == -1:
    # Add Clever link below
    # item = dock.makeDockOtherURLEntry('', label='Clever Dashboard')
    dock.items['persistent-others'] = [item] + dock.items['persistent-others']
    
docksave()    
        