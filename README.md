# Farming Simulator Test Runner Script

This PowerShell script runs the GIANTS TestRunner against a Farming Simulator mod folder and stores each run in its own timestamped output directory.

## Requirements

- PowerShell 3.0 or later
- GIANTS TestRunner Tool [Download Here](https://gdn.giants-software.com/index.php)
- GIANTS Editor [Download Here](https://gdn.giants-software.com/index.php)
- Farming Simulator [Buy it here](https://www.farming-simulator.com/buy-now.php?platform=pcdigital&code=MIGUELATOR)

## What This Script Does

- Accepts a mod folder path as the only required argument.
- Validates that the TestRunner executable and output base folder are configured correctly.
- Uses the configured GIANTS Editor and game path only when they are provided.
- Creates a unique output folder for every run using the mod name, a run number, and a timestamp.
- Prints the resolved paths and the final command before launching the TestRunner.

## Configuration

Open `execute_TestRunner.ps1` and set the following values before running the script:

- `$testRunnerPath`: Path to `TestRunner_public.exe`
- `$outputBasePath`: Base folder where mod test results will be stored
- `$gamePath`: Path to Farming Simulator installation, if you want to pass it to the TestRunner
- `$giantsEditorPath`: Path to GIANTS Editor, if you want to pass it to the TestRunner

If a value is left empty, the script skips that optional argument.

## Usage

1. Download `execute_TestRunner.ps1` to your computer.
2. Make sure PowerShell 3.0 or later is installed.
3. Update the configuration values in the script.
4. Run the script from PowerShell and provide the path to your mod folder:

```powershell
.\execute_TestRunner.ps1 -modFolderPath "Path\to\mod\folder"
```

You can also pass the mod folder positionally:

```powershell
.\execute_TestRunner.ps1 "Path\to\mod\folder"
```

Replace `Path\to\mod\folder` with the actual location of your mod.

## Output

Each run is written to a folder inside `$outputBasePath` using this structure:

`<mod name>\Test_<run number>_<timestamp>`

For example, a mod named `MyMod` might produce:

`MyMod\Test_1_2026-07-01_14-30-00`

If the folder already exists, the script keeps incrementing the run number until it finds a free name.

## Example Flow

1. You point the script at a mod folder.
2. The script extracts the mod name from that folder.
3. The script creates a unique output folder for the run.
4. The script launches the TestRunner with the selected paths.
5. The generated report appears in the new output folder.

## Notes

- The script is designed to be edited once and reused for multiple mods.
- Paths to the TestRunner executable and output base folder are mandatory.
- GIANTS Editor and Farming Simulator paths are optional but recommended for better results.
- Exercise caution when running scripts from untrusted sources.
- For issues or suggestions, please contact [Miguel Pacheco](mailto:minipachru@gmail.com) or create an issue on the repository.
