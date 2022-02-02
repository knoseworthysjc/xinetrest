. ./lib/fileupload.ps1
. ./lib/sobeysfilenametopath.ps1

$date = Get-Date -UFormat "%F"
$time = Get-Date -UFormat "%F %T"
$inFolder = "\\10.136.209.199\Sobeys_Assets\_HotFolders\SMT";
$doneFolder = "$inFolder"+"\Done";
$errorFolder = "$inFolder"+"\Error";
$log = "$inFolder"+"\Log\"+$date.ToString()+".log"
$logRec = @{}
$logRec.Add("start",$time.ToString())

$files = Get-ChildItem -Path $inFolder -Filter "*.eps"

$pth = "/vol04/Sobeys_Assets/Sobeys_SMT/"

foreach($file in $files)
{
    $name = $file.Name
    $newpath = sobeysFilenameToPath "$name"
    $startpath = "$pth$newpath/"
    $logRec.Add("name",$name)
    $logRec.Add("destination",$startpath)
    $src = $file.FullName    

    $upload = uploadfile $src $startpath "true"
    $logRec.Add("results",$upload)
    
    Move-Item $src $doneFolder -Force
}
Add-Content -Path $log -Value 