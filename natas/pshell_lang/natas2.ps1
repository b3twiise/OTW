<#

Script to retrieve the password of level 1-2

#>
$url = "http://natas1.natas.labs.overthewire.org "
$creds = "natas1:gtVrDuiDfck831PqWsLEZy5gyDz1clto"
$encodedCreds = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($creds))
$headers = @{ Authorization = "Basic $encodedCreds"}

Invoke-WebRequest -uri $url -Method Get -Headers $headers -Outfile temp.text

get-content ./temp.text | Select-String -pattern "(\w{20,})" > res 


 $a = (get-content res).split("\n")[2]
del ./temp.text 
del res

Write-host $a
echo $a


#remove-Item res


<#
<!--The password for natas2 is [7mZluruAthQk7Q2MqmDeTiUij2ZvWy2mBi[0m -->
[Finished in 1.9s]

#>