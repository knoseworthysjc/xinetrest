. ./lib/fileupload.ps1
. ./lib/xinetBrowse.ps1

. ./lib/sobeysfilenametopath.ps1
. ./lib/xinetMoveItem.ps1

$date = Get-Date -UFormat "%F"
$time = Get-Date -UFormat "%F %T"
$inFolder = "\\10.136.209.199\Sobeys_Assets\_HotFolders\SMT";
$path = "/vol04/Sobeys_Assets/_HotFolders/SMT";
$destination = "/vol04/Sobeys_Assets/Sobeys_SMT/"
$doneFolder = "$inFolder"+"\Done";
$errorFolder = "$inFolder"+"\Error";

$log = "$inFolder"+"\Log\"+$date.ToString()+".log"
$logRec = @{user=$Env:xinetuser;server=$Env:xinetserver}
$logRec.Add("start",$time.ToString())
$files=@()
$filelist=xinetBrowse($path)

foreach($file in $filelist)
{        
    $name = $file.FILE_NAME
    $name
    $logimg = @{
        FILE_ID=$file.FILE_ID;
        PARENT_FILE_ID=$file.PARENT_FILE_ID;
        FILE_NAME=$file.FILE_NAME;
        FILE_NAME_DECOMPOSED=$file.FILE_NAME_DECOMPOSED;
        FILE_PATH=$file.FILE_PATH;
        FILE_PATH_UTF8MAC=$file.FILE_PATH_UTF8MAC;
        FILE_COMMENT=$file.FILE_COMMENT;
        FILE_TYPE=$file.FILE_TYPE;
        FILE_CREATOR=$file.FILE_CREATOR;
        FILE_LENGTH=$file.FILE_LENGTH;
        FILE_ISADIR=$file.FILE_ISADIR;
        FILE_CDATE=$file.FILE_CDATE;
        FILE_MDATE=$file.FILE_MDATE;
        FILE_ADATE=$file.FILE_ADATE;
    }
    try {
        if($file.FILE_ISADIR -eq $FALSE){
                
        $newpath = sobeysFilenameToPath "$name"
        $startpath = "$destination$newpath/"
        
        $logimg.Add("destination",$startpath)
        $logimg.Add("status","success")
            
        $mv = xinetMoveItem $file.FILE_PATH_UTF8MAC $startpath $name "true"
        $logimg.Add("response",$mv);
}
    }  catch {
        $logimg.Add("status","failed")
    }
    $files += $logimg
}
$logRec.Add("files",$files)
$logdata = ConvertTo-JSON -InputObject $logRec -Depth 10 
Add-Content -Path $log -Value "$logdata,"