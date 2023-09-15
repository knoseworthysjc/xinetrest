$team = "AlphaBroderContent"
$url = "https://sjccontent.sharepoint.com/teams/$team"
$conn = Connect-PnPOnline -Tenant sjccontent.onmicrosoft.com -ClientId "$Env:sharepointclientid" -Thumbprint "$Env:sharepointthumbprint"  -url $url

#$files = Get-ChildItem -Path $inFolder -Include $inc -recurse | Where { ! $_.PSIsContainer -and $_.LastWriteTime -gt $upperBound} | Select Name,FullName,LastWriteTime

$paths = @(
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\AAA - cover colour wheel",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\ACCESSORIES",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\Adams",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\ADIDAS",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\ALO SPORT",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\ALSTYLE",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\ALTERNATIVE",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\AMERICAN APPAREL",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\ANVIL",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\AUGUSTA",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\AUTHENTIC PIGMENT",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\AWDIS",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\Backpacker",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\BADGER",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\BAGedge",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\BAGS",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\BAYSIDE",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\BELLA & CANVAS",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\Berne",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\BIG XSO",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\BLANKS",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\Burnside",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\C2",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\Carmel Towels",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\CHAMPION",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\Champion Accessories",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\CODE FIVE",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\COLORTONE",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\Columbia",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\COMFORT COLORS",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\CORE365",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\Core365_Laydowns",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\Corporate",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\DEVON&JONES",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\DICKIES",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\DRI DUCK",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\DYENOMITE",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\ECONSCIOUS",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\EXTREME",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\FLEXFIT",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\FRUIT OF THE LOOM",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\Gemline",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\GILDAN",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\Hall of Fame",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\HANES",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\HARRITON",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\HATS",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\Holloway",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\HOOK & TACKLE",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\Igloo",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\INSERT",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\J-AMERICA",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\JERZEES",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\Just-Hoods",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\Lane Seven",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\LAT",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\Leeman",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\Liberty Bags",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\MARMOT",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\MV SPORT",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\N3425",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\Nautica",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\NEW BALANCE",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\Next Level",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\NORTH END",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\NORTH END SPORT BLUE",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\NORTH END SPORT RED",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\Pacific Headwear",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\Premier Artisan Collection",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\Puma",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\Rabbit Skins",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\REPRIME",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\RETAIL_CATALOG_F22",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\RUSSELL ATHLETIC",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\Spyder",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\Star Tee",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\SUBLIVIE",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\Swannies",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\TEAM 365",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\THREADFAST",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\TIE-DYE",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\TOP OF THE WORLD",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\TRI DRI",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\Ultra Club",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\Ultra Club by CARMEL TOWELS",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\Ultra Club by LIBERTY BAGS",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\Under Armour",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\Union Made",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\Van Heuson",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\Vineyard Vines",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\WALLS FR",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\Weatherproof",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\Yupoong",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\PRIME LINE\Writing",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\PRIME LINE\Apparel",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\PRIME LINE\Bags",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\PRIME LINE\Blankets",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\PRIME LINE\Cover",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\PRIME LINE\Drinkware",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\PRIME LINE\Fitness Wellness",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\PRIME LINE\Gifts",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\PRIME LINE\Hammock",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\PRIME LINE\Headwear",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\PRIME LINE\Housewares",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\PRIME LINE\knives",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\PRIME LINE\Novelties",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\PRIME LINE\Office",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\PRIME LINE\Openers",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\PRIME LINE\Outdoor",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\PRIME LINE\Personal Care",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\PRIME LINE\PPE",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\PRIME LINE\Speakers",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\PRIME LINE\Stationery",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\PRIME LINE\Stress Relievers",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\PRIME LINE\Technology",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\PRIME LINE\Tools",
"\\10.3.0.39\Alpha Broder\ALPHA BRODER IMAGES\PRIME LINE\Travel")

$exclude = @("DNU", "OLD") 
$inc = "*.tif","*.jpg","*.eps","*.psd","*.jpeg","*.tiff"
$upperBound = [DateTime]::Now.Subtract([TimeSpan]::FromMinutes(15))

foreach($path in $paths){
$files = Get-ChildItem -Path "$path\*" -recurse -depth 1 -Include $inc | Where-Object{ 
    $path = $_.FullName.ToUpper() 
    $exclude -notcontains $_.FullName.Split("\")[-2]
} |Select Name,FullName,LastWriteTime

foreach($f in $files)
{
    
    $n=$f.Name
    $fn = $f.FullName
    $pth = $f.FullName
    $nn = $n.split(".")[0]
    $tmp = "$env:TEMP\$nn.png"
    
    
    $values = @{Title="$n";local_path="$fn";}
    
    $imgDetails = $n.replace("_z","").split(".")[0].split("_").replace("-","_").replace(" ","_")
    $data = @{Title="$nn.png";local_path="$fn";local_name="$n";update_metainfo=1;}
    $data["imageangle"]=& {
        if ($n -like "*BK*") {
            "Back"
        } elseif ($n -like "*SD*" -and $n -notlike "*.psd") {
            "Side"
        } elseif ($n -like "*OF1*") {
            "Off Figure"
        } elseif ($n -like "*LSD*") {
            "Left Side"
        } elseif ($n -like "*QRT*") {
            "Quarter"
        } elseif ($n -like "*FF*") {
            "Flat Front"
        } elseif ($n -like "*FB*") {
            "Flat Back"
        } elseif ($n -like "*TOP*") {
            "Top"
        } elseif ($n -like "*OFS*") {
            "Off Figure Side"
        } elseif ($n -like "*OFQ*") {
            "Off Figure Quarter"
        } else {
            "Other"
        }
    }
    if ($n.ToUpper().StartsWith("CAT") -or $n.ToUpper().StartsWith("HOL")) {
        $data["catalog_year"]=$imgDetails[0].ToUpper();
        $data["style_item_number"] = $imgDetails[1].ToUpper();

        if ($imgDetails.Length -ge 2){
            $data["color_code"]=$imgDetails[2];
        }else {
            $data["color_code"]=$imgDetails[1];
        }
       
    } else {
        $data["style_item_number"] = $imgDetails[0];
        if ($imgDetails.Length -ge 2){
            $data["color_code"]=$imgDetails[2];
        }else {
            $data["color_code"]=$imgDetails[1];
        }
    }
    
    if($fn -like "*PRIME LINE*"){
        $brand = $pth.split("\")[6]
        $spfolder = "Assets/Prime Line/$brand/"+$data["style_item_number"]
    }else {
        
        $brand = $pth.split("\")[5]
        $spfolder = "Assets/Styles/$brand/"+$data["style_item_number"]
    }
    
    magick "$fn" -density 72 -colorspace RGB -layers merge -resize 1500x1500 -quality 100 "$tmp"
    Add-PnPFile -Path "$tmp" -Folder "$spfolder" -ContentType "style_item_asset" -values $data 
    Remove-Item "$tmp"
    
}
}

Disconnect-PnPOnline