#!/usr/bin/env python

import datetime
import re
import sys

from pprint import pprint as PP

headers = []
line = sys.stdin.readline()
while line and line not in ('\n', '\r\n'):
    if line.endswith('\r\n') or line.endswith('\n'):
        line = line.rstrip('\r\n')

    if re.match('^\s+', line):
        headers[-1] += line
    else:
        headers.append(line)
    line = sys.stdin.readline()

path = []

for header in headers:
    match = re.match('delivered-to: (.+)', header, re.I)
    if match:
        path.insert(0, "  <<< Delivered to: %s >>> " % match.group(1))
        continue

    match = re.match('received: ', header, re.I)
    if match:
        m1        = re.search('from (\S+)', header, re.I)
        smtp_from = None if m1 is None else m1.group(1)

        m2      = re.search('by (\S+)', header, re.I)
        smtp_to = None if m2 is None else m2.group(1)

        m3      = re.search(';\s*(.+) [+-].*$', header, re.I)
        datestr = None if m3 is None else m3.group(1)
        date0 = datetime.datetime.strptime(datestr, '%a, %d %b %Y %H:%M:%S')
        path.insert(0, (smtp_from or '', smtp_to, date0.strftime('%Y-%m-%d %H:%M:%S')))

widths = (1,1)
for hop in path:
    if type(hop) == tuple:
        if hop[0] and len(hop[0]) > widths[0]:
            widths = (len(hop[0]), widths[1])
        if hop[1] and len(hop[1]) > widths[1]:
            widths = (widths[0], len(hop[1]))

format = "%%-%ds  %%-%ds  %%-19s" % widths

print format % ('From', 'To', 'Date (local)')
print format % ('====', '==', '============')
for hop in path:
    if type(hop) == tuple:
        print format % hop
    elif type(hop) == str:
        print hop
    else:
        PP(hop)
        sys.exit()
