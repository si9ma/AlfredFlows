#!/bin/bash

LIST_FORMAT='{"items":[%s]}'
ITEM_FORMAT='{"uid":"%s","title":"%s","subtitle":"%s","arg":"%s"}'
scale=`echo $1 | head -c 1`
var=${1#?}

[ "$scale" = "b" ] && scale=2
[ "$scale" = "h" ] && scale=16 && var=`echo $var | awk '{ print toupper($0) }'`
[ "$scale" = "o" ] && scale=8
[ "$scale" = "d" ] && scale=10

for i in 2 8 10 16
do
	[ "$scale" -eq "$i" ] && continue
	uid=$i
	title=`echo "obase=$i;ibase=$scale;${var}" | bc -l`
	subtitle="${i}进制"
	[ "$items" != "" ] && items="$items,"
	items="${items}$(printf $ITEM_FORMAT $uid $title $subtitle $title)"
done

printf "$LIST_FORMAT" "$items"