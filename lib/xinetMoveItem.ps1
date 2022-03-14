function xinetMoveItem($filepath,$newpath,$newname,$overwrite)
{
    
    $user = $Env:xinetuser;
    $pass = $Env:xinetpassword;
    $server = $Env:xinetserver;

$url = "$server"+"action=filemgr&filemgraction=move&filename=$filepath&newpath=$newpath&newname=$newname&overwrite=$overwrite";
$pair = "${user}:${pass}"
$bytes = [System.Text.Encoding]::ASCII.GetBytes($pair)
$base64 = [System.Convert]::ToBase64String($bytes)
$basicAuthValue = "Basic $base64"

$headers = @{ 
    Authorization = $basicAuthValue;
}
write-host($url)
try{
    $request = Invoke-WebRequest -Method "GET" -uri "$url" -Headers $headers -ContentType "application/json"

    $response = ConvertFrom-JSON -InputObject $request.Content -Depth 8   
    
} catch {
    $response = $_;
}

return $response

}