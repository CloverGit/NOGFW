#!/bin/sh
of="gfwlist.dat"
nf="gfwlist_new.dat"
#wget https://raw.githubusercontent.com/gfwlist/gfwlist/master/gfwlist.txt -O list && base64 -d list >> $nf && rm list
wget https://raw.githubusercontent.com/gfwlist/tinylist/master/tinylist.txt -O list && base64 -d list >> $nf && rm list
if [ -f $of ];then
   diff $of $nf > /dev/null
      if [ $? -eq 0 ]; then
         rm $nf
      else
         mv $of "gfwlist_`stat -c %Y $of`.dat"
         mv $nf $of
      fi	
else
   mv $nf $of
fi
cat $of|grep "Tiny List Start" -A 2147483647|grep "General List End" -B 2147483647|grep -v "\!\!\-\-\-"|grep -v "###"|grep -v "\.\.\."|sed '1d;/^$/d;s/%2F/\//g;s/@//g;s/!--//g;s/|//g;s/^\.//g;s/\/$//g;s/htt\w\+:\/\///g;s/\/.\{0,\}//g'|sort -k2n|uniq>url.dat
cat special.dat>>url.dat
