
<#
Script to retrieve the password of level 17-18

#>
$url = 'http://natas19.natas.labs.overthewire.org'
$creds = "natas19:4IwIrekcuZlA9OsjOkoUtwU6lhokCPYs"
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


# <?

# $maxid = 640; // 640 should be enough for everyone

# function isValidAdminLogin() { /* {{{ */
#     if($_REQUEST["username"] == "admin") {
#     /* This method of authentication appears to be unsafe and has been disabled for now. */
#         //return 1;
#     }

#     return 0;
# }
# /* }}} */
# function isValidID($id) { /* {{{ */
#     return is_numeric($id);
# }
# /* }}} */
# function createID($user) { /* {{{ */
#     global $maxid;
#     return rand(1, $maxid);
# }
# /* }}} */
# function debug($msg) { /* {{{ */
#     if(array_key_exists("debug", $_GET)) {
#         print "DEBUG: $msg<br>";
#     }
# }
# /* }}} */
# function my_session_start() { /* {{{ */
#     if(array_key_exists("PHPSESSID", $_COOKIE) and isValidID($_COOKIE["PHPSESSID"])) {
#     if(!session_start()) {
#         debug("Session start failed");
#         return false;
#     } else {
#         debug("Session start ok");
#         if(!array_key_exists("admin", $_SESSION)) {
#         debug("Session was old: admin flag set");
#         $_SESSION["admin"] = 0; // backwards compatible, secure
#         }
#         return true;
#     }
#     }

#     return false;
# }
# /* }}} */
# function print_credentials() { /* {{{ */
#     if($_SESSION and array_key_exists("admin", $_SESSION) and $_SESSION["admin"] == 1) {
#     print "You are an admin. The credentials for the next level are:<br>";
#     print "<pre>Username: natas19\n";
#     print "Password: <censored></pre>";
#     } else {
#     print "You are logged in as a regular user. Login as an admin to retrieve credentials for natas19.";
#     }
# }
# /* }}} */

# $showform = true;
# if(my_session_start()) {
#     print_credentials();
#     $showform = false;
# } else {
#     if(array_key_exists("username", $_REQUEST) && array_key_exists("password", $_REQUEST)) {
#     session_id(createID($_REQUEST["username"]));
#     session_start();
#     $_SESSION["admin"] = isValidAdminLogin();
#     debug("New session started");
#     $showform = false;
#     print_credentials();
#     }
# } 

# if($showform) {
# ?>

# <p>
# Please login with your admin account to retrieve credentials for natas19.
# </p>

# <form action="index.php" method="POST">
# Username: <input name="username"><br>
# Password: <input name="password"><br>
# <input type="submit" value="Login" />
# </form>
# <? } ?>
# <div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
# </div>



# my_session_start +PHPSESSID                     +$_SESSION[admin] > We get creds
#                  +isValid($_COOKIE[PHPSESSID])


# --------------------------------------------------------------------------------
# $url = 'http://natas18.natas.labs.overthewire.org/?debug=1'



 $parms = @{"username"="admin"}
       
 $req = (Invoke-WebRequest -uri $url -Method Post -Body $parms  -proxy "http://localhost:8080" -Headers $headers -WebSession $s).content 


# PHPSESSID=323832 2d61646d696e; path=/; HttpOnly
# PHPSESSID=313034 2d61646d696e; path=/; HttpOnly
# PHPSESSID=343935 2d61646d696e; path=/; HttpOnly
# PHPSESSID=3432   2d61646d696e; path=/; HttpOnly
# PHPSESSID=3634   2d61646d696e; path=/; HttpOnly
 

# I will be cheatingon this one
# eofm3Wsshxc5bwtVnEuGIlr7ivb9KABF
