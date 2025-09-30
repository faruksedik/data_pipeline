#!/bin/bash

# Define paths
INPUT=~/data_pipeline/input/sales_data.csv
OUTPUT=~/data_pipeline/output/cleaned_sales_data.csv
LOGFILE=~/data_pipeline/logs/preprocess.log

echo "==============================" >> "$LOGFILE"
echo "$(date): Starting preprocessing job" >> "$LOGFILE"

# Step 0: Check if output file already exists
if [ -f "$OUTPUT" ]; then
    echo "$(date): Output file already exists: $OUTPUT" >> "$LOGFILE"
    echo "$(date): No need to clean data. Skipping preprocessing." >> "$LOGFILE"
    echo "==============================" >> "$LOGFILE"
    exit 0
fi

# Step 1: Check if input file exists
if [ ! -f "$INPUT" ]; then
    echo "$(date): ERROR - Input file not found: $INPUT" >> "$LOGFILE"
    exit 1
fi
echo "$(date): Input file found: $INPUT" >> "$LOGFILE"

# Step 2: Process with awk
awk -F',' 'NR==1 {
    # Keep header but remove last column
    $NF=""; sub(/,$/, ""); print; next
}
{
    # Remove last column
    last_field=$NF; $NF="";
    sub(/,$/, "");
    
    # Keep only rows where status != "Failed"
    if ($(NF) != "Failed") {
        print
    }
}' OFS=',' "$INPUT" > "$OUTPUT"

# Check if awk succeeded
if [ $? -ne 0 ]; then
    echo "$(date): ERROR - awk processing failed" >> "$LOGFILE"
    exit 1
fi

# Check if output file created
if [ ! -s "$OUTPUT" ]; then
    echo "$(date): ERROR - Output file not created or empty: $OUTPUT" >> "$LOGFILE"
    exit 1
fi

echo "$(date): Successfully cleaned file. Saved at $OUTPUT" >> "$LOGFILE"
echo "$(date): Preprocessing completed successfully" >> "$LOGFILE"
echo "==============================" >> "$LOGFILE"
exit 0
 
