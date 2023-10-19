mkdir pub

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

$FMSats = "AO-91","AO-92","ISS","PO-101","SO-50","Tevel-1","Tevel-2","Tevel-3","Tevel-4","Tevel-5","Tevel-6","Tevel-7","Tevel-8","UVSQ-SAT","INSPIRE-Sat 7","LILACSAT-2"
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
$FMKeps = $FMKeps.replace("AO-91","AO-91 FM 435.250 145.960 67.0")
$FMKeps = $FMKeps.replace("AO-92","AO-92 FM 435.350 145.880 67.0")
$FMKeps = $FMKeps.replace("ISS","ISS FM 145.990 437.800 67.0")
$FMKeps = $FMKeps.replace("PO-101","PO-101 FM 437.500 145.900 141.3")
$FMKeps = $FMKeps.replace("SO-50","SO-50 FM 145.850 436.795 67.0 2s 74.4")
$FMKeps = $FMKeps.replace("Tevel-1","Tevel-1 FM 145.970 436.400")
$FMKeps = $FMKeps.replace("Tevel-2","Tevel-2 FM 145.970 436.400")
$FMKeps = $FMKeps.replace("Tevel-3","Tevel-3 FM 145.970 436.400")
$FMKeps = $FMKeps.replace("Tevel-4","Tevel-4 FM 145.970 436.400")
$FMKeps = $FMKeps.replace("Tevel-5","Tevel-5 FM 145.970 436.400")
$FMKeps = $FMKeps.replace("Tevel-6","Tevel-6 FM 145.970 436.400")
$FMKeps = $FMKeps.replace("Tevel-7","Tevel-7 FM 145.970 436.400")
$FMKeps = $FMKeps.replace("Tevel-8","Tevel-8 FM 145.970 436.400")
$FMKeps = $FMKeps.replace("UVSQ-SAT","UVSQ-SAT FM 145.905 437.020")
$FMKeps = $FMKeps.replace("INSPIRE-Sat 7","INSPIRE-Sat 7 FM 145.970 437.410")
$FMKeps = $FMKeps.replace("LILACSAT-2","LilacSat-2 (CAS-3H) FM 144.350 437.200")

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
