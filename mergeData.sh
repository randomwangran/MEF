#!/bin/bash


test=$(find . -maxdepth 1 -type d -regextype sed -regex '.*' -not -path '*/\.*' | cut -c 3-)

echo $test

echo "Analysing your postProcessing folder ..."
a=($(echo "$test" | tr ',' '\n' ))

# echo "${a[0]}"
# echo "${a[1]}"
# echo "${a[2]}"
# echo "${a[3]}"
# echo "======================================"
# echo "after sort"

a=($(echo "$test" | tr ',' '\n' | sort -g ))

echo "You have: ${#a[@]} time folders:"

echo "${a[0]}"
echo "${a[1]}"
echo "${a[2]}"
echo "${a[3]}"

# echo "lenth of the array: "
# echo "${#a[@]}"

echo "Creating the tmp data"

cd "${a[0]}"
pwd

cp -f ./forceCoeffs_bins.dat ../forceCoeffs_bins.dat.tmp
cp -f ./forceCoeffs.dat ../forceCoeffs.dat.tmp
cd ..

pwd

#### loop inital: find the latest time in the 0 folder

cd "${a[0]}"

echo "I am in the folder: "

pwd

latestTime=$(tac forceCoeffs.dat |egrep -m 1 . | head -n1 | awk '{print $1;}')

echo "The latest time in this time folder is $latestTime"

nextLine=1

cd ..

######## loop 1

cd "${a[1]}"

pwd

latestTime=$(tac ../forceCoeffs.dat.tmp |egrep -m 1 . | head -n1 | awk '{print $1;}')

latestTimeLineNum=$(grep -nw $latestTime forceCoeffs.dat |gawk '{print $1}' FS=":")

(( latestTimeLineNum += nextLine))

echo "The latestTime is at line : $latestTimeLineNum"

sed -n "$latestTimeLineNum,$ p" forceCoeffs.dat >> ../forceCoeffs.dat.tmp

cd ..

######## loop 2

cd "${a[2]}"

pwd

latestTime=$(tac ../forceCoeffs.dat.tmp |egrep -m 1 . | head -n1 | awk '{print $1;}')

latestTimeLineNum=$(grep -nw $latestTime forceCoeffs.dat |gawk '{print $1}' FS=":")

(( latestTimeLineNum += nextLine))

echo "The latestTime is at line : $latestTimeLineNum"

sed -n "$latestTimeLineNum,$ p" forceCoeffs.dat >> ../forceCoeffs.dat.tmp

cd ..

#### try to loop 3

cd "${a[3]}"

pwd

latestTime=$(tac ../forceCoeffs.dat.tmp |egrep -m 1 . | head -n1 | awk '{print $1;}')

latestTimeLineNum=$(grep -nw $latestTime forceCoeffs.dat |gawk '{print $1}' FS=":")

(( latestTimeLineNum += nextLine))

echo "The latestTime is at line : $latestTimeLineNum"

sed -n "$latestTimeLineNum,$ p" forceCoeffs.dat >> ../forceCoeffs.dat.tmp

cd ..

pwd

echo "Done"
