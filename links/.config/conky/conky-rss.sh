#!/bin/bash
# RSS Display Script by Bill Woodford (admin@sdesign.us) v1.0
#
# This script is designed to output story titles for most any RSS Feed.
#
# This script depends on curl.  Please ensure it is installed and in your $PATH
# Gentoo: emerge -av net-misc/curl
# Debian: apt-get install curl
# Homepage: http://curl.haxx.se/
#
# Usage:
# .conkyrc:	${execi [time] /path/to/script/conky-rss.sh URI LINES TITLENUM}
#	URI = Location of feed, ex. http://www.gentoo.org/rdf/en/glsa-index.rdf
#	LINES = How many titles to display (default 5)
#	TITLENUM = How many times the title of the feed itself is specified, usually 1 or 2 (default 2)
#
# Usage Example		
#		${execi 300 /home/youruser/scripts/conky-rss.sh http://www.foxnews.com/xmlfeed/rss/0,4313,1,00.rss 4 2}

# Feeds:
# http://feeds.wired.com/wired/index
# http://www.spiegel.de/schlagzeilen/tops/index.rss
# http://www.cnet.com/rss/news/
# http://rss.cnn.com/rss/edition_technology.rss

#RSS Setup - Don't change unless you want these values hard-coded!
uri=$1							#URI of RSS Feed
lines=$2						#Number of headlines
titlenum=$3						#Number of extra titles

#Script start
#Require a uri, as a minimum
if [[ "$uri" == "" ]]; then
	echo "No URI specified, cannot continue!" >&2
	echo "Please read script for more information" >&2
else
	#Set defaults if none specified
	if [[ $lines == "" ]]; then lines=5 ; fi
	if [[ $titlenum == "" ]]; then titlenum=2 ; fi

	#The actual work
	wget -O- -q $uri |\
	sed -e 's/<\/title>/\n/g' |\
	grep -o '<title>.*' |\
	sed -e 's/<title>//' |\
	head -n $(($lines + $titlenum)) |\
	tail -n $(($lines)) |\
	perl -n -mHTML::Entities -e ' binmode(STDOUT, ":utf8"); print HTML::Entities::decode_entities($_) ;'
fi