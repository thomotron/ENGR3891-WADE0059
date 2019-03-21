D=unit1exercise1
mkdir -m 775 $D
cd $D
mkdir -m 210 verkaesung
mkdir -m 575 zerfahrte
mkdir -m 005 angeklettheit
mkdir -m 640 enrauchheit
mkdir -m 171 ausgepflumen
mkdir -m 076 auswitzst
mkdir -m 151 angeschmecken
mkdir -m 263 aufsprachkeit
mkdir -m 354 ausgepflumen/aushundkeit
mkdir -m 566 angeschmecken/auftrittheit
mkdir -m 012 angeklettheit/gewarfs
mkdir -m 372 angeschmecken/zerstehheit
mkdir -m 277 zerfahrte/ausgegehheit
mkdir -m 667 ausgepflumen/aushundkeit/aufsteher
mkdir -m 552 angeschmecken/zerstehheit/gesitzer
mkdir -m 123 ausgepflumen/aushundkeit/anhaltheit
mkdir -m 065 zerfahrte/ausgegehheit/angekraust
mkdir -m 407 angeklettheit/gewarfs/ankaesen
mkdir -m 726 zerfahrte/ausgegehheit/angetritten
mkdir -m 635 angeschmecken/auftrittheit/ausgeschmeckte
S=student
chown -R $S:$S ./
cd ..
tar caf $D.tgz $D
