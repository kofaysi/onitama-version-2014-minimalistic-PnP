# SVG Animal Label Replacement Tool

This tool provides scripts for replacing text within `<tspan>` elements in SVG files based on specified mappings. It allows for batch processing of multiple mapping files against a single SVG source, automating the generation of customized PDFs for each mapping.

The scripts target SVG files created with Inkscape, with save attributes set to inline in the output application settings. This ensures compatibility with the expected SVG file format.

## Project Structure

The project includes the following files:

- `remap.sh`: A Bash script to replace text in an SVG file using a single mapping file and optionally generate a PDF.
- `batch_remap.sh`: A Bash script to process multiple mapping files in a single command.
- Example mapping files: `labels-EN.csv`, `labels-HU.csv`, etc.

## Prerequisites

To run the scripts, you will need:

- A Unix-like environment (Linux, macOS)
- `bash`
- `sed`
- Inkscape (for PDF generation)

Ensure these tools are installed and available in your system's command line.

---

## Usage

### Single File Processing (`remap.sh`)

To replace text in a single SVG file using a mapping file, use the `remap.sh` script.

#### Syntax

```bash
./remap.sh -m path_to_mapping_file -s path_to_source_svg [-p path_to_output_pdf]
```

#### Example Command

```bash
./remap.sh -m labels-EN.csv -s cards.svg -p cards-EN.pdf
```

- **`-m`**: Specifies the mapping file.
- **`-s`**: Specifies the source SVG file.
- **`-p`** (optional): Specifies the output PDF file name. If omitted, only the SVG is updated.

---

### Batch Processing (`batch_remap.sh`)

To process multiple mapping files against a single SVG source, use the `batch_remap.sh` script. This script automates the generation of PDFs for all specified mappings.

#### Syntax

```bash
./batch_remap.sh -s path_to_source_svg -m mapping_file1 [mapping_file2 ...]
```

#### Examples

1. **Using a Pattern (Shell Expansion)**:

   ```bash
   ./batch_remap.sh -s cards.svg -m labels-*.csv
   ```

   If your directory contains `labels-EN.csv`, `labels-HU.csv`, and `labels-DE.csv`, this command processes all three files and generates corresponding PDFs (e.g., `cards-EN.pdf`, `cards-HU.pdf`, `cards-DE.pdf`).

2. **Specifying Individual Files**:

   ```bash
   ./batch_remap.sh -s cards.svg -m labels-EN.csv labels-HU.csv
   ```

   This processes only the specified files.

---

### Expected Outputs

1. **Console Feedback**:
   - Each script outputs progress messages, including:
     - The mapping file being processed.
     - The language tag detected from the mapping file.
     - Confirmation of successful or failed PDF generation.

2. **Generated Files**:
   - Updated SVG files (in-place modifications).
   - PDF files for each processed mapping (if the `-p` option is used with `remap.sh` or specified in `batch_remap.sh`).

---

### Mapping File Format

Mapping files should contain one mapping per line in the following format:

```csv
[old_name],[new_name]
```

- The separator can be a comma, space, or tab (mixed usage is allowed).
- The first line of each mapping file is ignored as a header.

---

## Notes

1. Ensure your SVG files are saved with Inkscape's attributes set to "inline".
2. Language tags are extracted from mapping file names (e.g., `labels-EN.csv` results in the language tag `EN`).

---

## Contributing

Contributions to this project are welcome. Please ensure any changes follow the existing coding style and file structure.

---

## License

This project is open-source. You are free to use, modify, and distribute the scripts under the terms of an open-source license.

