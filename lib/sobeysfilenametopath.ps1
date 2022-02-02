function sobeysFilenameToPath($name)
{
    $fileext = $name.split(".")[0]
    $str_replace = $fileext.split("_")[0] -replace '[aA-zZ]',''    
    $underscore_int = [UInt64]$str_replace
    $underscore = [string]$underscore_int
    $basefolder = $underscore -match '[1-9]' -match '\d{1}';
    $path_a = [int]$Matches[0]
    $subfoldera = $underscore.substring($underscore.IndexOf([string]$path_a)+1) -replace '[aA-zZ]',''    
    return "$path_a/"+$subfoldera.substring(0,2)
}