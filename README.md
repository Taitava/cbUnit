# cbUnit
Unit tests for CoolBasic.

The documentation is under construction.

## Settings
### In test_*.cb files

Setting | Possible values | Description 
--------|-----------------|-------------
CBUNIT_COMMANDLINE | (any string) | This string will be available via CommandLine() in your application and test file. cbUnit.exe reads this from your test_*.cb file and uses it when executing that file. That's why it may seem strange how this setting works.
CBUNIT_STOP_AT | "ASSERT", "FUNCTION", "" | Defines how failures are tolerated. ASSERT: Prevent further test immediately when an assertation fails. FUNCTION: When an assertation fails, complete the current test_*() function but stop after that. "" or anything else: do not stop (default behaviour). Note that this setting does not prevent the test program from executing other test_*.cb files!

### Application's global settings
These do not exist yet.