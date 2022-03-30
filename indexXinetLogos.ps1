. ./lib/xinetBrowse.ps1
$team = "SobeysContent"
$url = "https://sjccontent.sharepoint.com/teams/$team"
$conn = Connect-PnPOnline -Url $url -interactive

$list = "xinet_logos"

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

$inFolder = "\\10.136.209.199\Sobeys_Assets\Logos_Icons";
#$upperBound = [DateTime]::Now.Subtract([TimeSpan]::FromDays(1))
# -and $_.LastWriteTime -gt $upperBound
$files = Get-ChildItem -Path $inFolder -Recurse | Where { ! $_.PSIsContainer } | Select Name,FullName,LastWriteTime

for($i=239; $i -lt $files.length; $i++)
#foreach($file in $files)
{        
    $file = $files[$i]
    $n = $file.Name
    $fn = $file.FullName
    $fp = $fn.replace("\\10.136.209.199","\vol04").replace("\","/")
    $mp = $fn.replace("\\10.136.209.199\","").replace("\",":")    
    $previewurl = "https://xinetapi.stjosephcontent.com/webnative/portalDI/imagebyid/?action=getimage&filetype=large&path=$fp"
    $download_url = "https://xinetapi.stjosephcontent.com/webnative/portalDI/imagebyid/?action=streamfile&path=$fp"
    
    $url = "$server"+"action=fileinfo&path=$fp";
    $request = Invoke-WebRequest -Method "GET" -uri $url -Headers $headers -ContentType "application/json"
    
    $json = ConvertFrom-JSON -InputObject $request.Content -Depth 8
    
    $response = $json.FILES_INFO
    
    $file_id = $response[0].FILE_ID;

    Add-PnPListItem -list "$list" -values @{Title=$n;fullpath=$fp;macpath=$mp;pcpath=$fn;preview_url=$previewurl;download_url=$download_url;xinet_asset_type="image";file_id=$file_id}
}
