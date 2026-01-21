#!/bin/bash
# CLI-only log analysis script
set -e

# Directories
RAW=log_analysis/raw
WORK=log_analysis/work
RESULTS=log_analysis/results

# Copy raw log to work folder
cp $RAW/sample.log $WORK/sample.log

# Extract errors
grep " ERROR " $WORK/sample.log > $RESULTS/errors.txt || true

# Extract warnings
grep " WARNING " $WORK/sample.log > $RESULTS/warnings.txt || true

# Sort chronologically
sort $WORK/sample.log > $RESULTS/chronological.log

# Create summary
echo "Analysis run on $(date)" > $RESULTS/summary.txt
echo "Total INFO messages: $(grep -c ' INFO ' $WORK/sample.log)" >> $RESULTS/summary.txt
echo "Total WARNING messages: $(grep -c ' WARNING ' $WORK/sample.log)" >> $RESULTS/summary.txt
echo "Total ERROR messages: $(grep -c ' ERROR ' $WORK/sample.log)" >> $RESULTS/summary.txt
