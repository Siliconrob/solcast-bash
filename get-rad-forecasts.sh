#!/bin/bash
while getopts i:o: option
do
 case "${option}"
 in
 i) inputFile=${OPTARG};;
 o) output=${OPTARG};;
 *)echo "Invalid arguments"; exit -1;
 esac
done

if [[ ! -z $inputFile ]]
then
    echo "${inputFile}"
else
    echo "Please specify an input file";
    exit 99;
fi

if [[ ! -z $output ]]
then
    echo "Creating output directory: ${output}";
    mkdir ${output};
fi

OLDIFS=$IFS
IFS=,
i=1
while read name lat lng
do
	test $i -eq 1 && ((i=i+1)) && continue;
	echo "$name ($lat, $lng)";
	curl -X GET -H 'Accept: text/csv' "${SOLCAST_API_URL}/radiation/forecasts?longitude=${lat}&latitude=${lng}&api_key=${SOLCAST_API_KEY}" >> "./${output}/${name}_$(date +%Y%m%d-%H%M%S).csv";
done < $inputFile
IFS=$OLDIFS
