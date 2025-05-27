A shell script to extract Scheme Name and Asset Value from https://www.amfiindia.com/spages/NAVAll.txt and save as TSV and JSON Format.

## TSV format : 

```sh
awk -F ';' 'NF>=5 && $4 != "" && $4 != "Scheme Name" {print $4 "\t" $5}' NAVAll.txt > nav.tsv
```

**Explanation:**

- `awk`: Invokes the awk text-processing tool.
- `-F ';'`: Sets the field separator to a semicolon (`;`), so awk splits each line into columns based on `;`.
- `'NF>=5 && $4 != "" && $4 != "Scheme Name" {print $4 "\t" $5}'`:
  - `NF>=5`: Only process lines with at least 5 fields (to skip blank lines and section headers).
  - `$4 != ""`: Skip lines where the 4th field (Scheme Name) is empty.
  - `$4 != "Scheme Name"`: Skip the header line.
  - `{print $4 "\t" $5}`: For matching lines, print the 4th field (Scheme Name) and 5th field (Net Asset Value), separated by a tab.
- `NAVAll.txt`: The input file.
- `> nav.tsv`: Redirects the output to `nav.tsv`.

**Result:**  
You get a `nav.tsv` file containing only the Scheme Name and Net Asset Value columns, one per line, tab-separated, and with all headers/blank lines skipped.

## JSON format : 
```sh
awk -F ';' 'NF>=5 && $4 != "" && $4 != "Scheme Name" {printf "{\"Scheme Name\": \"%s\", \"Net Asset Value\": \"%s\"}\n", $4, $5}' NAVAll.txt | jq -s '.' > nav.json
```

**Explanation:**

`awk` extracts the Scheme Name and Net Asset Value and prints each as a JSON object.
jq -s '.' collects all objects into a JSON array and writes to nav.json.

**Result:**
You will get a `nav.json` file containing an array of objects, each with "Scheme Name" and "Net Asset Value".