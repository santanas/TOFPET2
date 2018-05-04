#!/bin/bash
if [ $# -lt 4 ] 
then 
    echo "$0: Not enough arguments"
    echo "4 arguments required: configuration file, running mode (qcd or tot), time (s), output file name"
    echo "Example: ./run_TOFPET.sh config.ini qdc 60 data/output/test_04_05_2018"
    exit 0
    fi
if [  $# -gt 4 ]
then 
    echo "$0: Too many arguments"
    echo "4 arguments required: configuration file, running mode (qcd or tot), time (s), output file name"
    echo "Example: ./run_TOFPET.sh config.ini qdc 60 data/output/test_04_05_2018"
    exit 0
    fi

CONFIG=$1
MODE=$2
TIME=$3
OUTPUT=$4"_"$2_$3

printf "\n"
echo "Starting run..."
echo ./acquire_sipm_data --config $CONFIG --mode $MODE --time $TIME -o $OUTPUT
./acquire_sipm_data --config $CONFIG --mode $MODE --time $TIME -o $OUTPUT
echo "End run." 
printf "\n"

echo "Creating root file (singles)..."
echo ./convert_raw_to_singles --config $CONFIG -i $OUTPUT -o $OUTPUT"_singles.root" --writeRoot
./convert_raw_to_singles --config $CONFIG -i $OUTPUT -o $OUTPUT"_singles.root" --writeRoot
echo "File created."
printf "\n"

echo "Creating root file (coincidences)..."
echo ./convert_raw_to_coincidence --config $CONFIG -i $OUTPUT -o $OUTPUT"_coincidences.root" --writeRoot
./convert_raw_to_coincidence --config $CONFIG -i $OUTPUT -o $OUTPUT"_coincidences.root" --writeRoot
echo "File created."
printf "\n"
