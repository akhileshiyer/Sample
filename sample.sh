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



#3
#!/bin/bash

# Specify the input CSV files
file_a="file_a.csv"
file_b="file_b.csv"

# Specify the output files
incorrect_sizes="incorrect_sizes.csv"
missing_files="missing_files.csv"

# Create or overwrite the output files with headers
echo "Filename,Size (bytes) in $file_a,Size (bytes) in $file_b" > "$incorrect_sizes"
echo "Filename,Size (bytes) in $file_a" > "$missing_files"

# Function to get the size of a file from CSV
get_size() {
    filename=$1
    csv_file=$2
    awk -F ',' -v file="$filename" '$1 == file {print $2}' "$csv_file"
}

# Loop through each line in file_a
while IFS=, read -r filename_a size_a; do
    # Get the size of the same file from file_b
    size_b=$(get_size "$filename_a" "$file_b")

    # Check if the sizes match or if the file is missing in file_b
    if [ "$size_a" != "$size_b" ]; then
        echo "$filename_a,$size_a,$size_b" >> "$incorrect_sizes"
    fi

    # Remove the file from file_b to track missing files
    sed -i "/^$filename_a,/d" "$file_b"
done < "$file_a"

# Any remaining entries in file_b are missing in file_a
cat "$file_b" >> "$missing_files"

echo "Comparison results:"
echo "Incorrect sizes: $incorrect_sizes"
echo "Missing files: $missing_files"

