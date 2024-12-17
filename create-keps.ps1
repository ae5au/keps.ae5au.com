mkdir pub

$BareTLE = Invoke-WebRequest -Uri "https://www.amsat.org/tle/dailytle.txt"
if($BareTLE.StatusCode -ne 200)
{
    Write-Error "Failed to download keps from AMSAT. Stopping!"
    exit
}

$LinearSats = "RS-44","AO-07","FO-29","JO-97"
$LinearKeps = ""
foreach($Sat in $LinearSats)
{
    if($BareTLE.Content -match "$Sat\n(.*)\n(.*)\n")
    {
        $LinearKeps += $Matches[0]
    }
    else {
        Write-Warning "No match found for $Sat"
    }
}
$LinearKeps | Out-File pub/linear.txt

$FMSats = "AO-91","ISS","PO-101","SO-50","LILACSAT-2"
$FMKeps = ""
foreach($Sat in $FMSats)
{
    if($BareTLE.Content -match "$Sat\n(.*)\n(.*)\n")
    {
        $FMKeps += $Matches[0]
    }
    else {
        Write-Warning "No match found for $Sat"
    }
}
$FMKeps = $FMKeps.replace("AO-91","AO-91 FM 435.250 145.960 67.0")
$FMKeps = $FMKeps.replace("ISS","ISS FM 145.990 437.800 67.0")
$FMKeps = $FMKeps.replace("PO-101","PO-101 FM 437.500 145.900 141.3")
$FMKeps = $FMKeps.replace("SO-50","SO-50 FM 145.850 436.795 67.0 2s 74.4")
$FMKeps = $FMKeps.replace("LILACSAT-2","LilacSat-2 (CAS-3H) FM 144.350 437.200")

$FMKeps | Out-File pub/fm.txt

$DigiSats = "IO-117","LEDSAT","NO-44"
$DigiKeps = ""
foreach($Sat in $DigiSats)
{
    if($BareTLE.Content -match "$Sat\n(.*)\n(.*)\n")
    {
        $DigiKeps += $Matches[0]
    }
    else {
        Write-Warning "No match found for $Sat"
    }
}
$DigiKeps | Out-File pub/digi.txt
