# cbUnit
Unit tests for CoolBasic.

- Unit testing is a method for testing parts of an application one by one, separately from other parts. [More about unit testing in Wikipedia](https://en.wikipedia.org/wiki/Unit_testing)
- CoolBasic is an easy to learn game/application programming language for Windows. [More in CoolBasic.com](https://coolbasic.com)

The documentation is still under construction.

## Installation
### 0. Prerequisites
You need to have a CoolBasic compiler (`CBCompiler.exe`) on your computer. We will use it later in this installation process. But you probably do have it if you are already developing stuff with CoolBasic :). In case you don't happen to have it, download one of these:
- **Recommended**: Modded CBCompiler.exe (increased limit for amount of functions). [Download from here](https://github.com/cb-hackers/cbEnchanted/tree/master/tools/cbcompiler/IDE) [More information (in Finnish)](https://www.coolbasic.com/phpBB3/viewtopic.php?t=1616)
- The official compiler (has a limit of 127 functions). [Download IDE installer here](https://www.coolbasic.com/files/CBBeta10.exe) (contains also editor & manual) [More information (briefly in English)](https://www.coolbasic.com/)

### 1. Download cbUnit
Say that you have a CB project application located somewhere on your computer, e.g. *C:\\Program Files (x86)\\CoolBasic\\Projects\\MyApplication*.

1. In that directory, create a folder `tests` and under that another folder called `cbUnit`. So it will be something like *C:\\Program Files (x86)\\CoolBasic\\Projects\\MyApplication\\tests\\cbUnit*.  cbUnit is meant to be downloaded into that folder.
2. You can either:
	 - Go to the above mentioned folder using [Git Bash](https://gitforwindows.org/) and execute: `git clone https://github.com/Taitava/cbUnit.git .`
	 - **or** download a zip archive from [releases](https://github.com/Taitava/cbUnit/releases) or [latest source code](https://github.com/Taitava/cbUnit/archive/master.zip) and unzip it to the above mentioned folder.

### 2. Copy `CBCompiler.exe` to cbUnit
Locate your `CBCompiler.exe` file and **copy** it to `cbUnit\CBCompiler` folder, which is sad and lonely, waiting for the compiler to arrive.

cbUnit needs CBCompiler because it generates some simple testing framework code and builds it with your custom `test_*.cb` unit test files. We will also use the compiler to compile cbUnit's main program in the next step.

### 3. Compile cbUnit.exe
1. Go to `cbUnit\Install` in file explorer (or command line prompt).
2. Run `Make-cbUnit.exe.cmd`. It will launch `cbUnit\CBCompiler\CBCompiler.exe` to compile `cbUnit.exe` into the main `cbUnit` folder.

If you happen to make some changes to `cbUnit.cb` source code file, then you can always rerun this script to get the exe file updated. Editing `cbUnit.cb` is not needed though, unless you want to tweak cbUnit someway.

The installation is now done.

## Settings
### In test_*.cb files

Setting | Possible values | Description 
--------|-----------------|-------------
CBUNIT_COMMANDLINE | (any string) | This string will be available via CommandLine() in your application and test file. cbUnit.exe reads this from your test_*.cb file and uses it when executing that file. That's why it may seem strange how this setting works.
CBUNIT_STOP_AT | "ASSERT", "FUNCTION", "" | Defines how failures are tolerated. ASSERT: Prevent further test immediately when an assertation fails. FUNCTION: When an assertation fails, complete the current test_*() function but stop after that. "" or anything else: do not stop (default behaviour). Note that this setting does not prevent the test program from executing other test_*.cb files!

### Application's global settings
These do not exist yet.

## Contributing
Ideas, bug repots, pull requests: all welcome! :) [Just raise an issue in GitHub](https://github.com/Taitava/cbUnit/issues)

## Author
This library is created by Jarkko Linnanvirta. Contact me:
 - [in GitHub](https://github.com/Taitava)
 - via email: j -at- jare -dot- fi