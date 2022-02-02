function uploadfile($src,$pth,$overwrite='false')
{
    
    $user = $Env:xinetuser;
    $pass = $Env:xinetpass;
    $server = $Env:xinetserver;
    
$file = Get-Item -Path "$src" 

$name = $file.Name

$url = "$server"+"?action=upload&path=$pth&overwrite=$overwrite";
$pair = "${user}:${pass}"
$bytes = [System.Text.Encoding]::ASCII.GetBytes($pair)
$base64 = [System.Convert]::ToBase64String($bytes)
$basicAuthValue = "Basic $base64"

$headers = @{ 
    Authorization = $basicAuthValue;
}


try{
    $response = curl -u $pair -F "filedata=@$src" "$url"
} catch {
    $response = $_;
}

return $response

}

