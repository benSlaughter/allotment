---
layout: index
---


## "Time is what we want most, but what we use worst."

[![Code Climate](https://codeclimate.com/github/benSlaughter/allotment.png)](https://codeclimate.com/github/benSlaughter/allotment)
[![Build Status](https://travis-ci.org/benSlaughter/allotment.png?branch=master)](https://travis-ci.org/benSlaughter/allotment)
[![Dependency Status](https://gemnasium.com/benSlaughter/allotment.png)](https://gemnasium.com/benSlaughter/allotment)
[![Coverage Status](https://coveralls.io/repos/benSlaughter/allotment/badge.png?branch=master)](https://coveralls.io/r/benSlaughter/allotment)
[![Gem Version](https://badge.fury.io/rb/allotment.png)](http://badge.fury.io/rb/allotment)

Allotment is a performance time recording gem.
It makes recording performance simple, while still being powerful and flexible.

Allotment gives you the ability to record the performance of code with ease, and all the while it will store all your results as your code runs.
Results can be acessed at any time from anywhere.
Recordings are grouped together under their name and an average of the results can be caluculated easily.
No threads where harmed in the making of this gem, no threads are used, and this makes Allotment lightweight and simple.

### Cucumber

Allotment also plays well with cucumber.

A before and after hook records each scenarios completion time.

_See [Cucumber](#using-allotment-with-cucumber)_

### Limitations

* Allotment cannot run two simultaneous recordings of the same name at the same time.
* Allotment has only one set of results and cannot record to diferent results. (e.g. performance and load)

## Setup

Allotment has been tested with Ruby 1.9.2 and later.
To install:

```bash
gem install allotment
```

## Using Allotment with Cucumber

If you are using Cucumber you can record each scenario.
Add this line into your env.rb file:

```ruby
require 'allotment/cucumber'
```

## Using Allotment

Require Allotment at the start of your code

```ruby
require 'allotment'
```

### Recording a Block
Recording a block of code could not be simpler.

```ruby
Allotment.record('my_recording') { # code here }
```
```ruby
Allotment.record('my_recording') do
  # code here
end
```

When an event has been completed the performance timing is returned by the method.

```ruby
performance = Allotment.record { # code here }
```
```ruby
performance = Allotment.record do
  # code here
end
```

### Record point to point

Sometime you may want to record performance of more than just a block.
Allotment can do that too.

```ruby
Allotment.start 'my_recording'
# code here
Allotment.stop 'my_recording'
```

When stop is called the performance timing is returned by the method.

```ruby
performance = Allotment.stop 'my_recording'
```

When start recording is called the timing stopwatch is returned by the method.

```ruby
stopwatch = Allotment.start 'my_recording'
```

_More on [stopwatches](#allotment-stopwatches)_

**Warning!** If a recording name does not exists, then a NameError is raised.

### Hooks

Allotment has two inbuilt hooks, on_start, and on_stop.
Each hook contains a single proc that is called at points within recordings.

The on_start hook is called before the timer is started.
The on_stop hook is called after the timer is stopped.

A hook can be redefined at any time.
To define a hook call the hook and pass in a proc.

```ruby
Allotment.on_start { # Extra code here }
```
```ruby
Allotment.on_start do
  # Extra code here
end
```

### Accessing performance results

Allotment stores all the performance recordings as and when they happen.
If multiple recording of the same event exist they are stored in an array.
Allotment also patches Array with an average function.

```ruby
hash = Allotment.results
```
```ruby
array = Allotment.results["my_recording"]
```
```ruby
result = Allotment.results["my_recording"].first
```
```ruby
result = Allotment.results["my_recording"].average
```

## Allotment Stopwatches

Stopwatches are what Allotment uses to keep track of time.
Strangely enough they act just like a stopwatch.

### Basic usage

Stopwatches live inside the Allotment module.
When created, a stopwatch is not running, however the start method returns the stopwatch, and so can be called inline.

```ruby
sw = Allotment::Stopwatch.new
```
```ruby
sw = Allotment::Stopwatch.new.start
```

When stopping a stopwatch, the time that is currently on the stopwatch is returned

```ruby
time = sw.stop
```

Reset will wipe all times clean, and completely reset the time.
Reset can be called at any time.

```ruby
sw.reset
```

### Advanced usage

A stopwatch has the ability to lap, spit, and view the current time.
Each method behaves in a slightly different way.
 * Lap is the time elapsed from the last time a lap was called.
 * Split is the time from the last time the stopwatch was started.
 * Time is the total time from when the stopwatch was first started.

When the stop watch is run and the methods are called.
```
      30 seconds
      start                    end
      |--------------------------|
Lap   |---10---|---10---|---10---|
Split |---10---|---20---|---30---|
Time  |---10---|---20---|---30---|
```

When the stopwatch is stopped and the methods are called.
```
      30 seconds with 10 second stop
      start
Lap   |---10---|        |---10---|
Split |---10---|        |---10---|
Time  |---10---|        |---20---|
```

## Notes

Stopwatches use ruby Time to calculate the time between a start and a stop.
Allotment rspec tests need to be improved upon.
