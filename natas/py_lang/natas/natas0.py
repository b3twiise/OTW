#!/usr/bin/env python
from driver import *

req = makeGetConnection()
passw = retrievePassword(req)
nextLlv = int(sys.argv[1]) + 1
with open( ("natas" + str(nextLlv) +".pass") , "w")as f:
	f.write(passw + "\n")
print "The password for natas" + str(nextLlv) + " is: " + passw