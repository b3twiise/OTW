#!/usr/bin/env python
from driver import *


req=makeGetConnection()
# print req

# Another form. So pull the souce code and see

req=makeGetConnection("index-source.html")
# print req.text

# print unescap_thml(req.text)


# $encodedSecret = "3d3d516343746d4d6d6c315669563362"; /> />function encodeSecret($secret) {
#  />    return bin2hex(strrev(base64_encode($secret))); />
# } /> />if(array_key_exists("submit", $_POST)) {
#  />    if(encodeSecret($_POST['secret']) == $encodedSecret) {
#  />    print "Access granted. The password for natas9 is <censored>"; />    
# } else {
#  />    print "Wrong secret"; />    
# } />
# } />?

# They:---> base64->strrev->bin2hex
# We	:--->hex2bin->strrev->base64 b64encode(

def my_decode(str):
	import base64
	return base64.b64decode(''.join(reversed(str.decode("hex"))))

decodedSecret=my_decode("3d3d516343746d4d6d6c315669563362")

data={
	"submit" : True,
	"secret" : decodedSecret

}
req=makeGetConnection(post=True, data=data)
# print req

passwd = retrievePassword(req)
print_and_store_password(passwd)