#!/bin/bash

# # Download the file
curl -s "https://www.amfiindia.com/spages/NAVAll.txt" -o NAVAll.txt

# Extract Scheme Name and Asset Value, skipping header lines and empty lines
awk -F ';' 'NF>=5 && $4 != "" && $5 != "" && $4 != "Scheme Name" {print $4 "\t" $5}' NAVAll.txt > nav.tsv

#to save the output to a file in json format
awk -F ';' 'NF>=5 && $4 != "" && $4 != "Scheme Name" {printf "{\"Scheme Name\": \"%s\", \"Net Asset Value\": \"%s\"}\n", $4, $5}' NAVAll.txt | jq -s '.' > nav1.json

echo "Extracted Scheme Name and Asset Value to nav.tsv"