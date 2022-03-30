
$team = "SobeysContent"
$url = "https://sjccontent.sharepoint.com/teams/$team"
$conn = Connect-PnPOnline -Url $url -interactive

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
    Add-PnPListItem -list "xinet_images" -values @{item_number=$item;Title=$n;fullpath=$fp;macpath=$mp;pcpath=$fn}
}
