#!/bin/bash


test=$(find . -maxdepth 1 -type d -regextype sed -regex ".*" | cut -c 3-)

echo $test

echo "no sort"
a=($(echo "$test" | tr ',' '\n' ))

echo "${a[0]}"
echo "${a[1]}"
echo "${a[2]}"
echo "${a[3]}"
echo "======================================"
echo "after sort"

a=($(echo "$test" | tr ',' '\n' | sort -g ))

echo "${a[0]}"
echo "${a[1]}"
echo "${a[2]}"
echo "${a[3]}"

echo "lenth of the array: "
echo "${#a[@]}"

#### loop 1

cd "${a[0]}"

cp -f ./forceCoeffs_bins.dat ../forceCoeffs_bins.dat.tmp
cp -f ./forceCoeffs.dat ../forceCoeffs.dat.tmp

latestTime=$(tac forceCoeffs.dat |egrep -m 1 . | head -n1 | awk '{print $1;}')

echo $latestTime

nextLine=1
pwd

cd ..



cd "${a[1]}"

latestTimeLineNum=$(grep -nw $latestTime forceCoeffs.dat |gawk '{print $1}' FS=":")


echo "The latestTime is :"

echo $latestTimeLineNum
(( latestTimeLineNum += nextLine))
echo $latestTimeLineNum

sed -n "$latestTimeLineNum,$ p" forceCoeffs.dat >> ../forceCoeffs.dat.tmp

cd ..

#### try to loop

cd "${a[2]}"

pwd

latestTime=$(tac ../forceCoeffs.dat.tmp |egrep -m 1 . | head -n1 | awk '{print $1;}')

echo $latestTime

latestTimeLineNum=$(grep -nw $latestTime forceCoeffs.dat |gawk '{print $1}' FS=":")

echo "==="

echo $latestTimeLineNum
(( latestTimeLineNum += nextLine))
echo $latestTimeLineNum

sed -n "$latestTimeLineNum,$ p" forceCoeffs.dat >> ../forceCoeffs.dat.tmp

cd ..

#### try to loop 3

cd "${a[3]}"

pwd

latestTime=$(tac ../forceCoeffs.dat.tmp |egrep -m 1 . | head -n1 | awk '{print $1;}')

echo $latestTime

latestTimeLineNum=$(grep -nw $latestTime forceCoeffs.dat |gawk '{print $1}' FS=":")

echo "==="

echo $latestTimeLineNum
(( latestTimeLineNum += nextLine))
echo $latestTimeLineNum

sed -n "$latestTimeLineNum,$ p" forceCoeffs.dat >> ../forceCoeffs.dat.tmp