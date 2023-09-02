$NASAbare = Invoke-WebRequest -Uri "http://www.amsat.org/amsat/ftp/keps/current/nasabare.txt"
if($NASAbare.StatusCode -ne 200)
{
    Write-Error "Failed to download keps from AMSAT. Stopping!"
    exit
}

$LinearSats = "RS-44","AO-07","FO-29","JO-97"
$LinearKeps = ""
foreach($Sat in $LinearSats)
{
    if($NASAbare.Content -match "$Sat\n(.*)\n(.*)\n")
    {
        $LinearKeps += $Matches[0]
    }
    else {
        Write-Warning "No match found for $Sat"
    }
}
$LinearKeps | Out-File pub/linear.txt

$FMSats = "AO-91","ISS","PO-101","SO-50"
$FMKeps = ""
foreach($Sat in $FMSats)
{
    if($NASAbare.Content -match "$Sat\n(.*)\n(.*)\n")
    {
        $FMKeps += $Matches[0]
    }
    else {
        Write-Warning "No match found for $Sat"
    }
}
$FMKeps | Out-File pub/fm.txt

$DigiSats = "IO-117","LEDSAT"
$DigiKeps = ""
foreach($Sat in $DigiSats)
{
    if($NASAbare.Content -match "$Sat\n(.*)\n(.*)\n")
    {
        $DigiKeps += $Matches[0]
    }
    else {
        Write-Warning "No match found for $Sat"
    }
}
$DigiKeps | Out-File pub/digi.txt
