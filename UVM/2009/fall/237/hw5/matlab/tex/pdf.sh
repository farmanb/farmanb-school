#!/bin/bash
FILES="*.tex"

for f in $FILES; 
do 
    echo "Processing $f..."
    texi2pdf $f; 
done

PDFS="*.pdf"
AUX="*.aux"
LOG="*.log"

for p in $PDFS
do
    echo "Moving $p..."
    mv $p ../../tex/code
done

echo "Cleaning up..."

for junk in $AUX
do
    rm $junk
done

for junk in $LOG
do
    rm $junk
done
