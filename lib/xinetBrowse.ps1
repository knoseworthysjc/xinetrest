function xinetBrowse($path)
{
    
    $user = $Env:xinetuser;
    $pass = $Env:xinetpassword;
    $server = $Env:xinetserver;

$url = "$server"+"action=browse&path=$path";
$pair = "${user}:${pass}"
$bytes = [System.Text.Encoding]::ASCII.GetBytes($pair)
$base64 = [System.Convert]::ToBase64String($bytes)
$basicAuthValue = "Basic $base64"

$headers = @{ 
    Authorization = $basicAuthValue;
}

try{
    $request = Invoke-WebRequest -Method "GET" -uri $url -Headers $headers -ContentType "application/json"
    
    $json = ConvertFrom-JSON -InputObject $request.Content -Depth 8
    
    $response = $json.FILES_INFO
    
} catch {
    $response = $_;
}

return $response

}