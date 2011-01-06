#!/bin/bash
# Author: Murilo Santana
# Google url shortener bash script
# For information about the url shortener app:
# http://ggl-shortener.appspot.com/instructions/

app='http://ggl-shortener.appspot.com/?url='
url="$1"
protocol=`echo "$1" | sed -e "/^http:\/\//g"`

if [ -z "$1" ];
then
echo -e "you need to pass the url through an argument";
echo -e "e.g. `basename $0` http://url";
else
if [ ! "$protocol" ]; then
curl -s "$app$url" | sed -e 's/{"short_url":"//' -e 's/"}/\n/g'
else
repl=`echo "$1" | sed -e 's/^/http:\/\//g'`
curl -s "$app$repl" | sed -e 's/{"short_url":"//' -e 's/{"error_message":"Bad request/error: bad request/' -e 's/"}/\n/g'
fi;
fi
