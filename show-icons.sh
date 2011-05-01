#!/bin/sh
echo "This shows what is 'living' underneath the icons in the finder"
read

defaults read com.apple.finder \
	|awk '/TB Item Plists/,/TB Size Mode/' \
	|grep _CFURLString\" \
	|cut -d\= -f2

