D=unit1exercise4
mkdir $D
cd $D
p=(ausgehaltse aufkraute einwarfung auspflumer zerwarfte aufgesitzs berabarbung anschmecker aufkraute/enkletttete zerwarfte/ausgewarfse ausgehaltse/ausgekaesung anschmecker/ansprachtete berabarbung/zerpflumtete ausgehaltse/ausgekaesung/ansinnheit ausgehaltse/ausgekaesung/zersinnt berabarbung/zerpflumtete/eintrittkeit ausgehaltse/ausgekaesung/verrennst zerwarfte/ausgewarfse/aufrabarbt aufkraute/enkletttete/gekaeser berabarbung/zerpflumtete/angekatzese)
m=(2371 2413 504 255 2400 003 2075 2574 230 2725 473 764 2526 320 2253 2150 621 2675 747 076)
g=(audio voice voice tape cdrom audio voice student proxy floppy floppy student proxy news proxy cdrom audio audio tape fax)
S=student
for i in {0..19}; do
    install -d ${p[$i]} -m ${m[$i]} -o $S -g ${g[$i]}
done
cd ..
chown $S:$S $D
chmod 775 $D
tar caf unit1-solution4.tgz $D
