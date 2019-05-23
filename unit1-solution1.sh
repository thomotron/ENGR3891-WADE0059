a=aufgeschmeckte
b=aufgeschmecktete
c=ausgekaestest
d=ensetzse
e=auftrautete
f=gerauchse
g=gerenner
h=anlaufen
i=gehalts
j=behunder
k=angerennte
l=beschmecken
m=gehundse
n=einkatzeheit
o=angewarfte
p=angekraut
q=aufwitzen
r=aufgewarfen
s=zerlaufen
t=ansetzen
mkdir unit1exercise1
cd unit1exercise1
O="sudo chown"
M="sudo chmod"
mkdir -p $g/$j/$t $b/$i/$s $g/$l/$r $f/$k/$q $g/$j/$p $f/$k/$o $b/$i/$n $f/$m $h $e $d $c $a
$M 542 $g/$j/$t
$M 453 $b/$i/$s
$M 655 $g/$l/$r
$M 653 $f/$k/$q
$M 227 $g/$j/$p
$M 541 $f/$k/$o
$M 421 $b/$i/$n
$M 21 $f/$m
$M 446 $g/$l
$M 625 $f/$k
$M 135 $g/$j
$M 322 $b/$i
$M 434 $h
$M 165 $g
$M 461 $f
$M 712 $e
$M 61 $d
$M 410 $c
$M 522 $b
$M 210 $a
$O student:student $g/$j/$t $b/$i/$s $g/$l/$r $f/$k/$q $g/$j/$p $f/$k/$o $b/$i/$n $f/$m $g/$l $f/$k $g/$j $b/$i $h $g $f $e $d $c $b $a
cd ..
s=student; sudo chown ${s}:$s unit1exercise1
sudo chmod 775 unit1exercise1
sudo tar zcf unit1-solution1.tgz unit1exercise1
sudo rm -fr unit1exercise1
