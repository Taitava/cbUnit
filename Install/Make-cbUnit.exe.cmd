@echo off

rem We should be able to cd back to the original directory because if the script is run from the command line, the command line would change directory to where ever we left.
set original_directory=%cd%

if not exist ..\CBCompiler\CBCompiler.exe (
	echo Compiler does not exist in cbUnit\CBCompiler\CBCompiler.exe!
 	echo See README.md for installation instructions.
	pause
 	exit /b 1
)

rem Go to the program's directory to store it in a variable
cd ..
set "cbUnitDirectory=%cd%"

rem Echo information
echo Compiling cbUnit.exe into %cbUnitDirectory%\ ...

rem Go to the compiler directory in order to run the compiler correctly
cd CBCompiler

rem Delete old complier instructions file is exists. We will create a new one.
del Compiler > nul 2> nul

rem Delete old cbUnit.exe if exists
del ..\cbUnit.exe > nul 2> nul

rem Delete old compiled program if exists
del cbRun.exe > nul 2> nul
del cbUnit.exe > nul 2> nul

rem Delete old source code if exists
del Editor.out > nul 2> nul

rem Write a new compiler instructions file
echo type=1 > Compiler
echo sourcedir=%cbUnitDirectory%\ >> Compiler
echo buildTo=cbRun >> Compiler
echo force=1 >> Compiler

rem Write new source code file
copy ..\cbUnit.cb Editor.out > nul

rem Compile
call CBCompiler.exe

rem Move cbRun.exe -> ../cbUnit.exe
ren cbRun.exe cbUnit.exe > nul
move cbUnit.exe .. > nul

rem Clean up
del Editor.out > nul 2> nul
del Compiler > nul 2> nul

echo Done.
cd %original_directory%
pause