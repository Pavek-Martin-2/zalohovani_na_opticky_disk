cls
# automatizace zalohovani na dvd-rw

$dvd_jednotka = "D:"
# cd %USERPROFILE%\AppData\Local\Microsoft\Windows\Burn\Burn
$burn_folder = "C:\Users\DELL\AppData\Local\Microsoft\Windows\Burn\Burn\" # burn folder
$cesta_zaloha = "C:\Users\DELL\Documents\zaloha\"

$pole_zalohovat = @( # vsechno dohromady jednotlive soubory i adresare a sam pozna co je co podle rozdelovace
"bookmarks.rar",
"dvd_katalog.rar",
"firefox_hesla.rar",
"CHIRP.rar",
"login.rar",
"motiv_moje_aktualni.deskthemepack",
"mpv-x86_64_mpv 0.34.0-373-g0044c19f0d.rar",
"SAVEDATA.rar",
"segway_kolobezka_moje.rar",
"y.rar",
"iso.rar",
"CB-PMR.rar",
"dosbox-0.74-3.conf",
"fuse.rar",
"Garmin.rar"
"login",
"ruzne",
"save_hry",
"moje_prace",
"tapety"
)

# prazdne $pole_zalohovat
$d_pole_zalohovat = $pole_zalohovat.Length
if ($d_pole_zalohovat -eq 0 ){
echo "neni co zalohovat"
sleep 5
exit
}

$pole_soubory = @()
$pole_adresare = @()

for ( $aa = 0; $aa -le $d_pole_zalohovat -1; $aa++ ) {
$polozka_pole_zalohovat = $pole_zalohovat[$aa]
$nalezeno_rozdelovac = $polozka_pole_zalohovat.IndexOf(".")
# paklize NEnalezne rozdelovac promenna $nalezeno_rozdelovac nabyde hodnoty -1 (pro adresare)
# vsechno ostatni bude vyhodnocovat jako soubor ( neco.txt, index.html, neco.c )
# atd. rozdelovac neni vzdy ctvrtej znak od konce, takze proste jenom hleda tecku

#echo $polozka_pole_zalohovat
#echo $nalezeno_rozdelovac

if ( $nalezeno_rozdelovac -eq -1 ){
$pole_adresare += $polozka_pole_zalohovat
}else{
$pole_soubory += $polozka_pole_zalohovat
}
}

$d_pole_adresare = $pole_adresare.Length
#echo $pole_adresare[$d_pole_adresare -1] # posledni polozka

$d_pole_soubory = $pole_soubory.Length
#echo $pole_soubory[$d_pole_soubory -1] # posledni polozka

$b1 = "green"
$b2 = "red"
$b3 = "cyan"
$b4 = "yellow"
# ruzne pokusi o pouzit dvd-tools, ImbBurn apod. viz. AI_scr/ selhali ( takze toto se dela rucne )
Write-Host -ForegroundColor $b2 "DVD-RW" -NoNewline
Write-Host -ForegroundColor $b1 " by melo byt predem" -NoNewline
Write-Host -ForegroundColor $b2 " SMAZANE"
Write-Host -ForegroundColor $b1 "v pruzkumnikovy kliknout ve slozce" -NoNewline
Write-Host -ForegroundColor $b2 " Tento pocitac" -NoNewline
Write-Host -ForegroundColor $b1 " pravim tlacitkem mysi na polozku" -NoNewline
Write-Host -ForegroundColor $b2 " Jednotka DVD RW (D:)"
Write-Host -ForegroundColor $b1  "a nasledne v menu vybrat" -NoNewline
Write-Host -ForegroundColor $b2 " Smazat tento disk"
echo ""

# pause
Read-Host -Prompt "Press ENTER to continue"


# vycisteni vypalovaci fronty (pro jistotu)
Write-Host -ForegroundColor $b2 "cistim vypalovaci frontu"
Remove-Item "$burn_folder\*" -Force -Recurse # vycisteni fronty (smaze celou slozku burn)
Write-Host -ForegroundColor $b2 "vypalovaci fronta vycistena"
sleep 2

$d_pole_adresare = $pole_adresare.Length
#echo $pole_adresare[$d_pole_adresare] # posledni polozka

Write-Host -ForegroundColor $b3 "kopiruji adresare do vypalovaci fronty"
for ( $bb = 0; $bb -le $d_pole_adresare -1; $bb++ ) {
#Copy-Item "C:\Users\DELL\Documents\zaloha\dvd_katalog\" -Destination "$burn_folder\dvd_katalog\" -Recurse # vzor
$str_1 = ""
$str_1 += $cesta_zaloha
$str_1 += $pole_adresare[$bb]
$str_1 += "\"

$str_2 = ""
$str_2 += $burn_folder
$str_2 += $pole_adresare[$bb]
$str_2 += "\"

Write-Host -ForegroundColor $b1 '"' -NoNewline
Write-Host -ForegroundColor $b1 $str_1 -NoNewline
Write-Host -ForegroundColor $b1 '"' -NoNewline
Write-Host -ForegroundColor $b1 " -> " -NoNewline
Write-Host -ForegroundColor $b1 '"' -NoNewline
Write-Host -ForegroundColor $b1 $str_2 -NoNewline
Write-Host -ForegroundColor $b1 '"'

Copy-Item $str_1 -Destination $str_2 -Recurse
sleep 1
}

Write-Host -ForegroundColor $b3 "kopirovani adresaru do vypalovaci fronty bylo dokonceno"

$d_pole_soubory = $pole_soubory.Length
echo $pole_soubory[$d_pole_soubory] # posledni polozka


Write-Host -ForegroundColor $b3 "kopiruji soubory do vypalovaci fronty"
for ( $cc = 0; $cc -le $d_pole_soubory -1; $cc++ ) {
# Copy-Item "C:\Users\DELL\Documents\zaloha\bookmarks.html" -Destination $burn_folder # vzor 2
$str_3 = ""
$str_3 += $cesta_zaloha
$str_3 += $pole_soubory[$cc]

Write-Host -ForegroundColor $b1 '"' -NoNewline
Write-Host -ForegroundColor $b1 $str_3 -NoNewline
Write-Host -ForegroundColor $b1 '"' -NoNewline
Write-Host -ForegroundColor $b1 " -> " -NoNewline
Write-Host -ForegroundColor $b1 '"' -NoNewline
Write-Host -ForegroundColor $b1 $burn_folder -NoNewline
Write-Host -ForegroundColor $b1 '"'

Copy-Item $str_3 -Destination $burn_folder -Recurse
sleep 1
}

Write-Host -ForegroundColor $b4 "kopirovani souboru do vypalovaci fronty bylo dokonceno"

Write-Host -ForegroundColor $b1 "klikni pravim tlacitekem mysi v nesledujicim otevrenem okne a zvol polozku" -NoNewline
Write-Host -ForegroundColor $b2 " Vypalit na disk"
sleep 10

# taky rucne
# otevre onko pruzkumniku na jednotce D: uz je tam vse pripravene a uz jenom dat pravou mysi "Vypalit na disk"
Start-Process -FilePath "explorer.exe" $dvd_jednotka

