
$team = "SobeysContent"
$url = "https://sjccontent.sharepoint.com/teams/$team"
$conn = Connect-PnPOnline -Url $url -interactive


$list = "xinet_images"

$user = $Env:xinetuser;
    $pass = $Env:xinetpassword;
    $server = $Env:xinetserver;


$pair = "${user}:${pass}"
$bytes = [System.Text.Encoding]::ASCII.GetBytes($pair)
$base64 = [System.Convert]::ToBase64String($bytes)
$basicAuthValue = "Basic $base64"

$headers = @{ 
    Authorization = $basicAuthValue;
}

$inFolder = "\\10.136.209.199\Sobeys_Assets\Sobeys_SMT";
$upperBound = [DateTime]::Now.Subtract([TimeSpan]::FromDays(1))
$files = Get-ChildItem -Path $inFolder -Recurse | Where { ! $_.PSIsContainer -and $_.LastWriteTime -gt $upperBound} | Select Name,FullName,LastWriteTime


foreach($file in $files)
{        
    $n = $file.Name
    $fn = $file.FullName
    $item = $n.Split(".")[0].Split("_")[0]
    $fp = $fn.replace("\\10.136.209.199","\vol04").replace("\","/")
    $mp = $fn.replace("\\10.136.209.199\","").replace("\",":") 
    
    $url = "$server"+"action=fileinfo&path=$fp";
    $request = Invoke-WebRequest -Method "GET" -uri $url -Headers $headers -ContentType "application/json"
    
    $json = ConvertFrom-JSON -InputObject $request.Content -Depth 8
    
    $response = $json.FILES_INFO
    
    $file_id = $response[0].FILE_ID;
    try {
    Add-PnPListItem -list "xinet_images" -values @{item_number=$item;Title=$n;fullpath=$fp;macpath=$mp;pcpath=$fn;xinet_id=$file_id;}
    } catch {
        v = @{item_number=$item;Title=$n;fullpath=$fp;macpath=$mp;pcpath=$fn;xinet_id=$file_id;}
        v
    }
    start-sleep -Seconds 2
}
