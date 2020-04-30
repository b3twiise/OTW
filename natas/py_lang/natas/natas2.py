#!/usr/bin/env python
from driver import *


#This time it is a png. So let us set the stage
from PIL.ImageEnhance import Sharpness
from PIL import Image 
from PIL import ImageFilter
req = makeGetConnection()
print req

# <body>
# <h1>natas2</h1>
# <div id="content">
# There is nothing on this page
# <img src="files/pixel.png">
# </div>
# </body></html>

#I had to cheat a bit. After checking out /files, we see /files/users.txt and we go for it
req= makeGetConnection("files/users.txt")
nextLlv = int(sys.argv[1]) + 1

passw = retrievePassword(req.text)
nextLlv = int(sys.argv[1]) + 1

print "The password for natas" + str(nextLlv) + " is: " + passw


