#!/bin/bash

# Define paths
LOGDIR=~/data_pipeline/logs
PREPROCESS_LOG=$LOGDIR/preprocess.log
SUMMARY_LOG=$LOGDIR/monitor_summary.log

echo "==============================" >> $SUMMARY_LOG
echo "$(date): Starting log monitoring" >> $SUMMARY_LOG

# Step 0: Check if preprocess log exists
if [ ! -f "$PREPROCESS_LOG" ]; then
    echo "$(date): ERROR - preprocess log not found: $PREPROCESS_LOG" >> "$SUMMARY_LOG"
    echo "Preprocess log not found!"
    echo "==============================" >> "$SUMMARY_LOG"
    exit 1
fi

# Step 1: Search for ERROR or failed in preprocess.log (case-insensitive)
ERRORS=$(grep -i "ERROR\|failed" "$PREPROCESS_LOG")

if [ -n "$ERRORS" ]; then
    echo "$(date): Errors found in preprocess.log" >> $SUMMARY_LOG
    echo "$ERRORS" >> $SUMMARY_LOG
    echo "Errors found! Check $SUMMARY_LOG for details."
    exit 1
else
    echo "$(date): No errors detected in preprocess.log" >> $SUMMARY_LOG
    echo "No errors detected."
    exit 0
fi

echo "$(date): Log monitoring completed" >> $SUMMARY_LOG
echo "==============================" >> $SUMMARY_LOG
