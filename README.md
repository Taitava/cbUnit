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

## Creating `test_*.cb` files
Say that you have your `MyApplication` divided into multiple source code files, and you want to write some tests for each one of them. A good practice is to create one test file per one application source code file. You could have e.g.:
- `MyApplication\MainProgram.cb` and `MyApplication\tests\test_MainProgram.cb`
- `MyApplication\LibraryFunctions.cb` and `MyApplication\tests\test_LibraryFunctions.cb`

However, cbUnit does not force you to use any strict pattern to link your source code and test files together. The only rules for your test files are:
- Test files must be located in `tests` folder (no case-sensitivity).
- Test files' names need to start with `test_` and end with `.cb` (no case-sensitivity). A good practice is to include the related source code file's name in the test file's name, like in the examples above.

cbUnit *does* read your test files, but it *never* reads your application's source code files. And it never includes them for you, so in each of your `test_*.cb` file, you will need to `Include` the application source code file(s) that you want to test in that particular test file. cbUnit *does* include its own utility functions for you, so you don't need to include anything related to cbUnit in your `test_*.cb` files. You can just directly use [all the *assert* functions provided by cbUnit](https://github.com/Taitava/cbUnit/blob/master/cbUnit.asserts.cb).

### Content of a `test_*.cb` file
cbUnit assumes that each of your `test_*.cb` file contains functions and does not do anything outside of them. Of course you can use includes and define variables etc. outside of functions like you normally do. But code logic is *encouraged* to be written in functions. There is no strict rule for this, as cbUnit does not guard this in any way, but it can better report *assertion failures* if you use functions.

Functions in a `test_*.cb` file have the following rules:
- If a function is named `test_*()` (e.g.: `Function test_LoadGraphics()`), cbUnit will call it automatically. You do not need to call them at any point!
- `test_*()` functions do not use any parameters at the moment.
- If a function does not have the `test_` prefix, cbUnit will not call it. You can have this kind of functions in your test files freely, and you call them yourself just like you would expect.

Each function should contain *assertation tests*:
 - Your function should call one or more of `Assert*()` functions. Each one of them checks if the condition you gave them *is true*. E.g. `AssertBeginsWith("Hello World!", "Hello")` succeeds, but `AssertBeginsWith("Hello World!", "Hi")` fails and writes a report of the failure. Failures may also prevent further assertation tests from being run, depending on [your settings](#Settings).
 - You can find [all possible *assert* functions here](https://github.com/Taitava/cbUnit/blob/master/cbUnit.asserts.cb)
 - Each assert function has it's own set of parameters, but all of them follow a general principle: the parameters start with one or more test condition operands (some might be optional), and the last parameter is always an optional message that will be included in the test report *if* the assertation fails. (If you do not specify a message, each assert function has their own, generic purpose default message, which should be descriptive enough for most cases.)
 - If you cannot find a specific assert function tailored for your particular test condition, you can always use the base `Assert(condition, message$="Assertion condition is false.")` assert function. The first parameter is your condition as a simple `True` or `False` value (whether it succeeded or not). A downside to this function is that its default failure message is very ambiguous, so it's recommended that you write a more detailed one.

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