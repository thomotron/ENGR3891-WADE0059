M='mkdir -m'
D=unit1exercise1
$M 775 $D
cd $D
$M 536 angeraucher
$M 266 aussetzte
$M 771 angetrautest
$M 651 enschmeckse
$M 154 zerfahrer
$M 664 angekraust
$M 344 angehunds
$M 006 aufpflumheit
$M 616 aussetzte/gehundte
$M 305 angehunds/angesitzt
$M 700 aufpflumheit/ausgekaesen
$M 537 angekraust/geschmecken
$M 502 angekraust/enkatzetete
$M 363 angehunds/angesitzt/auspflums
$M 644 angehunds/angesitzt/aussetzt
$M 025 angehunds/angesitzt/angeschmecken
$M 255 angehunds/angesitzt/aufgerennen
$M 416 angehunds/angesitzt/getrauen
$M 270 aufpflumheit/ausgekaesen/eingehen
$M 145 angehunds/angesitzt/aufsetztete
S=student
chown -R $S:$S ./
cd ..
tar caf unit1-solution1.tgz $D
