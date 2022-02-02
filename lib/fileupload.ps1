function uploadfile($server,$user,$pass,$src,$pth,$overwrite='false')
{
    
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

