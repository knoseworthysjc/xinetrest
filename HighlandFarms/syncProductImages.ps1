$team = "HighlandFarmsContent"
$url = "https://sjccontent.sharepoint.com/teams/$team"
$conn = Connect-PnPOnline -Tenant sjccontent.onmicrosoft.com -ClientId "$Env:sharepointclientid" -Thumbprint "$Env:sharepointthumbprint"  -url $url

function uploadSharepoint($inFolder, $spFolder, $inc)
{
    
        $upperBound = [DateTime]::Now.Subtract([TimeSpan]::FromMinutes(15))
        $files = Get-ChildItem -Path $inFolder -Include $inc -recurse | Where { ! $_.PSIsContainer -and $_.LastWriteTime -gt $upperBound} | Select Name,FullName,LastWriteTime
        write-Host("Total Files:" + $files.length)
       foreach($file in $files)
        {        
        $n = $file.Name
        $fn = $file.FullName
        
        $category = $inFolder.split("\") | Select-Object -Last 2 | Select-Object -First 1
        $sp = "Product Images\$category"
        $xinetPath = $fn.replace("\","/").replace("//10.136.209.199","/vol04")
        $values = @{Title="$n";local_path="$xinetPath";product_category="$category"}
        
        Add-PnPFile -Path "$fn" -Folder "$sp" -Values $values       
        }
}
<#
$inFolder = "\\10.136.209.199\HomeDepot\Master Assets\Product_Images\*.*"
$upperBound = [DateTime]::Now.Subtract([TimeSpan]::FromHours(1))
#$files = Get-ChildItem -Path $inFolder -Filter "*.tif" | Where { ! $_.PSIsContainer -and $_.LastWriteTime -gt $upperBound} | Select Name,FullName,LastWriteTime
$files = Get-ChildItem -Path $inFolder -Include "*.tif","*.jpg" | Where { ! $_.PSIsContainer -and $_.LastWriteTime -gt $upperBound} | Select Name,FullName,LastWriteTime

foreach($file in $files)
    {        
    $n = $file.Name
    $fn = $file.FullName
    $n
    Add-PnPFile -Path "$fn" -Folder "product_images" -Values @{Title="$n";local_path="$fn";asset_status="New"}        

    }
    #>
$inc = "*.tif","*.psd","*.jpg"

$paths = Get-ChildItem "\\10.136.209.199\Highland_Farms\Highland_Farms_Assets\" 
foreach($f in $paths)
{
    $f.Name
    $f.FullName
    $pth = $f.FullName
    
    uploadSharepoint "$pth\*.*" "Product Images" $inc
}

Disconnect-PnPOnline