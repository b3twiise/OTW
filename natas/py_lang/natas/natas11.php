<?php
function xor_encrypt($in) {
    $key = "qw8J";
    $text = $in;
    $outText = '';

    // Iterate through each character
    for($i=0;$i<strlen($text);$i++) {
    $outText .= $text[$i] ^ $key[$i % strlen($key)];
    }

    return $outText;
}

// function loadData($def) {
//     $mydata = $def;
//     $tempdata = json_decode(xor_encrypt(base64_decode($da_arr, true)));
//     if(is_array($tempdata) && array_key_exists("showpassword", $tempdata) && array_key_exists("bgcolor", $tempdata)) {
//         if (preg_match('/^#(?:[a-f\d]{6})$/i', $tempdata['bgcolor'])) {
//         $mydata['showpassword'] = $tempdata['showpassword'];
//         $mydata['bgcolor'] = $tempdata['bgcolor'];
//         }
//     }
//     return $mydata;

// }



// $data = loadData($defaultdata);


// saveData($data);

$in = array( "showpassword"=>"yes", "bgcolor"=>"#ffffff");
print_r(base64_encode(xor_encrypt(json_encode($in))));
?>

