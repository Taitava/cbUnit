@echo off

rem We should be able to cd back to the original directory because if the script is run from the command line, the command line would change directory to where ever we left.
set original_directory=%cd%

rem Ensure that git is available
where git
if %ERRORLEVEL% neq 0 (
	echo Git is not installed. Install it from https://git-scm.com/download/win
	pause
	exit /b 1
)

rem Ensure that Libraries\ folder is available
cd ..\Libraries
if %ERRORLEVEL% neq 0 (
	echo The Libraries\ folder is missing.
	pause
	exit /b 1
)

rem ----------------------
rem DEFINE LIBRARIES BELOW
rem ----------------------

rem CommandLineArguments installation
cd CommandLineArguments > nul 2> nul
if %ERRORLEVEL% neq 0 (
	rem Install it
	git clone https://github.com/Taitava/cb-CommandLineArguments.git CommandLineArguments
) else (
	rem Update it
	git pull
)
if %ERRORLEVEL% neq 0 (
	echo Failed to install library CommandLineArguments!
) else (
	echo CommandLineArguments library installed/updated successfully.
)

rem Between different libraries:
cd %original_directory%\..\Libraries

rem PatternCompare installation
cd PatternCompare > nul 2> nul
if %ERRORLEVEL% neq 0 (
	rem Install it
	git clone https://github.com/Taitava/cb-PatternCompare.git PatternCompare
) else (
	rem Update it
	git pull
)
if %ERRORLEVEL% neq 0 (
	echo Failed to install library PatternCompare!
) else (
	echo PatternCompare library installed/updated successfully.
)

rem ----------------------
rem DEFINE LIBRARIES ABOVE
rem ----------------------

rem Finish
pause
cd %original_directory%