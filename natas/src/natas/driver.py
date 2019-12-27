#!/usr/bin/env python
import re
import requests
import sys
print sys.argv
def makeGetConnection(target="", referrer=""):
	if(len(sys.argv) != 3):
		print "From the driver"
		print "Usage: <sys.argv[0]> <challengenge#> < password>" 
		sys.exit(1)
	name = "natas"
	nameX = name + sys.argv[1]
	= {referrer: ""}

	r = requests.get("http://" + nameX + ".natas.labs.overthewire.org/"+ target, auth=(nameX, sys.argv[2]), {referrer=referrer})
	if target == "":
		return  r.text
	return r

def retrievePassword(resp_text):
	pattern = re.compile(r"\w{32}")
	for line in resp_text.split("\n"):
		# print "-----------------------------------------------------"
		n = pattern.search(line) 
		if n is not None and n.group() != sys.argv[2]:
			return n.group()

if __name__ == '__main__':
	main()