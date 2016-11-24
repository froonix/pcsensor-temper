#!/bin/bash

# Legacy script to tweet temp values.
# Only a simple example from my sys.

LC_NUMERIC=C

typeset -i tse
tse=$(date +%s)
typeset -i tss
tss=$tse-3600

cd /var/lib/munin/Misc || exit 1

max=$(rrdtool graph /dev/null -s "$tss" -e "$tse" \
	DEF:v1=room1-temper_0-temp-g.rrd:42:MAX \
	DEF:v2=room2-temper_0-temp-g.rrd:42:MAX \
	PRINT:v1:MAX:%lf \
	PRINT:v2:MAX:%lf \
	| tail -n +2)
max=$(sort -n -r <<< "$max" | head -n 1)
max=$(printf "%.2f" "$max" | sed 's/\./,/')

min=$(rrdtool graph /dev/null -s "$tss" -e "$tse" \
	DEF:v1=room1-temper_0-temp-g.rrd:42:MIN \
	DEF:v2=room2-temper_0-temp-g.rrd:42:MIN \
	PRINT:v1:MIN:%lf \
	PRINT:v2:MIN:%lf \
	| tail -n +2)
min=$(sort -n <<< "$min" | head -n 1)
min=$(printf "%.2f" "$min" | sed 's/\./,/')

avg=$(rrdtool graph /dev/null -s "$tss" -e "$tse" \
	DEF:v1=room1-temper_0-temp-g.rrd:42:AVERAGE \
	DEF:v2=room2-temper_0-temp-g.rrd:42:AVERAGE \
	PRINT:v1:AVERAGE:%lf \
	PRINT:v2:AVERAGE:%lf \
	| tail -n +2 \
	| awk '{ total += $1; count++ } END { print total/count }')
avg=$(printf "%.2f" "$avg" | sed 's/\./,/')

if [[ "$max" != "" && "$min" != "" && "$avg" != "" ]]
then
	ttytter -ssl -keyf=-example -status="Temperaturwerte der letzten Stunde: $min / $avg / $max °C (min/avg/max)" &> /dev/null && exit 0
else
	echo "Data source ERROR!"
	exit 2
fi

echo "Twitter update FAILED!"
exit 1
