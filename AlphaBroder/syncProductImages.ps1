$team = "AlphaBroderContent"
$url = "https://sjccontent.sharepoint.com/teams/$team"
$conn = Connect-PnPOnline -Tenant sjccontent.onmicrosoft.com -ClientId "$Env:sharepointclientid" -Thumbprint "$Env:sharepointthumbprint"  -url $url

$inc = "*.tif","*.jpg","*.eps","*.psd","*.jpeg","*.tiff"
$upperBound = [DateTime]::Now.Subtract([TimeSpan]::FromMinutes(15))
#$files = Get-ChildItem -Path $inFolder -Include $inc -recurse | Where { ! $_.PSIsContainer -and $_.LastWriteTime -gt $upperBound} | Select Name,FullName,LastWriteTime
$files = Get-ChildItem -Path "\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\Spyder\*" -Include $inc | Select Name,FullName,LastWriteTime

foreach($f in $files)
{
    
    $n=$f.Name
    $fn = $f.FullName
    $pth = $f.FullName
    $nn = $n.split(".")[0]
    $tmp = "$env:TEMP\$nn.png"
    
    $brand = $pth.split("\")[5]
    $values = @{Title="$n";local_path="$fn";}
    
    $imgDetails = $n.replace("_z","").split(".")[0].split("_")
    $data = @{Title="$nn.png";local_path="$fn";local_name="$n";update_metainfo=1;}

    if ($n.ToUpper().StartsWith("CAT")) {
        $data["catalog_year"]=$imgDetails[0].ToUpper();
        $data["style_item_number"] = $imgDetails[1].ToUpper();
        switch ($imgDetails.Length) {
            4 { 
                $data["color_code"]=$imgDetails[3];
                $data["imageangle"]=switch($imgDetails[2].ToUpper()){
                    "BK" {"Back"} 
                    "SD" {"Side"}
                    "OF1" {"Off Figure"}
                    "LSD" {"Left Side"}
                    "QRT" {"Quarter"}
                    "FF" {"Flat Front"}
                    "FB" {"Flat Back"}
                    "TOP" {"Top"}
                    default {"Other"}
                };
            }
            3 { 
                $data["color_code"]=$imgDetails[3];
                $data["imageangle"]="Front"; 
            } 
        }
    } else {
        $data["style_item_number"] = $imgDetails[0];
        switch ($imgDetails.Length) {
            2 { 
                $data["color_code"]=$imgDetails[1];
                $data["imageangle"]="Front"
            }
            default  { 
                $data["color_code"]=$imgDetails[3];
                $data["imageangle"]=switch($imgDetails[2].ToUpper()){
                    "BK" {"Back"} 
                    "SD" {"Side"}
                    "OF1" {"Off Figure"}
                    "LSD" {"Left Side"}
                    "QRT" {"Quarter"}
                    "FF" {"Flat Front"}
                    "FB" {"Flat Back"}
                    "TOP" {"Top"}
                    default {"Other"}
                };
            }}
    }
    if ($f.Extension -eq ".eps") {
        magick -density 72 -colorspace RGB -layers flatten "$fn" "$tmp"
    }else{
        magick -density 72 -colorspace RGB -layers flatten "$fn" "$tmp"
    }
    $spfolder = "Assets/Style Images/$brand/"+$data["style_item_number"]
    Add-PnPFile -Path "$tmp" -Folder "$spfolder" -ContentType "style_item_asset" -values $data 
    Remove-Item "$tmp"
}

Disconnect-PnPOnline