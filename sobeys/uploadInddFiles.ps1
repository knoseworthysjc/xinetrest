$team = "SobeysContent"
$url = "https://sjccontent.sharepoint.com/teams/$team"
$conn = Connect-PnPOnline -Tenant sjccontent.onmicrosoft.com -ClientId "$Env:sharepointclientid" -Thumbprint "$Env:sharepointthumbprint"  -url $url

$inFolders =@(
    @{f="\\10.136.209.199\Sobeys\Weekly_Flyers\Foodland";d="Flyer Pages";b="FoodLand"},
    @{f="\\10.136.209.199\Sobeys\Weekly_Flyers\IGA";d="Flyer Pages";b="IGA"},
    @{f="\\10.136.209.199\Sobeys\Weekly_Flyers\Sobeys_Safeway";d="Flyer Pages";b="SOBEYS"},
    @{f="\\10.136.209.199\Sobeys\Weekly_Flyers\Thrifty_Food";d="Flyer Pages";b="Thrifty Foods"}
)

foreach($inFolder in $inFolders)
{
    $upperBound = [DateTime]::Now.Subtract([TimeSpan]::FromHours(24))
    $files = Get-ChildItem -Path $inFolder.f -Filter "*.indd" -recurse -depth 4 | Where { ! $_.PSIsContainer -and $_.LastWriteTime -gt $upperBound} | Select Name,FullName,LastWriteTime
    
    foreach($file in $files)
    {        
        $n = $file.Name
        $fn = $file.FullName

        $pcpath = $fn
        $banner = $inFolder.b
        $projectAry = $fn -Split "\\" 
        $project = $projectAry[6]

        $pcpath
        $projectPath
        $banner
        $project
        <#
        
        $pgs = $n -Split "_"
        $pgsgrp = $pgs -Split "-"
        $pgsfr = [int]$pgsgrp[0].replace("P","")
        $pgsto = [int]$pgsgrp[1]
         
        $if = $inFolder.d
        Add-PnPFile -Path "$fn" -Folder "$if" -Values @{Title="$n";pagefrom0=$pgsfr;pageto0=$pgsto;Project=$inFolder.p;}        
        #>
        
    }
}