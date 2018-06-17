#!/bin/bash

test=$(find . -maxdepth 1 -type d -regextype sed -regex '.*' -not -path '*/\.*' | cut -c 3-)

echo "Analysing your postProcessing folder ..."

a=($(echo "$test" | tr ',' '\n' | sort -g ))

echo "You have: ${#a[@]} time folders:"

for ((i=0; i<${#a[@]}; i++))

do
    echo "${a[i]}"

done

echo "====================="

echo "Creating the tmp data"

cd "${a[0]}"

cp -f ./forceCoeffs.dat ../forceCoeffs.dat.tmp

cd ..

#### loop inital: find the latest time in the 0 folder

cd "${a[0]}"

latestTime=$(tac forceCoeffs.dat |egrep -m 1 . | head -n1 | awk '{print $1;}')

echo "The latest time before merging is $latestTime"

nextLine=1

cd ..

######## loop all the time data

for ((i=1; i<${#a[@]}; i++))

do
    
    cd "${a[i]}"

    echo "I am entering the folder:  ${PWD##*/}"
    
    latestTime=$(tac ../forceCoeffs.dat.tmp |egrep -m 1 . | head -n1 | awk '{print $1;}')

    latestTimeLineNum=$(grep -nw $latestTime forceCoeffs.dat |gawk '{print $1}' FS=":")

    (( latestTimeLineNum += nextLine))

    echo "The latestTime is at line : $latestTimeLineNum"

    sed -n "$latestTimeLineNum,$ p" forceCoeffs.dat >> ../forceCoeffs.dat.tmp

    if [ $i -eq 1 ]
    then
        echo "Processing data"
    else
    	echo "The latest time before merging is $latestTime"
    fi
	
    cd ..

done

echo "The forece.dat has been merged."
#=== merge bin data

echo "Working on bin data"

test=$(find . -maxdepth 1 -type d -regextype sed -regex '.*' -not -path '*/\.*' | cut -c 3-)

echo "Analysing your postProcessing folder ..."

abin=($(echo "$test" | tr ',' '\n' | sort -g ))

echo "You have: ${#abin[@]} time folders:"

for ((j=0; j<${#abin[@]}; j++))

do
    echo "${abin[j]}"

done

echo "====================="

echo "Creating the tmp data"

cd "${abin[0]}"

cp -f ./forceCoeffs_bins.dat ../forceCoeffs_bins.dat.tmp

cd ..

#### loop inital: find the latest time in the 0 folder

cd "${abin[0]}"

latestTime=$(tac forceCoeffs.dat |egrep -m 1 . | head -n1 | awk '{print $1;}')

echo "The latest time before merging is $latestTime"

nextLine=1

cd ..

######## loop all the time data

for ((j=1; j<${#abin[@]}; j++))

do
    
    cd "${abin[j]}"

    echo "I am entering the folder:  ${PWD##*/}"
    
    latestTime=$(tac ../forceCoeffs_bins.dat.tmp |egrep -m 1 . | head -n1 | awk '{print $1;}')

    latestTimeLineNum=$(grep -nw $latestTime forceCoeffs_bins.dat |gawk '{print $1}' FS=":")

    (( latestTimeLineNum += nextLine))

    echo "The latestTime is at line : $latestTimeLineNum"

    sed -n "$latestTimeLineNum,$ p" forceCoeffs_bins.dat >> ../forceCoeffs_bins.dat.tmp

    if [ $j -eq 1 ]
    then
        echo "Processing data"
    else
    	echo "The latest time before merging is $latestTime"
    fi
	
    cd ..

done

echo "The forece_bins.dat has been merged."
