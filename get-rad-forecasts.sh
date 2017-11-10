#!/bin/bash
INPUT=sample_latlngs.csv
OLDIFS=$IFS
IFS=,
[ ! -f $INPUT ] && { echo "$INPUT file not found"; exit 99; }
i=1
solcast_outdir="solcast_results"
mkdir ${solcast_outdir}
while read name lat lng
do
	test $i -eq 1 && ((i=i+1)) && continue;
	echo "$name ($lat, $lng)";
	curl -X GET -H 'Accept: text/csv' "${SOLCAST_API_URL}/radiation/forecasts?longitude=${lat}&latitude=${lng}&api_key=${SOLCAST_API_KEY}" >> "./${solcast_outdir}/${name}_$(date +%Y%m%d-%H%M%S).csv";
done < $INPUT
IFS=$OLDIFS
