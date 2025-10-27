#!/bin/bash

# This script finds all directories in the current location
# and creates an empty 'notes.md' file in each one.
# It also creates a 'slides' subdirectory with a 'slides.md' file inside.
# It does not search recursively into subdirectories.

echo "Creating notes.md and slides directory/file in all immediate subdirectories..."

# Loop through all directories in the current path
for dir in ./*/ ; do
  # For each directory, create the notes.md file
  touch "${dir}notes.md"

  # For each directory, create the discussion.md file
  touch "${dir}discussion.md"

  # Create the slides subdirectory
  mkdir -p "${dir}slides"

  # Create the slides.md file inside the slides directory
  touch "${dir}slides/slides.md"
done

echo "Done."
