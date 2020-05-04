
<#
Script to retrieve the password of level 6-7

#>
$url = "http://natas8.natas.labs.overthewire.org"
$creds = "natas8:DBfUBfqQG69KvJvJ1iAbMoIpwSNQ9bWe"
$encodedCreds = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($creds))
$headers = @{ Authorization = "Basic $encodedCreds"}

# $a = (Invoke-WebRequest -uri $url -Method Get -Headers $headers).content//




<#
We hear something about source code so, here we go
index-source.html
#>

# $url += "/index-source.html"//
# $a = (Invoke-WebRequest -uri $url -Method Get -Headers $headers).content//

# $clean =[System.Web.HttpUtility]::HtmlDecode($a).split("<br />")
# #Previous line makes source code visually appealing

# $clean//

<#

We get this gem

<?

$encodedSecret = "3d3d516343746d4d6d6c315669563362";

function encodeSecret($secret) {
    return bin2hex(strrev(base64_encode($secret)));
}

if(array_key_exists("submit", $_POST)) {
    if(encodeSecret($_POST['secret']) == $encodedSecret) {
    print "Access granted. The password for natas9 is <censored>";
    } else {
    print "Wrong secret";
    }
}
?>


#>

<#

bash one liners go burrrr!!!

voltron@voltron:/tmp$ echo -n 3d3d516343746d4d6d6c315669563362 | xxd -r -p | rev | base64 -d && echo
oubWYf2kBq
voltron@voltron:/tmp$ 

#>

# ===========================================

# Crack that hash

# ==========================================

$elHash = "3d3d516343746d4d6d6c315669563362"
$elB64 = ''
$reversed = ""
$decodedB4 = ""
$elsecret = ''
$reversed = $elHash -split "" | foreach-object {$a = 0; $item = ""; $ret ="" } {$a += 1; $item += $_; if (($a % 2) -eq 1){$ret += ([System.Text.Encoding]::ASCII.GetString([BYTE][CHAR]([CONVERT]::toint16($item,16))) ); $item = ""}} { $ret}
$elB64 = $reversed -split "" | forEach-object  {$ret = ""}{$ret =  $_ + $ret }{$ret}
$elsecret = [Text.Encoding]::Utf8.GetString([Convert]::FromBase64String($elB64))
echo $elsecret
# write-host $elHash
# ==================================================
#     Will need this when am ready
# =========================================

$url = "http://natas8.natas.labs.overthewire.org"

$sec = @{"secret" = $elsecret; "submit" = ""}
$a = (Invoke-WebRequest -uri $url -Method Post -Body $sec -proxy "http://localhost:8080" -Headers $headers).content 
$passwd = ($a | Select-String -allMatches "(\w{20,})").matches[1].value


echo "The password for natas9 is $passwd"



# PS /home/voltron/OTW/natas/pshell_lang> ./natas9.ps1    
# MethodInvocationException: /home/voltron/OTW/natas/pshell_lang/natas9.ps1:74                                                                  
# Line |                                                                                                                                        
#   74 |  … % 2) -eq 1){$ret += ([System.Text.Encoding]::ASCII.GetString([BYTE][C …
#      |                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#      | Exception calling "ToInt16" with "2" argument(s): "Specified argument was out of the range of valid values. (Parameter
#      | 'Index was out of range. Must be non-negative and less than the size of the collection.')"
#      oubWYf2kBq
# The password for natas9 is W0mMhUcRRnG8dcghE4qvk3JA9lGt8nDl                                                                                   
# PS /home/voltron/OTW/natas/pshell_lang>                                                                                                                                                                   