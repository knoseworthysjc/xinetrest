. ./lib/fileupload.ps1
. ./lib/xinetBrowse.ps1
. ./lib/xinetMoveItem.ps1

$date = Get-Date -UFormat "%F"
$time = Get-Date -UFormat "%F %T"
$inFolder = "\\10.136.209.199\HomeDepot\HotFolders\ProductImages";
$errorFolder = "\\10.136.209.199\HomeDepot\HotFolders\Errors";
$log = "\\10.136.209.199\HomeDepot\HotFolders\Logs\"+$date.ToString()+".log"
$logRec = @{user=$Env:xinetuser;server=$Env:xinetserver}
$logRec.Add("start",$time.ToString())
$filelist=@()
$files = Get-ChildItem -Path $inFolder -Include "*.jpg","*.tif","*.tiff","*.eps"

$pth = "/vol04/HomeDepot/Master Assets/Product_Images"

foreach($file in $files)
{
    try {
    $name = $file.Name
    
    $startpath = "$pth/"
    $logimg = @{}
    $logimg.Add("name",$name)
    $logimg.Add("destination",$startpath)
    $src = $file.FullName    

    $upload = uploadfile $src $startpath 1
    $logimg.Add("results",$upload)
    $filelist += $logimg
    
} catch {
    
}
}
$logRec.Add("Images",$filelist)
$logdata = ConvertTo-JSON($logRec)
Add-Content -Path $log -Value "$logdata,"