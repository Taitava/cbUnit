@echo off

rem We should be able to cd back to the original directory because if the script is run from the command line, the command line would change directory to where ever we left.
set original_directory=%cd%

if exist ..\CBCompiler\CBCompiler.exe (
	echo You already have CBCompiler.exe in place.
	pause
	exit /b 0
)

rem Go to CoolBasic folder
cd ..\..

if not exist IDE\CBCompiler.exe (
	echo CBCompiler.exe was not found from %cd%\IDE\CBCompiler.exe.
	echo Perhaps you have installed cbUnit somewhere else than in your CoolBasic directory? That's ok, you just need to manually copy CBCompiler.exe to cbUnit\CBCompiler\ . See README.md for more information about where to get CBCompiler.exe from.
	cd %original_directory%
	pause
	exit /b 1
)

if not exist cbUnit\ (
	echo Hmm, I have trouble finding my way back to the sweet home of cbUnit. Have you renamed cbUnit folder to something else, perhaps?
	cd %original_directory%
	pause
	exit /b 1
)

if not exist cbUnit\CBCompiler\ (
	echo Your cbUnit\ folder should have a folder named CBCompiler\ in it, but it doesn't exist.
	cd %original_directory%
	pause
	exit /b 1
)

echo Copying %cd%\IDE\CBCompiler.exe to %cd%\cbUnit\CBCompiler\CBCompiler.exe ...
copy IDE\CBCompiler.exe cbUnit\CBCompiler
if errorlevel 1 (
	echo Mission... FAILED!
) else (
	echo Huh that was a tough job but after hours of hard work, it's finally done!
)
cd %original_directory%
pause