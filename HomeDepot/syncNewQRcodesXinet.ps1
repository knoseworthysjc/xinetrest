$team = "HomeDepotContent"
$url = "https://sjccontent.sharepoint.com/teams/$team"
$conn = Connect-PnPOnline -Tenant sjccontent.onmicrosoft.com -ClientId "$Env:sharepointclientid" -Thumbprint "$Env:sharepointthumbprint"  -url $url

#Get-PnPFile -URL "/qrcode_images/_28934_102979_EN.svg" -Path "\\10.136.209.199\HomeDepot\HotFolders" -FileName "_28934_102979_EN.svg" -AsFile
$now = [DateTime]::Now.Subtract([TimeSpan]::FromHours(1))

$d =  Get-Date $now -Format s

$files = Get-PnPListItem -List "qrcode_images" -Query "<View><ViewFields><FieldRef Name='Title'/><FieldRef Name='Modified'/></ViewFields><Query><Where><Gt><FieldRef Name='Modified'/><Value Type='DateTime' IncludeTimeValue='TRUE'>$d</Value></Gt></Where></Query></View>"
$files | ForEach-Object -Process {
    $t = $_.FieldValues.Title
    Get-PnPFile -URL "/qrcode_images/$t" -Path "\\10.136.209.199\HomeDepot\Master Assets\QR Codes" -FileName "$t" -AsFile
}
