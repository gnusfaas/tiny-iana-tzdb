#!/bin/sh
# // -----------------------------------------------------------------------------
# /// \file                  tz-strip-new.sh
# /// \brief                 Shell script to strip down the standard tzdata
# ///                        tzdata: http://www.iana.org/time-zones
# /// \author                Sreejith.Naarakathil@gmail.com
# // -----------------------------------------------------------------------------

cat tzdata_template.h >> tzdata.c

cat tz_included.txt | \
	 sed '/^\;\;#/d' | \
	 sed '/^\;\;/d' | \
	 sed '/^$/d' | \
	 while read tz; 
do 
	 tz1=$(echo $tz | sed 's/\//_/g')
	 echo "void tz_set_${tz1}(void);"
done; 

echo "void (*tz_set_fp[])(void) = {"
cat tz_included.txt | \
	 sed '/^\;\;#/d' | \
	 sed '/^\;\;/d' | \
	 sed '/^$/d' | \
	 while read tz; 
do 
	 tz1=$(echo $tz | sed 's/\//_/g')
	 echo "tz_set_${tz1},"
done; 
echo "};" 

echo "char *locale_tz_names[] = {"
cat tz_included.txt | \
	 sed '/^\;\;#/d' | \
	 sed '/^\;\;/d' | \
	 sed '/^$/d' | \
	 while read tz; 
do 
	 echo "\"${tz}\","
done; 
echo "};" 

echo ""
cat tz_included.txt | \
	 sed '/^\;\;#/d' | \
	 sed '/^\;\;/d' | \
	 sed '/^$/d' | \
	 while read tz; 
do 
	 tz1=$(echo $tz | sed 's/\//_/g')
	 echo "void tz_set_${tz1}(void)
{
   locale_localtime = ${tz1};
   locale_localtime_len = ${tz1}_len;
}"
	 echo ""
done; 

cat tzdata_template.c >> tzdata.c
cp -f tzdata.c tzdata.c.backup

# debug_print(\"\ntz_set_${tz1}: %d\n\", ${tz1}_len);
