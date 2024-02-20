#!/bin/sh
echo "This shows what is 'living' underneath the icons in the finder"
echo "Press ENTER to start"
read

if [ "`uname -s`" != "Darwin" ]; then
  echo "This only works on macOS"
  exit
fi

# first, try with older version of macOS

defaults read com.apple.finder \
	|awk '/TB Item Plists/,/TB Size Mode/' \
	|grep _CFURLString\" \
	|cut -d\= -f2 |tee /tmp/showToolbar.$$

if [ -s /tmp/showToolbar.$$ ]; then
   cat /tmp/showToolbar.$$ | while read line; do
     FILE=`echo $line | sed -e 's/^.*localhost/"/' |sed -e 's/;//' | sed -e 's/%20/ /g' |sed -e 's/^"//' -e 's/"$//'`
     echo file: $FILE
     if [ ! -r "$FILE" ]; then
         echo "WARNING: file $FILE doesn't exist"
     fi
   done
else

   # try with newer macOS
   echo "These are the things on your Dock:"
   defaults read com.apple.dock \
    |grep '_CFURLString"' \
    |cut -d= -f2
fi




