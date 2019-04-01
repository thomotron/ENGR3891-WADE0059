mkdir unit1exercise2
cd unit1exercise2
install -d aufgegeht -m 351 -o uucp -g dip
install -d angetrittte -m 756 -o proxy -g tape
install -d angehaltung -m 363 -o mail -g uucp
install -d angesprachs -m 110 -o lp -g proxy
install -d gefahrte -m 653 -o news -g voice
install -d versetztete -m 471 -o mail -g uucp
install -d ausgesitztest -m 134 -o student -g voice
install -d angekatzetete -m 051 -o nobody -g fax
install -d angekatzetete/angehaltst -m 153 -o news -g proxy
install -d angehaltung/angewitzkeit -m 621 -o student -g voice
install -d angekatzetete/besinns -m 044 -o nobody -g student
install -d angehaltung/ausgewarfst -m 630 -o news -g tape
install -d gefahrte/ausfahrtete -m 057 -o nobody -g student
install -d angehaltung/angewitzkeit/einfahren -m 675 -o mail -g news
install -d angekatzetete/angehaltst/verrauchst -m 032 -o mail -g student
install -d angehaltung/angewitzkeit/aufgesinnt -m 116 -o games -g dip
install -d angekatzetete/angehaltst/enwitzkeit -m 641 -o games -g mail
install -d gefahrte/ausfahrtete/ausgetrautest -m 572 -o proxy -g news
install -d angekatzetete/besinns/angehunden -m 400 -o lp -g tape
install -d angekatzetete/angehaltst/einrauchs -m 623 -o mail -g news
cd ..
chown student:student unit1exercise2
chmod 775 unit1exercise2
tar caf unit1-solution2.tgz unit1exercise2
