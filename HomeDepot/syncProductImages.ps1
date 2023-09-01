$team = "HomeDepotContent"
$url = "https://sjccontent.sharepoint.com/teams/$team"
$conn = Connect-PnPOnline -Tenant sjccontent.onmicrosoft.com -ClientId "$Env:sharepointclientid" -Thumbprint "$Env:sharepointthumbprint"  -url $url

function uploadSharepoint($inFolder, $spFolder, $inc)
{
    $inc    
    $upperBound = [DateTime]::Now.Subtract([TimeSpan]::FromHours(1))
        $files = Get-ChildItem -Path $inFolder -Include $inc | Where { ! $_.PSIsContainer -and $_.LastWriteTime -gt $upperBound} | Select Name,FullName,LastWriteTime
        write-Host("Total Files:" + $files.length)
        foreach($file in $files)
        {        
        $n = $file.Name
        $fn = $file.FullName
        $n
        Add-PnPFile -Path "$fn" -Folder $spFolder -Values @{Title="$n";local_path="$fn";asset_status="New"}        
        }
}
<#
$inFolder = "\\10.136.209.199\HomeDepot\Master Assets\Product_Images\*.*"
$upperBound = [DateTime]::Now.Subtract([TimeSpan]::FromHours(1))
#$files = Get-ChildItem -Path $inFolder -Filter "*.tif" | Where { ! $_.PSIsContainer -and $_.LastWriteTime -gt $upperBound} | Select Name,FullName,LastWriteTime
$files = Get-ChildItem -Path $inFolder -Include "*.tif","*.jpg","*.jpeg" | Where { ! $_.PSIsContainer -and $_.LastWriteTime -gt $upperBound} | Select Name,FullName,LastWriteTime

foreach($file in $files)
    {        
    $n = $file.Name
    $fn = $file.FullName
    $n
    Add-PnPFile -Path "$fn" -Folder "product_images" -Values @{Title="$n";local_path="$fn";asset_status="New"}        

    }
    #>
$inc = "*.tif","*.jpg","*.jpeg","*.eps"
$incb = "*.ai","*.tif","*.jpg","*.eps","*.jpeg"
uploadSharepoint "\\10.136.209.199\HomeDepot\Master Assets\Product_Images\*.*" "product_images" $inc
uploadSharepoint "\\10.136.209.199\HomeDepot\Master Assets\Logos\*.*" "Logos" $incb