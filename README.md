# SVG Animal Label Replacement Tool

This tool provides a script for replacing text within `<tspan>` elements in SVG files based on specified mappings. It's designed to be used with files containing specific labels, facilitating the batch renaming of elements according to predefined mappings.

The SVG files targeted by this script are created with Inkscape, with save attributes set to inline in the output application settings. This ensures the script functions correctly with the expected SVG file format.

## Project Structure

The project includes the following files:

- `replace_animals.sh`: Bash script to perform text replacement in SVG files.
- `ghost animals names mapping (EN).csv`: Mapping file for English animal names.
- `ghost animals names mapping (HU).csv`: Mapping file for Hungarian animal names.

## Prerequisites

To run this script, you will need:
- A Unix-like environment (Linux, macOS)
- `bash`
- `sed`

Ensure that `bash` and `sed` are installed and available in your system's command line.

## Usage

To use the script, you need to specify the path to an SVG file and a mapping file. The script uses the `-m` option to specify the mapping file.

### Syntax

```bash
./replace_animals.sh -m [path_to_mapping_file] [path_to_svg_file]
```

### Example Command

```bash
./replace_animals.sh -m ghost\ animals\ names\ mapping\ \(EN\).csv Onitama\ japanese\ PnP\ version.svg
```

This command will replace names in `Onitama japanese PnP version.svg` using the mappings specified in `ghost animals names mapping (EN).csv`.
Mapping File Format

The mapping files should contain one mapping per line, formatted as follows:

```css
[old_name] [new_name]
```
The separator can be comman, space or tab (mixed usage is allowed). The first line of each mapping file is ignored as it is considered a header.

The translations herewithin follow the translation of the Japanese zodiac signs istead of literal translation of the animal kind.

### Contributing

Contributions to this project are welcome. Please ensure any contributions follow the existing coding style and file structure.

### License

Specify your licensing here or state if the project is open-source.

