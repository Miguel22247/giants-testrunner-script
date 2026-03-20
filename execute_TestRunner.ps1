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

# Define the base output folder (Mandatory)
$outputBasePath = ""

# Define the path where Farming Simulator is installed (Optional, but recommended for better results)
$gamePath = ""

# Define the Giants Editor Path (Optional, but recommended for better results)
$giantsEditorPath = ""

# Check if the mod folder path is provided
if (-not $modFolderPath) {
    Write-Host "Please provide the path to the mod folder."
    exit 1
}

# Validate mandatory paths
if (-not $testRunnerPath) {
    Write-Host "Error: `$testRunnerPath is not set. Please configure the path to the TestRunner executable."
    exit 1
}

if (-not $outputBasePath) {
    Write-Host "Error: `$outputBasePath is not set. Please configure the base output folder path."
    exit 1
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

# Build the arguments to execute the test runner
$arguments = @($modFolderPath)

if ($giantsEditorPath) {
    $arguments += "-e"
    $arguments += $giantsEditorPath
}

if ($gamePath) {
    $arguments += "-g"
    $arguments += $gamePath
}

$arguments += "--outputPath"
$arguments += $runFolderPath

# Optionally display the exact command being executed
$argumentString = ($arguments | ForEach-Object { '"{0}"' -f $_ }) -join ' '
Write-Host "Executing: `"$testRunnerPath`" $argumentString"
# Execute the command using the call operator with an argument array
& $testRunnerPath @arguments
