#!/bin/bash

# Function to display usage information
usage() {
  echo "Usage: $0 -s|--source path_to_source_svg -m|--mappings mapping_file1 [mapping_file2 ...]"
  echo "  -s, --source: Path to the source SVG file"
  echo "  -m, --mappings: Space-separated list of mapping files (e.g., labels-*.csv)"
  echo "This script processes all mapping files provided and generates PDFs for each."
  exit 1
}

# Initialize variables
source_file=""
mapping_files=()

# Parse command-line options
while [[ "$#" -gt 0 ]]; do
  case "$1" in
    -s|--source)
      source_file="$2"
      shift 2
      ;;
    -m|--mappings)
      shift
      while [[ "$#" -gt 0 && "$1" != -* ]]; do
        mapping_files+=("$1")
        shift
      done
      ;;
    *)
      usage
      ;;
  esac
done

# Check that mandatory arguments are provided
if [[ -z "$source_file" || ${#mapping_files[@]} -eq 0 ]]; then
  echo "Error: Both source SVG file and at least one mapping file are required."
  usage
fi

# Check existence of the source SVG file
if [[ ! -f "$source_file" ]]; then
  echo "Error: The source SVG file '$source_file' does not exist."
  exit 1
fi

# Check existence of each mapping file
for mapping_file in "${mapping_files[@]}"; do
  if [[ ! -f "$mapping_file" ]]; then
    echo "Error: Mapping file '$mapping_file' does not exist."
    exit 1
  fi
done

# Process each mapping file
for mapping_file in "${mapping_files[@]}"; do
  # Extract the language tag from the filename (between the last dash and .csv)
  base_name=$(basename "$mapping_file")
  language_tag=$(echo "$base_name" | sed -E 's/^.*-([^.]+)\.csv$/\1/')

  # Generate output PDF filename
  pdf_output="cards-$language_tag.pdf"

  # Run the remap script
  echo "Processing mapping file: $mapping_file (Language: $language_tag)"
  ./remap.sh -m "$mapping_file" -s "$source_file" -p "$pdf_output"

  # Check if the remap script executed successfully
  if [[ $? -eq 0 ]]; then
    echo "Successfully generated PDF: $pdf_output"
  else
    echo "Error: Failed to generate PDF for $mapping_file"
    exit 1
  fi
done

echo "All mappings processed successfully."

