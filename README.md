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
You can install cbUnit anywhere on your computer, but it's recommended to place it in the same folder with your CoolBasic editor (*CBEditor*), in a subfolder named `cbUnit`. So if you have installed CoolBasic to for example *C:\\Program Files (x86)\\CoolBasic\\*, you could install cbUnit to *C:\\Program Files (x86)\\CoolBasic\\cbUnit\\*.

To download cbUnit, you can either:
	 - Go to your *CoolBasic* folder using [Git Bash](https://gitforwindows.org/) and execute: `git clone https://github.com/Taitava/cbUnit.git cbUnit`. This will create a `cbUnit` folder for you and download cbUnit there.
	 - **or** download a zip archive from [releases](https://github.com/Taitava/cbUnit/releases) or [latest source code](https://github.com/Taitava/cbUnit/archive/master.zip) and unzip it to a new `cbUnit` folder.

### 2. Copy `CBCompiler.exe` to cbUnit
You have two ways to do this:
- **Preferred**: If you have installed cbUnit to the default location (in `CoolBasic\cbUnit`), you can go to `CoolBasic\cbUnit\Install` in file explorer (or command line prompt) and run `Copy-CBCompiler.exe.cmd` . It will copy `CBCompiler.exe` from your `CoolBasic\IDE\` folder to `CoolBasic\cbUnit\CBCompiler\`.
- **OR**: Locate your `CBCompiler.exe` file from your `CoolBasic\IDE` folder and **copy** it to `cbUnit\CBCompiler` folder, which is sad and lonely, waiting for the compiler to arrive.

cbUnit needs CBCompiler because it generates some simple testing framework code and builds it with your custom `test_*.cb` unit test files. We will also use the compiler to compile cbUnit's main program in the next step.

### 3. Install libraries

cbUnit uses some functions from [CB Repository](http://cbrepository.com) which are already included in *Libraries\cbRepository.com.cb*. In addition to this, cbUnit uses the following libraries that need to be cloned from [GitHub](https://github.com):
- [CommandLineArguments](https://github.com/Taitava/cb-CommandLineArguments)

There are two ways to install the libraries, with Git or manually.

### 3.1. Install libraries with Git

1. If you don't have Git on your machine yet, you can [download Git here](https://git-scm.com/download/win).
2. Go to `cbUnit\Install` in file explorer (or command line prompt).
3. Run `Install-libraries.cmd`. It will execute the needed Git command for you. You can also run this again later if you want to update the libraries to newer versions. But that's only rarely needed.

### 3.2. Install libraries manually

1. Go to the GitHub repository page of the [CommandLineArguments](https://github.com/Taitava/cb-CommandLineArguments) library.
2. Click *Code* -> *Download ZIP*.
3. Go to you cbUnit's folder and then to *Libraries*. Extract the zip file there to a new folder `CommandLineArguments`.
4. Make sure that the folder `CommandLineArguments` contains a file named `CommandLineArguments.cb`.

Now you are ready to compile cbUnit.exe.

### 4. Compile cbUnit.exe
1. Go to `cbUnit\Install` in file explorer (or command line prompt).
2. Run `Make-cbUnit.exe.cmd`. It will launch `cbUnit\CBCompiler\CBCompiler.exe` to compile `cbUnit.exe` into the main `cbUnit` folder.

If you happen to make some changes to `cbUnit.cb` source code file, then you can always rerun this script to get the exe file updated. Editing `cbUnit.cb` is not needed though, unless you want to tweak cbUnit someway.

The installation is now done.

## Creating `test_*.cb` files
Let's assume that you have a CB project application located somewhere on your computer, e.g. *C:\\Program Files (x86)\\CoolBasic\\Projects\\MyApplication*.

You can either create test files manually, or if you do not yet have a `tests` folder in your application directory, you can let cbUnit create one for you automatically with some empty test file(s) in it.

**Automatically**: Execute `cbUnit.exe --init "C:\Program Files (x86)\CoolBasic\Projects\MyApplication"`. This will create a `tests` folder for you. The folder will automatically contain empty `test_*.cb` files that are named similarly to any `*.cb` files found in your application's root directory. You can then freely decide if you will use those files or delete them and create test files with other names. The `cbUnit.exe --init` call also creates a handy `cbUnit.cmd` file that you can execute to run your test files when they are ready.

**Manually**: In your application directory, create a folder named `tests` . So it will be something like *C:\\Program Files (x86)\\CoolBasic\\Projects\\MyApplication\\tests\\*. 

Say that you have your `MyApplication` divided into multiple source code files, and you want to write some tests for each one of them. A good practice is to create one test file per one application source code file. You could have e.g.:
- `MyApplication\MainProgram.cb` and `MyApplication\tests\test_MainProgram.cb`
- `MyApplication\LibraryFunctions.cb` and `MyApplication\tests\test_LibraryFunctions.cb`

However, cbUnit does not force you to use any strict pattern to link your source code and test files together. The only rules for your test files are:
- Test files must be located in `tests` folder (no case-sensitivity) or in any of its possible subfolders.
- Test files' names need to start with `test_` and end with `.cb` (no case-sensitivity). A good practice is to include the related source code file's name in the test file's name, like in the examples above.

cbUnit *does* read your test files, but it *never* reads your application's source code files. And it never includes them for you, so in each of your `test_*.cb` file, you will need to `Include` the application source code file(s) that you want to test in that particular test file. cbUnit *does* include its own utility functions for you, so you don't need to include anything related to cbUnit in your `test_*.cb` files. You can just directly use [all the *assert* functions provided by cbUnit](https://github.com/Taitava/cbUnit/blob/master/cbUnit.asserts.cb).

### Content of a `test_*.cb` file
cbUnit assumes that each of your `test_*.cb` file contains functions and does not do anything outside of them. Of course you can use includes and define variables etc. outside of functions like you normally do. But code logic is *encouraged* to be written in functions. There is no strict rule for this, as cbUnit does not guard this in any way, but it can better report *assertion failures* if you use functions.

Functions in a `test_*.cb` file have the following rules:
- If a function is named `test_*()` (e.g.: `Function test_LoadGraphics()`), cbUnit will call it automatically. You do not need to call them at any point!
- `test_*()` functions do not use any parameters at the moment.
- If a function does not have the `test_` prefix, cbUnit will not call it. You can have this kind of functions in your test files freely, and you call them yourself just like you would expect.

Each function should contain *assertion tests*:
 - Your function should call one or more of `Assert*()` functions. Each one of them checks if the condition you gave them *is true*. E.g. `AssertBeginsWith("Hello World!", "Hello")` succeeds, but `AssertBeginsWith("Hello World!", "Hi")` fails and writes a report of the failure. Failures may also prevent further assertions from being run, depending on [your settings](#Settings).
 - You can find [all possible *assert* functions here](https://github.com/Taitava/cbUnit/blob/master/cbUnit.asserts.cb)
 - Each assertion function has it's own set of parameters, but all of them follow a general principle: the parameters start with one or more test condition operands (some might be optional), and the last parameter is always an optional message that will be included in the test report *if* the assertion fails. (Each assert function has their own, generic purpose default message, which will be appended to the end of your custom message, or used as the only message if you omit a custom message).
 - If you cannot find a specific assert function tailored for your particular test condition, you can use the base `Assert(condition, message$)` function. The first parameter is your condition as a simple `True` or `False` value (whether it succeeded or not). The second parameter is your custom error message, which is - as opposed to other `Assert*()` functions - always needed when calling this function. This function has other, optional parameters too, but they are meant for internal use, by other `Assert*()` functions.
 - Each assertion function returns a boolean result on whether the assertion succeeded or not. You can use this to easily control what assertions will/won't be run next. E.g. `If Assert(...) Then Assert(*An assertion that is depended of the previous assertion, and not meaningful to be run if the first one failed. *)`

#### Example content of a `test_*.cb` file
This example assumes that we have a `LibraryFunctions.cb` file containing e.g. [`GetWord2()` and `CountWords2()`](http://www.cbrepository.com/codes/code/11/) functions.
`MyApplication\tests\test_LibraryFunctions.cb`:
```Basic

Include "LibraryFunctions.cb"

Function test_GetWord2()
	AssertEquals(GetWord2("Tämä on lause.", 2), "on")
EndFunction

function test_CountWords2()
	AssertEquals(CountWords2("Hi my name is Jarkko."), 5)
	AssertEquals(CountWords2("Hi-my-name-is-Jarkko.", "-"), 5)
EndFunction

```

#### Hooks in a `test_*.cb` file
You can define the following *optional* functions in your `test_*.cb` file, and cbUnit will call them during appropriate events.

Hook | Description
-----|------------
`hook_Setup()` | Called before calling the first test function.
`hook_SetupTest(function_name$)` | Called before calling each test function. Gets a name of a test function that will be called next as a parameter.
`hook_Cleanup()` | Called just before ending the test program, in both cases: a) all tests ran, or b) a stop rule triggered after a failing test.
`hook_CleanupTest(function_name$)` | Called after calling a certain test function. Gets also called if the particular test function had a failing assertion and a stop rule triggered to end the test program.

Example:
```
Function hook_Setup()
	// Generate temporary text files for testing...
EndFunction

Function hook_Cleanup()
	// Remove all generated text files...
	// This is handy because this is called even if the test program exits before reaching the end of the test_*.cb file.
EndFunction
```

Return values of the hook functions are not used for anything.

## Running tests
Running tests is really simple:
1. If you have not already done so, in your application's root folder, create a file named `cbUnit.cmd`  (or you can decide another name for it if you wish). Edit it and add the following line: `start "cbUnit" "C:\Program Files (x86)\CoolBasic\cbUnit\cbUnit.exe"` (or whatever is the path to your *CoolBasic* directory). This *.cmd*-file works now as your link to start cbUnit. (Note: instead of creating `cbUnit.cmd` manually, you can also execute `cbUnit.exe --init "C:\Program Files (x86)\CoolBasic\Projects\MyApplication"` to create it automatically for you).
2. Run `cbUnit.cmd`. cbUnit will automatically know in which folder the calling `cbUnit.cmd` file resides and starts to test that application.
3. cbUnit will read all your `tests\test_*.cb` files. Each one will be compiled and run **one at a time**. Multiple test files are **not** compiled into one program! So different test files can define similarly named functions, variables etc.
4. After executing all test files, cbUnit will open a report text file in your favorite text editor and quit.

If you have made a syntax error (in a `test_*.cb` file or in your application code), CBCompiler will alert you with a popup error box, but in addition to this, the report file that cbUnit creates for you, contains the same compile error. If you have multiple `test_*.cb` files, cbUnit will continue to compile and run other test files after the failing one. It might result in multiple failing compiles if the syntax error happens to be in your application code, and not in a single test file.

### Selecting specific test files to be run
You can execute `cbUnit.exe` with explicit paths to the test files or folders that you want to run. Examples:
- `cbUnit.exe tests\test_ASpecificTestFile.cb` will run a single test file.
- `cbUnit.exe "C:\Program Files (x86)\CoolBasic\Projects\MyOtherApplication\tests"` will run all test files in a specific folder. Note that you need to use double quotes if the path contains spaces.
- `cbUnit.exe tests\test_1.cb tests\test_2.cb` will run two specific test files and combine the results into the same report.

Note that if the paths are relative, they always refer to the directory where you are currently executing `cbUnit.exe` from, not to `cbUnit.exe`'s location (unless you are e.g. double clicking `cbUnit.exe` in file explorer)!

### Passing command line arguments
You can pass command line arguments to your application while testing via two ways:
1. Call `cbUnit.exe -- Some command line arguments`. The two dashes indicates that the rest of the command line should be passed as-is to the CommandLine() of your application.
2. **Or**: Define `Const CBUNIT_COMMANDLINE = "Some command line arguments"` in your `test_*.cb` file.

If both of these are present, only the first one will be used.

## Settings
### In test_*.cb files

Setting | Possible values | Description
--------|-----------------|------------
CBUNIT_COMMANDLINE<br>*class*: **synthetic** | (any string) Default: `""` (an empty string) | This string will be available via CommandLine() in your application and test file. Note that if you execute `cbRun.exe -- with a double-dash option`, the string trailing `--` will be used instead of the `CBUNIT_COMMANDLINE` constant.
CBUNIT_EXPORT_TEST_PROGRAM<br>*class*: **synthetic** | `0`, `1` or `2`. Defaults to `0`. | If `1` or `2`, the generated test program source code will be exported to your `tests` folder. If you have a test file named `test_MyApplication.cb`, the exported test program source code file will be named `test_MyApplication.cbUnitTestProgram.cb`. You can then open it to inspect how the test program actually works. If the setting is `2`, the file will be automatically opened for you in whatever program is defined to open `*.cb` files. Note that you do NOT need this file in normal situations - only if you wonder how cbUnit works or if you suspect that there is a bug in cbUnit.
CBUNIT_FORCE_VARIABLE_DECLARATION<br>*class*: **synthetic** | `0` or `1`. Default: `0` | Whether to use the CBCompiler's FVD option to require that all variables used in the program should be predefined (e.g. with `Dim`) before usage. Very powerful for preventing bugs caused by typos in variable names, but in addition to the fact that your test files need to adhere to FVD, also your whole application needs to adhere to it.
CBUNIT_STOP_AT<br>*class*: **runtime** | `"ASSERT"`, `"FUNCTION"`, `""` <br> Default: `""` (an empty string) | Defines how failures are tolerated. ASSERT: Prevent further testing immediately when an assertion fails. FUNCTION: When an assertion fails, complete the current test_*() function but stop after that. "" or anything else: do not stop (default behaviour). Note that this setting does not prevent the test program from executing other test_*.cb files!

#### Setting classes
You don't really need to know what these different setting classes mean, as they just have some technical differences, but in case if you happen to wonder how certain settings actually work in a detail level, then this information may help.
- **runtime**: These settings are interpreted in the runtime part of cbUnit: in `cbUnit.runtime.cb`, `cbUnit.assert.cb`. If you define *runtime* settings as constants in your `test_*.cb` files, cbUnit uses them naturally (compare to *synthetic* settings).
- **synthetic**: These settings are interpreted in `cbUnit.cb`/`cbUnit.exe` and may exist in your `test_*.cb` files if you have defined them there, but they are not actually used by the compiled final test program. Instead, they are read by `cbUnit.exe` , which then uses them to control how it will build/compile/execute the final test program. E.g. `CBUNIT_COMMANDLINE` might be a constant in your `test_*.cb` file, but by the time your test program is executed, it would be too late to read the expected commandline value from that constant, as CoolBasic has already set the value of `CommandLine()` from the real commandline of the program. And as `cbUnit.exe` is in this case the executor of the program, it has submitted the value of `CBUNIT_COMMANDLINE` for CoolBasic to pick up.

### Application's global settings
These do not exist yet.

## Contributing
Ideas, bug repots, pull requests: all welcome! :) [Just raise an issue in GitHub](https://github.com/Taitava/cbUnit/issues)

## Author
This library is created by Jarkko Linnanvirta. Contact me:
 - [in GitHub](https://github.com/Taitava)
 - via email: j -at- jare -dot- fi