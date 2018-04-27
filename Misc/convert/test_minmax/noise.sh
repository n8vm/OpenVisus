#!/bin/bash

CONVERT="build/Debug/visusd.exe"
VIEWER="build/Debug/visusviewerd.exe"

BOX="0 1023 0 1023"
DIMS="1024 1024"
MAXH=20

SRC=docs/examples/visus/test_minmax/noise.tif 

DIR=./temp/test_minmax/noise
rm -Rf $DIR*
mkdir -p $DIR

IDX_SRC=$DIR/original.idx
IDX_MAX=$DIR/max.idx
IDX_MIN=$DIR/min.idx

$CONVERT create $IDX_SRC --box "$BOX" --fields "data uint16[1]"
$CONVERT create $IDX_MAX --box "$BOX" --fields "data uint16[2] filter(max)"
$CONVERT create $IDX_MIN --box "$BOX" --fields "data uint16[2] filter(min)"

$CONVERT import $SRC                   export $IDX_SRC --box "$BOX"
$CONVERT import $SRC cast uint16[2]    export $IDX_MAX --box "$BOX"
$CONVERT import $SRC cast uint16[2]    export $IDX_MIN --box "$BOX"

$CONVERT import $IDX_SRC --box "$BOX" --fromh 0 --toh $MAXH export $DIR/original.tif

$CONVERT apply-filters $IDX_MAX
$CONVERT apply-filters $IDX_MIN

# I want to see the image as it is (see --disable-filters)
$CONVERT import $IDX_MAX --box "$BOX" --fromh 0 --toh $MAXH --disable-filters  cast uint16[1] export $DIR/max.disk.tif 
$CONVERT import $IDX_MIN --box "$BOX" --fromh 0 --toh $MAXH --disable-filters  cast uint16[1] export $DIR/min.disk.tif 

# ranges
echo "Ranges for max, min should descrease, max should be stable"
for I in $(seq 0 $MAXH); do $CONVERT import $IDX_MAX --box "$BOX" --fromh 0 --toh $I compute-range "[0]"; done | grep "Range of"

echo "Ranges for min, min should be stable, max should increase"
for I in $(seq 0 $MAXH); do $CONVERT import $IDX_MIN --box "$BOX" --fromh 0 --toh $I compute-range "[0]"; done | grep "Range of"

for I in $(seq 0 $MAXH)
do
   $CONVERT import $IDX_MAX --box "$BOX" --fromh 0 --toh $I cast uint16[1] export $DIR/max.$(printf "%02d" $I).tif
   $CONVERT import $IDX_MIN --box "$BOX" --fromh 0 --toh $I cast uint16[1] export $DIR/min.$(printf "%02d" $I).tif
done


if diff $DIR/original.tif  $DIR/max.$(printf "%02d" $I).tif >/dev/null ; then
  echo OK
else
  echo "ERROR, images not equal"
  echo diff $DIR/original.tif  $DIR/max.$(printf "%02d" $I).tif
  exit -1
fi

if diff $DIR/original.tif  $DIR/min.$(printf "%02d" $I).tif >/dev/null ; then
  echo OK
else
  echo "ERROR, images not equal"
  echo diff $DIR/original.tif  $DIR/min.$(printf "%02d" $I).tif
  exit -1
fi




