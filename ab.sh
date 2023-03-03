#!/usr/bin/env bash

# idea from https://www.devside.net/wamp-server/load-testing-apache-with-ab-apache-bench

# if you are testing a base url, you need a trailing slash
SITE="https://192.168.0.110:8443/api/customer/123"
#SITE="https://my.fibank.bg/EBank/dynamic/l10n/bg.json"
OUTFILE="output.txt"
DIVIDER="\n====================================================================\n"

# if the file doesnt exist, make it
touch $OUTFILE;

echo "Benching: $SITE"

echo "1 concurrent user doing 100 page hits"
# first line in the file, use > so we overwrite then >> so we append
echo "1 concurrent user doing 100 page hits" > $OUTFILE
echo "This shows you how well the web-server will handle a simple load of 1 user doing a number of page loads." >> $OUTFILE
# newline spacer
echo -e "" >> $OUTFILE
ab -l -r -n 100 -c 1 -k -H "Accept-Encoding: gzip, deflate" $SITE >> $OUTFILE

# add the divider so we can read this easier
echo -e $DIVIDER >> $OUTFILE

# we are going to sleep after each test to allow the remote server and our machine to calm down
sleep 3

echo "5 concurrent users each doing 10 page hits"
echo "5 concurrent users each doing 10 page hits" >> $OUTFILE
echo "This is 100 page loads by 5 different concurrent users, each user is doing 10 sequential pages loads." >> $OUTFILE
echo "This represents a peak load of a website that gets about 50,000+ hits a month. Congratulations, your website / business / idea has made it (and no doubt is on its way up)." >> $OUTFILE
echo -e "" >> $OUTFILE
ab -l -r -n 50 -c 10 -k -H "Accept-Encoding: gzip, deflate" $SITE >> $OUTFILE

sleep 3

echo -e $DIVIDER >> $OUTFILE

echo "10 concurrent users each doing 10 page hits"
echo "10 concurrent users each doing 10 page hits" >> $OUTFILE
echo "This is 100 page loads by 10 different concurrent users, each user is doing 10 sequential pages loads." >> $OUTFILE
echo "This is where the load starts to really stress test the web-server, as 10 concurrent (simultaneous) users is a lot of traffic. Most websites will be lucky to see 1 or 2 users (visitors) a minute… So let me say it again, 10 users per second is a lot of traffic!" >> $OUTFILE
echo -e "" >> $OUTFILE
ab -l -r -n 100 -c 10 -k -H "Accept-Encoding: gzip, deflate" $SITE >> $OUTFILE

sleep 3

echo -e $DIVIDER >> $OUTFILE

echo "30 concurrent users each doing 20 page hits"
echo "30 concurrent users each doing 20 page hits" >> $OUTFILE
echo "This is 600 page loads by 30 different concurrent users, each user is doing 20 sequential pages loads." >> $OUTFILE
echo "This is the edge of what a non-cached WordPress setup will be able to handle without crashing or timing-out the web-server (and/or ab itself). This type of load represents an extremely active website or forum, the top 1%." >> $OUTFILE
echo -e "" >> $OUTFILE
ab -l -r -n 600 -c 30 -k -H "Accept-Encoding: gzip, deflate" $SITE >> $OUTFILE

sleep 3

echo -e $DIVIDER >> $OUTFILE

echo "90 concurrent users each doing 30 page hits"
echo "90 concurrent users each doing 30 page hits" >> $OUTFILE
echo "This is 2700 page loads by 90 different concurrent users, each user is doing 30 sequential pages loads." >> $OUTFILE
echo "Only a fully cached (using mod_cache) Apache setup will be able to handle this type of a load. This represents some of the busiest sites on the net, and there is no hope of this not maxing out and crashing (if your settings are not just right) the web-server with a non-cached WordPress setup." >> $OUTFILE
echo -e "" >> $OUTFILE
ab -l -r -n 2700 -c 90 -k -H "Accept-Encoding: gzip, deflate" $SITE >> $OUTFILE

sleep 3

echo "Bench Complete."