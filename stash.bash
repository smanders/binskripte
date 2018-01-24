#!/bin/bash
while getopts a option
do
  case "${option}"
  in
    a) ATOMIC=true
  esac
done

for vid in `ls -1 *.m4v *.mp4 2>/dev/null`;
do
  date=`echo $vid | cut -d _ -f2 | tr -d 'v'`
  tim=20${date}1200
  if [ "$ATOMIC" = true ]
  then
    yr=`echo $date | cut -c1-2`
    mo=`echo $date | cut -c3-4`
    da=`echo $date | cut -c5-6`
    utc=20${yr}-${mo}-${da}T12:00:00Z
    echo $utc : $tim : $vid
    if ! AtomicParsley ${vid} --year "${utc}" --purchaseDate "${utc}" --overWrite
    then
      if ! AtomicParsley ${vid} --year "${utc}" --purchaseDate "${utc}"
      then
        FAILURE=true
      fi
    fi
    AtomicParsley ${vid} -t
  else
    echo $tim : $vid
  fi
  touch -t $tim $vid
done

for pic in `ls -1 *.pdf *.cbz 2>/dev/null`;
do
  date=`echo $pic | cut -d _ -f2 | tr -d 'p'`
  tim=20${date}1200
  echo $tim : $pic
  touch -t $tim $pic
done

if [ "$ATOMIC" = true ]
then
  if [ "$FAILURE" = true ]
  then
    echo "!!" AtomicParsley FAIL
  fi
  for tmp in `ls -1 *-temp-*.mp4 *-temp-*.m4v 2>/dev/null`;
  do
    echo "!!" AtomicParsley overwrite error: $tmp
  done
fi
