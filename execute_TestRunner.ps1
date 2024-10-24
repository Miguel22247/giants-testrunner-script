<#
.SYNOPSIS
This script executes a command to run a test runner for a Farming Simulator 22 mod.

.DESCRIPTION
The script executes the TestRunner_public.exe command with the specified mod folder path and game path and outputPath.

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

# Define the path where the TestRunner is installed (mandatory)
$testRunnerPath = "D:\testingmods\TestRunner_public.exe"

# Define the path where Farming Simulator 22 is installed (optional)
$gamePath = "D:\SteamLibrary\steamapps\common\Farming Simulator 22"

# Define the base output folder (optional I think)
$outputBasePath = "D:\testingmods\testRunnerOutput"

# Define the Giants Editor Path (optional)
$giantsEditorPath = "D:\GIANTS_Editor_9.0.6_64-bit\editor.exe"

# Check if the mod folder path is provided
if (-not $modFolderPath) {
    Write-Host "Please provide the path to the mod folder."
    exit
} else {
    # Create the output folder path
    $outputFolderPath = Join-Path -Path $outputBasePath -ChildPath "$(($modFolderPath | Split-Path -Leaf) + '_Output')"
    
    # Check if the output folder already exists, if not, create it
    if (-not (Test-Path -Path $outputFolderPath -PathType Container)) {
        New-Item -Path $outputFolderPath -ItemType Directory | Out-Null
    } else {
        # If the output folder exists, append a number to avoid conflicts
        $counter = 1
        while (Test-Path -Path $outputFolderPath -PathType Container) {
            $outputFolderPath = Join-Path -Path $outputBasePath -ChildPath "$(($modFolderPath | Split-Path -Leaf) + '_Output_' + $counter)"
            $counter++
        }
        New-Item -Path $outputFolderPath -ItemType Directory | Out-Null
    }

    Write-Host "Loading Giants TestRunner located on: $testRunnerPath, with GamePath: $gamePath, and output: $outputFolderPath for mod: $modFolderPath"

    # Build the command
    $command = "$testRunnerPath $modFolderPath -e '$giantsEditorPath' -g '$gamePath' --outputPath $outputFolderPath"

    # Execute the command
    Invoke-Expression -Command $command
}
