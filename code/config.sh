#!/usr/bin/env bash

if [ $# -eq 0 ]; then
    echo "No arguments supplied"
else
  echo "args:"
  for i in $*; do 
    echo $i 
  done
  echo ""
fi

some_fastq=$(find -L ../data -name "*.f*q*" | head -1)
echo "some_fastq: $some_fastq"

outTmpDir="../results/temp"

# STAR
if [ -z "${1}" ]; then
  num_threads=$(get_cpu_count)
else
  if [ "${1}" -gt $(get_cpu_count) ]; then
    echo "Requesting more threads than available. Setting to Max Available."
    num_threads=$(get_cpu_count)
  else
    num_threads="${1}"
  fi
fi

if [ -z "${2}" ]; then
  genome_file=$(find -L ../data -name "SAindex")
  genome_dir=$(dirname "${genome_file}")
else
  genome_dir="${2}"
fi 

if [ -z "${3}" ]; then
  pattern_fwd="_$(get_read_pattern "$some_fastq" --fwd)"
else
  pattern_fwd="${3}"
fi

if [ -z "${4}" ]; then
  pattern_rev="_$(get_read_pattern "$some_fastq" --rev)"
else
  pattern_rev="${4}"
fi

# STAR Alignment Parameters

if [ -z "${5}" ]; then
  readFilesCommand="zcat"
else
  readFilesCommand="${5}"
fi

if [ -z "${6}" ]; then
  outSAMsort="SortedByCoordinate"
else
  outSAMsort="${6}"
fi

if [ -z "${7}" ]; then
  quantMode="-"
else
  quantMode="${7}"
fi

if [ -z "${8}" ]; then
  outReadsUnmapped="None"
else
  outReadsUnmapped="${8}"
fi

if [ -z "${9}" ]; then
  chimOutType="WithinBAM HardClip"  # For some reason the documentation lists Junctions as the default, but it totally isn't anymore.
else
  chimOutType="${9}"
fi

if [ -z "${10}" ]; then
  two_pass="None"
else
  two_pass="${10}"
fi

if [ -z "${11}" ]; then
  shared_memory="False"
else
  shared_memory="${11}"
fi

if [ -z "${12}" ]; then
  limitBAMsortRAM=10000000000
else
  limitBAMsortRAM=$((${12} * 1000000000))
fi


