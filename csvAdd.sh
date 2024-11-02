#!/bin/bash

# Check if the input file is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <infile.csv>"
    exit 1
fi

# Default argument
infile=$1

# Check if the input file exists
if [ ! -f "$infile" ]; then
    echo "File not found: $infile"
    exit 1
fi

# Read through the file line by line
{
    read -r header
    
    # Print a header with new "Sum" column
    echo "$header,Sum"

    # Process each row using input field separator (IFS)
    while IFS=, read -r col1 col2; do
        # Add the values together treating missing fields as a 0
        # Import basic calculator bc, (readiness for floating point numbers)
        sum=$(echo "${col1:-0} + ${col2:-0}" | bc)
        
        # Print the original values with the calculated sum
        echo "$col1,$col2,$sum"
    done
} < "$infile"
