#!/bin/sh
echo "This shows what is 'living' underneath the icons in the finder"
echo "Press ENTER to start"
read

defaults read com.apple.finder \
	|awk '/TB Item Plists/,/TB Size Mode/' \
	|grep _CFURLString\" \
	|cut -d\= -f2 |tee /tmp/showToolbar.$$

ls -l /tmp/showToolbar.$$

cat /tmp/showToolbar.$$ | while read line; do
  FILE=`echo $line | sed -e 's/^.*localhost/"/' |sed -e 's/;//' | sed -e 's/%20/ /g'`
  echo file: $FILE
  if [ ! -r $FILE ]; then
      echo "WARNING: file $FILE doesn't exist"
  fi
done


