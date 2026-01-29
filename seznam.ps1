cls

# pomucka, vsechny soubory (jen soubory) v adresari $cesta do textoveho seznamu $output
Set-PSDebug -Strict

$cesta = "C:\Users\DELL\Documents\zaloha\" # tady editovat
$pole_soubory = @(); $pole_adresare = @(); $pole_output = @()

$pole_adresare += Get-ChildItem -Path $cesta -Directory -Name
$d_pole_adresare = $pole_adresare.Length

$pole_soubory += Get-ChildItem -Path $cesta -File -Name
$d_pole_soubory = $pole_soubory.Length

$pole_output += "# ---------------- ADRESARE" # je adresare v ceste $cesta
for ( $aa = 0; $aa -le $d_pole_adresare -1; $aa++ ) {
$adresar = '"' + $pole_adresare[$aa] + '",'
#echo $adresar
$pole_output += $adresar
}

$pole_output += "# ---------------- SOUBORY" # jen soubory tamtez
# v souboru  "zalohovani_adresaru_na_DVD-RW.ps1" v premmenny $pole_zalohovat
# ale muze to bejt i prohazene soubory nebo adresare, jak je libo toto je jedno (toto je pouze pro lepsi prehlednost a snazsi vyber)
for ( $bb = 0; $bb -le $d_pole_soubory -1; $bb++ ) {
$soubor = '"' + $pole_soubory[$bb] + '",'
#echo $soubor
$pole_output += $soubor
}

$d_pole_output = $pole_output.Length
for ( $cc = 0; $cc -le $d_pole_soubory -1; $cc++ ) {
$output = $pole_output[$cc]
echo $output
}

$output_file = "seznam.txt"
Remove-Item $output_file -ErrorAction SilentlyContinue
sleep 1

Set-Content -Path $output_file  -Encoding ASCII -Value $pole_output

$out_1 = "seznam vsech souboru a podadresaru v adresari "
$out_1 += '"' + $cesta + '"' +  " byl ulozen do souboru " + '"' + $output_file + '"'
echo ""
Write-Host -ForegroundColor Yellow $out_1
sleep 10

# vybrat stoho co je potreba a vlozit to do souboru "zalohovani_adresaru_na_DVD-RW.ps1" do premenny $pole_zalohovat
# pozn. posledni radek $pole_zalohovat neobsahuje carku na konci, protoze za tim uz nic nejni
# to ale z tohohle seznamu nevypliva co bude posledni taky jsou carky vsude
