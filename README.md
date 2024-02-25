# Farming Simulator 22 Test Runner Script

This PowerShell script executes the Test Runner for a Farming Simulator 22 mod.

## Requirements

- PowerShell 3.0 or later
- Giants TestRunner Tool [Download Here](https://gdn.giants-software.com/index.php)
- Giants Editor [Download Here](https://gdn.giants-software.com/index.php)
- Farming Simulator 2022

## Usage

1. **Download Script:**
   - Download the `execute_TestRunner.ps1` file to your computer.

2. **Prerequisites:**
   - Ensure you have PowerShell 3.0 or later installed on your system.

3. **Setup:**
   - Define the following paths in the script:
     - `$testRunnerPath`: Path where the Test Runner executable (`TestRunner_public.exe`) is installed.
     - `$gamePath`: Path where Farming Simulator 22 is installed.
     - `$outputBasePath`: Base output folder where the results will be stored.

4. **Run the Script:**
   - Open PowerShell.
   - Navigate to the directory where `execute_TestRunner.ps1` is located.
   - Run the script by providing the path to the mod folder as an argument:

     ```powershell
     .\execute_TestRunner.ps1 -modFolderPath "Path\to\mod\folder"
     ```
     or
     ```powershell
     .\execute_TestRunner.ps1 "Path\to\mod\folder"
     ```

   Replace `"Path\to\mod\folder"` with the actual path to your mod folder.

5. **Output:**
   - The script will create a new folder inside the `$outputBasePath` with the name of the mod folder followed by "_Output" (or "_Output_X" if conflicts arise).
   - The Test Runner will generate its output in this folder.

## Notes

- This script uses PowerShell to execute the Test Runner command with the specified parameters.
- Ensure that the paths to `TestRunner_public.exe`, the game folder, and the output base folder are correctly defined in the script.
- Exercise caution when running scripts from untrusted sources.
- For issues or suggestions, please contact [Miguel Pacheco](mailto:minipachru@gmail.com).
