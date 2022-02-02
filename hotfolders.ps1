. ./lib/fileupload.ps1
. ./lib/sobeysfilenametopath.ps1

$date = Get-Date -UFormat "%F"
$time = Get-Date -UFormat "%F %T"
$inFolder = "\\10.136.209.199\Sobeys_Assets\_HotFolders\SMT";
$doneFolder = "$inFolder"+"\Done";
$errorFolder = "$inFolder"+"\Error";
$log = "$inFolder"+"\Log\"+$date.ToString()+".log"
Add-Content -Path $log -Value $time.ToString()
$files = Get-ChildItem -Path $inFolder -Filter "*.eps"

$user = $Env:xinetuser;
$pass = $Env:xinetpassword;
$server = $Env:xinetserver;
$pth = "/vol04/Sobeys_Assets/Sobeys_SMT/"

foreach($file in $files)
{
    $name = $file.Name
    $newpath = sobeysFilenameToPath "$name"
    $startpath = "$pth$newpath/"
    Add-Content -Path $log -Value $name
    Add-Content -Path $log -Value $startpath
    $src = $file.FullName    

    $file = uploadfile $server $user $pass $src $startpath "true"
    Add-Content -Path $log -Value $file
    Move-Item $src $doneFolder -Force
}
Add-Content -Path $log -Value $time.ToString()



