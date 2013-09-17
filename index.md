---
layout: index
---


# Allotment

[![Code Climate](https://codeclimate.com/github/benSlaughter/allotment.png)](https://codeclimate.com/github/benSlaughter/allotment)
[![Build Status](https://travis-ci.org/benSlaughter/allotment.png?branch=master)](https://travis-ci.org/benSlaughter/allotment)
[![Dependency Status](https://gemnasium.com/benSlaughter/allotment.png)](https://gemnasium.com/benSlaughter/allotment)
[![Coverage Status](https://coveralls.io/repos/benSlaughter/allotment/badge.png?branch=master)](https://coveralls.io/r/benSlaughter/allotment)
[![Gem Version](https://badge.fury.io/rb/allotment.png)](http://badge.fury.io/rb/allotment)

Allotment is a performance rubygem that records and stores the performance timing of running a block of code,
or from a from a chosen point, until a task or action is complete.

Each performance recording is stored with a recording name,
each following recording is added so that multiple recordings can be queried and assesed.

Allotment also stores all the results so that they can be easily accessed at any time.

## Setup

Allotment has been tested with Ruby 1.9.2 and later.
To install, type:

```bash
gem install allotment
```

## Using Allotment with Cucumber

If you are using Cucumber you can record each scenario, and report the results to the console, add this line into your env.rb file:

```ruby
require 'allotment/cucumber'
```

## Using Allotment

Allotments main features are: the ability to record performance of ruby blocks; and record from point to point.

Require Allotment at the start of your code:

```ruby
require 'allotment'
```

### Recording a Block

The basic way of recording a block is as follows:

```ruby
Allotment.record('my_recording') { # code here }
```
```ruby
Allotment.record('my_recording') do
  # code here
end
```

When an event has been completed the performance timing is returned by the method:

```ruby
performance = Allotment.record { # code here }
```
```ruby
performance = Allotment.record do
  # code here
end
```

### Record point to point:

The basic way of recording point to point is as follows:

```ruby
require 'allotment'

Allotment.start 'my_recording'
# code here
Allotment.stop 'my_recording'
```

When stop recording is called the performance timing is returned by the method:

```ruby
performance = Allotment.stop 'my_recording'
```

When start recording is called the timing stopwatch is returned by the method:

```ruby
stopwatch = Allotment.start 'my_recording'
```

_More on [stopwatches](#allotment-stopwatches)_

If a recording name does not exists, then a NameError shall be raised.

### Accessing performance results

Performance recordings are stored within a hash. The reperformance results are logged to an array under the recording name.
They can be access from Allotment at any time:

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

### Allotment Stopwatches

TODO

