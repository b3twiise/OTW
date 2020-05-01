<#

Script to retrieve the password of level 0

#>
$url = "http://natas0.natas.labs.overthewire.org "
$creds = "natas0:natas0"
$encodedCreds = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($creds))
$headers = @{ Authorization = "Basic $encodedCreds"}

Invoke-WebRequest -uri $url -Method Get -Headers $headers -Outfile temp.text

get-content ./temp.text | Select-String -pattern "(\w{12,})"

remove-Item ./temp.text


<#
<!--The password for natas1 is [7mgtVrDuiDfck831PqWsLEZy5gyDz1clto[0m -->

[Finished in 2.3s]
#>