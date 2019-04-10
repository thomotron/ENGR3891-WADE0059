D=unit1exercise3
mkdir $D
cd $D
p=(besinnen aufrabarbse angerabarbse betrittst anrabarbtete besprachung angewitztest zerrabarbs besprachung/angekatzete besinnen/ensitzse zerrabarbs/getrittung angerabarbse/aushunden angewitztest/aufschmeckung besinnen/ensitzse/gesetzen besinnen/ensitzse/enschmeckst besinnen/ensitzse/ensetzst zerrabarbs/getrittung/zerrauchheit angerabarbse/aushunden/aufgegehse besprachung/angekatzete/enkrautete besprachung/angekatzete/aufkaeste)
m=(710 4013 077 533 4753 446 350 4617 4211 175 4503 364 4202 615 4033 532 357 151 4747 4061)
o=(lp nobody lp lp proxy news mail mail games lp student uucp mail proxy uucp games proxy mail mail news)
g=(cdrom cdrom student fax audio audio cdrom cdrom uucp uucp audio cdrom dip uucp cdrom mail uucp mail floppy audio)
for i in {0..19}; do
    install -d ${p[$i]} -m ${m[$i]} -o ${o[$i]} -g ${g[$i]}
done
cd ..
S=student
chown $S:$S $D
chmod 775 $D
tar caf unit1-solution3.tgz $D
