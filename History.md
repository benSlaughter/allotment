# History
## Planned Versions
### Version 1.1.0
#### Minor: Simplify, improve, clean
 * Rescue within an event to ensure that the timing is stopped in the event of a failure - *completed*
 * Remove old hooks and add new block management - *completed*
 * Remove and old or unrequired code - *completed*
 * Readme completed with hooks, stopwatches and now functionality - *completed*
 * 100% coverage rspec tests - *completed* (so far)
 * Complete commenting of code - *completed*
 * Improved method naming - *completed*

### Version 1.0.4
#### Patch: Added before and after hooks
 * Added before and after hooks
 * Created hooks rspec tests
 * Had to change allotment into class for hooks
 * Split instance methods into seprate file
 * Created release notes

### Version 1.0.3
#### Patch: Updated and added files
 * Updated Gemfile
 * Updated gemspec
 * Added Version
 * Added Licence

### Version 1.0.2
#### Patch: Results returned as Hashie::Mash
 * results methods now return results as a Hashie::Mash

### Version 1.0.1
#### Patch: Added instance methods
 * Added instance methods so that the module can be included into a class and allotment does not need to be called every time.
 * Cleaned up stopwatch so that it had lap and split

## Released Versions
### Version 1.0.0
#### Major: Inital release version.
 * Allotment has the ablility to record blocks and procs, and to record from two separate points within the code.
 * Stopwatch has been completed and can start, stop, split, lap and restart.
 * There is an extention of Array for an average.
 * There is Cucumber support, a cucumber file has been included that will record scenario and test time.
