a=angehundte
b=aufsitzs
c=einsteht
d=aufgekaestest
e=verhaltst
f=angerabarbtest
g=angepflumtest
h=einspracher
i=ansinns
j=vertrauer
k=zerwitzen
l=angetraut
m=verhalter
n=verhaltkeit
o=gewitzen
p=aufschmecktete
q=auskatzete
r=einwarfen
s=enrauchen
t=aufpflumte
mkdir unit1exercise4
cd unit1exercise4
O="sudo chown"
M="sudo chmod"
mkdir -p $d/$l/$t $d/$l/$s $g/$j/$r $g/$j/$q $f/$i/$p $d/$l/$o $c/$m/$n $f/$k $h $e $b $a
$M 66 $d/$l/$t
$M 2030 $d/$l/$s
$M 2434 $g/$j/$r
$M 2176 $g/$j/$q
$M 737 $f/$i/$p
$M 2645 $d/$l/$o
$M 2256 $c/$m/$n
$M 2345 $c/$m
$M 2406 $d/$l
$M 240 $f/$k
$M 2317 $g/$j
$M 220 $f/$i
$M 2603 $h
$M 2743 $g
$M 2653 $f
$M 300 $e
$M 2667 $d
$M 2333 $c
$M 2756 $b
$M 2617 $a
$O student:dip $d/$l/$t $e
$O student:cdrom $d/$l/$s $d/$l $f/$k
$O student:audio $g/$j/$r $g/$j/$q $c/$m/$n $b
$O student:voice $f/$i/$p $g $f
$O student:fax $d/$l/$o $f/$i
$O student:floppy $c/$m $g/$j $d
$O student:tape $h
$O student:news $c
$O student:uucp $a
cd ..
s=student; sudo chown ${s}:$s unit1exercise4
sudo chmod 775 unit1exercise4
sudo tar zcf unit1-solution4.tgz unit1exercise4
sudo rm -fr unit1exercise4
