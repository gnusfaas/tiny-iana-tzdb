#!/bin/sh
# // -----------------------------------------------------------------------------
# /// \file                  tz-strip-new.sh
# /// \brief                 Shell script to strip down the standard tzdata
# ///                        tzdata: http://www.iana.org/time-zones
# /// \author                Sreejith.Naarakathil@gmail.com
# // -----------------------------------------------------------------------------

# Remove old log files
rm -f tz_omitted.txt
rm -f tz_included.txt

# Insert a blank line above every line which matches "Zone" or "Link" or '# Rule' at the begining of line
cat tzr.txt |     sed '/^\;\;/d' | while read tzr;
do
    sed -i '/^Zone/{x;p;x;G;}' $tzr
    sed -i '/^Link/{x;p;x;G;}' $tzr
    sed -i '/^# Rule/{x;p;x;G;}' $tzr
done;

# Remove all lines starting with pattern ';;#'
# Extract all lines starting with pattern ';;'
# Remove ';;' pattern from all lines
# Remove space from the start of the line
cat zn.txt | \
    sed '/^\;\;#/d' | \
    sed -n '/^\;\;/p' | \
    sed 's/;;//g' | \
    sed 's/^[ \t]*//' > tz_included.txt;

# Remove all lines starting with pattern ';;' and all blank lines
# Read one time zone at a time to tz1
# Log the omitted time zone names to tz_omitted.txt for reference
# Add escape charector to all time zone strings read to variable tz. Eg: Asia/Kolkata -> Asia\/Kolkata
# Read one time zone region at a time to tzr
# Comment out every line starting with pattern "Zone" or "Link" in the selected time zone region
# Comment out the selected time zone entry in the file 'backward'
# Read one time zone region at a time to tzr
# Comment out complete time zone section of every line starting with pattern "#Zone"
cat zn.txt | \
    sed '/^\;\;/d' | \
    sed '/^$/d' | \
    while read tz1;
do
    echo $tz1 >> tz_omitted.txt
    tz=$(echo $tz1 | sed 's/\//\\\//g');
    cat tzr.txt |     sed '/^\;\;/d' | while read tzr;
    do
        sed -i '/^Zone.*'"$tz"'/s/^/#/g' $tzr;
        sed -i '/^Link.*'"$tz"'/s/^/#/g' $tzr;
    done;
    sed -i '/'"$tz"'/s/^/#/g' backward;
done;
cat tzr.txt |     sed '/^\;\;/d' | while read tzr;
do
    sed -i '/^#Zone/,/^$/ {/^#Zone/n;/^$/ !{s/^/#/g}}' $tzr
done;

