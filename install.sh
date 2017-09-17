#!/bin/bash

# If you're not using arch, then you have fallen to the dark side! - your younger, more naive self
screenfetch

# list all directories, limit results to 1 per line
programs=$(ls -d1 -- */)

if command -v stow >/dev/null 2>&1; then
  echo "Restoring config with GNU Stow."
else
  echo "Error: GNU Stow is not installed. Aborting."
  exit
fi

echo

# Remove the trailing '/'s from directories
for program in ${programs///}; do
  echo "Restoring files for ${program}"
  stow "${program}"
done

echo

echo "Setup complete"
