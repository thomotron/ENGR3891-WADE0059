a=angefahren
b=auflaufst
c=vertrittheit
d=angerabarbst
e=besinntest
f=aufgesinner
g=angetrause
h=anrauchen
i=betrittte
j=getrittse
k=aufgefahrtest
l=auflaufkeit
m=einlaufung
n=besetzse
o=angetrauer
p=angesprachst
q=enrauchtete
r=verrennse
s=aufgewarfung
t=aufgeklettte
mkdir unit1exercise2
cd unit1exercise2
O="sudo chown"
M="sudo chmod"
mkdir -p $h/$m/$t $f/$j/$s $h/$m/$r $h/$m/$q $h/$m/$p $f/$l/$o $h/$m/$n $a/$k $g/$i $e $d $c $b
$M 264 $h/$m/$t
$M 40 $f/$j/$s
$M 226 $h/$m/$r
$M 405 $h/$m/$q
$M 367 $h/$m/$p
$M 162 $f/$l/$o
$M 667 $h/$m/$n
$M 615 $h/$m
$M 447 $f/$l
$M 674 $a/$k
$M 600 $f/$j
$M 622 $g/$i
$M 7 $h
$M 207 $g
$M 12 $f
$M 673 $e
$M 360 $d
$M 737 $c
$M 506 $b
$M 743 $a
$O student:dip $h/$m/$t
$O proxy:audio $f/$j/$s
$O student:student $h/$m/$r
$O uucp:fax $h/$m/$q
$O student:news $h/$m/$p
$O student:uucp $f/$l/$o $g/$i
$O proxy:news $h/$m/$n
$O news:cdrom $h/$m
$O news:news $f/$l $c
$O games:voice $a/$k
$O lp:tape $f/$j
$O games:cdrom $h
$O games:floppy $g
$O proxy:floppy $f
$O proxy:voice $e
$O news:uucp $d
$O uucp:mail $b
$O proxy:dip $a
cd ..
s=student; sudo chown ${s}:$s unit1exercise2
sudo chmod 775 unit1exercise2
sudo tar zcf unit1-solution2.tgz unit1exercise2
sudo rm -fr unit1exercise2
