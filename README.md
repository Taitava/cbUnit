# cbUnit
Unit tests for CoolBasic.

- Unit testing is a method for testing parts of an application one by one, separately from other parts. [More about unit testing in Wikipedia](https://en.wikipedia.org/wiki/Unit_testing)
- CoolBasic is an easy to learn game/application programming language for Windows. [More in CoolBasic.com](https://coolbasic.com)

The documentation is still under construction.



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