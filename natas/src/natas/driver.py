#!/usr/bin/env python
import re
import requests
import sys

print sys.argv
lvl = re.search(r"\d+", sys.argv[0]).group()
print lvl
currentPass = ""

def makeGetConnection(target="", headers={}, post=False, data="",cookies=""):
	global currentPass
	print "cookies=======================", cookies
	s=requests.Session()
	print "Usage: <sys.argv[0]>"
	name = "natas"
	nameX = name + lvl
	with open(nameX + ".pass") as handle:
		print nameX + ".pass"
		currentPass = handle.readline().strip()
		print "currentPass " + currentPass + "  " + str(len(currentPass))
		handle.close()


	if not post:
		r = s.get("http://" + nameX + ".natas.labs.overthewire.org/"+ target, auth=(nameX, currentPass),headers=headers,cookies=cookies)
	elif post:
		r =s.post("http://" + nameX + ".natas.labs.overthewire.org/"+ target,data=data, auth=(nameX, currentPass))
		print "Detected a post"
	# print "=================="
	# print r.headers
	# print "==================="
	if target == "":
		return  r.text
	return r
def retrievePassword(resp_text):
	pattern = re.compile(r"\w{32}")
	for line in resp_text.split("\n"):
		# print "-----------------------------------------------------"
		n = pattern.search(line) 
		if n is not None and  n.group() != currentPass:
			return n.group()


def unescap_thml(contents):
	ret = ""
	# da_bads={
	# "&nbsp" : " ",
	# "&lt" : "<",
	# "&gt" : ">",

	# }
	for line in contents.split("<br"):
		ret+=line.replace("&nbsp;", " ").replace("&lt;", "<").replace("&gt;", ">")
	return ret


def print_and_store_password(passwd):

	nextLlv = int(lvl) + 1
	with open( ("natas" + str(nextLlv) +".pass") , "w")as f:
		f.write(passwd + "\n")
	print "The password for natas" + str(nextLlv) + " is: " + passwd







if __name__ == '__main__':
	main()