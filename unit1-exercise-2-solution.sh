D=unit1exercise2
mkdir $D
cd $D
install -o proxy -g dip -m 406 -d zersetzkeit
install -o nobody -g floppy -m 144 -d begehen
install -o proxy -g proxy -m 614 -d einhaltt
install -o mail -g fax -m 014 -d angegehkeit
install -o lp -g voice -m 217 -d bewitzs
install -o student -g floppy -m 212 -d aufgewitzheit
install -o student -g student -m 545 -d ausgehtest
install -o lp -g floppy -m 406 -d angekaess
install -o mail -g tape -m 047 -d begehen/berabarbkeit
install -o mail -g audio -m 703 -d zersetzkeit/enkletts
install -o lp -g fax -m 054 -d angekaess/zersprachen
install -o news -g mail -m 731 -d bewitzs/auffahrse
install -o proxy -g voice -m 163 -d angekaess/angesinnheit
install -o lp -g cdrom -m 052 -d angekaess/angesinnheit/aufgelaufkeit
install -o mail -g news -m 057 -d angekaess/angesinnheit/ausgekletttete
install -o mail -g audio -m 102 -d zersetzkeit/enkletts/gerabarbse
install -o lp -g voice -m 565 -d angekaess/angesinnheit/einrabarber
install -o proxy -g tape -m 054 -d bewitzs/auffahrse/ausgewarfkeit
install -o nobody -g fax -m 603 -d begehen/berabarbkeit/ausgerabarbung
install -o lp -g dip -m 425 -d angekaess/zersprachen/engehtete
cd ..
chown student:student $D
chmod 775 $D
tar caf unit1-solution2.tgz $D
