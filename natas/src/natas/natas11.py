#!/usr/bin/env python
from driver import *


req=makeGetConnection()
# print req


# We get a note that cookies are protected with xor encryption

# So check source we shall
req = makeGetConnection(target = "index-source.html")

# print unescap_thml(req.text)





# -----------------------------------------------------------------------------------------------------------------------
# />$defaultdata = array( "showpassword"=>"no", "bgcolor"=>"#ffffff"); /> 

# />function xor_encrypt($in) { />   
#  $key = '<censored>'; />    
#  $text = $in; />    
#  $outText = ''; /> />    
#  // Iterate through each character /> 
#     for($i=0;$i<strlen($text);$i++) { />  
#    $outText .= $text[$i] ^ $key[$i % strlen($key)]; />    } /> />  
#   return $outText; />} /> />


#   function loadData($def) { 
#   />    global $_COOKIE; />    $mydata = $def; />    
#   if(array_key_exists("data", $_COOKIE)) { />   
#    $tempdata = json_decode(xor_encrypt(base64_decode($_COOKIE["data"])), true); />    
#    if(is_array($tempdata) && array_key_exists("showpassword", $tempdata) && array_key_exists("bgcolor", $tempdata)) { />       
#     if (preg_match('/^#(?:[a-f\d]{6})$/i', $tempdata['bgcolor'])) { />    
#         $mydata['showpassword'] = $tempdata['showpassword']; />   
#         $mydata['bgcolor'] = $tempdata['bgcolor']; />        } />    } />    } />    
#         return $mydata; />} /> 

#        />function saveData($d) { />    
#        setcookie("data", base64_encode(xor_encrypt(json_encode($d)))); />} /> 
#        />$data = loadData($defaultdata); /> 
#        />if(array_key_exists("bgcolor",$_REQUEST)) { />    
#        if (preg_match('/^#(?:[a-f\d]{6})$/i', $_REQUEST['bgcolor'])) { />       
#         $data['bgcolor'] = $_REQUEST['bgcolor']; />    } />} /> />saveData($data);
#          /> /> /> />?> /> /><h1>natas11</h1> /><div id="content"> /><body style="background: <span style="color: #0000BB"><?=$data</span><span style="color: #007700">[</span><span style="color: #DD0000">'bgcolor'</span><span style="color: #007700">]</span><span style="color: #0000BB">?></span>;"> />Cookies are protected with XOR encryption<br/><br/> /> /><? 
#          />if($data["showpassword"] == "yes") 
#          { />    print "The password for natas12 is <censored><br>"; />} /> />?> /> /><form> 

# quite a lot to unpack here.
# defaultdata :---> array initialiazed with (showpassword: no), (bgcolor:ffffff)
# function xor_encrypt($in) :--> $in[i] ^ $key[i % strlen($key)]
# function loadData($bla) :-->
# 	"data" in cookie then	$tempdata = json_decode(xor_encrypt(base64_decode($_COOKIE["data"])), true); 
# 							$tempdata is array and has elems (bgcolor && showpassword)
# 							return tempdata if valid

# function saveData($d) :--->
# 			encode cookie
# 			bgcolor exits in REQUESTS
# 			make sure data["showpassword"] =1


# # 1 We have cookie name data
# #bgcolor: len6
cookies = {
	"showpassword": "no", "bgcolor" : "#222222"
}
data ={
	"bgcolor": "#222222"
}
req = req=makeGetConnection(post=True, cookies=cookies, data=data)
# print req
# print "cookies=======================", cookies
print ' #FFFFFF' + str(req.cookies)

# After some google foo, we come up with this 




# <?php
# function xor_encrypt($in) {
#     $key = json_encode(array( "showpassword"=>"no", "bgcolor"=>"#ffffff"));
#     $text = $in;
#     $outText = '';

#     // Iterate through each character
#     for($i=0;$i<strlen($text);$i++) {
#     $outText .= $text[$i] ^ $key[$i % strlen($key)];
#     }

#     return $outText;
# }


# $in="ClVLIh4ASCsCBE8lAxMacFMZV2hdVVotEhhUJQNVAmhSEV4sFxFeaAw=";
# print_r (xor_encrypt(base64_decode($in)));
# ?>

######################################
#########(venv) b3twiise@phoenix:~/OTW/natas/src/natas$ php -f *php
#########qw8Jqw8Jqw8Jqw8Jqw8Jqw8Jqw8Jqw8Jqw8Jqw8Jq
##########(venv) b3twiise@phoenix:~/OTW/natas/src/natas$ 
#######################################


# Now the encoding is done with showpassword set to yes

 # array("showpassword"=>"yes", "bgcolor"=>"#ffffff")
cookies = {"data":"ClVLIh4ASCsCBE8lAxMacFMOXTlTWxooFhRXJh4FGnBTVF4sFxFeLFMK"}

req = req=makeGetConnection( cookies=cookies)
print req.text

#This pulls it. Now let us retrieve it

passwd = retrievePassword(req.text)

print_and_store_password(passwd)

