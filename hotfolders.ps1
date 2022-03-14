. ./lib/fileupload.ps1
. ./lib/sobeysfilenametopath.ps1

$date = Get-Date -UFormat "%F"
$time = Get-Date -UFormat "%F %T"
$inFolder = "\\10.136.209.199\Sobeys_Assets\_HotFolders\SMT";
$doneFolder = "$inFolder"+"\Done";
$errorFolder = "$inFolder"+"\Error";
$log = "$inFolder"+"\Log\"+$date.ToString()+".log"
$logRec = @{user=$Env:xinetuser;server=$Env:xinetserver}
$logRec.Add("start",$time.ToString())
$filelist=@()
$files = Get-ChildItem -Path $inFolder -Filter "*.eps"

$pth = "/vol04/Sobeys_Assets/Sobeys_SMT/"

foreach($file in $files)
{
    try {
    $name = $file.Name
    $newpath = sobeysFilenameToPath "$name"
    $startpath = "$pth$newpath/"
    $logimg = @{}
    $logimg.Add("name",$name)
    $logimg.Add("destination",$startpath)
    $src = $file.FullName    

    $upload = uploadfile $src $startpath 1
    $logimg.Add("results",$upload)
    $filelist += $logimg
    Move-Item $src $doneFolder -Force
} catch {
    Move-Item $src $errorFolder -Force
}
}
$logRec.Add("Images",$filelist)
$logdata = ConvertTo-JSON($logRec)
Add-Content -Path $log -Value "$logdata,"