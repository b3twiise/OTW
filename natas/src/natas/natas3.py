#!/usr/bin/env python
from driver import *

req = makeGetConnection()
print req

# There is nothing on this page
# <!-- No more information leaks!! Not even Google will find it this time... -->

# This confidence must be inspired by robots.txt

req = makeGetConnection("/robots.txt/")
#print req.text

# User-agent: *
# Disallow: /s3cr3t/

# Now we know what to do


req = makeGetConnection("/s3cr3t/")
#print req.text

# sinps..
# td><a href="/">Parent Directory</a></td><td>&nbsp;</td><td align="right">  - </td><td>&nbsp;</td></tr>
# <tr><td valign="top"><img src="/icons/text.gif" alt="[TXT]"></td><td><a href="users.txt">use
# sinps

req = makeGetConnection("/s3cr3t/users.txt")


passw = retrievePassword(req.text)
nextLlv = int(sys.argv[1]) + 1
with open( ("natas" + str(nextLlv) +".pass") , "w")as f:
	f.write(passw + "\n")
print "The password for natas" + str(nextLlv) + " is: " + passw

