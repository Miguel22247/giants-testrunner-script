#!/bin/bash

# Define the paths
testRunnerPath=""
gamePath=""
outputBasePath=""
giantsEditorPath=""

# Check if the mod folder path is provided
if [ -z "$1" ]; then
  echo "Please provide the path to the mod folder."
  exit 1
fi

modFolderPath="$1"

# Create the output folder path
modFolderName=$(basename "$modFolderPath")
outputFolderPath="$outputBasePath/${modFolderName}_Output"

# Check if the output folder already exists, if not, create it
if [ ! -d "$outputFolderPath" ]; then
  mkdir -p "$outputFolderPath"
else
  # If the output folder exists, append a number to avoid conflicts
  counter=1
  while [ -d "$outputFolderPath" ]; do
    outputFolderPath="$outputBasePath/${modFolderName}_Output_$counter"
    counter=$((counter + 1))
  done
  mkdir -p "$outputFolderPath"
fi

echo "Loading Giants TestRunner located on: $testRunnerPath, with GamePath: $gamePath, and output: $outputFolderPath for mod: $modFolderPath"

# Build the command
command="$testRunnerPath \"$modFolderPath\" -e \"$giantsEditorPath\" -g \"$gamePath\" --outputPath \"$outputFolderPath\""

# Execute the command
eval "$command"
