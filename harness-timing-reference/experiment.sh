#!/bin/bash
make clean
make all

rm -r results
rm $(uname -n).tar.gz

mkdir results

echo $HOSTNAME > results/hostname.txt
lscpu > results/lscpu.txt
uname -a > results/uname.txt
cat /proc/cpuinfo > results/cpuinfo.txt
cp /boot/config* results/
dmesg > results/dmesg.txt
gcc -v 2> results/gccv.txt
top -b -n 1 > results/top.txt

./harness -b 50000000 -w 50000 -i 10
mv intervals.data results/b50M_w50K_i10.data 

./harness -b 50000000 -w 50000 -i 20
mv intervals.data results/b50M_w50K_i20.data

./harness -b 50000000 -w 50000 -i 50
mv intervals.data results/b50M_w50K_i50.data

./harness -b 50000000 -w 50000 -i 100
mv intervals.data results/b50M_w50K_i100.data

tar -czvf $(uname -n).tar.gz results
rm -r results
