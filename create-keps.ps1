mkdir pub

$BareTLE = Invoke-WebRequest -Uri "https://www.amsat.org/tle/dailytle.txt"
if($BareTLE.StatusCode -ne 200)
{
    Write-Error "Failed to download keps from AMSAT. Stopping!"
    exit
}

$LinearSats = "RS-44","AO-07","FO-29","JO-97","AO-73"
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

$FMSats = "AO-91","ISS","PO-101","SO-50","LILACSAT-2","TEVEL2-1","TEVEL2-2","TEVEL2-3","TEVEL2-4","TEVEL2-5","TEVEL2-6","TEVEL2-7","TEVEL2-8","HADES-R (SO-124)","HADES-ICM (SO-125)"
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
$FMKeps = $FMKeps.replace("TEVEL2-1","Tevel2-1 FM 145.970 436.400")
$FMKeps = $FMKeps.replace("TEVEL2-2","Tevel2-2 FM 145.970 436.400")
$FMKeps = $FMKeps.replace("TEVEL2-3","Tevel2-3 FM 145.970 436.400")
$FMKeps = $FMKeps.replace("TEVEL2-4","Tevel2-4 FM 145.970 436.400")
$FMKeps = $FMKeps.replace("TEVEL2-5","Tevel2-5 FM 145.970 436.400")
$FMKeps = $FMKeps.replace("TEVEL2-6","Tevel2-6 FM 145.970 436.400")
$FMKeps = $FMKeps.replace("TEVEL2-7","Tevel2-7 FM 145.970 436.400")
$FMKeps = $FMKeps.replace("TEVEL2-8","Tevel2-8 FM 145.970 436.400")
$FMKeps = $FMKeps.replace("HADES-R (SO-124)","HADES-R (SO-124) FM 145.925 436.885")
$FMKeps = $FMKeps.replace("HADES-ICM (SO-125)","HADES-ICM (SO-125) FM 145.875 436.666")

$FMKeps | Out-File pub/fm.txt

$DigiSats = "IO-117","LEDSAT","NO-44","SONATE-2"
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
$DigiKeps = $DigiKeps.replace("SONATE-2","SONATE-2 APRS 145.825")

$DigiKeps | Out-File pub/digi.txt
