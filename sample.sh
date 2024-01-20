start='2019-01-01'
end='2019-02-01'

start=$(date -d $start +%Y%m%d)
end=$(date -d $end +%Y%m%d)

while [[ $start -le $end ]]
do
        echo $(date -d $start +%Y-%m-%d)
        start=$(date -d"$start + 1 day" +"%Y%m%d")

done

#2
#!/bin/bash

# Specify the directory containing the PDF files
pdf_directory="/path/to/your/pdf/directory"

# Specify the output CSV file
output_csv="output.csv"

# Create or overwrite the CSV file with headers
echo "Filename,Size (bytes)" > "$output_csv"

# Loop through each PDF file in the directory
for pdf_file in "$pdf_directory"/*.pdf; do
    # Extract filename and size in bytes
    filename=$(basename "$pdf_file")
    size=$(stat -c%s "$pdf_file")

    # Append the data to the CSV file
    echo "$filename,$size" >> "$output_csv"
done

echo "CSV file generated: $output_csv"
