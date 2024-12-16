#!/bin/bash

# Initialize variables
mapping_file=""
source_file=""
pdf_output=""

# Function to display usage information
usage() {
  echo "Usage: $0 -m|--mapping path_to_mapping_csv -s|--source path_to_source_svg [-p|--pdf path_to_output_pdf]"
  echo "  -m, --mapping: Path to the mapping CSV file"
  echo "  -s, --source: Path to the source SVG file"
  echo "  -p, --pdf: (Optional) Path to the output PDF file"
  exit 1
}

# Parse command-line options
while [[ "$#" -gt 0 ]]; do
  case "$1" in
    -m|--mapping)
      mapping_file="$2"
      shift 2
      ;;
    -s|--source)
      source_file="$2"
      shift 2
      ;;
    -p|--pdf)
      pdf_output="$2"
      shift 2
      ;;
    *)
      usage
      ;;
  esac
done

# Check that mandatory arguments are provided
if [[ -z "$mapping_file" || -z "$source_file" ]]; then
  echo "Error: Both mapping and source SVG files are required."
  usage
fi

# Check existence of the mapping file
if [[ ! -f "$mapping_file" ]]; then
  echo "Error: The mapping file '$mapping_file' does not exist."
  exit 1
fi

# Check existence of the SVG file
if [[ ! -f "$source_file" ]]; then
  echo "Error: The source SVG file '$source_file' does not exist."
  exit 1
fi

# Confirm start of processing
echo "Processing SVG file: $source_file using mapping file: $mapping_file"

# Process each line from the mapping file and perform replacements
{
  # Skip the first line (header) and read the rest
  read  # This reads the first line from the input and does nothing with it
  while IFS=$', \t' read -r column1 column2; do
    # Skip empty lines and comments
    [[ "$column1" =~ ^#.*$ || -z "$column1" ]] && continue

    # Inform about replacements being performed
    echo "Replacing: '$column1' with '$column2'"
    
    # Use sed to preserve tspan attributes while replacing its content
    sed -i "s|\(<text[^>]*inkscape:label=\"animal ghost name $column1\"[^>]*><tspan[^>]*>\)[^<]*\(</tspan>\)|\1$column2\2|g" "$source_file"
  done
} < "$mapping_file"

# Confirm completion of SVG modification
echo "SVG modifications completed."

# Export the modified SVG file to PDF if the PDF output path is supplied
if [[ -n "$pdf_output" ]]; then
  echo "Exporting to PDF: $pdf_output"
  inkscape "$source_file" --export-area-drawing --batch-process --export-type=pdf --export-filename="$pdf_output"
  
  # Confirm successful PDF generation
  if [[ $? -eq 0 ]]; then
    echo "PDF successfully generated: $pdf_output"
  else
    echo "Error: Failed to generate PDF."
    exit 1
  fi
else
  echo "No PDF output specified. Skipping PDF generation."
fi

