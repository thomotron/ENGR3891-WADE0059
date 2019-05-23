a=enspracht
b=befahrse
c=aussteht
d=einwarfs
e=ausrennse
f=zerkatzet
g=ensinnse
h=ausgesinner
i=angesitzte
j=aufgeschmeckt
k=ausschmeckse
l=aufgewarfst
m=angewarfte
n=ausgekrautete
o=begehse
p=gegehte
q=aufsetzs
r=anrenner
s=einhunder
t=angehaltt
mkdir unit1exercise3
cd unit1exercise3
O="sudo chown"
M="sudo chmod"
mkdir -p $h/$i/$t $h/$i/$s $b/$l/$r $h/$m/$q $a/$k/$p $h/$i/$o $h/$m/$n $a/$j $g $f $e $d $c
$M 747 $h/$i/$t
$M 4621 $h/$i/$s
$M 371 $b/$l/$r
$M 206 $h/$m/$q
$M 510 $a/$k/$p
$M 4027 $h/$i/$o
$M 4002 $h/$m/$n
$M 4655 $h/$m
$M 465 $b/$l
$M 4723 $a/$k
$M 745 $a/$j
$M 4142 $h/$i
$M 4605 $h
$M 4471 $g
$M 554 $f
$M 4354 $e
$M 4561 $d
$M 4601 $c
$M 417 $b
$M 4361 $a
$O student:cdrom $h/$i/$t
$O nobody:mail $h/$i/$s
$O student:uucp $b/$l/$r
$O news:uucp $h/$m/$q
$O lp:tape $a/$k/$p
$O news:news $h/$i/$o $f
$O student:tape $h/$m/$n
$O student:news $h/$m
$O lp:student $b/$l
$O nobody:cdrom $a/$k
$O news:cdrom $a/$j
$O student:proxy $h/$i
$O mail:tape $h
$O lp:voice $g
$O lp:audio $e
$O mail:dip $d
$O proxy:cdrom $c
$O nobody:dip $b
$O mail:student $a
cd ..
s=student; sudo chown ${s}:$s unit1exercise3
sudo chmod 775 unit1exercise3
sudo tar zcf unit1-solution3.tgz unit1exercise3
sudo rm -fr unit1exercise3
