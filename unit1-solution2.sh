D=unit1exercise2
mkdir $D
cd $D
p=(aufgegeht angetrittte angehaltung angesprachs gefahrte versetztete ausgesitztest angekatzetete angekatzetete/angehaltst angehaltung/angewitzkeit angekatzetete/besinns angehaltung/ausgewarfst gefahrte/ausfahrtete angehaltung/angewitzkeit/einfahren angekatzetete/angehaltst/verrauchst angehaltung/angewitzkeit/aufgesinnt angekatzetete/angehaltst/enwitzkeit gefahrte/ausfahrtete/ausgetrautest angekatzetete/besinns/angehunden angekatzetete/angehaltst/einrauchs)
m=(351 756 363 110 653 471 134 051 153 621 044 630 057 675 032 116 641 572 400 623)
o=(uucp proxy mail lp news mail student nobody news student nobody news nobody mail mail games games proxy lp mail)
g=(dip tape uucp proxy voice uucp voice fax proxy voice student tape student news student dip mail news tape news)
for i in {0..19}; do
    install -d ${p[$i]} -m ${m[$i]} -o ${o[$i]} -g ${g[$i]}
done
cd ..
S=student
chown $S:$S $D
chmod 775 $D
tar caf unit1-solution2.tgz $D
