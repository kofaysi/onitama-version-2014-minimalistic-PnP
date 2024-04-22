#!/bin/bash

# Check if a file name is provided as an input argument
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 path_to_your_file.svg"
  exit 1
fi

# Read the file name from the script's input argument
file_to_modify="$1"

# Define animal replacements as 'column1 column2' pairs
declare -a replacements=(
"frog béka"
"turtle teknos"
"snake kigyo"
"crane daru"
"monkey majom"
"ox bivaly"
"rat patkany"
"dog kutya"
"dragon sarkany"
"rooster kakas"
"sheep kos"
"boar vadkan"
"tiger tiris"
"horse lo"
"rabbit nyul"
)

# Loop through each replacement pair and use xmlstarlet to update the text
for pair in "${replacements[@]}"; do
  column1=$(echo $pair | awk '{print $1}')
  column2=$(echo $pair | awk '{print $2}')

  # Use xmlstarlet to update text in <tspan> that follows an inkscape:label within <text>
  xmlstarlet ed \
    -N svg="http://www.w3.org/2000/svg" \
    -N inkscape="http://www.inkscape.org/namespaces/inkscape" \
    -u "//svg:text[@id='text2']/svg:tspan/text()" \
    -v "${column2}" \
    "$file_to_modify" > temp_file.svg && mv temp_file.svg "$file_to_modify"
done

