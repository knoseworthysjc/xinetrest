
$team = "SobeysContent"
$url = "https://sjccontent.sharepoint.com/teams/$team"
$conn = Connect-PnPOnline -Url $url -interactive


$list = "xinet_flyer_pages"

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

$inFolder = "\\10.136.209.199\Sobeys\Weekly_Flyers\Sobeys_Safeway\101087_Sobeys_Safeway_Wk49_Mar31_to_Apr06";
$upperBound = [DateTime]::Now.Subtract([TimeSpan]::FromDays(20))
#$files = Get-ChildItem -Path $inFolder -Recurse | Where { ! $_.PSIsContainer -and $_.LastWriteTime -gt $upperBound -and $_.Extension -eq 'indd'} | Select Name,FullName,LastWriteTime
$files = Get-ChildItem -Path $inFolder -Recurse -Include "*.indd"

foreach($file in $files)
{        
    $n = $file.Name
    $fn = $file.FullName
    $fp = $fn.replace("\\10.136.209.199","\vol04").replace("\","/")
    $mp = $fn.replace("\\10.136.209.199\","").replace("\",":") 
    $n_ary = $n.Split("_")
    $banner = $n_ary[0]
    $week = $n_ary[1].replace("WK","")
    $page = $n_aryp[2]
    $previewurl = "https://xinetapi.stjosephcontent.com/webnative/portalDI/?action=getimage&filetype=large&path=$fp, $n"
    $download_url = "https://xinetapi.stjosephcontent.com/webnative/portalDI/?action=streamfile&path=$fp, $n"


    $url = "$server"+"action=fileinfo&path=$fp";
    $request = Invoke-WebRequest -Method "GET" -uri $url -Headers $headers -ContentType "application/json"
    
    $json = ConvertFrom-JSON -InputObject $request.Content -Depth 8
    
    $response = $json.FILES_INFO
    
    $file_id = $response[0].FILE_ID;
    $x = @{file=$n;id=$file_id;}
    $x
    
    try {
        Add-PnPListItem -list "$list" -values @{Title=$n;fullpath=$fp;macpath=$mp;pcpath=$fn;file_id=$file_id;week=$week;banner=$banner;xinet_asset_type="indesign";preview_url=$previewurl;download_url=$download_url;}
        } catch {
            v = @{item_number=$item;Title=$n;fullpath=$fp;macpath=$mp;pcpath=$fn;xinet_id=$file_id;}
            v
        }
        start-sleep -Seconds 2
}
