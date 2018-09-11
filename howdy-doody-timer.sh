#!/bin/bash

# howdy-doody-timer by Christian Kollross 2018

# Call this script from the crontab of a Raspberry Pi 
# to wake up with a daily video podcast

# Feed URL - The first <enclosure> will be played back (not necessarily the latest episode)
feed="https://www.tagesschau.de/export/video-podcast/webxl/tagesschau_https/"

# Switch on the TV
echo "on 0" | cec-client -s

# Switch to the correct HDMI input
echo "tx 4F:82:30:00" | cec-client -s

# Load and parse the feed, play the video
tmpfile="/tmp/hdtfeed.xml"
wget -O ${tmpfile} ${feed}
url=$(xmllint ${tmpfile} --xpath "string(/rss/channel/item/enclosure/@url)")
rm ${tmpfile}
omxplayer ${url}

# Switch off the TV
echo "standby 0" | cec-client -s

# FIN
