<#
.SYNOPSIS
This script executes a command to run a test runner for a Farming Simulator 22 mod.

.DESCRIPTION
The script executes the TestRunner_public.exe command with the specified mod folder path, game path, and output path.

.PARAMETER modFolderPath
Specifies the path to the mod folder.

.NOTES
File Name      : execute_TestRunner.ps1
Author         : Miguel Pacheco
Prerequisite   : PowerShell 3.0 or later
License        : MIT
#>

param (
    [string]$modFolderPath
)

# Define the path where the TestRunner is installed (Mandatory)
$testRunnerPath = ""

# Define the path where Farming Simulator is installed (Mandatory)
$gamePath = ""

# Define the base output folder (Mandatory)
$outputBasePath = ""

# Define the Giants Editor Path (Mandatory)
$giantsEditorPath = ""

# Check if the mod folder path is provided
if (-not $modFolderPath) {
    Write-Host "Please provide the path to the mod folder."
    exit
}

# Extract the mod name from the provided mod folder path
$modName = $modFolderPath | Split-Path -Leaf

# Create the mod-specific output folder
$modOutputFolderPath = Join-Path -Path $outputBasePath -ChildPath $modName

# Check if the mod-specific output folder exists; if not, create it
if (-not (Test-Path -Path $modOutputFolderPath -PathType Container)) {
    New-Item -Path $modOutputFolderPath -ItemType Directory | Out-Null
}

# Generate a timestamp for the current run
$timestamp = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"

# Create a new run folder with a unique run number and timestamp
$counter = 1
do {
    $runFolderPath = Join-Path -Path $modOutputFolderPath -ChildPath "Test_${counter}_$timestamp"
    $counter++
} while (Test-Path -Path $runFolderPath -PathType Container)

# Create the run folder
New-Item -Path $runFolderPath -ItemType Directory | Out-Null

# Display information about the paths being used
Write-Host "Loading Giants TestRunner located on: $testRunnerPath"
Write-Host "Using GamePath: $gamePath"
Write-Host "Mod Folder: $modFolderPath"
Write-Host "Output Path: $runFolderPath"

# Build the command to execute the test runner
$command = "$testRunnerPath $modFolderPath -e '$giantsEditorPath' -g '$gamePath' --outputPath $runFolderPath"

# Execute the command
Invoke-Expression -Command $command
