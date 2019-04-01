D=unit1exercise2
mkdir $D
cd $D
I='install -d'
$I aufgegeht -m 351 -o uucp -g dip
$I angetrittte -m 756 -o proxy -g tape
$I angehaltung -m 363 -o mail -g uucp
$I angesprachs -m 110 -o lp -g proxy
$I gefahrte -m 653 -o news -g voice
$I versetztete -m 471 -o mail -g uucp
$I ausgesitztest -m 134 -o student -g voice
AGK=angekatzetete
$I $AGK -m 051 -o nobody -g fax
$I $AGK/angehaltst -m 153 -o news -g proxy
$I angehaltung/angewitzkeit -m 621 -o student -g voice
$I $AGK/besinns -m 044 -o nobody -g student
$I angehaltung/ausgewarfst -m 630 -o news -g tape
$I gefahrte/ausfahrtete -m 057 -o nobody -g student
$I angehaltung/angewitzkeit/einfahren -m 675 -o mail -g news
$I $AGK/angehaltst/verrauchst -m 032 -o mail -g student
$I angehaltung/angewitzkeit/aufgesinnt -m 116 -o games -g dip
$I $AGK/angehaltst/enwitzkeit -m 641 -o games -g mail
$I gefahrte/ausfahrtete/ausgetrautest -m 572 -o proxy -g news
$I $AGK/besinns/angehunden -m 400 -o lp -g tape
$I $AGK/angehaltst/einrauchs -m 623 -o mail -g news
cd ..
S=student
chown $S:$S $D
chmod 775 $D
tar caf unit1-solution2.tgz $D
