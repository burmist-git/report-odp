#!/bin/bash

########################################################################
#                                                                      #
# Copyright(C) 2017 - LBS - (Single person developer.)                 #
# Tue Oct  2 17:58:17 JST 2018                                         #
# Autor: Leonid Burmistrov                                             #
#                                                                      #
# File description:                                                    #
#                  This script compresses pdf.                         #
#                                                                      #
# Input paramete:                                                      #
#                   NON.                                               #
#                                                                      #
# This software is provided "as is" without any warranty.              #
#                                                                      #
########################################################################

function compressPdf_bash {

    #    -dPDFSETTINGS=/screen lower quality, smaller size. (72 dpi)
    #    -dPDFSETTINGS=/ebook for better quality, but slightly larger pdfs. (150 dpi)
    #    -dPDFSETTINGS=/prepress output similar to Acrobat Distiller "Prepress Optimized" setting (300 dpi)
    #    -dPDFSETTINGS=/printer selects output similar to the Acrobat Distiller "Print Optimized" setting (300 dpi)
    #    -dPDFSETTINGS=/default selects output intended to be useful across a wide variety of uses, possibly at the expense of a larger output file

    echo "$1 : $2"
    output=$2"_$1.pdf"
    gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/$1 -dNOPAUSE -dQUIET -dBATCH -sOutputFile=$output $2

}

function mergePdf {

    cmd="gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=repOdpAll.pdf repOdp.pdf repOdp28.08.2018.pdf repOdp13.11.2018.pdf"
    echo $cmd
    $cmd
    
}

function dividePdf {
    
    cmd="gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER -dFirstPage=1 -dLastPage=5 -sOutputFile=febtemp_h2_feb_t1_01.pdf febtemp_h2_feb_t1.pdf"
    echo $cmd
    $cmd
    cmd="gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER -dFirstPage=6 -dLastPage=10 -sOutputFile=febtemp_h2_feb_t1_02.pdf febtemp_h2_feb_t1.pdf"
    echo $cmd
    $cmd
    
}

function printHelp { 
 
    echo " --> ERROR in input arguments <-- "
    echo " [0] -l  : Lower quality, smaller size (72 dpi)."
    echo " [0] -b  : Better quality, but slightly larger pdfs (150 dpi)."
    echo " [0] -p  : Output similar to Acrobat Distiller -Prepress Optimized- setting (300 dpi)."
    echo " [0] -o  : Output similar to Acrobat Distiller -Print Optimized- setting (300 dpi)."
    echo " [0] -d  : Output intended to be useful across a wide variety of uses, possibly at the expense of a larger output file."
    echo " [0] -a  : All."
    echo " [1]     : Input file."
    echo " [0] -m  : merge pdfs"
    echo " [0] -di : divide pdf"
    
    return 1

}

if [ $# -eq 0 ]
then   
    printHelp

elif [ $# -eq 1 ]
then
    if [ "$1" = "-m" ]
    then
	mergePdf
    elif [ "$1" = "-di" ]
    then
	dividePdf
    else
	printHelp
    fi
else
    if [ "$1" = "-l" ]
    then
	compressPdf_bash screen $2
    elif [ "$1" = "-b" ]
    then
	compressPdf_bash ebook $2
    elif [ "$1" = "-p" ]
    then
	compressPdf_bash prepress $2
    elif [ "$1" = "-o" ]
    then
	compressPdf_bash printer $2
    elif [ "$1" = "-d" ]
    then
	compressPdf_bash default $2
    elif [ "$1" = "-a" ]
    then
	compressPdf_bash screen $2
	compressPdf_bash ebook $2
	compressPdf_bash prepress $2
	compressPdf_bash printer $2
	compressPdf_bash default $2
    else	
	printHelp 
    fi
fi
