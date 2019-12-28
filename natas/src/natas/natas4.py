#!/usr/bin/env python
from driver import *


req=makeGetConnection(headers={"referer":"http://natas5.natas.labs.overthewire.org/"})
print req
# <nips>
# Access disallowed. You are visiting from "" while authorized users should come only from "http://natas5.natas.labs.overthewire.org/"
# </snips>

passw = retrievePassword(req)

nextLlv = int(sys.argv[1]) + 1
with open( ("natas" + str(nextLlv) +".pass") , "w")as f:
	f.write(passw + "\n")
print "The password for natas" + str(nextLlv) + " is: " + passw