#!/bin/bash

# Initialize variables
mapping_file=""

# Function to display usage information
usage() {
  echo "Usage: $0 -m path_to_mappings_file path_to_your_file.svg"
  exit 1
}

# Parse command-line options
while getopts ":m:" opt; do
  case $opt in
    m)
      mapping_file=$OPTARG
      ;;
    *)
      usage
      ;;
  esac
done

# Shift away processed options
shift $((OPTIND-1))

# Check the correct number of positional arguments
if [ "$#" -ne 1 ] || [ -z "$mapping_file" ]; then
  usage
fi

# Check existence of the SVG file and mappings file
if [ ! -f "$1" ] || [ ! -f "$mapping_file" ]; then
  echo "Error: One or both specified files do not exist."
  exit 1
fi

# Set variables for files
file_to_modify="$1"

# Process each line from the mappings file and perform replacements
{
  # Skip the first line (header) and read the rest
  read  # This reads the first line from the input and does nothing with it
  while IFS=' ' read -r column1 column2; do
    # Skip empty lines and comments
    [[ "$column1" =~ ^#.*$ || -z "$column1" ]] && continue

    # Use sed to preserve tspan attributes while replacing its content
    sed -i "s|\(<text[^>]*inkscape:label=\"animal ghost name $column1\"[^>]*><tspan[^>]*>\)[^<]*\(</tspan>\)|\1$column2\2|g" "$file_to_modify"
  done
} < "$mapping_file"


