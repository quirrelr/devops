#!/bin/bash

c1_back=$(awk 'NR==1{print substr($0, 20, 1)}' color.config )
c1_fore=$(awk 'NR==2{print substr($0, 20, 1)}' color.config )
c2_back=$(awk 'NR==3{print substr($0, 20, 1)}' color.config )
c2_fore=$(awk 'NR==4{print substr($0, 20, 1)}' color.config )

if [ -z "$c1_back" ] ; then c1_back=7 fi
if [ -z "$c1_fore" ] ; then c1_fore=6 fi
if [ -z "$c2_back" ] ; then c2_back=6 fi
if [ -z "$c2_fore" ] ; then c2_fore=6 fi

if [ "$c1_back" -ne "$c1_fore" ] && [ "$c2_back" -ne "$c2_fore" ] ; then

FOREGROUND_NAME=$(( 30 + $(./num_to_col.sh $c1_back) ))
BACKGROUND_NAME=$(( 40 + $(./num_to_col.sh $c1_fore) ))
FOREGROUND_VALUE=$(( 30 + $(./num_to_col.sh $c2_back) ))
BACKGROUND_VALUE=$(( 40 + $(./num_to_col.sh $c2_fore) ))
./printing.sh $FOREGROUND_NAME $BACKGROUND_NAME $FOREGROUND_VALUE $BACKGROUND_VALUE

#if [ $c1_back > 6 ]; then out_c1_back="default" ;;

echo "Column 1 background = $c1_back"
echo "./color_from_num.sh $c1_back"
echo "Column 1 font color = $c1_fore"
echo "Column 2 background = $c1_back"
echo "Column 2 font color = $c1_fore"
else echo "ERROR: Foreground and background colors can't be the same."
fi
