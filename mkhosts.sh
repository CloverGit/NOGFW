#!/bin/sh
if [ -f "hosts" ];then
    mv hosts "hosts_`stat -c %Y hosts`"
fi
if [ -f "faild" ];then
    mv faild "faild_`stat -c %Y faild`"
fi
for url in `cat $PWD/url.dat`
do
#out=`ping -c 1 $url | grep -o -P "(\d+\.)(\d+\.)(\d+\.)\d+" | sed -n 1p`
do=`nslookup $url`
#out=`echo $do|grep -o -P "(\d+\.)(\d+\.)(\d+\.)\d+"|sed -n 3p`
if [ `echo "$do"|grep -i "can't">/dev/null;echo $?` -ne 0 ];then
    out=`echo $do|grep -o -P "(\d+\.)(\d+\.)(\d+\.)\d+"|sed -n 3p`
    echo $out $url
    echo $out $url >> $PWD/hosts
else
    echo ping $url fail
    echo $url >>  $PWD/faild
fi
done
